local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local LANG = require("ejoysdk_lua.lang.util")
local util = require("ejoysdk_lua.ejoysdk_utils")
local VENDOR_NAME = "EJOYPAY"
local M = {}
local TAG = EM.MODULE.VENDORS.EJOY_PAY_IOS
local SYNC_EJOYPAY_INT = "SYNC_EJOYPAY_INT"
local SYNC_GET_RECEIPT = "SYNC_GET_RECEIPT"
local SYNC_GET_STORE_FRONT = "SYNC_GET_STORE_FRONT"
local SYNC_SHOW_LOADING = "SYNC_SHOW_LOADING"
local SYNC_HIDE_LOADING = "SYNC_HIDE_LOADING"
local SYNC_GET_ALL_UNFINISH_TRANSACTIONS = "SYNC_GET_ALL_UNFINISH_TRANSACTIONS"
local SYNC_GET_APPLE_PRODUCTINFOS = "SYNC_GET_APPLE_PRODUCTINFOS"
local SYNC_SUPPORT_CLOSE_TRANS_ID = "SYNC_SUPPORT_CLOSE_TRANS_ID"
local CAST_FINISH_PRODUCT_TRANSACTION = "CAST_FINISH_PRODUCT_TRANSACTION"
local CAST_FINISH_TRANS_ID_TRANSACTION = "CAST_FINISH_TRANS_ID_TRANSACTION"
local CAST_REFRESH_RECEIPT = "CAST_REFRESH_RECEIPT"
local EJOY_PAY_HAS_UNFINISHED_PAY_ORDER = E.LazyKeyStore:New("EJOY_PAY_HAS_UNFINISHED_PAY_ORDER_V1", false, true, false)
local EJOY_PAY_RESERVE_UPLOAD_FLAG = E.LazyKeyStore:New("EJOY_PAY_RESERVE_UPLOAD_FLAG_V1", false, true, false)
local pay_listener, ejoy_pay_span
local apple_product_infos = {}
local max_retry_upload_receipt_count = 5
local is_support_trans_id_finish_transaction = false
local last_pay_product_id

local function finish_transaction_with_product_id_and_trans_id(product_id, trans_id)
  if is_support_trans_id_finish_transaction and not util.STR.is_empty(trans_id) then
    UNI.cast(VENDOR_NAME, CAST_FINISH_TRANS_ID_TRANSACTION, {transactionIdentifier = trans_id}, nil)
  else
    UNI.cast(VENDOR_NAME, CAST_FINISH_PRODUCT_TRANSACTION, {product_id = product_id}, nil)
  end
  EJOY_PAY_HAS_UNFINISHED_PAY_ORDER:set(false)
end

local function get_notify_url()
  local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
  do return end
  return ejoy_pay.get_notify_url
end

local function ios_upload_receipt_method(product_id, trans_id, trade_id, trans_state, original_trans_id, cb, retry_number)
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
  local receipt_str = ret and ret.receipt or ""
  E.LOG.debug(TAG, "receipt_str ====")
  E.LOG.debug(TAG, receipt_str)
  local temp_params = {
    receipt = receipt_str,
    trans_id = trans_id,
    trade_id = trade_id,
    trans_state = trans_state,
    original_trans_id = original_trans_id,
    prd_id = product_id,
    notify_url = get_notify_url()
  }
  E.LOG.debug(TAG, {temp_params = temp_params})
  local upload_receipt_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.UPLOAD_RECEIPT_PAY)
  ESTAT.app_pay_report({
    biz_func = "sdk.apple_upload_receipt",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = temp_params
  })
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_UPLOAD_RECEIPT_IOS, temp_params, function(succ, ...)
    ATracer.finish_pay_sub_span(upload_receipt_pay_span, {
      ...
    })
    temp_params.retry_number = tostring(retry_number)
    temp_params.http_resp_body = {
      ...
    }
    ESTAT.app_pay_report({
      biz_func = "sdk.apple_upload_receipt",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = temp_params
    })
    if succ then
      local data = (...)
      E.LOG.debug(TAG, "upload_receipt_to_server -----succ = " .. tostring(succ))
      E.LOG.debug(TAG, "上传票据成功")
      E.LOG.debug(TAG, data)
      E.LOG.debug(TAG, "准备结束这个商品的订单，finish_transaction----")
      finish_transaction_with_product_id_and_trans_id(product_id, trans_id)
      if cb then
        cb(succ, ...)
      end
    else
      local code, msg, body_json = ...
      E.LOG.debug(TAG, "上传票据失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      E.LOG.debug(TAG, {body_json = body_json})
      code = tonumber(code)
      if 10000005 == code or 10000008 == code or 10000012 == code or 10000036 == code then
        E.LOG.debug(TAG, "本次命中需要关单的错误码，需要关闭订单")
        finish_transaction_with_product_id_and_trans_id(product_id, trans_id)
        if cb then
          cb(succ, ...)
        end
      elseif 10000037 == code then
        E.LOG.debug(TAG, "这个错误码表示需要刷新票据，准备进行票据刷新操作，会让用户输入密码")
        UNI.cast(VENDOR_NAME, CAST_REFRESH_RECEIPT, {}, nil)
        if cb then
          cb(succ, ...)
        end
      elseif 10000013 == code or 10000015 == code or 10000016 == code or 10000038 == code or code < 0 then
        E.LOG.debug(TAG, "本次命中需要重试的错误码，网络错误也是需要重试的，准备进行重试上传操作")
        if retry_number and tonumber(retry_number) >= max_retry_upload_receipt_count then
          E.LOG.debug(TAG, "此时发现上传票据接口重试超过 " .. tostring(max_retry_upload_receipt_count) .. " 次依然失败，不再做更多重试了，结束本次操作")
          if cb then
            cb(succ, ...)
          end
          return
        end
        if not retry_number or 0 == tonumber(retry_number) then
          retry_number = 1
        else
          retry_number = retry_number + 1
        end
        E.LOG.debug(TAG, "进行重试上传票据，当前为重试的第 " .. tostring(retry_number) .. " 次")
        ios_upload_receipt_method(product_id, trans_id, trade_id, trans_state, original_trans_id, cb, retry_number)
      elseif cb then
        cb(succ, ...)
      end
    end
  end)
end

local g_store_front

function M.get_store_front_data()
  if not g_store_front then
    local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_STORE_FRONT, {}, nil)
    g_store_front = ret
  end
  return g_store_front
end

function M.has_unfinished_transaction()
  local result = EJOY_PAY_HAS_UNFINISHED_PAY_ORDER:get()
  E.LOG.debug(TAG, "has_unfinished_transaction === " .. tostring(result))
  return result or false
end

function M.show_loading_ios()
  if _ejoysdk.os() == "ios" then
    UNI.sync_call(VENDOR_NAME, SYNC_SHOW_LOADING, {}, nil)
  end
end

function M.hide_loading_ios()
  if _ejoysdk.os() == "ios" then
    UNI.sync_call(VENDOR_NAME, SYNC_HIDE_LOADING, {}, nil)
  end
end

local function ios_check_purchases_unfinished(prd_id, from_loop)
  E.LOG.debug(TAG, "iOS平台，ios_check_purchases_unfinished ----called")
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_ALL_UNFINISH_TRANSACTIONS, {}, nil)
  E.LOG.debug(TAG, "SYNC_GET_ALL_UNFINISH_TRANSACTIONS, get data ===")
  E.LOG.debug(TAG, ret)
  local has_unfinish_trade = false
  if ret and next(ret) then
    for _k, item in pairs(ret) do
      local state = tonumber(item.transactionState)
      local product_id = item.productIdentifier
      local trans_id = item.transactionIdentifier
      local trade_id = item.applicationUsername
      local trans_state = item.transactionState
      local original_trans_id
      if item.originalTransaction and item.originalTransaction.transactionIdentifier then
        original_trans_id = item.originalTransaction.transactionIdentifier
      end
      if 1 == state or 3 == state then
        if prd_id and tostring(prd_id) == tostring(product_id) then
          has_unfinish_trade = true
        end
        local temp_params = {
          product_id = product_id,
          trans_id = trans_id,
          trade_id = trade_id
        }
        local biz_co = "sdk.apple_pay_init_login"
        if prd_id then
          biz_co = "sdk.apple_pay_start"
        elseif from_loop then
          biz_co = "sdk.loop_check_unfinished_transaction"
        end
        local biz_func = "sdk.apple_pay_reorder"
        ESTAT.app_pay_report({
          biz_func = biz_func,
          biz_act = "start",
          biz_co = biz_co,
          biz_params = temp_params
        })
        ios_upload_receipt_method(product_id, trans_id, trade_id, trans_state, original_trans_id, function(succ, ...)
          E.LOG.debug(TAG, "上传票据结果：succ = " .. tostring(succ))
          if succ then
            local resp_data = (...)
            E.LOG.debug(TAG, "resp_data =====")
            E.LOG.debug(TAG, resp_data)
          else
            local code, msg = ...
            E.LOG.debug(TAG, "code =" .. tostring(code) .. ", msg = " .. tostring(msg))
          end
          ESTAT.app_pay_report({
            biz_func = biz_func,
            biz_act = "finish",
            biz_st = succ and "succ" or "fail",
            biz_co = biz_co,
            biz_params = {
              all_unfinish_transactions = ret,
              http_request_body = temp_params,
              http_resp_body = {
                ...
              }
            }
          })
        end)
      end
    end
  end
  return has_unfinish_trade
end

local function ios_pay_result_handler(succ, _order_id, ext_params)
  EJOY_PAY_HAS_UNFINISHED_PAY_ORDER:set(true)
  local prefix_message = "{" .. LANG.getStringSuitCNOverseas("code", "") .. ":"
  E.LOG.debug(TAG, "pay result: succ = " .. tostring(succ) .. ", _order_id = " .. tostring(_order_id))
  E.LOG.debug(TAG, ext_params)
  local pay_result = ext_params
  if not succ then
    pay_result = ext_params.ext
  end
  local product_id = pay_result.productIdentifier
  local trans_id = pay_result.transactionIdentifier
  local trade_id = pay_result.applicationUsername
  local trans_state = pay_result.transactionState
  local original_trans_id
  if pay_result.originalTransaction and pay_result.originalTransaction.transactionIdentifier then
    original_trans_id = pay_result.originalTransaction.transactionIdentifier
  end
  local pay_param = {product_id = product_id}
  E.LOG.debug(TAG, "pay_param ====")
  E.LOG.debug(TAG, pay_param)
  if ejoy_pay_span then
    ATracer.finish_pay_sub_span(ejoy_pay_span, {
      succ = succ,
      order_id = _order_id,
      ext_params = ext_params
    })
    ejoy_pay_span = nil
  end
  if succ then
    ios_upload_receipt_method(product_id, trans_id, trade_id, trans_state, original_trans_id, function(succ2, ...)
      E.LOG.debug(TAG, "上传票据结束， succ = " .. tostring(succ2))
      if _order_id and "apple_reorder_success" == _order_id then
        E.LOG.debug(TAG, "当前是苹果补单成功回来的处理，不再回调给游戏了，因为之前支付下单时已经回调过游戏了")
        ESTAT.app_pay_report({
          biz_func = "sdk.apple_reorder_success",
          biz_act = "finish",
          biz_st = succ and "succ" or "fail",
          biz_co = succ and "200" or "400",
          biz_params = {
            ext_params = ext_params,
            http_resp_body = {
              ...
            }
          }
        })
        return
      end
      if succ2 then
        M.hide_loading_ios()
        local resp_data = (...)
        pay_listener(succ2, _order_id, resp_data)
      else
        M.hide_loading_ios()
        local code, msg = ...
        local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
        local receipt_str = ret and ret.receipt
        local resp = {
          code = code,
          msg = msg,
          ext = {
            pay_part = "upload_receipt_order",
            receipt_str = tostring(receipt_str),
            ext_params = ext_params,
            last_pay_product_id = last_pay_product_id,
            http_resp_body = {
              ...
            }
          }
        }
        pay_listener(false, _order_id, resp)
        local tip_msg = LANG.getStringSuitCNOverseas("pay_ios_fail_common", "")
        tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
        E.Modal.open(LANG.getStringSuitCNOverseas("tips", ""), {
          message = tip_msg,
          buttons = {
            LANG.getStringSuitCNOverseas("confirm", "")
          }
        })
      end
    end)
  else
    local code = ext_params.code or pay_result.code
    local msg = ext_params.msg or tostring(pay_result.msg)
    if 2 == code then
      E.LOG.debug(TAG, "本次是支付取消，需要关闭当前订单")
      finish_transaction_with_product_id_and_trans_id(product_id, trans_id)
    end
    if not util.STR.is_empty(trans_id) then
      E.LOG.debug(TAG, "支付失败时，苹果返回的渠道订单号有值，此时进行一次票据上传, trans_id = " .. tostring(trans_id))
      ios_upload_receipt_method(product_id, trans_id, trade_id, trans_state, original_trans_id, function()
      end)
    end
    local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
    local receipt_str = ret and ret.receipt
    local resp = {
      code = code,
      msg = msg,
      ext = {
        pay_part = "channel_order",
        receipt_str = tostring(receipt_str),
        ext_params = ext_params
      }
    }
    PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_SDK_REPORT_ORDER_IOS, {receipt = receipt_str, ext_params = ext_params}, function(...)
      E.LOG.debug(TAG, "支付的异常上报接口返回了, body=")
      E.LOG.debug(TAG, {
        ...
      })
    end)
    M.hide_loading_ios()
    pay_listener(false, _order_id, resp)
    if 2 == resp.code or 5 == resp.code then
      E.LOG.debug(TAG, "SKErrorPaymentCancelled和SKErrorStoreProductNotAvailable 两种错误不用弹窗提示给用户")
      return
    end
    local tip_msg = LANG.getStringSuitCNOverseas("pay_ios_fail_long", "")
    if 7004104 == code then
      tip_msg = LANG.getStringSuitCNOverseas("pay_network_delay", "")
    end
    tip_msg = tip_msg .. prefix_message .. tostring(resp.code) .. "}"
    E.Modal.open(LANG.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG.getStringSuitCNOverseas("confirm", "")
      }
    })
  end
end

function M.pay(gp_order_id, _ds_order_id, product, pay_params)
  local prefix_message = "{" .. LANG.getStringSuitCNOverseas("code", "") .. ":"
  E.LOG.debug(TAG, "支付前先检查下有无未结束的订单")
  if ios_check_purchases_unfinished(product.product_id) then
    E.LOG.debug(TAG, "当前存在未结束的订单")
    local code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_HAS_UNFINISHED_TRANSACTION
    local tip_msg = LANG.getStringSuitCNOverseas("pay_ios_frequency", "")
    tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
    E.LOG.debug(TAG, {tip_msg = tip_msg})
    E.Modal.open(LANG.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG.getStringSuitCNOverseas("confirm", "")
      }
    })
    local resp = {
      code = code,
      msg = tip_msg,
      ext = {
        product_id = product.product_id,
        pay_part = "ejoy_pay_unfinished_transaction"
      }
    }
    pay_listener(false, gp_order_id, resp)
    return
  end
  M.show_loading_ios()
  ejoy_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.EJOY_PAY_IOS)
  if 0 == util.tablelength(apple_product_infos) then
    apple_product_infos = UNI.sync_call(VENDOR_NAME, SYNC_GET_APPLE_PRODUCTINFOS, {}, nil)
    E.LOG.debug(TAG, "apple_product_infos =====")
    E.LOG.debug(TAG, apple_product_infos)
  end
  local appleProduct = apple_product_infos[product.product_id]
  E.LOG.debug(TAG, {appleProduct = appleProduct})
  if appleProduct then
    pay_params.pay_title = appleProduct.localizedTitle
    pay_params.pay_amout = tostring(appleProduct.price)
    pay_params.pay_currency = appleProduct.priceLocale and appleProduct.priceLocale.currencyCode
    pay_params.pay_language = appleProduct.priceLocale and appleProduct.priceLocale.languageCode
  end
  pay_params.prd_name = pay_params.pay_title
  pay_params.notify_url = get_notify_url()
  E.LOG.debug(TAG, "ejoy pay, pay_params = ")
  E.LOG.debug(TAG, pay_params)
  local gps_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.GPS_PAY)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER_IOS, pay_params, function(succ, ...)
    ATracer.finish_pay_sub_span(gps_pay_span, {
      ...
    })
    local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
    local receipt_str = ret and ret.receipt
    local temp_data = (...)
    ESTAT.app_pay_report({
      biz_func = "sdk.show_apple_pay",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        product_id = product.product_id,
        gp_order_id = gp_order_id,
        ds_order_id = _ds_order_id,
        trade_id = succ and temp_data and temp_data.trade_id or nil,
        receipt_str = receipt_str
      }
    })
    if succ then
      local data = (...)
      local trade_id = data.trade_id
      E.LOG.debug(TAG, "支付预下单成功，trade_id = " .. tostring(trade_id))
      pay_params.applicationUsername = trade_id
      ESTAT.app_pay_report({
        biz_func = "sdk.apple_pay_result",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {
          product_id = product.product_id,
          gp_order_id = gp_order_id,
          ds_order_id = _ds_order_id,
          trade_id = data and data.trade_id or nil
        }
      })
      last_pay_product_id = product.product_id
      UNI.pay(VENDOR_NAME, gp_order_id, pay_params)
    else
      M.hide_loading_ios()
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
      local tip_msg = LANG.getStringSuitCNOverseas("pay_common_tips", "")
      tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
      E.Modal.open(LANG.getStringSuitCNOverseas("tips", ""), {
        message = tip_msg,
        buttons = {
          LANG.getStringSuitCNOverseas("confirm", "")
        }
      })
    end
  end)
end

local function set_player_info_handler(_player_info, _type)
  E.LOG.debug(TAG, "set_player_info_handler ----called")
  local result = EJOY_PAY_RESERVE_UPLOAD_FLAG:get()
  if not result and _ejoysdk.os() == "ios" then
    local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
    local receipt_str = ret and ret.receipt
    E.LOG.debug(TAG, "receipt_str ====")
    E.LOG.debug(TAG, receipt_str)
    if string.len(receipt_str) > 0 then
      E.LOG.debug(TAG, "本地有支付票据，开始上传票据，让服务器来判断是否预约票据")
      local player_info = GDP.PLAYER_INFO.clone()
      player_info.player_token = nil
      local pay_params = {player_info = player_info, receipt = receipt_str}
      local biz_func = "sdk.apple_pay_preorder"
      ESTAT.app_pay_report({
        biz_func = biz_func,
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = pay_params
      })
      PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_RESERVE_REPORT_IOS, pay_params, function(succ, ...)
        if succ then
          local data = (...)
          E.LOG.debug(TAG, "upload_reserve_receipt_to_server -----succ = " .. tostring(succ))
          E.LOG.debug(TAG, "上传预约票据成功")
          E.LOG.debug(TAG, data)
          EJOY_PAY_RESERVE_UPLOAD_FLAG:set(true)
        else
          local code, msg = ...
          E.LOG.debug(TAG, "上传预约票据失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
        end
        ESTAT.app_pay_report({
          biz_func = biz_func,
          biz_act = "finish",
          biz_st = succ and "succ" or "fail",
          biz_co = succ and "200" or "400",
          biz_params = {
            http_request_body = pay_params,
            http_resp_body = {
              ...
            }
          }
        })
      end)
    end
  else
    E.LOG.debug(TAG, "已经检查过预约了，不再需要重复检查是否预约票据")
  end
end

local function start_loop_check_unfinished_transaction()
  E.LOG.debug(TAG, "start_loop_check_unfinished_transaction ----- called")
  local need_check = true
  local user_id = EG.user_info().uid
  if util.STR.is_empty(user_id) then
    E.LOG.debug(TAG, "当前user_id为空，用户未登录，不需要轮询检查iOS支付有无未结束订单了")
    need_check = false
  else
    local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
    local receipt_str = ret and ret.receipt
    if util.STR.is_empty(receipt_str) then
      E.LOG.debug(TAG, "当前receipt_str票据为空，不需要轮询检查iOS支付有无未结束订单了")
      need_check = false
    end
  end
  if need_check then
    E.LOG.debug(TAG, "轮询检查通过，开始检查有无未结束的订单")
    ios_check_purchases_unfinished(nil, true)
  end
  local loop_gap = 180
  E.Timer.once(loop_gap, function()
    start_loop_check_unfinished_transaction()
  end)
end

local has_account_login = false

local function acquire_handler(_user_info)
  E.LOG.debug(TAG, "acquire_handler ---called")
  E.LOG.debug(TAG, "登录成功后，先检查下有无未结束的订单")
  has_account_login = true
  ios_check_purchases_unfinished()
end

function M.setupInitPaySDK(opt)
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "init ejoy pay ios vendor")
  local param = {
    pay_game_id = E.get_game_id()
  }
  UNI.sync_call(VENDOR_NAME, SYNC_EJOYPAY_INT, param, nil)
  local result = UNI.sync_call(VENDOR_NAME, SYNC_SUPPORT_CLOSE_TRANS_ID, {}, nil)
  E.LOG.debug(TAG, {SYNC_SUPPORT_CLOSE_TRANS_ID = result})
  is_support_trans_id_finish_transaction = result and result.support or false
  E.LOG.debug(TAG, {is_support_trans_id_finish_transaction = is_support_trans_id_finish_transaction})
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, set_player_info_handler)
  UNI.register_pay_listener(VENDOR_NAME, function(succ, _order_id, ext_params)
    if _ejoysdk.os() == "ios" then
      ESTAT.app_pay_report({
        biz_func = "sdk.apple_pay_result",
        biz_act = "finish",
        biz_st = succ and "succ" or "fail",
        biz_co = succ and "200" or "400",
        biz_params = {ext_params = ext_params, order_id = _order_id}
      })
      if has_account_login then
        ios_pay_result_handler(succ, _order_id, ext_params)
      else
        E.LOG.debug(TAG, "当前是初始化后还未登录的时机，此时苹果的补单来了，不直接进行上传票据，避免服务器有错误告警")
        local ret = UNI.sync_call(VENDOR_NAME, SYNC_GET_RECEIPT, {}, nil)
        local receipt_str = ret and ret.receipt
        PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_SDK_REPORT_ORDER_IOS, {
          receipt = receipt_str,
          ext_params = ext_params,
          from = "sdk.init_not_login"
        }, function(...)
          E.LOG.debug(TAG, "支付的异常上报接口返回了, body=")
          E.LOG.debug(TAG, {
            ...
          })
        end)
      end
    end
  end)
  start_loop_check_unfinished_transaction()
end

return M
