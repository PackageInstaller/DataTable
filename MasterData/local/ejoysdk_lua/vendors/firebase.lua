local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PUSH = require("ejoysdk_lua.push.ejoysdk_push")
local EM = require("ejoysdk_lua.ejoysdk_module")
local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
local OVERSEA_APPLOG = require("ejoysdk_lua.vendors.oversea_applog")
local EC = require("ejoysdk_lua.ejoysdk_config")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local xpcall = compat.xpcall
local TAG = EM.MODULE.VENDORS.FIRE_BASE
local CHANNEL = "FIREBASE"
local native_vendor = CHANNEL
local UNI = require("ejoysdk_lua.vendors.unisdk")
local HTTP = E.HTTP
local push_event = require("ejoysdk_lua.push.ejoysdk_push_event")
local ASYNC_GET_TOKEN = "ASYNC_GET_TOKEN"
local ASYNC_SUBSCRIBE_TOPIC = "ASYNC_SUBSCRIBE_TOPIC"
local ASYNC_UNSUBSCRIBE_TOPIC = "ASYNC_UNSUBSCRIBE_TOPIC"
local ASYNC_GET_INSTANCE_ID = "ASYNC_GET_INSTANCE_ID"
local SYNC_GET_SENDER_ID = "SYNC_GET_SENDER_ID"
local CAST_INIT = "CAST_INIT"
local CAST_LUA_INIT_FINISH = "CAST_LUA_INIT_FINISH"
local CAST_COMMIT_EVENT = "CAST_COMMIT_EVENT"
local CAST_COMMIT_EMAIL_INFO = "CAST_COMMIT_EMAIL_INFO"
local CAST_COMMIT_PHONE_INFO = "CAST_COMMIT_PHONE_INFO"
local EVT_ON_SERVER_NOTIFICATION = "EVT_ON_SERVER_NOTIFICATION"
local EVT_ON_SERVER_NOTIFICATION_OPEN = "EVT_ON_SERVER_NOTIFICATION_OPEN"
local EVT_ON_SERVER_NOTIFICATION_RECEIVED_INAPP = "EVT_ON_SERVER_NOTIFICATION_RECEIVED_INAPP"
local KEY_ACCOUNT_ID = "account_id"
local KEY_PLAYER_ID = "player_id"
local KEY_ACCOUNT_REGION = "account_region"
local KEY_ACCOUNT_PUBLISH_AREA = "account_publish_area"
local KEY_PLAYER_REGION = "player_region"
local KEY_PLAYER_PUBLISH_AREA = "player_publish_area"
local KEY_ACCOUNT_LANG = "account_lang"
local KEY_PLAYER_LANG = "player_lang"
local KEY_SERVER_TOPIC = "server_topic"
local KEY_LANG_TOPIC = "lang_topic"
local KEY_REGION_TOPIC = "region_topic"
local CONFIG_KEY_LANG = "lang"
local CONFIG_KEY_REGION = "region"
local CONFIG_KEY_PUBLISH_AREA = "publish_area"
local FIREBASE_LAST_PLAYER_INFO = E.LazyKeyStore:New("FIREBASE_LAST_PLAYER_INFO", false, true, false)
local FIREBASE_TOPIC_STORE = E.LazyKeyStore:New("FIREBASE_TOPIC_STORE", false, true, false)
local FIREBASE_LAST_SDK_VERSION = E.LazyKeyStore:New("FIREBASE_LAST_SDK_VERSION", false, false, false)
local FIREBASE_LAST_PLATFORM = E.LazyKeyStore:New("FIREBASE_LAST_PLATFORM", false, false, false)
local url_items = {
  check_tags = "/api/check_tags"
}
local TYPE_LEN_LIMIT = 40
local TYPE_TAG_LIMIT = 80
local FIREBASE_ERROR_CORE = {
  FIREBASE_BIND_SUC = 74003001,
  FIREBASE_ERROR_PARAMS = 74003002,
  FIREBASE_BIND_FAIL = 74003003
}
local is_inited = false

local function get_store_value(key)
  local store_value = FIREBASE_LAST_PLAYER_INFO:get() or {}
  return store_value[key]
end

local function set_store_value(key, value)
  local info = FIREBASE_LAST_PLAYER_INFO:get() or {}
  info[key] = value
  FIREBASE_LAST_PLAYER_INFO:set(info)
end

local function get_value_from_topic_store(key)
  local store_value = FIREBASE_TOPIC_STORE:get() or {}
  return store_value[key]
end

local function set_value_to_topic_store(key, value)
  local info = FIREBASE_TOPIC_STORE:get() or {}
  info[key] = value
  FIREBASE_TOPIC_STORE:set(info)
end

local M = Vendor:Inherit(CHANNEL)
M.EVENT_KEY = {
  EVENT_EARN_VIRTUAL_CURRENCY = "earn_virtual_currency",
  EVENT_JOIN_GROUP = "join_group",
  EVENT_LEVEL_UP = "level_up",
  EVENT_POST_SCORE = "post_score",
  EVENT_SELECT_CONTENT = "select_content",
  EVENT_SPEND_VIRTUAL_CURRENCY = "spend_virtual_currency",
  EVENT_TUTORIAL_BEGIN = "tutorial_begin",
  EVENT_TUTORIAL_COMPLETE = "tutorial_complete",
  EVENT_UNLOCK_ACHIEVEMENT = "unlock_achievement",
  EVENT_SIGN_UP = "sign_up"
}
M.EVENT_PARAM = {
  PARAM_VIRTUAL_CURRENCY_NAME = "virtual_currency_name",
  PARAM_VALUE = "value",
  PARAM_GROUP_ID = "group_id",
  PARAM_CHARACTER = "character",
  PARAM_LEVEL = "level",
  PARAM_SCORE = "score",
  PARAM_CONTENT_TYPE = "content_type",
  PARAM_ITEM_ID = "item_id",
  PARAM_ITEM_NAME = "item_name",
  PARAM_ACHIEVEMENT_ID = "achievement_id"
}
M.FREQUENTLY_EVENTS = {
  ACTIVE = "active",
  ACCOUNTID_REGISTER = "accountid_register",
  PLAYER_CREATE = "player_create"
}

function M.set_native_vendor(vendor_name)
  native_vendor = vendor_name
end

local push_handlers

function M.set_handlers(handlers)
  push_handlers = handlers
end

local function callback(push_handler_name, ...)
  if push_handlers then
    local push_handler = push_handlers[push_handler_name]
    if push_handler then
      push_handler(...)
    end
  end
end

local EVT_HANDLERS = {}
EVT_HANDLERS[EVT_ON_SERVER_NOTIFICATION] = function(body)
  callback(push_event.ON_SERVER_NOTIFICATION, body.title, body.content, body.ext or {})
end
EVT_HANDLERS[EVT_ON_SERVER_NOTIFICATION_OPEN] = function(body)
  E.LOG.debug(TAG, "handle EVT_ON_SERVER_NOTIFICATION_OPEN")
  E.LOG.debug(TAG, {body = body})
  if body.ext and body.ext.platform_payload and type(body.ext.platform_payload) == "string" then
    local platform_payload = JSON.safe_decode(body.ext.platform_payload)
    E.LOG.debug(TAG, "decode platform_payload")
    E.LOG.debug(TAG, {platform_payload = platform_payload})
    if platform_payload and type(platform_payload) == "table" then
      platform_payload.is_priority_high = true
      ESTAT.stat_push("firebase_open_notification", nil, nil, {platform_payload = platform_payload})
    end
  else
    E.LOG.debug(TAG, "do not have platform_payload")
  end
  callback(push_event.ON_SERVER_NOTIFICATION_OPEN, body.title, body.content, body.ext or {})
  E.LOG.debug("url_open", "[v2]receive firebase:" .. JSON.encode(body))
  local notification_body = body or {}
  ET.publish("urlopen_v2", "notification", notification_body)
  ESTAT.stat_action("firebase_open_notification", nil, nil, notification_body)
end
EVT_HANDLERS[EVT_ON_SERVER_NOTIFICATION_RECEIVED_INAPP] = function(body)
  callback(push_event.ON_SERVER_NOTIFICATION_IN_APP, body.title, body.content, body.ext or {})
end
local sender_id

local function get_sender_id()
  if not sender_id then
    local result = UNI.sync_call(CHANNEL, SYNC_GET_SENDER_ID, {}, nil)
    sender_id = result and result.sender_id or nil
  end
  E.LOG.debug(TAG, "sender id: " .. tostring(sender_id))
  return sender_id
end

local BIND_TYPE_ACCOUNT = "account"
local BIND_TYPE_PLAYERID = "player_id"

local function get_api_url(api_path)
  local url_base = E.CONFIG.get_config("pusher")
  local url
  if EC.is_force_use_rule_service_splice_in_path("pusher") then
    url = url_base .. api_path
  else
    local product = E.CONFIG.get_config("product"):lower()
    url = url_base .. "/pusher/" .. product .. api_path
  end
  return url
end

local function bind_token_with_ext(type, token, value, ext, cb)
  assert(type == BIND_TYPE_ACCOUNT or type == BIND_TYPE_PLAYERID)
  local url = get_api_url("/manage/bind")
  local params = {
    type = type,
    token = token,
    value = value,
    sender_id = get_sender_id()
  }
  for k, v in pairs(ext) do
    params[k] = v
  end
  E.LOG.debug(TAG, "bind_token_with_ext")
  E.LOG.debug(TAG, params)
  local header = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-token"] = EH.get_player_token(),
      ["Ejoy-Token"] = EG.user_info().token
    },
    _log_config = {
      log_level = log_mgr.LOG_LEVEL.HIGH
    }
  }
  E.LOG.info(TAG, "bind_token_with_ext_to_server >>")
  HTTP.post(url, header, HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true)
      else
        cb(false)
      end
    else
      cb(false)
    end
  end)
end

local function bind_token(type, token, value, cb)
  assert(type == BIND_TYPE_ACCOUNT or type == BIND_TYPE_PLAYERID)
  local url = get_api_url("/manage/bind")
  local curr_publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  local params = {
    type = type,
    token = token,
    value = value,
    region = E.CONFIG.get_config(CONFIG_KEY_REGION),
    lang = E.CONFIG.get_config(CONFIG_KEY_LANG),
    sender_id = get_sender_id(),
    publish_area = curr_publish_area
  }
  local header = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-token"] = EH.get_player_token(),
      ["Ejoy-Token"] = EG.user_info().token
    },
    _log_config = {
      log_level = log_mgr.LOG_LEVEL.HIGH
    }
  }
  E.LOG.info(TAG, "bind_token_to_server >>")
  HTTP.post(url, header, HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true)
      else
        cb(false)
      end
    else
      cb(false)
    end
  end)
end

local function _bind_with_ext(type, ext_key, ext_store_key, ext_value)
  local bind_value
  if type == BIND_TYPE_ACCOUNT then
    local user_info = EG.user_info()
    bind_value = user_info.uid
  elseif type == BIND_TYPE_PLAYERID then
    local player_info = EG.player_info()
    bind_value = player_info.player_id
  end
  local last_ext_value = get_store_value(ext_store_key)
  if last_ext_value ~= ext_value then
    UNI.async_call(native_vendor, ASYNC_GET_TOKEN, {}, nil, function(succ, ...)
      if succ then
        local body = (...)
        local token = body.token
        E.LOG.debug(TAG, "firebase get token succ")
        E.LOG.debug(TAG, "firebase bind " .. tostring(ext_key) .. " for " .. tostring(type) .. ", get token: " .. tostring(token))
        local ext = {}
        ext[ext_key] = ext_value
        bind_token_with_ext(type, token, bind_value, ext, function(succ2)
          if succ2 then
            E.LOG.debug(TAG, "firebase bind " .. tostring(ext_key) .. " for " .. tostring(type) .. " value: " .. tostring(ext_value) .. " succ")
            set_store_value(ext_store_key, ext_value)
          end
        end)
      end
    end)
  end
end

function M.bind_account(account_id)
  local last_account = get_store_value(KEY_ACCOUNT_ID)
  local region = E.CONFIG.get_config(CONFIG_KEY_REGION)
  local last_region = get_store_value(KEY_ACCOUNT_REGION)
  local lang = E.CONFIG.get_config(CONFIG_KEY_LANG)
  local last_lang = get_store_value(KEY_ACCOUNT_LANG)
  local publish_area = E.CONFIG.get_config(CONFIG_KEY_PUBLISH_AREA)
  local last_publish_area = get_store_value(KEY_ACCOUNT_PUBLISH_AREA)
  local params = {
    account_id = account_id,
    last_account = last_account,
    region = region,
    last_region = last_region,
    lang = lang,
    last_lang = last_lang,
    publish_area = publish_area,
    last_publish_area = last_publish_area
  }
  log_mgr.info({}, TAG, "push_bind_account_start", "bind_account", params, {})
  UNI.async_call(native_vendor, ASYNC_GET_TOKEN, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      local token = body.token
      bind_token(BIND_TYPE_ACCOUNT, token, account_id, function(succ2)
        if succ2 then
          log_mgr.info({}, TAG, "push_bind_account_succ", "bind_account", {token = token, account_id = account_id}, {})
          set_store_value(KEY_ACCOUNT_ID, account_id)
          set_store_value(KEY_ACCOUNT_LANG, lang)
          set_store_value(KEY_ACCOUNT_REGION, region)
          set_store_value(KEY_ACCOUNT_PUBLISH_AREA, publish_area)
        else
          log_mgr.warn({}, TAG, "push_bind_account_fail", {
            token = token,
            account_id = account_id,
            cause = "bind_token_fail"
          }, {})
        end
      end)
    else
      local code, body = ...
      log_mgr.warn({}, TAG, "push_bind_account_fail", {
        code = code,
        msg = body.msg,
        cause = "get_token_fail"
      }, {})
    end
  end)
end

function M.bind_player_id(player_id)
  local last_player_id = get_store_value(KEY_PLAYER_ID)
  local region = E.CONFIG.get_config(CONFIG_KEY_REGION)
  local last_region = get_store_value(KEY_PLAYER_REGION)
  local lang = E.CONFIG.get_config(CONFIG_KEY_LANG)
  local last_lang = get_store_value(KEY_PLAYER_LANG)
  local publish_area = E.CONFIG.get_config(CONFIG_KEY_PUBLISH_AREA)
  local last_publish_area = get_store_value(KEY_PLAYER_PUBLISH_AREA)
  local params = {
    player_id = player_id,
    last_player_id = last_player_id,
    region = region,
    last_region = last_region,
    lang = lang,
    last_lang = last_lang,
    publish_area = publish_area,
    last_publish_area = last_publish_area
  }
  log_mgr.info({}, TAG, "push_bind_player_start", "bind_player", params, {})
  UNI.async_call(native_vendor, ASYNC_GET_TOKEN, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      local token = body.token
      bind_token(BIND_TYPE_PLAYERID, token, player_id, function(succ2)
        if succ2 then
          log_mgr.info({}, TAG, "push_bind_player_succ", "bind_player", {token = token, player_id = player_id}, {})
          set_store_value(KEY_PLAYER_ID, player_id)
          set_store_value(KEY_PLAYER_REGION, region)
          set_store_value(KEY_PLAYER_LANG, lang)
          set_store_value(KEY_PLAYER_PUBLISH_AREA, publish_area)
        else
          log_mgr.warn({}, TAG, "push_bind_player_fail", {
            token = token,
            player_id = player_id,
            cause = "bind_token_fail"
          }, {})
        end
      end)
    else
      local code, body = ...
      log_mgr.warn({}, TAG, "push_bind_player_fail", {
        code = code,
        msg = body.msg,
        cause = "async_get_token_fail"
      }, {}, {})
    end
  end)
end

local function subscribe_topic(topic, cb)
  UNI.async_call(native_vendor, ASYNC_SUBSCRIBE_TOPIC, {topic = topic}, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "subscribe_topic succ: " .. tostring(topic))
    else
      E.LOG.debug(TAG, "subscribe_topic fail: " .. tostring(topic))
    end
    if cb then
      cb(succ)
    end
  end)
end

local function unsubscrib_topic(topic, cb)
  UNI.async_call(native_vendor, ASYNC_UNSUBSCRIBE_TOPIC, {topic = topic}, nil, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "unsubscribe_topic succ: " .. tostring(topic))
    else
      E.LOG.debug(TAG, "unsubscribe_topic fail: " .. tostring(topic))
    end
    if cb then
      cb(succ)
    end
  end)
end

function M.bind_server_id(server_id)
  local last_server_id = get_store_value(KEY_SERVER_TOPIC)
  
  local function subscribe_server_id_cb(succ)
    if succ then
      log_mgr.info({}, TAG, "push_bind_server_succ", "bind_server", {server_id = server_id}, {})
      set_store_value(KEY_SERVER_TOPIC, server_id)
    else
      log_mgr.warn({}, TAG, "push_bind_server_fail", {
        server_id = server_id,
        cause = "subscribe_topic_fail"
      }, {})
    end
  end
  
  server_id = "server%" .. server_id
  local params = {last_server_id = last_server_id, server_id = server_id}
  log_mgr.info({}, TAG, "push_bind_server_start", "bind_server", params, {})
  if nil == last_server_id then
    subscribe_topic(server_id, subscribe_server_id_cb)
  elseif last_server_id ~= server_id then
    unsubscrib_topic(last_server_id, function(succ)
      if succ then
        subscribe_topic(server_id, subscribe_server_id_cb)
      else
        log_mgr.warn({}, TAG, "push_bind_server_fail", {
          last_server_id = last_server_id,
          cause = "unsubscrib_topic_fail"
        }, {})
      end
    end)
  end
end

local function bind_lang_topic()
  local lang = E.CONFIG.get_config(CONFIG_KEY_LANG)
  if not lang then
    return lang
  end
  lang = lang:lower()
  local last_lang = get_store_value(KEY_LANG_TOPIC)
  
  local function subscrib_lang_cb(succ)
    if succ then
      E.LOG.debug(TAG, "bind_lang_topic success")
      set_store_value(KEY_LANG_TOPIC, lang)
    else
      E.LOG.debug(TAG, "bind_lang_topic failed")
    end
  end
  
  E.LOG.debug(TAG, "bind_lang_topic, lang: " .. tostring(lang) .. " ,last lang: " .. tostring(last_lang))
  local lang_topic = "lang%" .. lang
  if nil == last_lang then
    subscribe_topic(lang_topic, subscrib_lang_cb)
  elseif last_lang ~= lang then
    local last_lang_topic = "lang%" .. last_lang
    unsubscrib_topic(last_lang_topic, function(succ)
      if succ then
        subscribe_topic(lang_topic, subscrib_lang_cb)
      end
    end)
  end
end

local function get_product_env()
  local product = E.CONFIG.get_config("product")
  product = product and product:lower()
  return product or ""
end

local function bind_platform_topic()
  local product = get_product_env()
  if product and #product > 0 then
    local last_platform = FIREBASE_LAST_PLATFORM:get()
    if last_platform and #last_platform > 0 and last_platform ~= product then
      local last_sdk_product_topic = "platform%" .. last_platform
      unsubscrib_topic(last_sdk_product_topic, function(succ)
        if succ then
          FIREBASE_LAST_PLATFORM:set("")
        else
          E.LOG.debug(TAG, "unbind " .. tostring(last_sdk_product_topic) .. " failed!")
        end
      end)
    end
    local sdk_product_topic = "platform%" .. product
    
    local function subscrib_cb(succ)
      if succ then
        FIREBASE_LAST_PLATFORM:set(product)
        E.LOG.debug(TAG, "bind platform: " .. tostring(product) .. " success!")
      else
        E.LOG.debug(TAG, "bind platform: " .. tostring(product) .. " failed!")
      end
    end
    
    subscribe_topic(sdk_product_topic, subscrib_cb)
  end
end

local function bind_region_topic()
  local region = E.CONFIG.get_config(CONFIG_KEY_REGION)
  if not region then
    return
  end
  local last_region = get_store_value(KEY_REGION_TOPIC)
  
  local function subscrib_region_cb(succ)
    if succ then
      set_store_value(KEY_REGION_TOPIC, region)
    end
  end
  
  E.LOG.debug(TAG, "bind_region_topic, region: " .. tostring(region) .. " ,last region: " .. tostring(last_region))
  local region_topic = "region%" .. region
  if nil == last_region then
    subscribe_topic(region_topic, subscrib_region_cb)
  elseif last_region ~= region then
    local last_region_topic = "region%" .. last_region
    unsubscrib_topic(last_region_topic, function(succ)
      if succ then
        subscribe_topic(region_topic, subscrib_region_cb)
      end
    end)
  end
end

local function bind_publish_area_topic()
  local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  
  local function subscrib_cb(succ)
    if succ then
      E.LOG.debug(TAG, "bind publish_area: " .. tostring(publish_area) .. " success!")
    else
      E.LOG.debug(TAG, "bind publish_area: " .. tostring(publish_area) .. " failed!")
    end
  end
  
  E.LOG.debug("bind_publish_area_topic, publish_area: " .. tostring(publish_area))
  local publish_area_topic = "publish_area%" .. tostring(publish_area)
  subscribe_topic(publish_area_topic, subscrib_cb)
end

local function bind_package_name_topic()
  local package_name = E.Sysinfo.package_name()
  
  local function subscrib_cb(succ)
    if succ then
      E.LOG.debug(TAG, "bind package_name: " .. tostring(package_name) .. " success!")
    else
      E.LOG.debug(TAG, "bind package_name: " .. tostring(package_name) .. " failed!")
    end
  end
  
  E.LOG.debug(TAG, "bind_package_name_topic, package_name: " .. tostring(package_name))
  local package_name_topic = "package_name%" .. package_name
  subscribe_topic(package_name_topic, subscrib_cb)
end

local function bind_os_topic()
  local os_name = _ejoysdk.os()
  
  local function subscrib_cb(succ)
    if succ then
      E.LOG.debug(TAG, "bind os: " .. tostring(os_name) .. " success!")
    else
      E.LOG.debug(TAG, "bind os: " .. tostring(os_name) .. " failed!")
    end
  end
  
  E.LOG.debug(TAG, "bind_os_topic, os: " .. tostring(os_name))
  local os_topic = "os%" .. os_name
  subscribe_topic(os_topic, subscrib_cb)
end

local function bind_sdk_version_topic()
  local ejoy = require("ejoysdk_lua.ejoysdk")
  local ejoysdk_version = ejoy.get_sdk_version_name("EJOYSDK")
  if not ejoysdk_version then
    E.log("bind_sdk_version_topic, but ejoysdk_version is nil")
    return
  end
  local last_sdk_version = FIREBASE_LAST_SDK_VERSION:get()
  if last_sdk_version and #last_sdk_version > 0 and last_sdk_version ~= ejoysdk_version then
    local last_sdk_version_topic = "sdk_version%" .. last_sdk_version
    unsubscrib_topic(last_sdk_version_topic, function(succ)
      if succ then
        FIREBASE_LAST_SDK_VERSION:set("")
      else
        E.LOG.debug(TAG, "unbind " .. tostring(last_sdk_version_topic) .. " failed!")
      end
    end)
  end
  
  local function subscrib_cb(succ)
    if succ then
      FIREBASE_LAST_SDK_VERSION:set(ejoysdk_version)
      E.log("bind sdk_version: " .. tostring(ejoysdk_version) .. " success!")
    else
      E.log("bind sdk_version: " .. tostring(ejoysdk_version) .. " failed!")
    end
  end
  
  E.log("bind_sdk_version_topic, sdk_version: " .. tostring(ejoysdk_version))
  local sdk_version_topic = "sdk_version%" .. ejoysdk_version
  subscribe_topic(sdk_version_topic, subscrib_cb)
end

local function bind_frequently_events_topic(event_name)
  if not event_name then
    E.log("bind_frequently_events_topic, event_name is nil")
    return
  end
  E.log("bind_frequently_events_topic, event_name: " .. tostring(event_name))
  local old_event_name = get_value_from_topic_store(event_name)
  if old_event_name then
    E.log("already bind this event_name before, can only bind once, event_name = " .. event_name)
    if M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER == event_name then
      local last_event_topic = "frequently_events%" .. M.FREQUENTLY_EVENTS.ACTIVE
      unsubscrib_topic(last_event_topic, nil)
    elseif M.FREQUENTLY_EVENTS.PLAYER_CREATE == event_name then
      local last_event_topic = "frequently_events%" .. M.FREQUENTLY_EVENTS.ACTIVE
      unsubscrib_topic(last_event_topic, function(_succ)
        last_event_topic = "frequently_events%" .. M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER
        unsubscrib_topic(last_event_topic, nil)
      end)
    end
    return
  end
  
  local function subscrib_region_cb(succ)
    if succ then
      set_value_to_topic_store(event_name, event_name)
      E.log("bind frequently_events_topic success, event_name = " .. event_name)
    else
      E.log("bind frequently_events_topic failed, event_name = " .. event_name)
    end
  end
  
  local event_topic = "frequently_events%" .. event_name
  if M.FREQUENTLY_EVENTS.ACTIVE == event_name then
    subscribe_topic(event_topic, subscrib_region_cb)
  elseif M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER == event_name then
    local last_region_topic = "frequently_events%" .. M.FREQUENTLY_EVENTS.ACTIVE
    unsubscrib_topic(last_region_topic, function(_succ)
    end)
    subscribe_topic(event_topic, subscrib_region_cb)
  elseif M.FREQUENTLY_EVENTS.PLAYER_CREATE == event_name then
    local last_event_topic = "frequently_events%" .. M.FREQUENTLY_EVENTS.ACTIVE
    unsubscrib_topic(last_event_topic, function(_succ)
    end)
    local last_region_topic = "frequently_events%" .. M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER
    unsubscrib_topic(last_region_topic, function(_succ)
    end)
    subscribe_topic(event_topic, subscrib_region_cb)
  end
end

local function require_params()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = EH.get_player_token()
    }
  }
end

local function push_post(type, params, cb)
  if url_items[type] then
    local url = get_api_url(url_items[type])
    E.HTTP.post(url, require_params(), E.HTTP.CT_JSON, params, function(resp)
      if resp and resp.status == 200 then
        if resp.body and 0 == resp.body.code then
          cb(true, resp and resp.body)
        else
          local body = resp.body
          cb(false, body and body.code, body and body.message)
        end
      else
        cb(false, resp and resp.status or -1, "request error")
      end
    end)
  end
end

local function _check_custom_tag_parmas(type, tag, cb)
  if not type or not tag then
    cb(false, FIREBASE_ERROR_CORE.FIREBASE_ERROR_PARAMS, "type or tag should not be nil")
    return false
  end
  if #type > TYPE_LEN_LIMIT or #tag > TYPE_TAG_LIMIT then
    cb(false, FIREBASE_ERROR_CORE.FIREBASE_ERROR_PARAMS, "the length is not supported.(need: #type <= 40 and #tag <= 80)")
    return false
  end
  return true
end

function M.bind_custom_tag(type, tag, cb)
  if not _check_custom_tag_parmas(type, tag, cb) then
    return
  end
  local custom_topic = tostring(type) .. "%" .. tostring(tag)
  local tag_params = {key = type, value = tag}
  push_post("check_tags", {
    tag_list = {tag_params}
  }, function(succ, ...)
    if succ then
      subscribe_topic(custom_topic, function(succ_topic)
        if succ_topic then
          E.LOG.debug(TAG, "bind custom_tag success, tag = " .. tostring(custom_topic))
          cb(true, tostring(custom_topic))
        else
          E.LOG.debug(TAG, "bind custom_tag fail, tag = " .. tostring(custom_topic))
          cb(false, FIREBASE_ERROR_CORE.FIREBASE_BIND_FAIL, "bind custom_tag fail, tag = " .. tostring(custom_topic))
        end
      end)
    else
      cb(false, ...)
    end
  end)
end

function M.unbind_custom_tag(type, tag, cb)
  if not _check_custom_tag_parmas(type, tag, cb) then
    return
  end
  local custom_topic = tostring(type) .. "%" .. tostring(tag)
  unsubscrib_topic(custom_topic, function(succ)
    if succ then
      E.LOG.debug(TAG, "unbind custom_tag success, tag = " .. tostring(custom_topic))
      cb(true, tostring(custom_topic))
    else
      E.LOG.debug(TAG, "unbind custom_tag fail, tag = " .. tostring(custom_topic))
      cb(false, FIREBASE_ERROR_CORE.FIREBASE_BIND_FAIL, "unbind custom_tag fail, tag = " .. tostring(custom_topic))
    end
  end)
end

local function register_handler()
  bind_frequently_events_topic(M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER)
end

local function get_player_token_handler(_player_token)
  log_mgr.info({}, TAG, "get_player_token_handler", "get_player_token_handler", {}, {})
  local player_info = EG.player_info()
  M.bind_player_id(player_info.player_id)
  M.bind_server_id(player_info.server_id)
  bind_lang_topic()
  bind_region_topic()
end

local function try_commit_mail_info()
  if E.Sysinfo.os() == "ios" then
    local ECC = require("ejoysdk_lua.ejoysdk_config_center")
    local usercenter_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_OVERSEA)
    local need_commit_mail = usercenter_config and usercenter_config.config and usercenter_config.config.commit_email_firebase == true
    if need_commit_mail then
      local account_info_content = E.UnRecoverKeyStore.get("ACCOUNT_FE_desensitization_account_info")
      if nil == account_info_content then
        E.LOG.debug(TAG, "has not airline account info")
        return
      end
      local account_info = JSON.safe_decode(account_info_content)
      local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
      local ejoyId = (USER.user_info() or {}).ejoyId
      E.LOG.debug(TAG, "start check current login by mail, ejoyId is " .. tostring(ejoyId))
      if account_info and account_info.email and ejoyId then
        for _, mail_info in pairs(account_info.email) do
          if mail_info.id == ejoyId and mail_info.value then
            local params = {
              mail = mail_info.value
            }
            E.LOG.debug(TAG, "commit mail info to firebase")
            UNI.cast(CHANNEL, CAST_COMMIT_EMAIL_INFO, params)
          end
        end
      end
    else
      E.LOG.debug(TAG, "do not need commit mail to firebase")
    end
  end
end

local function try_commit_phone_info()
  local function action()
    if E.Sysinfo.os() ~= "ios" then
      return
    end
    local ECC = require("ejoysdk_lua.ejoysdk_config_center")
    local usercenter_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_OVERSEA)
    local need_commit_phone = usercenter_config and usercenter_config.config and usercenter_config.config.commit_phone_firebase == true
    if not need_commit_phone then
      E.LOG.debug(TAG, "do not need commit phone to firebase")
      return
    end
    local account_info_content = E.UnRecoverKeyStore.get("ACCOUNT_FE_desensitization_account_info")
    if nil == account_info_content then
      E.LOG.debug(TAG, "has not airline account info")
      return
    end
    local account_info = JSON.safe_decode(account_info_content)
    local USER = require("ejoysdk_lua.user_center.ejoysdk_usercenter")
    local ejoyId = (USER.user_info() or {}).ejoyId
    E.LOG.debug(TAG, "start check current login by phone, ejoyId is " .. tostring(ejoyId))
    if not (account_info and account_info.phone) or not ejoyId then
      E.LOG.debug(TAG, "check current login by phone fail")
      return
    end
    for _, phone_info in pairs(account_info.phone) do
      if phone_info.id == ejoyId and phone_info.value and phone_info.mobileAreaCode then
        local params = {
          phone = "+" .. tostring(phone_info.mobileAreaCode) .. tostring(phone_info.value)
        }
        E.LOG.debug(TAG, "commit phone info to firebase")
        UNI.cast(CHANNEL, CAST_COMMIT_PHONE_INFO, params)
      end
    end
  end
  
  xpcall(action, function(x)
    E.LOG.e(TAG, "try_commit_phone_info lua error, error_msg=" .. tostring(x))
  end)
end

local function acquire_succ_handler()
  try_commit_mail_info()
  try_commit_phone_info()
  local user_info = EG.user_info()
  M.bind_account(user_info.uid)
end

local function get_player_info_handler(player_info)
  local last_firebase_player_info = FIREBASE_LAST_PLAYER_INFO:get()
  if not last_firebase_player_info or last_firebase_player_info.player_id ~= player_info.player_id then
    FIREBASE_LAST_PLAYER_INFO:set({})
  end
  bind_frequently_events_topic(M.FREQUENTLY_EVENTS.PLAYER_CREATE)
end

local function lang_changed_handler(new_lang)
  bind_lang_topic()
  _bind_with_ext(BIND_TYPE_PLAYERID, "lang", KEY_PLAYER_LANG, new_lang)
  _bind_with_ext(BIND_TYPE_ACCOUNT, "lang", KEY_ACCOUNT_LANG, new_lang)
end

local function region_changed_handler(new_region)
  bind_region_topic()
  _bind_with_ext(BIND_TYPE_PLAYERID, "region", KEY_PLAYER_REGION, new_region)
  _bind_with_ext(BIND_TYPE_ACCOUNT, "region", KEY_ACCOUNT_REGION, new_region)
end

local init_count
local init_finished = false

local function init_finish()
  if init_finished then
    log_mgr.info({}, TAG, "push_has_inited", "push_has_inited", {}, {})
    return
  end
  init_finished = true
  log_mgr.info({}, TAG, "push_init_finish", "push_init_finish", {}, {})
  local ejoysdk_push = require("ejoysdk_lua.push.ejoysdk_push")
  ejoysdk_push.set_push_vendor(M)
  UNI.register_event_cb(native_vendor, function(type, body)
    if not push_handlers then
      return
    end
    local handler = EVT_HANDLERS[type]
    if handler then
      handler(body)
    end
  end)
  UNI.cast(native_vendor, CAST_LUA_INIT_FINISH, {})
end

local function init_handler()
  init_count = init_count + 1
  if 2 == init_count then
    init_finish()
  elseif 1 == init_count and PUSH.inited == true then
    init_finish()
  end
end

local function sha1_hex(data)
  do return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data) end
  return _ejoysdk_crypt.hexencode, _ejoysdk_crypt.sha1(data)
end

local cache_app_instance_id = ""

function M.app_instance_id()
  return cache_app_instance_id
end

local EEA_SETTING = E.LazyKeyStore:New("EJOY_EEA_SETTING", false, true, false)
local CONSENT_MODE = {
  AD_STORAGE = "ad_storage",
  ANALYTICS_STORAG = "analytics_storage",
  AD_USER_DATA = "ad_user_data",
  AD_PERSONALIZATION = "ad_personalization"
}

local function set_eea_consent_mode(grant)
  grant = true == grant
  local consent_mode = {}
  for _, v in pairs(CONSENT_MODE) do
    consent_mode[v] = grant
  end
  EEA_SETTING:set(consent_mode)
  UNI.cast(native_vendor, "CAST_SET_CONSENT", consent_mode)
end

local function eea_check()
  local sdk_info = UNI.get_sdk_info(CHANNEL)
  if sdk_info and sdk_info.meta and sdk_info.meta.eea_check == true then
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
    UTILS.get_user_ip_info(function(succ, info)
      if succ and info and type(info.countryCode) == "string" then
        local cc = string.upper(info.countryCode)
        for _, country in ipairs({
          "AT",
          "BE",
          "BG",
          "CY",
          "CZ",
          "DK",
          "DE",
          "EE",
          "ES",
          "FI",
          "FR",
          "GR",
          "HU",
          "HR",
          "IT",
          "IE",
          "LV",
          "LT",
          "LU",
          "MT",
          "PT",
          "NL",
          "PL",
          "RO",
          "SK",
          "SI",
          "SE",
          "GB"
        }) do
          if cc == country then
            E.LOG.d(TAG, cc .. " is a EU country")
            set_eea_consent_mode(false)
            return
          end
        end
        set_eea_consent_mode(true)
      end
    end)
  end
end

function M.init(opt, cb)
  local config = opt.config or {}
  config.enable_ldu = OVERSEA_APPLOG.has_enabled_ldu() == true or false
  local os = E.Sysinfo.os()
  if "ios" == os then
    local versionFB = E.Sdkinfo.getSDKVersionName(CHANNEL)
    local version_check = require("ejoysdk_lua.ejoysdk_version_check")
    local result = version_check.compare_versions(versionFB, "10.23.1")
    if tonumber(result) >= 0 then
      config.consent_mode = EEA_SETTING:get() or {}
    else
      E.LOG.debug(TAG, "ios lower version consent_mode ignore")
    end
  else
    config.consent_mode = EEA_SETTING:get() or {}
  end
  UNI.cast(native_vendor, CAST_INIT, config)
  eea_check()
  if is_inited then
    cb(true)
    return
  end
  is_inited = true
  E.LOG.tips(TAG, "If you get a push or firebase report error")
  log_mgr.call_api({}, TAG, "init", log_mgr.LOG_LEVEL.HIGH, {}, opt, cb)
  init_count = 0
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. CONFIG_KEY_REGION, region_changed_handler)
  ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. CONFIG_KEY_LANG, lang_changed_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, get_player_info_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
  ET.subscribe(ET.holo.GET_PLAYER_TOKEN, get_player_token_handler)
  ET.subscribe(ET.gangplank.INITED, init_handler)
  ET.subscribe(ET.push.INITED, init_handler)
  ET.subscribe(ET.analytics.REGISTER, function(user_info)
    M.commit_event(M.EVENT_KEY.EVENT_SIGN_UP, {
      uid = sha1_hex(user_info.uid)
    })
  end)
  ET.subscribe(ET.analytics.REGISTER, register_handler)
  local os_version = E.Sysinfo.os_version() or ""
  local os_version_number = tonumber(os_version)
  if "android" == os and os_version_number and os_version_number >= 33 then
    E.LOG.debug(TAG, "android13 request POST_NOTIFICATIONS permission")
    E.Permission.check_permission_v2("android.permission.POST_NOTIFICATIONS", function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "POST_NOTIFICATIONS permission granted")
      else
        E.LOG.debug(TAG, "POST_NOTIFICATIONS permission deny")
      end
    end)
  end
  UNI.async_call(native_vendor, ASYNC_GET_TOKEN, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      local token = body.token
      log_mgr.info({}, TAG, "push_async_get_token_succ", "push_async_get_token_succ", {token = token}, {})
      bind_package_name_topic()
      bind_os_topic()
      bind_sdk_version_topic()
      bind_publish_area_topic()
      bind_lang_topic()
      bind_platform_topic()
      bind_frequently_events_topic(M.FREQUENTLY_EVENTS.ACTIVE)
    else
      local code, body = ...
      log_mgr.warn({}, TAG, "push_async_get_token_fail", {
        code = code,
        msg = body.msg
      }, {})
    end
  end)
  UNI.async_call(native_vendor, ASYNC_GET_INSTANCE_ID, {}, nil, function(succ, ...)
    if succ then
      local body = (...)
      local app_instance_id = body and body.app_instance_id or ""
      log_mgr.info({}, TAG, "push_get_instance_id_succ", "push_get_instance_id_succ", {instance_id = app_instance_id}, {})
      cache_app_instance_id = app_instance_id
    else
      local code, body = ...
      log_mgr.warn({}, TAG, "push_get_instance_id_fail", {
        code = code,
        msg = body and body.msg
      }, {})
    end
  end)
  OVERSEA_APPLOG.register_applog_events(CHANNEL, M)
  cb(true)
end

M.enable_ldu = false

function M.commit_event(event_name, params)
  if M.enable_ldu == true then
    E.LOG.debug(TAG, "firebase commit_event disabled with LDU setting")
    return
  end
  local event_params = {event_name = event_name, params = params}
  UNI.cast(CHANNEL, CAST_COMMIT_EVENT, event_params)
end

M:is_implemented({
  "PUSH",
  Vendor.ABILITY.STATS
})
return M
