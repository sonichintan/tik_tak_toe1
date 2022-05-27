import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}


// shghs
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-',];

  var Winner = '';
  var currentplayer = 'X';

  void drawxo(i){
    if(grid[i]=='-'){
      setState(() {
        grid[i]=currentplayer;
        currentplayer = currentplayer == 'X'?'O':'X';
      });
      findWinner(grid[i]);
    }
  }

  bool checkMove(i1,i2,i3,sign){
    if(grid[i1]==sign && grid[i2] == sign && grid[i3] == sign){
      return true;
    }
    return false;
  }

  void findWinner(currentsign){
    if(checkMove(0,1,2,currentsign)|| checkMove(3,4,5,currentsign) || checkMove(6,7,8,currentsign) ||
        checkMove(0,3,6,currentsign)|| checkMove(1,4,7,currentsign) || checkMove(2,5,8,currentsign) ||
        checkMove(0,4,8,currentsign)|| checkMove(2,4,6,currentsign)){
      setState(() {
        Winner = currentsign;
      });
    }
  }

  void reset(){
    setState(() {
      Winner = "";
      grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-',];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tik Tak Toe"),
        backgroundColor: Colors.transparent,
      ),
      body:Center(
        child: Column(
          children: [
            if(Winner!="") Text("$Winner WON THE GAME",style: TextStyle(fontSize: 30),),
            Container(
              constraints: BoxConstraints(maxHeight: 400,maxWidth: 400),
              margin: EdgeInsets.all(20),
              color: Colors.black,
              child: GridView.builder( shrinkWrap:true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10),
                itemCount: grid.length,
                itemBuilder: (context,index)=> Material(
                  color: Colors.amber,
                  child: InkWell(
                      splashColor: Colors.red,
                      onTap: ()=>drawxo(index),
                      child: Center(child: Text(grid[index],style: TextStyle(fontSize: 50),))),
                ),),
            ),
            ElevatedButton.icon(onPressed: reset, icon: Icon(Icons.refresh),label: Text("Play Again"))
          ],
        ),
      ),
    );
  }
}


