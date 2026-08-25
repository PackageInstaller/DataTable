local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local UP = require("ejoysdk_lua.user_center.usercenter_protocol")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CHANNEL = "X7SY"
local TAG = EM.MODULE.VENDORS.X7SY
local X7SY_PAY_TYPE = "258"
local ASYNC_X7SY_PAY = "ASYNC_X7SY_PAY"
local M = Vendor:Inherit(CHANNEL)
local current_guid
local inited = false
local role_info = {}
local pay_listener, logout_listener

local function login_listener(account_result)
  E.LOG.debug(TAG, "receive login result")
  E.log(account_result)
  if account_result.ext and account_result.ext.account_data then
    local account_data = account_result.ext.account_data
    if account_data.thirdPartyType == "xiao7_login" then
      current_guid = account_data.thirdPartyUid
      E.LOG.debug(TAG, "save current guid >> " .. tostring(current_guid))
    end
  end
end

function M.login(_ext, cb)
  function M.login_cb(channel_result)
    E.LOG.debug(TAG, "login callback channel_result:")
    
    local ext = channel_result.ext or {}
    ext.guest_policy = UP.GUEST_POLICY.IGNORE
    channel_result.ext = ext
    if cb then
      E.log(channel_result)
      cb(channel_result)
    end
  end
  
  UNI.login(CHANNEL, {})
end

local function get_notify_url()
  local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
  do return end
  return ejoy_pay.get_notify_url
end

local function show_alert_and_callback_fail_to_game(current_gp_order_id, channel_pay_params, code, body, pay_part)
  local resp = {
    code = code,
    msg = body and body.message or "default x7sy pay error message",
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

local function launch_x7sy_pay_page(current_gp_order_id, channel_pay_params)
  ESTAT.app_pay_report({
    biz_func = "sdk.x7sy_pay_result",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  UNI.async_call(CHANNEL, ASYNC_X7SY_PAY, channel_pay_params, nil, function(succ, ...)
    ESTAT.app_pay_report({
      biz_func = "sdk.x7sy_pay_result",
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
      pay_listener(true, current_gp_order_id, body)
    else
      E.LOG.error(TAG, "native pay fail")
      local code, body = ...
      E.LOG.debug(TAG, {body = body})
      show_alert_and_callback_fail_to_game(current_gp_order_id, channel_pay_params, code, body, "x7sy_channel_order")
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
  local product = local_params.product_info
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
    pay_type = X7SY_PAY_TYPE,
    player_info = JSON.encode(role_info),
    notify_url = get_notify_url(),
    channel_user_id = current_guid
  }
  if product.min_order_amt then
    pay_params.min_order_amt = tostring(product.min_order_amt)
  end
  E.LOG.d(TAG, "start pay, pay_params >>")
  E.log(pay_params)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    if succ then
      local data = (...)
      local pay_body = JSON.decode(data.pay_body) or {}
      local game_orderid = pay_body.game_orderid
      E.LOG.debug(TAG, "支付预下单成功，trade_id = " .. tostring(game_orderid))
      E.log(data)
      local channel_pay_params = {
        productId = product.product_id,
        cpOrderId = game_orderid,
        developerPayload = "default developerPayload string",
        ex = data.pay_body or {}
      }
      launch_x7sy_pay_page(ds_order_id, channel_pay_params)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      local resp = {
        code = code,
        msg = msg,
        ext = {
          pay_part = "x7sy_gps_order",
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

function M.check_if_support_vendor(vendor_name)
  E.LOG.debug(TAG, "check_if_support_vendor " .. tostring(vendor_name))
  if not vendor_name then
    return false
  end
  local sdk_infos = UNI.get_sdk_infos()
  for sdk_name, sdk_info in pairs(sdk_infos) do
    if sdk_name == vendor_name then
      return true, sdk_info
    end
  end
  return false
end

local function set_player_info_handler(player_info, type)
  E.LOG.debug(TAG, "=================== start set_role_info ===========================")
  E.log(player_info)
  role_info = {
    player_id = player_info.player_id,
    player_name = player_info.player_name,
    role_level = player_info.level or "1",
    server_id = player_info.server_id,
    server_name = player_info.server_name or "test_srpc",
    opportunityType = type,
    game_guid = current_guid
  }
  E.LOG.debug(TAG, "=================== set_role_info ===========================")
  E.log(TAG, role_info)
  UNI.set_player_info(CHANNEL, role_info, type)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "x7sy init")
  if inited then
    E.LOG.debug(TAG, "x7sy vendor had inited")
    if cb then
      cb(true)
    end
    return
  end
  inited = true
  local sdk_info = UNI.get_sdk_info(CHANNEL)
  E.log(sdk_info)
  pay_listener = opt.pay_listener
  logout_listener = opt.logout_listener
  UNI.register_login_listener(CHANNEL, function(succ, info, ext_params)
    local channel_result
    if succ then
      E.LOG.debug(TAG, "aligames login success")
      E.LOG.debug(TAG, "info ===")
      E.LOG.debug(TAG, info)
      E.LOG.debug(TAG, "ext_params ===")
      E.LOG.debug(TAG, ext_params)
      local user_info = {
        token = info.token,
        uid = info.uid,
        guest = false
      }
      channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {
        channel_info = ext_params and ext_params.channel_info
      })
    else
      E.LOG.debug(TAG, "login fail---")
      local code = info.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local msg = info.msg or "login failed unknown reason"
      channel_result = PROTOCOL.LoginResult.fail(code, msg)
    end
    M.login_cb(channel_result)
  end)
  UNI.register_logout_listener(CHANNEL, logout_listener)
  ET.subscribe(ET.ACCOUNT.LOGIN, login_listener)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  if cb then
    cb(true)
  end
end

function M.logout()
  E.LOG.debug(TAG, "start logout called----")
  UNI.logout(CHANNEL)
end

function M.merge_info(info, pinfo)
  do return M.merge_helper, info end
  return M.merge_helper, info, pinfo
end

function M.simple_token()
  return false
end

function M.check_token(_outsource, _info)
  M.login()
end

function M.can_show_user_center()
  return false
end

M:is_implemented({"ACCOUNT"})
return M
