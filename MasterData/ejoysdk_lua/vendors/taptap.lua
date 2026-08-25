local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CHANNEL = "TAP_UPDATE"
if _ejoysdk.os() == "windows" then
  CHANNEL = "TAP_LOGIN"
end
local ACTION_IS_SUPPORT_AUTH = "ACTION_IS_SUPPORT_AUTH"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.TAPTAP
local ASYNC_CALL_UPDATE = "ASYNC_CALL_UPDATE"
local ASYNC_GET_ACCESS_TOKEN = "ASYNC_GET_ACCESS_TOKEN"
local ASYNC_CHECK_LICENSE = "ASYNC_CHECK_LICENSE"
local SYNC_IS_SUPPORT_TAP_UPDATE = "SYNC_IS_SUPPORT_TAP_UPDATE"
local SYNC_TAPTAP_SUPPORT = "SYNC_TAPTAP_SUPPORT"
local SYNC_TAPTAP_CHECK_IF_NEED_RESTART = "SYNC_TAPTAP_CHECK_IF_NEED_RESTART"
local SYNC_TAPTAP_INIT = "SYNC_TAPTAP_INIT"
local ASYNC_TAPTAP_TICK = "ASYNC_TAPTAP_TICK"
local ASYNC_TAPTAP_EXIT = "ASYNC_TAPTAP_EXIT"
local tap_callback_tick
local current_tick_interval = 0.2
local EVENT_CHECK_LICENSE_BEGIN = "sdk.tap.checkLicense.begin"
local EVENT_CHECK_LICENSE_END = "sdk.tap.checkLicense.end"

local function check_tap_update_support()
  local ret = UNI.sync_call(CHANNEL, SYNC_IS_SUPPORT_TAP_UPDATE, {})
  if ret and ret.value then
    E.LOG.debug(TAG, "check " .. SYNC_IS_SUPPORT_TAP_UPDATE .. ": " .. tostring(ret.value))
    return ret.value
  else
    E.LOG.warn(TAG, "check SYNC_IS_SUPPORT_TAP_UPDATE failed")
    return false
  end
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "tap init")
  E.LOG.debug(TAG, {params = opt})
  local check_license = opt.TAP_LICENSE
  if check_license then
    QL.commit_event(EVENT_CHECK_LICENSE_BEGIN, {}, true)
    local params = {mode = 1}
    UNI.async_call(CHANNEL, ASYNC_CHECK_LICENSE, params, nil, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "check native license success")
        QL.commit_event(EVENT_CHECK_LICENSE_END, {}, true)
        cb(true)
      else
        E.LOG.debug(TAG, "check native license fail")
        cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_CHECK_LICENSE_FAIL, "check license fail")
        QL.commit_event(EVENT_CHECK_LICENSE_END, {}, false)
      end
    end)
  elseif _ejoysdk.os() == "windows" then
    local sdk_info = UNI.get_sdk_info(CHANNEL)
    local meta_data = sdk_info.meta
    E.LOG.debug(TAG, {meta_data = meta_data})
    local ret = UNI.sync_call(CHANNEL, SYNC_TAPTAP_CHECK_IF_NEED_RESTART, {})
    E.LOG.debug(TAG, "SYNC_TAPTAP_CHECK_IF_NEED_RESTART get value:")
    E.LOG.debug(TAG, {ret = ret})
    if ret.value then
      E.LOG.debug(TAG, "this game shold restart from taptap store client")
    end
    local init_param = {
      clientPublicKey = meta_data.clientPublicKey
    }
    ret = UNI.sync_call(CHANNEL, SYNC_TAPTAP_INIT, init_param)
    E.LOG.debug(TAG, "SYNC_TAPTAP_INIT get value:")
    E.LOG.debug(TAG, {ret = ret})
    if ret and 0 == ret.code then
      E.LOG.debug(TAG, "taptap init success")
      cb(true)
      
      function tap_callback_tick()
        UNI.async_call(CHANNEL, ASYNC_TAPTAP_TICK, {}, nil, function(_succ2, ...)
        end)
        E.Timer.once(current_tick_interval, tap_callback_tick)
      end
      
      tap_callback_tick()
    else
      E.LOG.debug(TAG, "taptap init failed")
      local tip_msg = "游戏启动异常，请稍后再试或联系客服。"
      if 2 == ret.code then
        tip_msg = "未找到TapTap，请下载最新版TapTap后，再尝试从TapTap重新启动游戏。"
      elseif 3 == ret.code then
        tip_msg = "请从TapTap启动游戏。"
      elseif 4 == ret.code then
        tip_msg = "TapTap版本不匹配，请尝试将TapTap和游戏都升级至最新版本后，再从TapTap重新启动游戏。"
      end
      E.Modal.open("提示", {
        message = tip_msg,
        buttons = {"确定"}
      }, function()
        E.LOG.debug(TAG, "ready to kill the game process")
        UNI.async_call(CHANNEL, ASYNC_TAPTAP_EXIT, {}, nil, function()
        end)
        _ejoysdk.exit()
      end)
      local code = ret and ret.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_NATIVE_INIT_FAILED
      local message = ret and ret.message or tip_msg
      cb(false, code, message)
    end
  else
    cb(true)
  end
end

function M.login(params, cb)
  E.LOG.debug(TAG, "tap login begin")
  M.tap_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.TAP_LOGIN, params)
  M.login_cb = cb
  if E.Sysinfo.os() ~= "android" and E.Sysinfo.os() ~= "windows" then
    ATracer.finish_login_sub_span(M.tap_login_span, {
      succ = false,
      code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT,
      msg = "Not Support"
    })
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support")
    M.login_cb(channel_result)
    return
  end
  params = params or {}
  E.LOG.debug(TAG, "call login taptap")
  if E.Sysinfo.os() == "android" then
    E.LOG.debug(TAG, "this is android, must call logout before login")
    M.logout()
  end
  UNI.async_call(CHANNEL, ASYNC_GET_ACCESS_TOKEN, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_GET_ACCESS_TOKEN >> " .. tostring(succ))
    if succ then
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      if body and body.accessToken and body.accessToken ~= "" and body.macKey and "" ~= body.macKey then
        ATracer.finish_login_sub_span(M.tap_login_span, {succ = true, body = body})
        local ext = {
          accessToken = body.accessToken,
          macKey = body.macKey
        }
        local userInfo = {
          token = JSON.encode(ext)
        }
        local channelName = CHANNEL
        if E.Sysinfo.os() == "android" then
          channelName = "TAP_LOGIN"
        end
        local channel_result = PROTOCOL.LoginResult.succ(channelName, userInfo, ext)
        E.LOG.debug(TAG, "ASYNC_GET_ACCESS_TOKEN succ ")
        E.LOG.debug(TAG, {channel_result = channel_result})
        if cb then
          cb(channel_result)
        end
      else
        E.LOG.debug(TAG, "ASYNC_GET_ACCESS_TOKEN fail ")
        ATracer.finish_login_sub_span(M.tap_login_span, {
          succ = false,
          code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL,
          msg = "Invalid taptap token"
        })
        local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL, "Invalid taptap token")
        if cb then
          cb(channel_result)
        end
      end
    else
      local code, body = ...
      ATracer.finish_login_sub_span(M.tap_login_span, {
        succ = false,
        code = code,
        body = body
      })
      local channel_result = PROTOCOL.LoginResult.fail(code, (body or {}).error_msg)
      if cb then
        cb(channel_result)
      end
    end
  end)
end

function M.logout()
  E.LOG.debug(TAG, "tap logout")
  UNI.logout(CHANNEL)
end

function M.launch_tap_update()
  local params = {}
  UNI.async_call(CHANNEL, ASYNC_CALL_UPDATE, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "launch tap update >> " .. tostring(succ))
  end)
end

function M.check_if_tap_update()
  local support = check_tap_update_support()
  if not support then
    E.LOG.debug(TAG, "native 不支持TAP更新，请检查是否有打入tap更新插件")
    return false
  end
  local channel_id = E.get_channel()
  E.LOG.debug(TAG, "channel >> " .. tostring(channel_id) .. ", type >> " .. type(channel_id))
  if "998233" ~= channel_id and "998247" ~= channel_id then
    E.LOG.debug(TAG, "非官方渠道或者taptap渠道，不执行tap更新")
    return false
  end
  return true
end

function M.supportAuth()
  local sdk_infos = UNI.get_sdk_infos()
  if sdk_infos and sdk_infos[CHANNEL] then
    if E.Sysinfo.os() == "android" then
      local ret = UNI.sync_call(CHANNEL, ACTION_IS_SUPPORT_AUTH, {})
      E.LOG.debug(TAG, "is_auth_support received ret:")
      E.log(ret)
      return ret and ret.support == true or false
    elseif E.Sysinfo.os() == "windows" then
      do return end
      return M.is_support_channel_sdk, ret and ret.support == true or false, ret, "is_auth_support received ret:"
    end
  end
  return false
end

function M.is_support_channel_sdk()
  if _ejoysdk.os() ~= "windows" then
    return false
  end
  local result = UNI.sync_call(CHANNEL, SYNC_TAPTAP_SUPPORT, {}, nil)
  E.LOG.debug(TAG, "is support taptap cb")
  E.LOG.debug(TAG, {result = result})
  if result and result.value then
    return result.value
  end
  return false
end

return M
