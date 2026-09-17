string.empty = ""

function string.isEmpty(s)
  return s == nil or s == string.empty
end

function string.ltrim(input)
  return string.gsub(input, "^[ \t\n\r]+", "")
end

function string.rtrim(input)
  return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trim(input)
  input = string.gsub(input, "^[ \t\n\r]+", "")
  return string.gsub(input, "[ \t\n\r]+$", "")
end

function string.trimChar(input, char)
  input = string.gsub(input, string.format("^[%s]+", char), "")
  return string.gsub(input, string.format("[%s]+$", char), "")
end

function string.split(input, delimiter)
  input = tostring(input)
  delimiter = tostring(delimiter)
  if delimiter == "" then
    return false
  end
  local pos, arr = 0, {}
  for st, sp in function()
    return string.find(input, delimiter, pos, true)
  end, nil, nil do
    table.insert(arr, string.sub(input, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(input, pos))
  return arr
end

function string.toVector3(str, flag)
  local pos = string.split(str, flag or ",")
  return {
    x = tonumber(pos[1]) or 0,
    y = tonumber(pos[2]) or 0,
    z = tonumber(pos[3]) or 0
  }
end

function string.toTable(str)
  if string.isEmpty(str) then
    return
  end
  return load(str)()
end

function string.concat(...)
  local strTab = {
    ...
  }
  return table.concat(strTab)
end

local function UTF8ByteCount(curByte)
  local byteCount = 1
  if 0 < curByte and curByte <= 127 then
    byteCount = 1
  elseif 192 <= curByte and curByte < 224 then
    byteCount = 2
  elseif 224 <= curByte and curByte < 240 then
    byteCount = 3
  elseif 240 <= curByte and curByte < 248 then
    byteCount = 4
  end
  return byteCount
end

function string.widthSingle(inputstr)
  local lenInByte = #inputstr
  local width = 0
  local i = 1
  while lenInByte >= i do
    local curByte = string.byte(inputstr, i)
    local isFullWidth = 198 <= curByte and curByte < 234
    width = width + (isFullWidth and 2 or 1)
    i = i + UTF8ByteCount(curByte)
  end
  return width
end

function string.subWidthText(inputstr, singleWidth)
  local lenInByte = #inputstr
  local i = 1
  local char
  local width = 0
  while lenInByte >= i do
    local curByte = string.byte(inputstr, i)
    local isFullWidth = 198 <= curByte and curByte < 234
    local tempWidth = width + (isFullWidth and 2 or 1)
    if singleWidth < tempWidth then
      char = string.sub(inputstr, 1, i - 1)
      break
    end
    width = tempWidth
    i = i + UTF8ByteCount(curByte)
  end
  return char or inputstr
end

function string.getTextCount(inputstr)
  local lenInByte = #inputstr
  local count = 0
  local i = 1
  while lenInByte >= i do
    local curByte = string.byte(inputstr, i)
    count = count + 1
    i = i + UTF8ByteCount(curByte)
  end
  return count
end

function string.subCountText(inputstr, startIndex, endIndex)
  local lenInByte = #inputstr
  local count = 0
  local i = 1
  local char
  local startByte = 0
  while lenInByte >= i do
    local curByte = string.byte(inputstr, i)
    count = count + 1
    if startIndex >= count then
      startByte = i
    end
    i = i + UTF8ByteCount(curByte)
    if endIndex <= count then
      char = string.sub(inputstr, startByte, i - 1)
      break
    end
  end
  return char or inputstr
end
