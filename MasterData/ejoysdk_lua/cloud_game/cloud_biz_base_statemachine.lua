local E = require("ejoysdk_lua.ejoysdk")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("CLOUD_BIZ_BASE")
local TAG = "CLOUD_BIZ_BASE"

local function request_cloud_config(cb)
  CA.request_cloud_server_config(function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M.static_show_error_retry_ui(err_code, err_msg, _retry_fun)
  E.LOG.warn(TAG, "show_error_retry_ui failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
  CSTAT.stat_action_fail("show_error_retry_ui", nil, err_code, err_msg)
  UI._show_network_error_retry(UI.ErrorType.NetworkError, err_code, _retry_fun)
end

function M.static_check_cloud_config(cb)
  local req_cloud_config_cb
  
  function req_cloud_config_cb(succ, ...)
    if CC.DEBUG_OPTIONS.TestConnectRequestTimeFailed then
      E.LOG.warn(TAG, "TestConnectRequestTimeFailed enabled")
      cb(false, 400000, "req_cloud_config_cb failed")
      return
    end
    if succ then
      E.LOG.debug(TAG, "request cloud config succ")
      cb(true)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "request cloud config failed, code" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end
  
  request_cloud_config(req_cloud_config_cb)
end

return M
