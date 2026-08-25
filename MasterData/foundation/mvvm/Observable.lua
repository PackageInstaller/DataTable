local setmetatable, getmetatable, rawset, rawget, pairs, type, ipairs = setmetatable, getmetatable, rawset, rawget, pairs, type, _ENV.ipairs
local insert = table.insert
local find, format, sub, gsub = string.find, string.format, string.sub, string.gsub
local load = load or loadstring
local type = type
local is_template = MvvmUtils.is_template
local compile_template = MvvmUtils.compile_template
local append_key = MvvmUtils.append_key
local CB_CHANGED = 1
local CB_ADD = 1
local CB_REMOVE = 2
local _M = {}
local mt_flag = {}

local function gen_set_callback(root_callbacks, field_path)
  return function(data, value, old, key, isSelfCallback)
    for callback_info, v in pairs(root_callbacks) do
      local callbacks = callback_info[field_path]
      if callbacks then
        for callback in pairs(callbacks) do
          callback(data, value, old, key, isSelfCallback)
        end
      end
    end
  end
end

local read_report

local function observeable_init(obj, computed, path, callback_info)
  if "table" ~= type(obj) then
    return obj
  end
  local org_mt = getmetatable(obj)
  if org_mt then
    if org_mt.__flag == mt_flag then
      assert(nil == computed or org_mt.__computed == computed, "不允许对同一个data指定不同的computed")
    end
    return obj
  end
  local root_callbacks = {}
  local _obj = {}
  local field_callbacks = {}
  local self_callback = gen_set_callback(root_callbacks, path)
  for k, v in pairs(obj) do
    local field_path = append_key(path, k)
    _obj[k] = "table" == type(v) and observeable_init(v, nil, field_path, callback_info) or v
    rawset(obj, k, nil)
    field_callbacks[k] = gen_set_callback(root_callbacks, field_path)
  end
  local mt = {
    __flag = mt_flag,
    __raw = _obj,
    __computed = computed,
    __root_callbacks = root_callbacks,
    __len = function(t)
      return #_obj
    end,
    __pairs = function(t)
      do return pairs end
      return pairs, _obj
    end,
    __ipairs = function(t)
      do return ipairs end
      return ipairs, _obj
    end,
    __newindex = function(t, k, v)
      local old = _obj[k]
      _obj[k] = "table" == type(v) and observeable_init(v, nil, append_key(path, k), callback_info) or v
      if old == v then
        return
      end
      local callback = field_callbacks[k]
      if not callback then
        callback = gen_set_callback(root_callbacks, append_key(path, k))
        field_callbacks[k] = callback
      end
      if nil == v then
        field_callbacks[k] = nil
      end
      if nil == old or nil == v then
        self_callback(obj, v, old, k, true)
      else
        callback(obj, v, old, k)
      end
    end
  }
  if computed then
    function mt.__index(t, k)
      if read_report then
        read_report(append_key(path, k))
      end
      local v = _obj[k]
      if nil == v then
        if not computed[k] then
          error("找不到属性：" .. k)
        end
        do return computed[k] end
        return computed[k], obj, k
      else
        return v
      end
    end
  else
    function mt.__index(t, k)
      if read_report then
        read_report(append_key(path, k))
      end
      return _obj[k]
    end
  end
  setmetatable(obj, mt)
  return obj
end

local parse_path = require("Mvvm.MvvmUtils").parse_path

local function to_ordinary_table(tbl)
  if "table" ~= type(tbl) then
    return tbl
  end
  local mt = getmetatable(tbl)
  local raw = mt and mt.__raw
  if not raw then
    return tbl
  end
  local ret = {}
  for k, v in pairs(raw) do
    ret[k] = to_ordinary_table(v)
  end
  return ret
end

local function new(data, computed)
  local callback_info = {}
  local collect_root_callbacks = {}
  observeable_init(data, computed, "", callback_info)
  local observe = {data = data}
  computed = getmetatable(data).__computed
  
  local function unwatchCallback(real_callback)
    for _, cbs in pairs(callback_info) do
      cbs[real_callback] = nil
    end
  end
  
  function observe:destroy()
    for root_callbacks in pairs(collect_root_callbacks) do
      root_callbacks[callback_info] = nil
    end
    collect_root_callbacks = {}
  end
  
  function observe:watchPath(path, callback)
    local keys = parse_path(path)
    
    local function get(obj)
      for _, key in ipairs(keys) do
        if not obj then
          return obj
        end
        obj = obj[key]
      end
      return obj
    end
    
    local value
    local cbs = {}
    local pp = ""
    local cur = data
    local valueKey = keys[#keys]
    for i, key in ipairs(keys) do
      pp = append_key(pp, key)
      local callbacks = callback_info[pp]
      if not callbacks then
        callbacks = {}
        callback_info[pp] = callbacks
      end
      local real_callback
      if i == #keys then
        real_callback = callback
        if "table" == type(cur) and "table" == type(cur[key]) then
          local org_mt = getmetatable(cur[key])
          if org_mt and not org_mt.__root_callbacks[callback_info] then
            org_mt.__root_callbacks[callback_info] = callback_info
            collect_root_callbacks[org_mt.__root_callbacks] = true
          end
        end
      else
        if cur then
          local org_mt = getmetatable(cur)
          if not org_mt.__root_callbacks[callback_info] then
            org_mt.__root_callbacks[callback_info] = callback_info
            collect_root_callbacks[org_mt.__root_callbacks] = true
          end
        end
        
        function real_callback(d, newTable, oldTable, tableKey, isSelfCallback)
          if not isSelfCallback and oldTable and newTable ~= oldTable then
            local old_mt = getmetatable(oldTable)
            old_mt.__root_callbacks[callback_info] = nil
            collect_root_callbacks[old_mt.__root_callbacks] = nil
            if newTable then
              local new_mt = getmetatable(newTable)
              new_mt.__root_callbacks[callback_info] = callback_info
              collect_root_callbacks[new_mt.__root_callbacks] = true
            end
          end
          local old = value
          value = get(data)
          if value == old then
            return
          end
          callback(data, value, old, valueKey, isSelfCallback)
        end
      end
      callbacks[real_callback] = true
      cbs[real_callback] = callbacks
      cur = cur and cur[key]
    end
    
    local function unwatcher()
      for cb, s in pairs(cbs) do
        s[cb] = nil
      end
    end
    
    value = get(data)
    return unwatcher, value
  end
  
  function observe:watch(pathOrFn, callback)
    local compiled
    if "function" == type(pathOrFn) then
      compiled = pathOrFn
    else
      compiled = computed and computed[pathOrFn]
      if not compiled then
        local is_computed_bind = is_template(pathOrFn)
        if is_computed_bind then
          compiled = compile_template(pathOrFn)
        else
          do return observe.watchPath, observe, pathOrFn end
          return observe.watchPath, observe, pathOrFn, callback, nil, nil, nil, nil
        end
      end
    end
    local watched = {}
    local to_watch = {}
    
    local function read_watch(path)
      if not watched[path] then
        table.insert(to_watch, path)
        watched[path] = true
      end
    end
    
    local cbs = {}
    local currentValue
    
    local function set_and_watch(d, n, o, k)
      read_report = read_watch
      local newValue = compiled(data)
      local oldValue = currentValue
      currentValue = newValue
      read_report = nil
      if #to_watch > 0 then
        for _, path in ipairs(to_watch) do
          local fn = observe:watchPath(path, set_and_watch)
          table.insert(cbs, fn)
        end
        to_watch = {}
      end
      callback(data, newValue, oldValue)
    end
    
    set_and_watch()
    
    local function unwatcher()
      for i, v in ipairs(cbs) do
        unwatchCallback(v)
      end
    end
    
    return unwatcher, currentValue
  end
  
  function observe:unwatch(unwatchFn)
    unwatchFn()
  end
  
  function observe:setter(path)
    local keys = parse_path(path)
    local key_len = #keys
    return function(obj, value)
      for i, key in ipairs(keys) do
        if not obj then
          return
        end
        if i == key_len then
          obj[key] = value
        else
          obj = obj[key]
        end
      end
    end
  end
  
  function observe:getter(path)
    local keys = parse_path(path)
    return function(obj)
      for _, key in ipairs(keys) do
        if not obj then
          return
        end
        obj = obj[key]
      end
      return obj
    end
  end
  
  function observe:read_report(callback)
    read_report = callback
  end
  
  function observe:raw(tbl)
    do return to_ordinary_table end
    return to_ordinary_table, tbl
  end
  
  return observe
end

_M.new = new
_M.raw = to_ordinary_table

local function test()
  parse_path("a.b.c")
  parse_path("a.b.cde")
  parse_path("a")
  parse_path("a[1]")
  parse_path("[1]")
  parse_path("a.b[1]")
  parse_path("a.b[1].cd")
  Logger.Debug(pcall(parse_path, "a.b[1.cd"))
  Logger.Debug(pcall(parse_path, "a.b[aa]"))
  local data = {
    someStr = "Hello ",
    child = {someStr = "World !"}
  }
  local observe = new(data)
  observe:watch("someStr", function(root, value, old)
    Logger.Debug("someStr changed", value, old)
  end)
  observe:watch("child.someStr", function(root, value, old)
    Logger.Debug("child.someStr changed", value, old)
  end)
  observe:watch("child", function(root, value, old)
    Logger.Debug("child changed", value, old)
  end)
  Logger.Debug("---------------------")
  data.someStr = "Hello John"
  Logger.Debug("---------------------")
  data.child.someStr = "!!!"
  Logger.Debug("---------------------")
  data.child = nil
  Logger.Debug("---------------------")
  data.child = {someStr = 100}
  Logger.Debug("---------------------")
  data.child.aaa = 1000
  Logger.Debug("---------------------")
  data.child = data.child
end

if arg and arg[1] == "test" then
  test()
end
return _M
