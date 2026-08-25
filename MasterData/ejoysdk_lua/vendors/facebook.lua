local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local OVERSEA_APPLOG = require("ejoysdk_lua.vendors.oversea_applog")
local ATRacer = require("ejoysdk_lua.account.account_tracer")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local VENDOR_NAME = "FB"
local TAG = EM.MODULE.VENDORS.FACEBOOK
local M = Vendor:Inherit(VENDOR_NAME)
local CAST_INIT_WITH_CONFIG = "CAST_INIT_WITH_CONFIG"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local SYNC_IS_CHROME_TABS_SUPPORT = "SYNC_IS_CHROME_TABS_SUPPORT"
local FACEBOOK_CURRENT_USER = E.LazyKeyStore:New("FACEBOOK_CURRENT_USER", false, true, false)
local logout_listener
local is_inited = false

local function login_handler()
end

function M.is_access_token_invalid(server_status, ...)
  local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
  return 406 == server_status or server_status == USER.USER_CENTER_ERROR_CODES.ERR_SERVER_THIRD_PART
end

function M.login_fail(status, _last_login_params, _login_fail_callback)
  if M.is_access_token_invalid(status) and E.Sysinfo.os() == "ios" then
    FACEBOOK_CURRENT_USER:set(nil)
    UNI.login(VENDOR_NAME, {})
    return true
  end
  return false
end

function M.is_support()
  local support = E.Sysinfo.is_app_install("com.facebook.katana") or false
  if not support then
    local ret = UNI.sync_call(VENDOR_NAME, SYNC_IS_CHROME_TABS_SUPPORT, {}, nil)
    support = ret and ret.support or false
  end
  return support
end

local function converTokenStrFromInfo(info)
  local jsonMap = {
    token = info.token,
    authenticationToken = info.authenticationToken,
    facebookAppID = info.facebookAppID
  }
  local jsonStr = JSON.encode(jsonMap)
  return jsonStr
end

function M.login(_ext, cb)
  local facebook_login_span = ATRacer.start_login_sub_span(ATRacer.ACCOUNT_FLOWS_SPANS.FACEBOOK_LOGIN)
  
  function M.login_cb(channel_result)
    ATRacer.finish_login_sub_span(facebook_login_span, channel_result)
    if cb then
      cb(channel_result)
    end
  end
  
  local os = E.Sysinfo.os()
  if "windows" == os then
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support Facebook Login")
    M.login_cb(channel_result)
    return
  end
  if "android" == os then
    if M.is_support() then
      UNI.login(VENDOR_NAME, {})
    else
      local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT
      local channel_result = PROTOCOL.LoginResult.fail(code, "Not Support Facebook Login")
      M.login_cb(channel_result)
    end
  else
    local current_user = FACEBOOK_CURRENT_USER:get()
    E.LOG.debug(TAG, "current_user ==")
    E.LOG.debug(TAG, current_user)
    if current_user and current_user.token then
      E.LOG.debug(TAG, "get facebook current user")
      E.LOG.debug(TAG, current_user)
      local tokenStr = current_user.token
      if current_user.authenticationToken then
        tokenStr = converTokenStrFromInfo(current_user)
      end
      local userInfo = {
        token = tokenStr,
        uid = current_user.uid,
        guest = false
      }
      local ext = {}
      local channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
      M.login_cb(channel_result)
    else
      E.LOG.debug(TAG, "no facebook current user")
      UNI.login(VENDOR_NAME, {})
    end
  end
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
  M.login()
end

function M.logout()
  E.LOG.debug(TAG, "logout called----")
  FACEBOOK_CURRENT_USER:set(nil)
  UNI.logout(VENDOR_NAME)
end

function M.init(opt, cb)
  _ejoysdk.log("facebook init begin")
  if opt.logout_listener then
    logout_listener = opt.logout_listener
    E.LOG.debug(TAG, "init logout_listener is not nil")
  else
    E.LOG.debug(TAG, "init logout_listener is nil, skip set logoutlistener")
  end
  local config = opt.config or {}
  config.enable_ldu = OVERSEA_APPLOG.has_enabled_ldu() == true or false
  UNI.cast(VENDOR_NAME, CAST_INIT_WITH_CONFIG, config)
  if is_inited then
    cb(true)
    return
  end
  is_inited = true
  UNI.register_login_listener(VENDOR_NAME, function(succ, info, _ext_paramas)
    local channel_result
    if succ then
      E.LOG.debug(TAG, "register_login_listener succ, info.token:" .. tostring(info.token))
      local tokenStr = info.token
      local os = E.Sysinfo.os()
      if "ios" == os and _ext_paramas and type(_ext_paramas) == "table" and _ext_paramas.authenticationToken then
        info.authenticationToken = _ext_paramas.authenticationToken
        info.facebookAppID = _ext_paramas.facebookAppID
        tokenStr = converTokenStrFromInfo(info)
      end
      FACEBOOK_CURRENT_USER:set(info)
      E.LOG.debug(TAG, "set current_user info = ")
      E.LOG.debug(TAG, info)
      local userInfo = {
        token = tokenStr,
        uid = info.uid,
        guest = false
      }
      local ext = {}
      channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
    else
      local code = info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local msg = info.msg or "login failed unknown reason"
      channel_result = PROTOCOL.LoginResult.fail(code, msg)
    end
    M.login_cb(channel_result)
  end)
  UNI.register_logout_listener(VENDOR_NAME, function(ext_params)
    logout_listener(ext_params)
  end)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  OVERSEA_APPLOG.register_applog_events(VENDOR_NAME, M)
  cb(true)
end

M.enable_ldu = false

function M.commit_event(event_name, params)
  if M.enable_ldu == true then
    E.LOG.debug(TAG, "facebook commit_event disabled with LDU setting")
    return
  end
  E.LOG.debug(TAG, "facebook commit_event:" .. tostring(event_name))
  params = params or {}
  params.event_name = event_name
  UNI.cast(VENDOR_NAME, CAST_COMMIT_EVENT, params)
end

function M.test_reset_init_state()
  is_inited = false
end

M:is_implemented({
  "ACCOUNT",
  Vendor.ABILITY.STATS
})
return M
