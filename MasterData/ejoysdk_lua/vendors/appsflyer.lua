local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local OVERSEA_APPLOG = require("ejoysdk_lua.vendors.oversea_applog")
local CHANNEL = "APPSFLYER"
local TAG = EM.MODULE.VENDORS.APPSFLYER
local M = Vendor:Inherit(CHANNEL)
local CAST_INIT_APPSFLYER = "CAST_INIT_APPSFLYER"
local CAST_UPDATE_UID = "CAST_UPDATE_UID"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local ASYNC_GEN_INVITE_LINK = "ASYNC_GEN_INVITE_LINK"
local is_inited = false
M.enable_ldu = false

function M.commit_event(event_name, params)
  if M.enable_ldu == true then
    E.LOG.debug(TAG, "appsflyer commit_event disabled with LDU setting")
    return
  end
  local event_params = {event_name = event_name, params = params}
  UNI.cast(CHANNEL, CAST_COMMIT_EVENT, event_params)
end

local function init_appsflyer_sdk()
  local init_param = {
    debuggable = false,
    collect_imei = false,
    currency_code = "USD",
    appsflyer_disable = false,
    enable_ldu = OVERSEA_APPLOG.has_enabled_ldu() == true or false,
    collect_device_name = false
  }
  UNI.cast(CHANNEL, CAST_INIT_APPSFLYER, init_param)
  local ejoy_referrer = E.Sysinfo.get_ejoy_referer() or "none"
  E.LOG.debug(TAG, "try commit instant event >> " .. tostring(ejoy_referrer))
  local params = {referrer = ejoy_referrer}
  M.commit_event("install_referrer", params)
end

local function update_uid(userId)
  local params = {uid = userId}
  UNI.cast(CHANNEL, CAST_UPDATE_UID, params)
end

local function login_handler(user_info)
  local params = {
    uid = user_info.uid,
    pid = user_info.pid,
    account_id = user_info.uid
  }
  M.commit_event("af_login", params)
  update_uid(user_info.uid)
end

local function gangplank_logout_handler()
  update_uid("")
end

local function gangplank_exit_handler()
  update_uid("")
end

function M.init(opt, cb)
  if is_inited then
    cb(true)
    return
  end
  is_inited = true
  E.LOG.debug(TAG, "AppsFlyer start init")
  init_appsflyer_sdk()
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  ET.subscribe(ET.analytics.REGISTER, function(user_info)
    M.commit_event("af_complete_registration", {
      account_id = user_info.uid
    })
  end)
  ET.subscribe(ET.analytics.PURCHASE_SUCC, function(order_id, product_info)
    local params = {af_order_id = order_id}
    local player_info = EG.player_info()
    params.role_id = player_info.player_id
    params.role_name = player_info.player_name
    params.server_id = player_info.server_id
    params.server_name = player_info.server_name
    local user_info = EG.user_info()
    params.account_id = user_info.uid
    if product_info then
      if product_info.product_id then
        params.af_content_id = product_info.product_id
      end
      if product_info.show_money then
        params.af_revenue = product_info.show_money
      end
      if product_info.money_type then
        params.af_currency = product_info.money_type
      end
    end
    M.commit_event("af_purchase", params)
  end)
  OVERSEA_APPLOG.register_applog_events(CHANNEL, M)
  cb(true)
end

M.INVITE_LINK = {
  onlink_id = "onelink_id",
  channel = "channel",
  refer_name = "referrer_name",
  refer_uid = "referrer_uid",
  refer_image_url = "referrer_image_url",
  campaign = "campaign",
  custom_params = "custom_params"
}

function M.gen_invite_link(params, cb)
  local function callback(succ, ...)
    if succ then
      local body = (...)
      
      cb(true, body.url)
    else
      cb(false)
    end
  end
  
  UNI.async_call(CHANNEL, ASYNC_GEN_INVITE_LINK, params, nil, callback)
end

M:is_implemented({
  Vendor.ABILITY.STATS
})
return M
