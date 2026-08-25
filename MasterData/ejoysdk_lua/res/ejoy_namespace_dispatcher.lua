local EL = require("ejoysdk_lua.res.ejoy_res_log")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local RS = require("ejoysdk_lua.res.res_stat")
local TAG = "ejoy_namespace_dispatcher"
local M = {}
M.NAMESPACE_UPDATE_OPTIONS = {
  RES_SAVE_BASE_PATH = "res_save_base_path",
  RES_SAVE_STORAGE_TYPE = "res_save_storage_type",
  RES_REAL_SAVE_STORAGE_TYPE = "res_real_save_storage_type",
  FOREGROUND_NOTIFICATION_ENABLED = "foreground_notification_enabled",
  PROGRESS_UPDATE_INTERVAL_SEC = "progress_update_interval_sec",
  ACCEPT_ALL_RES_IN_NAMESPACE = "accept_all_res_in_namespace",
  MAX_RETRY_TIMES = "max_retry_times",
  USING_CC_CACHE_DATA = "using_cc_cache_data",
  FORCE_CHECK_UPDATE = "force_check_update",
  FOREGROUND_NOTIFICATION_CUSTOM_CONFIG = "foreground_notification_custom_config",
  FORCE_INTEGRITY_CHECK = "force_integrity_check",
  DOWNLOAD_NOTIF_STYLE = "default_progress_style",
  DOWNLOAD_PRIORITY = "priority",
  DOWNLOAD_SUB_PRIORITY = "sub_priority",
  DOWNLOAD_MAX_BAND_PER_SEC = "max_band_width_kbytes_per_sec",
  DOWNLOAD_NETWORK_STRATEGY = "network_strategy",
  PKG_RES_VERSION = "pkg_res_version",
  RES_VERSION = "version",
  INTEGRITY_CHECK_UPDATES = "integrity_check_update"
}
M.STARTUP_UPDATE_OPTIONS = {
  ACCEPT_ALL_RES_IN_NAMESPACE = M.NAMESPACE_UPDATE_OPTIONS.ACCEPT_ALL_RES_IN_NAMESPACE,
  MAX_RETRY_TIMES = M.NAMESPACE_UPDATE_OPTIONS.MAX_RETRY_TIMES,
  FORCE_CHECK_UPDATE = M.NAMESPACE_UPDATE_OPTIONS.FORCE_CHECK_UPDATE,
  FOREGROUND_NOTIFICATION_ENABLED = M.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED
}
M.NAMESPACE_RES_UPDATE_OPTIONS = {
  RES_SAVE_BASE_PATH = M.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_BASE_PATH,
  RES_SAVE_STORAGE_TYPE = M.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE,
  FOREGROUND_NOTIFICATION_ENABLED = M.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED
}
M.STARTUP_UPDATE_STATES = SC.PUB_STARTUP_STATES
M.STARTUP_CONFIG_KEY = {
  PRODUCT_CODE = "product_code",
  CONFIG = "config",
  CURRENT_PRODUCT_CODE = "current_product_code",
  IS_REVIEW = "is_review",
  COMMON_STARTUP_DATA = "common_startup_data",
  REVIEW_STARTUP_DATA = "review_startup_data"
}
local DEFAULT_PROGRESS_UPDATE_INTERVAL_SEC = 1
local RES_KEY_ANY = "any"
local namespace_handler_map = {}
local startup_complete_listeners = {}
local splitpkg_complete_listeners = {}
local startup_config_listeners = {}
local on_show_app_update_ui_listener, on_game_exit_listener

function M.register_startup_update_complete_listener(_listener)
  for _, listener in ipairs(startup_complete_listeners) do
    if listener == _listener then
      return
    end
  end
  local len = #startup_complete_listeners
  startup_complete_listeners[len + 1] = _listener
end

function M.unregister_startup_update_complete_listener(_listener)
  local new = {}
  for _, listener in ipairs(startup_complete_listeners) do
    if _listener ~= listener then
      new[#new + 1] = listener
    end
  end
  startup_complete_listeners = new
end

function M.register_splitpkg_update_complete_listener(_listener)
  for _, listener in ipairs(splitpkg_complete_listeners) do
    if listener == _listener then
      return
    end
  end
  local len = #splitpkg_complete_listeners
  splitpkg_complete_listeners[len + 1] = _listener
end

function M.unregister_splitpkg_update_complete_listener(_listener)
  local new = {}
  for _, listener in ipairs(splitpkg_complete_listeners) do
    if _listener ~= listener then
      new[#new + 1] = listener
    end
  end
  splitpkg_complete_listeners = new
end

function M.register_res_update_namespace(namespace, res_key, _listeners, opts, engine_handler)
  opts = opts or {}
  local is_v2_facade = opts.is_v2_facade or false
  EL.LOG.debug(TAG, "is_v2_facade: " .. tostring(is_v2_facade))
  if not res_key or opts[M.NAMESPACE_UPDATE_OPTIONS.ACCEPT_ALL_RES_IN_NAMESPACE] then
    EL.LOG.debug(TAG, "register_res_update_namespace:" .. tostring(namespace) .. ", with accept all res_key")
    res_key = RES_KEY_ANY
  end
  namespace_handler_map[namespace] = namespace_handler_map[namespace] or {}
  local res_handler = namespace_handler_map[namespace][res_key] or {}
  namespace_handler_map[namespace][res_key] = res_handler
  res_handler[M.NAMESPACE_UPDATE_OPTIONS.PROGRESS_UPDATE_INTERVAL_SEC] = opts and opts[M.NAMESPACE_UPDATE_OPTIONS.PROGRESS_UPDATE_INTERVAL_SEC] or DEFAULT_PROGRESS_UPDATE_INTERVAL_SEC
  res_handler[M.NAMESPACE_UPDATE_OPTIONS.ACCEPT_ALL_RES_IN_NAMESPACE] = opts and opts[M.NAMESPACE_UPDATE_OPTIONS.ACCEPT_ALL_RES_IN_NAMESPACE] or false
  res_handler.listeners = _listeners
  if _listeners and not is_v2_facade then
    if _listeners.on_cache_res_incompatible then
      EL.LOG.debug(TAG, "on_cache_res_incompatible override:" .. tostring(_listeners.on_cache_res_incompatible))
      res_handler.on_cache_res_incompatible = _listeners.on_cache_res_incompatible
    end
    if _listeners.on_request_file_list then
      EL.LOG.debug(TAG, "on_request_file_list override:" .. tostring(_listeners.on_request_file_list))
      res_handler.on_request_file_list = _listeners.on_request_file_list
    end
    if _listeners.on_receive_res_update_confirm then
      EL.LOG.debug(TAG, "on_receive_res_update_confirm override:" .. tostring(_listeners.on_receive_res_update_confirm))
      res_handler.on_receive_res_update_confirm = _listeners.on_receive_res_update_confirm
    end
    if _listeners.on_request_res_version then
      EL.LOG.debug(TAG, "on_request_res_version override:" .. tostring(_listeners.on_request_res_version))
      res_handler.on_request_res_version = _listeners.on_request_res_version
    end
    if _listeners.on_res_complete_apply then
      EL.LOG.debug(TAG, "on_res_complete_apply override:" .. tostring(_listeners.on_res_complete_apply))
      res_handler.on_res_complete_apply = _listeners.on_res_complete_apply
    end
    if _listeners.on_res_valid_check then
      EL.LOG.debug(TAG, "on_res_valid_check override:" .. tostring(_listeners.on_res_valid_check))
      res_handler.on_res_valid_check = _listeners.on_res_valid_check
    end
    if _listeners.on_res_pre_apply then
      EL.LOG.debug(TAG, "on_res_pre_apply override:" .. tostring(_listeners.on_res_pre_apply))
      res_handler.on_res_pre_apply = _listeners.on_res_pre_apply
    end
    if _listeners.on_res_repair then
      EL.LOG.debug(TAG, "on_res_repair override:" .. tostring(_listeners.on_res_repair))
      res_handler.on_res_repair = _listeners.on_res_repair
    end
    if _listeners.on_res_failed_retry_listener then
      EL.LOG.debug(TAG, "on_res_failed_retry_listener override:" .. tostring(_listeners.on_res_failed_retry_listener))
      res_handler.on_res_failed_retry_listener = _listeners.on_res_failed_retry_listener
    end
    EL.LOG.debug(TAG, "register_res_update_namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
    if _listeners.on_res_state_change_listener then
      res_handler.state_listeners = res_handler.state_listeners or {}
      local exists = false
      for _, listener in ipairs(res_handler.state_listeners) do
        if listener == _listeners.on_res_state_change_listener then
          exists = true
          break
        end
      end
      if not exists then
        local len = #res_handler.state_listeners
        res_handler.state_listeners[len + 1] = _listeners.on_res_state_change_listener
      end
    end
    if _listeners.on_res_progress_change_listener then
      res_handler.progress_listeners = res_handler.progress_listeners or {}
      local exists = false
      for _, listener in ipairs(res_handler.progress_listeners) do
        if listener == _listeners.on_res_progress_change_listener then
          exists = true
          break
        end
      end
      if not exists then
        local len = #res_handler.progress_listeners
        res_handler.progress_listeners[len + 1] = _listeners.on_res_progress_change_listener
      end
    end
    M.register_startup_listeners(_listeners)
  end
  if _listeners and is_v2_facade then
    if _listeners.on_res_valid_check then
      EL.LOG.debug(TAG, "on_res_valid_check override:" .. tostring(_listeners.on_res_valid_check))
      res_handler.on_res_valid_check_v2 = _listeners.on_res_valid_check
    end
    if _listeners.on_res_repair then
      EL.LOG.debug(TAG, "on_repair override:" .. tostring(_listeners.on_res_repair))
      res_handler.on_res_repair_v2 = _listeners.on_res_repair
    end
    if _listeners.on_res_pre_apply then
      EL.LOG.debug(TAG, "on_res_pre_apply override:" .. tostring(_listeners.on_res_pre_apply))
      res_handler.on_res_pre_apply_v2 = _listeners.on_res_pre_apply
    end
    if _listeners.on_confirm_res_update then
      EL.LOG.debug(TAG, "on_confirm_res_update override:" .. tostring(_listeners.on_confirm_res_update))
      res_handler.on_receive_res_update_confirm_v2 = _listeners.on_confirm_res_update
    end
    if _listeners.on_res_failed_retry_listener then
      EL.LOG.debug(TAG, "on_res_failed_retry_listener override:" .. tostring(_listeners.on_res_failed_retry_listener))
      res_handler.on_res_failed_retry_listener_v2 = _listeners.on_res_failed_retry_listener
    end
    if _listeners.on_request_file_list then
      EL.LOG.debug(TAG, "on_request_file_list override:" .. tostring(_listeners.on_request_file_list))
      res_handler.on_request_file_list_v2 = _listeners.on_request_file_list
    end
    EL.LOG.debug(TAG, "register_res_update_namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
    if _listeners.on_res_download_progress_change_listener then
      local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
      res_handler.download_state = RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN
      res_handler.download_progress_info = {
        [RTM.PROGRESS_INFO_KEY.PERCENT] = 0,
        [RTM.PROGRESS_INFO_KEY.TOTAL_SIZE] = 0,
        [RTM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = 0,
        [RTM.PROGRESS_INFO_KEY.FINISH_COUNT] = 0,
        [RTM.PROGRESS_INFO_KEY.TOTAL_COUNT] = 0,
        [RTM.PROGRESS_INFO_KEY.SPEED] = 0
      }
      
      function res_handler.progress_listener_v2(progress_info)
        res_handler.download_progress_info = progress_info
        _listeners.on_res_download_progress_change_listener(res_handler.download_state, res_handler.download_progress_info)
      end
      
      function res_handler.state_listener_v2(state, _state_obj)
        res_handler.download_state = state
        _listeners.on_res_download_progress_change_listener(res_handler.download_state, res_handler.download_progress_info)
      end
      
      function res_handler.download_progress_listener_v2(state_obj, progress_info)
        local state = state_obj and state_obj[RTM.RES_STATE_INFO_KEY.STATE]
        _listeners.on_res_download_progress_change_listener(state, progress_info)
      end
    end
    if _listeners.on_group_res_update_complete then
      EL.LOG.debug(TAG, "on_group_res_update_complete override: " .. tostring(_listeners.on_group_res_update_complete))
      res_handler.on_group_res_update_complete = _listeners.on_group_res_update_complete
    end
    if _listeners.on_res_apply_progress_change_listener then
      EL.LOG.debug(TAG, "on_res_apply_progress_change_listener override: " .. tostring(_listeners.on_res_apply_progress_change_listener))
      res_handler.on_res_apply_progress_change_listener = _listeners.on_res_apply_progress_change_listener
    end
    if _listeners.on_confirm_res_apply then
      EL.LOG.debug(TAG, "on_confirm_res_apply override:" .. tostring(_listeners.on_confirm_res_apply))
      res_handler.on_confirm_res_apply = _listeners.on_confirm_res_apply
    end
    if _listeners.on_confirm_res_patch then
      EL.LOG.debug(TAG, "on_confirm_res_patch override:" .. tostring(_listeners.on_confirm_res_patch))
      res_handler.on_confirm_res_patch = _listeners.on_confirm_res_patch
    end
    M.register_startup_listeners(_listeners)
  end
  if engine_handler and is_v2_facade then
    if engine_handler.on_cache_res_incompatible then
      EL.LOG.debug(TAG, "on_cache_res_incompatible override:" .. tostring(engine_handler.on_cache_res_incompatible))
      res_handler.on_cache_res_incompatible_v2 = engine_handler.on_cache_res_incompatible
    end
    if engine_handler.on_request_file_list then
      EL.LOG.debug(TAG, "on_request_file_list override:" .. tostring(engine_handler.on_request_file_list))
      if res_handler.on_request_file_list_v2 then
        EL.LOG.debug(TAG, "game has set on_request_file_list, engine_handler's on_request_file_list override skip")
      else
        res_handler.on_request_file_list_v2 = engine_handler.on_request_file_list
      end
    end
    if engine_handler.on_process_file_list then
      EL.LOG.debug(TAG, "on_process_file_list override:" .. tostring(engine_handler.on_process_file_list))
      res_handler.on_process_file_list_v2 = engine_handler.on_process_file_list
    end
    if engine_handler.on_origin_res_apply then
      EL.LOG.debug(TAG, "on_origin_res_apply override:" .. tostring(engine_handler.on_origin_res_apply))
      res_handler.on_origin_res_apply_v2 = engine_handler.on_origin_res_apply
    end
    if engine_handler.on_res_apply then
      EL.LOG.debug(TAG, "on_res_complete_apply override:" .. tostring(engine_handler.on_res_apply))
      res_handler.on_res_complete_apply_v2 = engine_handler.on_res_apply
    end
  end
end

function M.register_startup_listeners(_listeners)
  if _listeners.on_startup_config_changed then
    local _listener = _listeners.on_startup_config_changed
    local already_registered = false
    for _, listener in ipairs(startup_config_listeners) do
      if listener == _listener then
        already_registered = true
        break
      end
    end
    if not already_registered then
      local len = #startup_config_listeners
      startup_config_listeners[len + 1] = _listener
    end
  end
  if _listeners.on_startup_update_complete then
    M.register_startup_update_complete_listener(_listeners.on_startup_update_complete)
  end
  if _listeners.on_splitpkg_res_update_complete then
    M.register_splitpkg_update_complete_listener(_listeners.on_splitpkg_res_update_complete)
  end
  if _listeners.on_show_app_update_ui then
    _ejoysdk.log("register_app_update_ui_listener begin")
    on_show_app_update_ui_listener = _listeners.on_show_app_update_ui
  end
  if _listeners.on_game_exit then
    on_game_exit_listener = _listeners.on_game_exit
  end
end

function M.unregister_startup_listeners(_listeners)
  if _listeners.on_startup_config_changed then
    local new = {}
    for _, listener in ipairs(startup_config_listeners) do
      if _listeners.on_startup_config_changed ~= listener then
        new[#new + 1] = listener
      end
    end
    startup_config_listeners = new
  end
  if _listeners.on_startup_update_complete then
    M.unregister_startup_update_complete_listener(_listeners.on_startup_update_complete)
  end
  if _listeners.on_splitpkg_res_update_complete then
    M.unregister_startup_update_complete_listener(_listeners.on_splitpkg_res_update_complete)
  end
end

function M.unregister_app_update_ui_listener()
  _ejoysdk.log("unregister_app_update_ui_listener begin")
  on_show_app_update_ui_listener = nil
end

function M.unregister_app_update_game_exit_listener()
  on_game_exit_listener = nil
end

function M.unregister_res_update_namespace(namespace, res_key, _listeners)
  res_key = res_key or RES_KEY_ANY
  local namespace_obj = namespace_handler_map[namespace]
  if not namespace_obj then
    EL.LOG.debug(TAG, "unregister_res_update_namespace skip, for namespace cache is nil")
    return
  end
  local res_handler = namespace_handler_map[namespace][res_key]
  if not res_handler then
    return
  end
  if not _listeners then
    EL.LOG.debug(TAG, "unregister_res_update_namespace, listeners is nil, so unregister all")
    namespace_handler_map[namespace][res_key] = nil
    return
  end
  if _listeners.on_request_file_list and _listeners.on_request_file_list == res_handler.on_request_file_list then
    EL.LOG.debug(TAG, "unregister on_request_file_list:" .. tostring(_listeners.on_request_file_list))
    res_handler.on_request_file_list = nil
  end
  if _listeners.on_receive_res_update_confirm and _listeners.on_receive_res_update_confirm == res_handler.on_receive_res_update_confirm then
    EL.LOG.debug(TAG, "unregister on_receive_res_update_confirm:" .. tostring(_listeners.on_receive_res_update_confirm))
    res_handler.on_receive_res_update_confirm = nil
  end
  if _listeners.on_request_res_version and _listeners.on_request_res_version == res_handler.on_request_res_version then
    EL.LOG.debug(TAG, "unregister on_request_res_version:" .. tostring(_listeners.on_request_res_version))
    res_handler.on_request_res_version = nil
  end
  if _listeners.on_cache_res_incompatible and _listeners.on_cache_res_incompatible == res_handler.on_cache_res_incompatible then
    EL.LOG.debug(TAG, "unregister on_cache_res_incompatible:" .. tostring(_listeners.on_cache_res_incompatible))
    res_handler.on_cache_res_incompatible = nil
  end
  if _listeners.on_res_complete_apply and _listeners.on_res_complete_apply == res_handler.on_res_complete_apply then
    EL.LOG.debug(TAG, "unregister on_res_complete_apply:" .. tostring(_listeners.on_res_complete_apply))
    res_handler.on_res_complete_apply = nil
  end
  M.unregister_startup_listeners(_listeners)
  if _listeners.on_res_state_change_listener then
    res_handler.state_listeners = res_handler.state_listeners or {}
    local new = {}
    for _, listener in ipairs(res_handler.state_listeners) do
      if _listeners.on_res_state_change_listener ~= listener then
        new[#new + 1] = listener
      end
    end
    res_handler.state_listeners = new
  end
  if _listeners.on_res_progress_change_listener then
    res_handler.progress_listeners = res_handler.progress_listeners or {}
    local new = {}
    for _, listener in ipairs(res_handler.progress_listeners) do
      if _listeners.on_res_progress_change_listener ~= listener then
        new[#new + 1] = listener
      end
    end
    res_handler.progress_listeners = new
  end
end

function M._test_get_namespace_res_handler(namespace, res_key)
  if not namespace_handler_map[namespace] then
    return nil
  end
  return namespace_handler_map[namespace][res_key]
end

function M._test_get_startup_complete_listeners()
  return startup_complete_listeners, startup_config_listeners
end

local function find_res_dispatch_handler(namespace, res_key)
  local namespace_obj = namespace_handler_map[namespace]
  if not namespace_obj then
    return nil
  end
  if res_key then
    local res_handler = namespace_obj[res_key]
    if res_handler then
      return res_handler
    end
  end
  local res_any_handler = namespace_obj[RES_KEY_ANY]
  return res_any_handler
end

function M.dispatch_res_valid_check(namespace, res_key, res_valid_check_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  EL.LOG.debug(TAG, "dispatch_res_valid_check begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", handler:" .. tostring(handler))
  if handler then
    if handler.on_res_valid_check then
      EL.LOG.debug(TAG, "begin dispatch res valid check, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
      handler.on_res_valid_check(namespace, res_key, function(check_result)
        EL.LOG.debug(TAG, string.format("on_res_valid_check result:%s,ns:%s,res_key:%s", tostring(check_result), tostring(namespace), tostring(res_key)))
        res_valid_check_cb(check_result)
      end)
    elseif handler.on_res_valid_check_v2 then
      EL.LOG.debug(TAG, "begin dispatch res valid check, res_key:" .. tostring(res_key))
      handler.on_res_valid_check_v2(function(check_result)
        EL.LOG.debug(TAG, "on_res_valid_check result:" .. tostring(check_result) .. ", res_key:" .. tostring(res_key))
        res_valid_check_cb(check_result)
      end)
    else
      EL.LOG.debug(TAG, "skip res valid check, res_key: " .. tostring(res_key))
      res_valid_check_cb(true)
    end
  else
    res_valid_check_cb(true)
  end
end

function M.dispatch_res_repair(namespace, res_key, group_name)
  local handler = find_res_dispatch_handler(namespace, res_key)
  EL.LOG.debug(TAG, "dispatch_res_repair begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", handler:" .. tostring(handler))
  if handler then
    if handler.on_res_repair then
      EL.LOG.debug(TAG, "begin dispatch res repair, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
      handler.on_res_repair(namespace, res_key, group_name)
    elseif handler.on_res_repair_v2 then
      EL.LOG.debug(TAG, "begin dispatch res repair, res_key:" .. tostring(res_key))
      handler.on_res_repair_v2(group_name)
    end
  end
end

function M.dispatch_res_pre_apply(namespace, res_key, res_location, apply_dest_path, res_state_infos, res_pre_apply_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  EL.LOG.debug(TAG, "dispatch_res_pre_apply begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", handler:" .. tostring(handler))
  if handler then
    if handler.on_res_pre_apply then
      EL.LOG.debug(TAG, "begin dispatch res pre apply event, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
      handler.on_res_pre_apply(namespace, res_key, res_location, apply_dest_path, res_state_infos, function(pre_apply_result, ...)
        EL.LOG.debug(TAG, "on_res_pre_apply result:" .. tostring(pre_apply_result) .. ", ns:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
        res_pre_apply_cb(pre_apply_result, ...)
      end)
    elseif handler.on_res_pre_apply_v2 then
      local ER = require("ejoysdk_lua.res.ejoysdk_res")
      local GRM = require("ejoysdk_lua.res.group_res_manager")
      local is_group = GRM.is_group(res_key)
      local engine_context = {
        download_res_files = function(file_path_list, opts, complete_cb, state_listener, progress_listener)
          local res_version = res_state_infos.res_update_info.version
          ER.download_res_files(namespace, res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
        end,
        get_res_info = function()
          if is_group then
            return nil
          end
          local game_startup_params = SC.get_game_startup_params()
          local res_info = game_startup_params[namespace][res_key]
          return namespace, res_key, res_info
        end,
        is_group = is_group
      }
      EL.LOG.debug(TAG, "begin dispatch res pre apply event, res_key:" .. tostring(res_key))
      handler.on_res_pre_apply_v2(engine_context, res_location, apply_dest_path, res_state_infos, function(pre_apply_result, ...)
        EL.LOG.debug(TAG, "on_res_valid_check result:" .. tostring(pre_apply_result) .. ", res_key:" .. tostring(res_key))
        res_pre_apply_cb(pre_apply_result, ...)
      end)
    else
      EL.LOG.debug(TAG, "skip res pre apply, res_key: " .. tostring(res_key))
      res_pre_apply_cb(true)
    end
  else
    res_pre_apply_cb(true)
  end
end

local confirm_update_result_cache = {}

local function _set_confirm_update_result(namespace, res_key, has_new_update, confirm_download)
  confirm_update_result_cache[namespace] = confirm_update_result_cache[namespace] or {}
  confirm_update_result_cache[namespace][res_key] = {has_new_update = has_new_update, confirm_download = confirm_download}
end

local function _get_confirm_update_result(namespace, res_key)
  local cache = confirm_update_result_cache[namespace] and confirm_update_result_cache[namespace][res_key] or {}
  EL.LOG.debug(TAG, string.format("_get_confirm_update_result, namespace:%s, res_key:%s, has_new_update:%s, confirm_download:%s", namespace, res_key, tostring(cache.has_new_update), tostring(cache.confirm_download)))
  return cache.has_new_update == false or cache.confirm_download == true
end

function M.dispatch_res_update_confirm(namespace, res_key, res_state_info, confirm_download_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  EL.LOG.debug(TAG, "dispatch_res_update_confirm begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", handler:" .. tostring(handler))
  if handler then
    if handler.on_receive_res_update_confirm then
      EL.LOG.debug(TAG, "begin dispatch res update info, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
      handler.on_receive_res_update_confirm(namespace, res_key, res_state_info, function(confirm_download)
        EL.LOG.debug(TAG, "on_receive_res_update_confirm result:" .. tostring(confirm_download) .. ", ns:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
        confirm_download_cb(confirm_download)
      end)
    elseif handler.on_receive_res_update_confirm_v2 then
      EL.LOG.debug(TAG, "begin dispatch res update info, res_key:" .. tostring(res_key))
      res_state_info = res_state_info or {}
      local ER = require("ejoysdk_lua.res.ejoysdk_res")
      local simple_res_state_info = ER.get_simple_res_state(res_state_info)
      handler.on_receive_res_update_confirm_v2(simple_res_state_info, function(confirm_download)
        EL.LOG.debug(TAG, "on_confirm_res_update result:" .. tostring(confirm_download) .. ", res_key:" .. tostring(res_key))
        _set_confirm_update_result(namespace, res_key, simple_res_state_info.has_new_update, confirm_download)
        confirm_download_cb(confirm_download)
      end)
    else
      confirm_download_cb(true)
    end
  else
    EL.LOG.warn(TAG, "skip dispatch res update, no 'on_receive_res_update_confirm' for namespace:" .. tostring(namespace) .. ", with res_key:" .. tostring(res_key))
    confirm_download_cb(false)
  end
end

function M.dispatch_cache_res_incompatible(namespace, res_key, incompatible_data, local_res_state_info, process_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and (handler.on_cache_res_incompatible or handler.on_cache_res_incompatible_v2) then
    if handler.on_cache_res_incompatible then
      handler.on_cache_res_incompatible(namespace, res_key, incompatible_data, local_res_state_info, function(succ, ...)
        if succ then
          EL.LOG.debug(TAG, "on_cache_res_incompatible result succ")
        else
          local code, msg = ...
          EL.LOG.warn(TAG, "on_cache_res_incompatible failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        if process_cb then
          process_cb(succ, ...)
        end
      end)
    end
    if handler.on_cache_res_incompatible_v2 then
      handler.on_cache_res_incompatible_v2(incompatible_data, function(succ, ...)
        if succ then
          EL.LOG.debug(TAG, "on_cache_res_incompatible result succ")
        else
          local code, msg = ...
          EL.LOG.warn(TAG, "on_cache_res_incompatible failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        if process_cb then
          process_cb(succ, ...)
        end
      end)
    end
  else
    EL.LOG.debug(TAG, "no on_cache_res_incompatible now default is succ")
    if process_cb then
      process_cb(true)
    end
  end
end

function M.request_using_res_version(namespace, res_key, cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and handler.on_request_res_version then
    handler.on_request_res_version(namespace, res_key, function(res_ver, ext)
      cb(res_ver, ext)
    end)
    return true
  else
    EL.LOG.debug(TAG, "request_using_res_version No handler with 'on_request_res_version', return nil")
    cb(nil)
    return false
  end
end

function M.request_file_list(namespace, res_key, file_list_cb, ext_info)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and (handler.on_request_file_list or handler.on_request_file_list_v2) then
    EL.LOG.debug(TAG, "request_file_list has handler and 'on_request_file_list', use this method check file list")
    if handler.on_request_file_list then
      handler.on_request_file_list(namespace, res_key, function(succ, ...)
        file_list_cb(succ, ...)
      end, ext_info)
    end
    if handler.on_request_file_list_v2 then
      handler.on_request_file_list_v2(ext_info, function(succ, ...)
        file_list_cb(succ, ...)
      end)
    end
    return true
  else
    EL.LOG.debug(TAG, "request_file_list No handler with 'on_request_file_list', use sdk inner check file list")
    return false
  end
end

function M.check_has_request_file_list_handler(namespace, res_key)
  local handler = find_res_dispatch_handler(namespace, res_key)
  return handler and (handler.on_request_file_list ~= nil or nil ~= handler.on_request_file_list_v2)
end

function M.process_file_list(namespace, res_key, file_list_cb, ext_info)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and handler.on_process_file_list_v2 then
    EL.LOG.debug(TAG, "process_file_list has handler and 'on_process_file_list', use this method check file list")
    if handler.on_process_file_list_v2 then
      handler.on_process_file_list_v2(ext_info, function(succ, ...)
        file_list_cb(succ, ...)
      end)
    end
    return true
  else
    EL.LOG.debug(TAG, "process_file_list No handler with 'on_process_file_list', use sdk inner check file list")
    return false
  end
end

function M.check_has_process_file_list_handler(namespace, res_key)
  local handler = find_res_dispatch_handler(namespace, res_key)
  return handler and handler.on_process_file_list_v2 ~= nil
end

function M.check_has_apply_handler(namespace, res_key)
  local handler = find_res_dispatch_handler(namespace, res_key)
  return handler and (handler.on_res_complete_apply ~= nil or nil ~= handler.on_res_complete_apply_v2)
end

function M.check_has_origin_apply_handler(namespace, res_key)
  local handler = find_res_dispatch_handler(namespace, res_key)
  return handler and handler.on_origin_res_apply_v2 ~= nil
end

function M.request_origin_res_apply(namespace, res_key, res_location, apply_dest_path, apply_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and handler.on_origin_res_apply_v2 then
    local engine_context = {
      get_res_info = function()
        return namespace, res_key
      end
    }
    handler.on_origin_res_apply_v2(engine_context, res_location, apply_dest_path, function(succ, ...)
      apply_cb(succ, ...)
    end)
  end
end

function M.request_res_patch_apply(namespace, res_key, res_location, apply_dest_path, res_state_infos, apply_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and (handler.on_res_complete_apply or handler.on_res_complete_apply_v2 or handler.on_res_apply) then
    EL.LOG.debug(TAG, "request_res_patch_apply has handler and 'request_res_patch_apply', use this method check apply")
    if handler.on_res_complete_apply then
      handler.on_res_complete_apply(namespace, res_key, res_location, res_state_infos, function(succ, ...)
        apply_cb(succ, ...)
      end)
    end
    if handler.on_res_complete_apply_v2 then
      local ER = require("ejoysdk_lua.res.ejoysdk_res")
      local GRM = require("ejoysdk_lua.res.group_res_manager")
      local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
      local is_group = GRM.is_group(res_key)
      local is_predownload = PREDOWNLOAD_MGR.UTILS.is_predownload(res_key)
      local engine_context = {
        download_res_files = function(file_path_list, opts, complete_cb, state_listener, progress_listener)
          local res_version = res_state_infos.res_update_info.version
          ER.download_res_files(namespace, res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
        end,
        get_res_info = function()
          if is_group or is_predownload then
            local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
            local startup_res_info = EF.get_startup_res_info()
            local pkg_res_path = startup_res_info.pkg_res_path
            local res_info = {pkg_res_path = pkg_res_path}
            return namespace, res_key, res_info
          end
          local game_startup_params = SC.get_game_startup_params()
          local res_info = game_startup_params[namespace][res_key]
          return namespace, res_key, res_info
        end,
        is_group = is_group,
        is_predownload = is_predownload
      }
      handler.on_res_complete_apply_v2(engine_context, res_location, apply_dest_path, function(succ, ...)
        apply_cb(succ, ...)
      end, function(state, progress_info)
        if handler.on_res_apply_progress_change_listener then
          EL.LOG.debug(TAG, "apply progress change, state is " .. tostring(state) .. ", progress_info is >>>")
          EL.LOG.debug(TAG, progress_info)
          handler.on_res_apply_progress_change_listener(state, progress_info)
        else
          EL.LOG.debug(TAG, "not set on_res_apply_progress_change_listener, skip notify")
        end
      end)
    end
    return true
  else
    EL.LOG.debug(TAG, "request_res_patch_apply No handler with 'request_res_patch_apply', use sdk inner check apply")
    apply_cb(true, false)
    return false
  end
end

function M.res_update_complete(namespace, res_key, succ, ...)
  if true == succ then
    local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
    local res_src_model = EMF.get_ejoy_res_source_model(namespace, res_key)
    if res_src_model and _get_confirm_update_result(namespace, res_key) then
      local res_type = "qz_patch"
      local res_state_infos = res_src_model:get_res_state()
      local ef = require("ejoysdk_lua.res.ejoysdk_res_facade")
      local update_info = res_state_infos[ef.RES_STATE_INFOS.TYPE_RES_UPDATE_STATE] or {}
      local res_ext_info = update_info.res_ext or {}
      local res_project_name = res_ext_info.project_name
      local res_ver = update_info[ef.RES_DOWNLOAD_STATE_KEY.VERSION_NAME]
      res_src_model:update_using_res_version(res_ver, res_project_name, res_type)
    end
  end
end

function M.notify_startup_update_complete(succ, ...)
  if true == succ then
    local startup_local_res_info = SC.get_startup_game_origin_params() or {}
    local namespace = startup_local_res_info.namespace
    local res_key = startup_local_res_info.res_key
    M.res_update_complete(namespace, res_key, succ, ...)
    local SU = require("ejoysdk_lua.res.startup.startup_utils")
    SU.update_last_version_info()
  end
  for _, lis in ipairs(startup_complete_listeners) do
    lis(succ, ...)
  end
end

function M.notify_group_res_update_complete(namespace, res_key, succ, ...)
  M.res_update_complete(namespace, res_key, succ, ...)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and handler.on_group_res_update_complete then
    handler.on_group_res_update_complete(succ, ...)
  end
end

function M.notify_splitpkg_update_complete(succ, ...)
  for _, lis in ipairs(splitpkg_complete_listeners) do
    lis(succ, ...)
  end
end

function M.notify_progress_change_listener(namespace, res_key, progress_info)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler then
    if handler.progress_listeners then
      for _, progress_listener in ipairs(handler.progress_listeners) do
        progress_listener(namespace, res_key, progress_info)
      end
    end
    if handler.progress_listener_v2 then
      handler.progress_listener_v2(progress_info)
    end
  end
end

function M.notify_res_state_change_listener(namespace, res_key, state, state_obj)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler then
    if handler.state_listeners then
      for _, state_lis in ipairs(handler.state_listeners) do
        state_lis(namespace, res_key, state, state_obj)
      end
    end
    if handler.state_listener_v2 then
      handler.state_listener_v2(state, state_obj)
    end
  end
end

function M.notify_res_update_change_listener(namespace, res_key, state_obj, progress_info)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and handler.download_progress_listener_v2 then
    handler.download_progress_listener_v2(state_obj, progress_info)
  end
end

function M.notify_startup_config_changed(cur_product_code, is_review, public_startup_config, review_startup_config, cb)
  local lis_size = #startup_config_listeners
  if 0 == lis_size then
    EL.LOG.debug(TAG, "notify_startup_config_changed return true, for lis_size is 0")
    if cb then
      cb(true)
    end
    return
  end
  local startup_config_callback_count = lis_size
  EL.LOG.debug(TAG, "notify_startup_config_changed, size:" .. tostring(startup_config_callback_count))
  for _, lis in ipairs(startup_config_listeners) do
    lis(cur_product_code, is_review, public_startup_config, review_startup_config, function(_succ, ...)
      startup_config_callback_count = startup_config_callback_count - 1
      if startup_config_callback_count <= 0 and cb then
        cb(_succ, ...)
      end
    end)
  end
end

function M.dispatch_res_failed_retry_listener(namespace, res_key, retry_cb, code, msg, ext)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and (handler.on_res_failed_retry_listener or handler.on_res_failed_retry_listener_v2) then
    EL.LOG.debug(TAG, "on_res_failed_retry_listener has handler, use this method check apply")
    if handler.on_res_failed_retry_listener then
      handler.on_res_failed_retry_listener(namespace, res_key, function()
        retry_cb()
      end, code, msg, ext)
    end
    if handler.on_res_failed_retry_listener_v2 then
      handler.on_res_failed_retry_listener_v2(res_key, function()
        retry_cb()
      end, code, msg, ext)
    end
    return true
  else
    return false
  end
end

function M.dispatch_show_app_update_ui_listener(update_info, close_cb)
  if on_show_app_update_ui_listener then
    on_show_app_update_ui_listener(update_info, function(succ, ...)
      close_cb(succ, ...)
    end)
    return true
  end
  return false
end

function M.dispatch_app_update_game_exit_listener()
  if on_game_exit_listener then
    on_game_exit_listener()
    return true
  end
  return false
end

local function _dispatch_confirm(namespace, res_key, handle_name, confirm_cb)
  local handler = find_res_dispatch_handler(namespace, res_key)
  if handler and handler[handle_name] then
    EL.LOG.debug(TAG, handle_name .. " has handler, use this method check apply")
    handler[handle_name](confirm_cb)
  else
    EL.LOG.debug(TAG, "skip notify, handle:" .. handle_name)
    confirm_cb()
  end
end

function M.dispatch_confirm_res_apply(namespace, res_key, confirm_cb)
  _dispatch_confirm(namespace, res_key, "on_confirm_res_apply", confirm_cb)
end

function M.dispatch_confirm_res_patch(namespace, res_key, confirm_cb)
  _dispatch_confirm(namespace, res_key, "on_confirm_res_patch", confirm_cb)
end

function M.publish_startup_state_changed(state, ...)
  if state == M.STARTUP_UPDATE_STATES.STARTUP_RES_APPLY_SUCC then
    local ns, rk = ...
    RS.stat_on_res_update_complete(ns, rk, nil, true)
  elseif state == M.STARTUP_UPDATE_STATES.STARTUP_RES_DOWNLOADING then
    local ns, rk = ...
    RS.stat_on_res_update_downloading(ns, rk, nil, true)
  elseif state == M.STARTUP_UPDATE_STATES.STARTUP_RES_DOWNLOAD_COMPLETE then
    local ns, rk = ...
    RS.stat_on_res_update_download_complete(ns, rk, nil, true)
  elseif state == M.STARTUP_UPDATE_STATES.STARTUP_RES_APPLYING then
    local ns, rk = ...
    RS.stat_on_res_update_applying(ns, rk, nil, true)
  elseif state == M.STARTUP_UPDATE_STATES.STARTUP_UPDATE_READY then
    local JF = require("ejoysdk_lua.vendors.jf")
    JF.flush_high_level_events()
  end
  ET.publish(ET.qz_startup_update.QZ_STARTUP_UPDATE_STATE_CHANGED, state, ...)
end

function M.subscribe_startup_state_changed(listener)
  if not listener then
    return
  end
  ET.subscribe(ET.qz_startup_update.QZ_STARTUP_UPDATE_STATE_CHANGED, listener)
end

function M.unsubscribe_startup_state_changed(listener)
  if not listener then
    return
  end
  ET.unsubscribe(ET.qz_startup_update.QZ_STARTUP_UPDATE_STATE_CHANGED, listener)
end

function M._test_unsubscribe_all()
  namespace_handler_map = {}
  startup_config_listeners = {}
  startup_complete_listeners = {}
end

return M
