local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local AL = require("ejoysdk_lua.account.service.account_login")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local SC = require("ejoysdk_lua.user_center.system_config")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CHANNEL = "XIAOMI"
local MI_LOGIN_TYPE = USER.get_third_party_type_by_vendor(CHANNEL)
local TAG = EM.MODULE.VENDORS.XIAOMI
local MI = Vendor:Inherit(CHANNEL)
local inited = false
local isXiaomi, miAppId, pay_listener, cddpResultCache, xiaomi_pay_status
local XIAOMI_PAY_TYPE = "260"
local ACCOUNT_TYPE = {
  OFFICIAL = "official_account",
  XIAOMI = "mi_account"
}
local accountType = ACCOUNT_TYPE.OFFICIAL
local xiaomi_uid
local ASYNC_CHANNEL_INIT = "ASYNC_CHANNEL_INIT"
local ASYNC_UNION_LOGIN = "ASYNC_UNION_LOGIN"
local ASYNC_DO_XIAOMI_PAY = "ASYNC_DO_XIAOMI_PAY"
local ASYNC_QUERY_PURCHASES = "ASYNC_QUERY_PURCHASES"
local ASYNC_FINISH_PURCHASES = "ASYNC_FINISH_PURCHASES"
local ASYNC_REPORT_GAME_ROLE = "ASYNC_REPORT_GAME_ROLE"
local SYNC_IS_XIAOMI_DEVICES = "SYNC_IS_XIAOMI_DEVICES"
local ASYNC_CHECK_PAY_STATUS = "ASYNC_CHECK_PAY_STATUS"
local ASYNC_BIND_ACCOUNT = "ASYNC_BIND_ACCOUNT"

local function notify_server_for_deliver_product(body, trade_id, cb)
  local params = {
    pay_type = XIAOMI_PAY_TYPE,
    inapp_purchase_data = JSON.encode(body),
    trade_id = trade_id
  }
  E.LOG.debug(TAG, {params = params})
  E.LOG.debug(TAG, "call verify interface now")
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_UPLOAD_RECEIPT, params, function(succ, ...)
    local error_code
    if not succ then
      error_code = (...)
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.xiaomi_upload_receipt",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or tostring(error_code),
      biz_params = {
        http_request_body = params,
        code = error_code,
        http_resp_body = {
          ...
        }
      }
    })
    E.LOG.debug(TAG, {
      ...
    })
    if succ then
      E.LOG.debug(TAG, "notify_server_for_deliver_product -----succ = " .. tostring(succ))
      E.LOG.debug(TAG, "verify interface called success")
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

local function check_pay_status()
  E.LOG.debug(TAG, "ASYNC_CHECK_PAY_STATUS --start")
  UNI.async_call(CHANNEL, ASYNC_CHECK_PAY_STATUS, {}, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_CHECK_PAY_STATUS ---end, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    if succ then
      local body = (...)
      local status = body.status
      xiaomi_pay_status = status
    else
      E.LOG.debug(TAG, "ASYNC_CHECK_PAY_STATUS fail")
    end
  end)
end

local function finish_purchases(purchases)
  E.LOG.debug(TAG, "ASYNC_FINISH_PURCHASES ---start")
  local params = {}
  params.purchaseToken = purchases.purchaseToken
  params.purchaseOrderId = purchases.purchaseOrderId
  params.cpUserInfo = purchases.cpUserInfo
  params.packageName = E.Sysinfo.package_name()
  params.appId = miAppId
  params.productType = purchases.productType
  local gps_order_id = purchases.cpOrderId
  notify_server_for_deliver_product(params, gps_order_id, function(succ, ...)
    if succ then
      UNI.async_call(CHANNEL, ASYNC_FINISH_PURCHASES, params, nil, function(succ2, ...)
        E.LOG.debug(TAG, "ASYNC_FINISH_PURCHASES ---end, succ >> " .. tostring(succ2))
        E.LOG.debug(TAG, {
          ...
        })
      end)
    else
      local code, message = ...
      E.LOG.debug(TAG, "notify server for deliver product fail, code = " .. tostring(code) .. ", message = " .. tostring(message))
    end
  end)
end

local function query_purchases()
  E.LOG.debug(TAG, "ASYNC_QUERY_PURCHASES ---start")
  UNI.async_call(CHANNEL, ASYNC_QUERY_PURCHASES, {}, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_QUERY_PURCHASES ---end, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    if succ then
      local body = (...)
      local purchaseData = body.purchaseData
      E.LOG.debug(TAG, purchaseData)
      E.LOG.debug(TAG, "purchaseData length >> " .. tostring(#purchaseData))
      if purchaseData and #purchaseData > 0 then
        for _, data in ipairs(purchaseData) do
          finish_purchases(data)
        end
      end
    else
      local _code, body = ...
      local error_code = body.error_code
      local error_msg = body.error_msg
      E.LOG.debug(TAG, "ASYNC_QUERY_PURCHASES fail")
      ESTAT.app_pay_report({
        biz_func = "sdk.xiaomi_query_purchases_fail",
        biz_act = "finish",
        biz_st = "fail",
        biz_co = tostring(error_code),
        biz_params = {
          code = error_code,
          message = error_msg,
          body = {
            ...
          }
        }
      })
    end
  end)
end

local function launch_xiaomi_pay(gp_order_id, channel_param)
  E.LOG.debug(TAG, {channel_param = channel_param})
  E.LOG.debug(TAG, "ASYNC_DO_XIAOMI_PAY ---start")
  ESTAT.app_pay_report({
    biz_func = "sdk.xiaomi_pay_result",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  UNI.async_call(CHANNEL, ASYNC_DO_XIAOMI_PAY, channel_param, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_DO_XIAOMI_PAY ---end")
    E.LOG.debug(TAG, {
      ...
    })
    ESTAT.app_pay_report({
      biz_func = "sdk.xiaomi_pay_result",
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
      if "10303523" == error_code then
        query_purchases()
      end
      local is_cancel = false
      if "-18004" == error_code then
        is_cancel = true
      end
      local resp = {
        code = is_cancel and CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL or CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_CHANNEL_ERROR,
        msg = "xiaomi pay fail",
        platform = CHANNEL,
        ext = {code = error_code, message = error_msg}
      }
      pay_listener(false, gp_order_id, resp)
    end
  end)
end

local function check_xiaomi_device()
  if nil ~= isXiaomi then
    E.LOG.debug(TAG, "isXiaomi no nil, do not check again")
    return
  end
  local ret = UNI.sync_call(CHANNEL, SYNC_IS_XIAOMI_DEVICES, {}, nil)
  if ret then
    isXiaomi = ret.isXiaomi
    miAppId = ret.miAppId
  end
end

local function enable_mi_login_type()
  local login_config = UTILS.deepcopy(SC.get("login"))
  for _, item in ipairs(login_config) do
    if item and item.type and item.type == "XIAOMI" then
      return true
    end
  end
  return false
end

local function _bind_account_to_xiaomi(uid)
  local params = {account_id = uid, xiaomi_uid = xiaomi_uid}
  UNI.async_call(CHANNEL, ASYNC_BIND_ACCOUNT, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_BIND_ACCOUNT ---end, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
  end)
end

function MI.union_login(cb)
  if not enable_mi_login_type() then
    E.LOG.debug(TAG, "not enable xiaomi login type, do not launch xiaomi union login page")
    local airline_v2 = require("ejoysdk_lua.vendors.airline_v2")
    airline_v2.show_login_h5({}, {}, cb)
    return
  end
  
  local function cb_wrapper(login_result)
    if accountType == ACCOUNT_TYPE.XIAOMI then
      E.LOG.debug(TAG, "not bind account to xiaomi")
    end
    cb(login_result)
  end
  
  local params = {}
  params.change_account = true
  UNI.async_call(CHANNEL, ASYNC_UNION_LOGIN, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "request union login return, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    ESTAT.app_pay_report({
      biz_func = "sdk.xiaomi_login_result",
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
    if succ then
      local data = (...)
      accountType = data.accountType or ACCOUNT_TYPE.OFFICIAL
      if accountType == ACCOUNT_TYPE.OFFICIAL then
        local airline_v2 = require("ejoysdk_lua.vendors.airline_v2")
        airline_v2.show_login_h5(params, {}, cb)
      elseif accountType == ACCOUNT_TYPE.XIAOMI then
        xiaomi_uid = data.uid
        local auth_params = {
          appId = miAppId,
          uid = data.uid,
          serviceToken = data.serviceToken
        }
        AL.login(CHANNEL, auth_params, function(login_result)
          E.LOG.debug(TAG, "xiaomi account login return")
          E.LOG.debug(TAG, login_result)
          if login_result.platform then
            login_result.platform = MI_LOGIN_TYPE
          end
          if login_result and login_result.code == 4008017 then
            local authorization_info = {}
            if login_result.ext and login_result.ext.channel_result and login_result.ext.channel_result.token then
              authorization_info.token = login_result.ext.channel_result.token
              authorization_info.thirdPartyType = MI_LOGIN_TYPE
            end
            E.LOG.debug(TAG, "need launch bind page, authorization_info = ")
            E.LOG.debug(TAG, authorization_info)
            auth_params.authorization_info = authorization_info
            local airline_v2 = require("ejoysdk_lua.vendors.airline_v2")
            airline_v2.show_login_h5(auth_params, {}, cb_wrapper)
          else
            cb_wrapper(login_result)
          end
        end)
      end
    else
      local _, body = ...
      local code = (body or {}).error_code
      local message = (body or {}).error_msg
      local channel_result = PROTOCOL.LoginResult.fail(code, message)
      E.LOG.debug(TAG, {ch_result = channel_result})
      if cb then
        cb(channel_result)
      end
    end
  end)
end

function MI.login(params, cb)
  E.LOG.debug(TAG, "XIAOMI login start")
  local thirdPartyToken = {
    appId = params.appId,
    uid = params.uid,
    session = params.serviceToken
  }
  local user_info = {
    token = JSON.encode(thirdPartyToken)
  }
  local channel_result = PROTOCOL.LoginResult.succ(MI_LOGIN_TYPE, user_info, {thirdparty_type = CHANNEL})
  E.LOG.debug(TAG, channel_result)
  if cb then
    cb(channel_result)
  end
end

function MI.init(opt, cb)
  E.LOG.debug(TAG, "xiaomi init start")
  if _ejoysdk.os() ~= "android" then
    E.LOG.debug(TAG, "is not support")
    cb(true)
    return
  end
  if inited then
    E.LOG.debug(TAG, "xiaomi vendor is inited")
    cb(true)
    return
  end
  inited = true
  pay_listener = opt.pay_listener
  check_xiaomi_device()
  if isXiaomi then
    UNI.async_call(CHANNEL, ASYNC_CHANNEL_INIT, {}, nil, function(succ, ...)
      E.LOG.debug(TAG, "ASYNC_CHANNEL_INIT ---end, succ >> " .. tostring(succ))
      E.LOG.debug(TAG, {
        ...
      })
      if succ then
        E.LOG.debug(TAG, "ASYNC_CHANNEL_INIT success")
        check_pay_status()
        ET.subscribe(ET.gangplank.ACQUIRE, query_purchases)
        cb(true)
      else
        local _code, body = ...
        local error_code = body.error_code
        local error_msg = body.error_msg
        cb(false, error_code, error_msg)
      end
    end)
  else
    cb(true)
  end
end

function MI.is_channel_device()
  if nil == isXiaomi then
    check_xiaomi_device()
  end
  return isXiaomi
end

function MI.channel_params()
  return {
    attributionChannel = "attributionChannel",
    thirdPartyAppId = miAppId
  }
end

function MI.logout()
  E.LOG.debug(TAG, "logout called----")
end

function MI.pay(gp_order_id, ds_order_id, product, _ext_info)
  local money_yuan = tostring(tonumber(product.money) / 100.0)
  money_yuan = string.format("%.2f", money_yuan)
  local player_info = GDP.PLAYER_INFO.clone()
  player_info.player_token = nil
  local pay_params = {
    cpOrderId = ds_order_id,
    payProductID = product.product_id,
    payProductName = product.product_desc,
    pay_type = XIAOMI_PAY_TYPE,
    currency = product.money_type or "CNY",
    order_amt = money_yuan,
    player_info = player_info
  }
  if product.min_order_amt then
    pay_params.min_order_amt = tostring(product.min_order_amt)
  end
  E.LOG.debug(TAG, "xiaomi pay, pay_params = ")
  E.LOG.debug(TAG, pay_params)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    E.LOG.debug(TAG, "gps create order ----end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    ESTAT.app_pay_report({
      biz_func = "sdk.show_xiaomi_pay",
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
        product_desc = product.product_desc,
        product_id = product.product_id,
        cp_user_info = cddpResultCache,
        role_id = player_info.player_id,
        pay_ticket = payBody and payBody.payTicket,
        callback_url = payBody and payBody.notifyUrl
      }
      launch_xiaomi_pay(gp_order_id, channel_param)
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

function MI.report_account_info(player_info, cddpResult)
  E.LOG.debug(TAG, "report account info")
  E.LOG.debug(TAG, cddpResult)
  if cddpResult and cddpResult.cddpAdmc and cddpResult.cddpAccountId and cddpResult.cddpTime then
    local info = {
      channel = cddpResult.cddpAdmc,
      appuid = cddpResult.cddpAccountId,
      timestamp = cddpResult.cddpTime
    }
    cddpResultCache = info
    UNI.async_call(CHANNEL, ASYNC_REPORT_GAME_ROLE, player_info, nil, function(succ, ...)
      E.LOG.debug(TAG, "ASYNC_REPORT_GAME_ROLE ---end, succ >> " .. tostring(succ))
      E.LOG.debug(TAG, {
        ...
      })
      if succ then
        E.LOG.debug(TAG, "ASYNC_REPORT_GAME_ROLE success")
      else
        E.LOG.debug(TAG, "ASYNC_REPORT_GAME_ROLE fail")
      end
    end)
  else
    E.LOG.debug(TAG, "account info data invalid")
  end
end

function MI.supportAuth()
  return false
end

function MI.supportPay()
  return "success" == xiaomi_pay_status
end

return MI
