local E = require("ejoysdk_lua.ejoysdk")
local HTTP = E.HTTP
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local SHARE_VENDOR_NAME = "TWITTER"
local UNI = require("ejoysdk_lua.vendors.unisdk")
local CAST_INIT = "CAST_INIT"
local VENDOR_NAME = "TWITTER_LOGIN"
local TWITTER = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.TWITTER
local OFFICIAL_QUERY = E.LazyKeyStore:New("OFFICIAL_QUERY_TWITTER", false, true, false)
local cb_handler_info = {}
local android_package_name = "com.twitter.android"

local function get_current_region_key()
  local curr_region = E.CONFIG.get_config("region")
  if curr_region then
    curr_region = curr_region:lower()
  else
    curr_region = "unknown"
  end
  return curr_region
end

local function set_official_query(query)
  if query and query.access_token and query.nonce and query.state then
    E.LOG.debug(TAG, "set_official_query now begin set query, access_token:" .. tostring(query.access_token))
    query.region = get_current_region_key()
    E.LOG.debug(TAG, "set_official_query >>")
    E.LOG.debug(TAG, query)
    OFFICIAL_QUERY:set(query)
  else
    E.LOG.warn(TAG, "set_official_query failed, for query is not valid!")
  end
end

local function clear_official_query()
  OFFICIAL_QUERY:set(nil)
end

local function get_official_query()
  local curr_region = get_current_region_key()
  local official_query = OFFICIAL_QUERY:get()
  if official_query and official_query.region == curr_region then
    E.LOG.debug(TAG, "get_official_query succ, current region has airline cache, region:" .. tostring(curr_region))
    E.LOG.debug(TAG, "get_official_query >>")
    E.LOG.debug(TAG, official_query)
    return official_query
  else
    local last_region = "unknown"
    if official_query then
      last_region = official_query.region or "unknown"
    end
    E.LOG.warn(TAG, "get_official_query for current region failed, current region NOT has airline cache, current region:" .. tostring(curr_region) .. ", last region:" .. tostring(last_region))
    return nil
  end
end

local function cb_handler(succ, token, new_nonce, _new_state)
  local nonce = cb_handler_info.nonce
  local channel_result
  if not succ then
    local error_info = token
    local code = error_info.code
    local msg = error_info.msg
    channel_result = PROTOCOL.LoginResult.fail(code, msg)
  elseif nonce and new_nonce ~= nonce then
    E.LOG.debug(TAG, "nonce: " .. tostring(nonce) .. " nonce cb: " .. tostring(new_nonce))
    local code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_NONCE_ERROR
    local msg = "nonce error"
    channel_result = PROTOCOL.LoginResult.fail(code, msg)
  else
    channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, {token = token}, {})
  end
  TWITTER.login_cb(channel_result)
end

local function on_url(url)
  local ret = HTTP.parse(url)
  if ret.host == "sdk.ejoy.com" and ret.query then
    local query = ret.query
    if query.access_token and query.nonce and query.state then
      set_official_query(query)
      cb_handler(true, query.access_token, query.nonce, query.state)
    else
      E.LOG.debug(TAG, "on_url error")
      if query.error then
        E.LOG.debug(TAG, query)
        cb_handler(false, {
          code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_OAUTH_FAILED,
          msg = "ejoy id server: " .. tostring(query.error)
        })
      else
        cb_handler(false, {
          code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_OAUTH_ERROR_CALLBACK_URL,
          msg = "ouath error callback url"
        })
      end
    end
  end
end

local function is_type_for_twitter(url)
  local ret = HTTP.parse(url)
  E.LOG.debug(TAG, "parse url >>")
  E.LOG.debug(TAG, ret)
  if ret.query and ret.query.type then
    local type = ret.query.type
    if "twitter" ~= type then
      return false
    end
  end
  return true
end

local function on_login_done(value)
  E.LOG.debug(TAG, "h5 on_login_done---")
  if not is_type_for_twitter(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 twitter，直接返回")
    return
  end
  cb_handler_info.webview_opened = false
  on_url(value.args.uri)
end

local function on_webview_close(value)
  if not is_type_for_twitter(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 twitter，直接返回")
    return
  end
  if cb_handler_info.webview_opened then
    cb_handler_info.webview_opened = false
    cb_handler(false, {
      code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_USER_CANCEL,
      msg = "user canceled"
    })
  end
end

local function get_service_ticket()
end

function TWITTER.init(opt, cb)
  TWITTER.opt = opt
  ET.subscribe("logindone", on_login_done)
  ET.subscribe("webview_close", on_webview_close)
  UNI.cast(SHARE_VENDOR_NAME, CAST_INIT, opt.config or {})
  cb(true)
end

function TWITTER.login(_ext, cb)
  TWITTER.login_cb = cb
  local twitter_vendor = TWITTER.opt.proxy
  local proxy_login_type = twitter_vendor.proxy_login_type
  E.LOG.debug(TAG, "TWITTER.login proxy_login_type:" .. (proxy_login_type or "nil"))
  if "bind" == proxy_login_type then
    E.LOG.debug(TAG, "TWITTER.login, now proxy_login_type is bind, so directly open TWITTER webview")
  else
    E.LOG.debug(TAG, "TWITTER..login, now proxy_login_type is login, check has TWITTER cache")
    local official_query = get_official_query()
    if official_query then
      E.LOG.debug(TAG, "TWITTER.login, now proxy_login_type is login, has cache and then directly return cache token >>")
      E.LOG.debug(TAG, official_query)
      cb_handler(true, official_query.access_token, official_query.nonce, official_query.state)
    else
      E.LOG.debug(TAG, "TWITTER.login, now proxy_login_type is login, NOT has cache and then open TWITTER webview")
    end
  end
end

function TWITTER.can_auto_login()
  local query = get_official_query()
  return nil ~= query and "" ~= query
end

function TWITTER.merge_info(info, pinfo)
  do return TWITTER.merge_helper, info end
  return TWITTER.merge_helper, info, pinfo
end

function TWITTER.simple_token()
  return false
end

function TWITTER.check_token(_outsource, _info)
  TWITTER.login()
end

function TWITTER.logout()
  clear_official_query()
  TWITTER.opt.logout_listener({})
end

function TWITTER.bind()
end

function TWITTER.is_access_token_invalid(server_status, ...)
  if 406 == server_status then
    local params = (...)
    local channel_error = params.body.channel_error
    if channel_error and channel_error.code and channel_error.code == USER.USER_CENTER_ERROR_CODES.ERR_ACCOUNT_TOKEN_INVALID then
      return true
    end
  end
  if server_status == USER.USER_CENTER_ERROR_CODES.ERR_SERVER_THIRD_PART or server_status == USER.USER_CENTER_ERROR_CODES.ERR_THIRD_PART_TOKEN_FAILED then
    return true
  end
  return false
end

function TWITTER.login_fail(status, last_login_params, _login_fail_callback)
  E.LOG.warn(TAG, "TWITTER.login_fail status:" .. (status or "nil"))
  if TWITTER.is_access_token_invalid(status, last_login_params) then
    E.LOG.debug(TAG, "qookaa access token invalid!!!")
    clear_official_query()
    get_service_ticket()
    return true
  end
  return false
end

function TWITTER.is_share_support()
  if E.Sysinfo.os() == "android" then
    do return E.Sysinfo.is_app_install end
    return E.Sysinfo.is_app_install, android_package_name
  elseif E.Sysinfo.os() == "ios" then
    do return E.Sysinfo.can_open_url end
    return E.Sysinfo.can_open_url, "twitter://"
  else
    return false
  end
end

function TWITTER.share(param, _chunk_data, cb)
  E.LOG.debug(TAG, "Twitter share >>")
  E.LOG.debug(TAG, param)
  local SOCIAL = require("ejoysdk_lua.social.ejoysdk_social")
  param.ios_white_list = {SHARE_VENDOR_NAME}
  param.package_name = android_package_name
  local activity_name = "com.twitter.composer.ComposerActivity"
  if param.platform == SOCIAL.SHARE_PLATFORM.twitter_share_timeline then
    activity_name = "com.twitter.app.dm.DMActivity"
  end
  if E.Sysinfo.can_resolve_activity(android_package_name, activity_name) then
    param.package_activity_name = activity_name
  end
  SOCIAL.share(SOCIAL.SHARE_PLATFORM.system_share, param, cb)
end

TWITTER:is_implemented({"ACCOUNT", "SHARE"})
return TWITTER
