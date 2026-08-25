local E = require("ejoysdk_lua.ejoysdk")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local EM = require("ejoysdk_lua.ejoysdk_module")
local WEIXIN = require("ejoysdk_lua.vendors.weixin")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local LANG = require("ejoysdk_lua.lang.util")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = EM.MODULE.VENDORS.WEIXIN
local M = {}
local pay_listener, ejoy_pay_span, last_pay_product_id
local WEIXIN_PAY_TYPE = "254"

local function weixin_pay_result_handler(succ, ...)
  E.LOG.debug(TAG, "weixin_create_purchases callback >> " .. tostring(succ))
  local data = {
    ...
  }
  E.log(data)
  if ejoy_pay_span then
    ATracer.finish_pay_sub_span(ejoy_pay_span, {
      ...
    })
    ejoy_pay_span = nil
  end
  if succ then
    local gpOrderId, trade_id = ...
    E.LOG.debug(TAG, "pay success, trade_id >> " .. tostring(trade_id))
    if pay_listener then
      E.LOG.debug(TAG, "trade_id >> " .. tostring(trade_id))
      pay_listener(true, gpOrderId, data)
    end
  else
    local gpOrderId, trade_id, error_body = ...
    E.LOG.debug(TAG, "err trade_id >> " .. tostring(trade_id) .. " code >> " .. tostring(error_body.code))
    local fail_code = error_body.code or CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_UNKNOWN
    local fail_msg = error_body.msg
    if pay_listener then
      local resp = {
        code = fail_code,
        msg = fail_msg,
        ext = {
          product_id = tostring(last_pay_product_id)
        }
      }
      pay_listener(false, gpOrderId, resp)
    end
    if fail_code ~= CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL then
      local tip_msg = LANG.getString("pay_common_tips", fail_msg)
      tip_msg = tip_msg .. "{" .. tostring(fail_code) .. "}"
      E.Modal.open(LANG.getString("tips", "提示"), {
        message = tip_msg,
        buttons = {
          LANG.getString("confirm", "确定")
        }
      })
    end
  end
end

local function gps_pay(gp_order_id, _ds_order_id, product, pay_params)
  local gps_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.GPS_PAY)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    ATracer.finish_pay_sub_span(gps_pay_span, {
      ...
    })
    local temp_data = (...)
    ESTAT.app_pay_report({
      biz_func = "sdk.show_weixin_pay",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        trade_id = succ and temp_data and temp_data.trade_id or nil
      }
    })
    if succ then
      local data = (...)
      local trade_id = data.trade_id
      E.LOG.debug(TAG, "支付预下单成功，trade_id = " .. tostring(trade_id))
      E.LOG.debug(TAG, "开始微信支付下单，准备拉起微信收银台")
      ESTAT.app_pay_report({
        biz_func = "sdk.weixin_pay_result",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {trade_id = trade_id}
      })
      local pay_body_json = data.pay_body
      local pay_body = JSON.safe_decode(pay_body_json)
      last_pay_product_id = product.product_id
      local _params = {
        product_id = product.product_id,
        order_id = trade_id,
        order_amount = pay_params.min_order_amt,
        attach_info = pay_params.attach_info,
        pay_body = pay_body
      }
      WEIXIN.pay(_params, function(is_succ, ...)
        E.LOG.debug(TAG, "weixin ejoy pay result:" .. tostring(is_succ))
        E.LOG.debug(TAG, {
          ...
        })
        ESTAT.app_pay_report({
          biz_func = "sdk.weixin_pay_result",
          biz_act = "finish",
          biz_st = is_succ and "succ" or "fail",
          biz_co = is_succ and "200" or "400",
          biz_params = {gp_order_id = gp_order_id, trade_id = trade_id}
        })
        weixin_pay_result_handler(is_succ, gp_order_id, trade_id, ...)
      end)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      local resp = {
        code = code,
        msg = msg,
        ext = {
          pay_part = "gps_order",
          product_id = tostring(product.product_id)
        }
      }
      if pay_listener then
        pay_listener(false, gp_order_id, resp)
      end
      local tip_msg = LANG.getString("pay_common_tips", msg)
      tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
      E.Modal.open(LANG.getString("tips", "提示"), {
        message = tip_msg,
        buttons = {
          LANG.getString("confirm", "确定")
        }
      })
    end
  end)
end

function M.pay(gp_order_id, _ds_order_id, product, pay_params)
  pay_params.pay_type = WEIXIN_PAY_TYPE
  E.LOG.debug(TAG, "weixin ejoy pay, _ds_order_id = " .. tostring(_ds_order_id))
  E.LOG.debug(TAG, product)
  E.LOG.debug(TAG, pay_params)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local user_info = EG.user_info()
  E.LOG.debug(TAG, "print user_info")
  E.LOG.debug(TAG, user_info)
  local wx = require("ejoysdk_lua.vendors.weixin")
  local attr = {
    thirdPartyUid = wx.get_current_uid(),
    thirdPartyType = "wx_mini_login",
    airline = "lingxi"
  }
  local channel_attrs = JSON.encode(attr)
  pay_params.channel_attrs = channel_attrs
  ejoy_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.WEIXIN_PAY)
  local deviceSystem = E.Sysinfo.get_device_system() or ""
  if "android" == deviceSystem or "harmonyos" == deviceSystem or "windows" == deviceSystem then
    gps_pay(gp_order_id, _ds_order_id, product, pay_params)
  else
    WEIXIN.pay(pay_params, function(is_succ, resp)
      E.LOG.debug(TAG, "weixin ejoy pay result:" .. tostring(is_succ))
      E.LOG.debug(TAG, resp)
      ESTAT.app_pay_report({
        biz_func = "sdk.weixin_pay_result",
        biz_act = "finish",
        biz_st = is_succ and "succ" or "fail",
        biz_co = is_succ and "200" or "400"
      })
      if pay_listener then
        pay_listener(is_succ, gp_order_id, resp)
      end
    end)
  end
end

function M.setupInitPaySDK(opt)
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "init weixin ejoy pay ios vendor")
end

return M
