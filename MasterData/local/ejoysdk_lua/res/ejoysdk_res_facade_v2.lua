local ER = require("ejoysdk_lua.res.ejoysdk_res")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local E = require("ejoysdk_lua.ejoysdk")
local DEH = require("ejoysdk_lua.res.ejoysdk_default_engine_handler")
local SPLIT_PKG_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
local INTERCEPTORS = require("ejoysdk_lua.res.startup.ejoysdk_res_update_interceptors")
local SUB_PKG_INTERCEPTOR = require("ejoysdk_lua.res.startup.interceptors.sub_pkg_interceptor.sub_pkg_interceptor")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local START_UP_RES_INFO = E.LazyKeyStore:New("EJOYSDK_START_UP_RES_INFO", false, true, false)
local M = {}
local TAG = "ejoy_res_facade_v2"
M.NAMESPACES = {QZ_PATCH = "qz_patch"}
M.RES_TYPE = {QZ_PATCH = "qz_patch"}
M.RES_INFO_KEY = RTM.USING_RES_INFO_PARAM_KEY
M.DOWNLOAD_STATE = RTM.PUBLIC_DOWNLOAD_STATE
M.RES_DOWNLOAD_STATE_KEY = RTM.RES_STATE_INFO_KEY
M.PROGRESS_INFO_KEY = RTM.PROGRESS_INFO_KEY
M.RES_STATE_INFOS = RTM.INFO_TYPE_KEY
M.UPDATE_INFO_KEY = RTM.UPDATE_INFO_KEY
M.USING_RES_INFO_KEY = RTM.USING_RES_STATE_INFO_KEY
M.FILE_LIST_ITEM_KEY = RTM.FILE_LIST_ITEM_KEY
M.NAMESPACE_UPDATE_OPTIONS = END.NAMESPACE_UPDATE_OPTIONS
M.NETWORK_STRATEGY = NS.STRATEGY
M.STARTUP_UPDATE_OPTIONS = END.STARTUP_UPDATE_OPTIONS
M.NAMESPACE_RES_UPDATE_OPTIONS = END.NAMESPACE_RES_UPDATE_OPTIONS
M.STORAGE_TYPE = RTM.STORAGE_TYPE
M.STARTUP_NAMESPACES = SC.STARTUP_NAMESPACES
M.STARTUP_UPDATE_STATES = SC.PUB_STARTUP_STATES
M.TOPIC_STARTUP_UPDATE_STATE_CHANGED = ET.qz_startup_update.QZ_STARTUP_UPDATE_STATE_CHANGED
M.FILE_LIST_TYPE = RTM.FILE_LIST_TYPE
M.STORAGE_TYPE = ERB.STORAGE_TYPE
M.STARTUP_CONFIG_KEY = END.STARTUP_CONFIG_KEY
local res_key
local cache_res_info_map = {}

function M.startup_res_update(product_code, res_info, opts, listeners, qz_product_code, sdk_init_config)
  local EM = require("ejoysdk_lua.res.startup_res_manager")
  local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
  res_info = res_info or {}
  res_info.res_save_storage_type, res_info.res_save_base_path = ER_UTILS.try_get_storage_other_type_path(res_info.res_save_storage_type, res_info.res_save_base_path)
  res_key = res_info.res_key
  local current_res_info_arr = {}
  res_info.namespace = M.NAMESPACES.QZ_PATCH
  if res_info.engine_handler == nil then
    res_info.engine_handler = DEH
    res_info.use_default_engine_handler = true
  end
  local cache_res_info = {
    res_key = res_key,
    res_save_base_path = res_info.res_save_base_path,
    res_save_storage_type = res_info.res_save_storage_type,
    pkg_res_path = res_info.pkg_res_path,
    qz_product_code = qz_product_code
  }
  START_UP_RES_INFO:set(cache_res_info)
  SC.update_startup_game_origin_params(res_info)
  table.insert(current_res_info_arr, res_info)
  if res_key then
    cache_res_info_map[res_key] = res_info
  end
  local startup_params = {}
  startup_params.current_res_info_arr = current_res_info_arr
  local init_config = sdk_init_config or {}
  startup_params.init_config = init_config
  startup_params.qz_product_code = qz_product_code
  opts = opts or {}
  opts.is_v2_facade = true
  local ext = opts.ext or {}
  opts.ext = nil
  INTERCEPTORS.init(res_info, listeners)
  local listeners_wrapper = INTERCEPTORS.get_last_interceptor() or listeners
  EM.init_startup_res(product_code, startup_params, opts, listeners_wrapper, ext)
end

function M.cancel_res_update(cb)
  local UTILS = require("ejoysdk_lua.ejoysdk_utils")
  local startup_res_info = M.get_startup_res_info()
  if startup_res_info and next(startup_res_info) and not UTILS.is_text_empty(startup_res_info.res_key) then
    local module_mrg = require("ejoysdk_lua.res.startup.startup_module_manager")
    local update_check = module_mrg.get_module_cache_by_name(SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_CHECK)
    if update_check then
      local update_task = update_check:get_update_task(M.NAMESPACES.QZ_PATCH, startup_res_info.res_key)
      if update_task then
        update_task:cancel_update(cb)
        return
      end
    end
  end
  cb(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_STARTUP_NOT_BEGIN, "fail to cancel an update which has not started")
end

function M.is_splitpkg_res_complete()
  local SPM = require("ejoysdk_lua.res.splitpkg_res_manager")
  local is_complete = SPM.is_local_res_complete()
  return is_complete
end

function M.splitpkg_res_update(opts, listeners)
  E.LOG.debug(TAG, "splitpkg_res_update received")
  if M.is_splitpkg_res_complete() then
    E.LOG.debug(TAG, "splitpkg_res_update received, and split res is complete, directly return true")
    listeners.on_splitpkg_res_update_complete(true)
    return
  end
  SPLIT_PKG_INTERCEPTOR.set_splitpkg_update_running()
  local UIM = require("ejoysdk_lua.res.update_info_manager")
  local startup_res_update_infos = SC.get_startup_update_infos()
  UIM.add_update_infos(startup_res_update_infos)
  local startup_params = SC.get_startup_local_res_infos_cache()
  SC.update_startup_local_res_infos(startup_params)
  E.LOG.debug(TAG, "splitpkg_res_update begin, update_infos>>")
  E.log(startup_res_update_infos)
  local namespace_exts = SC.get_namespace_ext_infos_cache() or {}
  local cache_res_info = START_UP_RES_INFO:get() or {}
  local inner_res_key = cache_res_info.res_key
  local inner_pkg_res_path = cache_res_info.pkg_res_path or ""
  _ejoysdk.log("inner_res_key:" .. tostring(inner_res_key) .. ", inner_pkg_res_path:" .. tostring(inner_pkg_res_path))
  local SI = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
  local split_config = SI.get_split_pkg_config()
  if not inner_res_key then
    local err_code = EC.RESOURCE_UPDATE_ERROR_CODES.RES_SPLITPKG_UPDATE_CALLED_BEFORE_STARTUP
    local err_msg = "splitpkg_res_update called before startup"
    E.LOG.error(TAG, "splitpkg_res_update failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
    listeners.on_splitpkg_res_update_complete(false, err_code, err_msg)
    return
  elseif not split_config.res_key or split_config.res_key ~= inner_res_key then
    local err_msg = "splitpkg_res_update res_key in split config not equals with startup res_key"
    E.LOG.error(TAG, err_msg)
    listeners.on_splitpkg_res_update_complete(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_SPLITPKG_RES_KEY_NOT_EQUALS_WITH_STARTUP, err_msg)
    return
  end
  local _pkg_res_path_config = split_config.pkg_res_path or ""
  E.LOG.debug(TAG, "splitpkg_res_update pkg_res_path_config:" .. tostring(_pkg_res_path_config) .. ", startup pkg_res_path:" .. tostring(inner_pkg_res_path))
  if inner_pkg_res_path and "" ~= inner_pkg_res_path and inner_pkg_res_path ~= _pkg_res_path_config then
    local err_msg = "splitpkg_res_update pkg_res_path in split config not equals with startup pkg_res_path, startup:" .. tostring(inner_pkg_res_path) .. ", split config:" .. tostring(_pkg_res_path_config)
    E.LOG.error(TAG, err_msg)
    listeners.on_splitpkg_res_update_complete(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_SPLITPKG_PKG_RES_PATH_NOT_EQUALS_WITH_STARTUP, err_msg)
    return
  end
  opts = opts or {}
  opts.is_v2_facade = true
  local res_info = {
    engine_handler = DEH,
    res_save_base_path = cache_res_info.res_save_base_path,
    res_save_storage_type = cache_res_info.res_save_storage_type,
    namespace_ext = namespace_exts[M.NAMESPACES.QZ_PATCH] or {}
  }
  INTERCEPTORS.init(res_info, listeners)
  local listeners_wrapper = INTERCEPTORS.get_last_interceptor() or listeners
  local SPM = require("ejoysdk_lua.res.splitpkg_res_manager")
  SPM.spitpkg_res_update(M.NAMESPACES.QZ_PATCH, inner_res_key, res_info, opts, listeners_wrapper)
end

function M.update_res_download_strategy(_res_key, strategy)
  ER.update_res_download_strategy(M.NAMESPACES.QZ_PATCH, _res_key, strategy)
end

function M.group_res_update(group_name, engine_handler, opts, listeners)
  local UIM = require("ejoysdk_lua.res.update_info_manager")
  local startup_res_update_infos = SC.get_startup_update_infos()
  UIM.add_update_infos(startup_res_update_infos)
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local namespace_exts = SC.get_namespace_ext_infos_cache() or {}
  local cache_res_info = START_UP_RES_INFO:get() or {}
  local inner_res_key = cache_res_info.res_key
  opts = opts or {}
  opts.is_v2_facade = true
  local group_res_info = {
    engine_handler = engine_handler,
    res_save_base_path = cache_res_info.res_save_base_path,
    res_save_storage_type = cache_res_info.res_save_storage_type,
    namespace_ext = namespace_exts[M.NAMESPACES.QZ_PATCH] or {}
  }
  if nil == engine_handler then
    local inner_res_info = inner_res_key and cache_res_info_map[inner_res_key]
    if inner_res_info and inner_res_info.engine_handler then
      group_res_info.engine_handler = inner_res_info.engine_handler
    else
      group_res_info.engine_handler = DEH
    end
  end
  GRM.group_res_update(M.NAMESPACES.QZ_PATCH, inner_res_key, group_name, group_res_info, opts, listeners)
end

function M.groups_res_update(groups, _opts, listeners)
  local MULTI_GROUPS_UPDATE = require("ejoysdk_lua.res.multi_groups_update")
  MULTI_GROUPS_UPDATE:New():groups_update(groups, _opts, listeners)
end

function M.get_startup_res_info()
  local cache_res_info = START_UP_RES_INFO:get() or {}
  return cache_res_info
end

function M.check_res_update(params, update_cb)
  local inner_res_key = params.res_key or res_key
  local inner_res_version = params.version
  local inner_params = {
    using_res_info = {version = inner_res_version}
  }
  local opts = params.opts or {}
  
  local function update_cb_wrapper(succ, ...)
    if succ then
      local _, has_update, res_state_info = ...
      local simple_res_state_info = ER.get_simple_res_state(res_state_info)
      update_cb(succ, has_update, simple_res_state_info)
    else
      update_cb(succ, ...)
    end
  end
  
  ER.check_namespace_res_update(M.NAMESPACES.QZ_PATCH, inner_res_key, inner_params, opts, update_cb_wrapper)
end

function M.confirm_res_update(_res_key, res_ver, params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
  local inner_res_key = _res_key or res_key
  ER.confirm_update_namespace_res(M.NAMESPACES.QZ_PATCH, inner_res_key, res_ver, params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
end

function M.get_res_state(_res_key, _group_name)
  local inner_res_key = _res_key or res_key
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  if _group_name then
    inner_res_key = GRM.get_task_key(inner_res_key, _group_name)
  end
  E.log("inner_res_key is " .. tostring(inner_res_key))
  local res_state_info = ER.get_res_state(M.NAMESPACES.QZ_PATCH, inner_res_key)
  local simple_res_state_info = ER.get_simple_res_state(res_state_info)
  return simple_res_state_info
end

function M.register_res_state_listener(listener)
  ER.register_res_state_change_listener(M.NAMESPACES.QZ_PATCH, res_key, listener)
end

function M.unregister_res_state_listener(listener)
  ER.unregister_res_state_change_listener(M.NAMESPACES.QZ_PATCH, res_key, listener)
end

function M.register_res_progress_listener(listener)
  ER.register_res_progress_listener(M.NAMESPACES.QZ_PATCH, res_key, listener)
end

function M.unregister_res_progress_listener(listener)
  ER.unregister_res_progress_listener(M.NAMESPACES.QZ_PATCH, res_key, listener)
end

function M.remove_res_version(_res_key, res_version, _opts)
  ER.remove_res_version(M.NAMESPACES.QZ_PATCH, _res_key, res_version, _opts)
end

function M.unsubscribe_startup_state_changed(listener)
  END.unsubscribe_startup_state_changed(listener)
end

function M.subscribe_startup_state_changed(listener)
  END.subscribe_startup_state_changed(listener)
end

function M.download_res_files(_res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
  ER.download_res_files(M.NAMESPACES.QZ_PATCH, _res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
end

function M.get_storage_path_by_type(storage_type)
  storage_type = storage_type or M.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  local storage_type_path_base = ERB.static_get_storage_path_by_type(storage_type)
  local storage_dir = E.Utils.trim_end(storage_type_path_base, "/")
  return storage_dir
end

function M.repair(_res_key, _group_name)
  local inner_res_key = _res_key or res_key
  if not inner_res_key then
    E.LOG.e(TAG, "invalid res_key")
    return
  end
  local cache_res_info = START_UP_RES_INFO:get()
  local save_storage_type, apply_dest_path, using_version
  if cache_res_info and next(cache_res_info) then
    local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
    save_storage_type = cache_res_info.res_save_storage_type
    apply_dest_path = ER_UTILS.get_apply_dest_path(save_storage_type, cache_res_info.res_save_base_path)
    if not UTILS.is_text_empty(apply_dest_path) then
      local local_res_group_state
      if _group_name then
        local_res_group_state = M.get_res_state(inner_res_key, _group_name)
      else
        local_res_group_state = M.get_res_state(inner_res_key)
      end
      using_version = local_res_group_state.using_version
    end
  end
  ER.repair(M.NAMESPACES.QZ_PATCH, inner_res_key, _group_name)
  END.dispatch_res_repair(M.NAMESPACES.QZ_PATCH, inner_res_key, _group_name)
  if using_version then
    local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
    local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
    local raw_storage_type = ER_UTILS.try_get_storage_type(save_storage_type, apply_dest_path)
    local target_file_list = ER_FILE_INFO_CACHE.get_cache_file_list(M.NAMESPACES.QZ_PATCH, inner_res_key, using_version, raw_storage_type or cache_res_info.res_save_storage_type)
    local current_file_list_info = RTM.static_get_using_res_file_list(apply_dest_path) or {}
    if next(current_file_list_info) then
      for _, group in ipairs(target_file_list) do
        for _, item in ipairs(group.items or {}) do
          if _group_name and _group_name == group.g or not _group_name then
            current_file_list_info[item.to] = nil
          end
        end
      end
      RTM.static_update_using_res_file_list(apply_dest_path, current_file_list_info)
    end
  end
  if not _group_name then
    SUB_PKG_INTERCEPTOR.on_res_repair(save_storage_type, apply_dest_path)
    SPLIT_PKG_INTERCEPTOR.on_res_repair(save_storage_type, apply_dest_path)
  end
end

function M.integrity_check(opts, cb)
  local RC = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_check")
  local UTILS = require("ejoysdk_lua.ejoysdk_utils")
  local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
  local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
  local cache_res_info = START_UP_RES_INFO:get() or {}
  if nil == cache_res_info or nil == next(cache_res_info) or UTILS.is_text_empty(cache_res_info.res_key) then
    cb(EC.RES_CHECK_CODE.ERROR_INVALID_PARAMS, {})
    return
  end
  local res_info = {
    res_key = cache_res_info.res_key,
    namespace = M.NAMESPACES.QZ_PATCH,
    pkg_res_list_dir = cache_res_info.pkg_res_path
  }
  local save_storage_type, apply_dest_path, using_version
  if next(cache_res_info) then
    save_storage_type = cache_res_info.res_save_storage_type
    apply_dest_path = ER_UTILS.get_apply_dest_path(save_storage_type, cache_res_info.res_save_base_path)
  end
  local raw_storage_type = ER_UTILS.try_get_storage_type(save_storage_type, apply_dest_path)
  local startup_requested_groups = {"default"}
  local GM = require("ejoysdk_lua.res.group_res_manager")
  local group_rk_arr = RTM.static_get_res_group_rk_arr(res_info.namespace, res_info.res_key) or {}
  for _, group_rk in ipairs(group_rk_arr) do
    table.insert(startup_requested_groups, GM.get_group_name_by_task_key(group_rk))
  end
  E.LOG.d(TAG, "integrity_check groups>>>")
  E.LOG.d(TAG, startup_requested_groups)
  
  local function get_file_list(_res_key, group_name)
    if not UTILS.is_text_empty(apply_dest_path) then
      local local_res_group_state
      if "default" == group_name then
        local_res_group_state = M.get_res_state(_res_key)
      else
        local_res_group_state = M.get_res_state(_res_key, group_name)
      end
      using_version = local_res_group_state.using_version
      local target_file_list = ER_FILE_INFO_CACHE.get_cache_file_list(M.NAMESPACES.QZ_PATCH, _res_key, using_version, raw_storage_type or cache_res_info.res_save_storage_type)
      for _, group in ipairs(target_file_list) do
        if group_name == group.g then
          return group.items
        end
      end
    end
    return {}
  end
  
  local ret = {
    code = EC.RES_CHECK_CODE.PASS_WITH_NO_ERROR,
    fail_list = {}
  }
  local counter = 0
  
  local function total_cb(result)
    counter = counter + 1
    if counter >= #startup_requested_groups then
      cb(result.code, result.fail_list)
    end
  end
  
  for _, group_name in ipairs(startup_requested_groups) do
    local file_list = get_file_list(res_info.res_key, group_name)
    if file_list and next(file_list) then
      local origin_file_info = {file_list = file_list}
      RC.integrity_check(res_info, origin_file_info, opts, function(succ, detail)
        if not succ then
          ret.code = ret.code < detail.code and detail.code or ret.code
          ret.fail_list[group_name] = detail.abnormal_list
          E.LOG.e(TAG, "资源完整性检查失败, group_name=" .. group_name .. ",code=" .. tostring(detail.code) .. ",msg=" .. tostring(detail.msg))
        end
        total_cb(ret)
      end)
    else
      total_cb(ret)
    end
  end
end

function M.publish_using_res_version(_res_key, version)
  ER.publish_using_res_version(M.NAMESPACES.QZ_PATCH, _res_key, version, nil, M.RES_TYPE.QZ_PATCH)
end

function M.is_sub_pkg()
  do return end
  return SUB_PKG_INTERCEPTOR.is_sub_pkg, nil
end

return M
