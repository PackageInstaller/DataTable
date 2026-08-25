local E = require("ejoysdk_lua.ejoysdk")
local HTTP = E.HTTP
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local AIRLINE_VENDOR_NAME = "AIRLINE"
local AIRLINE = Vendor:Inherit(AIRLINE_VENDOR_NAME)
AIRLINE.login_cb = nil
local TAG = EM.MODULE.VENDORS.AIRLINE_ACC
local OFFICIAL_QUERY = E.LazyKeyStore:New("OFFICIAL_QUERY", false, true, false)
local CONFIG_KEY_REGION = "region"
local cb_handler_info = {}
local OFFICIAL_CONFIG = {
  host = "hk-account.rhinocerosgames.com",
  url_base = "https://hk-account.rhinocerosgames.com",
  API = {
    getServiceTicket = "apiQookka/client/getServiceTicket",
    login = "m",
    auth = "api/completion",
    upgrade = "m"
  }
}

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

local function cb_handler(succ, token, new_nonce, _new_state, login_type)
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
    E.LOG.debug(TAG, "nonce: " .. tostring(nonce) .. " nonce cb: " .. tostring(new_nonce))
    E.LOG.debug(TAG, " login success, callback to account_login, token = " .. token)
    channel_result = PROTOCOL.LoginResult.succ(AIRLINE_VENDOR_NAME, {token = token}, {thirdparty_type = login_type})
  end
  AIRLINE.login_cb(channel_result)
end

local function on_url(url)
  E.LOG.debug(TAG, " on_url called, url = " .. url)
  local ret = HTTP.parse(url)
  if ret.host == "sdk.ejoy.com" and ret.query then
    local query = ret.query
    if query.access_token and query.nonce and query.state then
      set_official_query(query)
      cb_handler(true, query.access_token, query.nonce, query.state, query.login_type)
    else
      E.LOG.warn(TAG, "query error")
      if query.error then
        E.LOG.error(TAG, query)
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

local function is_type_for_airline(url)
  local ret = HTTP.parse(url)
  E.LOG.debug(TAG, ret)
  if ret.query and ret.query.type then
    local type = ret.query.type
    if "airline" ~= type then
      return false
    end
  end
  return true
end

local function on_login_done(value)
  E.LOG.debug(TAG, "h5 on_login_done---")
  E.LOG.debug(TAG, "value ===")
  E.LOG.debug(TAG, value)
  if not is_type_for_airline(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 airline，直接返回")
    return
  end
  cb_handler_info.webview_opened = false
  on_url(value.args.uri)
end

local function on_webview_close(value)
  if not is_type_for_airline(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 airline，直接返回")
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

local function get_host_url(url)
  local url_obj = HTTP.parse(url)
  return url_obj.host
end

local function update_official_url()
  local gangplank_config = EGC.get_current_cdn_config()
  if not gangplank_config then
    return
  end
  OFFICIAL_CONFIG.url_base = gangplank_config.airline_center or OFFICIAL_CONFIG.url_base
  OFFICIAL_CONFIG.host = get_host_url(OFFICIAL_CONFIG.url_base)
  E.LOG.debug(TAG, "update official airline url: " .. tostring(OFFICIAL_CONFIG.url_base) .. " ,host: " .. tostring(OFFICIAL_CONFIG.host))
end

local function get_service_ticket()
end

function AIRLINE.init(opt, cb)
  AIRLINE.opt = opt
  OFFICIAL_CONFIG.url_base = AIRLINE.opt.url_base or OFFICIAL_CONFIG.url_base
  OFFICIAL_CONFIG.host = get_host_url(OFFICIAL_CONFIG.url_base)
  local global_config = EGC.get_global_cdn_config()
  if global_config then
    update_official_url()
  else
    ET.subscribe(ET.gangplank.GLOBAL_CDN_CONFIG_SUCC, update_official_url)
  end
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. CONFIG_KEY_REGION, update_official_url)
  ET.subscribe("logindone", on_login_done)
  ET.subscribe("webview_close", on_webview_close)
  cb(true)
end

function AIRLINE.can_auto_login()
  local query = get_official_query()
  local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
  local last_vendor = AUTO_LOGIN.get_last_login()
  return nil ~= last_vendor and string.len(last_vendor) > 0 and nil ~= query and "" ~= query and nil ~= query.access_token
end

function AIRLINE.login(_ext, cb)
  AIRLINE.login_cb = cb
  local airline_vendor = AIRLINE.opt.proxy
  local proxy_login_type = airline_vendor.proxy_login_type
  E.LOG.debug(TAG, "AIRLINE.login proxy_login_type:" .. (proxy_login_type or "nil"))
  if "bind" == proxy_login_type then
    E.LOG.debug(TAG, "AIRLINE.login, now proxy_login_type is bind, so directly open airline webview")
    get_service_ticket()
  else
    E.LOG.debug(TAG, "AIRLINE..login, now proxy_login_type is login, check has airline cache")
    if AIRLINE.can_auto_login() then
      local official_query = get_official_query()
      E.LOG.debug(TAG, "AIRLINE.login, now proxy_login_type is login, has cache and then directly return cache token")
      E.LOG.debug(TAG, official_query)
      cb_handler(true, official_query.access_token, official_query.nonce, official_query.state, official_query.login_type)
    else
      E.LOG.debug(TAG, "AIRLINE.login, now proxy_login_type is login, NOT has cache and then open airline webview")
      get_service_ticket()
    end
  end
end

function AIRLINE.open_login_webview(_ticket)
end

function AIRLINE.merge_info(info, pinfo)
  do return AIRLINE.merge_helper, info end
  return AIRLINE.merge_helper, info, pinfo
end

function AIRLINE.simple_token()
  return false
end

function AIRLINE.check_token(_outsource, _info)
  AIRLINE.login()
end

function AIRLINE.logout()
  clear_official_query()
  AIRLINE.opt.logout_listener({})
end

function AIRLINE.bind()
end

function AIRLINE.is_access_token_invalid(server_status, ...)
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

function AIRLINE.login_fail(status, last_login_params, _login_fail_callback)
  E.LOG.warn(TAG, "AIRLINE.login_fail status:" .. (status or "nil"))
  if AIRLINE.is_access_token_invalid(status, last_login_params) then
    E.LOG.debug(TAG, "qookaa access token invalid!!!")
    clear_official_query()
    get_service_ticket()
  end
  return false
end

function AIRLINE.get_api(api)
  local realapi = OFFICIAL_CONFIG.API[api]
  do return HTTP.uri_join, OFFICIAL_CONFIG.url_base end
  return HTTP.uri_join, OFFICIAL_CONFIG.url_base, realapi or api
end

AIRLINE:is_implemented({"ACCOUNT"})

function AIRLINE.upgrade(_cb)
end

return AIRLINE
