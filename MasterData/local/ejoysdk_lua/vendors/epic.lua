local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local LANG_UTIL = require("ejoysdk_lua.lang.util")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CHANNEL = "EPIC"
local TAG = EM.MODULE.VENDORS.EPIC
local M = Vendor:Inherit(CHANNEL)
local EPIC_PAY_TYPE = "253"
local SYNC_EPIC_SUPPORT = "SYNC_EPIC_SUPPORT"
local SYNC_EPIC_SET_LANGUAGE = "SYNC_EPIC_SET_LANGUAGE"
local ASYNC_EPIC_TICK = "ASYNC_EPIC_TICK"
local ASYNC_EPIC_INIT = "ASYNC_EPIC_INIT"
local ASYNC_EPIC_EXIT = "ASYNC_EPIC_EXIT"
local ASYNC_EPIC_LOGIN = "ASYNC_EPIC_LOGIN"
local ASYNC_EPIC_REFRESH_TOKEN = "ASYNC_EPIC_REFRESH_TOKEN"
local ASYNC_EPIC_PAY = "ASYNC_EPIC_PAY"
local ASYNC_EPIC_GET_ALL_ENTITLEMENTS = "ASYNC_EPIC_GET_ALL_ENTITLEMENTS"
local ASYNC_EPIC_GET_ENTITLEMENT_TOKEN = "ASYNC_EPIC_GET_ENTITLEMENT_TOKEN"
local pay_listener, epic_init_params, current_epic_account_id, current_refresh_token
local login_callback_array = {}
local is_epic_channel_login_ing = false
local is_epic_channel_pay_ing = false
local epic_games_language, origin_epic_games_language
M.TICK_INTERVAL = {NORMAL = 1, FAST = 0.05}
local current_tick_interval = M.TICK_INTERVAL.NORMAL

local function adjust_tick_interval(call_time)
  if call_time > 0 then
    current_tick_interval = M.TICK_INTERVAL.FAST
  else
    current_tick_interval = M.TICK_INTERVAL.NORMAL
  end
  E.LOG.debug(TAG, "current tick interval >> " .. tostring(current_tick_interval))
end

local function adjust_tick_fast()
  adjust_tick_interval(1)
end

local function adjust_tick_slow()
  adjust_tick_interval(-1)
end

local function get_notify_url()
  local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
  do return end
  return ejoy_pay.get_notify_url
end

local function notify_server_for_deliver_product(body, trade_id, cb)
  local params = {
    pay_type = EPIC_PAY_TYPE,
    inapp_purchase_data = JSON.encode(body),
    notify_url = get_notify_url(),
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
      biz_func = "sdk.epic_upload_receipt",
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

local function get_entitlement_token(params, cb)
  E.LOG.debug(TAG, "ASYNC_EPIC_GET_ENTITLEMENT_TOKEN ---start")
  UNI.async_call(CHANNEL, ASYNC_EPIC_GET_ENTITLEMENT_TOKEN, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_EPIC_GET_ENTITLEMENT_TOKEN ---end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    local error_code
    if not succ then
      error_code = (...)
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_get_entitlement_token",
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
    if succ then
      local body = (...)
      local token = body and body.EntitlementToken
      if cb then
        cb(true, token)
      end
    else
      local code, body = ...
      if cb then
        cb(false, code, body.message)
      end
    end
  end)
end

local function loop_call_verify_interface_from_array(entitlementArray, trade_id, cb)
  local params = {epicAccountId = current_epic_account_id}
  get_entitlement_token(params, function(succ, ...)
    if succ then
      local entitlementToken = (...)
      local sandboxId = epic_init_params.sandboxId
      if entitlementArray and next(entitlementArray) then
        for _k, item in pairs(entitlementArray) do
          E.LOG.debug(TAG, {item = item})
          local veryfyBody = {}
          veryfyBody.token = entitlementToken
          veryfyBody.sandboxId = sandboxId
          veryfyBody.entitlement = item
          E.LOG.debug(TAG, {veryfyBody = veryfyBody})
          notify_server_for_deliver_product(veryfyBody, trade_id, cb)
        end
      end
    else
      local code, message = ...
      if cb then
        cb(false, code, message)
      end
    end
  end)
end

local function check_unfinished_purchase()
  local params = {epicAccountId = current_epic_account_id}
  E.LOG.debug(TAG, "ASYNC_EPIC_GET_ALL_ENTITLEMENTS ---start")
  UNI.async_call(CHANNEL, ASYNC_EPIC_GET_ALL_ENTITLEMENTS, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_EPIC_GET_ALL_ENTITLEMENTS ---end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_get_all_entitlements",
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
      local body = (...)
      local entitlementArray = body.entitlementArray
      loop_call_verify_interface_from_array(entitlementArray)
    else
      local code, body = ...
      E.LOG.debug(TAG, "获取未结束订单信息失败")
      E.LOG.debug(TAG, {
        code = code,
        message = body.message
      })
    end
  end)
end

local function show_user_alert_to_exit(code, tip_msg)
  local prefix_message = "{" .. LANG_UTIL.getStringSuitCNOverseas("code", "") .. ":"
  tip_msg = tip_msg .. prefix_message .. tostring(code) .. "}"
  E.Modal.open(LANG_UTIL.getStringSuitCNOverseas("tips", "提示"), {
    message = tip_msg,
    buttons = {
      LANG_UTIL.getStringSuitCNOverseas("confirm", "确定")
    }
  }, function()
    E.LOG.debug(TAG, "reday to kill the game process")
    UNI.async_call(CHANNEL, ASYNC_EPIC_EXIT, {}, nil, function()
    end)
    _ejoysdk.exit()
  end)
end

local function acquire_handler(user_info)
  E.LOG.debug(TAG, "acquire_handler ---called")
  E.LOG.debug(TAG, {user_info = user_info})
  check_unfinished_purchase()
end

local function handler_login_or_refresh_token_result(cb, succ, ...)
  E.LOG.debug(TAG, "handler_login_or_refresh_token_result----called")
  if succ then
    local body = (...)
    E.LOG.debug(TAG, {body = body})
    local data = {
      epicId = body.epicAccountId,
      accessToken = body.AccessToken
    }
    current_epic_account_id = body.epicAccountId
    current_refresh_token = body.RefreshToken
    E.LOG.debug(TAG, "get epicAccountId and accessToken success from epic")
    E.LOG.debug(TAG, {data = data})
    if cb then
      cb(true, data)
    end
  else
    local code, body = ...
    if 1003 == code or 1013 == code or 1040 == code or 1041 == code then
      local tip_msg = LANG_UTIL.getStringSuitCNOverseas("epic_login_err_msg", "")
      show_user_alert_to_exit(code, tip_msg)
    elseif cb then
      cb(false, code, body.message)
    end
  end
end

local function check_if_epic_refresh_token_done(cb)
  E.LOG.debug(TAG, "ASYNC_EPIC_REFRESH_TOKEN ---start")
  local params = {refreshToken = current_refresh_token}
  adjust_tick_fast()
  is_epic_channel_login_ing = true
  UNI.async_call(CHANNEL, ASYNC_EPIC_REFRESH_TOKEN, params, nil, function(succ, ...)
    is_epic_channel_login_ing = false
    adjust_tick_slow()
    E.LOG.debug(TAG, "ASYNC_EPIC_REFRESH_TOKEN ---end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    local code
    if not succ then
      code = (...)
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_refresh_token_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or tostring(code),
      biz_params = {
        login_params = params,
        code = code,
        body = {
          ...
        }
      }
    })
    handler_login_or_refresh_token_result(cb, succ, ...)
  end)
end

local function parse_args_to_json(input)
  local result = {}
  for pair in input:gmatch("%S+") do
    local key, value = pair:match("^-([%a_]+)=(.+)$")
    if key and value then
      value = value:match("^\"(.+)\"$") or value
      result[key] = value
    end
  end
  return result
end

local language_switch = {
  ["zh-cn"] = "zh-hans",
  ["es-mx"] = "es",
  ["es-es"] = "es"
}
local argsJsonTable

local function get_args_json_table()
  if argsJsonTable then
    return argsJsonTable
  end
  local origin_cmd = _ejoysdk.get_command_line()
  E.LOG.debug(TAG, {origin_cmd = origin_cmd})
  local args = origin_cmd
  if type(args) == "string" then
    E.LOG.debug(TAG, "args is a string type")
    local jsonTable = parse_args_to_json(args)
    E.LOG.debug(TAG, {jsonTable = jsonTable})
    if jsonTable and next(jsonTable) then
      argsJsonTable = jsonTable
    end
  else
    E.LOG.debug(TAG, "args type = " .. tostring(type(args)))
  end
  return argsJsonTable, origin_cmd
end

local function check_if_launch_from_epic()
  if M.is_support_channel_sdk() then
    local jsonTable = get_args_json_table()
    if jsonTable and next(jsonTable) and jsonTable.AUTH_PASSWORD then
      return true
    end
  end
  return false
end

local function check_if_epic_login_done(cb)
  E.LOG.debug(TAG, "to parse exchange code from command line by epic launcher")
  local exchangeCode, epic_language
  local jsonTable, args = get_args_json_table()
  if jsonTable and next(jsonTable) then
    exchangeCode = jsonTable.AUTH_PASSWORD
    epic_language = M.get_epic_language()
  end
  E.LOG.debug(TAG, {exchangeCode = exchangeCode, epic_language = epic_language})
  local params = {exchangeCode = exchangeCode}
  E.LOG.debug(TAG, "ASYNC_EPIC_LOGIN ---start")
  adjust_tick_fast()
  is_epic_channel_login_ing = true
  UNI.async_call(CHANNEL, ASYNC_EPIC_LOGIN, params, nil, function(succ, ...)
    is_epic_channel_login_ing = false
    adjust_tick_slow()
    local code
    if not succ then
      code = (...)
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_login_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or tostring(code),
      biz_params = {
        login_params = params,
        args = args,
        jsonTable = jsonTable,
        code = code,
        body = {
          ...
        }
      }
    })
    E.LOG.debug(TAG, "ASYNC_EPIC_LOGIN ---end")
    E.LOG.debug(TAG, "epic login cb, succ >> " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    handler_login_or_refresh_token_result(cb, succ, ...)
  end)
end

local function locainCallbackWrap(succ, ...)
  E.LOG.debug(TAG, "epic login done return to locainCallbackWrap function")
  E.LOG.debug(TAG, {
    ...
  })
  local channel_result
  if succ then
    local json_data = (...)
    local user_info = {
      token = JSON.encode(json_data)
    }
    channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {})
    E.LOG.debug(TAG, {channel_result = channel_result})
  else
    local code, message = ...
    channel_result = PROTOCOL.LoginResult.fail(code, message)
  end
  for _, callback in ipairs(login_callback_array) do
    callback(channel_result)
  end
  login_callback_array = {}
end

function M.login(_ext, cb)
  if E.Sysinfo.os() ~= "windows" then
    E.LOG.debug(TAG, "sign with epic only support for Windows, mobile should go Oauth by H5")
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support", {})
    cb(channel_result)
    return
  end
  E.LOG.debug(TAG, "epic login begin")
  if cb and type(cb) == "function" then
    table.insert(login_callback_array, cb)
  else
    E.LOG.error(TAG, "login cb is not function, cb type = " .. tostring(type(cb)))
  end
  if is_epic_channel_login_ing then
    E.LOG.debug(TAG, "epic is already login ing, do nothing with this login call")
    return
  end
  if current_refresh_token then
    E.LOG.debug(TAG, "epic channel refresh token begin")
    check_if_epic_refresh_token_done(locainCallbackWrap)
  else
    E.LOG.debug(TAG, "epic channel login begin")
    check_if_epic_login_done(locainCallbackWrap)
  end
end

local function show_alert_and_callback_fail_to_game(gp_order_id, product_id, code, tip_msg, pay_part, channel_pay_params, body)
  if 17 == code then
    code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL
  end
  local resp = {
    code = code,
    msg = tip_msg,
    ext = {
      product_id = product_id,
      pay_part = pay_part,
      channel_pay_params = channel_pay_params,
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

local function launch_epic_pay_page(gp_order_id, trade_id, channel_pay_params)
  ESTAT.app_pay_report({
    biz_func = "sdk.epic_pay_result",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  E.LOG.debug(TAG, {channel_pay_params = channel_pay_params})
  E.LOG.debug(TAG, "ASYNC_EPIC_PAY ----start")
  adjust_tick_fast()
  is_epic_channel_pay_ing = true
  UNI.async_call(CHANNEL, ASYNC_EPIC_PAY, channel_pay_params, nil, function(succ, ...)
    is_epic_channel_pay_ing = false
    adjust_tick_slow()
    E.LOG.debug(TAG, "ASYNC_EPIC_PAY ----end, succ = " .. tostring(succ))
    E.LOG.debug(TAG, {
      ...
    })
    local error_code
    if not succ then
      error_code = (...)
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_pay_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or tostring(error_code),
      biz_params = {
        gp_order_id = gp_order_id,
        channel_pay_params = channel_pay_params,
        code = error_code,
        body = {
          ...
        }
      }
    })
    if succ then
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      local entitlementArray = body.entitlementArray
      loop_call_verify_interface_from_array(entitlementArray, trade_id, function(succ2, ...)
        E.LOG.debug(TAG, "launch_epic_pay_page, notify_server_for_deliver_product result = " .. tostring(succ2))
        E.LOG.debug(TAG, {
          ...
        })
        if succ2 then
          local success_body = (...)
          pay_listener(succ2, gp_order_id, success_body)
        else
          local code, message = ...
          body.message = message
          E.LOG.debug(TAG, {body = body})
          local msg = body and body.message or body.msg or "default epic pay error message"
          local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", msg)
          show_alert_and_callback_fail_to_game(gp_order_id, channel_pay_params.productId, code, tip_msg, "epic_upload_receipt_order", channel_pay_params, body)
        end
      end)
    else
      local code, body = ...
      E.LOG.debug(TAG, {
        code = code,
        message = body.message,
        body = body
      })
      local msg = body and body.message or body.msg or "default epic pay error message"
      local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", msg)
      show_alert_and_callback_fail_to_game(gp_order_id, channel_pay_params.productId, code, tip_msg, "epic_channel_order", channel_pay_params, body)
    end
  end)
end

function M.pay(product_id, gp_order_id, ds_order_id, attach_info_str, local_params)
  E.LOG.d(TAG, "start pay, params >>")
  E.LOG.d(TAG, {
    product_id = product_id,
    gp_order_id = gp_order_id,
    ds_order_id = ds_order_id,
    attach_info_str = attach_info_str,
    local_params = local_params
  })
  if not current_epic_account_id then
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_vendor_can_not_pay_tips", "")
    local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_EPIC_PAY_NOT_LOGIN_SUCCESS
    local pay_part = "epic_pay_not_login_success"
    show_alert_and_callback_fail_to_game(gp_order_id, product_id, code, tip_msg, pay_part)
    return
  end
  check_unfinished_purchase()
  local product = local_params.product_info
  local player_info = GDP.PLAYER_INFO.clone()
  local ext_info = {}
  if attach_info_str then
    ext_info = JSON.decode(attach_info_str)
  end
  local epic_product_id
  if product.channel_product_info and product.channel_product_info.epic_product_id then
    epic_product_id = product.channel_product_info.epic_product_id
  else
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_product_can_not_find_tips", "")
    local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_EPIC_PAY_CHANNEL_PRODUCT_INFO_WRONG
    local pay_part = "epic_pay_channel_product_info_wrong"
    show_alert_and_callback_fail_to_game(gp_order_id, product_id, code, tip_msg, pay_part)
    return
  end
  local pay_params = {
    cpOrderId = ds_order_id,
    payProductID = product.product_id,
    payProductName = product.product_desc,
    currency = ext_info.currency,
    order_amt = ext_info.order_amt,
    pay_type = EPIC_PAY_TYPE,
    player_info = JSON.encode(player_info),
    notify_url = get_notify_url(),
    channel_attrs = JSON.encode({epic_product_id = epic_product_id})
  }
  if product.min_order_amt then
    pay_params.min_order_amt = tostring(product.min_order_amt)
  end
  E.LOG.debug(TAG, {pay_params = pay_params})
  E.LOG.debug(TAG, "gps create order start---")
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    if succ then
      local data = (...)
      local trade_id = data.trade_id
      E.LOG.debug(TAG, "gps create order success, trade_id = " .. tostring(trade_id))
      local channel_pay_params = {productId = epic_product_id, trade_id = trade_id}
      channel_pay_params.epicAccountId = current_epic_account_id
      if is_epic_channel_pay_ing then
        E.LOG.debug(TAG, "epic is already pay ing, do nothing with this pay call")
        local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_ios_frequency", "")
        local code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_EPIC_PAY_FREQUENCY
        local pay_part = "epic_pay_frequency"
        show_alert_and_callback_fail_to_game(gp_order_id, product_id, code, tip_msg, pay_part)
        return
      end
      launch_epic_pay_page(gp_order_id, trade_id, channel_pay_params)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "gps create order failed, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      local tip_msg = LANG_UTIL.getStringSuitCNOverseas("pay_common_tips", msg)
      local pay_part = "epic_gps_order"
      show_alert_and_callback_fail_to_game(gp_order_id, product_id, code, tip_msg, pay_part, nil, {
        ...
      })
    end
  end)
end

local epic_callback_tick
local inited = false

function M.init(opt, cb)
  E.LOG.debug(TAG, "epic init --called")
  if not cb then
    E.LOG.debug(TAG, "init call from officialpay vendor, not call actual init funtion")
    return
  end
  if inited then
    E.LOG.debug(TAG, "epic vendor had inited")
    if cb then
      cb(true)
    end
    return
  end
  if not M.is_support_channel_sdk() then
    E.LOG.debug(TAG, "not support_epic_sdk")
    if cb then
      cb(true)
    end
    return
  end
  pay_listener = opt.pay_listener
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  if not check_if_launch_from_epic() then
    local error_code = CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_CHECK_ENV_FAIL
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_launch_not_from_store",
      biz_act = "finish",
      biz_st = "succ",
      biz_co = tostring(error_code),
      biz_params = {code = error_code}
    })
    local tip_msg = LANG_UTIL.getStringSuitCNOverseas("game_need_launch_from_epic", "")
    show_user_alert_to_exit(error_code, tip_msg)
    return
  end
  local sdk_info = UNI.get_sdk_info(CHANNEL)
  local meta_data = sdk_info.meta
  E.LOG.debug(TAG, {sdk_info = sdk_info})
  local jsonTable = get_args_json_table()
  local sandboxIdLaunch, deploymentIdLaunch
  if jsonTable and next(jsonTable) then
    sandboxIdLaunch = jsonTable.epicsandboxid
    deploymentIdLaunch = jsonTable.epicdeploymentid
  end
  epic_init_params = {
    productName = meta_data.productName,
    productVersion = meta_data.productVersion,
    productId = meta_data.productId,
    clientId = meta_data.clientId,
    clientSecret = meta_data.clientSecret,
    sandboxId = sandboxIdLaunch,
    deploymentId = deploymentIdLaunch
  }
  E.LOG.debug(TAG, "ASYNC_EPIC_INIT ---start")
  UNI.async_call(CHANNEL, ASYNC_EPIC_INIT, epic_init_params, nil, function(succ, ...)
    E.LOG.debug(TAG, "ASYNC_EPIC_INIT ---end")
    E.LOG.debug(TAG, {
      ...
    })
    local error_code
    if succ then
      E.LOG.debug(TAG, "epic native init succ")
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      
      function epic_callback_tick()
        UNI.async_call(CHANNEL, ASYNC_EPIC_TICK, {}, nil, function(_succ2, ...)
        end)
        E.Timer.once(current_tick_interval, epic_callback_tick)
      end
      
      epic_callback_tick()
      inited = true
      if cb then
        cb(true)
      end
      check_if_epic_login_done(locainCallbackWrap)
      if M.get_epic_language() then
        local result = UNI.sync_call(CHANNEL, SYNC_EPIC_SET_LANGUAGE, {epic_language = origin_epic_games_language}, nil)
        E.LOG.debug(TAG, "SYNC_EPIC_SET_LANGUAGE get result ===")
        E.LOG.debug(TAG, {result = result})
      end
    else
      E.LOG.error(TAG, "epic native init fail")
      local code, body = ...
      error_code = code
      local message = body.message or "epic native init fail"
      E.LOG.debug(TAG, {code = code, message = message})
      if cb then
        cb(false, code, message)
      end
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.epic_init_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or tostring(error_code),
      biz_params = {
        ...
      }
    })
  end)
end

function M.get_epic_language()
  if epic_games_language then
    return epic_games_language
  end
  local jsonTable = get_args_json_table()
  if jsonTable and next(jsonTable) and jsonTable.epiclocale and type(jsonTable.epiclocale) == "string" then
    origin_epic_games_language = jsonTable.epiclocale
    epic_games_language = jsonTable.epiclocale:lower()
    epic_games_language = language_switch[epic_games_language] or epic_games_language
  end
  return epic_games_language
end

function M.get_language()
  do return end
  return M.get_epic_language, nil
end

function M.is_support_channel_sdk()
  if _ejoysdk.os() ~= "windows" then
    return false
  end
  local result = UNI.sync_call(CHANNEL, SYNC_EPIC_SUPPORT, {}, nil)
  E.LOG.debug(TAG, "is support epic cb")
  E.LOG.debug(TAG, {result = result})
  if result and result.value then
    return result.value
  end
  return false
end

function M.is_support_epic_sdk()
  do return end
  return M.is_support_channel_sdk, nil
end

function M.can_auto_login()
  if M.is_support_channel_sdk() then
    return false
  end
  return true
end

function M.need_sdk_login()
  do return end
  return M.is_support_channel_sdk, nil
end

function M.check_token(_outsource, _info)
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
