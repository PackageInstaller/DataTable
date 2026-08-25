local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local E = require("ejoysdk_lua.ejoysdk")
local TAG = "#server_api#ejoysdk_ds_account#"
local M = {}

function M.query_channel_transfer_info(cb)
  local params = {}
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  params[DSP.PAY_PARAMS_KEY.STRING_DS_TOKEN] = GDP.USER_INFO.get("ptoken")
  E.LOG.debug(TAG, "query_channel_transfer_info begin, current ds token >> " .. tostring(GDP.USER_INFO.get("ptoken")))
  DSP.post(DSP.SERVICE.ACCOUNT_QUERY_INFO, params, function(succ, ...)
    E.LOG.debug(TAG, "query_channel_transfer_info end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    if cb then
      cb(succ, ...)
    end
  end)
end

return M
