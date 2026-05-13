local ipairs = ipairs
local pairs = pairs
local table_insert = table.insert
local table_concat = table.concat
local string_format = string.format
local type = type
local tonumber = tonumber
local next = next

function string.tomap(str, delimiter)
  delimiter = delimiter or " "
  local map = {}
  local array = string.split(string.trim(str), delimiter)
  for _, value in ipairs(array) do
    value = string.split(string.trim(value), "=")
    if #value == 2 then
      map[value[1]] = value[2]
    end
  end
  return map
end

function string.toNumMap(str, delimiter)
  delimiter = delimiter or " "
  local map = {}
  local array = string.split(string.trim(str), delimiter)
  for _, value in ipairs(array) do
    value = string.split(string.trim(value), "=")
    if #value == 2 then
      map[checknumber(value[1])] = checknumber(value[2])
    end
  end
  return map
end

function string.toArray(str, delimiter, toNum)
  delimiter = delimiter or " "
  toNum = toNum or false
  local array = {}
  local tempArray = string.split(string.trim(str), delimiter)
  for _, value in ipairs(tempArray) do
    if string.trim(value) ~= "" then
      if toNum then
        value = checknumber(value)
      end
      table_insert(array, value)
    end
  end
  return array
end

function string.toTableArray(str, delimiter)
  delimiter = delimiter or " "
  local array = {}
  local tempArray = string.split(string.trim(str), delimiter)
  for _, value in ipairs(tempArray) do
    local trimValue = string.trim(value)
    if trimValue ~= "" then
      value = string.split(trimValue, "=")
      table_insert(array, value)
    end
  end
  return array
end

function string.toLineArray(s)
  local ts = {}
  local posa = 1
  while true do
    local pos, chars = s:match("()([\r\n].?)", posa)
    if pos then
      local line = s:sub(posa, pos - 1)
      ts[#ts + 1] = line
      if chars == "\r\n" then
        pos = pos + 1
      end
      posa = pos + 1
    else
      local line = s:sub(posa)
      if line ~= "" then
        ts[#ts + 1] = line
      end
      break
    end
  end
  return ts
end

function string.htmlTag(str, tag)
  local iStart, iEnd = string.find(str, string_format("<%s=", tag))
  local jStart, jEnd = string.find(str, string_format("</%s>", tag))
  local subStr
  if iEnd and jStart then
    subStr = string.sub(str, iEnd + 1, jStart - 1)
  end
  return subStr, iStart, jEnd
end

function string.value(str, index, default, notNum)
  local i, tail = 1
  for k in str:gmatch("[%d.]+") do
    if i == index then
      return notNum and k or tonumber(k)
    end
    i = i + 1
    tail = notNum and k or tonumber(k)
  end
  return default or tail
end

local function iterator(str, start, delimiter)
  start = start or 0
  delimiter = delimiter or " "
  local tail = #str
  return function()
    local s = str:find("=", start, true)
    if not s then
      return
    end
    local e = str:find(delimiter, s, true) or tail + 1
    start = e + 1
    return s, e
  end
end

function string.modify(str, mod, inc, delimiter)
  mod = mod or {}
  delimiter = delimiter or " "
  local s1, s2, t = 1, 1, {}
  for i, j in iterator(str, 0, delimiter) do
    local k = tonumber(str:sub(s1, i - 1))
    if mod[k] then
      if s1 ~= s2 then
        table_insert(t, str:sub(s2, s1 - 2))
      end
      s2 = j + 1
      if type(mod[k]) == "number" then
        if inc then
          local v = tonumber(str:sub(i + 1, j - 1))
          table_insert(t, string_format("%d=%d", k, v + tonumber(mod[k])))
        else
          table_insert(t, string_format("%d=%d", k, tonumber(mod[k])))
        end
      end
      mod[k] = nil
    end
    s1 = j + 1
    if not next(mod) then
      if s1 < #str then
        table_insert(t, str:sub(s1))
      end
      return table_concat(t, delimiter)
    end
  end
  if s1 ~= s2 then
    table_insert(t, str:sub(s2))
  end
  for k, v in pairs(mod) do
    table_insert(t, string_format("%d=%d", k, checknumber(v)))
  end
  return table_concat(t, delimiter)
end

function string.setv(str, k, v, delimiter)
  delimiter = delimiter or " "
  return str:modify({
    [tonumber(k)] = tonumber(v)
  }, false, delimiter)
end

function string.msetv(str, vs, delimiter)
  delimiter = delimiter or " "
  if not next(vs) then
    return str
  end
  return str:modify(vs, false, delimiter)
end

function string.incrv(str, k, delta, delimiter)
  delimiter = delimiter or " "
  return str:modify({
    [tonumber(k)] = tonumber(delta)
  }, true, delimiter)
end

function string.mincrv(str, ds, delimiter)
  delimiter = delimiter or " "
  if not next(ds) then
    return str
  end
  return str:modify(ds, true, delimiter)
end

function string.delk(str, k, delimiter)
  delimiter = delimiter or " "
  return str:modify({
    [tonumber(k)] = ""
  }, false, delimiter)
end

function string.mdelk(str, ks, delimiter)
  delimiter = delimiter or " "
  local mod = {}
  for _, k in ipairs(ks) do
    mod[k] = ""
  end
  return str:modify(mod, false, delimiter)
end

function string.getv(str, k, default, delimiter)
  delimiter = delimiter or " "
  local s1 = 1
  for i, j in iterator(str, 0, delimiter) do
    if tonumber(str:sub(s1, i - 1)) == k then
      return tonumber(str:sub(i + 1, j - 1))
    end
    s1 = j + 1
  end
  return default
end

local function iter_dk(str, start, delimiter)
  start = start or 0
  delimiter = delimiter or " "
  local tail = #str
  return function()
    local s1 = str:find("=", start, true)
    if not s1 then
      return
    end
    local s2 = str:find("=", s1 + 1, true)
    local e = str:find(delimiter, s1, true) or tail + 1
    start = e + 1
    return s1, s2, e
  end
end

function string.modify_dk(str, mod, inc, delimiter)
  mod = mod or {}
  delimiter = delimiter or " "
  local s1, s2, t = 1, 1, {}
  for i, j, e in iter_dk(str, 0, delimiter) do
    local key1 = tonumber(str:sub(s1, i - 1))
    local key2 = tonumber(str:sub(i + 1, j - 1))
    if mod[key1] and mod[key1][key2] then
      if s1 ~= s2 then
        table_insert(t, str:sub(s2, s1 - 2))
      end
      s2 = e + 1
      if type(mod[key1][key2]) == "number" then
        if inc then
          local v = tonumber(str:sub(j + 1, e - 1))
          table_insert(t, string_format("%d=%d=%d", key1, key2, v + mod[key1][key2]))
        else
          table_insert(t, string_format("%d=%d=%d", key1, key2, mod[key1][key2]))
        end
      end
      mod[key1][key2] = nil
      if not next(mod[key1]) then
        mod[key1] = nil
      end
    end
    s1 = e + 1
    if not next(mod) then
      if s1 < #str then
        table_insert(t, str:sub(s1))
      end
      return table_concat(t, delimiter)
    end
  end
  if s1 ~= s2 then
    table_insert(t, str:sub(s2))
  end
  for k1, data in pairs(mod) do
    for k2, v in pairs(data) do
      if type(v) == "number" then
        table_insert(t, string_format("%d=%d=%d", k1, k2, v))
      end
    end
  end
  return table_concat(t, delimiter)
end

function string.setv_dk(str, k1, k2, v, delimiter)
  delimiter = delimiter or " "
  local mod = {
    [k1] = {
      [k2] = v
    }
  }
  return str:modify_dk(mod, false, delimiter)
end

function string.msetv_dk(str, vs, delimiter)
  delimiter = delimiter or " "
  if not next(vs) then
    return str
  end
  local mod = {}
  for _, t in ipairs(vs) do
    local k1 = tonumber(t[1])
    local k2 = tonumber(t[2])
    local v = tonumber(t[3])
    if mod[k1] then
      mod[k1][k2] = v
    else
      mod[k1] = {
        [k2] = v
      }
    end
  end
  return str:modify_dk(mod, false, delimiter)
end

function string.incrv_dk(str, k1, k2, delta, delimiter)
  delimiter = delimiter or " "
  local mod = {
    [tonumber(k1)] = {
      [tonumber(k2)] = tonumber(delta)
    }
  }
  return str:modify_dk(mod, true, delimiter)
end

function string.mincrv_dk(str, ds, delimiter)
  delimiter = delimiter or " "
  if not next(ds) then
    return str
  end
  local mod = {}
  for _, t in ipairs(ds) do
    local k1 = tonumber(t[1])
    local k2 = tonumber(t[2])
    local delta = tonumber(t[3])
    if mod[k1] then
      mod[k1][k2] = delta
    else
      mod[k1] = {
        [k2] = delta
      }
    end
  end
  return str:modify_dk(ds, true, delimiter)
end

function string.delk_dk(str, k1, k2, delimiter)
  delimiter = delimiter or " "
  local mod = {
    [tonumber(k1)] = {
      [tonumber(k2)] = ""
    }
  }
  return str:modify_dk(mod, false, delimiter)
end

function string.mdelk_dk(str, ks, delimiter)
  delimiter = delimiter or " "
  local mod = {}
  for _, t in ipairs(ks) do
    local k1 = tonumber(t[1])
    local k2 = tonumber(t[2])
    if mod[k1] then
      mod[k1][k2] = ""
    else
      mod[k1] = {
        [k2] = ""
      }
    end
  end
  return str:modify_dk(mod, false, delimiter)
end

function string.getv_dk(str, k1, k2, default, delimiter)
  delimiter = delimiter or " "
  local s1 = 1
  for i, j, e in iter_dk(str, 0, delimiter) do
    local key1 = tonumber(str:sub(s1, i - 1))
    local key2 = tonumber(str:sub(i + 1, j - 1))
    if k1 == key1 and k2 == key2 then
      return tonumber(str:sub(j + 1, e - 1))
    end
    s1 = e + 1
  end
  return default
end

function string.getbit(str, pos)
  local len = #str
  if pos > len or len + pos < 0 then
    return 48
  end
  if pos < 0 and 0 <= len + pos then
    pos = len + pos + 1
  end
  return str:byte(pos)
end

function string.bitcnt(str)
  local cnt = 0
  for i = 1, #str do
    cnt = cnt + str:byte(i) - 48
  end
  return cnt
end

function string.setbit(str, pos, yes)
  yes = yes or "1"
  local len = #str
  if pos < 0 then
    if len + pos < 0 then
      return str
    end
    pos = len + pos + 1
  end
  if len < pos then
    return str .. string.rep("0", pos - len - 1) .. yes
  else
    return str:sub(1, pos - 1) .. yes .. str:sub(pos + 1, -1)
  end
end

function string.toint(input)
  local len = string.len(input)
  local value = 0
  for i = 1, len do
    local tmp = string.byte(input, i)
    value = value * 256 + tmp
  end
  return value
end

function string.isCJKUnicode(char)
  local ch = string.toint(char)
  return 14989440 <= ch and ch <= 15318719 or 14858880 <= ch and ch <= 14860191 or 14860208 <= ch and ch <= 14910399 or 14910592 <= ch and ch <= 14911167 or 15705216 <= ch and ch <= 15707071 or 15710384 <= ch and ch <= 15710607 or 14911360 <= ch and ch <= 14989247
end

function string.isNormalWords(char)
  local value = char:toint()
  if value < 128 then
    return 65 <= value and value <= 90 or 97 <= value and value <= 122
  else
    return char:isCJKUnicode()
  end
end

function string.stringToChars(str)
  local list = {}
  local len = string.len(str)
  local i = 1
  while len >= i do
    local c = string.byte(str, i)
    local shift = 1
    if 0 < c and c <= 127 then
      shift = 1
    elseif 192 <= c and c <= 223 then
      shift = 2
    elseif 224 <= c and c <= 239 then
      shift = 3
    elseif 240 <= c and c <= 247 then
      shift = 4
    end
    local char = string.sub(str, i, i + shift - 1)
    i = i + shift
    table.insert(list, char)
  end
  return list, len
end

function string.checkChatWords(char)
  local value = char:toint()
  if value < 128 then
    return 32 <= value and value ~= 47 and value ~= 92 and value ~= 60 and value ~= 62
  elseif 15711361 <= value and value <= 15712143 then
    return true
  else
    return char:isCJKUnicode()
  end
end

function string.randWeight(str)
  if not str or str == "" then
    return nil
  end
  local tab, sum = {}, 0
  for index, vstr in ipairs(str:toArray()) do
    local tmp = vstr:toArray("=", true)
    sum = sum + tmp[#tmp]
    tab[index] = tmp
  end
  local weight = math.randomFloat(0, sum)
  print("weight:", weight)
  for _, v in ipairs(tab) do
    local val = v[#v]
    if weight > val then
      weight = weight - val
    else
      return v[1]
    end
  end
end
