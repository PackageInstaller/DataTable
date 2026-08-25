local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local VENDOR_NAME = "APPLE_LOGIN"
local TAG = EM.MODULE.VENDORS.APPLE_LOGIN
local M = Vendor:Inherit(VENDOR_NAME)
M.login_cb = nil
local SYNC_IS_PLATFORM_SUPPORT = "SYNC_IS_PLATFORM_SUPPORT"
local APPLE_CURRENT_USER = E.LazyKeyStore:New("APPLE_CURRENT_USER", false, true, false)
local ptoken_expiry_duration = 86400
local ptoken_safe_diff = 120
local logout_listener
local k_login_auto_flag = false

local function login_handler()
end

function M.login_fail(_status, _last_login_params, _login_fail_callback)
  if E.Sysinfo.os() == "ios" then
    APPLE_CURRENT_USER:set(nil)
    if k_login_auto_flag then
      E.log("Apple 登录token自动登录失败，进行重试+++")
      k_login_auto_flag = false
      UNI.login(VENDOR_NAME, {})
      return true
    end
  end
  return false
end

local function exe_apple_login_auth()
  k_login_auto_flag = false
  E.LOG.debug(TAG, "no Apple_Login current user")
  UNI.login(VENDOR_NAME, {})
end

function M.login(_ext, cb)
  if E.Sysinfo.os() ~= "ios" then
    E.LOG.debug(TAG, "sign with Apple only support for iOS")
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support", {})
    cb(channel_result)
    return
  end
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_IS_PLATFORM_SUPPORT, {}, nil)
  local is_support = ret and ret.support or false
  if not is_support then
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Only Support iOS 13.0 or later system", {})
    cb(channel_result)
    return
  end
  M.login_cb = cb
  local current_user = APPLE_CURRENT_USER:get()
  if not current_user or not current_user.ptoken then
    E.LOG.debug(TAG, "ptoken miss")
    exe_apple_login_auth()
    return
  end
  local ptoken = JSON.safe_decode(current_user.ptoken)
  if not ptoken or not ptoken.userId then
    E.LOG.debug(TAG, "ptoken userId miss")
    exe_apple_login_auth()
    return
  end
  if not current_user.ptoken_fetch_time or E.time() - current_user.ptoken_fetch_time >= ptoken_expiry_duration - ptoken_safe_diff then
    E.LOG.debug(TAG, "ptoken_fetch_time invalid, ptoken_fetch_time=" .. tostring(current_user.ptoken_fetch_time))
    exe_apple_login_auth()
    return
  end
  k_login_auto_flag = true
  E.LOG.debug(TAG, "get Apple_Login current user, auto login--------")
  E.log(current_user)
  local ext = {}
  local userInfo = {
    token = current_user.ptoken,
    uid = current_user.uid,
    guest = false
  }
  local channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
  M.login_cb(channel_result)
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
  APPLE_CURRENT_USER:set(nil)
  UNI.logout(VENDOR_NAME)
end

function M.init(opt, cb)
  logout_listener = opt.logout_listener
  UNI.register_login_listener(VENDOR_NAME, function(succ, info, ext_paramas)
    local channel_result
    if succ then
      E.LOG.debug("Apple_Login", "register_login_listener succ")
      local jsonTable = {
        userId = ext_paramas.userId,
        identityToken = ext_paramas.identityToken,
        authorizationCode = ext_paramas.authorizationCode,
        fullName = ext_paramas.fullName,
        email = ext_paramas.email,
        realNameStatus = ext_paramas.realNameStatus,
        bundleID = ext_paramas.bundleID
      }
      local jsonStr = JSON.encode(jsonTable)
      info.ptoken = jsonStr
      info.ptoken_fetch_time = E.time()
      APPLE_CURRENT_USER:set(info)
      local userInfo = {
        token = jsonStr,
        uid = info.uid,
        guest = false
      }
      channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, {})
    else
      E.LOG.debug(TAG, "Apple_Login failed, info = ")
      E.LOG.debug(TAG, info)
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
  cb(true)
end

M:is_implemented({"ACCOUNT"})
return M
