local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UP = require("ejoysdk_lua.user_center.usercenter_protocol")
local ALIGAMES_DEVICE_ID = require("ejoysdk_lua.device_id.aligames_device_id")
local DEVICE_ID = require("ejoysdk_lua.device_id.ejoysdk_device_id")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = "white_brand"
local VENDOR_NAME = "ALIGAMES_WHITE_BRAND"
local M = Vendor:Inherit(VENDOR_NAME)
local DEFAULT_ACCOUNT_URL_BASE = "https://magic-account-api.flysdk.cn"
local WHITE_BRAND_SI_SP = E.LazyKeyStore:New("WHITE_BRAND_GUEST_ID_SP", false, false, true)
local TOKEN_RISK_DIALOG_SHOWED = E.LazyKeyStore:New("ALIGAMES_TOKEN_RISK_DIALOG_SHOWED")
local config = {}

local function post_with_protocol(api, params, cb)
  UP.post(api, params, function(succ, ...)
    cb(succ, ...)
  end)
end

function M.check_token(_outsource, _info)
  M.login()
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.login()
end

function M.exec_login(cb)
  local function login_agst_handler(agst_token)
    local params = {agstToken = agst_token}
    
    E.LOG.debug(TAG, "white brand exec_login beign:" .. tostring(agst_token))
    post_with_protocol(UP.SERVICE.GUEST_LOGIN, params, function(succ, ...)
      if succ then
        local data = (...)
        if data then
          local airlineToken = data.airlineToken
          cb(true, airlineToken, data)
        else
          E.LOG.warn(TAG, "response body data is nil")
          cb(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_RESP_BODY_INVALID, "body is empty")
        end
      else
        local code, msg, data = ...
        E.LOG.warn(TAG, "exec_login failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, code, msg, data)
      end
    end)
  end
  
  DEVICE_ID.get_token(function(device_token)
    _ejoysdk.log("get_token callback")
    E.LOG.debug(TAG, "get_token callback")
    local has_risk = DEVICE_ID.current_token_has_risk()
    if has_risk then
      E.LOG.debug(TAG, "has risk")
      local showed = TOKEN_RISK_DIALOG_SHOWED:get()
      if "true" ~= showed then
        E.Modal.alert("温馨提示", "因部分系统数据权限限制，卸载游戏app或清除数据，会导致您的游戏数据丢失。", function()
          E.LOG.debug(TAG, "risk dialog dismiss")
          login_agst_handler(device_token)
          TOKEN_RISK_DIALOG_SHOWED:set("true")
        end)
      else
        E.LOG.debug(TAG, "has risk, and already showed alert, directly exec login")
        login_agst_handler(device_token)
      end
    else
      E.LOG.debug(TAG, "not has risk")
      login_agst_handler(device_token)
    end
  end)
end

function M.exec_logout(cb)
  E.LOG.debug(TAG, "logout start")
  if cb then
    cb(true, {})
  end
  E.LOG.debug(TAG, "logout end")
end

function M.logout()
end

local function init_config()
  E.LOG.debug(TAG, "init_config start")
  config = E.CONFIG.get_vendor_config(VENDOR_NAME) or {}
  E.LOG.debug(TAG, "init_config end")
end

local function init_usercenter_protocol()
  local api_url_base = config.api_url_base
  if not api_url_base or "" == api_url_base then
    api_url_base = DEFAULT_ACCOUNT_URL_BASE
  end
  UP.set_url_base_with_type(UP.SERVICE_TYPE.ACCOUNT_CENTER, api_url_base)
end

local function update_si(si)
  ALIGAMES_DEVICE_ID.set_si(si)
  UP.set_si(si)
end

local function init_si(cb)
  local si_sp = WHITE_BRAND_SI_SP:get()
  if si_sp and "" ~= si_sp then
    E.LOG.debug(TAG, "init si from sp succ:" .. tostring(si_sp))
    update_si(si_sp)
    cb(true)
    return
  end
  post_with_protocol(UP.SERVICE.SYS_DEVICE_INIT, {}, function(succ, ...)
    if succ then
      local data = (...)
      if data and data.si and data.si ~= "" then
        local si = data.si
        WHITE_BRAND_SI_SP:set(si)
        update_si(si)
        cb(true)
      else
        E.LOG.warn(TAG, "init_si failed, response data si is nil")
        cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_GUEST_SI_EMPTY, "si is empty")
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "init_si failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.init(_opt, cb)
  init_config()
  init_usercenter_protocol()
  E.LOG.debug(TAG, "ios and windows need request si")
  init_si(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "check si succ")
    else
      E.LOG.warn(TAG, "check si failed")
    end
    cb(succ, ...)
  end)
end

M:is_implemented({"ACCOUNT"})
return M
