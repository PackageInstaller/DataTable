local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local HISTORY = require("ejoysdk_lua.noone.noone_history")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONFIG = require("ejoysdk_lua.noone.noone_config")
local VENDOR_NAME = "NOONE"
local DEFAULT_SECRET = "EJOYSDK_DEMO"
local PLATFORM_SECRET = DEFAULT_SECRET
local _TAG = EM.MODULE.VENDORS.NOONE
local M = Vendor:Inherit(VENDOR_NAME)
local logout_listener, user_id, auto_login, noone_meta_config
local ERR_CODE_EMPTY_UID = 74002001
local URL_CONFIG = {
  h5_url_base = "https://account.lingxigames.com",
  url_query = "?ver=1.0&df=json&cver=" .. E.get_pkg_info().versions.lua_version .. "&os=" .. E.get_pkg_info().os,
  API = {login = "m#/noone"}
}

local function get_api_url(api)
  local realapi = URL_CONFIG.API[api]
  local api_url = E.HTTP.uri_join(URL_CONFIG.h5_url_base, realapi or api)
  return api_url
end

local function is_empty(str)
  return not str or "" == str or type(str) ~= "string"
end

function M.init(opt, cb)
  if opt.secret then
    PLATFORM_SECRET = opt.secret
  end
  logout_listener = opt.logout_listener
  E.LOG.debug("NOONE", "init---called")
  local last_login_info = HISTORY.get_last_login_info()
  if last_login_info and last_login_info.uid then
    M.set_uid(last_login_info.uid)
  end
  local secret = CONFIG.get_noone_secret()
  if not is_empty(secret) then
    M.set_secret(secret)
  end
  local h5_url_base = CONFIG.get_noone_h5_api_host()
  if not is_empty(h5_url_base) then
    URL_CONFIG.h5_url_base = h5_url_base
  end
  auto_login = CONFIG.get_noone_auto_login()
  HISTORY.init()
  cb(true)
end

local function show_h5_login()
  local url = get_api_url("login")
  E.LOG.debug(_TAG, "h5_show_login, url=" .. (url or "null"))
  local host = E.HTTP.parse(url).host
  E.WebView.open(url, {
    [host] = {
      startupData = {},
      transparent = true
    }
  }, {
    compactMode = true,
    use_fragment = true,
    hide_close_btn = true
  }, nil, function(_value)
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
    if UTILS.STR.is_empty(user_id) then
      local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
      M.login_cb(PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_CANCEL, "取消登录"))
    end
  end)
end

local function get_noone_meta_config()
  if noone_meta_config and next(noone_meta_config) ~= nil then
    return noone_meta_config
  end
  local noone_sdk_meta
  local sdk_infos = E.get_meta_config("sdks")
  for _, sdk_info in ipairs(sdk_infos) do
    local sdk_name = sdk_info.name
    if sdk_name == VENDOR_NAME then
      noone_sdk_meta = sdk_info.meta
      break
    end
  end
  noone_meta_config = noone_sdk_meta or {}
  return noone_meta_config
end

local function exec_login(cb)
  assert(user_id, "please invoke VENDOR_NOONE.set_uid(user_id) before login")
  if PLATFORM_SECRET == DEFAULT_SECRET then
    local _noone_meta = get_noone_meta_config()
    local noone_secret = _noone_meta.secret
    if noone_secret then
      E.LOG.debug(_TAG, "exec_login update with meta config secret:" .. tostring(noone_secret))
      PLATFORM_SECRET = noone_secret
    end
  end
  local md5_token
  if type(_ejoysdk_crypt.md5) == "function" then
    md5_token = _ejoysdk_crypt.md5(user_id .. PLATFORM_SECRET)
  elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
    md5_token = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(user_id .. PLATFORM_SECRET))
  end
  local account_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, {token = md5_token}, {
    token_type = PROTOCOL.TOKEN_TYPE.ACCOUNT,
    channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, {token = md5_token})
  })
  account_result.pid = user_id
  M.login_cb(account_result)
  if cb then
    E.log(user_id)
    HISTORY.update({uid = user_id})
    PROTOCOL.succ_callback(cb, {})
  end
end

function M.h5_get_login_history(cb)
  E.LOG.debug(_TAG, "get_login_history start")
  local history = HISTORY.get_list()
  E.LOG.debug(_TAG, "back to h5, history, succ, history=" .. tostring(JSON.encode(history)))
  PROTOCOL.succ_callback(cb, history)
  return history
end

function M.login(_ext, cb)
  E.LOG.d("demonk", "noone login start")
  M.login_cb = cb
  if is_empty(user_id) or false == auto_login then
    show_h5_login()
    return
  end
  exec_login()
end

function M.h5_exec_login(params, cb)
  E.LOG.debug(_TAG, "h5_exec_login")
  E.log(params)
  if is_empty(params.uid) then
    PROTOCOL.fail_callback(cb, ERR_CODE_EMPTY_UID, "uid is empty")
  else
    M.set_uid(params.uid)
    exec_login(cb)
  end
end

function M.h5_delete_history(uid, cb)
  E.LOG.debug(_TAG, "delete account " .. tostring(uid))
  HISTORY.delete(uid)
  PROTOCOL.succ_callback(cb, {})
end

function M.set_uid(uid)
  user_id = uid
end

function M.set_secret(secret)
  PLATFORM_SECRET = secret
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
  E.LOG.debug(_TAG, "NOONE logout")
  if HISTORY.get_last_login_info() then
    HISTORY.delete_last_login_info()
    M.set_uid(nil)
  end
  logout_listener({})
end

M:is_implemented({"ACCOUNT"})
return M
