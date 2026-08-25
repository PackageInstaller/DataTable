local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PROTOCOL = require("ejoysdk_lua.account.api.protocol")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local VENDOR_NAME = "DYMINICLOUDGAME"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.DYMINICLOUDGAME
local ASYNC_LOGIN = "ASYNC_LOGIN"
local ASYNC_REQUEST_GAME_PAYMENT = "ASYNC_REQUEST_GAME_PAYMENT"
local ASYNC_OPEN_AWEME_CUSTOMER_SERVICE = "ASYNC_OPEN_AWEME_CUSTOMER_SERVICE"
local ASYNC_NAVIGATE_TO_SCENE = "ASYNC_NAVIGATE_TO_SCENE"
local ASYNC_CHECK_SCENE = "ASYNC_CHECK_SCENE"
local ASYNC_ADD_SHORTCUT = "ASYNC_ADD_SHORTCUT"
local ASYNC_CHECK_SHORTCUT = "ASYNC_CHECK_SHORTCUT"
local ASYNC_REPORT_SCENE = "ASYNC_REPORT_SCENE"
local ASYNC_OPEN_CUSTOMER_SERVICE_CONVERSATION = "ASYNC_OPEN_CUSTOMER_SERVICE_CONVERSATION"
local ASYNC_GET_SYSTEM_INFO = "ASYNC_GET_SYSTEM_INFO"
local ASYNC_GET_LAUNCH_OPTIONS_SYNC = "ASYNC_GET_LAUNCH_OPTIONS_SYNC"
local ASYNC_GET_ARCHIVE_RESULT = "ASYNC_GET_ARCHIVE_RESULT"
local ASYNC_ON_SHOW = "ASYNC_ON_SHOW"
local ASYNC_OFF_SHOW = "ASYNC_OFF_SHOW"
local ASYNC_ON_HIDE = "ASYNC_ON_HIDE"
local ASYNC_OFF_HIDE = "ASYNC_OFF_HIDE"
local ASYNC_REQUEST_FEED_SUBSCRIBE = "ASYNC_REQUEST_FEED_SUBSCRIBE"
local ASYNC_CHECK_FEED_SUBSCRIBE_STATUS = "ASYNC_CHECK_FEED_SUBSCRIBE_STATUS"
local ASYNC_ON_FEED_STATUS_CHANGE = "ASYNC_ON_FEED_STATUS_CHANGE"
local ASYNC_OFF_FEED_STATUS_CHANGE = "ASYNC_OFF_FEED_STATUS_CHANGE"
local ASYNC_GET_SETTING = "ASYNC_GET_SETTING"
local ASYNC_OPEN_SETTING = "ASYNC_OPEN_SETTING"
local ASYNC_SHARE_APP_MESSAGE = "ASYNC_SHARE_APP_MESSAGE"
local ASYNC_OPEN_AWEME_USER_PROFILE = "ASYNC_OPEN_AWEME_USER_PROFILE"
local ASYNC_CHECK_FOLLOW_AWEME_STATE = "ASYNC_CHECK_FOLLOW_AWEME_STATE"
local ASYNC_REQUEST_SUBSCRIBE_MESSAGE = "ASYNC_REQUEST_SUBSCRIBE_MESSAGE"
local ASYNC_SET_CLIPBOARD_DATA = "ASYNC_SET_CLIPBOARD_DATA"
local ASYNC_GET_CLIPBOARD_DATA = "ASYNC_GET_CLIPBOARD_DATA"
local ASYNC_ON_CLIPBOARD_CHANGE = "ASYNC_ON_CLIPBOARD_CHANGE"
local ASYNC_OFF_CLIPBOARD_CHANGE = "ASYNC_OFF_CLIPBOARD_CHANGE"
local DYMINICLOUDGAME_PAY_TYPE = "252"
local pay_listener
local ASYNC_GRANT_PHONE_NUMBER = "ASYNC_GRANT_PHONE_NUMBER"
local ASYNC_GET_PHONE_NUMBER_AUTH_STATE = "ASYNC_GET_PHONE_NUMBER_AUTH_STATE"
local current_douyin_uid, vendor_listenrs, _system_info, _platform_type, _launch_options

local function apply_inject_methods()
  if E.Sysinfo and not M._cloud_cutout then
    M._cloud_cutout = E.Sysinfo.cutout
    
    function E.Sysinfo.cutout()
      do return end
      return M.Sysinfo.cutout, nil
    end
  end
  if E.Sysinfo and not M._cloud_get_device_system then
    M._cloud_get_device_system = E.Sysinfo.get_device_system
    
    function E.Sysinfo.get_device_system()
      do return end
      return M.Sysinfo.get_device_system, nil
    end
  end
  if EG and not M._cloud_can_show_user_center then
    M._cloud_can_show_user_center = EG.can_show_user_center
    
    function EG.can_show_user_center()
      E.LOG.debug(TAG, "dy mini cloud game not support user center")
      return false
    end
  end
end

local function login_listener(user_info)
  if user_info and user_info.pinfo and user_info.pinfo.ext and user_info.pinfo.ext.ch_openid then
    current_douyin_uid = user_info.pinfo.ext.ch_openid
  end
end

local function get_player_token_handler()
  local player_info = EG.player_info()
  if not player_info or player_info and player_info.is_valid == false then
    E.LOG.debug(TAG, "player_info = nil or player_info.is_valid = false, ignore bind player")
    return
  end
  local push_api = require("ejoysdk_lua.server_api.push_ex")
  push_api.bind_channel("douyin", push_api.COLLECT_TYPE_PLAYERID, player_info.player_id)
end

local function acquire_succ_handler()
  local user_info = EG.user_info()
  local push_api = require("ejoysdk_lua.server_api.push_ex")
  push_api.bind_channel("douyin", push_api.COLLECT_TYPE_ACCOUNT, user_info.uid)
  if not _launch_options then
    M.get_launch_options(nil, nil)
  end
end

local EVT_HANDLERS = {}

function EVT_HANDLERS.EVT_CLIPBOARD_CHANGE(body)
  if vendor_listenrs and vendor_listenrs.on_clipboard_change then
    vendor_listenrs.on_clipboard_change(body)
  end
end

function EVT_HANDLERS.EVT_ON_SHOW(body)
  if vendor_listenrs and vendor_listenrs.on_show then
    vendor_listenrs.on_show(body)
  end
end

function EVT_HANDLERS.EVT_ON_HIDE(body)
  if vendor_listenrs and vendor_listenrs.on_hide then
    vendor_listenrs.on_hide(body)
  end
end

function EVT_HANDLERS.EVT_ARCHIVE_RESULT(body)
  if vendor_listenrs and vendor_listenrs.on_archive_result then
    vendor_listenrs.on_archive_result(body)
  end
end

function M.get_platform_info(cb)
  if _platform_type then
    if cb then
      cb(_platform_type, _system_info)
    end
    return
  end
  UNI.async_call(VENDOR_NAME, ASYNC_GET_SYSTEM_INFO, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if body and body.platform then
        _platform_type = body.platform
        _system_info = body
        E.LOG.debug(TAG, "get_platform_info success: " .. tostring(body.platform))
      end
    else
      E.LOG.debug(TAG, "get_platform_info failed")
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "check shortcut failed"
      E.LOG.warn(TAG, "get_platform_info failed: " .. tostring(error_msg) .. ", code: " .. tostring(error_code))
    end
    if cb then
      cb(_platform_type, _system_info)
    end
  end)
end

function M.init(_opt, cb)
  E.LOG.debug(TAG, "init dyminicloudgame start")
  apply_inject_methods()
  pay_listener = _opt.pay_listener
  ET.subscribe(ET.gangplank.ACQUIRE, login_listener)
  M.get_platform_info(nil)
  M.get_launch_options(nil, nil)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, get_player_token_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
  UNI.register_event_cb(VENDOR_NAME, function(_type, _body)
    local handler = EVT_HANDLERS[_type]
    if handler then
      handler(_body)
    end
  end)
  if cb then
    cb(true)
  end
end

function M.set_listeners(_listeners)
  vendor_listenrs = _listeners
  return true
end

function M.get_third_open_id()
  return current_douyin_uid
end

function M.get_third_ad_params()
  if not _launch_options then
    E.LOG.debug(TAG, "get_third_ad_params: launch_options not ready")
    return {}
  end
  if _launch_options.query and type(_launch_options.query) == "string" then
    if _launch_options.query == "null" then
      return ""
    end
    local decoded = JSON.decode(_launch_options.query)
    if decoded then
      _launch_options.query = decoded
    else
      E.LOG.warn(TAG, "get_third_ad_params: JSON decode failed")
      return ""
    end
  end
  return _launch_options.query and _launch_options.query.ad_params or ""
end

function M.get_cache_launch_option()
  if not _launch_options then
    E.LOG.debug(TAG, "get_cache_launch_option: launch_options not ready")
    return nil
  end
  return _launch_options
end

function M.login(_ext, cb)
  E.LOG.debug(TAG, "login start")
  local login_params = {force = true}
  UNI.async_call(VENDOR_NAME, ASYNC_LOGIN, login_params, nil, function(succ, ...)
    E.LOG.debug(TAG, "login result, succ: " .. tostring(succ))
    if succ then
      local body = (...)
      local code = body.code
      E.LOG.debug(TAG, "login success, code: " .. tostring(code))
      local meta_config = E.CONFIG.get_vendor_config_v2(VENDOR_NAME) or {}
      local clientKey = meta_config.app_id or meta_config.appId or ""
      local thirdPartyToken = {accessToken = code, clientId = clientKey}
      local user_info = {
        token = JSON.encode(thirdPartyToken)
      }
      local channel_result = PROTOCOL.LoginResult.succ(VENDOR_NAME, user_info, {thirdparty_type = VENDOR_NAME})
      E.LOG.debug(TAG, channel_result)
      if cb then
        cb(channel_result)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "login failed"
      E.LOG.error(TAG, "login failed, code: " .. tostring(error_code) .. ", msg: " .. tostring(error_msg))
      if cb then
        local result = PROTOCOL.LoginResult.fail(error_code, error_msg)
        cb(result)
      end
    end
  end)
end

local function pay_result_handler(success, gp_order_id, trade_id, ...)
  if pay_listener then
    if success then
      pay_listener(true, gp_order_id, ...)
    else
      local body = (...)
      local resp = {
        code = (body or {}).code or -1,
        msg = (body or {}).msg or "支付失败",
        ext = {
          pay_part = "dyminicloudgame_pay",
          trade_id = trade_id
        }
      }
      pay_listener(false, gp_order_id, resp)
    end
  end
end

local ejoy_pay_span

function M.pay(gp_order_id, ds_order_id, product, pay_params)
  pay_params.pay_type = DYMINICLOUDGAME_PAY_TYPE
  E.LOG.debug(TAG, "dyminicloudgame pay, gp_order_id = " .. tostring(gp_order_id))
  E.LOG.debug(TAG, "ds_order_id = " .. tostring(ds_order_id))
  E.LOG.debug(TAG, product)
  E.LOG.debug(TAG, pay_params)
  ejoy_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.DOUYIN_PAY)
  local gps_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.GPS_PAY)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
    ATracer.finish_pay_sub_span(gps_pay_span, {
      ...
    })
    local temp_data = (...)
    ESTAT.app_pay_report({
      biz_func = "sdk.show_dyminicloudgame_pay",
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
      E.LOG.debug(TAG, "开始云抖小支付下单，准备拉起收银台")
      ESTAT.app_pay_report({
        biz_func = "sdk.dyminicloudgame_pay_result",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {trade_id = trade_id}
      })
      local _params = {
        product_id = product.product_id,
        order_id = trade_id,
        order_amount = pay_params.min_order_amt,
        attach_info = pay_params.attach_info
      }
      if not _params.attach_info then
        E.LOG.error(TAG, "attach_info is nil")
        if pay_listener then
          pay_listener(false, gp_order_id, {
            code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_NO_SIGN_DATA,
            msg = "attach_info is nil",
            ext = {
              pay_part = "params_check"
            }
          })
        end
        return
      end
      M.get_platform_info(function(platform_system, _target_system_info)
        E.LOG.debug(TAG, "pay deviceSystem: " .. tostring(platform_system))
        local l_platform_system = platform_system and platform_system:lower()
        local async_type = "ios" == l_platform_system and ASYNC_OPEN_AWEME_CUSTOMER_SERVICE or ASYNC_REQUEST_GAME_PAYMENT
        if "windows" == l_platform_system or "mac" == l_platform_system then
          if pay_listener then
            pay_listener(false, gp_order_id, {
              code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_FAIL_NOT_SUPPORT,
              msg = "system not support",
              ext = {
                pay_part = "params_check"
              }
            })
          end
          return
        end
        local dyminicloudgame_pay_params = {
          env = 0,
          goodType = 2,
          zoneId = "1",
          mode = "game",
          orderAmount = tonumber(_params.order_amount),
          customId = _params.order_id,
          extraInfo = _params.attach_info
        }
        if "android" == l_platform_system then
          dyminicloudgame_pay_params.platform = "android"
          dyminicloudgame_pay_params.currencyType = "CNY"
        end
        UNI.async_call(VENDOR_NAME, async_type, dyminicloudgame_pay_params, nil, function(pay_succ, ...)
          E.LOG.debug(TAG, "pay result, succ: " .. tostring(pay_succ))
          ESTAT.app_pay_report({
            biz_func = "sdk.dyminicloudgame_pay_result",
            biz_act = "finish",
            biz_st = pay_succ and "succ" or "fail",
            biz_co = pay_succ and "200" or "400",
            biz_params = {gp_order_id = gp_order_id, trade_id = trade_id}
          })
          if pay_succ then
            local body = (...)
            pay_result_handler(true, gp_order_id, trade_id, body)
          else
            local _, body = ...
            local error_code = (body or {}).error_code or -1
            local error_msg = (body or {}).error_msg or "pay failed"
            E.LOG.error(TAG, "pay failed, code: " .. tostring(error_code) .. ", msg: " .. tostring(error_msg))
            local resp
            if tostring(error_code) == "20000" then
              resp = {
                code = CONSTANTS.OFFICIAL_ERR_CODES.CODE_PAY_CANCEL,
                msg = "取消支付"
              }
            else
              resp = {
                code = CONSTANTS.EJOYPAY_ERR_CODES.CODE_PAY_UNKNOWN,
                msg = "渠道支付失败，code：" .. tostring(error_code) .. "，msg：" .. tostring(error_msg)
              }
            end
            pay_result_handler(false, gp_order_id, trade_id, resp)
          end
          if ejoy_pay_span then
            ATracer.finish_pay_sub_span(ejoy_pay_span, {
              ...
            })
            ejoy_pay_span = nil
          end
        end)
      end)
    else
      local code, msg = ...
      E.LOG.error(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      if pay_listener then
        pay_listener(false, gp_order_id, {
          code = code,
          msg = msg,
          ext = {
            pay_part = "gps_order",
            product_id = tostring(product.product_id)
          }
        })
      end
    end
  end)
end

function M.navigate_to_scene(params, cb)
  E.LOG.debug(TAG, "navigate_to_scene start")
  local scene_params = {
    scene = params.scene or "sidebar"
  }
  UNI.async_call(VENDOR_NAME, ASYNC_NAVIGATE_TO_SCENE, scene_params, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "navigate_to_scene success")
      if cb then
        cb(true)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "navigate failed"
      E.LOG.error(TAG, "navigate_to_scene failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.check_scene(params, cb)
  E.LOG.debug(TAG, "check_scene start")
  local scene_params = {
    scene = params.scene or "sidebar"
  }
  UNI.async_call(VENDOR_NAME, ASYNC_CHECK_SCENE, scene_params, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(succ, body)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "check scene failed"
      E.LOG.error(TAG, "check_scene failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.add_shortcut(params, cb)
  E.LOG.debug(TAG, "add_shortcut start")
  UNI.async_call(VENDOR_NAME, ASYNC_ADD_SHORTCUT, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "add shortcut failed"
      E.LOG.error(TAG, "add_shortcut failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.check_shortcut(params, cb)
  E.LOG.debug(TAG, "check_shortcut start")
  UNI.async_call(VENDOR_NAME, ASYNC_CHECK_SHORTCUT, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "check shortcut failed"
      E.LOG.error(TAG, "check_shortcut failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.report_scene(params, cb)
  E.LOG.debug(TAG, "report_scene start")
  params = params or {}
  local report_params = {
    scene_id = params.scene_id or 7001
  }
  UNI.async_call(VENDOR_NAME, ASYNC_REPORT_SCENE, report_params, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "report_scene success")
      if cb then
        cb(true)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "report scene failed"
      E.LOG.error(TAG, "report_scene failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.open_customer_service(params, cb)
  E.LOG.debug(TAG, "open_customer_service start")
  local service_params = {
    type = params.type or 3,
    sessionFrom = params.session_from or ""
  }
  UNI.async_call(VENDOR_NAME, ASYNC_OPEN_CUSTOMER_SERVICE_CONVERSATION, service_params, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "open_customer_service success")
      if cb then
        cb(true)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "open customer service failed"
      E.LOG.error(TAG, "open_customer_service failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.show_custom_service(params, cb, _close_cb)
  E.LOG.debug(TAG, "show_custom_service start")
  M.open_customer_service(params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.get_system_info(_params, cb)
  E.LOG.debug(TAG, "get_system_info start")
  UNI.async_call(VENDOR_NAME, ASYNC_GET_SYSTEM_INFO, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "get system info failed"
      E.LOG.info(TAG, "get_system_info failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.get_launch_options(params, cb)
  E.LOG.debug(TAG, "get_launch_options start")
  UNI.async_call(VENDOR_NAME, ASYNC_GET_LAUNCH_OPTIONS_SYNC, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      _launch_options = body
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "get launch options failed"
      E.LOG.info(TAG, "get_launch_options failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.get_archive_result(params, cb)
  E.LOG.debug(TAG, "get_archive_result start")
  local archive_params = {
    timeout_millis = params.timeout_millis or 5000
  }
  UNI.async_call(VENDOR_NAME, ASYNC_GET_ARCHIVE_RESULT, archive_params, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "get archive result failed"
      E.LOG.info(TAG, "get_archive_result failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

local function share_app_message(params, cb)
  E.LOG.debug(TAG, "share_app_message start")
  UNI.async_call(VENDOR_NAME, ASYNC_SHARE_APP_MESSAGE, params or {}, nil, function(succ, ...)
    if succ then
      if cb then
        cb(true)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "share_app_message failed"
      E.LOG.info(TAG, "share_app_message failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.share(params, _chunk_data, cb)
  params = params or {}
  E.LOG.debug(TAG, params)
  if params.media and #params.media > 0 and params.media[1].type == "image_url" then
    share_app_message(params, cb)
  elseif params.content_url then
    if cb then
      cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "douyin share url not support")
    end
  elseif cb then
    cb(false, CONSTANTS.SHARE.CODE_PARAM_NOT_SUPPORT, "douyin share param not support")
  end
end

function M.open_aweme_user_profile(params, cb)
  E.LOG.debug(TAG, "open_aweme_user_profile start")
  UNI.async_call(VENDOR_NAME, ASYNC_OPEN_AWEME_USER_PROFILE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "open_aweme_user_profile failed"
      E.LOG.info(TAG, "open_aweme_user_profile failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.check_follow_aweme_state(params, cb)
  E.LOG.debug(TAG, "check_follow_aweme_state start")
  UNI.async_call(VENDOR_NAME, ASYNC_CHECK_FOLLOW_AWEME_STATE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local _, body = ...
      local error_code = (body or {}).error_code or -1
      local error_msg = (body or {}).error_msg or "check_follow_aweme_state failed"
      E.LOG.info(TAG, "check_follow_aweme_state failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.subscribe_msg(params, cb)
  E.LOG.debug(TAG, "request_subscribe_message start")
  params = params or {}
  UNI.async_call(VENDOR_NAME, ASYNC_REQUEST_SUBSCRIBE_MESSAGE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if params.template_id and body[params.template_id] == "accept" then
        local push_api = require("ejoysdk_lua.server_api.push_ex")
        push_api.inc_msg_subscribe("douyin", params.template_id)
        E.LOG.debug(TAG, "subscribe msg success")
      end
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "subscribe_msg failed"
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.set_clipboard_data(params, cb)
  E.LOG.debug(TAG, "set_clipboard_data start")
  UNI.async_call(VENDOR_NAME, ASYNC_SET_CLIPBOARD_DATA, params or {}, nil, function(succ, ...)
    if cb then
      cb(succ)
    end
  end)
end

function M.get_clipboard_data(params, cb)
  E.LOG.debug(TAG, "get_clipboard_data start")
  UNI.async_call(VENDOR_NAME, ASYNC_GET_CLIPBOARD_DATA, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "get_clipboard_data failed"
      E.LOG.info(TAG, "get_clipboard_data failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.on_show(params, cb)
  E.LOG.debug(TAG, "on_show start")
  UNI.async_call(VENDOR_NAME, ASYNC_ON_SHOW, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "on_show failed"
      E.LOG.info(TAG, "on_show failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.off_show(params, cb)
  E.LOG.debug(TAG, "off_show start")
  UNI.async_call(VENDOR_NAME, ASYNC_OFF_SHOW, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "off_show failed"
      E.LOG.info(TAG, "off_show failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.on_hide(params, cb)
  E.LOG.debug(TAG, "on_hide start")
  UNI.async_call(VENDOR_NAME, ASYNC_ON_HIDE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "on_hide failed"
      E.LOG.info(TAG, "on_hide failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.off_hide(params, cb)
  E.LOG.debug(TAG, "off_hide start")
  UNI.async_call(VENDOR_NAME, ASYNC_OFF_HIDE, params or {}, nil, function(succ, ...)
    if cb then
      cb(succ)
    end
  end)
end

function M.request_feed_subscribe(params, cb)
  E.LOG.debug(TAG, "request_feed_subscribe start")
  UNI.async_call(VENDOR_NAME, ASYNC_REQUEST_FEED_SUBSCRIBE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "request_feed_subscribe failed"
      E.LOG.info(TAG, "request_feed_subscribe failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.check_feed_subscribe_status(params, cb)
  E.LOG.debug(TAG, "check_feed_subscribe_status start")
  UNI.async_call(VENDOR_NAME, ASYNC_CHECK_FEED_SUBSCRIBE_STATUS, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "check_feed_subscribe_status failed"
      E.LOG.info(TAG, "check_feed_subscribe_status failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.on_feed_status_change(params, cb)
  E.LOG.debug(TAG, "on_feed_status_change start")
  UNI.async_call(VENDOR_NAME, ASYNC_ON_FEED_STATUS_CHANGE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "on_feed_status_change failed"
      E.LOG.info(TAG, "on_feed_status_change failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.off_feed_status_change(params, cb)
  E.LOG.debug(TAG, "off_feed_status_change start")
  UNI.async_call(VENDOR_NAME, ASYNC_OFF_FEED_STATUS_CHANGE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "off_feed_status_change failed"
      E.LOG.error(TAG, "off_feed_status_change failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.get_setting(params, cb)
  E.LOG.debug(TAG, "get_setting start")
  UNI.async_call(VENDOR_NAME, ASYNC_GET_SETTING, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "get setting failed"
      E.LOG.error(TAG, "get_setting failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.open_setting(params, cb)
  E.LOG.debug(TAG, "open_setting start")
  UNI.async_call(VENDOR_NAME, ASYNC_OPEN_SETTING, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "open_setting failed"
      E.LOG.error(TAG, "open_setting failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.on_clipboard_change(params, cb)
  E.LOG.debug(TAG, "on_clipboard_change start")
  UNI.async_call(VENDOR_NAME, ASYNC_ON_CLIPBOARD_CHANGE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "on_clipboard_change failed"
      E.LOG.error(TAG, "on_clipboard_change failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.off_clipboard_change(params, cb)
  E.LOG.debug(TAG, "off_clipboard_change start")
  UNI.async_call(VENDOR_NAME, ASYNC_OFF_CLIPBOARD_CHANGE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "off_clipboard_change failed"
      E.LOG.info(TAG, "off_clipboard_change failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.grant_phone_number(params, cb)
  E.LOG.debug(TAG, "grant_phone_number start")
  UNI.async_call(VENDOR_NAME, ASYNC_GRANT_PHONE_NUMBER, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "grant_phone_number failed"
      E.LOG.info(TAG, "grant_phone_number failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.get_phone_number_auth_state(params, cb)
  E.LOG.debug(TAG, "get_phone_number_auth_state start")
  UNI.async_call(VENDOR_NAME, ASYNC_GET_PHONE_NUMBER_AUTH_STATE, params or {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      if cb then
        cb(true, body)
      end
    else
      local code, body = ...
      local error_code = code or -1
      local error_msg = (body or {}).error_msg or "get_phone_number_auth_state failed"
      E.LOG.info(TAG, "get_phone_number_auth_state failed: " .. tostring(error_msg))
      if cb then
        cb(false, error_code, error_msg)
      end
    end
  end)
end

function M.logout()
  E.LOG.debug(TAG, "logout called")
end

function M.simple_token()
  return false
end

function M.is_share_support()
  E.LOG.debug(TAG, "douyin share support")
  return true
end

M:is_implemented({"SHARE"})
local Sysinfo = {}
M.Sysinfo = Sysinfo

function M.Sysinfo.cutout()
  local cutout_rect = {
    x = 0,
    y = 0,
    width = 0,
    height = 0
  }
  if not _system_info then
    E.LOG.warn(TAG, "cutout: system_info not ready, return default")
    return {
      cutout_rects = {cutout_rect},
      safe_inset = {
        top = 0,
        left = 0,
        bottom = 0,
        right = 0
      }
    }
  end
  local safe_inset
  local screen_width = _system_info.screenWidth
  local screen_height = _system_info.screenHeight
  local pixel_ratio = _system_info.pixelRatio or 1
  if not (_system_info.safeArea and _system_info.safeArea.top) or _system_info.safeArea.top == "" then
    safe_inset = {
      top = 0,
      left = 0,
      bottom = 0,
      right = 0
    }
  else
    if screen_width < _system_info.safeArea.width then
      E.LOG.warn(TAG, "system_info screen width height error, origin width: " .. tostring(screen_width) .. ", origin height: " .. tostring(screen_height))
      local temp_screen_width = screen_width
      screen_width = screen_height
      screen_height = temp_screen_width
      E.LOG.warn(TAG, "system_info screen width height error, final width: " .. tostring(screen_width) .. ", final height: " .. tostring(screen_height))
    end
    safe_inset = {
      top = math.floor(_system_info.safeArea.top * pixel_ratio),
      left = math.floor(_system_info.safeArea.left * pixel_ratio),
      bottom = math.floor((screen_height - _system_info.safeArea.bottom) * pixel_ratio),
      right = math.floor((screen_width - _system_info.safeArea.right) * pixel_ratio)
    }
  end
  if safe_inset.top < 0 or safe_inset.bottom < 0 or safe_inset.left < 0 or safe_inset.right < 0 then
    E.LOG.warn(TAG, "safe_inset error, return default_safe_inset, origin safe_inset: ")
    E.log(safe_inset)
    safe_inset = {
      top = 0,
      bottom = 0,
      left = 0,
      right = 0
    }
  end
  local result = {
    cutout_rects = {cutout_rect},
    safe_inset = safe_inset
  }
  return result
end

function Sysinfo.get_device_system()
  local platform = _system_info and _system_info.platform
  local brand = _system_info and _system_info.brand or ""
  local os = "unknown"
  if not platform or "" == platform then
    return os
  end
  platform = string.lower(platform)
  if string.find(platform, "ios") then
    os = "ios"
  elseif string.find(platform, "android") then
    os = "android"
  elseif string.find(platform, "harmony") then
    os = "harmonyos"
  else
    brand = string.lower(brand)
    if string.find(brand, "apple") then
      os = "mac"
    else
      os = "windows"
    end
  end
  return os
end

return M
