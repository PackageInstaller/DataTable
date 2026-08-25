local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local CHANNEL = "OPPO"
local TAG = EM.MODULE.VENDORS.OPPO
local OPPO = Vendor:Inherit(CHANNEL)
local inited = false
local isOPPO, pay_listener, oppoAppId
local OPPO_PAY_TYPE = "261"
local ASYNC_OPPO_LOGIN = "ASYNC_OPPO_LOGIN"
local ASYNC_DO_OPPO_PAY = "ASYNC_DO_OPPO_PAY"
local SYNC_IS_OPPO_DEVICES = "SYNC_IS_OPPO_DEVICES"
local SYNC_CHANNEL_INIT = "SYNC_CHANNEL_INIT"
local g_oppo_account_id

local function check_oppo_device()
  if nil ~= isOPPO then
    E.LOG.debug(TAG, "isOPPO no nil, do not check again")
    return
  end
  local ret = UNI.sync_call(CHANNEL, SYNC_IS_OPPO_DEVICES, {}, nil)
  if ret then
    isOPPO = ret.isOPPO
  end
end

function OPPO.init(opt, cb)
  E.LOG.debug(TAG, "OPPO init start")
  E.LOG.debug(TAG, {params = opt})
  if _ejoysdk.os() ~= "android" then
    E.LOG.debug(TAG, "is not support")
    cb(true)
    return
  end
  if inited then
    E.LOG.debug(TAG, "oppo vendor is inited")
    cb(true)
    return
  end
  inited = true
  oppoAppId = opt and opt.appid
  pay_listener = opt.pay_listener
  check_oppo_device()
  if isOPPO then
    UNI.sync_call(CHANNEL, SYNC_CHANNEL_INIT, {}, nil)
  end
  cb(true)
end

function OPPO.union_login(cb)
  local airline_v2 = require("ejoysdk_lua.vendors.airline_v2")
  local params = {}
  airline_v2.show_login_h5(params, {}, cb)
end

function OPPO.login(_ext, cb)
  E.LOG.debug(TAG, "OPPO login start")
  local params = {}
  UNI.async_call(CHANNEL, ASYNC_OPPO_LOGIN, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "request union login return, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    ESTAT.app_pay_report({
      biz_func = "sdk.oppo_login_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        login_params = params,
        body = {
          ...
        }
      }
    })
    local channel_result
    if succ then
      local data = (...)
      local token = data.token
      local ssoid = data.ssoid
      local ticket = data.ticket
      g_oppo_account_id = ssoid
      local thirdPartyToken = {
        appId = oppoAppId,
        ssoid = ssoid,
        token = token,
        ticket = ticket
      }
      local user_info = {
        token = JSON.encode(thirdPartyToken)
      }
      channel_result = PROTOCOL.LoginResult.succ("oppo_login", user_info, {thirdparty_type = CHANNEL})
      E.LOG.debug(TAG, channel_result)
      if cb then
        cb(channel_result)
      end
    else
      local _, body = ...
      local code = (body or {}).error_code
      local message = (body or {}).error_msg
      channel_result = PROTOCOL.LoginResult.fail(code, message)
      E.LOG.debug(TAG, {ch_result = channel_result})
      if cb then
        cb(channel_result)
      end
    end
  end)
end

function OPPO.upload_login_result()
end

local function launch_oppo_pay(gp_order_id, channel_param)
  E.LOG.debug(TAG, {channel_param = channel_param})
  E.LOG.debug(TAG, "ASYNC_DO_OPPO_PAY ---start")
  ESTAT.app_pay_report({
    biz_func = "sdk.oppo_pay_result",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  UNI.async_call(CHANNEL, ASYNC_DO_OPPO_PAY, channel_param, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_DO_OPPO_PAY ---end")
    ESTAT.app_pay_report({
      biz_func = "sdk.oppo_pay_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        channel_param = channel_param,
        body = {
          ...
        }
      }
    })
    if succ then
      pay_listener(true, gp_order_id)
    else
      local _code, body = ...
      local error_code = body.error_code
      local error_msg = body.error_msg
      local is_cancel = false
      if "1004" == error_code then
        is_cancel = true
      end
      local resp = {
        code = is_cancel and CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL or CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_CHANNEL_ERROR,
        msg = "oppo pay fail",
        platform = CHANNEL,
        ext = {code = error_code, message = error_msg}
      }
      pay_listener(false, gp_order_id, resp)
    end
  end)
end

function OPPO.is_channel_device()
  if nil == isOPPO then
    check_oppo_device()
  end
  return isOPPO
end

function OPPO.channel_params()
  return {attributionChannel = "oppo", thirdPartyAppId = oppoAppId}
end

function OPPO.logout()
  E.LOG.debug(TAG, "logout called----")
end

function OPPO.pay(gp_order_id, ds_order_id, product, _ext_info)
  local money_yuan = tostring(tonumber(product.money) / 100.0)
  money_yuan = string.format("%.2f", money_yuan)
  local player_info = GDP.PLAYER_INFO.clone()
  player_info.player_token = nil
  local pay_params = {
    cpOrderId = ds_order_id,
    payProductID = product.product_id,
    payProductName = product.product_desc,
    pay_type = OPPO_PAY_TYPE,
    currency = product.money_type or "CNY",
    order_amt = money_yuan,
    player_info = player_info
  }
  if product.min_order_amt then
    pay_params.min_order_amt = tostring(product.min_order_amt)
  end
  E.LOG.debug(TAG, "oppo pay, pay_params = ")
  E.LOG.debug(TAG, pay_params)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    E.LOG.debug(TAG, "gps create order ----end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    ESTAT.app_pay_report({
      biz_func = "sdk.show_oppo_pay",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        pay_params = pay_params,
        body = {
          ...
        }
      }
    })
    if succ then
      local data = (...)
      local trade_id = data.trade_id
      local payBody = data.pay_body and JSON.safe_decode(data.pay_body)
      E.LOG.debug(TAG, "支付预下单成功，trade_id = " .. tostring(trade_id))
      local channel_param = {
        order_id = trade_id,
        amount = pay_params.min_order_amt,
        product_name = pay_params.payProductName,
        product_desc = product.product_id,
        account_id = EG.user_info().uid,
        oppo_account_id = g_oppo_account_id,
        role_id = player_info.player_id,
        pay_ticket = payBody and payBody.payTicket,
        callback_url = payBody and payBody.notifyUrl,
        attach = payBody and payBody.attach_info
      }
      launch_oppo_pay(gp_order_id, channel_param)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      local resp = {
        code = code,
        msg = msg,
        ext = {
          pay_part = "oppo_gps_order",
          product_id = tostring(product.product_id),
          http_resp_body = {
            ...
          }
        }
      }
      pay_listener(false, gp_order_id, resp)
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

function OPPO.report_account_info(_cddpResult)
  E.LOG.debug(TAG, "report account info, oppo do nothing")
end

function OPPO.supportAuth()
  E.LOG.debug(TAG, "check support oppo auth")
  if _ejoysdk.os() ~= "android" then
    return false
  end
  local sdk_infos = UNI.get_sdk_infos()
  E.LOG.debug(TAG, sdk_infos)
  if sdk_infos and sdk_infos[CHANNEL] then
    do return end
    return OPPO.is_channel_device, TAG, sdk_infos
  end
  return false
end

function OPPO.supportPay()
  return true
end

return OPPO
