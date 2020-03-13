import de.bezier.guido.*;
private int NUM_ROWS = 10;
private int NUM_COLS = 10;
private int num_mines = 3;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS; r++)
    {
        for(int c = 0; c<NUM_COLS; c++)
            buttons[r][c]= new MSButton(r,c);
    }
    
    
    setMines();
}
public void setMines()
{
    
    // for(int r = 0; r < buttons.length; r++)
    //     for(int c=0; c<buttons[r].length; c++)
   

    for(int i =0; i<num_mines; i++)
    {

        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);


        if(!mines.contains(buttons[row][col]))
        {   mines.add(buttons[row][col]);
            System.out.println(row + "," + col);

        }
    }

}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
   for(int r=0; r<NUM_ROWS; r++)
   {
    for(int c=0; c<NUM_COLS; c++)
        {
            if(mines.contains(buttons[r][c]) && buttons[r][c].flagged==false)    
            return false;
        }
    }
return true;
}
public void displayLosingMessage()
{
    
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel("U");

    buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("L");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+3].setLabel("S");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+4].setLabel("E");




}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("Y");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("O");
    buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel("U");

    buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("W");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("I");
    buttons[NUM_ROWS/2][(NUM_COLS/2)+3].setLabel("N");

}
public boolean isValid(int r, int c)
{
    if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
        return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;

    if(isValid(row-1,col-1)==true && mines.contains(buttons[row-1][col-1]))
    numMines = numMines + 1; 
  
    if(isValid(row-1,col+1)==true && mines.contains(buttons[row-1][col+1]))
    numMines = numMines + 1; 
  
    if(isValid(row-1,col)==true && mines.contains(buttons[row-1][col]))
    numMines = numMines + 1;  
  
    if(isValid(row+1,col+1)==true && mines.contains(buttons[row+1][col+1]))
    numMines = numMines + 1; 
  
    if(isValid(row+1,col-1)==true && mines.contains(buttons[row+1][col-1]))
    numMines = numMines + 1; 
  
    if(isValid(row+1,col)==true && mines.contains(buttons[row+1][col]))
    numMines = numMines + 1; 
  
    if(isValid(row,col-1)==true && mines.contains(buttons[row][col-1]))
    numMines = numMines + 1;  
  
    if(isValid(row,col+1)==true && mines.contains(buttons[row][col+1]))
    numMines = numMines + 1; 
  
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        
        if(mouseButton == RIGHT)
        {
            flagged =!flagged;
        
        

        if(flagged==false)
            clicked=false;
     }
        else if(mines.contains(this))
             displayLosingMessage();


        else if(countMines(myRow,myCol)>0)
           buttons[myRow][myCol].setLabel(countMines(myRow,myCol));
            

        else
        {
            if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked==false)
                buttons[myRow-1][myCol-1].mousePressed();

            if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked==false)
                 buttons[myRow-1][myCol+1].mousePressed();

            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked==false)
                buttons[myRow-1][myCol].mousePressed();

            if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked==false)
                buttons[myRow+1][myCol+1].mousePressed();
   
            if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked==false)
                buttons[myRow+1][myCol-1].mousePressed();
    
  
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked==false)
                buttons[myRow+1][myCol].mousePressed();
    
  
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked==false)
                buttons[myRow][myCol-1].mousePressed();
    
  
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked==false)
                buttons[myRow][myCol+1].mousePressed();
   
        } 
            


    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
