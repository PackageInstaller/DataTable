local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "ASA"
local TAG = EM.MODULE.VENDORS.ASA_INFO
local M = Vendor:Inherit(VENDOR_NAME)
local retry_config = {
  retry_call_native_times = 0,
  max_retry_call_native_times = 3,
  retry_request_apple_service_times = 0,
  max_retry_request_apple_service_times = 0,
  retry_request_platform_service_times = 0,
  max_retry_request_platform_service_times = 3
}
local timer_config = {async_action_max_wait_seconds = 5, retry_delay_seconds = 5}
local apple_service_url = "https://api-adservices.apple.com/api/v1/"
local needMockAttributionValue = false
local mockAttributionValue = false
local ASA_OBJECT = {}
local TOP_ERROR_CODE = {
  TOKEN = 10000,
  ASA_INFO_HIGH = 10001,
  ASA_INFO_LOW = 20000,
  LESS_IOS_10 = 30000,
  UPLOAD_PLATFORM_FAIL = 40000
}

local function update_asa_object(asa_token, asa_info, error_code, sub_error_code, sub_error_msg)
  E.LOG.debug(TAG, "start update asa_object")
  ASA_OBJECT.data = ASA_OBJECT.data or {}
  if asa_token and type(asa_token) == "string" and 0 ~= #asa_token then
    ASA_OBJECT.data.asaToken = asa_token
  else
    ASA_OBJECT.data.asaToken = nil
  end
  if asa_info and type(asa_info) == "table" then
    ASA_OBJECT.data.asaInfo = asa_info
  else
    ASA_OBJECT.data.asaInfo = nil
  end
  if error_code and type(error_code) == "number" then
    ASA_OBJECT.error_code = error_code
  else
    ASA_OBJECT.error_code = nil
  end
  if sub_error_code and type(sub_error_code) == "number" then
    ASA_OBJECT.sub_error_code = sub_error_code
  else
    ASA_OBJECT.sub_error_code = nil
  end
  if sub_error_msg and type(sub_error_msg) == "string" then
    ASA_OBJECT.sub_error_msg = sub_error_msg
  else
    ASA_OBJECT.sub_error_msg = nil
  end
  E.LOG.debug(TAG, {after_update_ASA_OBJECT = ASA_OBJECT})
end

local function report_jf()
  ASA_OBJECT.is_priority_high = true
  if ASA_OBJECT.error_code then
    E.LOG.warn(TAG, "report_jf, " .. "action:asa_fail")
    E.LOG.debug(TAG, {report_jf_ASA_OBJECT = ASA_OBJECT})
    ESTAT.stat_action("asa_fail", nil, false, ASA_OBJECT)
  else
    E.LOG.debug(TAG, "report_jf, " .. "action:asa_succ")
    E.LOG.debug(TAG, {report_jf_ASA_OBJECT = ASA_OBJECT})
    ESTAT.stat_action("asa_succ", nil, true, ASA_OBJECT)
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
    ASA_OBJECT.error_code = TOP_ERROR_CODE.UPLOAD_PLATFORM_FAIL
    ASA_OBJECT.sub_error_code = code
    ASA_OBJECT.sub_error_msg = msg
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
    end, "ejoysdk")
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
      end, "ejoysdk")
    end
    
    log_service_request()
  end
  
  local function real_action(logObject)
    dsp_req_with_timer(logObject, function(resp_reach, ...)
      E.LOG.debug(TAG, "receive platform_service resp, resp_reach:" .. tostring(resp_reach))
      if not resp_reach then
        ESTAT.stat_action("asa_req_platform_timeout", nil, false, nil)
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
  
  if ASA_OBJECT.error_code then
    ESTAT.get_jf_format_data("sdk.asa.fail", ASA_OBJECT or {}, function(log)
      real_action(log)
    end)
  else
    ESTAT.get_jf_format_data("sdk.asa.succ", ASA_OBJECT or {}, function(log)
      real_action(log)
    end)
  end
end

M.request_platform_service_retry_action = request_platform_service_retry_action
M.request_platform_service = request_platform_service

local function request_apple_service_retry_action(token, resp)
  if retry_config.retry_request_apple_service_times >= retry_config.max_retry_request_apple_service_times then
    local msg
    if resp and resp.status then
      msg = "apple service fail, status:" .. tostring(resp.status) .. ", reach max retry times, max retry times:" .. tostring(retry_config.max_retry_request_apple_service_times)
    else
      msg = "apple service fail" .. ", reach max retry times, max retry times:" .. tostring(retry_config.max_retry_request_apple_service_times)
    end
    E.LOG.debug(TAG, msg)
    retry_config.retry_request_apple_service_times = 0
    local sub_error_code
    if resp and resp.status then
      sub_error_code = resp.status
    end
    update_asa_object(token, nil, TOP_ERROR_CODE.ASA_INFO_HIGH, sub_error_code, nil)
    report_jf()
    request_platform_service()
  else
    retry_config.retry_request_apple_service_times = retry_config.retry_request_apple_service_times + 1
    if resp then
      E.LOG.debug(TAG, "retry apple service, status:" .. tostring(resp.status) .. ", current retry times:" .. tostring(retry_config.retry_request_apple_service_times))
      E.Timer.once(timer_config.retry_delay_seconds, function()
        M.request_apple_service(token)
      end)
    else
      E.LOG.debug(TAG, "retry apple service,because time out, current retry times:" .. tostring(retry_config.retry_request_apple_service_times))
      M.request_apple_service(token)
    end
  end
end

local function request_apple_service(token)
  E.LOG.debug(TAG, "start request apple service")
  local req_apple_resp_reach = false
  local req_apple_timer_reach = false
  
  local function req_with_timer(cb)
    local headers = {
      acceptable = E.HTTP.CT_JSON,
      trace = true
    }
    E.LOG.debug(TAG, "req_token:" .. token)
    E.HTTP.post(apple_service_url, headers, "text/plain", token, function(resp)
      if req_apple_timer_reach then
        return
      end
      req_apple_resp_reach = true
      cb(true, resp)
    end)
    E.Timer.once(timer_config.async_action_max_wait_seconds, function()
      if req_apple_resp_reach then
        return
      end
      req_apple_timer_reach = true
      cb(false)
    end)
  end
  
  req_with_timer(function(resp_reach, resp)
    E.LOG.debug(TAG, "end request apple service, resp_reach:" .. tostring(resp_reach))
    if not resp_reach then
      ESTAT.stat_action("asa_req_apple_timeout", nil, false, nil)
      M.request_apple_service_retry_action(token, nil)
      return
    end
    if resp.status == 200 then
      if needMockAttributionValue then
        if resp.body then
          E.LOG.debug(TAG, "mock attribution, old_value:" .. tostring(resp.body.attribution) .. ", new_value:" .. tostring(mockAttributionValue))
          resp.body.attribution = mockAttributionValue
        end
      else
        E.LOG.debug(TAG, "no mock attribution, current_value:" .. tostring(resp.body.attribution))
      end
      retry_config.retry_request_apple_service_times = 0
      update_asa_object(token, resp.body or {}, nil, nil, nil)
      request_platform_service()
    elseif resp.status == 404 or resp.status == 500 then
      M.request_apple_service_retry_action(token, resp)
    else
      retry_config.retry_request_apple_service_times = 0
      update_asa_object(token, nil, TOP_ERROR_CODE.ASA_INFO_HIGH, resp.status, nil)
      request_platform_service()
    end
  end)
end

M.request_apple_service_retry_action = request_apple_service_retry_action
M.request_apple_service = request_apple_service

local function call_native_retry_action(resp)
  if retry_config.retry_call_native_times >= retry_config.max_retry_call_native_times then
    E.LOG.debug(TAG, "call native reach max retry times, max retry times:" .. tostring(retry_config.max_retry_call_native_times))
    retry_config.retry_call_native_times = 0
    if resp then
      if resp.type and type(resp.type) == "string" then
        if resp.type == "asaToken" then
          update_asa_object(nil, nil, TOP_ERROR_CODE.TOKEN, resp.errorCode, resp.errorMsg)
        elseif resp.type == "asaInfo" then
          update_asa_object(nil, nil, TOP_ERROR_CODE.ASA_INFO_LOW, resp.errorCode, resp.errorMsg)
        end
      end
    else
      update_asa_object(nil, nil, TOP_ERROR_CODE.ASA_INFO_LOW, nil, nil)
    end
    request_platform_service()
  else
    retry_config.retry_call_native_times = retry_config.retry_call_native_times + 1
    E.LOG.debug(TAG, "retry call native, current times:" .. tostring(retry_config.retry_call_native_times))
    if resp then
      E.Timer.once(timer_config.retry_delay_seconds, function()
        M.call_native()
      end)
    else
      M.call_native()
    end
  end
end

local function call_native()
  E.LOG.debug(TAG, "start call native")
  local call_native_resp_reach = false
  local call_native_timer_reach = false
  
  local function call_with_timer(cb)
    UNI.async_call(VENDOR_NAME, "ASYNC_GET_ASA_INFO", nil, nil, function(_, resp)
      if call_native_timer_reach then
        return
      end
      call_native_resp_reach = true
      cb(true, resp)
    end)
    E.Timer.once(timer_config.async_action_max_wait_seconds, function()
      if call_native_resp_reach then
        return
      end
      call_native_timer_reach = true
      cb(false)
    end)
  end
  
  call_with_timer(function(resp_reach, resp)
    if not resp_reach then
      E.LOG.debug(TAG, "call native time out")
      ESTAT.stat_action("asa_call_native_timeout", nil, false, nil)
      M.call_native_retry_action(nil)
      return
    end
    if not resp then
      E.LOG.warn(TAG, "receive native call back, unexp data!")
      ESTAT.stat_action("asa_native_resp_nil", nil, false, nil)
      return
    end
    E.LOG.debug(TAG, "receive native call back")
    E.LOG.debug(TAG, {call_native_resp = resp})
    if resp.succ then
      retry_config.retry_call_native_times = 0
      if resp.data.asaInfo then
        if needMockAttributionValue then
          if resp.data.asaInfo then
            local real_info = resp.data.asaInfo["Version3.1"]
            if real_info then
              E.LOG.debug(TAG, "mock attribution, old_value:" .. tostring(real_info["iad-attribution"]) .. ", new_value:" .. tostring(mockAttributionValue))
              real_info["iad-attribution"] = mockAttributionValue
            end
          end
        else
          E.LOG.debug(TAG, "no mock attribution, current_value:" .. tostring(resp.data.asaInfo["iad-attribution"]))
        end
        update_asa_object(nil, resp.data.asaInfo, nil, nil, nil)
        request_platform_service()
      elseif resp.data.asaToken then
        request_apple_service(resp.data.asaToken)
      end
    else
      if resp.type and type(resp.type) == "string" and resp.type == "iAdNotSupport" then
        retry_config.retry_call_native_times = 0
        update_asa_object(nil, nil, TOP_ERROR_CODE.LESS_IOS_10, nil, nil)
        request_platform_service()
        return
      end
      M.call_native_retry_action(resp)
    end
  end)
end

M.call_native_retry_action = call_native_retry_action
M.call_native = call_native

local function is_overseas()
  do return E.CONFIG.get_config end
  return E.CONFIG.get_config, E.CONFIG.KEY.MULTI_REGIONS_ENABLED
end

function M.asa_action()
  if is_overseas() then
    E.LOG.debug(TAG, "is_overseas: true")
    return
  end
  if E.Sysinfo.os() ~= "ios" then
    return
  end
  call_native()
end

function M.init(_, cb)
  E.LOG.debug(TAG, "asa info vendor init complete")
  M.asa_action()
  cb(true)
end

function M.get_mock_attribution()
  return needMockAttributionValue, mockAttributionValue, apple_service_url
end

function M.update_mock_attribution_option(need_mock)
  needMockAttributionValue = need_mock
end

function M.update_mock_attribution_value(new_value)
  mockAttributionValue = new_value
end

function M.update_apple_service_url(url)
  apple_service_url = url
end

return M
