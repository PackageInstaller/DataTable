local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local LANG = require("ejoysdk_lua.lang.util")
local CHANNEL = "WEGAME"
local TAG = EM.MODULE.VENDORS.WEGAME
local WEGAME = Vendor:Inherit(CHANNEL)
local ASYNC_WEGAME_INIT = "ASYNC_WEGAME_INIT"
local ASYNC_WEGAME_AUTH = "ASYNC_WEGAME_AUTH"
local ASYNC_WEGAME_TICK = "ASYNC_WEGAME_TICK"
local ASYNC_WEGAME_PAY = "ASYNC_WEGAME_PAY"
local SYNC_WEGAME_SUPPORT = "SYNC_WEGAME_SUPPORT"
local inited = false
local wegame_appid, pay_listener, current_rail_id
local WEGAME_PAY_TYPE = "807"
local wegame_callback_tick

function WEGAME.init(opt, cb)
  E.LOG.debug(TAG, "wegame init")
  if inited then
    E.LOG.debug(TAG, "wegame vendor had inited")
    if cb then
      cb(true)
    end
    return
  end
  if not WEGAME.is_support_wegame_sdk() then
    E.LOG.debug(TAG, "not support_wegame_sdk")
    if cb then
      cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_NOT_SUPPORT, "native not support wegame")
    end
    return
  end
  local sdk_info = UNI.get_sdk_info(CHANNEL)
  E.LOG.debug(TAG, {sdkInfo = sdk_info})
  if sdk_info and sdk_info.meta and type(sdk_info.meta.appid) == "string" and #sdk_info.meta.appid > 0 then
    wegame_appid = sdk_info.meta.appid
    E.LOG.debug(TAG, "init wegame id >> " .. tostring(wegame_appid))
  else
    E.LOG.error(TAG, "parse wegame appid error")
  end
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "call native wegame vendor init")
  local init_params = {appid = wegame_appid}
  UNI.async_call(CHANNEL, ASYNC_WEGAME_INIT, init_params, nil, function(succ, ...)
    E.LOG.debug(TAG, "wegame native init succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      E.LOG.debug(TAG, "wegame native init succ")
      E.LOG.debug(TAG, "start wegame tick")
      
      function wegame_callback_tick()
        UNI.async_call(CHANNEL, ASYNC_WEGAME_TICK, {}, nil, function(_succ2, ...)
        end)
        E.Timer.once(1, wegame_callback_tick)
      end
      
      wegame_callback_tick()
      inited = true
      if cb then
        cb(true)
      end
    else
      E.LOG.error(TAG, "wegame native init fail")
      local _code, body = ...
      local code = body.code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_NATIVE_INIT_FAILED
      local msg = body.message or "wegame native init fail"
      if code == CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_CHECK_ENV_FAIL then
        E.LOG.debug(TAG, "need startup from wegame client")
        local title = LANG.getStringSuitCNOverseas("tips", "提示")
        local ensure_btn_str = LANG.getStringSuitCNOverseas("confirm", "确认")
        local tip_msg = LANG.getStringSuitCNOverseas("wegame_check_env_fail_tips", "本游戏需要通过Wegame启动。")
        local param = {
          message = tip_msg,
          buttons = {ensure_btn_str}
        }
        E.Modal.open(title, param, function(answer)
          E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
          if cb then
            cb(false, code, msg)
          end
        end)
      elseif cb then
        cb(false, code, msg)
      end
    end
  end)
end

function WEGAME.is_support_wegame_sdk()
  if _ejoysdk.os() ~= "windows" then
    return false
  end
  local result = UNI.sync_call(CHANNEL, SYNC_WEGAME_SUPPORT, {}, nil)
  E.LOG.debug(TAG, "is support WEGAME cb")
  E.log(result)
  if result and result.value then
    return result.value
  end
  return false
end

local current_gp_order_id
local has_pay_callback = false

local function pay_callback(succ, resp)
  if not has_pay_callback and pay_listener then
    ESTAT.app_pay_report({
      biz_func = "sdk.wegame_pay_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {gp_order_id = current_gp_order_id, resp = resp}
    })
    pay_listener(succ, current_gp_order_id, resp)
    current_gp_order_id = nil
    has_pay_callback = true
  else
    E.LOG.debug(TAG, "order had callback, do not callback again")
  end
end

function WEGAME.pay(gp_order_id, _ds_order_id, product, pay_params)
  E.LOG.debug(TAG, "ejoy pay, pay_params = ")
  E.LOG.debug(TAG, pay_params)
  current_gp_order_id = gp_order_id
  has_pay_callback = false
  local gps_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.GPS_PAY)
  pay_params.pay_type = WEGAME_PAY_TYPE
  pay_params.channel_user_id = current_rail_id
  E.LOG.debug(TAG, "ejoy pay, channel_user_id = " .. tostring(current_rail_id))
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    ATracer.finish_pay_sub_span(gps_pay_span, {
      ...
    })
    local temp_data = (...)
    ESTAT.app_pay_report({
      biz_func = "sdk.show_wegame_pay",
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
      local gateway_order_id = data.gateway_order_id
      E.LOG.debug(TAG, "gateway_order_id = " .. tostring(gateway_order_id))
      local user_data = {trade_id = trade_id}
      local params = {}
      params.order_id = gateway_order_id
      params.user_data = JSON.safe_encode(user_data)
      ESTAT.app_pay_report({
        biz_func = "sdk.wegame_pay_result",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {trade_id = trade_id}
      })
      UNI.async_call(CHANNEL, ASYNC_WEGAME_PAY, params, nil, function(succ2, ...)
        if succ2 then
          E.LOG.debug(TAG, "wegame native launch pay succ")
          local body_data = (...)
          E.LOG.debug(TAG, {body = body_data})
        else
          E.LOG.error(TAG, "wegame native pay fail")
          local _code, body = ...
          E.LOG.debug(TAG, {body = body})
          local resp = {
            code = (body or {}).code or CONSTANTS.WINDOWS_WEGAME_CODE.LAUNCH_PAY_FAIL,
            msg = (body or {}).message or "wegame launch pay fail",
            ext = {
              pay_part = "gps_order",
              product_id = tostring(product.product_id),
              platform = CHANNEL,
              gp_order = gp_order_id,
              ds_order = gp_order_id,
              rail_id = current_rail_id
            }
          }
          pay_callback(false, resp)
        end
      end)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      local resp = {
        code = code,
        msg = msg,
        ext = {
          pay_part = "gps_order",
          product_id = tostring(product.product_id),
          platform = CHANNEL,
          gp_order = gp_order_id,
          ds_order = gp_order_id,
          rail_id = current_rail_id
        }
      }
      pay_callback(false, resp)
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

local function login_wegame_ticket(cb)
  UNI.async_call(CHANNEL, ASYNC_WEGAME_AUTH, {}, nil, function(succ, ...)
    E.LOG.debug(TAG, "wegame login cb, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      data = {
        ...
      }
    })
    if succ then
      local body = (...)
      if type(body.ticket) == "string" and body.ticket ~= "" then
        local ticket = body.ticket
        local rail_id = body.user_id
        current_rail_id = rail_id
        E.LOG.debug(TAG, "get ticket from wegame return >> " .. ticket)
        if cb then
          cb(true, rail_id, ticket)
        end
      else
        cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED, "login ticket return null")
      end
    else
      local _code, body = ...
      local code = (body or {}).code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
      local message = (body or {}).message or "wegame login get ticket fail"
      cb(false, code, message)
    end
  end)
end

function WEGAME.login(_ext, cb)
  if E.Sysinfo.os() ~= "windows" then
    E.LOG.debug(TAG, "sign with WeGame only support for Windows")
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support", {})
    cb(channel_result)
    return
  end
  login_wegame_ticket(function(succ, ...)
    if succ then
      local rail_id, ticket = ...
      E.LOG.debug(TAG, "get ticket from wegame return >> " .. tostring(ticket) .. ", and rail id >> " .. tostring(rail_id))
      local thirdPartyToken = {
        accessToken = ticket,
        railId = rail_id,
        appid = wegame_appid
      }
      local user_info = {
        token = JSON.encode(thirdPartyToken)
      }
      local channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {thirdparty_type = "WEGAME"})
      if cb then
        cb(channel_result)
      end
    else
      local code, message = ...
      local channel_result = PROTOCOL.LoginResult.fail(code, message)
      if cb then
        cb(channel_result)
      end
    end
  end)
end

function WEGAME.setupInitPaySDK(opt)
  pay_listener = opt.pay_listener
  E.LOG.debug(TAG, "init ejoy pay wegame vendor")
end

local EVT_WEGAME_PAY_PAGE_SHOW = "EVT_WEGAME_PAY_PAGE_SHOW"
local EVT_WEGAME_PAY_PAGE_CLOSE = "EVT_WEGAME_PAY_PAGE_CLOSE"
local EVT_WEGAME_PAY_RESULT = "EVT_WEGAME_PAY_RESULT"
local EVT_WEGAME_NOTIFY_EXIT = "EVT_WEGAME_NOTIFY_EXIT"
local EVT_WEGAME_ANTI_ADDICTIONS_ACTIONS = "EVT_WEGAME_ANTI_ADDICTIONS_ACTIONS"
local HANDLERS = {}
HANDLERS[EVT_WEGAME_PAY_PAGE_SHOW] = function(body)
  E.LOG.debug(TAG, "receive EVT_WEGAME_PAY_PAGE_SHOW")
  E.log(body)
end
HANDLERS[EVT_WEGAME_PAY_PAGE_CLOSE] = function(body)
  E.LOG.debug(TAG, "receive EVT_WEGAME_PAY_PAGE_CLOSE")
  E.LOG.debug(TAG, {data = body})
  local resp = {
    code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
    msg = "wegame pay cancel",
    ext = body
  }
  pay_callback(false, resp)
end
HANDLERS[EVT_WEGAME_PAY_RESULT] = function(body)
  E.LOG.debug(TAG, "receive EVT_WEGAME_PAY_RESULT")
  E.LOG.debug(TAG, {data = body})
  if body and body.succ == true then
    local order_id = body.orderId
    E.LOG.debug(TAG, "pay success, and orderId >> " .. tostring(order_id))
    pay_callback(true, body)
  else
    local order_id = body.orderId
    local code = body.code
    E.LOG.debug(TAG, "pay failed, and orderId >> " .. tostring(order_id) .. ", and code >> " .. tostring(code))
    local resp = {
      code = code,
      msg = "wegame pay failed",
      ext = body
    }
    pay_callback(false, resp)
  end
end
HANDLERS[EVT_WEGAME_NOTIFY_EXIT] = function(_body)
  E.LOG.debug(TAG, "receive EVT_WEGAME_NOTIFY_EXIT")
  local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
  gangplank.notify_exit(true)
end
HANDLERS[EVT_WEGAME_ANTI_ADDICTIONS_ACTIONS] = function(body)
  E.LOG.debug(TAG, "receive EVT_WEGAME_ANTI_ADDICTIONS_ACTIONS")
  E.LOG.debug(TAG, {data = body})
  local tips = {}
  local need_exit = false
  
  local function parse_func()
    if body and body.data then
      local data_str = body.data
      local data_json = JSON.decode(data_str)
      if data_json.actions then
        local actions = data_json.actions
        for _, item in ipairs(actions) do
          local action = item.action
          local id = action.type.id
          local name = action.type.name
          if 1 == id and "kRailAntiAddictionActionShowTips" == name then
            tips.title = action.title
            tips.content = action.content
            tips.display_duration_seconds = action.display_duration_seconds
          elseif 2 == id and "kRailAntiAddictionActionHalt" == name then
            need_exit = true
          end
        end
      end
    end
  end
  
  local ok = pcall(parse_func)
  if ok then
    E.LOG.debug(TAG, "parse anti addictions actions success, need exit >> " .. tostring(need_exit))
    E.LOG.debug(TAG, {tips = tips})
    if tips.title and tips.content and tips.display_duration_seconds then
      local ensure_btn_str = LANG.getStringSuitCNOverseas("confirm", "确认")
      local param = {
        message = tips.content,
        buttons = {ensure_btn_str}
      }
      local is_modal_open = true
      E.Modal.open(tips.title, param, function(answer)
        E.LOG.debug(TAG, "on exit callback >> " .. tostring(answer))
        is_modal_open = false
        if need_exit then
          local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
          gangplank.notify_exit(true)
        end
      end)
      E.Timer.once(tips.display_duration_seconds, function()
        E.LOG.debug(TAG, "display_duration_seconds dead ")
        if is_modal_open then
          E.LOG.debug(TAG, "close modal false ")
          E.Modal.close(function()
            is_modal_open = false
            if need_exit then
              local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
              gangplank.notify_exit(true)
            end
          end)
        else
          E.LOG.debug(TAG, "is_model_open false ")
        end
      end)
    end
  else
    E.LOG.error(TAG, "parse anti addictions actions error")
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
      handler(value.body)
    else
      _ejoysdk.log(TAG, "no handler for " .. tostring(value.type))
    end
  end)
end
return WEGAME
