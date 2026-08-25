local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CHANNEL = "BILIBILI"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.BILIBILI
local SYNC_BILIBILI_SUPPORT = "SYNC_BILIBILI_SUPPORT"
local ASYNC_BILIBILI_INIT = "ASYNC_BILIBILI_INIT"
local ASYNC_BILIBILI_LOGIN = "ASYNC_BILIBILI_LOGIN"
local ASYNC_BILIBILI_PAY = "ASYNC_BILIBILI_PAY"
local CAST_BILIBILI_EXIT = "CAST_BILIBILI_EXIT"
local CAST_BILIBILI_START_HEART_BEAT = "CAST_BILIBILI_START_HEART_BEAT"
local CAST_BILIBILI_LOGOUT = "CAST_BILIBILI_LOGOUT"
local CAST_BILIBILI_NOTIFY_ZONE = "CAST_BILIBILI_NOTIFY_ZONE"
local CAST_BILIBILI_CREATE_ROLE = "CAST_BILIBILI_CREATE_ROLE"
local pay_listener, logout_listener

function M.channel_id()
  return 12
end

local function acquire_handler(_user_info)
  E.LOG.debug(TAG, "acquire_handler ---called")
  E.LOG.debug(TAG, "CAST_BILIBILI_START_HEART_BEAT----called")
  UNI.cast(CHANNEL, CAST_BILIBILI_START_HEART_BEAT, {})
end

local function set_player_info_handler(player_info, _type)
  E.LOG.debug(TAG, "set_player_info_handler -----called")
  E.LOG.debug(TAG, {player_info = player_info})
  local role = {
    roleId = player_info.player_id,
    roleName = player_info.player_name
  }
  UNI.cast(CHANNEL, CAST_BILIBILI_CREATE_ROLE, role)
  role.serverId = player_info.server_id
  role.serverName = player_info.server_name or ""
  UNI.cast(CHANNEL, CAST_BILIBILI_NOTIFY_ZONE, role)
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "bilibili init call")
  E.LOG.debug(TAG, {params = opt})
  if _ejoysdk.os() ~= "windows" and cb then
    cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_NOT_SUPPORT, "Only Support for Windows")
    return
  end
  local result = UNI.sync_call(CHANNEL, SYNC_BILIBILI_SUPPORT, {}, nil)
  E.LOG.debug(TAG, "is support bilibili cb")
  E.LOG.debug(TAG, {result = result})
  if result and result.value then
    E.LOG.debug(TAG, "SYNC_BILIBILI_SUPPORT return true")
  else
    cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_NOT_SUPPORT, "not support bilibili, bilibili.dll is not in the right directory")
    return
  end
  pay_listener = opt.pay_listener
  logout_listener = opt.logout_listener
  local sdk_info = UNI.get_sdk_info(CHANNEL)
  local meta_data = sdk_info.meta
  E.LOG.debug(TAG, {meta_data = meta_data})
  E.LOG.debug(TAG, "ASYNC_BILIBILI_INIT ---start")
  local init_param = UTILS.deepcopy(meta_data)
  UNI.async_call(CHANNEL, ASYNC_BILIBILI_INIT, init_param, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_BILIBILI_INIT ---end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    if succ then
      E.LOG.debug(TAG, "bilibili init success")
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      cb(true)
    else
      local code, body = ...
      local tip_msg = "初始化失败，请尝试重启游戏或联系客服。"
      if 100 == code then
        E.LOG.debug(TAG, "bili code = 100 when init, should not handler this code")
        return
      elseif -1 == code or -2 == code then
        tip_msg = "进入游戏需要先阅读并同意隐私政策和用户协议。"
      end
      E.LOG.debug(TAG, "bilibili init failed")
      tip_msg = tip_msg .. "{错误码:" .. tostring(code) .. "}"
      E.Modal.open("提示", {
        message = tip_msg,
        buttons = {
          "退出游戏"
        }
      }, function()
        E.LOG.debug(TAG, "reday to kill the game process")
        UNI.cast(CHANNEL, CAST_BILIBILI_EXIT, {})
        _ejoysdk.exit()
      end)
      code = code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_NATIVE_INIT_FAILED
      local message = body and body.message or tip_msg
      cb(false, code, message)
    end
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, set_player_info_handler)
end

function M.login(params, cb)
  E.LOG.debug(TAG, "bilibili login begin")
  M.tap_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.TAP_LOGIN, params)
  if E.Sysinfo.os() ~= "windows" then
    ATracer.finish_login_sub_span(M.tap_login_span, {
      succ = false,
      code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT,
      msg = "Not Support"
    })
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support")
    if cb then
      cb(channel_result)
    end
    return
  end
  params = params or {}
  E.LOG.debug(TAG, "ASYNC_BILIBILI_LOGIN ----start")
  UNI.async_call(CHANNEL, ASYNC_BILIBILI_LOGIN, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_BILIBILI_LOGIN ---end ,succ = " .. tostring(succ))
    if succ then
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      if body and body.data and "" ~= body.data.accessToken then
        ATracer.finish_login_sub_span(M.tap_login_span, {succ = true, body = body})
        local ext = {
          channel_info = {
            access_key = body.data.accessToken
          }
        }
        local userInfo = {
          token = JSON.encode(ext)
        }
        local channel_result = PROTOCOL.LoginResult.succ(tostring(M.channel_id()), userInfo, ext)
        E.LOG.debug(TAG, {channel_result = channel_result})
        if cb then
          cb(channel_result)
        end
      else
        ATracer.finish_login_sub_span(M.tap_login_span, {
          succ = false,
          code = CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL,
          msg = "Invalid bilibili token"
        })
        local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.AIRLINE_V2_ERROR_CODES.CODE_AUTH_FAIL, "Invalid bilibili token")
        if cb then
          cb(channel_result)
        end
      end
    else
      local code, body = ...
      ATracer.finish_login_sub_span(M.tap_login_span, {
        succ = false,
        code = code,
        body = body
      })
      if 100 == code then
        E.LOG.debug(TAG, "bili code = 100 when login, should not handler this code")
        return
      end
      if -2 == code then
        code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_CANCEL
      end
      local bodyData = body.data
      local message = bodyData and bodyData.message
      local channel_result = PROTOCOL.LoginResult.fail(code, message)
      if cb then
        cb(channel_result)
      end
    end
  end)
end

function M.logout()
  E.LOG.debug(TAG, "bilibili logout")
  UNI.cast(CHANNEL, CAST_BILIBILI_LOGOUT, {})
  logout_listener({})
end

function M.pay(gp_order_id, ds_order_id, product, attach_info_str)
  E.LOG.debug(TAG, "pay ---called")
  E.LOG.d(TAG, "start pay, params >>")
  E.LOG.d(TAG, {
    product = product,
    gp_order_id = gp_order_id,
    ds_order_id = ds_order_id,
    attach_info_str = attach_info_str
  })
  local ext_info = {}
  if attach_info_str then
    ext_info = JSON.decode(attach_info_str)
  end
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local player_info = GDP.PLAYER_INFO.clone()
  E.LOG.debug(TAG, {player_info = player_info})
  local product_id = product.product_id
  local pay_params = {
    orderSign = ext_info.sign,
    outTradeNo = ds_order_id,
    productId = product_id,
    productName = product.product_desc,
    gameMoney = ext_info.gameMoney,
    amount = tostring(product.money),
    notifyUrl = ext_info.callbackUrl
  }
  E.LOG.debug(TAG, {pay_params = pay_params})
  E.LOG.debug(TAG, "ASYNC_BILIBILI_PAY ----start")
  UNI.async_call(CHANNEL, ASYNC_BILIBILI_PAY, pay_params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_BILIBILI_PAY ---end ,succ = " .. tostring(succ))
    if succ then
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      local resp = {
        product_id = product_id,
        channel_pay_params = pay_params,
        body = body
      }
      pay_listener(succ, gp_order_id, resp)
    else
      local code, body = ...
      E.LOG.debug(TAG, {code = code, body = body})
      if 100 == code then
        E.LOG.debug(TAG, "bili code = 100 when pay, should not handler this code")
        return
      end
      local bodyData = body.data
      local message = bodyData and bodyData.message
      local messageDetail = bodyData.msgdetails
      if type(messageDetail) == "string" and "" ~= messageDetail then
        local detailTable = JSON.safe_decode(messageDetail)
        E.LOG.debug(TAG, {detailTable = detailTable})
        if detailTable and type(detailTable) == "table" then
          E.LOG.debug(TAG, "come here, detailTable is a  table type")
          if "table" == type(detailTable.msgdeatils) then
            local detailErrorMessage = detailTable.msgdeatils and detailTable.msgdeatils.message
            message = message .. detailErrorMessage
            if detailTable.msgdeatils then
              code = detailTable.msgdeatils.code or code
            end
          elseif "string" == type(detailTable.msgdeatils) then
            message = detailTable.msgdeatils
          end
        else
          E.LOG.debug(TAG, "come here, detailTable is a  string type")
          message = messageDetail
        end
      end
      E.LOG.debug(TAG, "messageDetail type = " .. tostring(type(messageDetail)))
      if -2 == code or 4 == code then
        code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL
      elseif 2 == code then
        code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_BILIBILI_LIMIT_FAIL
      end
      local resp = {
        code = code,
        msg = message,
        ext = {
          product_id = product_id,
          pay_part = "bilibili_channel_order",
          channel_pay_params = pay_params,
          body = body
        }
      }
      E.LOG.debug(TAG, "show_alert_and_callback_fail_to_game ----called")
      E.LOG.debug(TAG, {resp = resp})
      pay_listener(false, gp_order_id, resp)
      if code == CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL then
        E.LOG.debug(TAG, "this is cancel payment, no need to alert to user")
        return
      end
      local tip_msg = "支付失败。"
      local LANG_UTIL = require("ejoysdk_lua.lang.util")
      local prefix_message = "{" .. LANG_UTIL.getStringSuitCNOverseas("code", "") .. ":"
      tip_msg = tip_msg .. prefix_message .. tostring(resp.code) .. "}"
      E.LOG.debug(TAG, {tip_msg = tip_msg})
      E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", ""), {
        message = tip_msg,
        buttons = {
          LANG_UTIL.getStringSuitCNOverseas("confirm", "")
        }
      })
    end
  end)
end

function M.is_support_channel_sdk()
  if _ejoysdk.os() ~= "windows" then
    return false
  end
  local result = UNI.sync_call(CHANNEL, SYNC_BILIBILI_SUPPORT, {}, nil)
  E.LOG.debug(TAG, "is support bilibili cb")
  E.LOG.debug(TAG, {result = result})
  if result and result.value then
    return result.value
  end
  return false
end

local EVT_BILIBILI_HEATBEAT_NOTIFY = "EVT_BILIBILI_HEATBEAT_NOTIFY"
local HANDLERS = {}
HANDLERS[EVT_BILIBILI_HEATBEAT_NOTIFY] = function(code, body)
  E.LOG.debug(TAG, "receive EVT_BILIBILI_HEATBEAT_NOTIFY")
  E.LOG.debug(TAG, {body = body})
  if 1 == code then
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    gangplank.logout()
  end
end
if E.Sysinfo.os() == "windows" then
  _ejoysdk.register_cb(CHANNEL, function(_cbid, js_str, _chunk)
    local value = JSON.safe_decode(js_str)
    if not value or not value.type then
      return
    end
    local handler = HANDLERS[value.type]
    if handler then
      handler(value.code, value.body)
    end
  end)
end
return M
