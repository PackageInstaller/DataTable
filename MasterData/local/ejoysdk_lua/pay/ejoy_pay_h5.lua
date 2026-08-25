local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local VENDOR_NAME = "EJOYPAY"
local M = {}
local TAG = EM.MODULE.VENDORS.EJOY_PAY_H5
local SYNC_EJOYPAY_INT = "SYNC_EJOYPAY_INT"
local SYNC_EJOYPAY_INIT_WX = "SYNC_EJOYPAY_INIT_WX"
local SYNC_IS_SUPPORT_WX_PAY = "SYNC_IS_SUPPORT_WX_PAY"
local ASYNC_ALIPAY = "ASYNC_ALIPAY"
local ASYNC_WX_PAY = "ASYNC_WX_PAY"
local SP_WX_APP_ID = E.SPKeyStore:New("com.ejoy.sdk.lua", "SP_WX_APP_ID")
local pay_listener, ejoy_pay_span, pay_init_data, pay_query_info_data, wx_app_id, is_wx_pay_init
local LUA_KEY_PAY_INFO = "payInfo"
local LUA_KEY_PAY_REQ = "payReq"
local LUA_KEY_ORDER_ID = "order_id"
local LUA_KEY_RESULT = "result"
local LUA_KEY_CODE = "code"
local LUA_KEY_MESSAGE = "message"
local LUA_KEY_RESULT_EXT = "result_ext"
local LUA_KEY_ALIPAY_RESULT_STATUS = "resultStatus"
local LUA_KEY_ALIPAY_RESULT_MEMO = "memo"
local LUA_KEY_WX_APP_ID = "wx_app_id"
local H5_PAY_STATE = {
  DEFAULT = 0,
  SUCCESS = 1,
  FAILED = 2,
  REFUND = 3
}
M.ENV = {
  DEBUG = "debug",
  RELEASE = "release",
  PRE_RELEASE = "pre_release"
}
M.URL_BASE_H5 = {
  DEBUG = "https://paycenter-test.lingxigames.com/cashier",
  PRE_RELEASE = "https://paycenter-pre.lingxigames.com/cashier",
  RELEASE = "https://paycenter.lingxigames.com/cashier"
}
local l_env

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  l_env = env
end

local function get_env()
  if l_env then
    return l_env
  end
  local EI = require("ejoysdk_lua.ejoysdk_init")
  do return end
  return EI.env
end

local INTERNAL_EVENT = {
  EVT_ON_ALIPAY_RESULT = "alipay_result",
  EVT_ON_WXPAY_RESULT = "wxpay_result"
}
local EVT_HANDLERS = {}

local function call_js(type, scene, data)
  local js_script = "window.luaNotify('" .. type .. "','" .. scene .. "', '" .. data .. "');"
  E.LOG.debug(TAG, "call js >> " .. tostring(js_script))
  E.WebView.call_js(js_script)
end

EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_ALIPAY_RESULT] = function(body)
  local order_id = body[LUA_KEY_ORDER_ID]
  local result = body[LUA_KEY_RESULT]
  local result_status = body[LUA_KEY_ALIPAY_RESULT_STATUS]
  local memo = body[LUA_KEY_ALIPAY_RESULT_MEMO]
  local result_ext = body[LUA_KEY_RESULT_EXT]
  E.LOG.debug(TAG, "on alipay result, order_id >> " .. tostring(order_id))
  E.LOG.debug(TAG, "result_status >> " .. tostring(result_status))
  E.LOG.debug(TAG, "memo >> " .. tostring(memo))
  E.LOG.debug(TAG, "result >> " .. tostring(result))
  E.LOG.debug(TAG, result_ext)
  local data = {}
  data.order_id = order_id
  if "9000" == result_status then
    data.code = 2000000
    data.msg = "pay success"
  else
    data.code = -1
    data.msg = memo
  end
  call_js("paycenter", "pay_result", JSON.encode(data))
end
EVT_HANDLERS[INTERNAL_EVENT.EVT_ON_WXPAY_RESULT] = function(body)
  local code = body[LUA_KEY_CODE]
  local message = body[LUA_KEY_MESSAGE]
  E.LOG.debug(TAG, "on wxpay result, code >> " .. tostring(code))
  E.LOG.debug(TAG, "message >> " .. tostring(message))
  local data = {}
  if 0 == code then
    data.code = 2000000
    data.msg = "pay success"
  else
    data.code = code
    data.msg = message
  end
  call_js("paycenter", "pay_result", JSON.encode(data))
end

local function open_pay_center_webview(pay_params)
  local payment_url = M.URL_BASE_H5.RELEASE
  local _env = get_env()
  if _env == M.ENV.DEBUG then
    payment_url = M.URL_BASE_H5.DEBUG
  elseif _env == M.ENV.PRE_RELEASE then
    payment_url = M.URL_BASE_H5.PRE_RELEASE
  end
  if pay_init_data and pay_init_data.cashier_url then
    payment_url = pay_init_data.cashier_url
    E.LOG.debug(TAG, "使用支付SDK初始化接口下发配置的收银台URL: " .. tostring(payment_url))
  else
    local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if is_oversea then
      E.LOG.debug(TAG, "支付初始化接口未返回收银台地址，需要读取global-config配置的收银台URL")
      local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
      local gangplank_config = EGC.get_current_cdn_config()
      if gangplank_config and gangplank_config.render_center and gangplank_config.render_center.payment and gangplank_config.render_center.payment ~= "" then
        payment_url = gangplank_config.render_center.payment
      end
    end
  end
  local pay_finished = false
  local last_pay_status
  
  local function on_js_callback(_value)
    local args = _value.args
    E.LOG.debug(TAG, "open_pay_center_webview js callback >>")
    E.LOG.debug(TAG, args)
    if args.type == "paycenter_pay_result" then
      last_pay_status = args.params or {}
      pay_finished = true
    end
  end
  
  local function on_close_callback()
    E.LOG.debug(TAG, "open_pay_center_webview close callback >>")
    if ejoy_pay_span then
      ATracer.finish_pay_sub_span(ejoy_pay_span, {pay_finished = pay_finished, last_pay_status = last_pay_status})
      ejoy_pay_span = nil
    end
    local order_id = (pay_params or {}).gpOrderId
    if pay_finished then
      E.LOG.debug(TAG, "pay finished and webview is closed, last_pay_status >>")
      E.LOG.debug(TAG, last_pay_status)
      last_pay_status = last_pay_status or {}
      local orderStatus = last_pay_status.orderStatus
      if orderStatus == H5_PAY_STATE.SUCCESS then
        E.LOG.debug(TAG, "receive pay succ")
        pay_listener(true, order_id, {})
      else
        local msg = last_pay_status.msg
        local code = last_pay_status.serverCode
        E.LOG.warn(TAG, "receive pay failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        local ext = {pay_part = "h5_order", last_pay_status = last_pay_status}
        pay_listener(false, order_id, {
          code = code,
          msg = msg,
          ext = ext
        })
      end
    else
      E.LOG.warn(TAG, "pay cancelled")
      pay_listener(false, order_id, {
        code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
        msg = "pay cancelled"
      })
    end
  end
  
  local trd_params = {}
  local init_args = E.CONFIG.get_config(E.CONFIG.KEY.INIT_ARGS)
  if type(init_args) == "table" and next(init_args) and type(init_args.channel) == "string" then
    local channel = string.upper(init_args.channel)
    local channel_vendor = EV.get(channel)
    if channel_vendor and channel_vendor.check_args then
      local params = channel_vendor.check_args(init_args)
      trd_params = params or trd_params
      trd_params.type = (EG.user_info() or {}).platform
    end
  end
  local product_info = pay_params or {}
  if pay_init_data then
    pay_init_data.is_sandbox_user = GDP.USER_INFO.get("is_sandbox_user") or nil
  else
    pay_init_data = {
      is_sandbox_user = GDP.USER_INFO.get("is_sandbox_user") or nil
    }
  end
  local start_up_data = {
    product_info = product_info,
    cp_order_id = product_info.cpOrderId,
    gp_order_id = product_info.gpOrderId,
    order_amount = product_info.order_amt,
    product_name = product_info.payProductName,
    sysinfo_country = E.CONFIG.get_config("district"),
    pay_init_data = pay_init_data,
    pay_query_data = pay_query_info_data,
    thirdparty_params = trd_params
  }
  if _ejoysdk.os() == "android" then
    start_up_data.is_wechat_install = E.Sysinfo.is_app_install("com.tencent.mm")
    start_up_data.is_alipay_install = E.Sysinfo.is_app_install("com.eg.android.AlipayGphone")
  end
  if _ejoysdk.os() == "android" or _ejoysdk.os() == "windows" then
    start_up_data.last_pay_type = E.UnRecoverKeyStore.get("PAYCENTER_FE_last_pay_type_id")
  end
  if ejoy_pay_span then
    local ETracer = require("ejoysdk_lua.ejoysdk_span_reporter")
    start_up_data.opentracing = {
      traceId = ejoy_pay_span:context():get_trace_id(),
      span = ejoy_pay_span:get_operation_name(),
      span_id = ejoy_pay_span:context():get_span_id(),
      trace_enable = ETracer.opentracing_enable()
    }
  end
  local url_white_hosts = {}
  local ret = E.HTTP.parse(payment_url)
  if ret.host then
    table.insert(url_white_hosts, ret.host)
  end
  local options = {
    hide_close_btn = false,
    min_width = 450,
    min_height = 400,
    transparent = true
  }
  E.LOG.d(TAG, "will open pay h5, params >>")
  E.LOG.d(TAG, {
    url = payment_url,
    url_white_hosts = url_white_hosts,
    start_up_data = start_up_data,
    options = options
  })
  pay_params.payment_url = payment_url
  ESTAT.h5_pay_report({
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {
      payment_url = payment_url,
      cp_order_id = product_info.cpOrderId,
      gp_order_id = product_info.gpOrderId
    }
  })
  local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
  local local_url = LIGHTBOAT.get_url_from_cache(payment_url)
  local is_offline = E.Utils.start_with(local_url, "file://")
  local regx = is_offline and "(%d+%.%d+%.%d+)/[^/]*$" or "/(v%d+_%d+)/"
  local version = local_url:match(regx)
  ESTAT.stat_bizid("pay.url.version", "0", "0", {
    url = payment_url,
    local_url = local_url,
    is_offline = is_offline,
    version = version
  })
  E.open_webview_with_options(payment_url, url_white_hosts, start_up_data, options, on_js_callback, on_close_callback)
end

function M.launch_alipay(order_id, payInfo, cb)
  local params = {}
  params[LUA_KEY_ORDER_ID] = order_id
  params[LUA_KEY_PAY_INFO] = payInfo
  E.LOG.debug(TAG, "try launch alipay")
  E.log(params)
  UNI.async_call(VENDOR_NAME, ASYNC_ALIPAY, params, nil, function(succ, ...)
    if cb then
      cb(succ)
    end
  end)
end

function M.is_support_weixin_app_pay()
  if _ejoysdk.os() ~= "android" or tostring(E.get_channel()) ~= "998233" then
    E.LOG.debug(TAG, "is not android official channel, not support")
    return false
  end
  if nil == wx_app_id then
    E.LOG.debug(TAG, "wx_app_id has not init yet, not support")
    return false
  end
  local is_wx_app_install = E.Sysinfo.is_app_install("com.tencent.mm")
  if not is_wx_app_install then
    E.LOG.debug(TAG, "wx is not install, not support")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_IS_SUPPORT_WX_PAY, {}, nil)
  if ret and ret.is_support then
    return true
  else
    return false
  end
end

function M.launch_wx_pay(order_id, payReq, cb)
  if not is_wx_pay_init then
    E.LOG.debug(TAG, "wx pay is not init, cb false")
    if cb then
      cb(false)
    end
    return
  end
  local params = {}
  params[LUA_KEY_ORDER_ID] = order_id
  params[LUA_KEY_PAY_REQ] = payReq
  E.LOG.debug(TAG, "try launch wx pay")
  E.log(params)
  UNI.async_call(VENDOR_NAME, ASYNC_WX_PAY, params, nil, function(succ, ...)
    if cb then
      cb(succ)
    end
  end)
end

function M.get_wx_appid()
  if wx_app_id and type(wx_app_id) == "string" and "" ~= wx_app_id then
    return wx_app_id
  end
  wx_app_id = SP_WX_APP_ID:get()
  return wx_app_id
end

function M.set_wx_appid(data)
  wx_app_id = data
  SP_WX_APP_ID:set(wx_app_id)
end

function M.setPayInitData(data)
  pay_init_data = data
end

function M.getPayInitData()
  return pay_init_data
end

function M.pay(_gp_order_id, _ds_order_id, _product, pay_params)
  ejoy_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.EJOY_PAY_H5)
  if M.is_support_weixin_app_pay() then
    if not is_wx_pay_init then
      E.LOG.debug(TAG, "wx_pay is not inited")
      local param = {}
      param[LUA_KEY_WX_APP_ID] = wx_app_id
      UNI.sync_call(VENDOR_NAME, SYNC_EJOYPAY_INIT_WX, param, nil)
      is_wx_pay_init = true
    else
      E.LOG.debug(TAG, "wx_pay is inited")
    end
  end
  open_pay_center_webview(pay_params)
end

local function pay_invoke_handler()
  if not pay_init_data or not pay_init_data.pay_type_district_list then
    E.LOG.error(TAG, "pay_init_data or pay_init_data.pay_type_district_list is nil, do not request pay query info, return now.")
    return
  end
  if _ejoysdk.os() == "ios" or _ejoysdk.os() == "harmonyos" then
    E.LOG.debug(TAG, "iOS和鸿蒙不需要调用支付的运营活动信息接口，他们不使用H5收银台.")
    return
  end
  local pay_params = {
    pay_type_district_list = pay_init_data.pay_type_district_list
  }
  E.LOG.debug(TAG, "request_pay_query_info, params = ")
  E.LOG.debug(TAG, pay_params)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_SDK_INFO_QUERY, pay_params, function(succ, ...)
    if succ then
      local data = (...)
      E.LOG.debug(TAG, "支付SDK查询运营信息成功")
      E.LOG.debug(TAG, {response_data = data})
      pay_query_info_data = data
    else
      local code, msg = ...
      E.LOG.debug(TAG, "支付SDK查询运营信息失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
    end
  end)
end

function M.setupInitPaySDK(opt)
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "init ejoy_pay_h5 vendor")
  local param = {
    pay_game_id = E.get_game_id()
  }
  if _ejoysdk.os() == "android" then
    UNI.sync_call(VENDOR_NAME, SYNC_EJOYPAY_INT, param, nil)
    UNI.register_event_cb(VENDOR_NAME, function(type, body_data)
      if not type or "" == type then
        E.LOG.debug(TAG, "type is invalid")
        return
      end
      local handler = EVT_HANDLERS[type]
      if handler then
        E.LOG.debug(TAG, "handled event with type:" .. (type or "nil"))
        handler(body_data)
      end
    end)
  else
    E.LOG.debug(TAG, "windows has not native vendor, do not init")
  end
  ET.subscribe(ET.gangplank.PAY_INVOKE, pay_invoke_handler)
end

return M
