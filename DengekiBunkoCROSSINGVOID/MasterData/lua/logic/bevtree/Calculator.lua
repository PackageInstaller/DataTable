local Stack = require("Logic/BevTree/Stack")
local BevData = require("Logic/BevTree/BevData")
local Calculator = {}

function Calculator.isWordStartChar(ch)
  local lowerAlphabet = ch >= string.byte("a") and ch <= string.byte("z")
  local upperAlphabet = ch >= string.byte("A") and ch <= string.byte("Z")
  local special = ch == string.byte("_")
  return lowerAlphabet or upperAlphabet or special
end

function Calculator.isWordChar(ch)
  local lowerAlphabet = ch >= string.byte("a") and ch <= string.byte("z")
  local upperAlphabet = ch >= string.byte("A") and ch <= string.byte("Z")
  local special = ch == string.byte("_")
  local number = ch >= string.byte("0") and ch <= string.byte("9")
  return lowerAlphabet or upperAlphabet or special or number
end

function Calculator.isNumber(ch)
  local number = ch >= string.byte("0") and ch <= string.byte("9")
  local dot = ch == string.byte(".")
  return number or dot
end

function Calculator.isOperator(ch)
  local leftBracket = ch == string.byte("(")
  local rightBracket = ch == string.byte(")")
  local add = ch == string.byte("+")
  local minus = ch == string.byte("-")
  local divide = ch == string.byte("/")
  local multiply = ch == string.byte("*")
  return leftBracket or rightBracket or add or minus or divide or multiply
end

function Calculator.getOperatorPriority(word)
  local add = word == "+"
  local minus = word == "-"
  local divide = word == "/"
  local multiply = word == "*"
  if add or minus then
    return 2
  elseif divide or multiply then
    return 3
  end
  return 1
end

function Calculator.isVarName(word)
  return Calculator.isWordStartChar(string.byte(word, 1))
end

function Calculator.isNumberToken(word)
  return Calculator.isNumber(string.byte(word, 1))
end

function Calculator.isLeftBracket(word)
  return word == "("
end

function Calculator.isRightBracket(word)
  return word == ")"
end

function Calculator.isOperatorToken(word)
  local add = word == "+"
  local minus = word == "-"
  local divide = word == "/"
  local multiply = word == "*"
  return add or minus or divide or multiply
end

function Calculator.getTokens(expression)
  local i = 1
  local state = "expecting_new_token"
  local token = ""
  local tokens = {}
  while i <= string.len(expression) do
    local ch = string.byte(expression, i)
    if state == "expecting_new_token" then
      if Calculator.isWordStartChar(ch) then
        token = token .. string.char(ch)
        state = "expecting_var_name_char"
      elseif Calculator.isNumber(ch) then
        token = token .. string.char(ch)
        state = "expecting_number_char"
      elseif Calculator.isOperator(ch) then
        token = string.char(ch)
        tokens[#tokens + 1] = token
        token = ""
        state = "expecting_new_token"
      end
      i = i + 1
    elseif state == "expecting_var_name_char" then
      if Calculator.isWordChar(ch) then
        token = token .. string.char(ch)
        i = i + 1
      else
        tokens[#tokens + 1] = token
        token = ""
        state = "expecting_new_token"
      end
    elseif state == "expecting_number_char" then
      if Calculator.isNumber(ch) then
        token = token .. string.char(ch)
        i = i + 1
      else
        tokens[#tokens + 1] = token
        token = ""
        state = "expecting_new_token"
      end
    end
  end
  if string.len(token) > 0 then
    tokens[#tokens + 1] = token
  end
  return tokens
end

function Calculator.getNpr(tokens)
  local stack = Stack.new()
  local nprTokens = {}
  for i = 1, #tokens do
    local token = tokens[i]
    if Calculator.isNumberToken(token) or Calculator.isVarName(token) then
      nprTokens[#nprTokens + 1] = token
    elseif Calculator.isLeftBracket(token) then
      stack:push(token)
    elseif Calculator.isOperatorToken(token) then
      while Calculator.getOperatorPriority(token) <= Calculator.getOperatorPriority(stack:top()) do
        nprTokens[#nprTokens + 1] = stack:pop()
      end
      stack:push(token)
    elseif Calculator.isRightBracket(token) then
      while not Calculator.isLeftBracket(stack:top()) do
        nprTokens[#nprTokens + 1] = stack:pop()
      end
      stack:pop()
    end
  end
  while not stack:empty() do
    nprTokens[#nprTokens + 1] = stack:pop()
  end
  return nprTokens
end

function Calculator.eval(varname)
  if type(varname) == "number" then
    return varname
  end
  local vars = BevData.instance.vars[BevData.instance.currentTeam]
  if varname:match("%D") == nil then
    return tonumber(varname)
  else
    if vars[varname] ~= nil then
      if type(vars[varname]) == "number" then
        return vars[varname]
      elseif vars[varname]:match("%D") == nil then
        return tonumber(vars[varname])
      else
        return Calculator.calc(vars[varname])
      end
    end
    return 0
  end
end

function Calculator.calcTwoOperands(lhs, rhs, op)
  local lval = Calculator.eval(lhs)
  local rval = Calculator.eval(rhs)
  if op == "+" then
    return lval + rval
  elseif op == "-" then
    return lval - rval
  elseif op == "*" then
    return lval * rval
  elseif op == "/" then
    return lval / rval
  end
  return 0
end

function Calculator.calc(expression)
  local tokens = Calculator.getTokens(expression)
  local nprTokens = Calculator.getNpr(tokens)
  local stack = Stack.new()
  for i = 1, #nprTokens do
    local token = nprTokens[i]
    if Calculator.isNumberToken(token) or Calculator.isVarName(token) then
      stack:push(token)
    elseif Calculator.isOperatorToken(token) then
      local operandR = stack:pop()
      local operandL = stack:pop()
      local result = Calculator.calcTwoOperands(operandL, operandR, token)
      stack:push(result)
    end
  end
  if not stack:empty() then
    if Calculator.isVarName(stack:top()) then
      local ret = Calculator.eval(stack:top())
      return ret
    else
      local ret = stack:top()
      return ret
    end
  end
  return 0
end

return Calculator
