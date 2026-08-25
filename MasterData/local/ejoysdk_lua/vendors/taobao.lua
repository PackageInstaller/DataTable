local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "TAOBAO"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.TAOBAO
local UNI = require("ejoysdk_lua.vendors.unisdk")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local ASYNC_GET_ACCESS_TOKEN = "ASYNC_GET_ACCESS_TOKEN"

function M.init(opt, cb)
  M.opt = opt
  cb(true)
end

function M.login(_ext_params, cb)
  E.LOG.debug(TAG, "taobao login begin")
  cb = cb or function()
  end
  local os = E.Sysinfo.os()
  if "windows" == os then
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support")
    cb(channel_result)
    return
  end
  if M.isTaobaoInstalled() then
    UNI.async_call(VENDOR_NAME, ASYNC_GET_ACCESS_TOKEN, {}, nil, function(succ, ...)
      if succ then
        local body = (...)
        if body and body.token and body.token ~= "" then
          local userInfo = {
            token = body.token,
            uid = body.user_id,
            guest = false
          }
          local ext = {}
          local channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
          cb(channel_result)
        else
          local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL, "Invalid taobao-token")
          cb(channel_result)
        end
      else
        local code, body = ...
        local channel_result = PROTOCOL.LoginResult.fail(code, (body or {}).error_msg)
        cb(channel_result)
      end
    end)
  else
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_TAOBAO_NOT_INSTALL, "Not Install")
    cb(channel_result)
  end
end

function M.isTaobaoInstalled()
  local sdk_infos = UNI.get_sdk_infos()
  local os = _ejoysdk.os()
  if sdk_infos and sdk_infos[VENDOR_NAME] then
    if "android" == os then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, "com.taobao.taobao"
    elseif "ios" == os then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, "tbopen:"
    end
  end
  return false
end

M.VENDOR_NAME = VENDOR_NAME
return M
