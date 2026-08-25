local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local data = {}
local RPC_INPUT_MESSAGE = "cloud_input_rpc"
local E = require("ejoysdk_lua.ejoysdk")
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_input_rpc"

function M.init(is_cloud, msg_logic)
  data.msg_logic = msg_logic
  data.is_cloud = is_cloud
  if is_cloud then
    return
  end
  msg_logic:rpc_register_handle(RPC_INPUT_MESSAGE, function(_error_response, response, params)
    cloud_adapter.show_input_method(function(succ, ...)
      if succ then
        local input_text = (...)
        E.LOG.debug(TAG, "mobile input send =" .. tostring(input_text))
        response(true, input_text or "")
      else
        E.LOG.warn(TAG, "mobile input failed send empty str")
        response(false, ...)
      end
    end, params)
  end)
end

function M.request_input(error_cb, ok_cb, params)
  data.msg_logic:rpc_request(data.msg_logic:rpc_create_error_handle(error_cb), function(succ, ...)
    if succ then
      local input_str = (...)
      E.LOG.debug(TAG, "remote input receive =" .. tostring(input_str))
      ok_cb(input_str)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "remote input failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      error_cb(code, msg)
    end
  end, RPC_INPUT_MESSAGE, params)
end

return M
