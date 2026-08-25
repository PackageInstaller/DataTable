local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CHANNEL = "STEAM"
local TAG = EM.MODULE.VENDORS.STEAM
local STEAM = Vendor:Inherit(CHANNEL)
local STEAM_PAY_TYPE = "243"
local steam_appid, current_steam_id
local inited = false
local ASYNC_STEAM_INIT = "ASYNC_STEAM_INIT"
local ASYNC_STEAM_AUTH = "ASYNC_STEAM_AUTH"
local ASYNC_STEAM_TICK = "ASYNC_STEAM_TICK"
local SYNC_STEAM_SUPPORT = "SYNC_STEAM_SUPPORT"
local SYNC_GET_STEAM_LANGUAGE = "SYNC_GET_STEAM_LANGUAGE"
local steam_language = "english"
local steam_ui_language = "english"
local sdk_trans_steam_ui_language, pay_listener, logout_listener
local in_login = false

local function login_listener(account_result)
  E.LOG.debug(TAG, "receive login result")
  E.log(account_result)
  if account_result.ext and account_result.ext.account_data then
    local channel_result = account_result.ext.channel_result
    if channel_result.ext and channel_result.ext.thirdparty_type == "STEAM" then
      local account_data = account_result.ext.account_data
      current_steam_id = account_data.thirdPartyUid
      E.LOG.debug(TAG, "save current steam id >> " .. tostring(current_steam_id))
    end
  end
end

local function save_steam_language(data)
  if type(data) ~= "table" then
    return
  end
  local language = data.language
  local ui_language = data.uiLanguage
  if language and "" ~= language then
    steam_language = language
  else
    steam_language = ui_language
  end
  steam_ui_language = ui_language or steam_ui_language
  E.LOG.debug(TAG, "save steam ui_language >> " .. tostring(steam_ui_language))
  E.LOG.debug(TAG, "save steam language >> " .. tostring(steam_language))
end

local function login_steam_ticket(cb)
  local params = {appid = steam_appid}
  UNI.async_call(CHANNEL, ASYNC_STEAM_AUTH, params, nil, function(succ, ...)
    E.LOG.debug(TAG, "steam login cb, succ >> " .. tostring(succ))
    E.log({
      ...
    })
    if succ then
      local body = (...)
      save_steam_language(body)
      if type(body.ticket) == "string" and body.ticket ~= "" then
        local ticket = body.ticket
        E.LOG.debug(TAG, "get ticket from steam return >> " .. ticket)
        if cb then
          cb(true, ticket)
        end
      else
        cb(false)
      end
    else
      local _code, body = ...
      cb(false, body)
    end
  end)
end

local login_cb, login_cb_wrapper
local LOGIN_TIMEOUT_INTERVAL = 20
local LOGIN_TIMEOUT_INTERVAL_SHORT = 8
local max_retry_steam_login_count = 2
local global_login_new_switch

local function check_if_steam_go_new_switch()
  if nil ~= global_login_new_switch then
    E.LOG.debug(TAG, "already call check_if_steam_go_new_switch get value, return old value")
    E.LOG.debug(TAG, {global_login_new_switch = global_login_new_switch})
    return global_login_new_switch
  end
  E.LOG.debug(TAG, "first call check_if_steam_go_new_switch，should read config_center data for switch")
  global_login_new_switch = true
  local ecc = require("ejoysdk_lua.ejoysdk_config_center")
  local biz_config = ecc.get_config(ecc.NAMESPACE.EJOYSDK_BIZ)
  if biz_config and biz_config.config and biz_config.config.steam_config then
    local steam_config = biz_config.config.steam_config
    global_login_new_switch = steam_config.steam_login_retry or false
    E.LOG.debug(TAG, {steam_config = steam_config})
  end
  ESTAT.app_pay_report({
    biz_func = "sdk.steam_switch_config",
    biz_act = "finish",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {body = biz_config}
  })
  E.LOG.debug(TAG, {global_login_new_switch = global_login_new_switch})
  return global_login_new_switch
end

local function steam_login_with_retry(retry_number)
  E.LOG.debug(TAG, "steam_login_with_retry ---called, retry_number = " .. tostring(retry_number))
  E.Timer.once(LOGIN_TIMEOUT_INTERVAL_SHORT, function()
    E.LOG.debug(TAG, "login time out")
    if login_cb_wrapper then
      E.LOG.debug(TAG, "login_cb_wrapper is not nil, so need to check if to retry steam login")
      if retry_number and tonumber(retry_number) >= max_retry_steam_login_count then
        local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_LOGIN_TIME_OUT, "login api time out", {})
        login_cb_wrapper(channel_result)
        return
      end
      if not retry_number or 0 == tonumber(retry_number) then
        retry_number = 1
      else
        retry_number = retry_number + 1
      end
      E.LOG.debug(TAG, "进行重试调用STEAM登录接口，当前为重试的第 " .. tostring(retry_number) .. " 次")
      steam_login_with_retry(retry_number)
    else
      E.LOG.debug(TAG, "time out but cb_wrapper is nil")
      E.LOG.debug(TAG, "login_cb_wrapper is nil, it means steam login callback before now")
    end
  end)
  login_steam_ticket(function(succ, body)
    local channel_result
    if succ then
      local ticket = body
      E.LOG.debug(TAG, "get ticket from steam return >> " .. ticket)
      local thirdPartyToken = {thirdPartyToken = ticket, appid = steam_appid}
      local user_info = {
        token = JSON.encode(thirdPartyToken)
      }
      channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {thirdparty_type = "STEAM"})
    else
      local code = (body or {}).error_code
      local message = (body or {}).error_msg or "steam login get ticket fail"
      message = message .. "-" .. tostring(code)
      channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_LOGIN_FAIL, message)
    end
    if login_cb_wrapper then
      login_cb_wrapper(channel_result)
    else
      E.LOG.debug(TAG, "native call back out but cb_wrapper is nil")
      ESTAT.app_pay_report({
        biz_func = "sdk.steam_login_result_after_timeout",
        biz_act = "finish",
        biz_st = succ and "succ" or "fail",
        biz_co = succ and "200" or (body or {}).error_code,
        biz_params = {body = body}
      })
    end
  end)
end

function STEAM.login(_ext, cb)
  login_cb = cb
  if E.Sysinfo.os() ~= "windows" then
    E.LOG.debug(TAG, "sign with Steam only support for Windows")
    local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.OFFICIAL_ERR_CODES.CODE_LOGIN_NOT_SUPPORT, "Not Support", {})
    if login_cb then
      login_cb(channel_result)
    end
    return
  end
  if not in_login then
    E.LOG.debug(TAG, "call steam login api")
    in_login = true
    
    function login_cb_wrapper(channel_result)
      E.LOG.debug(TAG, "login call back")
      in_login = false
      login_cb_wrapper = nil
      if login_cb then
        login_cb(channel_result)
      end
    end
    
    if check_if_steam_go_new_switch() then
      E.LOG.debug(TAG, "go new login_with_retry function")
      steam_login_with_retry()
      return
    end
    E.LOG.debug(TAG, "keep old steam login function")
    E.Timer.once(LOGIN_TIMEOUT_INTERVAL, function()
      E.LOG.debug(TAG, "login time out")
      if login_cb_wrapper then
        local channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_LOGIN_TIME_OUT, "login api time out", {})
        login_cb_wrapper(channel_result)
      else
        E.LOG.debug(TAG, "time out but cb_wrapper is nil")
      end
    end)
    login_steam_ticket(function(succ, body)
      local channel_result
      if succ then
        local ticket = body
        E.LOG.debug(TAG, "get ticket from steam return >> " .. ticket)
        local thirdPartyToken = {thirdPartyToken = ticket, appid = steam_appid}
        local user_info = {
          token = JSON.encode(thirdPartyToken)
        }
        channel_result = PROTOCOL.LoginResult.succ(CHANNEL, user_info, {thirdparty_type = "STEAM"})
      else
        local code = (body or {}).error_code
        local message = (body or {}).error_msg or "steam login get ticket fail"
        message = message .. "-" .. tostring(code)
        channel_result = PROTOCOL.LoginResult.fail(CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_LOGIN_FAIL, message)
      end
      if login_cb_wrapper then
        login_cb_wrapper(channel_result)
      else
        E.LOG.debug(TAG, "native call back out but cb_wrapper is nil")
        ESTAT.app_pay_report({
          biz_func = "sdk.steam_login_result_after_timeout_20",
          biz_act = "finish",
          biz_st = succ and "succ" or "fail",
          biz_co = succ and "200" or (body or {}).error_code,
          biz_params = {body = body}
        })
      end
    end)
  else
    E.LOG.debug(TAG, "steam in login and do not call again")
    ESTAT.app_pay_report({
      biz_func = "sdk.steam_login_call_frequency",
      biz_act = "finish",
      biz_st = "succ",
      biz_co = "200"
    })
  end
end

local current_gp_order_id

function STEAM.pay(product_id, gp_order_id, ds_order_id, attach_info_str, local_params)
  E.LOG.d(TAG, "start pay, params >>")
  E.LOG.d(TAG, {
    product_id = product_id,
    gp_order_id = gp_order_id,
    ds_order_id = ds_order_id,
    attach_info_str = attach_info_str
  })
  E.log(local_params)
  local product = local_params.product_info
  current_gp_order_id = local_params.gp_order_id
  local player_info = GDP.PLAYER_INFO.clone()
  player_info.player_token = nil
  local ext_info = {}
  if attach_info_str then
    ext_info = JSON.decode(attach_info_str)
  end
  
  local function pay_func(channel_token)
    local pay_params = {
      cpOrderId = ds_order_id,
      payProductID = product.product_id,
      payProductName = product.product_desc,
      currency = ext_info.currency,
      order_amt = ext_info.order_amt,
      pay_type = STEAM_PAY_TYPE,
      language = steam_language,
      channel_user_id = current_steam_id,
      channel_token = channel_token,
      channel_attrs = JSON.encode({steam_app_id = steam_appid}),
      player_info = JSON.encode(player_info)
    }
    if product.min_order_amt then
      pay_params.min_order_amt = tostring(product.min_order_amt)
    end
    PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
      if succ then
        local data = (...)
        local trade_id = data.trade_id
        E.LOG.debug(TAG, "支付预下单成功，trade_id = " .. tostring(trade_id))
      else
        local code, msg = ...
        E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
        local resp = {
          code = code,
          msg = msg,
          platform = CHANNEL,
          ext = {
            pay_part = "steam_gps_order",
            product_id = tostring(product_id),
            http_resp_body = {
              ...
            }
          }
        }
        pay_listener(false, local_params.gp_order_id, resp)
      end
    end)
  end
  
  if current_steam_id and "" ~= current_steam_id then
    pay_func()
  else
    login_steam_ticket(function(succ, body)
      if succ then
        local ticket = body
        pay_func(ticket)
      else
        local code = (body or {}).error_code or CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_VENDOR_UNKNOWN_LOGIN_FAILED
        local message = (body or {}).error_msg or "steam login get ticket fail"
        local resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_STEAM_NO_LOGIN_TICKET,
          msg = "steam ticket get error",
          platform = CHANNEL,
          ext = {
            pay_part = "steam_login_ticket_fail",
            product_id = tostring(product_id),
            current_steam_id = current_steam_id,
            code = code,
            message = message
          }
        }
        pay_listener(false, gp_order_id, resp)
      end
    end)
  end
end

local steam_callback_tick

function STEAM.init(opt, cb)
  E.LOG.debug(TAG, "steam init steam")
  if inited then
    E.LOG.debug(TAG, "steam vendor had inited")
    if cb then
      cb(true)
    end
    return
  end
  if not STEAM.is_support_channel_sdk() then
    E.LOG.debug(TAG, "not support_steam_sdk")
    if cb then
      cb(true)
    end
    return
  end
  local sdk_info = UNI.get_sdk_info(CHANNEL)
  E.log(sdk_info)
  if sdk_info and sdk_info.meta and type(sdk_info.meta.appid) == "string" and #sdk_info.meta.appid > 0 then
    steam_appid = sdk_info.meta.appid
    E.LOG.debug(TAG, "init steam id >> " .. steam_appid)
  end
  pay_listener = opt.pay_listener
  logout_listener = opt.logout_listener
  ET.subscribe(ET.ACCOUNT.LOGIN, login_listener)
  E.LOG.debug(TAG, "call native steam vendor init")
  local init_params = {appid = steam_appid}
  UNI.async_call(CHANNEL, ASYNC_STEAM_INIT, init_params, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "steam native init succ")
      
      function steam_callback_tick()
        E.LOG.debug(TAG, "steam cb tick")
        UNI.async_call(CHANNEL, ASYNC_STEAM_TICK, {}, nil, function(_succ2, ...)
        end)
        E.Timer.once(1, steam_callback_tick)
      end
      
      steam_callback_tick()
      local body = (...)
      E.LOG.debug(TAG, "steam init callback")
      E.LOG.debug(TAG, {body = body})
      save_steam_language(body)
      inited = true
      if cb then
        cb(true)
      end
    else
      E.LOG.error(TAG, "steam native init fail")
      local _code, body = ...
      local error_msg = "steam native init fail"
      E.LOG.debug(TAG, {body = body})
      if body and (body.error_code or body.error_msg) then
        local code = body.error_code
        local msg = body.error_msg
        error_msg = tostring(msg) .. "-" .. tostring(code)
      end
      if cb then
        cb(false, CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_NATIVE_INIT_FAILED, error_msg)
      end
    end
  end)
end

function STEAM.is_support_channel_sdk()
  if _ejoysdk.os() ~= "windows" then
    return false
  end
  local result = UNI.sync_call(CHANNEL, SYNC_STEAM_SUPPORT, {}, nil)
  E.LOG.debug(TAG, "is support steam cb")
  E.log(result)
  if result and result.value then
    return result.value
  end
  return false
end

function STEAM.is_support_steam_sdk()
  do return end
  return STEAM.is_support_channel_sdk, nil
end

function STEAM.can_auto_login()
  if STEAM.is_support_channel_sdk() then
    return false
  end
  return true
end

function STEAM.need_sdk_login()
  do return end
  return STEAM.is_support_channel_sdk, nil
end

function STEAM.check_token(_outsource, _info)
end

function STEAM.merge_info(info, pinfo)
  do return STEAM.merge_helper, info end
  return STEAM.merge_helper, info, pinfo
end

function STEAM.simple_token()
  return false
end

function STEAM.logout()
  E.LOG.debug(TAG, "logout called----")
  if logout_listener then
    logout_listener({})
  end
end

local switch = {
  english = "en",
  schinese = "zh-hans",
  tchinese = "zh-hant",
  japanese = "ja",
  koreana = "ko",
  vietnamese = "vi",
  indonesian = "id",
  thai = "th",
  german = "de",
  spanish = "es",
  french = "fr",
  polish = "pl",
  portuguese = "pt",
  brazilian = "pt-br",
  russian = "ru"
}

function STEAM.get_steam_language()
  if sdk_trans_steam_ui_language then
    return sdk_trans_steam_ui_language
  end
  local body = UNI.sync_call(CHANNEL, SYNC_GET_STEAM_LANGUAGE, {}, nil)
  E.LOG.debug(TAG, {SYNC_GET_STEAM_LANGUAGE = body})
  if body and next(body) then
    local ui_language = body.uiLanguage
    sdk_trans_steam_ui_language = ui_language and switch[ui_language] or sdk_trans_steam_ui_language
  end
  return sdk_trans_steam_ui_language
end

function STEAM.get_language()
  E.LOG.debug(TAG, "steam language >> " .. tostring(steam_language) .. ",steam ui_language >>" .. tostring(steam_ui_language))
  local sl = "en"
  local sul = "en"
  sl = not UTILS.is_text_empty(steam_language) and switch[steam_language] or sl
  sul = not UTILS.is_text_empty(steam_ui_language) and switch[steam_ui_language] or sul
  return steam_language, steam_ui_language, sl, sul
end

function STEAM.query_steam_account_status(cb)
  local UA = require("ejoysdk_lua.user_center.usercenter_api")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local user_info = EG.user_info()
  E.LOG.debug(TAG, "query_steam_account_status ---start")
  E.LOG.debug(TAG, {user_info = user_info})
  local account_token = user_info.ptoken
  UA.query_steam_account_status(steam_appid, current_steam_id, account_token, cb)
end

STEAM:is_implemented({"ACCOUNT"})
local EVT_STEAM_PAY_NOTIFY = "EVT_STEAM_PAY_NOTIFY"
local HANDLERS = {}
HANDLERS[EVT_STEAM_PAY_NOTIFY] = function(body)
  E.LOG.debug(TAG, "receive EVT_STEAM_PAY_NOTIFY")
  E.log(body)
  if body and body.orderId and body.authorized and body.appId then
    if 1 ~= body.authorized then
      if pay_listener then
        local resp = {
          code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
          msg = "pay cancelled",
          platform = CHANNEL,
          ext = {
            pay_part = "steam_authorized",
            current_steam_id = current_steam_id,
            body = body
          }
        }
        pay_listener(false, body.orderId, resp)
      end
      return
    end
    local jsonTable = {
      orderId = body.orderId,
      appId = body.appId,
      authorized = body.authorized
    }
    local params = {
      inapp_purchase_data = JSON.encode(jsonTable),
      pay_type = STEAM_PAY_TYPE,
      inapp_data_signature = ""
    }
    PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_UPLOAD_RECEIPT, params, function(succ, ...)
      if succ then
        local data = (...)
        E.LOG.debug(TAG, "upload_receipt_for_deliver_product -----succ = " .. tostring(succ))
        E.LOG.debug(TAG, "上传票据成功")
        E.LOG.debug(TAG, data)
        if pay_listener then
          pay_listener(true, current_gp_order_id)
        end
      else
        local code, msg = ...
        E.LOG.debug(TAG, "上传票据失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
        if pay_listener then
          local resp = {
            code = code,
            msg = msg,
            platform = CHANNEL,
            ext = {
              pay_part = "steam_upload_receipt",
              current_steam_id = current_steam_id,
              http_request_params = params,
              http_resp_body = {
                ...
              }
            }
          }
          pay_listener(false, body.orderId, resp)
        end
      end
    end)
  elseif pay_listener then
    local resp = {
      code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_STEAM_PAY_NOTIFY_BODY_EMPTY,
      msg = "EVT_STEAM_PAY_NOTIFY 返回数据空",
      platform = CHANNEL,
      ext = {
        pay_part = "steam_pay_notify",
        current_steam_id = current_steam_id,
        http_resp_body = body
      }
    }
    pay_listener(false, body.orderId or "", resp)
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
    end
  end)
end
return STEAM
