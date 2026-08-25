local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local JF = require("ejoysdk_lua.vendors.jf")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EI = require("ejoysdk_lua.ejoysdk_init")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local util = require("ejoysdk_lua.ejoysdk_utils")
local LDU_SETTING = E.LazyKeyStore:New("EJOY_LDU_SETTING", false, false, false)
local CHAT
local M = {}
M.APPLOG_EVENT = {
  SDK_INSTALL = "ej_sdk_install",
  SDK_STARTUP = "ej_sdk_startup",
  SDK_STARTUP_SUCC = "ej_sdk_startup_succ",
  SDK_REGISTER = "ej_register",
  SDK_LOGIN = "ej_login",
  SDK_PURCHASE = "ej_purchase",
  SDK_CREATE_ROLE = "ej_role_create"
}
local TAG = "oversea_applog"
local DEFAULT_COMMIT_VENDORS = {"FIREBASE", "APPSFLYER"}
local MEDIA_NAME_ALL = "_media_name_all_"
local OFFICIALPAY_VENDOR_NAME = "OFFICIALPAY"
local PURCHASE_NOTIFY_BY_SERVER = "NOTIFY_BY_SERVER"
local PURCHASE_NOTIFY_BY_SDK = "NOTIFY_BY_SDK"
local aggregate_vendors = {}
local is_init = false
local all_media_inited = false
local cache_event_data_for_media = {}

local function dup_commit_params(params)
  local succ, dup_params = pcall(util.deepcopy, params)
  if not succ then
    E.LOG.warn(TAG, "commit_event dup params failed, msg:" .. tostring(dup_params))
    dup_params = params
  end
  return dup_params
end

local function flatten_params(params, keep_origin_key, prefix, result)
  result = result or {}
  prefix = prefix or ""
  keep_origin_key = keep_origin_key or false
  for k, v in pairs(params) do
    local key = prefix .. tostring(k)
    if type(v) == "table" then
      if keep_origin_key then
        flatten_params(v, keep_origin_key, key .. ".", result)
      else
        flatten_params(v, keep_origin_key, prefix, result)
      end
    elseif result[key] then
      result["origin_" .. key] = result[key]
    else
      result[key] = v
    end
  end
  return result
end

local function convert_purchase_params(media, params)
  local convert_purchase_keys
  if "APPSFLYER" == media then
    convert_purchase_keys = {
      money_type = "af_currency",
      product_price = "af_revenue"
    }
  else
    convert_purchase_keys = {money_type = "currency", product_price = "value"}
  end
  for origin_key, target_key in pairs(convert_purchase_keys) do
    if params[target_key] then
      params["origin_" .. target_key] = params[target_key]
    end
    params[target_key] = params[origin_key]
  end
  return params
end

local function commit_event_to_media(media, event_name, params, opts)
  local vendor = aggregate_vendors[media]
  local dup_params
  if vendor then
    dup_params = dup_commit_params(params)
    if "FIREBASE" == media or "FB" == media or "APPSFLYER" == media then
      E.LOG.debug(TAG, "commit_event_to_media original media: " .. tostring(media) .. ", event_name: " .. tostring(event_name) .. ", params: ")
      E.log(dup_params)
      dup_params = flatten_params(dup_params, false)
      E.LOG.debug(TAG, "commit_event_to_media after flatten media: " .. tostring(media) .. ", event_name: " .. tostring(event_name) .. ", params: ")
      E.log(dup_params)
      if event_name == M.APPLOG_EVENT.SDK_PURCHASE then
        dup_params = convert_purchase_params(media, dup_params)
        E.LOG.debug(TAG, "commit_event_to_media ej_purchase media: " .. tostring(media) .. ", event_name: " .. tostring(event_name) .. ", params: ")
        E.log(dup_params)
      end
    end
    vendor.commit_event(event_name, dup_params)
    return true
  elseif "JF" == media then
    if E.Utils.start_with(event_name, "client.") or E.Utils.start_with(event_name, "game.") or E.Utils.start_with(event_name, "sdk.") then
      JF.commit_event(event_name, params, opts)
    else
      dup_params = dup_commit_params(params)
      opts = opts or {}
      dup_params = dup_params or {}
      dup_params.action = event_name
      JF.commit_event("sdk.analytics.3rd", dup_params, opts)
    end
    return true
  else
    return false
  end
end

local function cache_media_event(media, event_name, params, opts)
  cache_event_data_for_media[media] = cache_event_data_for_media[media] or {}
  table.insert(cache_event_data_for_media[media], {
    _event_name = event_name,
    _params = params,
    _opts = opts
  })
end

local function flush_cached_media_events()
  for media, events in pairs(cache_event_data_for_media) do
    for _, event_obj in ipairs(events) do
      commit_event_to_media(media, event_obj._event_name, event_obj._params, event_obj._opts)
    end
  end
  cache_event_data_for_media = {}
end

local function on_new_media_registered_before_initted(new_media)
  E.LOG.debug(TAG, "on_media_ready, try commit cached events for media:" .. tostring(new_media))
  E.log(cache_event_data_for_media)
  local media_events = cache_event_data_for_media[new_media]
  if media_events then
    for _, event_obj in ipairs(media_events) do
      commit_event_to_media(new_media, event_obj._event_name, event_obj._params, event_obj._opts)
    end
  else
    media_events = cache_event_data_for_media[MEDIA_NAME_ALL] or {}
    for _, event_obj in ipairs(media_events) do
      E.LOG.debug(TAG, "on_media_ready, use media all event, media:" .. tostring(new_media) .. ", event_name:" .. tostring(event_obj._event_name))
      commit_event_to_media(new_media, event_obj._event_name, event_obj._params, event_obj._opts)
    end
  end
  cache_event_data_for_media[new_media] = nil
end

local function fill_sdk_params(params)
  if not params then
    return
  end
  params.ej_utdid = E.Sysinfo.utdid()
  params.ej_ptid = E.get_ptid()
  E.LOG.debug(TAG, "fill_sdk_params, utdid:" .. tostring(params.ej_utdid) .. ", ptid:" .. tostring(params.ej_ptid))
end

function M.commit_event(event_name, params, opt)
  opt = opt or {}
  params = params or {}
  fill_sdk_params(params)
  local commit_media_set = {}
  if opt.include_all_medias then
    for vn, _ in pairs(aggregate_vendors) do
      commit_media_set[vn] = true
    end
    commit_media_set[JF.VENDOR_NAME] = true
    if not all_media_inited then
      cache_media_event(MEDIA_NAME_ALL, event_name, params, opt)
    end
  end
  local cms = opt.medias or DEFAULT_COMMIT_VENDORS
  for _, media in ipairs(cms) do
    commit_media_set[media] = true
  end
  local commit_medias = {}
  for vn, _ in pairs(commit_media_set) do
    table.insert(commit_medias, vn)
  end
  E.LOG.debug(TAG, "commit_medias >>")
  E.log(commit_medias)
  for _, media in ipairs(commit_medias) do
    local handled = commit_event_to_media(media, event_name, params, opt)
    if not handled then
      if not all_media_inited then
        cache_media_event(media, event_name, params, opt)
      else
        E.LOG.warn(TAG, "vendor not registered, skip commit event:" .. tostring(media))
      end
    end
  end
end

function M.commit_event_to_all_medias(event_name, params, _opts)
  _opts = _opts or {}
  _opts.include_all_medias = true
  M.commit_event(event_name, params, _opts)
end

local function upload_event_to_all_medias(event_name, params, _opts)
  _opts = _opts or {}
  _opts.is_upload_now = true
  M.commit_event_to_all_medias(event_name, params, _opts)
end

function M.register_applog_events(vendor_name, vendor)
  if not vendor:is_support_ability({
    Vendor.ABILITY.STATS
  }) then
    E.LOG.warn(TAG, "register_applog_events warnning, vendor does not has stats ability")
    return
  end
  E.LOG.debug(TAG, "register_applog_events, vendor_name:" .. tostring(vendor_name))
  aggregate_vendors[vendor_name] = vendor
  if next(aggregate_vendors) ~= nil and not is_init then
    M.init()
  end
end

local function gangplank_inited_handler(succ, ...)
  if all_media_inited then
    E.LOG.debug(TAG, "gangplank_inited_handler all_media already initted")
    return
  end
  E.LOG.debug(TAG, "oversesa_applog gangplank_inited_handler! " .. tostring(succ))
  if succ then
    all_media_inited = true
    flush_cached_media_events()
    upload_event_to_all_medias(M.APPLOG_EVENT.SDK_STARTUP_SUCC)
    if E.is_override_install_startup() then
      E.LOG.debug(TAG, "is install time startup, stat install event")
      upload_event_to_all_medias(M.APPLOG_EVENT.SDK_INSTALL)
    end
  end
end

local function parse_purchase_succ_msg(msg)
  if msg.reader_status ~= nil and 0 ~= msg.reader_status then
    return nil
  end
  local order_id, product_info
  local data = msg.content and msg.content.data or {}
  order_id = data.order_uuid
  product_info = data.product_info
  return order_id, product_info
end

local function check_purchase_succ_msg(msg)
  local order_id, product_info = parse_purchase_succ_msg(msg)
  if order_id then
    upload_event_to_all_medias(M.APPLOG_EVENT.SDK_PURCHASE, {order_id = order_id, product_info = product_info})
    local session_id = msg.session_id
    local ts = msg.ts
    CHAT.set_msg_received_with_ts(session_id, ts, function(succ)
      E.LOG.debug(TAG, "设置付费聊天消息已收，结果: " .. tostring(succ))
    end)
  end
end

local function chat_on_login_observer()
  local player_info = EG.player_info()
  if not player_info or not player_info.player_id then
    return
  end
  local session_id = "system_gangplank:" .. tostring(player_info.player_id)
  local opt = {max_msg_count = 20}
  E.LOG.debug(TAG, "登录后，获取历史聊天付费成功消息")
  CHAT.get_msg(session_id, opt, function(succ, ...)
    if succ then
      local msgs = (...)
      E.LOG.debug(TAG, "登录后，获取历史聊天付费成功消息，成功：" .. tostring(#msgs))
      for i = #msgs, 1, -1 do
        local msg = msgs[i]
        check_purchase_succ_msg(msg)
      end
    end
  end)
end

local function chat_gangplank_msg_observer(msgs)
  for _, msg in ipairs(msgs) do
    check_purchase_succ_msg(msg)
  end
end

local function sdk_purchase_succ_handler(order_id, product_info)
  E.LOG.debug(TAG, "sdk_purchase_succ_handler received:" .. tostring(order_id))
  upload_event_to_all_medias(M.APPLOG_EVENT.SDK_PURCHASE, {order_id = order_id, product_info = product_info})
end

function M.subscribe_server_purchase_msg()
  ET.subscribe("chat_on_login", chat_on_login_observer)
  ET.subscribe("chat_info_gangplank_msg", chat_gangplank_msg_observer)
end

local function init_jf(debuggable)
  E.LOG.debug(TAG, "init_jf entered")
  local jf = require("ejoysdk_lua.vendors.jf")
  jf.init({debug = debuggable}, function()
    E.LOG.debug(TAG, "jf init succ")
  end)
end

function M.init()
  if is_init then
    E.LOG.warn(TAG, "init skip, already inited")
    return
  end
  init_jf()
  E.LOG.debug(TAG, "init begin")
  local _media_metatable = {
    __newindex = function(self, vendor_name, _vendor)
      E.LOG.debug(TAG, "new media registered, vendor_name:" .. tostring(vendor_name))
      rawset(self, vendor_name, _vendor)
      if not all_media_inited then
        E.LOG.warn(TAG, "vendor register before gangplank already inited")
        on_new_media_registered_before_initted(vendor_name)
        return
      end
    end
  }
  aggregate_vendors = setmetatable(aggregate_vendors, _media_metatable)
  upload_event_to_all_medias(M.APPLOG_EVENT.SDK_STARTUP)
  ET.subscribe(EI.SUBSCRIBE_GANGPLANK_INITED, gangplank_inited_handler)
  ET.subscribe(ET.analytics.REGISTER, function(_user_info)
    local is_guest_result = EG.is_magic_guest()
    upload_event_to_all_medias(M.APPLOG_EVENT.SDK_REGISTER, {
      uid = _user_info.uid,
      is_guest = is_guest_result
    })
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    local is_guest_result = EG.is_magic_guest()
    upload_event_to_all_medias(M.APPLOG_EVENT.SDK_LOGIN, {
      uid = user_info.uid,
      is_guest = is_guest_result
    })
  end)
  local sdk_infos = UNI.get_sdk_infos()
  local vendor_info = sdk_infos[OFFICIALPAY_VENDOR_NAME]
  local purchase_notify_mode = PURCHASE_NOTIFY_BY_SDK
  if vendor_info and vendor_info.meta and vendor_info.meta.purchase_notify_mode then
    purchase_notify_mode = vendor_info.meta.purchase_notify_mode
  end
  E.LOG.debug(TAG, "init purchase_notify_mode:" .. tostring(purchase_notify_mode))
  if purchase_notify_mode == PURCHASE_NOTIFY_BY_SERVER then
    CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
    M.subscribe_server_purchase_msg()
  else
    ET.subscribe(ET.analytics.PURCHASE_SUCC, sdk_purchase_succ_handler)
  end
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, function(player_info, type)
    if "createRole" == type then
      E.LOG.debug(TAG, "receive createRole event")
      upload_event_to_all_medias(M.APPLOG_EVENT.SDK_CREATE_ROLE, {
        roleId = player_info.player_id,
        roleName = player_info.player_name,
        roleLevel = player_info.level,
        zoneId = player_info.server_id,
        zoneName = player_info.server_name,
        opportunityType = type
      })
    end
  end)
  is_init = true
end

function M.test_reset_state()
  all_media_inited = false
  is_init = false
  ET.unsubscribe("chat_on_login", chat_on_login_observer)
  ET.unsubscribe("chat_info_gangplank_msg", chat_gangplank_msg_observer)
  ET.unsubscribe(ET.analytics.PURCHASE_SUCC, sdk_purchase_succ_handler)
end

function M.set_limit_data_usage(enable)
  local CAST_SET_LIMIT_DATA_USAGE = "CAST_SET_LDU"
  enable = true == enable
  LDU_SETTING:set(tostring(enable))
  E.LOG.debug(TAG, "set LDU:" .. tostring(enable))
  for vendor_name, vendor in pairs(aggregate_vendors) do
    vendor.enable_ldu = enable
    UNI.cast(vendor_name, CAST_SET_LIMIT_DATA_USAGE, {enable_ldu = enable})
  end
end

function M.has_enabled_ldu()
  return LDU_SETTING:get() == "true" or false
end

return M
