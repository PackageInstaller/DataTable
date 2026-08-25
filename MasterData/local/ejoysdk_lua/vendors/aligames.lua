local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local AIRLINE_V2 = require("ejoysdk_lua.vendors.airline_v2")
local AIRLINE_V1 = require("ejoysdk_lua.vendors.airline_v1")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ACF = require("ejoysdk_lua.vendors.aligames_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local AP = require("ejoysdk_lua.pay.protocol.dspay_protocol")
local MD5 = require("ejoysdk_lua.libs.md5")
local AUTO_LOGIN = require("ejoysdk_lua.vendors.auto_login")
local CHANNEL = "ALIGAMES"
local UNISDK_CHANNEL = "ALIGAMES"
local TAG = EM.MODULE.VENDORS.ALIGAMES
local CAST_CUSTOM_SERVICE = "CAST_CUSTOM_SERVICE"
local CLOSE_EVENT_DATA_USER_CENTER = "aligames_user_center"
local CLOSE_EVENT_DATA_BBS = "aligames_bbs"
local CLOSE_EVENT_DATA_CUSTOM = "aligames_custom"
local CLOSE_EVENT_DATA_CUSTOMER_SERVICE = "aligames_customer_service"
local CAST_ALIGAMES_NOTIFY_RESULT = "CAST_ALIGAMES_NOTIFY_RESULT"
local CAST_ALIGAMES_COMMON_CALL = "CAST_ALIGAMES_COMMON_CALL"
local PAY_FAILED_NOT_REALNAME = -10001
local PAY_FAILED_LIMITED = -10002
local M = Vendor:Inherit(CHANNEL)
local logout_listener, pay_listener, exit_listener
local pay_inited = false
local product_infos = {}
local pay_params = {}
local bbs_url
local account_user_info = {}
local logining_vendor_name, aligames_pay_span
local products_request_times = 0
local LAST_LOGIN_SUCC_VENDOR = E.SPKeyStore:New("com.ejoy.sdk.lua", "LAST_LOGIN_SUCC_VENDOR")
local ALIGAMES_HAS_UNFINISHED_PAY_ORDER = E.LazyKeyStore:New("ALIGAMES_HAS_UNFINISHED_PAY_ORDER_V1", false, true, false)
local last_pay_product_id, ext_channel_info

local function check_if_support_vendor(vendor_name)
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

local need_go_pay_prewrite_way = false
local EJOY_GAME_LAST_PAY_SWITCH = E.LazyKeyStore:New("EJOY_GAME_LAST_PAY_SWITCH_V1", false, true, false)

local function setupPayControlSwitch()
  E.LOG.debug(TAG, "setupPayControlSwitch ----- called")
  local is_official_channel = tostring(E.get_channel()) == "998233" or false
  local is_contain_ejoypay = check_if_support_vendor("EJOYPAY")
  local can_switch_traffic = is_official_channel and is_contain_ejoypay
  local stat_params = {}
  local is_airline_v2_login_and_go_ejoypay = check_if_support_vendor("AIRLINE_V2") and can_switch_traffic
  if _ejoysdk.os() == "harmonyos" or _ejoysdk.os() == "windows" or _ejoysdk.os() == "weixin" or _ejoysdk.os() == "douyin" or is_airline_v2_login_and_go_ejoypay then
    E.LOG.debug(TAG, "鸿蒙和Windows、微信小游戏都必须走新支付插件, os = " .. tostring(_ejoysdk.os()))
    E.LOG.debug(TAG, "当前是灵犀2.0登录且能切新支付的包，就直接切到新支付流程去")
    E.LOG.debug(TAG, {
      is_contain_ejoypay = is_contain_ejoypay,
      can_switch_traffic = can_switch_traffic,
      is_airline_v2_login_and_go_ejoypay = is_airline_v2_login_and_go_ejoypay
    })
    need_go_pay_prewrite_way = true
  elseif can_switch_traffic then
    local last_pay_method = EJOY_GAME_LAST_PAY_SWITCH:get()
    local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
    local ejoy_pay_has_unfinished_order = ejoy_pay.has_unfinished_transaction()
    local aligames_has_unfinished_order = ALIGAMES_HAS_UNFINISHED_PAY_ORDER:get()
    stat_params = {
      ejoy_pay_has_unfinished_order = ejoy_pay_has_unfinished_order,
      aligames_has_unfinished_order = aligames_has_unfinished_order,
      last_pay_method = last_pay_method
    }
    if ejoy_pay_has_unfinished_order or aligames_has_unfinished_order then
      E.LOG.debug(TAG, "ios当前存在未结束的订单，需要保持原来的开关")
      E.LOG.debug(TAG, "ejoy_pay_has_unfinished_order = " .. tostring(ejoy_pay_has_unfinished_order))
      E.LOG.debug(TAG, "aligames_has_unfinished_order = " .. tostring(aligames_has_unfinished_order))
      need_go_pay_prewrite_way = last_pay_method or false
    else
      E.LOG.debug(TAG, "iOS或安卓，是官渠包且接入了新支付插件的版本，当前可以读取灰度控制的下发开关来尝试切流")
      need_go_pay_prewrite_way = true
      E.LOG.debug(TAG, "安卓和iOS已经全量走新支付链路了，不再读取灰度开关，直接让其走新支付链路")
    end
  end
  EJOY_GAME_LAST_PAY_SWITCH:set(need_go_pay_prewrite_way)
  stat_params.need_go_pay_prewrite_way = need_go_pay_prewrite_way
  stat_params.is_official_channel = is_official_channel
  stat_params.channel_id = E.get_channel()
  stat_params.is_contain_ejoypay = is_contain_ejoypay
  stat_params.can_switch_traffic = can_switch_traffic
  ESTAT.stat_action("pay_switch_choose", "", false, stat_params)
  return need_go_pay_prewrite_way
end

local function check_products()
  EG.product_infos_base(CHANNEL, function(succ, infos)
    products_request_times = products_request_times + 1
    if succ then
      E.LOG.debug(TAG, "获取 aligames product info success")
      product_infos = infos
      ET.publish("purchase_inited", CHANNEL, infos)
      E.LOG.debug(TAG, product_infos)
      pay_inited = true
      local stat_params = {}
      stat_params.request_times = products_request_times
      ESTAT.stat_action("products_check", nil, true, stat_params)
    else
      E.LOG.error(TAG, "获取 aligames product info failure")
      if not UTILS.STR.is_empty(EG.user_info().ptoken) then
        E.LOG.debug(TAG, "it's login state, and need recheck products")
        E.Timer.once(5, check_products)
        if 50 == products_request_times then
          E.LOG.warn(TAG, "check_products reaches so much times, need stat")
          local stat_params = {}
          stat_params.request_times = products_request_times
          ESTAT.stat_action("products_check", nil, false, stat_params)
        end
      else
        E.LOG.debug(TAG, "check_products logout state, not need check products")
      end
    end
  end)
end

local function login_handler()
  if pay_inited then
    return
  end
  E.LOG.debug(TAG, "开始获取 aligames product info")
  products_request_times = 0
  check_products()
end

local function account_login_handler(login_result)
  E.LOG.d(TAG, "dasheng account login finished")
  local is_succ = login_result and login_result:is_succ() or false
  if true == is_succ then
    E.LOG.d(TAG, "dasheng account login finished succ ")
    local user_data = login_result.ext.account_data or {}
    local channel_info = login_result.ext.channel_info or {}
    UNI.cast(UNISDK_CHANNEL, CAST_ALIGAMES_NOTIFY_RESULT, {
      event = 30001,
      data = {
        succ = is_succ,
        login_result = user_data,
        channel_info = channel_info
      }
    })
  end
end

local IOS_PAY_UN_CERTIFICATION = "UN_CERTIFICATION"
local IOS_PAY_UNDER_AGE_OVER_LIMIT = "UNDER_AGE_OVER_LIMIT"

local function get_ios_pay_error(msg)
  if not msg then
    return nil
  end
  local pattern = "NSLocalizedDescription=(.-)%[(.-)%]"
  local error_msg, error_code
  msg:gsub(pattern, function(p1, p2)
    error_msg = p1
    error_code = p2
  end)
  return error_code, error_msg
end

local function get_android_pay_error(msg)
  if not msg then
    return nil
  end
  local pattern = "%((-*%d+)%).*"
  local code = string.match(msg, pattern)
  return code
end

local function check_dingding_login_ios()
  local function check_dingding_support()
    local support_one, one_data = check_if_support_vendor("ONE")
    
    if support_one and one_data and one_data.meta_data and one_data.meta_data.login_cover_lingxi == true then
      E.LOG.debug(TAG, "ONE登录配置为覆盖灵犀登录，为了兼容star旧包和新游戏的ONE登录。")
      return true
    end
    return false
  end
  
  return _ejoysdk.os() == "ios" and check_dingding_support()
end

local function is_windows_official_channel_id()
  local user_info = EG.user_info() or {}
  local current_platform = user_info.platform
  E.LOG.d(TAG, "current_platform >> " .. tostring(current_platform))
  return _ejoysdk.os() == "windows" and "998233" == current_platform
end

local function get_login_vendor(login_type)
  local vendor
  if not UTILS.STR.is_empty(login_type) then
    vendor = EV.get(login_type)
  end
  if not vendor then
    login_type = ""
    local default = "AIRLINE_V1"
    local airline_v1 = AIRLINE_V1
    if check_if_support_vendor("HARMONY_ACCOUNT") then
      login_type = "HARMONY_ACCOUNT"
    elseif airline_v1.should_lua_login() then
      if check_dingding_login_ios() then
        login_type = "ONE"
      elseif check_if_support_vendor("AIRLINE_V2") then
        E.LOG.debug(TAG, "check_if_support_vendor true")
        login_type = "AIRLINE_V2"
      end
    end
    if not UTILS.STR.is_empty(login_type) then
      vendor = EV.get(login_type)
    end
    if not vendor then
      E.LOG.d(TAG, "get lingxi 1.0")
      login_type = default
      vendor = airline_v1
    end
  end
  E.LOG.debug(TAG, "get_login_vendor, vendor ===" .. (login_type or ""))
  return vendor, login_type
end

function M.login(params, origin_cb)
  E.LOG.debug(TAG, "aligames login start")
  logining_vendor_name = nil
  local aligames_login_span = ATracer.start_login_sub_span(ATracer.ACCOUNT_FLOWS_SPANS.ALIGAMES_LOGIN)
  local vendor, vendor_name = get_login_vendor()
  E.LOG.debug(TAG, "get_login_vendor >> " .. tostring(vendor_name))
  
  function M.login_cb(result)
    E.LOG.debug(TAG, "login_callback---called, result = ")
    E.LOG.debug(TAG, result)
    if result and result:is_succ() then
      ext_channel_info = result.ext or {}
      local account_data = (result.ext or {}).account_data or {}
      if account_data.loginPolicy and 1 == account_data.loginPolicy then
        E.LOG.debug(TAG, "此时属于账号扫码登录方式，用户授权时选择了登录仅单次有效，不能保存到登录历史")
        E.LOG.debug(TAG, "此时也不能把扫码记录为上次登录的插件名")
      else
        logining_vendor_name = result.platform
        LAST_LOGIN_SUCC_VENDOR:set(vendor_name)
      end
    end
    ATracer.finish_login_sub_span(aligames_login_span, {cb_result = result})
    origin_cb(result)
  end
  
  if need_go_pay_prewrite_way then
    E.LOG.debug(TAG, "need go pay prewrite way")
    params.do_not_pay = true
  else
    local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
    params.wx_appid = ejoy_pay.get_wx_appid()
  end
  if vendor then
    E.LOG.debug(TAG, "call vendor login")
    vendor.login(params, M.login_cb)
  else
    E.LOG.debug(TAG, "login call error, vendor is nil, something wrong")
  end
end

function M.login_fail(status, last_login_params, fail_cb)
  local vendor = get_login_vendor()
  if vendor and vendor.login_fail then
    do return vendor.login_fail, status, last_login_params end
    return vendor.login_fail, status, last_login_params, fail_cb
  else
    E.LOG.debug(TAG, "vendor not implementation login_fail function")
  end
  return false
end

function M.logout()
  E.LOG.debug(TAG, "logout called---")
  AUTO_LOGIN.clear_last_login()
  local last_vendor = LAST_LOGIN_SUCC_VENDOR:get()
  local channel_vendor = EV.get(last_vendor)
  E.LOG.d(TAG, "last vendor: " .. tostring(channel_vendor or "nil"))
  if channel_vendor then
    channel_vendor.logout()
  else
    logout_listener({})
  end
end

function M.get_user_info()
  return account_user_info
end

function M.is_sandbox_user()
  return (M.get_user_info() or {}).is_sandbox_user == true
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

function M.can_pay()
  return pay_inited
end

function M.vendor_channel()
  return CHANNEL
end

local g_gangplank_pay_callback_table = {}

local function hander_android_pay_timeout_callback(order_id)
  g_gangplank_pay_callback_table[order_id] = true
  local timeout_value = 300
  local ECC = require("ejoysdk_lua.ejoysdk_config_center")
  local BizConfig = ECC.get_config(ECC.NAMESPACE.EJOYSDK_BIZ)
  local BizConfigData = BizConfig and BizConfig.config
  if BizConfigData and BizConfigData.time_config and BizConfigData.time_config.pay_callback_time_out then
    timeout_value = tonumber(BizConfigData.time_config.pay_callback_time_out)
  end
  E.Timer.once(timeout_value, function()
    E.LOG.debug(TAG, "支付的超时回调来啦----")
    E.LOG.debug(TAG, "order_id = " .. tostring(order_id))
    if not g_gangplank_pay_callback_table[order_id] then
      E.LOG.debug(TAG, "之前已经回调过该次支付，或者其他原因清理了缓存数据，直接丢弃本次超时回调")
      return
    end
    local ext_params = {}
    ext_params.ext = {}
    ext_params.ext.code = CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_PAY_TIMEOUT
    E.LOG.debug(TAG, "回调游戏本次支付超时")
    pay_listener(false, order_id, ext_params)
    g_gangplank_pay_callback_table[order_id] = nil
  end)
end

local function handle_pay_result(succ, _order_id, ext_params)
  E.LOG.debug(TAG, "aligames lua pay listener, succ: " .. tostring(succ))
  E.LOG.debug(TAG, "order_id ===" .. tostring(_order_id))
  E.LOG.debug(TAG, ext_params)
  local os = E.Sysinfo.os()
  if "android" == os and not g_gangplank_pay_callback_table[_order_id] then
    local utils = require("ejoysdk_lua.ejoysdk_utils")
    if not _order_id or 0 == string.len(tostring(_order_id)) or utils.tablelength(g_gangplank_pay_callback_table) > 0 then
      E.LOG.debug(TAG, "g_gangplank_pay_callback_table 里找不到order_id，是因为order_id为空，或者 order_id不是gangplank创建的导致匹配不上. order_id = " .. tostring(_order_id))
      E.LOG.debug(TAG, "此时依然需要给游戏支付回调，且同时清空缓存table，避免5分钟后继续超时回调支付pay_listener")
      g_gangplank_pay_callback_table = {}
    else
      E.LOG.debug(TAG, "之前已经回调过支付callback，本次不再进行回调")
      return
    end
  end
  if aligames_pay_span then
    ATracer.finish_pay_sub_span(aligames_pay_span, {
      succ = succ,
      order_id = _order_id,
      ext_params = ext_params
    })
    aligames_pay_span = nil
  end
  if not succ then
    ext_params.ext = ext_params.ext or {}
    ext_params.ext.product_id = tostring(last_pay_product_id)
    if "ios" == os then
      local error_code, error_msg = get_ios_pay_error(ext_params.ext.msg)
      E.LOG.error(TAG, "pay aligames error_code: " .. tostring(error_code))
      if error_code == IOS_PAY_UN_CERTIFICATION then
        ext_params.ext.code = PAY_FAILED_NOT_REALNAME
        ext_params.ext.msg = error_msg
        pay_listener(false, _order_id, ext_params)
        return
      elseif error_code == IOS_PAY_UNDER_AGE_OVER_LIMIT then
        ext_params.ext.code = PAY_FAILED_LIMITED
        ext_params.ext.msg = error_msg
        pay_listener(false, _order_id, ext_params)
        return
      end
    elseif "android" == os then
      local err_msg = ext_params.msg
      local code = get_android_pay_error(err_msg)
      E.LOG.error(TAG, "pay failed, err_msg:" .. (err_msg or "nil") .. ", code:" .. (code or "nil"))
      if code and #code > 0 then
        ext_params.ext.code = code
        ext_params.ext.msg = err_msg
        E.LOG.warn(TAG, "pay failed ext params >>")
        E.LOG.warn(TAG, ext_params)
        pay_listener(false, _order_id, ext_params)
        if _order_id then
          g_gangplank_pay_callback_table[_order_id] = nil
        end
        E.LOG.debug(TAG, "回调支付失败")
        return
      end
    elseif "windows" == os then
      E.LOG.debug(TAG, "nothing to do here")
    end
  end
  pay_listener(succ, _order_id, ext_params)
  if "android" == os then
    if _order_id then
      g_gangplank_pay_callback_table[_order_id] = nil
    end
    E.LOG.debug(TAG, "android回调支付")
  elseif "ios" == os and succ then
    ALIGAMES_HAS_UNFINISHED_PAY_ORDER:set(false)
  end
end

function M.pay(product_id, _count, gp_order_id, _body)
  E.LOG.debug(TAG, "pay function called")
  local product = product_infos[product_id]
  assert(product, "product_id " .. tostring(product_id) .. " not found")
  local money = product.money
  if _ejoysdk.os() == "ios" then
    money = tonumber(product.money)
    money = money / 100.0
    E.LOG.debug(TAG, "aligames pay, product = ")
    E.LOG.debug(TAG, product)
  end
  pay_params = {
    cpOrderId = gp_order_id,
    amount = money,
    moneyType = product.money_type,
    payProductID = product.product_id,
    payProductName = product.product_desc,
    payProductDescribe = product.product_desc,
    payProductExt = product.product_ext or {},
    payProductType = product.product_type or 1,
    payCallbackURL = EG.gangplank_url("/notify/aligames"),
    payCallbackParams = ""
  }
  E.LOG.debug(TAG, "pay params >>")
  E.LOG.debug(TAG, pay_params)
  local os = _ejoysdk.os and _ejoysdk.os()
  if "ios" == os then
    local CG = require("ejoysdk_lua.cloud_game.cloud_config")
    local pkgInfo = E.get_pkg_info()
    if pkgInfo.cloud_game_mode and pkgInfo.cloud_game_mode == CG.CLOUD_MODE.MOBILE then
      E.LOG.debug(TAG, "ios云微端才需要拼接这个后缀")
      local cloud_suffix_str = ".cloud_ejoy"
      if E.Utils.end_with(product.product_id, cloud_suffix_str) then
        E.LOG.debug(TAG, "已经拼接过云微端后缀字符串了，不需要再次拼接")
      else
        pay_params.payProductID = product.product_id .. cloud_suffix_str
        product.product_id = pay_params.payProductID
      end
      local temp_params = {
        cloudSuffix = ".cloud_ejoy"
      }
      local params_str = JSON.encode(temp_params)
      pay_params.payCallbackParams = params_str
    end
  end
  aligames_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.ALIGAMES_PAY)
  if "windows" ~= os or is_windows_official_channel_id() then
    ESTAT.create_order_report({
      biz_func = "sdk.pay_chain",
      biz_act = "visit",
      biz_st = "succ",
      biz_co = "200",
      biz_chain_ver = need_go_pay_prewrite_way and "1" or "0"
    })
    if need_go_pay_prewrite_way then
      E.LOG.debug(TAG, "need_go_pay_prewrite_way = true，走新的支付插件ejoypay的支付流程")
      local channel_ext = {isGwSdk = true}
      if "ios" == os then
        pay_params.amount = pay_params.amount * 100.0
      end
      local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
      ejoy_pay.show_loading_ios()
      local account_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.ACCOUNT_PAY)
      ESTAT.create_order_report({
        biz_func = "sdk.create_ds_order",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {product_id = product_id, gp_order_id = gp_order_id}
      })
      AP.create_order(pay_params, channel_ext, function(succ, ...)
        ejoy_pay.hide_loading_ios()
        local temp_data = (...)
        ESTAT.create_order_report({
          biz_func = "sdk.create_ds_order",
          biz_act = "finish",
          biz_st = succ and "succ" or "fail",
          biz_co = succ and "200" or "400",
          biz_params = {
            product_id = product_id,
            gp_order_id = gp_order_id,
            ds_order_id = succ and temp_data and temp_data.dsOrderId or nil
          }
        })
        if succ then
          local body_data = (...)
          local ds_order_id = body_data.dsOrderId
          product.min_order_amt = body_data.minOrderAmount
          E.LOG.debug(TAG, "go to new ejoy pay, ds_order_id >>" .. tostring(ds_order_id))
          E.LOG.debug(TAG, {body_data = body_data})
          ATracer.finish_pay_sub_span(account_pay_span, body_data)
          local attach_info_str = body_data.ex
          if body_data.ex and type(body_data.ex) == "table" then
            attach_info_str = JSON.encode(body_data.ex)
          end
          local ULM = require("ejoysdk_lua.account.union_login_manager")
          local shareVendor
          if ULM.check_is_union_pkg() then
            local vendor_name = ULM.check_is_union_pkg()
            shareVendor = EV.get(vendor_name)
          end
          if shareVendor and shareVendor.supportPay() and _ejoysdk.os() == "android" then
            E.LOG.debug(TAG, "this is android share package, go shareVendor.pay function")
            shareVendor.pay(gp_order_id, ds_order_id, product, body_data.ex or {})
          else
            E.LOG.debug(TAG, "go ejoy_pay.pay function")
            ejoy_pay.pay(gp_order_id, ds_order_id, product, attach_info_str)
          end
        else
          local code, message = ...
          E.LOG.debug(TAG, "create ds order fail, code: " .. tostring(code) .. ", message: " .. tostring(message))
          local resp = {
            code = code,
            msg = tostring(message),
            ext = {
              pay_part = "account_order",
              product_id = tostring(product_id)
            }
          }
          ATracer.finish_pay_sub_span(account_pay_span, resp)
          pay_listener(false, gp_order_id, resp)
          local show_msg = "支付异常，请稍后再试或联系客服。"
          local title = "提示"
          if 5003003 == code then
            show_msg = "交易失败，请重启游戏再试。"
          elseif 5000007 == code then
            show_msg = message
            title = "支付失败"
          end
          if 5000007 ~= code then
            show_msg = show_msg .. "{错误码:" .. tostring(code) .. "}"
          end
          E.Modal.open(title, {
            message = show_msg,
            buttons = {"确定"}
          })
        end
      end)
    else
      if "android" == os then
        hander_android_pay_timeout_callback(gp_order_id)
      end
      E.LOG.debug(TAG, "走旧的灵犀1.0支付SDK的流程")
      last_pay_product_id = product_id
      UNI.pay(UNISDK_CHANNEL, gp_order_id, pay_params)
      if "ios" == _ejoysdk.os() then
        ALIGAMES_HAS_UNFINISHED_PAY_ORDER:set(true)
      end
    end
  else
    local code = CONSTANTS.CHANNEL_ERROR_CODE.CHANNEL_PAYL_FAIL_ON_WINDOWS
    local ext_params = {
      code = code,
      msg = "请前往手机端支付。"
    }
    pay_listener(false, gp_order_id, ext_params)
    local tip_msg = ext_params.msg
    tip_msg = tip_msg .. "{错误码:" .. tostring(ext_params.code) .. "}"
    E.Modal.open("提示", {
      message = tip_msg,
      buttons = {"确定"}
    })
    ESTAT.create_order_report({
      biz_func = "sdk.create_ds_order",
      biz_act = "start",
      biz_st = "fail",
      biz_co = "400",
      biz_params = {
        product_id = product_id,
        gp_order_id = gp_order_id,
        code = code,
        msg = "CHANNEL PAY not suport on windows, please go mobile app to pay"
      }
    })
  end
end

function M.product_list()
  return product_infos
end

function M.exit()
  local os = _ejoysdk.os()
  if "android" == os or "harmonyos" == os or "windows" == os then
    local vendor, _ = get_login_vendor()
    if vendor and type(vendor.exit) == "function" then
      vendor.exit()
    else
      exit_listener(true)
    end
  else
    exit_listener(true)
  end
end

M.utdid = AIRLINE_V1.utdid
M.is_emulator = AIRLINE_V1.is_emulator
M.channel_id = AIRLINE_V1.channel_id
M.sub_channel_id = AIRLINE_V1.sub_channel_id
M.get_ft_version = AIRLINE_V1.get_ft_version
M.is_delete_msg_check = AIRLINE_V1.is_delete_msg_check
M.is_delete_app_update = AIRLINE_V1.is_delete_app_update
M.ali_auth = AIRLINE_V1.ali_auth
M.is_support_ali_auth = AIRLINE_V1.is_support_ali_auth
M.read_apk_channel_extra_info = AIRLINE_V1.read_apk_channel_extra_info

local function update_userinfo_handler(user_info)
  E.LOG.debug(TAG, "aligames auth_handler-----")
  E.LOG.debug(TAG, {
    aligames_userinfo = user_info or "nil"
  })
  if user_info and UNISDK_CHANNEL == user_info.with then
    account_user_info = user_info
  end
end

local function acquire_handler(user_info)
  E.LOG.debug(TAG, "aligames acquire_handler -----")
  if user_info and UNISDK_CHANNEL == user_info.with then
    update_userinfo_handler(user_info)
    if logining_vendor_name and string.len(logining_vendor_name) > 0 then
      AUTO_LOGIN.set_last_login(logining_vendor_name)
      logining_vendor_name = nil
    end
  end
end

local function logout_handler()
  E.LOG.debug(TAG, "aligames logout -----")
  account_user_info = {}
end

local try_jf_commit_event_ipv4_times = 0

local function try_jf_commit_event_ipv4()
  try_jf_commit_event_ipv4_times = try_jf_commit_event_ipv4_times + 1
  local query_ipv4_url = "https://meta-service.aligames.com/openapi/ipv4/query"
  local utdid = E.Sysinfo.utdid()
  local query_ipv4_params_req_id = utdid .. E.time()
  local query_ipv4_params_app_id = "hysdk"
  local query_ipv4_params_sign
  query_ipv4_params_sign = MD5.sumhexa(query_ipv4_params_req_id .. query_ipv4_params_app_id)
  local query_ipv4_params = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["x-req-id"] = query_ipv4_params_req_id,
      ["x-app-id"] = query_ipv4_params_app_id,
      ["x-req-src"] = "gmc",
      ["x-req-sign"] = query_ipv4_params_sign
    }
  }
  local query_ipv4_body = {deviceId = utdid}
  E.HTTP.post(query_ipv4_url, query_ipv4_params, E.HTTP.CT_JSON, query_ipv4_body, function(resp)
    local SDK_START_UP_IPV4 = "sdk.startup.ipv4"
    local JF = require("ejoysdk_lua.vendors.jf")
    if resp.status == 200 and resp.body and 200 == resp.body.state then
      local resp_ipv4 = resp.body.ipv4 or "nil"
      JF.commit_event(SDK_START_UP_IPV4, {
        success = true,
        requestId = query_ipv4_params_req_id,
        ipv4 = resp_ipv4
      }, {is_upload_now = true})
    else
      E.LOG.debug(TAG, {query_ipv4_url = query_ipv4_url, resp = resp})
      local query_ipv4_fail_state = ""
      local query_ipv4_fail_msg = ""
      if resp.body then
        query_ipv4_fail_state = resp.body.state or ""
        query_ipv4_fail_msg = resp.body.msg or ""
      end
      JF.commit_event(SDK_START_UP_IPV4, {
        success = false,
        requestId = query_ipv4_params_req_id,
        ipv4 = "",
        status = resp.status,
        state = query_ipv4_fail_state,
        msg = query_ipv4_fail_msg
      })
      if try_jf_commit_event_ipv4_times <= 3 then
        E.Timer.once(5, function()
          try_jf_commit_event_ipv4()
        end)
      end
    end
  end)
end

function M.init(opt, cb)
  pay_listener = opt.pay_listener
  logout_listener = opt.logout_listener
  exit_listener = opt.exit_listener
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.ACCOUNT.LOGIN, account_login_handler)
  UNI.register_pay_listener(UNISDK_CHANNEL, handle_pay_result)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe(ET.gangplank.USER_INFO_UPDATE, update_userinfo_handler)
  ET.subscribe(ET.gangplank.AUTH_SUCC, update_userinfo_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  AIRLINE_V1.init(opt, cb)
  local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
  setupPayControlSwitch()
  if need_go_pay_prewrite_way then
    ejoy_pay.setupInitPaySDK(opt)
  else
    local is_official_channel = tostring(E.get_channel()) == "998233" or false
    local is_contain_ejoypay = check_if_support_vendor("EJOYPAY")
    local can_switch_traffic = is_official_channel and is_contain_ejoypay
    if _ejoysdk.os() == "android" and can_switch_traffic then
      E.LOG.debug(TAG, "安卓官渠包，且接了支付预埋插件，需要调用支付初始化接口来获取微信app_id参数，但支付还保留原来的流程")
      ejoy_pay.setupInitPaySDK(opt)
    end
  end
  if get_login_vendor() == EV.get("AIRLINE_V2") then
    E.LOG.d(TAG, "use lingxi_v2")
    E.CONFIG.set_config(E.CONFIG.KEY.LINGXI_V2_SUPPORT, true)
  end
  if _ejoysdk.os() == "android" then
    local jym_token_trans_helper = require("ejoysdk_lua.protocol.jym_token_transmission_helper")
    jym_token_trans_helper.init()
  end
  try_jf_commit_event_ipv4()
end

function M.show_custom_service(params, cb, close_cb)
  local os = E.Sysinfo.os()
  if "weixin" == os then
    local WEIXIN = require("ejoysdk_lua.vendors.weixin")
    WEIXIN.show_custom_service(params, cb, close_cb)
    return
  end
  if "douyin" == os then
    local DOUYIN = require("ejoysdk_lua.vendors.douyin")
    DOUYIN.show_custom_service(params, cb, close_cb)
    return
  end
  M.custom_service(params, close_cb)
  if cb then
    cb(true)
  end
end

local function open_webview(url, screen_orientation, closeEventData, options)
  local params_ds_token = EG.user_info().ptoken
  local local_start_up_data = {
    pkg_info = E.get_pkg_info(),
    ds_token = params_ds_token,
    ejoysdk_ver = E.get_sdk_version_name("EJOYSDK")
  }
  E.LOG.debug(TAG, "open_webview:" .. (url or "nil") .. ", ds_token:" .. (params_ds_token or "nil"))
  local wv_options = {
    compactMode = true,
    closeEventData = closeEventData,
    screen_orientation = screen_orientation or options and options.orientation
  }
  if options then
    for wo_k, wo_v in pairs(options) do
      wv_options[wo_k] = wo_v
    end
  end
  E.WebView.open(url, {
    [".aligames.com"] = {startupData = local_start_up_data},
    [".lingxigames.com"] = {startupData = local_start_up_data},
    [".ejoy.com"] = {startupData = local_start_up_data},
    ["30.103.91.243"] = {startupData = local_start_up_data}
  }, wv_options)
end

function M.can_show_user_center()
  if ACF.is_lingxi_baipai() then
    _ejoysdk.log(TAG .. "can_show_user_center false, baipai not support show user_center")
    return false
  end
  local os = E.Sysinfo.os()
  if "android" == os then
    if E.is_scan_pkg() then
      return false
    end
    local pkg_info = E.get_pkg_info()
    return pkg_info.ds_channel_id == ACF.CONSTANTS.LX_CHANNEL_ID
  elseif "ios" == os then
    if E.is_scan_pkg() then
      return false
    end
    return true
  elseif "windows" == os then
    if is_windows_official_channel_id() then
      return true
    end
    return false
  elseif "harmonyos" == os then
    local pkg_info = E.get_pkg_info()
    return pkg_info.ds_channel_id == ACF.CONSTANTS.LX_CHANNEL_ID
  else
    return false
  end
end

function M.async_can_show_user_center(cb)
  if cb then
    cb(M.can_show_user_center())
  end
end

function M.set_lx_guest_bind_state()
  local os = E.Sysinfo.os()
  if "android" == os then
    local bind_store = E.SPKeyStore:New("cn.uc.gamesdk.pref", "cn.uc.gamesdk.guestBindInfo")
    local value = {
      type = 3,
      account = EG.user_info().account
    }
    bind_store:set(JSON.encode(value))
  elseif "ios" == os then
    local bind_store = E.SPKeyStore:New("cn.uc.gamesdk.pref", "G9SDKAccountGuestBindInfoKey")
    bind_store:set("G9SDKAccountGuestBindHasPhone")
  end
end

local function listen_webview_event(close_event_data, close_cb)
  local function webview_js_callback(_value)
    local args = _value.args
    
    if args.type == "logout" or args.type == "bind_succ" then
      E.LOG.debug(TAG, "webview_js_callback receive logout event! do logout")
      M.set_lx_guest_bind_state()
      EG.logout()
    end
  end
  
  local function webview_close_callback(_value)
    E.LOG.debug(TAG, "listen_webview_close_event, receive close event")
    if _value and _value.args == close_event_data then
      E.LOG.debug(TAG, "listen_webview_close_event, event>>" .. tostring(_value.args))
      if close_cb then
        close_cb()
      end
      ET.unsubscribe("webview_close", webview_close_callback)
      ET.unsubscribe("webview_jsargs", webview_js_callback)
    end
  end
  
  ET.subscribe("webview_close", webview_close_callback)
  ET.subscribe("webview_jsargs", webview_js_callback)
end

function M.show_user_center(screen_orientation, options, close_cb)
  if M.can_show_user_center() then
    local pkg_info = E.get_pkg_info()
    local brand = pkg_info.airline
    if UTILS.STR.is_empty(brand) then
      E.LOG.debug(TAG, "开始访问灵犀用户中心页面")
      open_webview("https://account-lingxi.aligames.com/m/#/linxi", screen_orientation, CLOSE_EVENT_DATA_USER_CENTER, options)
      listen_webview_event(CLOSE_EVENT_DATA_USER_CENTER, close_cb)
    else
      AIRLINE_V2.show_user_center(nil, nil, close_cb)
    end
  else
    E.LOG.error(TAG, "此时不能打开用户中心，可能是非官渠包，或者是扫码包之类的，鸿蒙包如果是华为渠道账号登录也不能打开用户中心，必须官渠登录才可以")
    if close_cb then
      close_cb()
    end
  end
end

M.open_user_center = M.show_user_center

function M.show_bbs(screen_orientation, path, options)
  E.LOG.debug(TAG, "开始访问论坛页面")
  
  local function open_bbs_webview(url)
    if path then
      E.LOG.debug(TAG, "show bbs with path:" .. path)
      url = UTILS.STR.append_url_path(url, path)
    else
      E.LOG.debug(TAG, "show bbs without path")
    end
    E.LOG.debug(TAG, "show_bbs, open_bbs_webview url:" .. (url or "nil"))
    url = url .. "#client=" .. E.Sysinfo.os()
    open_webview(url, screen_orientation, CLOSE_EVENT_DATA_BBS, options)
    listen_webview_event(CLOSE_EVENT_DATA_BBS)
  end
  
  if not bbs_url then
    local product_id = E.CONFIG.get_config("product")
    local bbs_get_url_service = "/api/get_bbs_url"
    local bbs_api_url = "https://" .. product_id .. "-bbs.ejoy.com" .. bbs_get_url_service
    local new_bbs_platform = false
    if E.CONFIG.is_force_use_rule_service_splice_in_path("bbs") then
      bbs_api_url = "https://" .. product_id .. "-platform.ejoy.com/bbs" .. bbs_get_url_service
      new_bbs_platform = true
    end
    E.HTTP.get(bbs_api_url, {
      acceptable = E.HTTP.CT_JSON
    }, function(resp)
      E.LOG.debug(TAG, "show_bbs, get bbs url resp>>")
      local default_bbs_url = "https://" .. product_id .. "-bbs.ejoy.com"
      if new_bbs_platform then
        default_bbs_url = "https://" .. product_id .. "-platform.ejoy.com/bbs"
      end
      local url = default_bbs_url
      if resp.body and 0 == resp.body.code and resp.body.bbs_url and resp.body.bbs_url ~= "" then
        url = resp.body.bbs_url
        bbs_url = url
        E.LOG.debug(TAG, "show_bbs, get bbs url success, url:" .. tostring(bbs_url))
      elseif resp.body and resp.body.code then
        E.LOG.error(TAG, "show_bbs, get bbs url failed, code:" .. tostring(resp.body.code) .. ", msg:" .. (resp.body.message or "nil"))
      else
        E.LOG.error(TAG, "show_bbs, get bbs url failed, response body return nil")
      end
      open_bbs_webview(url)
    end)
  else
    E.LOG.debug(TAG, "show_bbs, has cached bbs_url:" .. tostring(bbs_url))
    open_bbs_webview(bbs_url)
  end
end

function M.show_url(url, screen_orientation, close_event_data)
  if not url or "" == url then
    E.LOG.warn(TAG, "show_url url is empty!")
  end
  E.LOG.debug(TAG, "开始访问自定义页面, url:" .. url)
  local my_close_event_data = close_event_data or CLOSE_EVENT_DATA_CUSTOM
  open_webview(url, screen_orientation, my_close_event_data)
  listen_webview_event(my_close_event_data)
end

function M.custom_service(params, close_cb)
  local cs_url = "https://general.aligames.com/lx_customer_relay_page"
  local use_ds
  local CC = require("ejoysdk_lua.ejoysdk_config_center")
  local custom_service_config = CC.get_config(CC.NAMESPACE.USERCENTER_CN)
  if custom_service_config and custom_service_config.config then
    local customer_service_infos = custom_service_config.config.customer_service
    if customer_service_infos then
      cs_url = customer_service_infos.url or cs_url
      use_ds = customer_service_infos.use_ds or false
    end
  end
  if cs_url and not use_ds then
    params = params or {}
    local orientation = params.orientation
    for k, v in pairs(params) do
      if type(k) == "string" and (type(v) == "string" or type(v) == "number" or type(v) == "boolean") then
        cs_url = E.Utils.url_append_params(cs_url, k, tostring(v))
      end
    end
    open_webview(cs_url, orientation, CLOSE_EVENT_DATA_CUSTOMER_SERVICE)
    listen_webview_event(CLOSE_EVENT_DATA_CUSTOMER_SERVICE, close_cb)
  else
    if close_cb then
      close_cb()
    end
    if E.Sysinfo.os() == "windows" then
      E.LOG.warn(TAG, "windows is not support custom_service")
      return
    end
    UNI.cast(UNISDK_CHANNEL, CAST_CUSTOM_SERVICE, params or {})
  end
end

function M.is_for_lingxi()
  do return end
  return ACF.is_for_lingxi, nil
end

function M.get_lingxi_brand()
  local lx_brand = ACF.get_lingxi_brand()
  E.LOG.debug(TAG, "get_lingxi_brand:" .. tostring(lx_brand))
  return lx_brand
end

function M.intercept_after_account_login(account_result, cb)
  local login_vendor = get_login_vendor()
  if login_vendor and type(login_vendor.intercept_after_account_login) == "function" then
    login_vendor.intercept_after_account_login(account_result, cb)
  else
    cb(true)
  end
end

local go_channel_sdk_callback

function M.common_call(call_type, params, cb)
  UNI.cast(UNISDK_CHANNEL, CAST_ALIGAMES_COMMON_CALL, {
    event = 30001,
    data = {call_type = call_type, params = params}
  })
  if cb then
    go_channel_sdk_callback = cb
  end
end

function M.on_gochannel_callback(data, cb)
  if go_channel_sdk_callback then
    go_channel_sdk_callback(data)
    cb(true)
    return
  end
  cb(false)
end

function M.get_ext_channel_info()
  return ext_channel_info
end

M:is_implemented({
  "ACCOUNT",
  "PAY",
  "CUSTOM_SERVICE"
})
return M
