local VA = require("ejoysdk_lua.vm_channel.ejoy_vm_agent")
local M = {}
local TAG = "ejoy_vm_channel"
M.LUA_VM = {EJOY = "ejoysdk", GAME = "game"}
local clients = {
  [M.LUA_VM.GAME] = VA:New(M.LUA_VM.GAME),
  [M.LUA_VM.EJOY] = VA:New(M.LUA_VM.EJOY)
}

local function current_vm_name()
  local my_vm_name = _ejoysdk.MAIN and M.LUA_VM.EJOY or M.LUA_VM.GAME
  return my_vm_name
end

function M.cross_vm_require(target_vm_name, module_name)
  assert(module_name and "" ~= module_name, "module name should not be nil")
  local E = require("ejoysdk_lua.ejoysdk")
  local my_vm_name = current_vm_name()
  local need_cross_vm_call = target_vm_name and target_vm_name ~= my_vm_name
  local _module
  if need_cross_vm_call then
    E.LOG.debug(TAG, "cross_vm_require vm:" .. tostring(target_vm_name) .. ", module:" .. tostring(module_name))
    local agent = clients[my_vm_name]
    _module = agent:client():cross_vm_require(module_name)
  else
    E.LOG.debug(TAG, "require in self vm:" .. tostring(module_name))
    _module = require(module_name)
  end
  return _module
end

function M.on_receive_message(message)
  local my_vm_name = current_vm_name()
  local agent = clients[my_vm_name]
  agent:server():on_receive(message)
end

function M.on_message_response(func_id, callback_params)
  local my_vm_name = current_vm_name()
  local agent = clients[my_vm_name]
  agent:client():on_message_response(func_id, callback_params)
end

return M
