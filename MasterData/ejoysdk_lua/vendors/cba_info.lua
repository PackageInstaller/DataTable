local E = require("ejoysdk_lua.ejoysdk")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "CBA"
local TAG = EM.MODULE.VENDORS.CBA_INFO
local M = Vendor:Inherit(VENDOR_NAME)
local retry_config = {retry_request_platform_service_times = 0, max_retry_request_platform_service_times = 3}
local timer_config = {async_action_max_wait_seconds = 5, retry_delay_seconds = 5}
local CBA_OBJECT = {}
local TOP_ERROR_CODE = {GET_CBA_INFO_FAIL = 10000, UPLOAD_PLATFORM_FAIL = 20000}

local function update_cba_object(caid_data, error_code, sub_error_code, sub_error_msg)
  E.LOG.debug(TAG, "start update cba_object")
  CBA_OBJECT.data = CBA_OBJECT.data or {}
  for key, value in pairs(caid_data) do
    CBA_OBJECT.data[key] = value
  end
  if error_code and type(error_code) == "number" then
    CBA_OBJECT.error_code = error_code
  else
    CBA_OBJECT.error_code = nil
  end
  if sub_error_code and type(sub_error_code) == "number" then
    CBA_OBJECT.sub_error_code = sub_error_code
  else
    CBA_OBJECT.sub_error_code = nil
  end
  if sub_error_msg and type(sub_error_msg) == "string" then
    CBA_OBJECT.sub_error_msg = sub_error_msg
  else
    CBA_OBJECT.sub_error_msg = nil
  end
  E.log({after_update_CBA_OBJECT = CBA_OBJECT})
end

local function report_jf()
  CBA_OBJECT.is_priority_high = true
  if CBA_OBJECT.error_code then
    E.LOG.debug(TAG, "report_jf, " .. "action:cba_fail")
    E.LOG.debug(TAG, {report_jf_CBA_OBJECT = CBA_OBJECT})
    ESTAT.stat_action("cba_fail", nil, false, CBA_OBJECT)
  else
    E.LOG.debug(TAG, "report_jf, " .. "action:cba_succ")
    E.LOG.debug(TAG, {report_jf_CBA_OBJECT = CBA_OBJECT})
    ESTAT.stat_action("cba_succ", nil, true, CBA_OBJECT)
  end
end

local function request_platform_service_retry_action(resp_reach, ...)
  local _, code, msg = ...
  E.LOG.debug(TAG, {
    succ = false,
    code = code,
    msg = msg
  })
  if retry_config.retry_request_platform_service_times >= retry_config.max_retry_request_platform_service_times then
    E.LOG.debug(TAG, "upload platform_service, reach max retry times, max retry times:" .. tostring(retry_config.max_retry_request_platform_service_times))
    retry_config.retry_request_platform_service_times = 0
    CBA_OBJECT.error_code = TOP_ERROR_CODE.UPLOAD_PLATFORM_FAIL
    CBA_OBJECT.sub_error_code = code
    CBA_OBJECT.sub_error_msg = msg
    report_jf()
  else
    retry_config.retry_request_platform_service_times = retry_config.retry_request_platform_service_times + 1
    E.LOG.debug(TAG, "retry upload platform_service,current times:" .. tostring(retry_config.retry_request_platform_service_times))
    if resp_reach then
      E.Timer.once(timer_config.retry_delay_seconds, function()
        M.request_platform_service()
      end)
    else
      M.request_platform_service()
    end
  end
end

local function request_platform_service()
  E.LOG.debug(TAG, "start request platform_service")
  local req_platform_resp_reach = false
  local req_platform_timer_reach = false
  
  local function dsp_req_with_timer(logObject, cb)
    local parm = {}
    parm.contentType = 2
    parm.logNum = 1
    parm.logValue = JSON.encode(logObject)
    E.LOG.debug(TAG, {request_platform_service_parm = parm})
    DSP.enable_log_service_fx(true)
    DSP.post("log.collect.ejoysdklog", parm, function(succ, ...)
      if req_platform_timer_reach then
        return
      end
      req_platform_resp_reach = true
      cb(true, succ, ...)
    end, "ejoysdk", "cba")
    E.Timer.once(timer_config.async_action_max_wait_seconds, function()
      if req_platform_resp_reach then
        return
      end
      req_platform_timer_reach = true
      cb(false)
    end)
    local log_service_request
    local _retry_times = 0
    
    function log_service_request()
      DSP.enable_log_service_fx(false)
      DSP.post("log.collect.ejoysdklog", parm, function(_succ, ...)
        E.LOG.debug(TAG, "log.collect.ejoysdklog to ds result:" .. tostring(_succ))
        if not _succ and _retry_times <= 3 then
          _retry_times = _retry_times + 1
          log_service_request()
        end
      end, "ejoysdk", "cba")
    end
    
    log_service_request()
  end
  
  local function http_action(logObject)
    dsp_req_with_timer(logObject, function(resp_reach, ...)
      E.LOG.debug(TAG, "receive platform_service resp, resp_reach:" .. tostring(resp_reach))
      if not resp_reach then
        ESTAT.stat_action("cba_req_platform_timeout", nil, false, nil)
        M.request_platform_service_retry_action(false)
        return
      end
      local succ = (...)
      if succ then
        local _, data = ...
        E.LOG.debug(TAG, {succ = true, data = data})
        retry_config.retry_request_platform_service_times = 0
        report_jf()
      else
        M.request_platform_service_retry_action(true, ...)
      end
    end)
  end
  
  ESTAT.get_jf_format_data("sdk.caid", CBA_OBJECT or {}, function(log)
    local security = require("ejoysdk_lua.vendors.security")
    log.params.secInfo = security.ejoysdk_get_mw()
    E.LOG.debug(TAG, "sdk.startup.server log params:")
    E.log(log)
    http_action(log)
  end)
end

M.request_platform_service_retry_action = request_platform_service_retry_action
M.request_platform_service = request_platform_service

local function is_overseas()
  do return E.CONFIG.get_config end
  return E.CONFIG.get_config, E.CONFIG.KEY.MULTI_REGIONS_ENABLED
end

function M.cba_action()
  if is_overseas() then
    E.LOG.debug(TAG, "is_overseas: true")
    return
  end
  if E.Sysinfo.os() ~= "ios" then
    return
  end
  local cba_info = E.get_cba_tweleve_info()
  if not cba_info then
    E.LOG.debug(TAG, "get cba info fail, native version too low")
    update_cba_object(nil, TOP_ERROR_CODE.GET_CBA_INFO_FAIL)
    report_jf()
    return
  end
  update_cba_object(cba_info)
  request_platform_service()
end

function M.init(_, cb)
  E.LOG.debug(TAG, "cba info vendor init complete")
  M.cba_action()
  cb(true)
end

return M
