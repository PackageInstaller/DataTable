local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local DSP = require("ejoysdk_lua.protocol.aligames_protocol")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local VENDOR_NAME = "ALI_DATA_PKG"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = "free_flow#" .. EM.MODULE.VENDORS.ALI_DATAPKG
local ASYNC_GET_PHONE_MASK = "ASYNC_GET_PHONE_MASK"
local ASYNC_GET_TOKEN = "ASYNC_GET_TOKEN"
local ASYNC_EXCHANGE_CDN_HOST = "ASYNC_EXCHANGE_CDN_HOST"
local SYNC_GET_CURRENT_CARRIER_NAME = "SYNC_GET_CURRENT_CARRIER_NAME"
local SYNC_INIT_CONFIG = "SYNC_INIT_CONFIG"
local LUA_KEY_CARRIER_NAME = "carrier_name"
local LUA_KEY_MASK_NUMBER = "mask_number"
local LUA_KEY_PROTOCOL_NAME = "protocol_name"
local LUA_KEY_PROTOCOL_URL = "protocol_url"
local LUA_KEY_AUTH_TOKEN = "auth_token"
local LUA_KEY_CDN_HOST = "cdn_host"
local LUA_KEY_RECEIPT = "receipt"
local LUA_KEY_OPERATOR = "operator"
local LUA_KEY_XGIP_TOKEN = "xgip_token"
local config = {}
local mobile_protocol = {}
local order_infos = {}
local eligible_info = {}
M.AUTH_VENDOR_NAME = "PHONE_AUTH"
M.CONFIG_KEY = {
  AUTH_SECRET = "auth_secret",
  PRODUCT_ID = "productId",
  XGIP_APPID = "xgipAppId"
}
M.PROTOCOL_KEY = {PROTOCOL_NAME = LUA_KEY_PROTOCOL_NAME, PROTOCOL_URL = LUA_KEY_PROTOCOL_URL}
M.OPERATOR = {
  CT = "ct",
  CU = "cu",
  CM = "cm"
}
M.GET_RESULT_LOOP_INTERVAL = {INTERVAL_FOREGROUND = 10, INTERVAL_BACKGROUND = 60}
M.FREE_STATUE = {
  NO_FREE = 0,
  IN_FREE = 1,
  ORDERING = 2
}
M.ORDER_STATUE = {
  INIT_ORDER = 0,
  SUCCESS_ORDER = 1,
  TRY_ORDER = 2,
  FAIL_ORDER = 3
}
M.RECEIVE_ERROR_CODE = {
  CUR_PHONE_ALREADY_RECEIVE = 5001009,
  CUR_ACCOUNT_ALREADY_RECEIVE = 5001010,
  INVALID_TOKEN = 5001011,
  ALIYUN_ERROR = 5001012,
  MASK_TOKEN_NOT_MATCH = 5001014
}
M.RECEIVE_FAIL_TYPE = {SERVER_RESULT = 1, TOME_OUT = 2}
local loop_interval = M.GET_RESULT_LOOP_INTERVAL.INTERVAL_FOREGROUND
local loop_total_time = 1200000
local start_request_result_time = 0
local phone_number_info

local function find_order_by_mask(mask)
  local order_info = order_infos[mask]
  return order_info
end

function M.init(opt, cb)
  M.opt = opt
  E.LOG.debug(TAG, "init ali_datapkg")
  local vendor_config = E.CONFIG.get_vendor_config_v2(VENDOR_NAME) or {}
  local params = {}
  params[M.CONFIG_KEY.AUTH_SECRET] = opt[M.CONFIG_KEY.AUTH_SECRET] or vendor_config[M.CONFIG_KEY.AUTH_SECRET] or nil
  params[M.CONFIG_KEY.PRODUCT_ID] = opt[M.CONFIG_KEY.PRODUCT_ID] or vendor_config[M.CONFIG_KEY.PRODUCT_ID] or nil
  params[M.CONFIG_KEY.XGIP_APPID] = opt[M.CONFIG_KEY.XGIP_APPID] or vendor_config[M.CONFIG_KEY.XGIP_APPID] or nil
  E.LOG.debug(TAG, "let us see what it is")
  E.LOG.debug(TAG, {params = params})
  E.LOG.debug(TAG, {vendor_config = vendor_config})
  cb = cb or function()
  end
  if not params[M.CONFIG_KEY.AUTH_SECRET] then
    cb(true)
    return
  end
  config = params
  UNI.sync_call(VENDOR_NAME, SYNC_INIT_CONFIG, config, nil)
  M.get_mobile_number_info()
  cb(true)
end

function M.is_support()
  local sdk_infos = UNI.get_sdk_infos()
  for sdk_name, _sdk_info in pairs(sdk_infos) do
    if sdk_name == VENDOR_NAME then
      return true
    end
  end
  return false
end

local function suit_carrier_name_to_alpha(carrier_name)
  if "中国联通" == carrier_name then
    carrier_name = "CUCC"
  elseif "中国移动" == carrier_name then
    carrier_name = "CMCC"
  elseif "中国电信" == carrier_name then
    carrier_name = "CTCC"
  end
  return carrier_name
end

function M.get_current_carrier_name()
  E.LOG.debug(TAG, "get current carrier name")
  if _ejoysdk.os() == "harmonyos" then
    return nil
  end
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_CURRENT_CARRIER_NAME, {}, nil)
  if ret and ret[LUA_KEY_CARRIER_NAME] then
    E.LOG.debug(TAG, "get the carrier name >> " .. tostring(ret[LUA_KEY_CARRIER_NAME]))
    local carrier_name = ret[LUA_KEY_CARRIER_NAME]
    if E.Sysinfo.os() == "ios" then
      carrier_name = suit_carrier_name_to_alpha(carrier_name)
    end
    return carrier_name
  end
  return nil
end

function M.get_mobile_mask_number(cb)
  E.LOG.debug(TAG, "get phone mask number")
  UNI.async_call(VENDOR_NAME, ASYNC_GET_PHONE_MASK, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if body[LUA_KEY_MASK_NUMBER] then
        E.LOG.debug(TAG, "get current mask number >> " .. tostring(body[LUA_KEY_MASK_NUMBER]))
        local mask = body[LUA_KEY_MASK_NUMBER]
        local protocol_name = body[LUA_KEY_PROTOCOL_NAME]
        local protocol_url = body[LUA_KEY_PROTOCOL_URL]
        local protocol = {}
        protocol[LUA_KEY_PROTOCOL_NAME] = protocol_name
        protocol[LUA_KEY_PROTOCOL_URL] = protocol_url
        mobile_protocol[mask] = protocol
        if cb then
          cb(true, mask)
        end
      end
    else
      local code, message = ...
      E.LOG.error(TAG, "get phone mask number failed >> " .. tostring(code) .. ", msg: " .. tostring(message))
      if cb then
        cb(false, code, message)
      end
    end
  end)
end

function M.get_protocol(mask)
  local protocol = mobile_protocol[mask]
  return protocol
end

function M.get_auth_token(cb)
  E.LOG.debug(TAG, "start user auth ")
  local params = {}
  UNI.async_call(VENDOR_NAME, ASYNC_GET_TOKEN, params, nil, function(succ, ...)
    local carrier_name = M.get_current_carrier_name() or nil
    local stat_params = {carrier_name = carrier_name}
    local stat_code = 200
    if succ then
      local body = (...)
      if body[LUA_KEY_AUTH_TOKEN] then
        local token = body[LUA_KEY_AUTH_TOKEN]
        E.LOG.debug(TAG, "user auth token >> " .. tostring(token))
        if cb then
          cb(true, token)
        end
      end
    else
      local code, body = ...
      local message = ""
      if body and type(body) == "table" then
        message = body.msg or body.error_msg
      end
      stat_code = code
      E.LOG.error(TAG, "get auth token failed >> " .. tostring(code) .. ", msg: " .. tostring(message))
      if cb then
        cb(false, code, message)
      end
      stat_params.body = body
    end
    stat_params.net_type_name = E.Sysinfo.network_type_name()
    ESTAT.sdk_account_pfcomm({
      biz_mod = "login",
      biz_func = "sdk.one_click_login",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = tostring(stat_code),
      biz_params = stat_params
    })
  end)
end

function M.is_current_mask_free(operator, mask, cb)
  local ds_uid = EG.user_info().uid
  E.LOG.debug(TAG, "request is current mask free ds_uid>> " .. tostring(ds_uid))
  local ds_operator = operator
  local product_id = config[M.CONFIG_KEY.PRODUCT_ID]
  local params = {
    accountId = ds_uid,
    phoneNumberMask = mask,
    operator = ds_operator,
    productId = product_id
  }
  
  local function inner_cb(succ, ...)
    if succ then
      local resp = (...)
      local status = resp.status
      local eligible = resp.eligible
      E.LOG.debug(TAG, "is current mask free, status  >> " .. tostring(status) .. ", eligible >> " .. tostring(eligible))
      E.log(resp)
      local order_info = resp.orderInfo
      if order_info then
        order_infos[mask] = order_info
      end
      eligible_info[mask] = eligible
      if cb then
        cb(true, status)
      end
    else
      local code, message = ...
      E.LOG.debug(TAG, "is current mask free, error >> " .. tostring(code) .. ", msg: " .. tostring(message))
      if cb then
        cb(false, code, message)
      end
    end
  end
  
  DSP.post(DSP.SERVICE.FREE_DATA_PKG_CHECK, params, inner_cb)
end

function M.request_free_data_pack(operator, mask, verify_token, cb)
  local ds_token = EG.user_info().ptoken
  local ds_operator = operator
  local product_id = config[M.CONFIG_KEY.PRODUCT_ID]
  E.LOG.debug(TAG, "request free data pkg, ds token >> " .. tostring(ds_token))
  local params = {
    verifyToken = verify_token,
    phoneNumberMask = mask,
    dsToken = ds_token,
    operator = ds_operator,
    productId = product_id
  }
  E.log(params)
  
  local function inner_cb(succ, ...)
    if succ then
      local resp = (...)
      local order_id = resp.orderId
      local status = resp.status
      E.LOG.debug(TAG, "request free data pkg succ >> orderId >> " .. tostring(order_id) .. ", and status >> " .. tostring(status))
      if status == M.ORDER_STATUE.INIT_ORDER then
        if cb then
          cb(true, order_id)
        end
      elseif cb then
        cb(false)
      end
    else
      local code, message = ...
      E.LOG.error(TAG, "request free data pkg error >> " .. tostring(code) .. ", msg: " .. tostring(message))
      if cb then
        cb(false, code, message)
      end
    end
  end
  
  DSP.post(DSP.SERVICE.FREE_DATA_PKG_RECEIVE, params, inner_cb)
end

local is_loop_stop = false

function M.start_request_result_loop(mask, order_id, cb)
  is_loop_stop = false
  local request_result_loop
  
  local function retry_func()
    local now = E.system_clock()
    local waiting_time = now - start_request_result_time
    if is_loop_stop then
      E.LOG.debug(TAG, "is loop stop is true, return")
      return
    end
    if waiting_time > loop_total_time then
      if cb then
        cb(false, M.RECEIVE_FAIL_TYPE.TOME_OUT)
      end
    else
      E.Timer.once(loop_interval, request_result_loop)
    end
  end
  
  function request_result_loop()
    E.LOG.debug(TAG, "try request the receive result >>")
    if is_loop_stop then
      E.LOG.debug(TAG, "is loop stop is true, return")
      return
    end
    M.get_request_result(mask, order_id, function(succ, ...)
      if succ then
        local status = (...)
        if status == M.ORDER_STATUE.SUCCESS_ORDER then
          if cb then
            cb(true)
          end
        elseif status == M.ORDER_STATUE.FAIL_ORDER then
          if cb then
            cb(false)
          end
        else
          retry_func()
        end
      else
        retry_func()
      end
    end)
  end
  
  start_request_result_time = E.system_clock()
  request_result_loop()
end

function M.stop_request_result_loop()
  E.LOG.debug(TAG, "stop request result loop >> ")
  is_loop_stop = true
end

function M.set_loop_interval(interval)
  E.LOG.debug(TAG, "reset loop interval >> " .. tostring(interval))
  loop_interval = interval
end

function M.get_request_result(_mask, order_id, cb)
  E.LOG.debug(TAG, "get request result  >> " .. tostring(order_id))
  local params = {orderId = order_id}
  
  local function inner_cb(succ, ...)
    if succ then
      local resp = (...)
      local status = resp.status
      E.LOG.debug(TAG, "get request result succ, status >> " .. tostring(status))
      if cb then
        cb(true, status)
      end
    else
      E.LOG.debug(TAG, "get request result fail ")
      if cb then
        cb(false)
      end
    end
  end
  
  DSP.post(DSP.SERVICE.FREE_DATA_PKG_RESULT, params, inner_cb)
end

function M.is_eligible(mask)
  E.LOG.debug(TAG, "get is is_eligible, mask >> " .. tostring(mask))
  local eligible = eligible_info[mask]
  if nil ~= eligible then
    E.LOG.debug(TAG, "eligible is not nil >> " .. tostring(eligible))
    return eligible
  end
  return false
end

function M.get_ordering_order(mask)
  E.LOG.debug(TAG, "get order status, mask >> " .. tostring(mask))
  local order = order_infos[mask]
  if order then
    local status = order.status
    E.LOG.debug(TAG, "order status >> " .. tostring(status))
    if status and status == M.ORDER_STATUE.INIT_ORDER then
      return order_infos[mask]
    end
    return nil
  end
end

function M.exchange_CDN_host(mask, origin_host_list, cb)
  E.LOG.debug(TAG, "exchange cdn host >> ")
  E.log(origin_host_list)
  local order_info = find_order_by_mask(mask)
  if not order_info then
    if cb then
      cb(false, CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_ALI_DATA_PKG_NO_ORDER_INFO, "did not find the order for mask >> " .. tostring(mask))
    end
    return
  end
  local receipt = order_info.receipt
  local xgip_token = order_info.xgipToken
  E.LOG.debug(TAG, "find the receipt >> " .. tostring(receipt) .. ", xgiptoken >> " .. tostring(xgip_token))
  local params = {}
  params[LUA_KEY_CDN_HOST] = origin_host_list
  params[LUA_KEY_RECEIPT] = receipt
  params[LUA_KEY_OPERATOR] = M.OPERATOR.CT
  params[LUA_KEY_XGIP_TOKEN] = xgip_token
  UNI.async_call(VENDOR_NAME, ASYNC_EXCHANGE_CDN_HOST, params, nil, function(succ, ...)
    if succ then
      local resp = (...)
      if cb then
        cb(true, resp)
      end
    else
      local code, message = ...
      if cb then
        cb(false, code, message)
      end
      E.LOG.error(TAG, "exchange cdn host error >> " .. tostring(code) .. ", msg: " .. tostring(message))
    end
  end)
end

function M.get_mobile_number_info_cache()
  if phone_number_info and phone_number_info.succ == true then
    local info = phone_number_info
    phone_number_info = nil
    M.get_mobile_number_info()
    return info
  end
  return nil
end

function M.get_mobile_number_info(cb)
  cb = cb or function()
  end
  local cache = M.get_mobile_number_info_cache()
  if cache and cache.succ == true then
    E.LOG.debug(TAG, "读取缓存成功")
    cb(cache)
    return
  end
  
  local function save_cb(ret)
    if ret and ret.succ == true then
      E.LOG.debug(TAG, "预载手机信息成功")
      phone_number_info = ret
    else
      E.LOG.debug(TAG, "预载手机信息失败")
      phone_number_info = nil
    end
    cb(ret)
  end
  
  local ret = {succ = false}
  if M.is_support() then
    local carrier_name = M.get_current_carrier_name() or nil
    if carrier_name and "" ~= carrier_name and "unknown" ~= carrier_name then
      M.get_mobile_mask_number(function(succ, ...)
        local stat_params = {carrier_name = carrier_name}
        local stat_code = 200
        if true == succ then
          local mask_number = (...)
          ret.succ = true
          ret.number = mask_number or ""
          ret.carrier = carrier_name or ""
          local protocol = mobile_protocol[ret.number]
          ret.protocol = {
            name = protocol[LUA_KEY_PROTOCOL_NAME] or "",
            url = protocol[LUA_KEY_PROTOCOL_URL] or ""
          }
        else
          local code, body = ...
          stat_code = code
          ret.code = code
          local message = ""
          if body and type(body) == "table" then
            message = body.msg or body.error_msg
          end
          ret.msg = message
        end
        save_cb(ret)
        stat_params.ret = ret
        stat_params.net_type_name = E.Sysinfo.network_type_name()
        ESTAT.sdk_account_pfcomm({
          biz_mod = "login",
          biz_func = "sdk.one_click_get_phone_mask",
          biz_act = "finish",
          biz_st = succ and "succ" or "fail",
          biz_co = tostring(stat_code),
          biz_params = stat_params
        })
      end)
      return
    else
      ret.code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_ALI_DATA_PKG_GET_CARRIER_FAILED
      ret.msg = "get carrier fail"
    end
  else
    ret.code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT
    ret.msg = "not support"
  end
  save_cb(ret)
end

function M.login(_ext, cb)
  E.LOG.debug(TAG, "aliyun login begin")
  cb = cb or function()
  end
  local os = E.Sysinfo.os()
  if "windows" == os then
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support")
    cb(channel_result)
    return
  end
  M.get_auth_token(function(succ, ...)
    if succ then
      local token = (...)
      if token and "" ~= token then
        local userInfo = {
          token = token,
          uid = "",
          guest = false
        }
        local ext = {}
        local channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, userInfo, ext)
        cb(channel_result)
      else
        local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL, "Invalid Ali-Token")
        cb(channel_result)
      end
    else
      local code, body = ...
      local channel_result = PROTOCOL.LoginResult.fail(code, (body or {}).error_msg)
      cb(channel_result)
    end
  end)
end

return M
