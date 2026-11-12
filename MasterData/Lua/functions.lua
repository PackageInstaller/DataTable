function clone(object)
  local lookup_table = {}
  
  local function _copy(object)
    if type(object) ~= "table" then
      return object
    elseif lookup_table[object] then
      return lookup_table[object]
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key, value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end
  
  return _copy(object)
end

function class(classname, super)
  local superType = type(super)
  local cls
  if superType ~= "function" and superType ~= "table" then
    superType = nil
  end
  if superType == "function" or super and super.__ctype == 1 then
    cls = {}
    if superType == "table" then
      for k, v in pairs(super) do
        cls[k] = v
      end
      cls.__create = super.__create
      cls.super = super
    else
      cls.__create = super
    end
    
    function cls.ctor()
    end
    
    cls.__cname = classname
    cls.__ctype = 1
    
    function cls.new(...)
      local instance = cls.__create(...)
      for k, v in pairs(cls) do
        instance[k] = v
      end
      instance.class = cls
      instance:ctor(...)
      return instance
    end
  else
    if super then
      cls = clone(super)
      cls.super = super
    else
      cls = {
        ctor = function(...)
        end
      }
    end
    cls.__cname = classname
    cls.__ctype = 2
    cls.__index = cls
    
    function cls.new(...)
      local instance = setmetatable({}, cls)
      instance.class = cls
      instance:ctor(...)
      return instance
    end
  end
  return cls
end

function import(moduleName, currentModuleName)
  local currentModuleNameParts
  local moduleFullName = moduleName
  local offset = 1
  while true do
    if string.byte(moduleName, offset) ~= 46 then
      moduleFullName = string.sub(moduleName, offset)
      if currentModuleNameParts and 0 < #currentModuleNameParts then
        moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
      end
      break
    end
    offset = offset + 1
    if not currentModuleNameParts then
      if not currentModuleName then
        local n, v = debug.getlocal(3, 1)
        currentModuleName = v
      end
      currentModuleNameParts = string.split(currentModuleName, ".")
    end
    table.remove(currentModuleNameParts, #currentModuleNameParts)
  end
  return require(moduleFullName)
end

function handler(obj, method, uiComponent)
  return function(...)
    if uiComponent == nil then
      return method(obj, ...)
    else
      return method(obj, uiComponent, ...)
    end
  end
end

function ui_handler(obj, method, uiComponent, nIndex)
  return function(...)
    if type(nIndex) == "number" then
      return method(obj, uiComponent, nIndex, ...)
    else
      return method(obj, uiComponent, ...)
    end
  end
end

function dotween_callback_handler(obj, method, ...)
  local tbParameter = {}
  for i = 1, select("#", ...) do
    local param = select(i, ...)
    table.insert(tbParameter, param)
  end
  return function()
    if obj ~= nil and type(method) == "function" then
      local ok, error = pcall(method, obj, table.unpack(tbParameter))
      if not ok then
        printError(error)
      end
    end
  end
end

function safe_call_cs_func(cs_func, ...)
  local tbParameter = {}
  for i = 1, select("#", ...) do
    local param = select(i, ...)
    table.insert(tbParameter, param)
  end
  local ok, result = pcall(cs_func, table.unpack(tbParameter))
  if not ok then
    printError(result)
  else
    return result
  end
end

function safe_call_cs_func2(cs_func, ...)
  local tbParameter = {}
  for i = 1, select("#", ...) do
    local param = select(i, ...)
    table.insert(tbParameter, param)
  end
  local tbResult = {
    pcall(cs_func, table.unpack(tbParameter))
  }
  if not tbResult[1] then
    printError(tbResult[2])
  else
    table.remove(tbResult, 1)
    return table.unpack(tbResult)
  end
end

function table.nums(t)
  local count = 0
  for k, v in pairs(t) do
    count = count + 1
  end
  return count
end

function table.keys(hashtable)
  local keys = {}
  for k, v in pairs(hashtable) do
    keys[#keys + 1] = k
  end
  return keys
end

function table.values(hashtable)
  local values = {}
  for k, v in pairs(hashtable) do
    if v ~= json.null then
      values[#values + 1] = v
    end
  end
  return values
end

function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end
end

function table.insertto(dest, src, begin)
  begin = checkint(begin)
  if begin <= 0 then
    begin = #dest + 1
  end
  local len = #src
  for i = 0, len - 1 do
    dest[i + begin] = src[i + 1]
  end
end

function checknumber(value, base)
  return tonumber(value, base) or 0
end

function checkint(value)
  return math.round(checknumber(value))
end

function math.round(value)
  value = checknumber(value)
  return math.floor(value + 0.5)
end

function checkbool(value)
  return value ~= nil and value ~= false
end

function checktable(value)
  if type(value) ~= "table" then
    value = {}
  end
  return value
end

function isset(hashtable, key)
  local t = type(hashtable)
  return (t == "table" or t == "userdata") and hashtable[key] ~= nil
end

function table.indexof(array, value, begin)
  for i = begin or 1, #array do
    if array[i] == value then
      return i
    end
  end
  return 0
end

function table.keyof(hashtable, value)
  for k, v in pairs(hashtable) do
    if v == value then
      return k
    end
  end
  return nil
end

function table.removebyvalue(array, value, removeall)
  local c, i, max = 0, 1, #array
  while i <= max do
    if array[i] == value then
      table.remove(array, i)
      c = c + 1
      i = i - 1
      max = max - 1
      if not removeall then
        break
      end
    end
    i = i + 1
  end
  return c
end

function table.map(t, fn)
  for k, v in pairs(t) do
    t[k] = fn(v, k)
  end
end

function table.walk(t, fn)
  for k, v in pairs(t) do
    fn(v, k)
  end
end

function table.shuffle(t)
  local n = #t
  while 2 < n do
    local k = math.random(n)
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
  return t
end

function table.filter(t, fn)
  for k, v in pairs(t) do
    if not fn(v, k) then
      t[k] = nil
    end
  end
end

function table.unique(t, bArray)
  local check = {}
  local n = {}
  local idx = 1
  for k, v in pairs(t) do
    if not check[v] then
      if bArray then
        n[idx] = v
        idx = idx + 1
      else
        n[k] = v
      end
      check[v] = true
    end
  end
  return n
end

function string.htmlspecialchars(input)
  for k, v in pairs(string._htmlspecialchars_set) do
    input = string.gsub(input, k, v)
  end
  return input
end

function string.restorehtmlspecialchars(input)
  for k, v in pairs(string._htmlspecialchars_set) do
    input = string.gsub(input, v, k)
  end
  return input
end

function string.nl2br(input)
  return string.gsub(input, "\n", "<br />")
end

function string.text2html(input)
  input = string.gsub(input, "\t", "    ")
  input = string.htmlspecialchars(input)
  input = string.gsub(input, " ", "&nbsp;")
  input = string.nl2br(input)
  return input
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

function string.ucfirst(input)
  return string.upper(string.sub(input, 1, 1)) .. string.sub(input, 2)
end

local function urlencodechar(char)
  return "%" .. string.format("%02X", string.byte(char))
end

function string.urlencode(input)
  input = string.gsub(tostring(input), "\n", "\r\n")
  input = string.gsub(input, "([^%w%.%- ])", urlencodechar)
  return string.gsub(input, " ", "+")
end

function string.urldecode(input)
  input = string.gsub(input, "+", " ")
  input = string.gsub(input, "%%(%x%x)", function(h)
    return string.char(checknumber(h, 16))
  end)
  input = string.gsub(input, "\r\n", "\n")
  return input
end

function string.utf8len(input)
  local len = string.len(input)
  local left = len
  local cnt = 0
  local arr = {
    0,
    192,
    224,
    240,
    248,
    252
  }
  while left ~= 0 do
    local tmp = string.byte(input, -left)
    local i = #arr
    while arr[i] do
      if tmp >= arr[i] then
        left = left - i
        break
      end
      i = i - 1
    end
    cnt = cnt + 1
  end
  return cnt
end

function string.formatnumberthousands(num)
  local formatted = tostring(checknumber(num))
  local k
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if k == 0 then
      break
    end
  end
  return formatted
end

function string.append_all(buffer, ...)
  for i = 1, select("#", ...) do
    table.insert(buffer, (select(i, ...)))
  end
end

function print_dump(data, showMetatable, lastCount)
  if type(data) ~= "table" then
    if type(data) == "string" then
      print("\"", data, "\"")
    else
      print(tostring(data))
    end
  else
    local count = lastCount or 0
    count = count + 1
    print("{\n")
    if showMetatable then
      for i = 1, count do
        print("\t")
      end
      local mt = getmetatable(data)
      print("\"__metatable\" = ")
      print_dump(mt, showMetatable, count)
      print(",\n")
    end
    for key, value in pairs(data) do
      for i = 1, count do
        print("\t")
      end
      if type(key) == "string" then
        print("\"", key, "\" = ")
      elseif type(key) == "number" then
        print("[", key, "] = ")
      else
        print(tostring(key))
      end
      print_dump(value, showMetatable, count)
      print(",\n")
    end
    for i = 1, lastCount or 0 do
      print("\t")
    end
    print("}")
  end
  if not lastCount then
    print("\n")
  end
end

function setfenv(fn, env)
  local i = 1
  while true do
    local name = debug.getupvalue(fn, i)
    if name == "_ENV" then
      debug.upvaluejoin(fn, i, function()
        return env
      end, 1)
      break
    elseif not name then
      break
    end
    i = i + 1
  end
  return fn
end

function getfenv(fn)
  local i = 1
  while true do
    local name, val = debug.getupvalue(fn, i)
    if name == "_ENV" then
      return val
    elseif not name then
      break
    end
    i = i + 1
  end
end

function run_with_env(env, fn, ...)
  setfenv(fn, env)
  fn(...)
end

local function sortedKeys(t)
  local keys = {}
  for k in pairs(t) do
    if type(k) == "number" then
      table.insert(keys, k)
    end
  end
  table.sort(keys)
  return keys
end

function ipairsSorted(t)
  local keys = sortedKeys(t)
  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], t[keys[i]]
    end
  end
end

function orderedFormat(formatStr, ...)
  local args = {
    ...
  }
  return (formatStr:gsub("{([^}]+)}", function(placeholder)
    local patterns = {".-_(%d+)$", "^(%d+)$"}
    for _, pattern in ipairs(patterns) do
      local num = placeholder:match(pattern)
      if num then
        local index = tonumber(num) + 1
        return tostring(args[index] or "")
      end
    end
    return "{" .. placeholder .. "}"
  end))
end

function clearFloat(a)
  local floor = math.floor(a)
  local ceil = math.ceil(a)
  if math.abs(a - floor) < 1.0E-10 then
    return floor
  end
  if math.abs(a - ceil) < 1.0E-10 then
    return ceil
  end
  return a
end
