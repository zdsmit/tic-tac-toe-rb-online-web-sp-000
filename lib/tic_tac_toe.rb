board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [0, 4, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  (user_input.to_i) - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  index
  if valid_move?(board, index) && !position_taken?(board, index)
    move(board, index, value = "X")
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  puts counter
  return counter
end

def current_player(board)
  if (turn_count(board)) % 2 == 0
    return "X"
    puts "X"
  else
    return "O"
    puts "O"
  end
end

def won?(board)
   WIN_COMBINATIONS.detect do |combination|
     if (board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X") ||
        (board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O")
        return combination
     end
   end
end

def full?(board)
  board.all? do|position|
    if position == "X" || position == "O"
       true
    end
  end
end

def draw?(board)
  if full?(board) && !won?(board)
     true
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  end
end

def winner(board)
  WIN_COMBINATIONS.detect do |combination|
    if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
      return "X"
    elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
      return "O"
    elsif draw?(board)
     return "nil"
    end
  end
end

def play(board)
  gets
  until over?(board)
    display_board(board)
    current_player(board)
    turn(board)
    if over?(board) && won?(board)
      if winner(board) == "X"
        return "Congratulations X!"
      elsif winner?(board) == "O"
        return "Congratulations O!"
      elsif over?(board) && draw(board)
        return "Cat's Game!"
      end
    end
  end
end
