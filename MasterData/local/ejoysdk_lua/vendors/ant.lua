local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "ANT"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.ANT
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ASYNC_GET_ACCESS_TOKEN = "ASYNC_GET_ACCESS_TOKEN"
local ATracer = require("ejoysdk_lua.account.account_tracer")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
M.AUTH_VENDOR_NAME = VENDOR_NAME .. "_AUTH"

function M.init(opt, cb)
  M.opt = opt
  cb(true)
end

function M.login(params, cb)
  E.LOG.debug(TAG, "alipay login begin")
  local ant_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.ANT_LOGIN, params)
  cb = cb or function()
  end
  local os = E.Sysinfo.os()
  if "windows" == os then
    ATracer.finish_login_sub_span(ant_login_span, {
      succ = false,
      code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT,
      msg = "Not Support"
    })
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support")
    cb(channel_result)
    return
  end
  params = params or {}
  if not params or not params.authInfo then
    ATracer.finish_login_sub_span(ant_login_span, {
      succ = false,
      code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL,
      msg = "Params Error"
    })
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL, "Params Error")
    cb(channel_result)
    return
  end
  if M.isAntInstalled() then
    UNI.async_call(VENDOR_NAME, ASYNC_GET_ACCESS_TOKEN, params, nil, function(succ, ...)
      if succ then
        local body = (...)
        if body and body.token and body.token ~= "" then
          ATracer.finish_login_sub_span(ant_login_span, {succ = true, body = body})
          local userInfo = {
            token = body.token,
            uid = body.user_id,
            guest = false
          }
          local ext = {}
          local channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
          cb(channel_result)
        else
          ATracer.finish_login_sub_span(ant_login_span, {
            succ = false,
            code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL,
            msg = "Invalid alipay-token"
          })
          local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL, "Invalid alipay-token")
          cb(channel_result)
        end
      else
        local code, body = ...
        ATracer.finish_login_sub_span(ant_login_span, {
          succ = false,
          code = code,
          body = body
        })
        local channel_result = PROTOCOL.LoginResult.fail(code, (body or {}).error_msg)
        cb(channel_result)
      end
    end)
  else
    ATracer.finish_login_sub_span(ant_login_span, {
      succ = false,
      code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_TAOBAO_NOT_INSTALL,
      msg = "Not Install"
    })
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_TAOBAO_NOT_INSTALL, "Not Install")
    cb(channel_result)
  end
end

function M.isAntInstalled()
  local sdk_infos = UNI.get_sdk_infos()
  local os = _ejoysdk.os()
  if sdk_infos and sdk_infos[VENDOR_NAME] then
    local tmp = "p" .. "a" .. "y"
    if "android" == os then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, "com.eg.android.Ali" .. tmp .. "Gphone", tmp, "Gphone"
    elseif "ios" == os then
      do return E.Sysinfo.is_app_install end
      return E.Sysinfo.is_app_install, "ali" .. tmp .. ":", tmp, ":"
    end
  end
  return false
end

return M
