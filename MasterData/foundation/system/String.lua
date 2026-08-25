getmetatable("").__pairs = function(s)
  local i, n = 0, #s
  return function()
    i = i + 1
    if i <= n then
      return i, s:sub(i, i)
    end
  end
end

function string:split(delimiter)
  delimiter = tostring(delimiter)
  assert("" ~= delimiter, "empty separator")
  local pos, arr = 0, {}
  for st, sp in function()
    do return string.find, self, delimiter, pos end
    return string.find, self, delimiter, pos, true
  end, nil, nil, nil do
    table.insert(arr, string.sub(self, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(self, pos))
  return arr
end

function string.join(arr, delimiter)
  if type(arr) == "string" then
    assert(false, "join is a static function")
  end
  delimiter = tostring(delimiter)
  if "" == delimiter then
    return ""
  end
  if #arr < 1 then
    return ""
  end
  local data = tostring(arr[1])
  for i = 2, #arr do
    data = data .. delimiter .. arr[i]
  end
  return data
end

function string:startswith(sub)
  return string.sub(self, 1, #sub) == sub
end

function string:endswith(sub)
  return "" == sub or string.sub(self, -string.len(sub)) == sub
end

function string:contains(sub)
  local find = string.find(self, sub)
  return find and find > 0
end

function string:color(color)
  if not color then
    return self
  end
  do return string.format, "<color=%s>%s</color>", color end
  return string.format, "<color=%s>%s</color>", color, self
end

function string:colorFirstLine(color)
  local arr = string.split(self, "\n")
  if arr[1] then
    arr[1] = string.color(arr[1], color)
  end
  do return string.join, arr end
  return string.join, arr, "\n"
end

function string:islower()
  return self == string.lower(self)
end

function string:isupper()
  return self == string.upper(self)
end

function string:isdigit()
  return string.match(self, "%d+") == self
end

function string:lastindexof(sub)
  local reverseData = string.reverse(self)
  local reverseSub = string.reverse(sub)
  local start = string.find(reverseData, reverseSub, 0, true)
  if start then
    return #self - (start + #sub - 1) + 1
  end
  return nil
end

function string:isempty()
  return nil == self or 0 == #self
end

function string:at(pos)
  do return string.sub, self, pos end
  return string.sub, self, pos, pos
end

function string:tonumber()
  do return tonumber end
  return tonumber, self
end

function string:trim(sub)
  if nil == sub then
    do return string.gsub, self, "^%s*(.-)%s*$" end
    return string.gsub, self, "^%s*(.-)%s*$", "%1"
  end
  do return self:trimleft(sub).trimright, (self:trimleft(sub)) end
  return self:trimleft(sub).trimright, self:trimleft(sub), sub, "%1"
end

function string:trimleft(sub)
  do return string.gsub, self, "^" .. sub end
  return string.gsub, self, "^" .. sub, ""
end

function string:trimright(sub)
  do return string.gsub, self, sub .. "$" end
  return string.gsub, self, sub .. "$", ""
end

function string.replace(s, pattern, repl, plain)
  if not plain then
    do return string.gsub, s, pattern end
    return string.gsub, s, pattern, repl, nil, nil, nil, nil, nil, nil
  end
  local i, j = string.find(s, pattern, 1, true)
  if i and j then
    local ret = {}
    local start = 1
    while i and j do
      table.insert(ret, string.sub(s, start, i - 1))
      table.insert(ret, repl)
      start = j + 1
      i, j = string.find(s, pattern, start, true)
    end
    table.insert(ret, string.sub(s, start))
    do return table.concat end
    return table.concat, ret, string.sub(s, start)
  end
  return s
end

function string:left(n)
  do return string.sub, self, 1 end
  return string.sub, self, 1, n
end

function string:mid(s, n)
  do return string.sub, self, s end
  return string.sub, self, s, s + n - 1
end

function string:right(n)
  do return string.sub, self end
  return string.sub, self, #self - n + 1
end

function string:tableformat(t)
  local formatstring = self
  for k, v in pairs(t) do
    formatstring = string.replace(formatstring, "{" .. k .. "}", v, true)
  end
  return formatstring
end
