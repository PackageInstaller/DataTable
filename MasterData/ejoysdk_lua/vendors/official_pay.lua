local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local HTTP = E.HTTP
local util = require("ejoysdk_lua.ejoysdk_utils")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local V = require("ejoysdk_lua.version")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
local UP = require("ejoysdk_lua.user_center.usercenter_protocol")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local ejoy_pay = require("ejoysdk_lua.vendors.ejoy_pay")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local ATracer = require("ejoysdk_lua.account.account_tracer")
local LANG = require("ejoysdk_lua.lang.util")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local CHANNEL = "OFFICIALPAY"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.OFFICIAL_PAY
local CAST_PLAYER_LOGIN = "CAST_PLAYER_LOGIN"
local CAST_USER_LOGOUT = "CAST_USER_LOGOUT"
local CAST_REQUEST_PRODUCTS = "CAST_REQUEST_PRODUCTS"
local SYNC_IS_DELETE_GPS_PAY_ORDER = "SYNC_IS_DELETE_GPS_PAY_ORDER"
local ASYNC_GET_GOOGLE_BILLING_CONFIG = "ASYNC_GET_GOOGLE_BILLING_CONFIG"
local pay_listener
local pay_inited = false
local product_infos = {}
local platform_pay_vendor, global_publish_platform, global_google_account_area, official_pay_span
local OFFICIALPAY_HAS_UNFINISHED_PAY_ORDER = E.LazyKeyStore:New("OFFICIALPAY_HAS_UNFINISHED_PAY_ORDER_V1", false, true, false)
local need_go_pay_prewrite_way = false
local EJOY_GAME_LAST_OFFICIAL_PAY_SWITCH = E.LazyKeyStore:New("EJOY_GAME_LAST_OFFICIAL_PAY_SWITCH_V1", false, true, false)
local last_player_id = ""

local function official_purchase_inited(vendor_name, ...)
  if "OFFICIAL" == vendor_name then
    pay_inited = true
    product_infos = (...)
    UNI.cast(CHANNEL, CAST_REQUEST_PRODUCTS, product_infos)
    ESTAT.pay_init_report({
      biz_act = "finish",
      biz_st = "succ",
      biz_co = "200"
    })
  else
    ESTAT.pay_init_report({
      biz_act = "finish",
      biz_st = "fail",
      biz_co = "400"
    })
  end
end

local function setupPayControlSwitch()
  E.LOG.debug(TAG, "setupPayControlSwitch ----- called")
  local EC = require("ejoysdk_lua.ejoysdk_config")
  local is_contain_ejoypay = EC.has_vendor_config("EJOYPAY")
  local officialpay_version = E.get_sdk_version_name(CHANNEL)
  local is_not_contain_officialpay = UTILS.STR.is_empty(officialpay_version)
  E.LOG.debug(TAG, {officialpay_version = officialpay_version, is_not_contain_officialpay = is_not_contain_officialpay})
  local stat_params = {}
  if _ejoysdk.os() == "ios" and is_contain_ejoypay then
    E.LOG.debug(TAG, "ios当前包体有接了ejoypay新支付插件，固定让其走新支付流程")
    need_go_pay_prewrite_way = true
  elseif _ejoysdk.os() == "android" or _ejoysdk.os() == "windows" or _ejoysdk.os() == "harmonyos" then
    E.LOG.debug(TAG, "鸿蒙、安卓包或者是windows包，当前可以直接切流到新支付收银台，此lua发布时，仁辉应该灰度完成了")
    need_go_pay_prewrite_way = true
  end
  EJOY_GAME_LAST_OFFICIAL_PAY_SWITCH:set(need_go_pay_prewrite_way)
  stat_params.need_go_pay_prewrite_way = need_go_pay_prewrite_way
  stat_params.channel_id = E.get_channel()
  stat_params.is_contain_ejoypay = is_contain_ejoypay
  stat_params.is_not_contain_officialpay = is_not_contain_officialpay
  ESTAT.stat_action("officialpay_switch_choose", "", false, stat_params)
end

local function logout_handler()
  last_player_id = nil
  UNI.cast(CHANNEL, CAST_USER_LOGOUT, {}, nil)
end

local function get_pay_notify_url(_vendor_name)
  local pay_channel_id = E.get_channel()
  return EGC.get_current_cdn_config().payment_center .. "/cs/" .. pay_channel_id
end

local function refreshGooglePlayPayAreaAsync()
  if "GooglePlay" == global_publish_platform then
    UNI.async_call(CHANNEL, ASYNC_GET_GOOGLE_BILLING_CONFIG, {}, nil, function(succ, ...)
      E.LOG.debug(TAG, "ASYNC_GET_GOOGLE_BILLING_CONFIG ---end, succ = " .. tostring(succ))
      local body = (...)
      E.LOG.debug(TAG, {body = body})
      local code = 0
      if succ then
        global_google_account_area = body and body.countryCode
      else
        code = body
      end
      ESTAT.stat_action("officialpay_get_google_country_code", tostring(code), succ, {
        ...
      })
    end)
  end
end

function M.getGoogleAccountPayArea()
  return global_google_account_area
end

local function set_player_info_handler(player_info, type)
  UNI.set_player_info(CHANNEL, player_info, type)
  local current_player_id = ""
  if player_info and player_info.player_id then
    current_player_id = player_info.player_id
  end
  E.LOG.debug(TAG, "new role info received, last player_id:" .. (last_player_id or "") .. ", now player_id:" .. tostring(current_player_id))
  if "" ~= current_player_id and last_player_id ~= current_player_id then
    last_player_id = current_player_id
    E.LOG.debug(TAG, "new role info received, init pay now")
    local gangplank_config = EGC.get_current_cdn_config()
    local pay_api_url
    if _ejoysdk.os() == "android" then
      pay_api_url = gangplank_config.paysdk_api_url_a
    elseif _ejoysdk.os() == "ios" then
      pay_api_url = gangplank_config.paysdk_api_url_i
    end
    local param = {
      player_info = player_info,
      user_id = EG.user_info().uid,
      language = E.CONFIG.get_config("lang"),
      country_id = E.CONFIG.get_config("district"),
      pay_game_id = E.get_game_id(),
      product_id = E.CONFIG.get_config("product"),
      paysdk_api_url = pay_api_url,
      paysdk_log_url = gangplank_config.paysdk_log_url,
      paysdk_locale = gangplank_config.paysdk_locale,
      sign_secret_key = PAYPROTOCOL.get_secret_key(),
      sign_secret_key_version = PAYPROTOCOL.get_secure_version_id()
    }
    param.notify_url = HTTP.url_query(get_pay_notify_url(CHANNEL), {
      cbUrl = EG.gangplank_url("/notify/official")
    })
    E.LOG.debug(TAG, "set_player_info_handler")
    E.LOG.debug(TAG, {param = param})
    if _ejoysdk.os() == "ios" and need_go_pay_prewrite_way then
      E.LOG.debug(TAG, "this is ios system, and need_go_pay_prewrite_way is true, no need to init officialpay old paysdk.")
    else
      E.LOG.debug(TAG, "go to init officialpay paysdk.")
      UNI.cast(CHANNEL, CAST_PLAYER_LOGIN, param, nil)
    end
  else
    E.LOG.debug(TAG, "new role info received, player_id not change and return")
  end
  refreshGooglePlayPayAreaAsync()
end

local function global_errcode_handler(_vendor_name, err_code)
  E.LOG.debug(TAG, "global_errcode_handler, errCode:" .. (err_code or "nil"))
  if err_code == USER.USER_CENTER_ERROR_CODES.ERR_TOKEN_EXPIRED or err_code == USER.USER_CENTER_ERROR_CODES.ERR_TOKEN_INVALID then
    E.LOG.warn(TAG, "global_errcode_handler err_code:" .. tostring(err_code) .. ", token is invalid or expired, now need logout")
    EG.logout()
    return true
  end
  return false
end

local function open_pay_limitation_page(body_data, cb)
  local result = {}
  local OFFICIAL = require("ejoysdk_lua.vendors.official")
  local path = "#/real-name/jp"
  local ejoypayH5 = require("ejoysdk_lua.pay.ejoy_pay_h5")
  local pay_init_data = ejoypayH5.getPayInitData()
  local full_url, h5_domain
  if pay_init_data and pay_init_data.cashier_url then
    E.LOG.debug(TAG, "支付初始化有返回cashier_url，直接使用")
    h5_domain = pay_init_data.cashier_url
  else
    local gangplank_config = EGC.get_current_cdn_config()
    if gangplank_config and gangplank_config.render_center and gangplank_config.render_center.payment and gangplank_config.render_center.payment ~= "" then
      h5_domain = gangplank_config.render_center.payment
    end
  end
  full_url = E.HTTP.uri_join(h5_domain, path)
  E.LOG.debug(TAG, "full_url = " .. tostring(full_url))
  local is_done = false
  OFFICIAL.open_webview_with_url(full_url, function(_args)
    E.LOG.debug(TAG, {_args = _args})
    if cb and _args.type == "account_pay_update_age_info" then
      result = _args.params or {}
      is_done = true
      if result.area and result.birthday then
        E.LOG.debug(TAG, "get the age info, now to close age H5 page")
        E.WebView.close()
        if cb then
          cb(result)
        end
      else
        E.LOG.error(TAG, "年龄信息输入有误!!!!")
      end
    end
  end, function()
    if not is_done and cb then
      cb(result)
    end
  end, body_data)
end

local function open_pay_limitation_err_page(cb)
  local OFFICIAL = require("ejoysdk_lua.vendors.official")
  local path = "#/tips/recharge-jp"
  local ejoypayH5 = require("ejoysdk_lua.pay.ejoy_pay_h5")
  local pay_init_data = ejoypayH5.getPayInitData()
  local full_url, h5_domain
  if pay_init_data and pay_init_data.cashier_url then
    E.LOG.debug(TAG, "支付初始化有返回cashier_url，直接使用")
    h5_domain = pay_init_data.cashier_url
  else
    local gangplank_config = EGC.get_current_cdn_config()
    if gangplank_config and gangplank_config.render_center and gangplank_config.render_center.payment and gangplank_config.render_center.payment ~= "" then
      h5_domain = gangplank_config.render_center.payment
    end
  end
  full_url = E.HTTP.uri_join(h5_domain, path)
  E.LOG.debug(TAG, "full_url = " .. tostring(full_url))
  OFFICIAL.open_webview_with_url(full_url, nil, function()
    if cb then
      cb()
    end
  end)
end

local function update_pay_limitation(pay_limit_age_cb, rules, cb)
  local function update_age(input_info)
    if not (input_info and input_info.area) or not input_info.birthday then
      cb(false, 5004001, "年龄输入错误")
      
      return
    end
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    local OFFICIAL = require("ejoysdk_lua.vendors.official")
    local url = OFFICIAL.get_account_center_api_url("recharge_limit_update_user_info")
    url = url .. "?ver=1.0&df=json&gt=ng&cver=1.0.0" .. "&os=" .. E.Sysinfo.os()
    local user_info = gangplank.user_info()
    local user_center_info = USER.user_info()
    local params = {
      opType = 3,
      gameId = E.get_pkg_info().game_id or "",
      token = user_info.ptoken or "",
      ejoyId = user_center_info.ejoyId or "",
      openId = user_center_info.openId or "",
      receiveEjoyEmailType = 2,
      area = input_info.area or "",
      birthday = input_info.birthday or ""
    }
    UP.post_to(url, "", params, cb)
  end
  
  if pay_limit_age_cb then
    pay_limit_age_cb(rules, update_age)
  else
    open_pay_limitation_page(rules, update_age)
  end
end

local function get_request_id()
  local random_mills = math.random(1, 1000)
  local sys_clock = os.time() * 1000
  local random_time_in_mills = sys_clock + random_mills
  E.LOG.debug(TAG, "get_request_id :" .. tostring(random_time_in_mills) .. ", sys_clock:" .. tostring(sys_clock) .. ", random_mills:" .. tostring(random_mills))
  return random_time_in_mills
end

local function create_official_order(order_id, channel_id, params, cb, override)
  local gangplank_config = EGC.get_current_cdn_config()
  local payment_center_url = gangplank_config.payment_center .. "/client/pay.order.create" .. "?ver=1.0&df=json&gt=ng&cver=1.0.0" .. "&os=" .. E.Sysinfo.os()
  E.LOG.debug(TAG, "payment_center_url: " .. tostring(payment_center_url))
  E.LOG.debug(TAG, "账号支付下单create official order, order id: " .. tostring(order_id) .. ", >>")
  E.LOG.debug(TAG, params)
  local last_login_vendor = EG.get_last_login()
  local order_info = UTILS.deepcopy(params.cb)
  order_info.area = E.CONFIG.get_config("district")
  order_info.gameRegion = gangplank_config.region
  order_info.token = EG.user_info().ptoken
  order_info.orderSrc = E.Sysinfo.os()
  order_info.thirdPartyType = (EG.user_info() or {}).platform or ""
  local post_params = {
    id = get_request_id(),
    client = {
      ve = V.LUA_VERSION,
      gameId = E.get_pkg_info().game_id,
      os = E.Sysinfo.os(),
      channelId = channel_id,
      si = "si",
      pkgInfo = E.get_pkg_info()
    },
    data = order_info
  }
  E.LOG.debug(TAG, "log official post params >>")
  E.LOG.debug(TAG, post_params)
  
  local function fail_cb(resp, common_cb)
    local state = resp.body.state
    local ERR_CODE_NEED_AGE = 5004001
    local ERR_CODE_PAY_LIMITATION = 5004002
    local rule = {}
    if (state.code == ERR_CODE_NEED_AGE or state.code == ERR_CODE_PAY_LIMITATION) and resp.body.data then
      rule = resp.body.data
      state.msg = JSON.encode(rule)
    end
    if state.code == ERR_CODE_NEED_AGE then
      update_pay_limitation(override.pay_limit_age_cb, rule, function(succ, ...)
        if succ then
          create_official_order(order_id, channel_id, params, cb, override)
        else
          common_cb()
          local code, msg = ...
          E.LOG.debug(TAG, "failed to update user info, code: " .. tostring(code) .. ",msg=" .. tostring(msg))
        end
      end)
    elseif state.code == ERR_CODE_PAY_LIMITATION and not override.pay_limit_custom_err then
      open_pay_limitation_err_page(common_cb)
    else
      common_cb()
    end
  end
  
  E.LOG.debug(TAG, "create official order")
  E.HTTP.post(payment_center_url, {
    trace = true,
    acceptable = HTTP.CT_JSON
  }, HTTP.CT_JSON, post_params, function(resp)
    E.LOG.debug(TAG, "账号支付下单结果create_official_order finish, resp =")
    E.LOG.debug(TAG, resp)
    if resp.status == 200 then
      local state = resp.body.state
      local stateCode = state and state.code
      if 2000000 == stateCode then
        cb(true, resp.body.data)
      else
        fail_cb(resp, function()
          cb(false, stateCode, state.msg)
          global_errcode_handler(last_login_vendor, stateCode)
        end)
      end
    else
      cb(false, resp.status, "")
    end
  end)
end

local function get_pay_type_from_publish_platform(publish_platform)
  local pay_type
  if "GooglePlay" == publish_platform then
    pay_type = "201"
  elseif "HMS" == publish_platform then
    pay_type = "231"
  elseif "Samsung" == publish_platform then
    pay_type = "230"
  elseif "OneStoreV19" == publish_platform then
    pay_type = "913"
  elseif "OneStoreV16" == publish_platform then
    pay_type = "233"
  else
    E.LOG.error(TAG, "publish_platform is error, please check your sdkconfig.json officialpay content!!!")
  end
  E.LOG.d(TAG, "publish_platform = " .. tostring(publish_platform) .. ", pay_type = " .. tostring(pay_type))
  return pay_type
end

local function vendor_pay_function(product_id, count, gp_order_id, ds_order_id, ext_info, local_params)
  local attach_info_str = ext_info
  if ext_info and type(ext_info) == "table" then
    attach_info_str = JSON.encode(ext_info)
  end
  if _ejoysdk.os() == "windows" and "STEAM" == global_publish_platform or _ejoysdk.os() == "android" and "GooglePlay" == global_publish_platform then
    local pay_init_data = ejoy_pay.getPayInitData()
    if pay_init_data and pay_init_data.payment_method == "official" then
      E.LOG.debug(TAG, "now is gps server choose to use official H5 pay")
      E.LOG.debug(TAG, {global_publish_platform = global_publish_platform})
      ejoy_pay.pay(gp_order_id, ds_order_id, local_params.product_info, attach_info_str)
      return
    end
  end
  if platform_pay_vendor and platform_pay_vendor.pay then
    ESTAT.h5_pay_report({
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {
        product_id = product_id,
        gp_order_id = gp_order_id,
        ds_order_id = ds_order_id
      }
    })
    platform_pay_vendor.pay(product_id, gp_order_id, ds_order_id, attach_info_str, local_params)
  else
    local function origin_pay_function(gps_order_id, pay_mode)
      local pay_params = {product_id = product_id, count = count}
      
      pay_params.ext_info = util.deepcopy(ext_info) or {}
      pay_params.ext_info.gps_order_id = gps_order_id
      pay_params.ext_info.pay_mode = pay_mode
      E.LOG.debug(TAG, "走officialpay支付sdk的支付流程")
      E.LOG.debug(TAG, "origin_pay_function called, pay_params = ")
      E.LOG.debug(TAG, pay_params)
      ESTAT.app_pay_report({
        biz_func = "sdk.app_pay_result",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {
          product_id = product_id,
          gp_order_id = gp_order_id,
          ds_order_id = ds_order_id
        }
      })
      UNI.pay(CHANNEL, ds_order_id, pay_params)
    end
    
    local is_official_delete_preorder = false
    local ret = UNI.sync_call(CHANNEL, SYNC_IS_DELETE_GPS_PAY_ORDER, {})
    if ret and ret.value and "OneStoreV16" ~= global_publish_platform then
      is_official_delete_preorder = true
    end
    E.LOG.debug(TAG, {SYNC_IS_DELETE_GPS_PAY_ORDER = ret})
    E.LOG.debug(TAG, "global_publish_platform = " .. tostring(global_publish_platform))
    if _ejoysdk.os() == "ios" and need_go_pay_prewrite_way then
      E.LOG.debug(TAG, "海外iOS包根据轻舟下发参数开关走新的支付插件 ejoypay 了")
      ejoy_pay.pay(gp_order_id, ds_order_id, local_params.product_info, attach_info_str)
    elseif _ejoysdk.os() == "android" and is_official_delete_preorder then
      local player_info = GDP.PLAYER_INFO.clone()
      player_info.player_token = nil
      local product = local_params.product_info
      local pay_params = {
        cpOrderId = ds_order_id,
        payProductID = product.product_id,
        payProductName = product.product_desc,
        currency = ext_info.currency,
        order_amt = ext_info.order_amt,
        player_info = player_info,
        pay_type = get_pay_type_from_publish_platform(global_publish_platform),
        attach_info = attach_info_str,
        notify_url = HTTP.url_query(get_pay_notify_url(CHANNEL), {
          cbUrl = EG.gangplank_url("/notify/official")
        })
      }
      if product.min_order_amt then
        pay_params.min_order_amt = tostring(product.min_order_amt)
      end
      ESTAT.app_pay_report({
        biz_func = "show_app_pay",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {
          product_id = product_id,
          gp_order_id = gp_order_id,
          ds_order_id = ds_order_id
        }
      })
      E.LOG.debug(TAG, "安卓渠道包，在lua下第三张单，支付预下单")
      local gps_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.ACCOUNT_PAY)
      PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_PRE_CREATE_ORDER, pay_params, function(succ, ...)
        ATracer.finish_pay_sub_span(gps_pay_span, {
          ...
        })
        local temp_data = (...)
        ESTAT.app_pay_report({
          biz_func = "show_app_pay",
          biz_act = "finish",
          biz_st = succ and "succ" or "fail",
          biz_co = succ and "200" or "400",
          biz_params = {
            product_id = product_id,
            gp_order_id = gp_order_id,
            ds_order_id = ds_order_id,
            trade_id = succ and temp_data and temp_data.trade_id or nil
          }
        })
        if succ then
          local data = (...)
          E.LOG.debug(TAG, "第三张单支付预下单创单成功")
          E.LOG.debug(TAG, {data = data})
          local trade_id = data.trade_id
          origin_pay_function(trade_id, data.pay_mode)
        else
          local code, msg = ...
          E.LOG.debug(TAG, "支付预下单失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
          local resp = {
            code = code,
            msg = msg,
            ext = {
              pay_part = "gps_order",
              product_id = tostring(product_id)
            }
          }
          pay_listener(false, gp_order_id, resp)
          local tip_msg = LANG.getStringSuitCNOverseas("pay_common_tips", "")
          tip_msg = tip_msg .. "{code:" .. tostring(code) .. "}"
          E.LOG.debug(TAG, {
            tip_msg = tip_msg,
            code = code,
            msg = msg
          })
          E.Modal.open(LANG.getStringSuitCNOverseas("tips", ""), {
            message = tip_msg,
            buttons = {
              LANG.getStringSuitCNOverseas("confirm", "")
            }
          })
        end
      end)
    else
      origin_pay_function()
      if _ejoysdk.os() == "ios" then
        OFFICIALPAY_HAS_UNFINISHED_PAY_ORDER:set(true)
      end
    end
  end
end

function M.pay(product_id, count, gp_order_id, ext_info, override)
  E.LOG.debug(TAG, "pay function called")
  official_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.OFFICIAL_PAY)
  ESTAT.place_order_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {gp_order_id = gp_order_id, product_id = product_id}
  })
  if M.skip_official_order() then
    vendor_pay_function(product_id, count, gp_order_id, nil, ext_info)
  else
    local account_pay_span = ATracer.start_pay_sub_span(ATracer.PAY_FLOWS_SPANS.ACCOUNT_PAY)
    ESTAT.create_order_report({
      biz_func = "sdk.create_ds_order",
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {gp_order_id = gp_order_id, product_id = product_id}
    })
    create_official_order(gp_order_id, E.get_channel(), ext_info, function(succ, ...)
      ATracer.finish_pay_sub_span(account_pay_span, {
        ...
      })
      local temp_data = (...)
      ESTAT.create_order_report({
        biz_func = "sdk.create_ds_order",
        biz_act = "finish",
        biz_st = succ and "succ" or "fail",
        biz_co = succ and "200" or "400",
        biz_params = {
          product_id = product_id,
          gp_order_id = gp_order_id,
          ds_order_id = succ and temp_data and temp_data.accountOrderId or nil
        }
      })
      if succ then
        local data = (...)
        data.channelEx = data.channelEx or {}
        local product = product_infos[product_id]
        product.min_order_amt = data.minOrderAmount
        local local_params = {gp_order_id = gp_order_id, product_info = product}
        vendor_pay_function(product_id, count, gp_order_id, data.accountOrderId, data.channelEx, local_params)
      else
        local code, msg = ...
        local resp = {
          code = code,
          msg = msg or "default error message[account_order]",
          platform = CHANNEL,
          ext = {
            pay_part = "account_order",
            product_id = tostring(product_id)
          }
        }
        pay_listener(false, gp_order_id, resp)
        if 5004002 ~= code then
          local tip_msg = LANG.getStringSuitCNOverseas("pay_common_tips", "")
          tip_msg = tip_msg .. "{code" .. tostring(code) .. "}"
          E.LOG.debug(TAG, {
            tip_msg = tip_msg,
            code = code,
            msg = msg
          })
          E.Modal.open(LANG.getStringSuitCNOverseas("tips", ""), {
            message = tip_msg,
            buttons = {
              LANG.getStringSuitCNOverseas("confirm", "")
            }
          })
        end
      end
    end, override)
  end
end

function M.can_pay()
  return pay_inited
end

function M.product_list()
  return product_infos
end

function M.vendor_channel()
  return "OFFICIAL"
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "======= OFFICIALPAY INIT ==========")
  pay_listener = opt.pay_listener
  ET.subscribe("purchase_inited", official_purchase_inited)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, logout_handler)
  UNI.register_pay_listener(CHANNEL, function(succ, _order_id, ext_params)
    E.LOG.debug(TAG, "pay_listener_callback, succ=" .. tostring(succ) .. ", order_id = " .. tostring(_order_id))
    E.LOG.debug(TAG, {ext_params = ext_params})
    if _ejoysdk.os() == "android" and ext_params and ext_params.msg and type(ext_params.msg) == "string" then
      local error_msg = ext_params.msg
      local temp_msg = string.gsub(error_msg, "Pay Unsuccess,errorMsg=", "")
      temp_msg = string.gsub(temp_msg, "null", "")
      ext_params.msg = temp_msg
      E.LOG.debug(TAG, {after_ext_params = ext_params})
    end
    ESTAT.app_pay_report({
      biz_func = "sdk.app_pay_result",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {order_id = _order_id, ext_params = ext_params}
    })
    if official_pay_span then
      ATracer.finish_pay_sub_span(official_pay_span, {
        succ = succ,
        order_id = _order_id,
        ext_params = ext_params
      })
      official_pay_span = nil
    end
    pay_listener(succ, _order_id, ext_params)
    if _ejoysdk.os() == "ios" and succ then
      OFFICIALPAY_HAS_UNFINISHED_PAY_ORDER:set(false)
    end
  end)
  local sdk_infos = UNI.get_sdk_infos()
  for sdk_name, sdk_info in pairs(sdk_infos) do
    if sdk_name and sdk_name:lower() == CHANNEL:lower() then
      local info = sdk_info or {}
      local meta_data = info.meta or {}
      local publish_platform = meta_data.publish_platform or ""
      global_publish_platform = publish_platform
      platform_pay_vendor = EV.get(publish_platform)
      break
    end
  end
  if platform_pay_vendor then
    E.LOG.debug(TAG, {
      platform_pay_vendor = tostring(platform_pay_vendor)
    })
    platform_pay_vendor.init(opt)
  else
    E.LOG.debug(TAG, "platform_pay_vendor is nil")
    E.LOG.debug(TAG, {global_publish_platform = global_publish_platform})
  end
  if _ejoysdk.os() == "windows" and "STEAM" == global_publish_platform or _ejoysdk.os() == "android" and "GooglePlay" == global_publish_platform then
    E.LOG.debug(TAG, "ready to init ejoy_pay, make it request gps pay init api")
    E.LOG.debug(TAG, {global_publish_platform = global_publish_platform})
    ejoy_pay.setupInitPaySDK(opt)
  end
  setupPayControlSwitch()
  ESTAT.pay_init_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_chain_ver = need_go_pay_prewrite_way and "1" or "0"
  })
  if need_go_pay_prewrite_way then
    ejoy_pay.setupInitPaySDK(opt)
  end
  cb(true)
end

function M.skip_official_order()
  if platform_pay_vendor and platform_pay_vendor.skip_official_order then
    do return end
    return platform_pay_vendor.skip_official_order, nil
  end
  return false
end

function M.skip_gp_order()
  if platform_pay_vendor and platform_pay_vendor.skip_gp_order then
    do return end
    return platform_pay_vendor.skip_gp_order, nil
  end
  return false
end

M:is_implemented({"PAY"})
return M
