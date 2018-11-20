pragma solidity ^0.4.15;

contract RockPaperScicorrs {

    // A string that maps to a string that maps to a int
    mapping(string => mapping(string => int)) payoffMatrix;

    address player1;
    address player2;

    // State variables for players choice or rock, paper or scissors
    string public player1Choice;
    string public player2Choice;

    // Just to prevent a player registering twice
    modifier notRegisteredYet()
    {
        if (msg.sender==player1 || msg.sender==player2) {
            revert();
        }
        else
            _;
    }

    // To ensure that a certain amount of ether is sent with the transaction
    modifier sentEnoughEther(uint amount)
    {
        if (msg.value<amount) {
            revert();
        }
        else
            _;
    }

    // construction function

    function RockPaperScissors() {
        payoffMatrix["rock"]["rock"] = 0;
        payoffMatrix["rock"]["paper"] = 2;
        payoffMatrix["rock"]["scissors"] = 1;
        payoffMatrix["paper"]["rock"] = 1;
        payoffMatrix["paper"]["paper"] = 0;
        payoffMatrix["paper"]["scissors"] = 2;
        payoffMatrix["scissors"]["rock"] = 2;
        payoffMatrix["scissors"]["paper"] = 1;
        payoffMatrix["scissors"]["scissors"] = 0;
    }

    function play(string choice) returns (int w) {
        if (msg.sender == player1) {
            player1Choice = choice;
        }
        else if (msg.sender == player2) {
            player2Choice = choice;
        }
        if (bytes(player1Choice).length!=0 && bytes(player2Choice).length!=0) {
            int winner = payoffMatrix[player1Choice][player2Choice];
            if (winner == 1)
                player1.transfer(this.balance);
            else if (winner == 2)
                player2.transfer(this.balance);
            else {
                player1.transfer(this.balance/2);
                player2.transfer(this.balance);
            }
        }
        else
            return -1;
    }

    // Getter Functions - only used to get values from the smart contracts, not used for the active game play

}