local unpack = unpack or table.unpack
local util = require("XLua.Common.xlua_util")
local helper = require("XLua.Common.helper")
local cache = {}

local function GetKey(...)
  local params = {
    ...
  }
  local key = ""
  for _, v in ipairs(params) do
    key = key .. "\t" .. tostring(v)
  end
  return key
end

local function GetCache(key)
  return cache[key]
end

local function SetCache(key, value)
  assert(GetCache(key) == nil, "already contains key " .. key)
  cache[key] = value
end

local function ClearCache(key)
  cache[key] = nil
end

local function add_listener_with_delegate(messengerName, cs_del_obj)
  CS.XLuaMessenger.AddListener(messengerName, cs_del_obj)
end

local function add_listener_with_func(messengerName, cs_obj, func)
  local key = GetKey(cs_obj, func)
  local obj_bind_callback = GetCache(key)
  if obj_bind_callback == nil then
    obj_bind_callback = util.bind(func, cs_obj)
    SetCache(key, obj_bind_callback)
    local lua_callback = CS.XLuaMessenger.CreateDelegate(messengerName, obj_bind_callback)
    CS.XLuaMessenger.AddListener(messengerName, lua_callback)
  end
end

local function add_listener_with_reflection(messengerName, cs_obj, method_name, ...)
  local cs_del_obj = helper.new_callback(cs_obj, method_name, ...)
  CS.XLuaMessenger.AddListener(messengerName, cs_del_obj)
end

local function add_listener(messengerName, ...)
  local params = {
    ...
  }
  assert(1 <= #params, "error params count!")
  if #params == 1 then
    add_listener_with_delegate(messengerName, unpack(params))
  elseif #params == 2 and type(params[2]) == "function" then
    add_listener_with_func(messengerName, unpack(params))
  else
    add_listener_with_reflection(messengerName, unpack(params))
  end
end

local function broadcast(messengerName, ...)
  CS.XLuaMessenger.Broadcast(messengerName, ...)
end

local function remove_listener_with_delegate(messengerName, cs_del_obj)
  CS.XLuaMessenger.RemoveListener(messengerName, cs_del_obj)
end

local function remove_listener_with_func(messengerName, cs_obj, func)
  local key = GetKey(cs_obj, func)
  local obj_bind_callback = GetCache(key)
  if obj_bind_callback ~= nil then
    ClearCache(key)
    local lua_callback = CS.XLuaMessenger.CreateDelegate(messengerName, obj_bind_callback)
    CS.XLuaMessenger.RemoveListener(messengerName, lua_callback)
  end
end

local function remove_listener_with_reflection(messengerName, cs_obj, method_name, ...)
  local cs_del_obj = helper.new_callback(cs_obj, method_name, ...)
  CS.XLuaMessenger.RemoveListener(messengerName, cs_del_obj)
end

local function remove_listener(messengerName, ...)
  local params = {
    ...
  }
  assert(1 <= #params, "error params count!")
  if #params == 1 then
    remove_listener_with_delegate(messengerName, unpack(params))
  elseif #params == 2 and type(params[2]) == "function" then
    remove_listener_with_func(messengerName, unpack(params))
  else
    remove_listener_with_reflection(messengerName, unpack(params))
  end
end

return {
  add_listener = add_listener,
  broadcast = broadcast,
  remove_listener = remove_listener
}
