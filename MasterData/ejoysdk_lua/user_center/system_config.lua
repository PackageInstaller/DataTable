local E = require("ejoysdk_lua.ejoysdk")
local API = require("ejoysdk_lua.user_center.usercenter_api")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local has_requested = false
local system_config
local TAG = "SYSTEM_CONFIG"
local cb_data = {
  si = "",
  check_time = "",
  config_data = nil
}
local SYSTEM_CONFIG = E.LazyKeyStore:New("SYSTEM_CONFIG_FULL", false, true, false)
local CONFIG_CHECK_TIME = E.LazyKeyStore:New("CONFIG_CHECK_TIME", false, false, false)
local USERCENTER_SI = E.LazyKeyStore:New("si")

local function parse_config(config_data, cb)
  if not config_data then
    E.LOG.e(TAG, "config data error")
    cb(false, -1, "system config error")
    return
  end
  local config_check_time = CONFIG_CHECK_TIME:get()
  local client_config = config_data.clientConfig
  if client_config and next(client_config) ~= nil then
    SYSTEM_CONFIG:set(config_data)
    E.LOG.debug(TAG, "init_with_system_config receive config from server side")
  else
    config_data = SYSTEM_CONFIG:get()
    if not config_data then
      cb(false, -1, "system config cache error")
      return
    end
    client_config = (config_data or {}).clientConfig
    E.LOG.debug(TAG, "init_with_system_config from local SP cache")
  end
  system_config = client_config
  if config_data.configCheckTime then
    config_check_time = config_data.configCheckTime
    CONFIG_CHECK_TIME:set(config_check_time)
  end
  local si = USERCENTER_SI:get()
  if config_data.si and config_data.si ~= "" then
    si = config_data.si
    USERCENTER_SI:set(si)
    E.LOG.debug(TAG, "init_with_system_config udpate si:" .. tostring(si))
  end
  if si and config_check_time and config_data then
    E.LOG.debug(TAG, "si, config_check_time, config_data 三个都有值，可以正常回调成功")
    cb(true, si, config_check_time, config_data)
  else
    E.LOG.error(TAG, "si, config_check_time, config_data 三个数据中有缺失的数据，回调失败")
    local stat_param = {
      si = si,
      config_check_time = config_check_time,
      config_data = config_data
    }
    local code = CONSTANTS.USER_CENTER_ERROR_CODES.CODE_SYSTEM_CONFIG_PARSE_DATA_EMPTY
    local msg = "parse_config data wrong, three data has some data is empty"
    local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
    QL.commit_action_fail_main("system_config_parse_config", nil, code, msg, stat_param)
    has_requested = false
    cb(false, code, msg)
  end
end

local function request_config(config_check_time, cb)
  cb = cb or function()
  end
  if true == has_requested then
    cb(true, cb_data.si, cb_data.check_time, cb_data.client_config)
    return
  end
  E.LOG.d(TAG, "usercenter_system_config_check, config_check_time=" .. tostring(config_check_time))
  API.usercenter_system_config_check(config_check_time, function(succ2, ...)
    if true == succ2 then
      E.LOG.d(TAG, "usercenter_system_config_check succ")
      local config_data = (...)
      if config_data then
        parse_config(config_data, function(succ, ...)
          has_requested = succ
          cb(succ, ...)
        end)
      else
        E.LOG.warn(TAG, "usercenter_system_config_check failed, data is empty:")
        cb(false, CONSTANTS.USER_CENTER_ERROR_CODES.CODE_SYSTEM_CONFIG_DATA_EMPTY, "system config response data is empty")
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "usercenter_system_config_check failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, ...)
    end
  end)
end

function M.request_system_config(cb)
  local config_check_time = CONFIG_CHECK_TIME:get()
  request_config(config_check_time, cb)
end

function M.init(config_data, cb)
  local local_system_config = config_data or SYSTEM_CONFIG:get()
  
  local function parse_result_callback(succ, ...)
    if true == succ then
      local si, check_time, client_config = ...
      cb_data.si = si
      cb_data.check_time = check_time
      cb_data.client_config = client_config
    end
    cb(succ, ...)
  end
  
  if local_system_config and next(local_system_config) ~= nil then
    E.LOG.debug(TAG, "local system config >> ")
    E.LOG.debug(TAG, local_system_config)
    parse_config(local_system_config, function(succ, ...)
      if true == succ then
        parse_result_callback(succ, ...)
      else
        E.LOG.d(TAG, "sync request full")
        request_config("", parse_result_callback)
      end
    end)
  else
    E.LOG.d(TAG, "sync request")
    request_config("", parse_result_callback)
  end
end

function M.get(key)
  local ret
  if system_config and key and type(key) == "string" then
    ret = system_config[key]
  end
  return ret
end

function M.get_si()
  do return USERCENTER_SI.get end
  return USERCENTER_SI.get, USERCENTER_SI
end

return M
