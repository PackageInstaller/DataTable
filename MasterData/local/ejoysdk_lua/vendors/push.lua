local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local push_event = require("ejoysdk_lua.push.ejoysdk_push_event")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
local ECO = require("ejoysdk_lua.ejoysdk_community")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EC = require("ejoysdk_lua.ejoysdk_config")
local HTTP = E.HTTP
local VENDOR_NAME = "PUSH"
local TAG = EM.MODULE.VENDORS.PUSH
local CAST_LUA_INIT_FINISH = "CAST_LUA_INIT_FINISH"
local CAST_TURN_ON_PUSH = "CAST_TURN_ON_PUSH"
local CAST_TURN_OFF_PUSH = "CAST_TURN_OFF_PUSH"
local CAST_ADD_LOCAL_NOTIFICATION = "CAST_ADD_LOCAL_NOTIFICATION"
local CAST_REMOVE_LOCAL_NOTIFICATION = "CAST_REMOVE_LOCAL_NOTIFICATION"
local ASYNC_BIND_ACCOUNT = "ASYNC_BIND_ACCOUNT"
local ASYNC_UNBIND_ACCOUNT = "ASYNC_UNBIND_ACCOUNT"
local ASYNC_ADD_ALIAS = "ASYNC_ADD_ALIAS"
local ASYNC_REMOVE_ALIAS = "ASYNC_REMOVE_ALIAS"
local ASYNC_BIND_TAG = "ASYNC_BIND_TAG"
local ASYNC_UNBIND_TAG = "ASYNC_UNBIND_TAG"
local ASYNC_GET_TAG_LIST = "ASYNC_GET_TAG_LIST"
local SYNC_GET_DEVICE_INFO = "SYNC_GET_DEVICE_INFO"
local SYNC_IS_SUPPORT_GET_TAG_LIST = "SYNC_IS_SUPPORT_GET_TAG_LIST"
local ASYNC_GET_DEVICE_INFO = "ASYNC_GET_DEVICE_INFO"
local EVT_ON_SERVER_MESSAGE = "EVT_ON_SERVER_MESSAGE"
local EVT_ON_SERVER_NOTIFICATION = "EVT_ON_SERVER_NOTIFICATION"
local EVT_ON_SERVER_NOTIFICATION_OPEN = "EVT_ON_SERVER_NOTIFICATION_OPEN"
local EVT_ON_SERVER_NOTIFICATION_RECEIVED_INAPP = "EVT_ON_SERVER_NOTIFICATION_RECEIVED_INAPP"
local EVT_ON_LOCAL_NOTIFICATION = "EVT_ON_LOCAL_NOTIFICATION"
local EVT_ON_LOCAL_NOTIFICATION_OPEN = "EVT_ON_LOCAL_NOTIFICATION_OPEN"
local EVT_ON_LOCAL_NOTIFICATION_RECEIVE_INAPP = "EVT_ON_LOCAL_NOTIFICATION_RECEIVE_INAPP"
local PUSH_LAST_PLAYER_ID = E.LazyKeyStore:New("PUSH_LAST_PLAYER_ID", false, false, false)
local PUSH_LAST_PLAYER_ID_TIME = E.LazyKeyStore:New("PUSH_LAST_PLAYER_ID_TIME", false, false, false)
local PUSH_LAST_ACCOUNT_ID = E.LazyKeyStore:New("PUSH_LAST_ACCOUNT_ID", false, false, false)
local PUSH_LAST_ACCOUNT_ID_TIME = E.LazyKeyStore:New("PUSH_LAST_ACCOUNT_ID_TIME", false, false, false)
local PUSH_LAST_SERVER_ID = E.LazyKeyStore:New("PUSH_LAST_SERVER_ID", false, false, false)
local PUSH_LAST_SERVER_ID_ON_DEVICE = E.LazyKeyStore:New("PUSH_LAST_SERVER_ID_ON_DEVICE", false, false, false)
local SAVE_ENTER_GAME_TAG = E.LazyKeyStore:New("SAVE_ENTER_GAME_TAG", false, false, false)
local PUSH_TOPIC_STORE = E.LazyKeyStore:New("PUSH_TOPIC_STORE", false, true, false)
local PUSH_BIND_CACHE_EXPIRY_DURATION = 86400
local PUSH_LAST_SDK_VERSION = E.LazyKeyStore:New("PUSH_LAST_SDK_VERSION", false, false, false)
local PUSH_LAST_PLATFORM = E.LazyKeyStore:New("PUSH_LAST_PLATFORM", false, false, false)
local M = Vendor:Inherit(VENDOR_NAME)
M.DEVICE_TARGET = 1
M.ACCOUNT_TARGET = 2
M.ALIAS_TARGET = 3
local COLLECT_TYPE_ACCOUNT = "account"
local COLLECT_TYPE_PLAYERID = "player_id"
local appkey, device_info
local url_items = {
  check_tags = "/api/check_tags"
}
local TYPE_LEN_LIMIT = 40
local TYPE_TAG_LIMIT = 80
local PUSH_ERROR_CORE = {
  PUSH_BIND_SUC = 74003001,
  PUSH_ERROR_PARAMS = 74003002,
  PUSH_BIND_FAIL = 74003003
}
M.FREQUENTLY_EVENTS = {
  ACTIVE = "active",
  ACCOUNTID_REGISTER = "accountid_register",
  PLAYER_CREATE = "player_create"
}
local is_bind_use_cache = false

local function require_params()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = EH.get_player_token()
    }
  }
end

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

local function get_value_from_topic_store(key)
  local store_value = PUSH_TOPIC_STORE:get() or {}
  return store_value[key]
end

local function set_value_to_topic_store(key, value)
  local info = PUSH_TOPIC_STORE:get() or {}
  info[key] = value
  PUSH_TOPIC_STORE:set(info)
end

local function is_bind_use_cache_from_cc()
  local cc_config = ECC.get_config(ECC.NAMESPACE.EJOYSDK_BIZ)
  local push_config = cc_config and cc_config.config and cc_config.config.push
  if push_config and push_config.is_bind_use_cache then
    return true
  end
  return false
end

local function get_appkey()
  if not appkey then
    if E.Sysinfo.os() == "android" then
      appkey = tostring(E.Sysinfo.manifest_meta_data("int", "com.alibaba.app.appkey"))
    elseif E.Sysinfo.os() == "ios" then
      appkey = tostring(UNI.sync_call(VENDOR_NAME, "ASYNC_PUSH_GET_APPKEY", {}).value)
    elseif E.Sysinfo.os() == "harmonyos" then
      local meta_config = E.CONFIG.get_vendor_config_v2("push") or {}
      appkey = meta_config.appkey
    end
  end
  E.LOG.debug(TAG, "appkey: " .. tostring(appkey))
  return appkey
end

local function server_collect(type, value, cb)
  assert(type == COLLECT_TYPE_PLAYERID or type == COLLECT_TYPE_ACCOUNT, "server collect type wrong")
  cb = cb or function()
  end
  local url = get_api_url("/manage/ay/collect")
  M.get_device_info_async(function(dinfo)
    local params = {
      type = type,
      value = value,
      appKey = get_appkey(),
      deviceId = dinfo and dinfo.device_id or ""
    }
    local header = {
      acceptable = E.HTTP.CT_JSON,
      _log_config = {
        log_level = log_mgr.LOG_LEVEL.HIGH
      }
    }
    if COLLECT_TYPE_ACCOUNT == type then
      header.headers = {
        ["Ejoy-Token"] = EG.user_info().token
      }
    else
      header.headers = {
        ["moment-token"] = EH.get_player_token(),
        ["Ejoy-Token"] = EG.user_info().token
      }
    end
    HTTP.post(url, header, HTTP.CT_JSON, params, function(resp)
      if resp.status == 200 then
        if resp.body and 0 == resp.body.code then
          local bind_value = resp.body and resp.body.bind_value
          cb(true, bind_value)
        else
          cb(false)
        end
      else
        cb(false)
      end
    end)
  end)
end

local function async_call(type, params, cb)
  UNI.async_call(VENDOR_NAME, type, params, nil, cb)
end

function M.turn_on_push()
  UNI.cast(VENDOR_NAME, CAST_TURN_ON_PUSH, {})
end

function M.turn_off_push()
  UNI.cast(VENDOR_NAME, CAST_TURN_OFF_PUSH, {})
end

function M.get_device_info()
  if not device_info then
    if E.Sysinfo.os() == "harmonyos" then
      return nil
    else
      device_info = UNI.sync_call(VENDOR_NAME, SYNC_GET_DEVICE_INFO, {}) or {}
    end
  end
  return device_info
end

function M.get_device_info_async(cb)
  if E.Sysinfo.os() == "harmonyos" then
    if device_info then
      if cb then
        cb(device_info)
      end
    else
      async_call(ASYNC_GET_DEVICE_INFO, {}, function(succ, ...)
        if cb then
          if succ then
            local info_body = (...)
            device_info = info_body and type(info_body) == "table" and info_body or {}
            cb(device_info)
          else
            cb(nil)
          end
        end
      end)
    end
  elseif cb then
    cb(M.get_device_info())
  end
end

function M.get_tag_list(cb)
  if M.is_support_get_tag_list() then
    async_call(ASYNC_GET_TAG_LIST, {}, function(succ, ...)
      if cb then
        if succ then
          local info_body = (...)
          local tag_list_str = info_body and type(info_body) == "table" and info_body.tag_list
          local sp_tag_list
          if tag_list_str and type(tag_list_str) == "string" then
            sp_tag_list = E.Utils.split_string(tag_list_str, ",")
          end
          cb(true, sp_tag_list or {})
        else
          local _code, info_body = ...
          local ra_error_code = "0"
          local ra_error_msg = ""
          if info_body and type(info_body) == "table" then
            ra_error_code = tostring(info_body and info_body.error_code or "0")
            ra_error_msg = tostring(info_body and info_body.error_msg or "")
          end
          cb(false, ra_error_code, ra_error_msg)
        end
      end
    end)
  elseif cb then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "push sdk not support this api")
  end
end

local _is_support_get_tag_list

function M.is_support_get_tag_list()
  if nil == _is_support_get_tag_list then
    if E.Sysinfo.os() == "harmonyos" then
      _is_support_get_tag_list = true
    else
      local ret = UNI.sync_call(VENDOR_NAME, SYNC_IS_SUPPORT_GET_TAG_LIST, {}) or {}
      _is_support_get_tag_list = ret and ret.value or false
    end
  end
  return _is_support_get_tag_list
end

local function get_product_env()
  local product = E.CONFIG.get_config("product")
  product = product and product:lower()
  return product or ""
end

local function bind_account_use_cache_flag(account)
  local last_account = PUSH_LAST_ACCOUNT_ID:get()
  local last_account_time = PUSH_LAST_ACCOUNT_ID_TIME:get() or 0
  local now = E.time()
  if last_account ~= account or now - last_account_time >= PUSH_BIND_CACHE_EXPIRY_DURATION then
    server_collect(COLLECT_TYPE_ACCOUNT, account, function(succ2, bind_value)
      if succ2 then
        local account_tag = account
        if nil ~= bind_value then
          account_tag = bind_value
        end
        async_call(ASYNC_BIND_ACCOUNT, {account = account_tag}, function(succ, ...)
          if succ then
            E.LOG.d(TAG, "bind_account_use_cache_flag:" .. tostring(account_tag) .. " succ")
          else
            PUSH_LAST_ACCOUNT_ID:set("")
            PUSH_LAST_ACCOUNT_ID_TIME:set(0)
            local log_params = {
              account = tostring(account),
              last_account = tostring(last_account),
              last_account_time = tostring(last_account_time),
              cause = "async_call_bind_account_fail"
            }
            log_mgr.warn({}, TAG, "push_bind_account_fail", log_params, {})
            ESTAT.stat_action("push", "bind_account", false, log_params)
          end
        end)
        PUSH_LAST_ACCOUNT_ID:set(account)
        PUSH_LAST_ACCOUNT_ID_TIME:set(E.time())
        local log_params = {
          account = tostring(account),
          last_account = tostring(last_account),
          last_account_time = tostring(last_account_time)
        }
        log_mgr.debug({}, TAG, "push_bind_account_succ", "bind_account", log_params, {})
      else
        PUSH_LAST_ACCOUNT_ID:set("")
        PUSH_LAST_ACCOUNT_ID_TIME:set(0)
        M.unbind_account(account)
        local log_params = {
          account = tostring(account),
          last_account = tostring(last_account),
          last_account_time = tostring(last_account_time),
          cause = "server_collect_fail"
        }
        log_mgr.warn({}, TAG, "push_bind_account_fail", log_params, {})
        ESTAT.stat_action("push", "bind_account", false, log_params)
      end
    end)
  else
    local log_params = {
      account = tostring(account),
      last_account = tostring(last_account),
      last_account_time = tostring(last_account_time)
    }
    log_mgr.debug({}, TAG, "push_bind_account_succ_already", "bind_account", log_params, {})
  end
end

function M.bind_account(account)
  local last_account = PUSH_LAST_ACCOUNT_ID:get()
  local last_account_time = PUSH_LAST_ACCOUNT_ID_TIME:get() or 0
  local log_params_start = {
    last_account = tostring(last_account),
    last_account_time = tostring(last_account_time),
    account = tostring(account)
  }
  log_mgr.debug({}, TAG, "push_bind_account_start", "bind_account", log_params_start, {})
  if is_bind_use_cache then
    bind_account_use_cache_flag(account)
  else
    server_collect(COLLECT_TYPE_ACCOUNT, account, function(succ2, bind_value)
      if succ2 then
        local account_tag = account
        if nil ~= bind_value then
          account_tag = bind_value
        end
        async_call(ASYNC_BIND_ACCOUNT, {account = account_tag}, function(succ, ...)
          if succ then
            E.LOG.d(TAG, "bind_account:" .. tostring(account_tag) .. " succ")
          else
            local _code, info_body = ...
            M.get_device_info_async(function(dinfo)
              PUSH_LAST_ACCOUNT_ID:set("")
              PUSH_LAST_ACCOUNT_ID_TIME:set(0)
              local ra_error_code = "0"
              local ra_error_msg = ""
              if info_body and type(info_body) == "table" then
                ra_error_code = tostring(info_body and info_body.error_code or "0")
                ra_error_msg = tostring(info_body and info_body.error_msg or "")
              end
              local log_params = {
                account = tostring(account),
                last_account = tostring(last_account),
                last_account_time = tostring(last_account_time),
                cause = "async_call_bind_account_fail",
                push_device_id = dinfo and dinfo.device_id or "",
                error_code = ra_error_code,
                error_msg = ra_error_msg,
                init_error_code = tostring(dinfo and dinfo.init_result and dinfo.init_result.error_code or "0"),
                init_error_msg = tostring(dinfo and dinfo.init_result and dinfo.init_result.error_msg or "")
              }
              log_mgr.warn({}, TAG, "push_bind_account_fail", log_params, {})
              ESTAT.stat_action("push", "bind_account", false, log_params)
            end)
          end
        end)
        PUSH_LAST_ACCOUNT_ID:set(account)
        PUSH_LAST_ACCOUNT_ID_TIME:set(E.time())
        local log_params = {
          account = tostring(account),
          last_account = tostring(last_account),
          last_account_time = tostring(last_account_time),
          cause = "bind_account_succ"
        }
        log_mgr.debug({}, TAG, "push", "bind_account", log_params, {})
      else
        PUSH_LAST_ACCOUNT_ID:set("")
        PUSH_LAST_ACCOUNT_ID_TIME:set(0)
        M.unbind_account(account)
        local log_params = {
          account = tostring(account),
          last_account = tostring(last_account),
          last_account_time = tostring(last_account_time),
          cause = "server_collect_fail"
        }
        log_mgr.warn({}, TAG, "push_bind_account_fail", log_params, {})
        ESTAT.stat_action("push", "bind_account", false, log_params)
      end
    end)
  end
end

function M.unbind_account(account, cb)
  log_mgr.call_api({}, TAG, "unbind_account", log_mgr.LOG_LEVEL.HIGH, {}, account, cb)
  async_call(ASYNC_UNBIND_ACCOUNT, {account = account}, function(...)
    if cb then
      cb(...)
    end
    log_mgr.call_api_async_callback({}, TAG, "unbind_account", log_mgr.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.add_alias(alias, cb)
  log_mgr.call_api({}, TAG, "add_alias", log_mgr.LOG_LEVEL.HIGH, {}, alias, cb)
  async_call(ASYNC_ADD_ALIAS, {alias = alias}, function(...)
    if cb then
      cb(...)
    end
    log_mgr.call_api_async_callback({}, TAG, "add_alias", log_mgr.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.remove_alias(alias, cb)
  log_mgr.call_api({}, TAG, "remove_alias", log_mgr.LOG_LEVEL.HIGH, {}, alias, cb)
  async_call(ASYNC_REMOVE_ALIAS, {alias = alias}, function(...)
    if cb then
      cb(...)
    end
    log_mgr.call_api_async_callback({}, TAG, "remove_alias", log_mgr.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.bind_tag(target, tags, alias, cb)
  log_mgr.call_api({}, TAG, "bind_tag", log_mgr.LOG_LEVEL.HIGH, {}, target, tags, alias, cb)
  async_call(ASYNC_BIND_TAG, {
    target = target,
    tags = tags,
    alias = alias
  }, function(...)
    if cb then
      cb(...)
    end
    log_mgr.call_api_async_callback({}, TAG, "bind_tag", log_mgr.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.unbind_tag(target, tags, alias, cb)
  log_mgr.call_api({}, TAG, "unbind_tag", log_mgr.LOG_LEVEL.HIGH, {}, target, tags, alias, cb)
  async_call(ASYNC_UNBIND_TAG, {
    target = target,
    tags = tags,
    alias = alias
  }, function(...)
    if cb then
      cb(...)
    end
    log_mgr.call_api_async_callback({}, TAG, "unbind_tag", log_mgr.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.add_local_notification(title, content, calendar, ext, config)
  log_mgr.call_api({}, TAG, "add_local_notification", log_mgr.LOG_LEVEL.LOW, {}, title, content, calendar, ext, config)
  UNI.cast(VENDOR_NAME, CAST_ADD_LOCAL_NOTIFICATION, {
    title = title,
    content = content,
    calendar = calendar,
    ext = ext,
    config = config
  })
end

function M.remove_local_notification(notify_id)
  log_mgr.call_api({}, TAG, "remove_local_notification", log_mgr.LOG_LEVEL.LOW, {}, notify_id)
  UNI.cast(VENDOR_NAME, CAST_REMOVE_LOCAL_NOTIFICATION, {notify_id = notify_id})
end

local push_handlers

function M.set_handlers(handlers)
  log_mgr.call_api({}, TAG, "set_handlers", log_mgr.LOG_LEVEL.LOW, {}, handlers)
  push_handlers = handlers
end

local function bind_player_use_cache_flag(player_id, bind_player_id_alias_func)
  local last_player_id = PUSH_LAST_PLAYER_ID:get()
  local last_player_id_time = PUSH_LAST_PLAYER_ID_TIME:get() or 0
  local now = E.time()
  if last_player_id ~= player_id or now - last_player_id_time >= PUSH_BIND_CACHE_EXPIRY_DURATION then
    M.remove_alias(nil, function(succ)
      if succ then
        PUSH_LAST_PLAYER_ID:set("")
        PUSH_LAST_PLAYER_ID_TIME:set(0)
        if bind_player_id_alias_func then
          bind_player_id_alias_func()
        end
      else
        local log_params = {
          player_id = tostring(player_id),
          last_player_id = tostring(last_player_id),
          last_player_id_time = tostring(last_player_id_time),
          cause = "remove_alias_fail"
        }
        log_mgr.warn({}, TAG, "push_bind_player_fail", log_params, {})
        ESTAT.stat_action("push", "bind_player", false, log_params)
      end
    end)
  else
    local log_params = {
      player_id = tostring(player_id),
      last_player_id = tostring(last_player_id),
      last_player_id_time = tostring(last_player_id_time),
      cause = "bind_player_succ_already"
    }
    log_mgr.debug({}, TAG, "push", "bind_player", log_params, {})
  end
end

function M.bind_player_id(player_id)
  local last_player_id = PUSH_LAST_PLAYER_ID:get()
  local last_player_id_time = PUSH_LAST_PLAYER_ID_TIME:get() or 0
  
  local function bind_player_id_alias_func()
    server_collect(COLLECT_TYPE_PLAYERID, player_id, function(succ2, bind_value)
      if succ2 then
        local player_id_alias = player_id
        if nil ~= bind_value then
          player_id_alias = bind_value
        end
        M.add_alias(player_id_alias, function(succ, ...)
          if succ then
            E.LOG.d(TAG, "add_alias:" .. tostring(player_id_alias) .. " succ")
          else
            local _code, info_body = ...
            M.get_device_info_async(function(dinfo)
              local ra_error_code = "0"
              local ra_error_msg = ""
              if info_body and type(info_body) == "table" then
                ra_error_code = tostring(info_body and info_body.error_code or "0")
                ra_error_msg = tostring(info_body and info_body.error_msg or "")
              end
              local log_params = {
                player_id = tostring(player_id),
                last_player_id = tostring(last_player_id),
                last_player_id_time = tostring(last_player_id_time),
                cause = "add_alias_fail",
                push_device_id = dinfo and dinfo.device_id or "",
                error_code = ra_error_code,
                error_msg = ra_error_msg,
                init_error_code = tostring(dinfo and dinfo.init_result and dinfo.init_result.error_code or "0"),
                init_error_msg = tostring(dinfo and dinfo.init_result and dinfo.init_result.error_msg or "0")
              }
              log_mgr.warn({}, TAG, "push_bind_player_fail", log_params, {})
              ESTAT.stat_action("push", "bind_player", false, log_params)
            end)
          end
        end)
        PUSH_LAST_PLAYER_ID:set(player_id)
        PUSH_LAST_PLAYER_ID_TIME:set(E.time())
        local log_params = {
          player_id = tostring(player_id),
          last_player_id = tostring(last_player_id),
          last_player_id_time = tostring(last_player_id_time),
          cause = "bind_player_succ"
        }
        log_mgr.debug({}, TAG, "push", "bind_player", log_params, {})
      else
        PUSH_LAST_PLAYER_ID:set("")
        PUSH_LAST_PLAYER_ID_TIME:set(0)
        M.remove_alias(nil)
        local log_params = {
          player_id = tostring(player_id),
          last_player_id = tostring(last_player_id),
          last_player_id_time = tostring(last_player_id_time),
          cause = "server_collect_fail"
        }
        log_mgr.warn({}, TAG, "push_bind_player_fail", log_params, {})
        ESTAT.stat_action("push", "bind_player", false, log_params)
      end
    end)
  end
  
  local log_params_start = {
    player_id = tostring(player_id),
    last_player_id = tostring(last_player_id),
    last_player_id_time = tostring(last_player_id_time),
    cause = "bind_player_start"
  }
  log_mgr.debug({}, TAG, "push", "bind_player", log_params_start, {})
  if is_bind_use_cache then
    bind_player_use_cache_flag(player_id, bind_player_id_alias_func)
  else
    M.remove_alias(nil, function(succ, ...)
      if succ then
        PUSH_LAST_PLAYER_ID:set("")
        PUSH_LAST_PLAYER_ID_TIME:set(0)
        bind_player_id_alias_func()
      else
        local _code, info_body = ...
        M.get_device_info_async(function(dinfo)
          local ra_error_code = "0"
          local ra_error_msg = ""
          if info_body and type(info_body) == "table" then
            ra_error_code = tostring(info_body and info_body.error_code or "0")
            ra_error_msg = tostring(info_body and info_body.error_msg or "")
          end
          local log_params = {
            player_id = tostring(player_id),
            last_player_id = tostring(last_player_id),
            last_player_id_time = tostring(last_player_id_time),
            cause = "remove_alias_fail",
            push_device_id = dinfo and dinfo.device_id or "",
            error_code = ra_error_code,
            error_msg = ra_error_msg,
            init_error_code = tostring(dinfo and dinfo.init_result and dinfo.init_result.error_code or "0"),
            init_error_msg = tostring(dinfo and dinfo.init_result and dinfo.init_result.error_msg or "0")
          }
          log_mgr.warn({}, TAG, "push_bind_player_fail", log_params, {})
          ESTAT.stat_action("push", "bind_player", false, log_params)
        end)
      end
    end)
  end
end

function M.bind_server_id(server_id)
  local last_account = PUSH_LAST_ACCOUNT_ID:get()
  local user_info = EG.user_info()
  local account = user_info.uid
  log_mgr.debug({}, TAG, "push_bind_server_start", "bind_server", {last_account = last_account, account = account}, {})
  if last_account ~= account then
    log_mgr.warn({}, TAG, "push_bind_server_fail", {
      last_account = last_account,
      account = account,
      cause = "current_account_bind_fail"
    }, {})
    return
  end
  local last_server_id = PUSH_LAST_SERVER_ID:get()
  
  local function bind_server_id_tag()
    local server_tag = "server:" .. server_id
    M.bind_tag(M.ACCOUNT_TARGET, {server_tag}, nil, function(succ)
      if succ then
        log_mgr.debug({}, TAG, "push_bind_server_succ", "bind_server", {server_tag = server_tag}, {})
        PUSH_LAST_SERVER_ID:set(server_id)
      else
        log_mgr.warn({}, TAG, "push_bind_server_fail", {
          server_tag = server_tag,
          cause = "bind_tag_fail"
        }, {})
        PUSH_LAST_SERVER_ID:set("")
      end
    end)
  end
  
  log_mgr.debug({}, TAG, "push_check_server_id", "bind_server", {server_id = server_id, last_server_id = last_server_id}, {})
  if nil == last_server_id or 0 == #last_server_id then
    bind_server_id_tag()
  elseif last_server_id ~= server_id then
    local last_server_tag = "server:" .. last_server_id
    M.unbind_tag(M.ACCOUNT_TARGET, {last_server_tag}, nil, function(succ)
      if succ then
        PUSH_LAST_SERVER_ID:set("")
        bind_server_id_tag()
      else
        log_mgr.warn({}, TAG, "push_bind_server_fail", {
          last_server_tag = last_server_tag,
          cause = "unbind_tag_fail"
        }, {})
      end
    end)
  else
    log_mgr.debug({}, TAG, "push_bind_server_succ_already", "bind_server", {server_id = server_id, last_server_id = last_server_id}, {})
  end
end

function M.bind_server_id_on_device(server_id)
  if not server_id or type(server_id) ~= "string" or 0 == #server_id then
    return
  end
  local last_server_id = PUSH_LAST_SERVER_ID_ON_DEVICE:get()
  local server_tag = "server:" .. tostring(server_id)
  
  local function bind_server_id_tag()
    M.bind_tag(M.DEVICE_TARGET, {server_tag}, nil, function(succ)
      if succ then
        log_mgr.debug({}, TAG, "push_bind_server_succ", "bind_server_on_device", {server_tag = server_tag}, {})
        PUSH_LAST_SERVER_ID_ON_DEVICE:set(server_id)
      else
        log_mgr.warn({}, TAG, "push_bind_server_fail_on_device", {
          server_tag = server_tag,
          cause = "bind_tag_fail"
        }, {})
      end
    end)
  end
  
  log_mgr.debug({}, TAG, "push_check_server_id", "bind_server_on_device", {server_id = server_id, last_server_id = last_server_id}, {})
  if last_server_id ~= server_id then
    local unbind_tag_list = {}
    local last_server_tag
    if last_server_id and #last_server_id > 0 then
      last_server_tag = "server:" .. tostring(last_server_id)
      table.insert(unbind_tag_list, last_server_tag)
    end
    M.get_tag_list(function(get_tag_list_succ, ret_tag_list)
      if get_tag_list_succ then
        local push_ret_tag_list = ret_tag_list
        if push_ret_tag_list then
          for _, v in pairs(push_ret_tag_list) do
            if E.Utils.start_with(v, "server:") and v ~= server_tag and v ~= last_server_tag then
              table.insert(unbind_tag_list, v)
            end
          end
        end
      end
      if unbind_tag_list and #unbind_tag_list > 0 then
        M.unbind_tag(M.DEVICE_TARGET, unbind_tag_list, nil, function(unbind_tag_succ)
          if unbind_tag_succ then
            PUSH_LAST_SERVER_ID_ON_DEVICE:set("")
            bind_server_id_tag()
          else
            log_mgr.warn({}, TAG, "push_bind_server_fail_on_device", {
              last_server_tag = last_server_tag,
              cause = "unbind_tag_fail"
            }, {})
          end
        end)
      else
        bind_server_id_tag()
      end
    end)
  else
    log_mgr.debug({}, TAG, "push_bind_server_succ_already", "bind_server_on_device", {
      server_id = server_id,
      last_server_id = tostring(last_server_id)
    }, {})
  end
end

local function clear_push_data_for_last_account()
  local last_account = PUSH_LAST_ACCOUNT_ID:get()
  if last_account and #last_account > 0 then
    PUSH_LAST_ACCOUNT_ID:set("")
    PUSH_LAST_ACCOUNT_ID_TIME:set(0)
    M.unbind_account(last_account, function(succ, ...)
      E.LOG.debug(TAG, "aliyun logout unbind account: " .. tostring(last_account) .. ", result:" .. tostring(succ))
      if not succ then
        local error_code, error_msg = ...
        E.LOG.debug(TAG, "error code: " .. tostring(error_code) .. ", error msg: " .. tostring(error_msg))
      end
    end)
  end
end

local function clear_push_data_for_last_player_id()
  local last_player_id = PUSH_LAST_PLAYER_ID:get()
  if last_player_id and #last_player_id > 0 then
    PUSH_LAST_PLAYER_ID:set("")
    PUSH_LAST_PLAYER_ID_TIME:set(0)
    M.remove_alias(nil, function(succ, ...)
      E.LOG.debug(TAG, "aliyun logout unbind player_id: " .. tostring(last_player_id) .. ", result: " .. tostring(succ))
      if not succ then
        local error_code, error_msg = ...
        E.LOG.debug(TAG, "error code: " .. tostring(error_code) .. ", error msg: " .. tostring(error_msg))
      end
    end)
  end
end

local function clear_push_data_for_last_server_id_on_device()
  local last_server_id_on_device = PUSH_LAST_SERVER_ID_ON_DEVICE:get()
  if last_server_id_on_device and #last_server_id_on_device > 0 then
    local last_server_tag = "server:" .. last_server_id_on_device
    M.unbind_tag(M.DEVICE_TARGET, {last_server_tag}, nil, function(succ, ...)
      E.LOG.debug(TAG, "aliyun logout unbind server_id on device: " .. tostring(last_server_id_on_device) .. ", result: " .. tostring(succ))
      if succ then
        PUSH_LAST_SERVER_ID_ON_DEVICE:set("")
      else
        local error_code, error_msg = ...
        E.LOG.debug(TAG, "error code: " .. tostring(error_code) .. ", error msg: " .. tostring(error_msg))
      end
    end)
  end
end

function M.clear_push_data_on_player_offline()
  clear_push_data_for_last_player_id()
  clear_push_data_for_last_server_id_on_device()
end

function M.clear_push_data()
  clear_push_data_for_last_account()
  clear_push_data_for_last_player_id()
  clear_push_data_for_last_server_id_on_device()
end

local function callback(push_handler_name, ...)
  if push_handlers then
    local push_handler = push_handlers[push_handler_name]
    if push_handler then
      push_handler(...)
    end
  end
end

local function open_community_page(notification_body)
  local is_community_notification = false
  local biz_data
  if not notification_body.ext or not notification_body.ext.platform_payload then
    return
  end
  local platform_payload = notification_body.ext.platform_payload
  if type(platform_payload) == "string" then
    E.LOG.d(TAG, "platform_payload data type is string")
    platform_payload = JSON.safe_decode(platform_payload)
  end
  if type(platform_payload) ~= "table" then
    return
  end
  if platform_payload.biz_data and platform_payload.biz_data.platform then
    local ESW = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
    if ESW.Type.Community == platform_payload.biz_data.platform then
      is_community_notification = true
      biz_data = platform_payload.biz_data
    end
  end
  if not is_community_notification then
    return false
  end
  local ESW = require("ejoysdk_lua.shortcut.ejoysdk_shortcut_webview")
  local sc_params = ESW.get_config_from_cc_h5res("community")
  if not sc_params then
    return false
  end
  if sc_params.disable_notification_open ~= nil and sc_params.disable_notification_open == true then
    return false
  end
  local HOLO = require("ejoysdk_lua.ejoysdk_holo")
  if not HOLO.get_player_token() then
    E.LOG.d(TAG, "player not login, not launch community")
    return false
  end
  local params = {
    local_params = {from_source = "community"}
  }
  if biz_data and type(biz_data) == "table" and nil ~= next(biz_data) then
    params.from_source_data = {}
    params.from_source_data.biz_data = biz_data
  end
  ECO.notification_open(params)
  return true
end

local EVT_HANDLERS = {}
EVT_HANDLERS[EVT_ON_SERVER_MESSAGE] = function(body)
  callback(push_event.ON_SERVER_MESSAGE, body.title, body.content, body.ext or {})
end
EVT_HANDLERS[EVT_ON_SERVER_NOTIFICATION] = function(body)
  callback(push_event.ON_SERVER_NOTIFICATION, body.title, body.content, body.ext or {})
  ESTAT.stat_action("push", "receive_notification", true, {})
end
EVT_HANDLERS[EVT_ON_SERVER_NOTIFICATION_OPEN] = function(body)
  callback(push_event.ON_SERVER_NOTIFICATION_OPEN, body.title, body.content, body.ext or {})
  E.LOG.debug("url_open", "[v2]receive aliyun:" .. JSON.encode(body))
  local notification_body = body or {}
  ET.publish("urlopen_v2", "notification", notification_body)
  open_community_page(notification_body)
  local launch_time = E.Sysinfo.launch_time() / 1000
  ESTAT.stat_action("push", "open_notification", launch_time, notification_body)
end
EVT_HANDLERS[EVT_ON_SERVER_NOTIFICATION_RECEIVED_INAPP] = function(body)
  callback(push_event.ON_SERVER_NOTIFICATION_IN_APP, body.title, body.content, body.ext or {})
  ESTAT.stat_action("push", "receive_notification_inapp", true, {})
end
EVT_HANDLERS[EVT_ON_LOCAL_NOTIFICATION] = function(body)
  callback(push_event.ON_LOCAL_NOTIFICATION, body.title, body.content, body.ext or {})
end
EVT_HANDLERS[EVT_ON_LOCAL_NOTIFICATION_OPEN] = function(body)
  callback(push_event.ON_LOCAL_NOTIFICATION_OPEN, body.title, body.content, body.ext or {})
end
EVT_HANDLERS[EVT_ON_LOCAL_NOTIFICATION_RECEIVE_INAPP] = function(body)
  callback(push_event.ON_LOCAL_NOTIFICATION_IN_APP, body.title, body.content, body.ext or {})
end

local function bind_static_topic()
  local bind_tag_list = {}
  local unbind_tag_list = {}
  local filter_tag_map = {}
  local package_name = E.Sysinfo.package_name()
  local package_name_topic = "package_name:" .. tostring(package_name)
  local os_name = _ejoysdk.os()
  local os_topic = "os:" .. tostring(os_name)
  local ejoy = require("ejoysdk_lua.ejoysdk")
  local ejoysdk_version = ejoy.get_sdk_version_name("EJOYSDK")
  E.LOG.debug(TAG, "bind_package_name_topic, package_name: " .. tostring(package_name) .. ", bind_os_topic, os: " .. tostring(os_name))
  table.insert(bind_tag_list, package_name_topic)
  table.insert(bind_tag_list, os_topic)
  if ejoysdk_version then
    local last_sdk_version = PUSH_LAST_SDK_VERSION:get()
    if last_sdk_version and #last_sdk_version > 0 and last_sdk_version ~= ejoysdk_version then
      local last_sdk_version_topic = "sdk_version:" .. last_sdk_version
      table.insert(unbind_tag_list, last_sdk_version_topic)
      filter_tag_map[last_sdk_version_topic] = true
    end
    E.LOG.debug(TAG, "bind_sdk_version_topic, sdk_version: " .. tostring(ejoysdk_version))
    local sdk_version_topic = "sdk_version:" .. ejoysdk_version
    table.insert(bind_tag_list, sdk_version_topic)
    filter_tag_map[sdk_version_topic] = true
  end
  local product = get_product_env()
  if product and #product > 0 then
    local last_platform = PUSH_LAST_PLATFORM:get()
    if last_platform and #last_platform > 0 and last_platform ~= product then
      local last_sdk_product_topic = "platform:" .. last_platform
      table.insert(unbind_tag_list, last_sdk_product_topic)
      filter_tag_map[last_sdk_product_topic] = true
    end
    local sdk_product_topic = "platform:" .. product
    table.insert(bind_tag_list, sdk_product_topic)
    filter_tag_map[sdk_product_topic] = true
  end
  M.get_tag_list(function(get_tag_list_succ, ret_tag_list)
    if get_tag_list_succ then
      local push_ret_tag_list = ret_tag_list
      if push_ret_tag_list then
        for _, v in pairs(push_ret_tag_list) do
          if (E.Utils.start_with(v, "platform:") or E.Utils.start_with(v, "sdk_version:")) and nil == filter_tag_map[v] then
            table.insert(unbind_tag_list, v)
          end
        end
      end
    end
    if unbind_tag_list and #unbind_tag_list > 0 then
      M.unbind_tag(M.DEVICE_TARGET, unbind_tag_list, nil, function(unbind_tag_succ)
        if unbind_tag_succ then
          E.LOG.debug(TAG, "unbind bind_static_topic success!")
        else
          E.LOG.debug(TAG, "unbind bind_static_topic failed!")
        end
      end)
    end
    
    local function subscrib_cb(subscrib_cb_succ)
      if subscrib_cb_succ then
        if ejoysdk_version then
          PUSH_LAST_SDK_VERSION:set(ejoysdk_version)
        end
        E.LOG.debug(TAG, "bind_static_topic success!")
      else
        E.LOG.debug(TAG, "bind_static_topic failed!")
      end
    end
    
    if bind_tag_list and #bind_tag_list > 0 then
      M.bind_tag(M.DEVICE_TARGET, bind_tag_list, nil, subscrib_cb)
    end
  end)
end

local function bind_frequently_events_topic(event_name)
  if not event_name then
    E.log("bind_frequently_events_topic, event_name is nil")
    return
  end
  E.log("bind_frequently_events_topic, event_name: " .. tostring(event_name))
  local old_event_name = get_value_from_topic_store(event_name)
  if old_event_name then
    E.log("already bind this event_name before, can only bind once, event_name = " .. tostring(event_name))
    if M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER == event_name then
      local last_event_topic = "frequently_events:" .. M.FREQUENTLY_EVENTS.ACTIVE
      M.unbind_tag(M.DEVICE_TARGET, {last_event_topic}, nil, function(_succ)
      end)
    elseif M.FREQUENTLY_EVENTS.PLAYER_CREATE == event_name then
      local last_event_topic1 = "frequently_events:" .. M.FREQUENTLY_EVENTS.ACTIVE
      local last_event_topic2 = "frequently_events:" .. M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER
      M.unbind_tag(M.DEVICE_TARGET, {last_event_topic1, last_event_topic2}, nil, function(_succ)
      end)
    end
    return
  end
  
  local function subscrib_frequently_events_cb(succ)
    if succ then
      set_value_to_topic_store(event_name, event_name)
      E.log("bind frequently_events_topic success, event_name = " .. tostring(event_name))
    else
      E.log("bind frequently_events_topic failed, event_name = " .. tostring(event_name))
    end
  end
  
  local event_topic = "frequently_events:" .. event_name
  if M.FREQUENTLY_EVENTS.ACTIVE == event_name then
    M.bind_tag(M.DEVICE_TARGET, {event_topic}, nil, subscrib_frequently_events_cb)
  elseif M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER == event_name then
    local last_region_topic = "frequently_events:" .. M.FREQUENTLY_EVENTS.ACTIVE
    M.unbind_tag(M.DEVICE_TARGET, {last_region_topic}, nil, function(_succ)
    end)
    M.bind_tag(M.DEVICE_TARGET, {event_topic}, nil, subscrib_frequently_events_cb)
  elseif M.FREQUENTLY_EVENTS.PLAYER_CREATE == event_name then
    local last_event_topic1 = "frequently_events:" .. M.FREQUENTLY_EVENTS.ACTIVE
    local last_event_topic2 = "frequently_events:" .. M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER
    M.unbind_tag(M.DEVICE_TARGET, {last_event_topic1, last_event_topic2}, nil, function(_succ)
    end)
    M.bind_tag(M.DEVICE_TARGET, {event_topic}, nil, subscrib_frequently_events_cb)
  end
end

local function _check_custom_tag_parmas(type, tag, cb)
  if not type or not tag then
    cb(false, PUSH_ERROR_CORE.PUSH_ERROR_PARAMS, "type or tag should not be nil")
    return false
  end
  if #type > TYPE_LEN_LIMIT or #tag > TYPE_TAG_LIMIT then
    cb(false, PUSH_ERROR_CORE.PUSH_ERROR_PARAMS, "the length is not supported.(need: #type <= 40 and #tag <= 80)")
    return false
  end
  return true
end

function M.bind_custom_tag(type, tag, cb)
  if not _check_custom_tag_parmas(type, tag, cb) then
    return
  end
  local custom_topic = tostring(type) .. ":" .. tostring(tag)
  local tag_params = {key = type, value = tag}
  push_post("check_tags", {
    tag_list = {tag_params}
  }, function(succ, ...)
    if succ then
      M.bind_tag(M.DEVICE_TARGET, {custom_topic}, nil, function(succ_topic)
        if succ_topic then
          E.LOG.debug(TAG, "bind custom_tag success, tag = " .. tostring(custom_topic))
          cb(true, tostring(custom_topic))
        else
          E.LOG.debug(TAG, "bind custom_tag fail, tag = " .. tostring(custom_topic))
          cb(false, PUSH_ERROR_CORE.PUSH_BIND_FAIL, "bind custom_tag fail, tag = " .. tostring(custom_topic))
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
  local custom_topic = tostring(type) .. ":" .. tostring(tag)
  M.unbind_tag(M.DEVICE_TARGET, {custom_topic}, nil, function(succ)
    if succ then
      E.LOG.debug(TAG, "unbind custom_tag success, tag = " .. tostring(custom_topic))
      cb(true, tostring(custom_topic))
    else
      E.LOG.debug(TAG, "unbind custom_tag fail, tag = " .. tostring(custom_topic))
      cb(false, PUSH_ERROR_CORE.PUSH_BIND_FAIL, "unbind custom_tag fail, tag = " .. tostring(custom_topic))
    end
  end)
end

local function register_handler()
  bind_frequently_events_topic(M.FREQUENTLY_EVENTS.ACCOUNTID_REGISTER)
end

local function get_player_info_handler(_player_info)
  bind_frequently_events_topic(M.FREQUENTLY_EVENTS.PLAYER_CREATE)
end

local function get_player_token_handler()
  local player_info = EG.player_info()
  if not player_info or player_info and player_info.is_valid == false then
    E.LOG.debug(TAG, "player_info = nil or player_info.is_valid = false, ignore bind player")
    return
  end
  M.bind_player_id(player_info.player_id)
  M.bind_server_id_on_device(player_info.server_id)
end

local function acquire_succ_handler()
  local user_info = EG.user_info()
  M.bind_account(user_info.uid)
end

local function do_init()
  log_mgr.debug({}, TAG, "push_init_finish", "push_init_finish", {}, {})
  ET.unsubscribe(ET.push.INITED, do_init)
  local ejoysdk_push = require("ejoysdk_lua.push.ejoysdk_push")
  ejoysdk_push.set_push_vendor(M)
  if _ejoysdk.os() == "harmonyos" then
    local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
    local _pusher = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_push")
    _pusher.set_event_callback(EVT_HANDLERS)
  else
    UNI.register_event_cb(VENDOR_NAME, function(type, body)
      local handler = EVT_HANDLERS[type]
      if handler then
        handler(body)
      end
    end)
    UNI.cast(VENDOR_NAME, CAST_LUA_INIT_FINISH, {})
  end
  local entered_game = SAVE_ENTER_GAME_TAG:get()
  if "true" ~= entered_game then
    M.bind_tag(M.DEVICE_TARGET, {
      "user:not_logined"
    }, nil, function()
    end)
  end
end

local function enter_tag_handler(...)
  local entered_game = SAVE_ENTER_GAME_TAG:get()
  if "true" ~= entered_game then
    M.unbind_tag(M.DEVICE_TARGET, {
      "user:not_logined"
    }, nil, function()
      M.bind_tag(M.DEVICE_TARGET, {
        "user:logined"
      }, nil, function()
        SAVE_ENTER_GAME_TAG:set("true")
      end)
    end)
  end
end

function M.init(_opt, cb)
  E.LOG.tips(TAG, "If you get a push error")
  log_mgr.call_api({}, TAG, "init", log_mgr.LOG_LEVEL.HIGH, {}, _opt, cb)
  local ejoysdk_push = require("ejoysdk_lua.push.ejoysdk_push")
  if ejoysdk_push.inited then
    do_init()
  else
    ET.subscribe(ET.push.INITED, do_init)
  end
  is_bind_use_cache = is_bind_use_cache_from_cc()
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, get_player_token_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, M.clear_push_data_on_player_offline)
  ET.subscribe(ET.gangplank.ACQUIRE, acquire_succ_handler)
  ET.subscribe(ET.gangplank.LOGIN, enter_tag_handler)
  ET.subscribe(ET.gangplank.LOGOUT, M.clear_push_data)
  ET.subscribe(ET.analytics.REGISTER, register_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, get_player_info_handler)
  bind_static_topic()
  bind_frequently_events_topic(M.FREQUENTLY_EVENTS.ACTIVE)
  cb(true)
end

M:is_implemented({"PUSH"})
return M
