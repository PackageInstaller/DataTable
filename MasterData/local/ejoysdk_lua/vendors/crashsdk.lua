local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local CHANNEL = "CRASH_SDK"
local M = Vendor:Inherit(CHANNEL)
local CAST_INIT_CRASH_SDK = "CAST_INIT_CRASH_SDK"
local CAST_CRASH_SDK_UPDATE_DATA = "CAST_CRASH_SDK_UPDATE_DATA"
local CAST_CREATE_CUSTOM_LOG = "CAST_CREATE_CUSTOM_LOG"
local CAST_ADD_HEADER_INFO = "CAST_ADD_HEADER_INFO"
local CAST_ADD_CACHED_INFO = "CAST_ADD_CACHED_INFO"
local TAG = EM.MODULE.VENDORS.CRASH_SDK
local ffi_supported_os = {weixin = true, douyin = true}
local support_ffi = ffi_supported_os[E.Sysinfo.os()] or false
local ffi_crash_sdk = _ejoysdk.ffi_crash_sdk and _ejoysdk.ffi_crash_sdk() or nil

function M.create_custom_log(log_level, err_msg, stack_trace, stack_hash, extra)
  if "" == stack_hash then
    stack_hash = nil
  end
  if _ejoysdk.os() == "windows" then
    _ejoysdk.error_report("lua", log_level, err_msg, stack_trace, stack_hash, extra)
    return
  end
  local log_params = {
    logType = "lua",
    logLevel = log_level,
    errMsg = err_msg,
    stackTrace = stack_trace,
    stackHash = stack_hash,
    extra = extra
  }
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.createCustomLog(log_params)
  else
    UNI.cast(CHANNEL, CAST_CREATE_CUSTOM_LOG, log_params)
  end
end

function M.create_custom_log_with_checkutf8(log_level, err_msg, stack_trace, stack_hash, extra)
  stack_trace = EU.verify_utf_char(stack_trace)
  err_msg = EU.verify_utf_char(err_msg)
  extra = EU.verify_utf_char(extra)
  M.create_custom_log(log_level, err_msg, stack_trace, stack_hash, extra)
end

function M.add_header_info(key, value)
  assert(type(key) == "string", "key must be string")
  assert(type(value) == "string", "value must be string")
  local header = {key = key, value = value}
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.addHeaderInfo(header)
  else
    UNI.cast(CHANNEL, CAST_ADD_HEADER_INFO, header)
  end
end

function M.add_cached_info(key, value)
  assert(type(key) == "string", "key must be string")
  assert(type(value) == "string", "value must be string")
  local param = {key = key, value = value}
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.addCachedInfo(param)
  else
    UNI.cast(CHANNEL, CAST_ADD_CACHED_INFO, param)
  end
end

local function init_crash_sdk()
  local ch = E.get_channel()
  local game_id = E.get_game_id()
  local init_param = {channel_id = ch, game_id = game_id}
  if support_ffi and ffi_crash_sdk then
    ffi_crash_sdk.luaCrashInit(init_param)
  else
    UNI.cast(CHANNEL, CAST_INIT_CRASH_SDK, init_param)
  end
end

local function update_data(params)
  if support_ffi and ffi_crash_sdk then
    for key, value in pairs(params) do
      ffi_crash_sdk.updateHeaderInfo({key = key, value = value})
    end
  else
    UNI.cast(CHANNEL, CAST_CRASH_SDK_UPDATE_DATA, params)
  end
end

local function login_handler(user_info)
  local params = {
    uid = user_info.uid
  }
  update_data(params)
end

local function gangplank_logout_handler()
  local params = {uid = ""}
  update_data(params)
end

local function gangplank_exit_handler()
  M.exit()
end

function M.exit()
  local params = {uid = ""}
  update_data(params)
  E.LOG.debug(TAG, "接收到gangplank exit事件，退出崩溃SDK")
  UNI.exit(CHANNEL)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "crashsdk start init!")
  init_crash_sdk()
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  cb(true)
end

return M
