local packPool = CommonPool.New(function()
  return setmetatable({}, {__mode = "v"})
end, nil)
local unpack = unpack or table.unpack

function SafePack(...)
  local params = {
    ...
  }
  params.n = select("#", ...)
  return params
end

function SafeUnpack(safe_pack_tb)
  return unpack(safe_pack_tb, 1, safe_pack_tb.n)
end

function ConcatSafePackNoGC(concat, safe_pack_l, ...)
  for i = 1, safe_pack_l.n do
    concat[i] = safe_pack_l[i]
  end
  local rn = select("#", ...)
  for i = 1, rn do
    concat[safe_pack_l.n + i] = select(i, ...)
  end
  concat.n = safe_pack_l.n + rn
end

function _ENV:Bind(func, ...)
  assert(self == nil or type(self) == "table")
  assert(func ~= nil and type(func) == "function")
  local params
  if self == nil then
    params = SafePack(...)
  else
    params = SafePack(self, ...)
  end
  return function(...)
    if select("#", ...) > 0 then
      local args = packPool:PoolGet()
      ConcatSafePackNoGC(args, params, ...)
      local ret, ret2 = func(SafeUnpack(args))
      packPool:PoolPut(args)
      return ret, ret2
    end
    return func(SafeUnpack(params))
  end
end

function BindCallback(...)
  local bindFunc
  local argCount = select("#", ...)
  assert(1 <= argCount, "BindCallback : error params count!")
  if type(select(1, ...)) == "table" and type(select(2, ...)) == "function" then
    bindFunc = Bind(...)
  elseif type(select(1, ...)) == "function" then
    bindFunc = Bind(nil, ...)
  else
    error("BindCallback : error params list!")
  end
  return bindFunc
end

function DeepCopy(object)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for index, value in pairs(object) do
      new_table[_copy(index)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  
  return _copy(object)
end

function Serialize(tb, flag)
  local result = ""
  result = string.format("%s{", result)
  
  local function filter(str)
    str = string.gsub(str, "%[", " ")
    str = string.gsub(str, "%]", " ")
    str = string.gsub(str, "\"", " ")
    str = string.gsub(str, "%'", " ")
    str = string.gsub(str, "\\", " ")
    str = string.gsub(str, "%%", " ")
    return str
  end
  
  for k, v in pairs(tb) do
    if type(k) == "number" then
      if type(v) == "table" then
        result = string.format("%s[%d]=%s,", result, k, Serialize(v))
      elseif type(v) == "number" then
        result = string.format("%s[%d]=%d,", result, k, v)
      elseif type(v) == "string" then
        result = string.format("%s[%d]=%q,", result, k, v)
      elseif type(v) == "boolean" then
        result = string.format("%s[%d]=%s,", result, k, tostring(v))
      elseif flag then
        result = string.format("%s[%d]=%q,", result, k, type(v))
      else
        error("the type of value is a function or userdata")
      end
    elseif type(v) == "table" then
      result = string.format("%s%s=%s,", result, k, Serialize(v, flag))
    elseif type(v) == "number" then
      result = string.format("%s%s=%d,", result, k, v)
    elseif type(v) == "string" then
      result = string.format("%s%s=%q,", result, k, v)
    elseif type(v) == "boolean" then
      result = string.format("%s%s=%s,", result, k, tostring(v))
    elseif flag then
      result = string.format("%s[%s]=%q,", result, k, type(v))
    else
      error("the type of value is a function or userdata")
    end
  end
  result = string.format("%s}", result)
  return result
end

function CreatEnumTable(tbl, index)
  assert(type(tbl) == "table")
  local enumtbl = {}
  local enumindex = index or 0
  for i, v in ipairs(tbl) do
    enumtbl[v] = enumindex + i
  end
  return enumtbl
end

function List2Table(list)
  local tab = {}
  for i = 0, list.Count - 1 do
    table.insert(tab, list[i])
  end
  return tab
end

function Dictionary2Table(dic)
  local tab = {}
  for k, v in pairs(dic) do
    tab[k] = v
  end
  return tab
end

function FormatNum(num)
  local t1, t2 = math.modf(num)
  if 0 < t2 then
    return num
  else
    return t1
  end
end

function GetPreciseDecimalStr(num, n)
  num = FormatNum(num)
  n = n or 0
  local floor = math.floor(num)
  local isInt = n == 0 or num == floor
  local value
  if isInt then
    value = tostring(floor)
  else
    local scale = Mathf.Pow(10, n)
    num = num * scale
    value = tostring(math.floor(num) / scale)
  end
  return value
end

function math.clamp(v, minValue, maxValue)
  if v < minValue then
    return minValue
  end
  if maxValue < v then
    return maxValue
  end
  return v
end

function string.isNumber(str)
  if string.len(str) < 1 then
    return false
  end
  for i = 1, string.len(str) do
    if string.byte(str, i, i) < 48 or string.byte(str, i, i) > 57 then
      return false
    end
  end
  return true
end
