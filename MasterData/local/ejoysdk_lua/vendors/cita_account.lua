local E = require("ejoysdk_lua.ejoysdk")
local HTTP = E.HTTP
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local VENDOR_NAME = "CITA_LOGIN"
local CITA = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.CITA_ACC
CITA.login_cb = nil
local CITA_QUERY
local cb_handler_info = {}

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
    E.LOG.debug(TAG, query)
    E.LOG.debug(TAG, "set_official_query now begin set query, access_token:" .. tostring(query.access_token))
    query.region = get_current_region_key()
    CITA_QUERY:set(query)
  else
    E.LOG.warn(TAG, "set_official_query failed, for query is not valid!")
  end
end

local function clear_official_query()
  CITA_QUERY:set(nil)
end

local function get_official_query()
  local curr_region = get_current_region_key()
  local cita_query = CITA_QUERY:get()
  if cita_query and cita_query.region == curr_region then
    E.LOG.debug(TAG, "get_official_query succ, current region has cita cache, region:" .. tostring(curr_region))
    E.LOG.debug(TAG, "get_official_query >>")
    E.LOG.debug(TAG, cita_query)
    return cita_query
  else
    local last_region = "unknown"
    if cita_query then
      last_region = cita_query.region or "unknown"
    end
    E.LOG.warn(TAG, "get_official_query for current region failed, current region NOT has cita cache, current region:" .. tostring(curr_region) .. ", last region:" .. tostring(last_region))
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
  CITA.login_cb(channel_result)
end

local function on_url(url)
  local ret = HTTP.parse(url)
  if ret.host == "sdk.ejoy.com" and ret.query then
    local query = ret.query
    if query.access_token then
      set_official_query(query)
      cb_handler(true, query.access_token, query.nonce, query.state)
    else
      E.LOG.warn(TAG, "on_url fail")
      if query.error then
        E.LOG.debug(TAG, query)
        cb_handler(false, {
          code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_OAUTH_FAILED,
          msg = "ejoy id server: " .. tostring(query.error)
        })
      else
        E.LOG.debug(TAG, "ouath error callback url")
        cb_handler(false, {
          code = CONSTANTS.AIRLINE_ACCOUNT_ERROR_CODES.CODE_OAUTH_ERROR_CALLBACK_URL,
          msg = "ouath error callback url"
        })
      end
    end
  end
end

local function is_type_for_cita(url)
  local ret = HTTP.parse(url)
  return not ret.query or not ret.query.type or ret.query.type == string.lower(VENDOR_NAME)
end

local function on_login_done(value)
  E.LOG.debug(TAG, "h5 on_login_done")
  if not is_type_for_cita(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 cita, 直接返回")
    return
  end
  cb_handler_info.webview_opened = false
  on_url(value.args.uri)
end

local function on_webview_close(value)
  if not is_type_for_cita(value.args.uri) then
    E.LOG.debug(TAG, "type 不是 cita,直接返回")
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

function CITA.init(opt, cb)
  E.LOG.debug(TAG, "init")
  CITA.opt = opt
  CITA_QUERY = E.LazyKeyStore:New("CITA_QUERY", false, true, false)
  ET.subscribe("logindone", on_login_done)
  ET.subscribe("webview_close", on_webview_close)
  cb(true)
end

function CITA.can_auto_login()
  local query = get_official_query()
  local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
  local last_vendor = AUTO_LOGIN.get_last_login()
  return nil ~= last_vendor and string.len(last_vendor) > 0 and nil ~= query and "" ~= query and nil ~= query.access_token
end

function CITA.login(_ext, cb)
  CITA.login_cb = cb
  E.LOG.debug(TAG, "login")
  local cita_vendor = CITA.opt.proxy
  local proxy_login_type = cita_vendor.proxy_login_type
  E.LOG.debug(TAG, "AIRLINE.login proxy_login_type:" .. (proxy_login_type or "nil"))
  if "bind" == proxy_login_type then
    E.LOG.debug(TAG, "AIRLINE.login, now proxy_login_type is bind, so directly open cita webview")
  else
    E.LOG.debug(TAG, "AIRLINE..login, now proxy_login_type is login, check has cita cache")
    if CITA.can_auto_login() then
      local official_query = get_official_query()
      E.LOG.debug(TAG, "AIRLINE.login, now proxy_login_type is login, has cache and then directly return cache token")
      E.LOG.debug(TAG, official_query)
      cb_handler(true, official_query.access_token, official_query.nonce, official_query.state)
    else
      E.LOG.debug(TAG, "AIRLINE.login, now proxy_login_type is login, NOT has cache and then open cita webview")
    end
  end
end

function CITA.merge_info(info, pinfo)
  do return CITA.merge_helper, info end
  return CITA.merge_helper, info, pinfo
end

function CITA.simple_token()
  return false
end

function CITA.check_token(_outsource, _info)
  CITA.login()
end

function CITA.logout()
  clear_official_query()
  CITA.opt.logout_listener({})
end

function CITA.bind()
end

function CITA.is_access_token_invalid(server_status, ...)
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

function CITA.login_fail(status, last_login_params, _login_fail_callback)
  E.LOG.warn(TAG, "CITA.login_fail status:" .. (status or "nil"))
  if CITA.is_access_token_invalid(status, last_login_params) then
    E.LOG.debug(TAG, "cita access token invalid!!!")
    clear_official_query()
  end
  return false
end

CITA:is_implemented({"ACCOUNT"})
return CITA
