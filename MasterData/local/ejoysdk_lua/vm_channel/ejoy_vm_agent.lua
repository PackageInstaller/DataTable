local Class = require("ejoysdk_lua.ejoysdk_class")
local CL = require("ejoysdk_lua.vm_channel.vm_agent_client")
local SR = require("ejoysdk_lua.vm_channel.vm_agent_server")
local M = Class:Inherit("EjoyVmAgent")

function M:_init(client_name)
  self._data = {
    name = client_name,
    client = CL:New(client_name),
    server = SR:New(client_name)
  }
end

function M:client()
  return self._data.client
end

function M:server()
  return self._data.server
end

return M
