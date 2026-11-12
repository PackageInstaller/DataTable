local tableconcat = table.concat
local stringformat = string.format
local StringBuilder = {}

function StringBuilder:new(sep)
  local object = {}
  setmetatable(object, self)
  self.__index = self
  object.sep = sep
  object.buffer = {}
  return object
end

function StringBuilder:Append(str)
  self.buffer[#self.buffer + 1] = str
end

function StringBuilder:AppendFormat(format, ...)
  self:Append(stringformat(format, ...))
end

function StringBuilder:AppendLine(str)
  self:Append(str)
  self:Append("\r\n")
end

function StringBuilder:ToString()
  return tableconcat(self.buffer, self.sep)
end

function StringBuilder:Clear()
  local count = #self.buffer
  for i = 1, count do
    self.buffer[i] = nil
  end
end

local function __printTable(tb, sb, name, aPreText, bLast)
  if tb == nil then
    return
  end
  if bLast == nil then
    bLast = false
  end
  name = name or ""
  local preText = aPreText or ""
  local subPreText = ""
  if aPreText == nil then
    sb:AppendLine("[ROOT]")
  else
    if bLast then
      subPreText = preText .. "    "
    else
      subPreText = preText .. "│  "
    end
    if type(tb) == "table" then
      if bLast then
        sb:AppendLine(string.format("%s└─[%s]", preText, name))
      else
        sb:AppendLine(string.format("%s├─[%s]", preText, name))
      end
    elseif bLast then
      sb:AppendLine(string.format("%s└─%s= %s", preText, name, tostring(tb)))
    else
      sb:AppendLine(string.format("%s├─%s= %s", preText, name, tostring(tb)))
    end
  end
  if type(tb) == "table" then
    local counter = 0
    local count = 0
    for _, _ in pairs(tb) do
      count = count + 1
    end
    for key, obj in pairs(tb) do
      counter = counter + 1
      __printTable(obj, sb, key, subPreText, counter == count)
    end
  end
  if bLast then
    sb:AppendLine(preText)
  end
end

function PrintTable(tb, filename)
  local sb = StringBuilder:new()
  __printTable(tb, sb)
  local str = sb:ToString()
  if filename then
    local f = io.open(filename, "w")
    if f ~= nil then
      f:write(str)
      f:close()
    end
  else
    print(str)
  end
end
