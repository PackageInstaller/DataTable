local TeamShareUtils = {}
local CodeStr = "abcdefghijklmnopqrstuvwABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
local CodeStrTable = {}
for i = 1, #CodeStr do
  CodeStrTable[i] = string.sub(CodeStr, i, i)
end
local CodeIndexTable = {}
for i = 1, #CodeStr do
  CodeIndexTable[CodeStrTable[i]] = i
end
local CodeStrLen = #CodeStr
local MultipleStrTable = {
  "x",
  "y",
  "z",
  "#",
  "&",
  "+",
  "*",
  "!",
  "$",
  "%",
  "^",
  "&",
  "*",
  "("
}

function TeamShareUtils.NumberToCode(number)
  number = number + 1
  local code
  if number <= CodeStrLen then
    code = CodeStrTable[number]
  else
    local a = math.floor(number / CodeStrLen)
    local b = number % CodeStrLen + 1
    assert(a <= #MultipleStrTable, "MultipleStrTable index out of range " .. a)
    code = MultipleStrTable[a] .. CodeStrTable[b]
  end
  return code
end

function TeamShareUtils.CodeToNumber(code)
  local number = 0
  if 1 == #code then
    number = CodeIndexTable[code]
  elseif 2 == #code then
    local firstChar = string.sub(code, 1, 1)
    local secondChar = string.sub(code, 2, 2)
    local multiple = table.indexof(MultipleStrTable, firstChar)
    if multiple then
      number = CodeIndexTable[secondChar] - 1 + multiple * CodeStrLen
    else
      Logger.Error("-----------数字不正确 MultipleStrTable 没有索引" .. firstChar)
    end
  else
    Logger.Error("-----------最多支持两位字符串编码" .. code)
  end
  print("-------------code CodeToNumber", code, number)
  return number - 1
end

function TeamShareUtils.IsValidCode(code)
  return table.indexof(MultipleStrTable, code) or table.indexof(CodeStrTable, code)
end

function TeamShareUtils.IsMultipleCode(code)
  do return table.indexof, MultipleStrTable end
  return table.indexof, MultipleStrTable, code
end

function TeamShareUtils.Test()
  for i = 0, 500 do
    local code = TeamShareUtils.NumberToCode(i)
    local number = TeamShareUtils.CodeToNumber(code)
    print(string.format("test source %s encode %s decode %s", i, code, number))
    assert(number == i, string.format("test source error %s encode %s decode %s", i, code, number))
  end
end

return TeamShareUtils
