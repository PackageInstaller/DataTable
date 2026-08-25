local Class = require("ejoysdk_lua.ejoysdk_class")
local Message = require("ejoysdk_lua.vm_channel.message")
local unpack = table.unpack or _ENV.unpack
local M = Class:Inherit("EjoyVmAgentClient")
local TAG = "vm_agent_client"

function M:_init(client_name)
  self._data = {
    name = client_name,
    proxy_module_cache = {}
  }
end

local function call_lua_module(module_name, fn_name, sync_cb, ...)
  local E = require("ejoysdk_lua.ejoysdk")
  local message = Message.serialize_call_to_message(module_name, fn_name, sync_cb, ...)
  E.async_call_lua_module(message)
end

local function async_call_lua_module(module_name, fn_name, ...)
  call_lua_module(module_name, fn_name, nil, ...)
end

local function sync_call_lua_module(module_name, fn_name, sync_cb, ...)
  call_lua_module(module_name, fn_name, sync_cb, ...)
end

function M:cross_vm_require(module_name)
  local E = require("ejoysdk_lua.ejoysdk")
  local _proxy_module = self._data.proxy_module_cache[module_name]
  if _proxy_module then
    return _proxy_module
  end
  _proxy_module = {
    async_call = function(fn_name, ...)
      async_call_lua_module(module_name, fn_name, ...)
    end,
    sync_call = function(fn_name, sync_cb, ...)
      sync_call_lua_module(module_name, fn_name, sync_cb, ...)
    end
  }
  setmetatable(_proxy_module, {
    __index = function(_t, k)
      local _func_name = k
      return function(...)
        local data = (...)
        E.LOG.debug(TAG, "async_call_lua_module proxy, func:" .. tostring(_func_name) .. ", data type:" .. tostring(type(data)))
        async_call_lua_module(module_name, _func_name, ...)
      end
    end
  })
  self._data.proxy_module_cache[module_name] = _proxy_module
  return _proxy_module
end

function M:on_message_response(func_id, callback_params)
  local cb = Message.find_callback(func_id)
  local _ok = pcall(cb, unpack(callback_params))
  Message.recycle_callback(cb)
end

return M
