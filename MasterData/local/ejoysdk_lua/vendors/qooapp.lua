local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CHANNEL = "QOOAPP"
local TAG = EM.MODULE.VENDORS.QOOAPP
local M = Vendor:Inherit(CHANNEL)
local QOOAPP_PAY_TYPE = "247"
local ASYNC_QOOAPP_INIT = "ASYNC_QOOAPP_INIT"
local ASYNC_QOOAPP_LOGIN = "ASYNC_QOOAPP_LOGIN"
local ASYNC_QOOAPP_RESTORE_PURCHASES = "ASYNC_QOOAPP_RESTORE_PURCHASES"
local ASYNC_QOOAPP_PAY = "ASYNC_QOOAPP_PAY"
local pay_listener
local qooapp_init_success = false
local qooapp_login_success = false

local function get_notify_url()
  local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
  do return end
  return ejoy_pay.get_notify_url
end

local function notify_server_for_deliver_product(body, cb)
  local params = {
    pay_type = QOOAPP_PAY_TYPE,
    inapp_purchase_data = JSON.encode(body),
    notify_url = get_notify_url()
  }
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_UPLOAD_RECEIPT, params, function(succ, ...)
    ESTAT.app_pay_report({
      biz_func = "sdk.qooapp_upload_receipt",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        http_request_body = params,
        http_resp_body = {
          ...
        }
      }
    })
    if succ then
      E.LOG.debug(TAG, "notify_server_for_deliver_product -----succ = " .. tostring(succ))
      E.LOG.debug(TAG, "上传票据成功")
    else
      local code, msg, body_json = ...
      E.LOG.debug(TAG, "notify_server_for_deliver_product -----fail, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      E.LOG.debug(TAG, {body_json = body_json})
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

local function check_loop_upload_to_server_with_qooapp_pay_body(body, is_pay, cb)
  if body and 2 == body.encVersion and body.data then
    local decode_succ, decode_data = pcall(_ejoysdk_crypt.base64decode, body.data)
    E.LOG.debug(TAG, {decode_data = decode_data})
    if true == decode_succ then
      local json_data = JSON.safe_decode(decode_data)
      E.LOG.debug(TAG, {json_data = json_data})
      if is_pay and json_data and next(json_data) then
        body.payload = json_data
        notify_server_for_deliver_product(body, cb)
      elseif json_data and next(json_data) then
        for _k, item in pairs(json_data) do
          E.LOG.debug(TAG, {item = item})
          body.payload = item
          E.LOG.debug(TAG, "after sdk handler body")
          E.LOG.debug(TAG, {after_body = body})
          notify_server_for_deliver_product(body, cb)
        end
      end
    else
      E.LOG.error(TAG, "base64decode error")
      local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_QOOAPP_BODY_BASE64DECODE_FAIL
      local message = "qooapp body base64decode error"
      if cb then
        cb(false, code, message)
      end
      ESTAT.app_pay_report({
        biz_func = "sdk.qooapp_decode_body_fail",
        biz_act = "finish",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {body = body}
      })
    end
  else
    E.LOG.error(TAG, "body.data is nil or body.encVersion not 2")
    local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_QOOAPP_BODY_WRONG_FORMAT
    local message = "qooapp body wrong format"
    if cb then
      cb(false, code, message)
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.qooapp_body_wrong_data",
      biz_act = "finish",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {body = body}
    })
  end
end

local function check_unfinished_purchase()
  E.LOG.debug(TAG, "check_unfinished_purchase  ---called")
  UNI.async_call(CHANNEL, ASYNC_QOOAPP_RESTORE_PURCHASES, {}, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "check_unfinished_purchase succ")
      local body = (...)
      E.LOG.debug(TAG, {before_body = body})
      check_loop_upload_to_server_with_qooapp_pay_body(body)
    else
      E.LOG.error(TAG, "check_unfinished_purchase fail")
      local code, body = ...
      E.LOG.debug(TAG, {code = code, body = body})
      ESTAT.app_pay_report({
        biz_func = "sdk.qooapp_restore_purchase_fail",
        biz_act = "finish",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {body = body}
      })
    end
  end)
end

local function show_alert_and_callback_fail_to_game(current_gp_order_id, channel_pay_params, code, body, pay_part)
  local resp = {
    code = code,
    msg = body and body.message or "default qooapp pay error message",
    ext = {
      pay_part = pay_part,
      prd_id = channel_pay_params.productId,
      channel_pay_params = channel_pay_params,
      ext_params = body
    }
  }
  pay_listener(false, current_gp_order_id, resp)
  if code == CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL then
    E.LOG.debug(TAG, "当前是取消支付，不需要弹窗提示")
    return
  end
  local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", "")
  tip_msg = tip_msg .. "{" .. tostring(resp.code) .. "}"
  E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
    message = tip_msg,
    buttons = {
      LANG_UTIL.getStringSuitCNOverseas("confirm", "")
    }
  })
end

local function launch_qooapp_pay_page(current_gp_order_id, channel_pay_params)
  ESTAT.app_pay_report({
    biz_func = "sdk.qooapp_pay_result",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  UNI.async_call(CHANNEL, ASYNC_QOOAPP_PAY, channel_pay_params, nil, function(succ, ...)
    ESTAT.app_pay_report({
      biz_func = "sdk.qooapp_pay_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        channel_pay_params = channel_pay_params,
        body = {
          ...
        }
      }
    })
    if succ then
      E.LOG.debug(TAG, "native pay succ")
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      check_loop_upload_to_server_with_qooapp_pay_body(body, true, function(succ2, ...)
        E.LOG.debug(TAG, "launch_qooapp_pay_page, notify_server_for_deliver_product result = " .. tostring(succ2))
        E.LOG.debug(TAG, {
          ...
        })
        if succ2 then
          local success_body = (...)
          pay_listener(succ2, current_gp_order_id, success_body)
        else
          local code, _message = ...
          E.LOG.debug(TAG, {body = body})
          show_alert_and_callback_fail_to_game(current_gp_order_id, channel_pay_params, code, body, "qooapp_upload_receipt_order")
        end
      end)
    else
      E.LOG.error(TAG, "native pay fail")
      local code, body = ...
      E.LOG.debug(TAG, {body = body})
      show_alert_and_callback_fail_to_game(current_gp_order_id, channel_pay_params, code, body, "qooapp_channel_order")
    end
  end)
end

function M.pay(product_id, gp_order_id, ds_order_id, attach_info_str, local_params)
  E.LOG.d(TAG, "start pay, params >>")
  E.LOG.d(TAG, {
    product_id = product_id,
    gp_order_id = gp_order_id,
    ds_order_id = ds_order_id,
    attach_info_str = attach_info_str
  })
  E.log(local_params)
  if not qooapp_init_success or not qooapp_login_success then
    E.LOG.debug(TAG, {qooapp_init_success = qooapp_init_success, qooapp_login_success = qooapp_login_success})
    local code, msg, pay_part, tip_msg
    if not qooapp_init_success then
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_QOOAPP_NOT_INIT_SUCCESS
      msg = "QOOAPP has not init success, can not pay now"
      pay_part = "qooapp_pay_not_init_success"
      tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", "")
    elseif not qooapp_login_success then
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_QOOAPP_NOT_LOGIN_SUCCESS
      msg = "QOOAPP has not login success, can not pay now"
      pay_part = "qooapp_pay_not_login_success"
      tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_vendor_can_not_pay_tips", "")
    end
    local resp = {
      code = code,
      msg = msg,
      ext = {product_id = product_id, pay_part = pay_part}
    }
    pay_listener(false, gp_order_id, resp)
    tip_msg = tip_msg .. "{" .. tostring(resp.code) .. "}"
    E.LOG.debug(TAG, {tip_msg = tip_msg})
    E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
      message = tip_msg,
      buttons = {
        LANG_UTIL.getStringSuitCNOverseas("confirm", "")
      }
    })
    return
  end
  check_unfinished_purchase()
  local product = local_params.product_info
  local current_gp_order_id = local_params.gp_order_id
  local player_info = GDP.PLAYER_INFO.clone()
  local ext_info = {}
  if attach_info_str then
    ext_info = JSON.decode(attach_info_str)
  end
  local pay_params = {
    cpOrderId = ds_order_id,
    payProductID = product.product_id,
    payProductName = product.product_desc,
    currency = ext_info.currency,
    order_amt = ext_info.order_amt,
    pay_type = QOOAPP_PAY_TYPE,
    player_info = JSON.encode(player_info),
    notify_url = get_notify_url()
  }
  if product.min_order_amt then
    pay_params.min_order_amt = tostring(product.min_order_amt)
  end
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    if succ then
      local data = (...)
      local trade_id = data.trade_id
      E.LOG.debug(TAG, "支付预下单成功，trade_id = " .. tostring(trade_id))
      local channel_pay_params = {
        productId = product.product_id,
        cpOrderId = trade_id,
        developerPayload = "default developerPayload string"
      }
      launch_qooapp_pay_page(current_gp_order_id, channel_pay_params)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      local resp = {
        code = code,
        msg = msg,
        ext = {
          pay_part = "qooapp_gps_order",
          product_id = tostring(product_id),
          http_resp_body = {
            ...
          }
        }
      }
      pay_listener(false, local_params.gp_order_id, resp)
      local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", "")
      tip_msg = tip_msg .. "{" .. tostring(code) .. "}"
      E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
        message = tip_msg,
        buttons = {
          LANG_UTIL.getStringSuitCNOverseas("confirm", "")
        }
      })
    end
  end)
end

local function acquire_handler(_user_info)
  E.LOG.debug(TAG, "acquire_handler ---called")
  E.LOG.debug(TAG, {qooapp_init_success = qooapp_init_success})
  if qooapp_init_success then
    local current_info = EG.user_info()
    local login_params = {
      account_id = current_info.uid
    }
    E.LOG.debug(TAG, {login_params = login_params})
    UNI.async_call(CHANNEL, ASYNC_QOOAPP_LOGIN, login_params, nil, function(succ, ...)
      ESTAT.app_pay_report({
        biz_func = "sdk.qooapp_login_result",
        biz_act = "finish",
        biz_st = succ and "succ" or "fail",
        biz_co = succ and "200" or "400",
        biz_params = {
          login_params = login_params,
          body = {
            ...
          }
        }
      })
      if succ then
        E.LOG.debug(TAG, "native login succ")
        local body = (...)
        E.LOG.debug(TAG, {body = body})
        qooapp_login_success = true
        check_unfinished_purchase()
      else
        E.LOG.error(TAG, "native login fail")
        local code, body = ...
        E.LOG.debug(TAG, {code = code, body = body})
      end
    end)
  else
    E.LOG.error(TAG, "灵犀账号acquire成功后，qooapp还没初始化完成，此时不能绑定灵犀账号")
    ESTAT.app_pay_report({
      biz_func = "sdk.qooapp_login_not_init",
      biz_act = "finish",
      biz_st = "succ",
      biz_co = "200"
    })
  end
end

local inited = false

function M.init(opt, cb)
  E.LOG.debug(TAG, "qooapp init function called")
  if inited then
    E.LOG.debug(TAG, "qooapp vendor had inited")
    if cb then
      cb(true)
    end
    return
  end
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "call native qooapp vendor init")
  inited = true
  if cb then
    cb(true)
  end
  UNI.async_call(CHANNEL, ASYNC_QOOAPP_INIT, {}, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "native init succ")
      local body = (...)
      E.LOG.debug(TAG, "init callback")
      E.LOG.debug(TAG, {body = body})
      qooapp_init_success = true
    else
      E.LOG.error(TAG, "native init fail")
      local code, body = ...
      E.LOG.debug(TAG, {code = code, body = body})
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.qooapp_init_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        ...
      }
    })
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
end

function M.login(_ext, _cb)
  E.LOG.debug(TAG, "call login function >>")
end

function M.check_token(_outsource, _info)
  E.LOG.debug(TAG, "check_token called----")
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.logout()
  E.LOG.debug(TAG, "logout called----")
end

M:is_implemented({"ACCOUNT"})
return M
