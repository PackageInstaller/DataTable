local Class = require("ejoysdk_lua.ejoysdk_class")
local Message = require("ejoysdk_lua.vm_channel.message")
local M = Class:Inherit("EjoyVmAgentServer")

function M:_init(client_name)
  self._data = {name = client_name}
end

function M:on_receive(message)
  local Bridge = require("ejoysdk_lua.ejoysdk_js_bridge_adapter")
  if not Bridge.output2 then
    function Bridge.output2(func_id, callback_params)
      self:reponse_to_receive(func_id, callback_params)
    end
  end
  Message.parse_message_to_call(message)
end

function M:reponse_to_receive(func_id, callback_params)
  local E = require("ejoysdk_lua.ejoysdk")
  E.async_response_lua_module(func_id, callback_params)
end

return M
