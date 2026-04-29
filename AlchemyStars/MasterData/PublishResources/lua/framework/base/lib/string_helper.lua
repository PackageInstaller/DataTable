local toint = math.tointeger

function string.lead(s, prefix)
  return string.find(s, "^" .. prefix) and true or false
end

function string.endwith(s, prefix)
  return string.find(s, prefix .. "$") and true or false
end

function string.startwith(s, prefix)
  return string.find(s, "^" .. prefix) and true or false
end

function string.MD5(s)
  return string.upper(s:md5())
end

function string.tohex(c)
  local i = string.byte(c)
  return string.format("%%%X", i)
end

function string.diff(s1, s2)
  local len1, len2 = string.len(s1), string.len(s2)
  local b, e1, e2 = 0, len1, len2
  local len = math.min(len1, len2)
  for ii = 1, len do
    if string.sub(s1, ii, ii) ~= string.sub(s2, ii, ii) then
      break
    end
    b = ii
  end
  for ii = 1, len do
    if string.sub(s1, e1, e1) ~= string.sub(s2, e2, e2) then
      break
    end
    e2 = len2 - ii
    e1 = len1 - ii
  end
  return b, e1, e2
end

function string.split(s, delimiter)
  if nil == s or "" == s then
    return {}
  end
  local t, i, j, k = {}, 1, 1, 1
  while i <= #s + 1 do
    j, k = s:find(delimiter, i)
    j, k = j or #s + 1, k or #s + 1
    t[#t + 1] = s:sub(i, j - 1)
    i = k + 1
  end
  return t
end

function string.uchar(u)
  if u <= 127 then
    return string.char(u)
  end
  if u <= 2047 then
    return string.char(192 + toint(u / 64), 128 + u % 64)
  end
  return string.char(224 + toint(u / 4096), 128 + toint(u / 64 % 64), 128 + u % 64)
end

function string.trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function string.ip2string(ip)
  local s = string.format("%08x", ip)
  local h1 = toint("0x" .. string.sub(s, 1, 2))
  local h2 = toint("0x" .. string.sub(s, 3, 4))
  local l1 = toint("0x" .. string.sub(s, 5, 6))
  local l2 = toint("0x" .. string.sub(s, 7, 8))
  return string.format("%s.%s.%s.%s", h1, h2, l1, l2)
end

function string.isnullorempty(s)
  return s == nil or string.len(s) == 0
end

function string.nocase(s)
  s = string.gsub(s, "%a", function(c)
    return string.format("[%s%s]", string.lower(c), string.upper(c))
  end)
  return s
end

function string.equal_with_ignorecase(s1, s2)
  return string.lower(s1) == string.lower(s2)
end

function string.trimend(s, suffix)
  if not suffix then
    return s
  end
  local length = #suffix
  if length == 0 then
    return s
  elseif length == 1 then
    local index = string.find(s, "[" .. suffix .. "]+" .. "$")
    if index then
      return string.sub(s, 0, index - 1)
    end
    return s
  else
    local index
    local res = s
    repeat
      index = string.find(res, suffix .. "$")
      if index then
        res = string.sub(res, 0, index - 1)
      end
    until index == nil
    return res
  end
end

function string.args2str(args, split)
  local len = table.maxn(args)
  if len == 0 then
    return ""
  elseif len == 1 then
    return tostring(args[1])
  else
    local tb = {}
    if split == nil then
      for i = 1, len do
        table.insert(tb, tostring(args[i]))
      end
    else
      table.insert(tb, tostring(args[1]))
      for i = 2, len do
        table.insert(tb, split)
        table.insert(tb, tostring(args[i]))
      end
    end
    return table.concat(tb)
  end
end
