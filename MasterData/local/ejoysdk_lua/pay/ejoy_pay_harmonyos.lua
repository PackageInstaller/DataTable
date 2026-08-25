local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local LANG = require("ejoysdk_lua.lang.util")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local HA = require("ejoysdk_lua.vendors.harmony_account")
local M = {}
local TAG = EM.MODULE.VENDORS.EJOY_PAY_HARMONYOS
local pay_listener, ejoy_pay_span, last_pay_product_id

local function harmonyos_upload_receipt_for_deliver_product(purchaseOrderPayload)
  E.LOG.debug(TAG, "deliver product, purchaseOrderPayload")
  if not purchaseOrderPayload.jwsPurchaseOrder then
    E.LOG.error(TAG, "harmonyos_upload_receipt_for_deliver_product fail, jwsPurchaseOrder is nil")
    return
  end
  local jsonTable = {
    jwsPurchaseOrder = purchaseOrderPayload.jwsPurchaseOrder
  }
  local params = {
    inapp_purchase_data = JSON.encode(jsonTable),
    inapp_data_signature = ""
  }
  local upload_receipt_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.UPLOAD_RECEIPT_PAY)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_UPLOAD_RECEIPT, params, function(succ, ...)
    ATracer.finish_pay_sub_span(upload_receipt_pay_span, {
      ...
    })
    if succ then
      local data = (...)
      E.LOG.debug(TAG, "harmonyos_upload_receipt_for_deliver_product -----succ = " .. tostring(succ))
      E.LOG.debug(TAG, "鸿蒙上传票据成功")
      E.LOG.debug(TAG, data)
      if data and data.consumer_info then
        local consumer_info = data.consumer_info
        local purchaseOrderInfo = JSON.decode(consumer_info)
        E.log(purchaseOrderInfo)
        HA.finish_purchases(purchaseOrderInfo)
      end
      purchaseOrderPayload.jwsPurchaseOrder = ""
      E.LOG.debug(TAG, {purchaseOrderPayload = purchaseOrderPayload})
    else
      local code, msg = ...
      E.LOG.debug(TAG, "鸿蒙上传票据失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
    end
  end)
end

local function harmonyos_check_purchases_unfinished()
  E.LOG.debug(TAG, "harmonyos_check_purchases_unfinished >>")
  E.async_call_once("harmony_query_purchases", function(succ, ...)
    E.LOG.debug(TAG, "harmony_query_purchases return, succ " .. tostring(succ))
    local logData = {
      ...
    }
    E.log(logData)
    if succ then
      local purchaseDataList = (...)
      E.log(purchaseDataList)
      for _, data in pairs(purchaseDataList) do
        local purchaseData = data
        E.LOG.debug(TAG, "purchaseData >> " .. tostring(purchaseData))
        E.log(purchaseData)
        harmonyos_upload_receipt_for_deliver_product(purchaseData)
      end
    else
      local code, message = ...
      E.LOG.debug(TAG, "harmony_query_purchases fail, code >> " .. tostring(code) .. ", message >> " .. tostring(message))
    end
  end)
end

local function harmonyos_pay_result_handler(succ, ...)
  E.LOG.debug(TAG, "harmony_create_purchases callback >> " .. tostring(succ))
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
    local gpOrderId, trade_id, purchaseOrderPayload = ...
    E.LOG.debug(TAG, "pay success, trade_id >> " .. tostring(trade_id))
    E.log(purchaseOrderPayload)
    harmonyos_upload_receipt_for_deliver_product(purchaseOrderPayload)
    if pay_listener then
      E.LOG.debug(TAG, "trade_id >> " .. tostring(trade_id))
      pay_listener(true, gpOrderId, purchaseOrderPayload)
    end
  else
    local gpOrderId, _trade_id, code, _message = ...
    if 1001860051 == code or 1001860001 == code then
      harmonyos_check_purchases_unfinished()
    end
    if pay_listener then
      local resp
      if 1001860000 == code then
        resp = {
          code = 2,
          msg = "取消支付"
        }
      else
        resp = {
          code = code,
          msg = "渠道支付失败:" .. tostring(_message),
          ext = {
            product_id = tostring(last_pay_product_id)
          }
        }
      end
      pay_listener(false, gpOrderId, resp)
      if 2 ~= resp.code then
        local tip_msg = LANG.getString("pay_common_tips", resp.msg)
        local prefix_message = "{" .. LANG.getStringSuitCNOverseas("code", "") .. ":"
        tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
        E.Modal.open(LANG.getString("tips", "提示"), {
          message = tip_msg,
          buttons = {
            LANG.getString("confirm", "确定")
          }
        })
      end
    end
  end
end

function M.pay(gp_order_id, _ds_order_id, product, pay_params)
  E.LOG.debug(TAG, "ejoy pay, pay_params = ")
  E.LOG.debug(TAG, pay_params)
  ejoy_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.EJOY_PAY_HARMONYOS)
  local gps_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.GPS_PAY)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    ATracer.finish_pay_sub_span(gps_pay_span, {
      ...
    })
    local temp_data = (...)
    ESTAT.app_pay_report({
      biz_func = "sdk.show_harmony_pay",
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
      E.LOG.debug(TAG, "开始鸿蒙的支付下单，准备拉起鸿蒙收银台")
      ESTAT.app_pay_report({
        biz_func = "sdk.harmony_pay_result",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {trade_id = trade_id}
      })
      last_pay_product_id = product.product_id
      HA.pay(product.product_id, trade_id, function(success, ...)
        ESTAT.app_pay_report({
          biz_func = "sdk.harmony_pay_result",
          biz_act = "finish",
          biz_st = success and "succ" or "fail",
          biz_co = success and "200" or "400",
          biz_params = {gp_order_id = gp_order_id, trade_id = trade_id}
        })
        harmonyos_pay_result_handler(success, gp_order_id, ...)
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
      pay_listener(false, gp_order_id, resp)
      local tip_msg = LANG.getString("pay_common_tips", msg)
      local prefix_message = "{" .. LANG.getStringSuitCNOverseas("code", "") .. ":"
      tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
      E.Modal.open(LANG.getString("tips", "提示"), {
        message = tip_msg,
        buttons = {
          LANG.getString("confirm", "确定")
        }
      })
    end
  end)
end

local function acquire_handler(_user_info)
  harmonyos_check_purchases_unfinished()
end

function M.setupInitPaySDK(opt)
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "init ejoy_pay_harmonyos vendor")
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
end

return M
