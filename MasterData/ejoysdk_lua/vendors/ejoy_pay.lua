local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EM = require("ejoysdk_lua.ejoysdk_module")
local PAYPROTOCOL = require("ejoysdk_lua.pay.protocol.paycenter_protocol")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EC = require("ejoysdk_lua.ejoysdk_config")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ejoypayH5 = require("ejoysdk_lua.pay.ejoy_pay_h5")
local ejoypayIOS = require("ejoysdk_lua.pay.ejoy_pay_ios")
local ejoypayHARMONYOS = require("ejoysdk_lua.pay.ejoy_pay_harmonyos")
local ejoypayWEIXIN = require("ejoysdk_lua.pay.ejoy_pay_weixin")
local ejoypayDOUYIN = require("ejoysdk_lua.pay.ejoy_pay_douyin")
local VENDOR_NAME = "EJOYPAY"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.EJOY_PAY
local CAST_REQUEST_PRODUCTS = "CAST_REQUEST_PRODUCTS"
local ejoy_pay_inited = false
local pay_inited = false
local products_request_times = 0
local pay_init_request_times = 0
local pay_init_data

function M.launch_alipay(order_id, payInfo, cb)
  ejoypayH5.launch_alipay(order_id, payInfo, cb)
end

function M.is_support_weixin_app_pay()
  do return end
  return ejoypayH5.is_support_weixin_app_pay, nil
end

function M.launch_wx_pay(order_id, payReq, cb)
  ejoypayH5.launch_wx_pay(order_id, payReq, cb)
end

function M.get_wx_appid()
  do return end
  return ejoypayH5.get_wx_appid, nil
end

function M.get_store_front_data()
  do return end
  return ejoypayIOS.get_store_front_data, nil
end

function M.has_unfinished_transaction()
  do return end
  return ejoypayIOS.has_unfinished_transaction, nil
end

function M.show_loading_ios()
  ejoypayIOS.show_loading_ios()
end

function M.hide_loading_ios()
  ejoypayIOS.hide_loading_ios()
end

function M.pay(gp_order_id, ds_order_id, product, attach_info_str)
  local player_info = GDP.PLAYER_INFO.clone()
  player_info.player_token = nil
  local money_yuan = tostring(tonumber(product.money) / 100.0)
  money_yuan = string.format("%.2f", money_yuan)
  local pay_params = {
    gpOrderId = gp_order_id,
    cpOrderId = ds_order_id,
    order_id = ds_order_id,
    app_env_id = E.CONFIG.get_config("product"):upper(),
    prd_id = product.product_id,
    order_amt = money_yuan,
    currency = product.money_type or "CNY",
    prd_name = product.product_desc,
    player_info = player_info,
    attach_info = attach_info_str,
    amount = tostring(product.money),
    showMoney = product.show_money or money_yuan,
    moneyType = product.money_type,
    payProductID = product.product_id,
    payProductName = product.product_desc,
    payProductDescribe = product.product_desc,
    payProductType = tostring(product.product_type or 1)
  }
  if product.min_order_amt then
    pay_params.min_order_amt = tostring(product.min_order_amt)
  end
  if _ejoysdk.os() == "android" or _ejoysdk.os() == "windows" then
    local is_wegame = EC.has_vendor_config("WEGAME")
    local is_wxminicloudgame = EC.has_vendor_config("WXMINICLOUDGAME")
    local is_dyminicloudgame = EC.has_vendor_config("DYMINICLOUDGAME")
    if is_wegame then
      ESTAT.app_pay_report({
        biz_func = "sdk.show_wegame_pay",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
      })
      local WG = require("ejoysdk_lua.vendors.wegame")
      WG.pay(gp_order_id, ds_order_id, product, pay_params)
    elseif is_wxminicloudgame then
      ESTAT.app_pay_report({
        biz_func = "sdk.show_wxminicloudgame_pay",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
      })
    elseif is_dyminicloudgame then
      ESTAT.app_pay_report({
        biz_func = "sdk.show_dyminicloudgame_pay",
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
      })
      local DYCLOUD = require("ejoysdk_lua.vendors.dyminicloudgame")
      DYCLOUD.pay(gp_order_id, ds_order_id, product, pay_params)
    else
      ESTAT.h5_pay_report({
        biz_act = "start",
        biz_st = "succ",
        biz_co = "200",
        biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
      })
      local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
      if is_oversea then
        local ext_info = {}
        if attach_info_str then
          ext_info = JSON.decode(attach_info_str)
        end
        pay_params = {
          gpOrderId = gp_order_id,
          cpOrderId = ds_order_id,
          currency = ext_info.currency,
          moneyType = ext_info.currency,
          order_amt = ext_info.order_amt,
          showMoney = product.show_money,
          amount = ext_info.order_amt,
          payProductID = product.product_id,
          payProductName = product.product_desc,
          min_order_amt = product.min_order_amt and tostring(product.min_order_amt) or nil
        }
        E.LOG.debug(TAG, {h5_pay_params = pay_params})
      end
      ejoypayH5.pay(gp_order_id, ds_order_id, product, pay_params)
    end
  elseif _ejoysdk.os() == "ios" then
    ESTAT.app_pay_report({
      biz_func = "sdk.show_apple_pay",
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
    })
    ejoypayIOS.pay(gp_order_id, ds_order_id, product, pay_params)
  elseif _ejoysdk.os() == "harmonyos" then
    ESTAT.app_pay_report({
      biz_func = "sdk.show_harmony_pay",
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
    })
    ejoypayHARMONYOS.pay(gp_order_id, ds_order_id, product, pay_params)
  elseif _ejoysdk.os() == "weixin" then
    ESTAT.app_pay_report({
      biz_func = "sdk.show_weixin_pay",
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
    })
    ejoypayWEIXIN.pay(gp_order_id, ds_order_id, product, pay_params)
  elseif _ejoysdk.os() == "douyin" then
    ESTAT.app_pay_report({
      biz_func = "sdk.show_douyin_pay",
      biz_act = "start",
      biz_st = "succ",
      biz_co = "200",
      biz_params = {gp_order_id = gp_order_id, ds_order_id = ds_order_id}
    })
    ejoypayDOUYIN.pay(gp_order_id, ds_order_id, product, pay_params)
  else
    E.LOG.error(TAG, "this os has no ejoypay vendor, something wrong, please check it!")
  end
end

local function check_products()
  if products_request_times > 5 then
    E.LOG.error(TAG, "重试次数超过5次，说明获取不到商品列表信息，不再进行重试")
    ESTAT.app_pay_report({
      biz_func = "sdk.check_products",
      biz_act = "finish",
      biz_st = "fail",
      biz_co = "400",
      biz_params = {
        msg = "重试次数超过5次，说明获取不到商品列表信息，不再进行重试",
        products_request_times = products_request_times
      }
    })
    return
  end
  local ADMIN_CHANNEL_NAME = "ALIGAMES"
  local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if is_oversea then
    ADMIN_CHANNEL_NAME = "OFFICIAL"
  end
  ESTAT.app_pay_report({
    biz_func = "sdk.check_products",
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200",
    biz_params = {ADMIN_CHANNEL_NAME = ADMIN_CHANNEL_NAME, products_request_times = products_request_times}
  })
  EG.product_infos_base(ADMIN_CHANNEL_NAME, function(succ, infos)
    ESTAT.app_pay_report({
      biz_func = "sdk.check_products",
      biz_act = "finish",
      biz_st = succ and "succ" or "fail",
      biz_co = succ and "200" or "400",
      biz_params = {
        ADMIN_CHANNEL_NAME = ADMIN_CHANNEL_NAME,
        products_request_times = products_request_times,
        infos = infos
      }
    })
    products_request_times = products_request_times + 1
    if succ then
      E.LOG.debug(TAG, "获取 ejoy_pay product info success >>")
      E.LOG.debug(TAG, infos)
      local suit_product_ids = infos
      if _ejoysdk.os() == "ios" then
        local CG = require("ejoysdk_lua.cloud_game.cloud_config")
        local pkgInfo = E.get_pkg_info()
        if pkgInfo.cloud_game_mode and pkgInfo.cloud_game_mode == CG.CLOUD_MODE.MOBILE then
          E.LOG.debug(TAG, "ios云微端才需要拼接这个后缀")
          suit_product_ids = {}
          for product_id_key, product_info in pairs(infos) do
            local cloud_product_id = product_id_key .. ".cloud_ejoy"
            product_info.product_id = cloud_product_id
            suit_product_ids[cloud_product_id] = product_info
          end
          E.LOG.debug(TAG, {suit_product_ids = suit_product_ids})
        end
      end
      UNI.cast(VENDOR_NAME, CAST_REQUEST_PRODUCTS, suit_product_ids)
      ET.publish("purchase_inited", VENDOR_NAME)
      pay_inited = true
    else
      local status = infos
      E.LOG.error(TAG, "获取 ejoy_pay product info failure: " .. tostring(status))
      if not UTILS.STR.is_empty(EG.user_info().ptoken) then
        E.LOG.debug(TAG, "it's login state, and need recheck products")
        E.Timer.once(products_request_times, check_products)
      else
        E.LOG.debug(TAG, "check_products logout state, not need check products")
      end
    end
  end)
end

local function request_pay_init(user_info)
  ESTAT.pay_init_report({
    biz_act = "start",
    biz_st = "succ",
    biz_co = "200"
  })
  if pay_init_request_times > 5 then
    E.LOG.error(TAG, "重试次数超过5次都没成功，说明支付初始化接口挂了，不再进行重试")
    ESTAT.pay_init_report({
      biz_act = "finish",
      biz_st = "fail",
      biz_co = "400",
      biz_params = {
        msg = "支付初始化接口重试次数超过最大限制",
        pay_init_request_times = pay_init_request_times
      }
    })
    return
  end
  local publish_platform = "Official"
  if _ejoysdk.os() == "ios" then
    publish_platform = "Apple"
  elseif _ejoysdk.os() == "harmonyos" then
    publish_platform = "HarmonyPay"
  else
    local sdk_infos = UNI.get_sdk_infos()
    for sdk_name, sdk_info in pairs(sdk_infos) do
      if sdk_name and sdk_name:upper() == "OFFICIALPAY" then
        local info = sdk_info or {}
        local meta_data = info.meta or {}
        publish_platform = meta_data.publish_platform or ""
        break
      end
    end
    if "H5_OVERSEAS_PAY" == publish_platform or "WIN_OVERSEAS_PAY" == publish_platform then
      publish_platform = "Official"
    end
  end
  local pay_params = {}
  pay_params.publish_platform = publish_platform
  pay_params.st = user_info.st
  if not pay_params.st then
    pay_params.st = user_info and user_info.ext and user_info.ext.channel_info and user_info.ext.channel_info.serviceTicket
  end
  E.LOG.debug(TAG, "request pay_init, params = ")
  E.LOG.debug(TAG, pay_params)
  PAYPROTOCOL.post(PAYPROTOCOL.SERVICE.PAY_SDK_INIT, pay_params, function(succ, ...)
    pay_init_request_times = pay_init_request_times + 1
    if succ then
      ESTAT.pay_init_report({
        biz_act = "finish",
        biz_st = "succ",
        biz_co = "200"
      })
      local data = (...)
      E.LOG.debug(TAG, "支付SDK初始化成功")
      E.LOG.debug(TAG, {response_data = data})
      pay_init_data = data
      ejoypayH5.setPayInitData(data)
      if data and data.api_url then
        PAYPROTOCOL.set_pay_url_base(data.api_url)
      end
      if data and type(data.wx_app_id) == "string" and data.wx_app_id ~= "" then
        E.LOG.debug(TAG, "初始化 wx_app_id >> " .. tostring(data.wx_app_id))
        ejoypayH5.set_wx_appid(data.wx_app_id)
      end
    else
      local code, msg = ...
      E.LOG.error(TAG, "支付SDK初始化失败, code = " .. tostring(code) .. ", msg = " .. tostring(msg))
      E.Timer.once(pay_init_request_times, function()
        request_pay_init(user_info)
      end)
      ESTAT.pay_init_report({
        biz_act = "finish",
        biz_st = "fail",
        biz_co = "400",
        biz_params = {
          code = tostring(code),
          msg = msg,
          pay_init_request_times = pay_init_request_times,
          http_request_params = pay_params,
          http_resp_body = {
            ...
          }
        }
      })
    end
  end)
end

local function acquire_handler(user_info)
  if pay_inited then
    return
  end
  E.LOG.debug(TAG, "acquire_handler ---called")
  E.LOG.debug(TAG, "开始获取 ejoy_pay product info")
  products_request_times = 0
  check_products()
  pay_init_request_times = 0
  request_pay_init(user_info)
end

function M.getPayInitData()
  return pay_init_data
end

local global_use_ejoy_pay

function M.official_should_use_ejoypay(stat_params)
  E.LOG.debug(TAG, "读取official_should_use_ejoypay函数获取灰度开关的值")
  if nil ~= global_use_ejoy_pay then
    E.LOG.debug(TAG, "之前已经调用official_should_use_ejoypay读取过值了，直接返回旧的值就好")
    E.LOG.debug(TAG, {global_use_ejoy_pay = global_use_ejoy_pay})
    return global_use_ejoy_pay
  end
  E.LOG.debug(TAG, "第一次调用official_should_use_ejoypay，需要去读取轻舟配置下发参数里的值")
  global_use_ejoy_pay = false
  local temp_brand
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local gangplank_config = EGC.get_current_cdn_config()
  if gangplank_config and gangplank_config.ext and gangplank_config.ext.airline_info and gangplank_config.ext.airline_info.brand then
    temp_brand = gangplank_config.ext.airline_info.brand
  end
  if temp_brand and "altplus" == temp_brand then
    E.LOG.debug(TAG, "当前是新品牌altplus的游戏，直接走新H5收银台的支付流程，不再读取灰度下发参数。[不区分端的OS系统]")
    global_use_ejoy_pay = true
    if stat_params then
      stat_params.gangplank_config = gangplank_config
    end
  else
    E.LOG.debug(TAG, "当前旧品牌的游戏，读取灰度下发参数决定走新旧哪个收银台")
    local ecc = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = ecc.get_config(ecc.NAMESPACE.EJOYSDK_BIZ)
    if biz_config and biz_config.config and biz_config.config.pay_config then
      local pay_config = biz_config.config.pay_config
      global_use_ejoy_pay = pay_config.use_ejoy_pay or false
      E.LOG.debug(TAG, {pay_config = pay_config})
    end
  end
  E.LOG.debug(TAG, {global_use_ejoy_pay = global_use_ejoy_pay})
  return global_use_ejoy_pay
end

function M.get_notify_url()
  local notify_url
  local is_oversea = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if is_oversea then
    local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
    notify_url = EGC.get_current_cdn_config().payment_center .. "/cs/" .. E.get_channel()
    E.LOG.debug(TAG, "notify_url first = " .. tostring(notify_url))
    notify_url = E.HTTP.url_query(notify_url, {
      cbUrl = EG.gangplank_url("/notify/official")
    })
    E.LOG.debug(TAG, "notify_url final = " .. tostring(notify_url))
  end
  return notify_url
end

function M.setupInitPaySDK(opt)
  if ejoy_pay_inited then
    return
  end
  E.LOG.debug(TAG, "init ejoy pay vendor")
  ejoy_pay_inited = true
  if _ejoysdk.os() == "harmonyos" then
    ejoypayHARMONYOS.setupInitPaySDK(opt)
  elseif _ejoysdk.os() == "ios" then
    ejoypayIOS.setupInitPaySDK(opt)
  elseif _ejoysdk.os() == "weixin" then
    ejoypayWEIXIN.setupInitPaySDK(opt)
  elseif _ejoysdk.os() == "douyin" then
    ejoypayDOUYIN.setupInitPaySDK(opt)
  else
    local is_wegame = EC.has_vendor_config("WEGAME")
    if is_wegame then
      local WG = require("ejoysdk_lua.vendors.wegame")
      WG.setupInitPaySDK(opt)
    else
      ejoypayH5.setupInitPaySDK(opt)
    end
  end
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_handler)
  ET.subscribe("APP_LIFE_CIRCLE_EVENT", function(value)
    E.LOG.debug(TAG, "APP_LIFE_CIRCLE_EVENT -----callback")
    E.LOG.debug(TAG, value)
    if _ejoysdk.os() == "ios" then
      E.LOG.debug(TAG, "ios life circle event")
    elseif _ejoysdk.os() == "android" then
      E.LOG.debug(TAG, "android life circle event")
    end
  end)
end

return M
