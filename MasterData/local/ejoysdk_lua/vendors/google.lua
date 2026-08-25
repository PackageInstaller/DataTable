local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local VENDOR_NAME = "GOOGLE"
local VENDOR_NAME_GOOGLE_PLAY = "GOOGLE_PLAY"
local TAG = EM.MODULE.VENDORS.GOOGLE
local M = Vendor:Inherit(VENDOR_NAME)
local logout_invoke = false
local options = {}

function M.is_access_token_invalid(server_status, ...)
  return 406 == server_status or server_status == USER.USER_CENTER_ERROR_CODES.ERR_SERVER_THIRD_PART
end

local function is_system_time_diff_one_hour()
  local server_time = E.time()
  local os_time = os.time()
  local time_diff = math.abs(server_time - os_time)
  local google_token_expire_time_seconds = 3600
  local is_diff_one_hour = time_diff >= google_token_expire_time_seconds
  if is_diff_one_hour then
    E.LOG.debug(TAG, "is_system_time_diff_one_hour true:" .. tostring(time_diff) .. ", os_time:" .. tostring(os_time))
  else
    E.LOG.debug(TAG, "is_system_time_diff_one_hour false:" .. tostring(time_diff) .. ", os_time:" .. tostring(os_time))
  end
  return is_diff_one_hour
end

function M.login_fail(status, last_login_params, fail_cb)
  local ql_params = {}
  ql_params.os_time = tostring(os.time())
  ql_params.server_time = tostring(E.time())
  ql_params.server_status = tostring(status)
  ql_params.vendor_name = VENDOR_NAME
  ql_params.region = E.CONFIG.get_config("region") or "unknown"
  last_login_params = last_login_params or {}
  local stat_params = {
    outsource = last_login_params.outsource or {},
    info = last_login_params.info or {}
  }
  ql_params.login_params = stat_params
  if E.Sysinfo.os() == "android" and is_system_time_diff_one_hour() and status == USER.USER_CENTER_ERROR_CODES.ERR_SERVER_THIRD_PART then
    ql_params.is_diff_one_hour = "true"
    ESTAT.stat_action("third.login", VENDOR_NAME, false, ql_params)
    if fail_cb then
      fail_cb(CONSTANTS.USER_CENTER_ERROR_CODES.CODE_SYSTEM_TIME_NOT_SYNC, "system time not sync, need check")
      return true
    end
  else
    ql_params.is_diff_one_hour = "false"
    ESTAT.stat_action("third.login", VENDOR_NAME, false, ql_params)
  end
  return false
end

local login_type = VENDOR_NAME

function M.login(params, cb)
  E.LOG.debug(TAG, "google login ---called")
  M.login_cb = cb
  logout_invoke = false
  login_type = (params or {}).vendor or VENDOR_NAME
  if _ejoysdk.os() ~= "windows" then
    UNI.login(VENDOR_NAME, {
      use_games = VENDOR_NAME_GOOGLE_PLAY == login_type,
      install_guide = true
    })
  else
    local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT
    local msg = "Not Support"
    local channel_result = PROTOCOL.LoginResult.fail(code, msg)
    M.login_cb(channel_result)
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

function M.logout(params)
  params = params or {}
  logout_invoke = params.manual or false
  login_type = params.vendor or VENDOR_NAME
  UNI.logout(VENDOR_NAME)
end

function M.can_pay()
  return false
end

function M.pay(_product_id, _count, _order_id, _body)
  E.LOG.error(TAG, "google pay error, should use officialpay instead")
end

function M.product_list()
  return {}
end

local function post_mail_info_to_firebase(gmail)
  if not gmail then
    E.LOG.debug(TAG, "gmail is nil ,no need to post firebase")
    return
  end
  local params = {mail = gmail}
  E.LOG.debug(TAG, "commit mail info to firebase")
  local FIREBASE_CHANNEL = "FIREBASE"
  local FIREBASE_CAST_COMMIT_EMAIL_INFO = "CAST_COMMIT_EMAIL_INFO"
  UNI.cast(FIREBASE_CHANNEL, FIREBASE_CAST_COMMIT_EMAIL_INFO, params)
end

function M.init(opt, cb)
  local vendor_name = (opt.proxy or {}).vendor_name or VENDOR_NAME
  options[vendor_name] = opt
  
  local function register_login_callback(succ, info, _ext_paramas)
    if succ then
      E.LOG.debug(TAG, "register_login_listener succ, info.token:" .. tostring(info.token))
      E.LOG.debug(TAG, "google login success-------_ext_paramas ===")
      E.LOG.debug(TAG, _ext_paramas)
      local userInfo = {
        token = info.token,
        uid = info.user_id,
        guest = false
      }
      local ext = {}
      local channel_result = PROTOCOL.LoginResult.succ(login_type, userInfo, ext)
      M.login_cb(channel_result)
      if E.Sysinfo.os() == "ios" then
        post_mail_info_to_firebase(_ext_paramas and _ext_paramas.email or nil)
      end
    else
      E.LOG.warn(TAG, "register_login_listener failed >>")
      E.LOG.debug(TAG, info)
      local code = info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local msg = info.msg or "login failed unknown reason"
      local channel_result = PROTOCOL.LoginResult.fail(code, msg)
      M.login_cb(channel_result)
    end
  end
  
  local function register_logout_callback(ext_params)
    E.LOG.debug(TAG, "logout_listener >>")
    if not logout_invoke then
      local option = options[login_type]
      option.logout_listener(ext_params)
    end
  end
  
  UNI.register_login_listener(VENDOR_NAME, register_login_callback)
  UNI.register_logout_listener(VENDOR_NAME, register_logout_callback)
  ET.subscribe(ET.gangplank.ACQUIRE_FAILED, function(_fail_info)
    E.LOG.debug(TAG, "google login fail>>")
    M.logout({manual = true})
  end)
  cb(true)
end

M:is_implemented({"ACCOUNT", "PAY"})
return M
