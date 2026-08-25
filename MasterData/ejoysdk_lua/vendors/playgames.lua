local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
local AL = require("ejoysdk_lua.account.service.account_login")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local VENDOR_NAME = "PGA_LOGIN"
local TAG = EM.MODULE.VENDORS.PLAYGAMES
local ASYNC_GET_AUTH_CODE = "ASYNC_GET_AUTH_CODE"
local M = Vendor:Inherit(VENDOR_NAME)
local pga_can_auto_login = false
local login_type = VENDOR_NAME
local show_continue_login = false

function M.login(params, cb)
  M.login_cb = cb
  params = params or {}
  login_type = params.vendor or VENDOR_NAME
  UNI.login(VENDOR_NAME)
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
  login_type = (params or {}).vendor or VENDOR_NAME
  UNI.logout(VENDOR_NAME)
end

function M.login_fail(_status, _last_login_params, _fail_cb)
  return false
end

function M.get_auth_code(cb, refresh)
  if not refresh or type(refresh) ~= "boolean" then
    refresh = false
  end
  UNI.async_call(VENDOR_NAME, ASYNC_GET_AUTH_CODE, {refresh = refresh}, nil, cb)
end

function M.update_auth_code(origin_token, cb)
  M.get_auth_code(function(succ, auth_data)
    if succ and auth_data and next(auth_data) and auth_data.auth_code and auth_data.auth_code ~= "" then
      local auth_code = auth_data.auth_code
      local ptoken = JSON.decode(origin_token)
      ptoken.code = auth_code
      cb(JSON.encode(ptoken))
    else
      cb(origin_token)
    end
  end, true)
end

local function init_handler()
  if EV.has_vendor("PGA_LOGIN") then
    E.LOG.debug(TAG, "pgs try get auth code")
    local pga_login = EV.get("PGA_LOGIN") or {}
    if pga_login.get_auth_code then
      pga_login.get_auth_code(function(succ, ...)
        if succ then
          pga_can_auto_login = true
          E.LOG.debug(TAG, "pgs get auth code: true")
        else
          pga_can_auto_login = false
          E.LOG.debug(TAG, "pgs get auth code: false")
        end
      end)
    end
  else
    E.LOG.debug(TAG, "no PGA_LOGIN, pgs should not try get auth code")
  end
end

local function auto_bind_pgs(user_info, login_vendor)
  if VENDOR_NAME == login_vendor then
    return
  end
  M.get_auth_code(function(succ, ...)
    local LANG = require("ejoysdk_lua.lang.util")
    if succ then
      local server_domain = E.CONFIG.get_config(E.CONFIG.KEY.SERVER_DOMAIN):lower()
      local switch = {
        [".sialiagames.com.tw"] = "青鳥",
        [".sialiagamesinc.com.tw"] = "青鳥",
        [".orientalgame.com.tw"] = "東風",
        [".vntth.com"] = "VNTTH",
        [".qookkagames.com"] = "Qookka",
        [".qoolandgames.com"] = "Qooland"
      }
      local login_tips = switch[server_domain] or ""
      if user_info.isPga == true then
        E.Toast.show(string.format(LANG.getString("login_tips", ""), login_tips .. " "), {use_native = true})
      else
        local data = (...)
        if data and data.auth_code and "" ~= data.auth_code then
          AL.bind(VENDOR_NAME, nil, function(bind_result)
            if not bind_result or not bind_result:is_succ() then
              bind_result = bind_result or {}
              local err_code = bind_result.code
              E.LOG.debug(TAG, "bind failed, err_code=" .. tostring(err_code or CONSTANTS.OFFICIAL_ERR_CODES.CODE_BIND_FAIL))
              E.Toast.show(string.format(LANG.getString("login_tips", ""), login_tips .. " "), {use_native = true})
            else
              E.Toast.show(LANG.getString("pgs_auto_bind", "Your account has bound to PGS"), {use_native = true})
            end
          end)
        end
      end
    else
      E.LOG.debug(TAG, "pgs get auth_code failed")
    end
  end)
end

local function acquire_handler(user_info)
  E.LOG.debug(TAG, "playgames acquire_handler -----")
  local last_login_vendor = AUTO_LOGIN.get_last_login()
  if user_info and "OFFICIAL" == user_info.with and last_login_vendor and string.len(last_login_vendor) > 0 then
    auto_bind_pgs(user_info, last_login_vendor)
  end
end

local options = {}

function M.init(opt, cb)
  local vendor_name = (opt.proxy or {}).vendor_name or VENDOR_NAME
  options[vendor_name] = opt
  
  local function register_login_callback(succ, info, _ext_paramas)
    if succ then
      show_continue_login = true
      E.LOG.debug(TAG, "register_login_listener succ, info.token:" .. tostring(info.token))
      local userInfo = {
        token = JSON.encode({
          code = info.token,
          clientid = info.channel_product_code
        }),
        guest = false
      }
      local ext = {}
      local channel_result = PROTOCOL.LoginResult.succ(login_type, userInfo, ext)
      M.login_cb(channel_result)
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
    local option = options[login_type]
    option.logout_listener(ext_params)
  end
  
  UNI.register_login_listener(VENDOR_NAME, register_login_callback)
  UNI.register_logout_listener(VENDOR_NAME, register_logout_callback)
  ET.subscribe(ET.gangplank.INITED, init_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  cb(true)
end

function M.show_continue_login()
  return show_continue_login
end

function M.can_pga_autologin()
  return pga_can_auto_login
end

M:is_implemented({"ACCOUNT"})
return M
