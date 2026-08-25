local E = require("ejoysdk_lua.ejoysdk")
local FLOW_TASK = require("ejoysdk_lua.libs.flow_task")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local STAT = require("ejoysdk_lua.res.res_stat")
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local SU = require("ejoysdk_lua.res.startup.startup_utils")
local MODULE_NAME = SC.STARTUP_CORE_MODULE_NAME.INIT_FLOW
local TAG = MODULE_NAME
local M = FLOW_TASK:new(MODULE_NAME)
local STARTUP_NS = SC.STARTUP_NAMESPACES
local QZ_EJ_OVERRIDE_PROCESS_STATUS = E.LazyKeyStore:New("QZ_EJ_OVERRIDE_PROCESS_STATUS", false, false, false)
local start_init_states = {
  state_check_for_override_install = false,
  state_cdn_config = false,
  state_startup_config = false
}

function M:_cache_update_infos(game_res_ns_map, update_infos, update_namespace_exts, cb)
  E.LOG.debug(TAG, "_cache_update_infos succ >>")
  update_infos = update_infos or {}
  E.log(update_infos)
  E.log(update_namespace_exts)
  SC.update_namespace_ext_infos(update_namespace_exts)
  SC.update_boot_res_update_info(update_infos[STARTUP_NS.QZ_BOOT])
  local game_res_update_infos = {}
  for ns, res_map in pairs(update_infos) do
    if game_res_ns_map[ns] then
      game_res_update_infos[ns] = res_map
    end
  end
  if next(game_res_update_infos) == nil then
    EL.LOG.debug(TAG, "no update info for game res namespaces")
    cb(true)
    STAT.stat_request_ns_res_update_end(true, "update_empty")
    return
  end
  local startup_update_infos = {}
  for ns, res_map in pairs(game_res_update_infos) do
    for res_key, _update_info in pairs(res_map) do
      EL.LOG.debug(TAG, "add download startup only res:" .. tostring(res_key))
      startup_update_infos[ns] = startup_update_infos[ns] or {}
      startup_update_infos[ns][res_key] = _update_info
    end
  end
  SC.update_game_startup_res_update_infos(startup_update_infos)
  if next(startup_update_infos) == nil then
    EL.LOG.debug(TAG, "no startup res update, skip update")
    cb(true)
    STAT.stat_request_ns_res_update_end(true, "update_timing_empty")
  else
    cb(true)
  end
end

function M:_switch_to_review_env(review_product_code, qz_endpoints)
  E.LOG.debug(TAG, "_switch_to_review_env begin:" .. tostring(review_product_code))
  E.log(qz_endpoints)
  ECC.delete_with_new_product(review_product_code)
  E.CONFIG.autoconfig("", review_product_code)
  SC.update_qz_product_code(review_product_code)
  ECC.set_prioritized_base_urls(qz_endpoints)
end

function M:_request_namespace_res_update(startup_ns_arr, local_res_params, request_result_handler, ext)
  local update_request_options = {
    disable_update_cache = true,
    disable_update_cache_ns_arr = SC.DISABLE_UPDATE_CACHE_NS_ARR,
    update_type = ECC.CONFIG_CENTER_UPDATE_TYPE.ALL,
    product_code = SC.get_qz_product_code()
  }
  E.LOG.debug(TAG, "update_request_options >>")
  E.log(update_request_options)
  if SC.is_qz_pcode_equals_current_pcode() then
    local request_ns_arr = {}
    for _, startup_ns in ipairs(startup_ns_arr) do
      table.insert(request_ns_arr, startup_ns)
    end
    table.insert(request_ns_arr, ECC.NAMESPACE.EJOYSDK_BIZ)
    E.LOG.debug(TAG, "request_namespace_res_update begin qz and current pcode equals, so ejoysdk_biz request with qz namespaces >>")
    E.log(request_ns_arr)
    ER.request_namespace_res_update(request_ns_arr, local_res_params, request_result_handler, update_request_options, ext)
  else
    E.LOG.debug(TAG, "request_namespace_res_update begin qz and current pcode NOT equals, so ejoysdk_biz do separate request")
    local finish_cnt = 0
    local is_update_cfg_succ, update_infos, update_namespace_exts, update_cfg_err_code, update_cfg_err_msg
    
    local function cfg_result_cb()
      finish_cnt = finish_cnt + 1
      if 2 == finish_cnt then
        if is_update_cfg_succ then
          request_result_handler(true, update_infos, update_namespace_exts)
        else
          request_result_handler(false, update_cfg_err_code, update_cfg_err_msg)
        end
      end
    end
    
    ER.request_namespace_res_update(startup_ns_arr, local_res_params, function(succ, ...)
      E.LOG.debug(TAG, "request_namespace_res_update qz result:" .. tostring(succ))
      is_update_cfg_succ = succ
      if succ then
        update_infos, update_namespace_exts = ...
      else
        update_cfg_err_code, update_cfg_err_msg = ...
        E.LOG.warn(TAG, "_request_namespace_res_update startup config failed, code:" .. tostring(update_cfg_err_code) .. ", msg:" .. tostring(update_cfg_err_msg))
      end
      cfg_result_cb()
    end, update_request_options, ext)
    ER.request_namespace_res_update({
      ECC.NAMESPACE.EJOYSDK_BIZ
    }, nil, function(succ, ...)
      E.LOG.debug(TAG, "request_namespace_res_update biz result:" .. tostring(succ))
      if not succ then
        local code, msg = ...
        E.LOG.warn(TAG, "_request_namespace_res_update ejoysdk_biz failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      end
      cfg_result_cb()
    end, nil, ext)
  end
end

function M:_request_startup_configs(cb)
  E.LOG.debug(TAG, "_request_startup_configs begin")
  local is_force_check_update = SC.is_force_check_update()
  EL.LOG.debug(TAG, "_request_startup_configs, last state:" .. tostring(start_init_states.state_startup_config) .. ", is_force:" .. tostring(is_force_check_update))
  if start_init_states.state_startup_config and not is_force_check_update then
    EL.LOG.debug(TAG, "_request_startup_configs already succ, now return true")
    cb(true)
    return
  end
  
  local function startup_check_complete(succ, ...)
    start_init_states.state_startup_config = succ
    cb(succ, ...)
  end
  
  local game_local_ns_res_params = self._data.module_instance.game_res_local_infos()
  local request_ext_info = self._data.module_instance.get_startup_ext_info()
  local startup_ns_arr = {}
  local startup_ns_map = {}
  local game_res_ns_map = {}
  game_res_ns_map[STARTUP_NS.QZ_PATCH] = true
  for ns, _data in pairs(game_local_ns_res_params) do
    table.insert(startup_ns_arr, ns)
    startup_ns_map[ns] = true
    game_res_ns_map[ns] = true
  end
  for _ns_key, ns in pairs(STARTUP_NS) do
    if not startup_ns_map[ns] then
      table.insert(startup_ns_arr, ns)
      startup_ns_map[ns] = true
    else
      EL.LOG.debug(TAG, "already exists")
    end
  end
  local game_startup_params = SC.get_game_startup_params()
  local all_ns_resources = ER.get_all_cached_namespace_resources()
  local local_res_params = {}
  for ns, res_map in pairs(all_ns_resources) do
    if startup_ns_map[ns] then
      for res_key, res_info in pairs(res_map) do
        local group_rk_arr
        if not E.Utils.start_with(res_key, RTM.RES_GROUP_INFO_KEY.PREFIX) then
          group_rk_arr = RTM.static_get_res_group_rk_arr(ns, res_key) or {}
          local_res_params[ns] = local_res_params[ns] or {}
          local res_params = local_res_params[ns][res_key] or {}
          local using_res_info = res_info[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
          local cur_res_type = using_res_info[ER.RES_CONFIG_KEY.KEY_RES_TYPE]
          local cur_res_ver = using_res_info[ER.RES_CONFIG_KEY.KEY_VERSION]
          res_params.res_type = cur_res_type
          local versions = {}
          if cur_res_ver then
            table.insert(versions, cur_res_ver)
          end
          if SU.can_reuse_res() and game_startup_params and game_startup_params[ns] and game_startup_params[ns][res_key] then
            local pkg_version = game_startup_params[ns][res_key].pkg_res_version
            if not UTILS.STR.is_empty(pkg_version) and pkg_version ~= cur_res_ver then
              table.insert(versions, pkg_version)
            end
          end
          if not next(group_rk_arr) then
            _ejoysdk.log(">>>>>>>>>>>>>> using_res_info:" .. tostring(cur_res_ver) .. ", rk:" .. tostring(res_key))
            res_params.version = cur_res_ver
          else
            for _, group_rk in ipairs(group_rk_arr) do
              local group_res_info = res_map[group_rk] or {}
              local group_res_using_res_info = group_res_info[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
              local group_cur_res_ver = group_res_using_res_info[ER.RES_CONFIG_KEY.KEY_VERSION]
              if group_cur_res_ver then
                table.insert(versions, group_cur_res_ver)
              end
            end
          end
          if versions and next(versions) then
            res_params.versions = versions
          end
          local_res_params[ns][res_key] = res_params
        end
      end
    else
      E.LOG.warn(TAG, "sdk using namespace not in white list:" .. tostring(ns))
    end
  end
  for ns, res_map in pairs(game_local_ns_res_params) do
    for res_key, res_info in pairs(res_map) do
      local_res_params[ns] = local_res_params[ns] or {}
      local origin_res_params = local_res_params[ns][res_key] or {}
      local_res_params[ns][res_key] = res_info
      local versions = origin_res_params.versions or {}
      local game_res_version = res_info.version
      if game_res_version then
        UTILS.insert_array(versions, game_res_version)
      end
      local_res_params[ns][res_key].versions = versions
    end
  end
  EL.LOG.debug(TAG, "before request_namespace_res_update local_res_params:")
  E.log(local_res_params)
  E.log(game_local_ns_res_params)
  SC.update_startup_local_res_infos(local_res_params)
  STAT.stat_request_ns_res_update_begin()
  E.LOG.debug(TAG, "request_namespace_res_update begin >>")
  E.log(startup_ns_arr)
  E.log(game_res_ns_map)
  local _startup_config_cache = ECC.get_config(STARTUP_NS.QZ_CONFIG) or {}
  local _cache_product_code = _startup_config_cache.product_code
  _cache_product_code = _cache_product_code and _cache_product_code:upper()
  local current_product_code = SC.get_current_product_code()
  current_product_code = current_product_code and current_product_code:upper()
  if _cache_product_code and _cache_product_code ~= current_product_code then
    E.LOG.warn(TAG, "current startup product_code different with cache product_code, begin remove cache")
    ECC.delete_config()
  else
    E.LOG.debug(TAG, "cache is nil or current product_code equals cache product_code, now begin request startup updates, cachep:" .. tostring(_cache_product_code) .. ", curp:" .. tostring(current_product_code))
  end
  local request_result_handler
  
  function request_result_handler(succ, ...)
    if succ then
      local update_infos, update_namespace_exts = ...
      local is_current_review_env = SC.get_review_state()
      E.LOG.debug(TAG, "request_result_handler is_review_result:" .. tostring(is_current_review_env))
      local qz_config = update_infos[STARTUP_NS.QZ_CONFIG] or {}
      local qz_endpoints = qz_config[SC.QZ_CONFIG_KEYS.QZ_ENDPOINTS]
      E.LOG.debug(TAG, "request_result_handler is_review:" .. tostring(is_current_review_env) .. ", qz_config >>")
      E.log(qz_config)
      if is_current_review_env then
        E.LOG.debug(TAG, "its review result, now update review qz_config")
        SC.update_review_startup_config(qz_config)
        ECC.set_prioritized_base_urls(qz_endpoints)
        self:_cache_update_infos(game_res_ns_map, update_infos, update_namespace_exts, function(_succ)
          startup_check_complete(_succ)
        end)
      else
        E.LOG.debug(TAG, "its not review result, now check review rules")
        SC.update_public_startup_config(qz_config)
        local find_review_config = qz_config[SC.QZ_CONFIG_KEYS.REVIEW_CONFIG] or {}
        local is_reivew = false
        local config_is_review_state = find_review_config[SC.QZ_CONFIG_KEYS.IS_REVIEW]
        if config_is_review_state and type(config_is_review_state) == "boolean" then
          is_reivew = config_is_review_state
        end
        local review_product_code
        local is_review_product_code_different = false
        if is_reivew then
          review_product_code = find_review_config[SC.QZ_CONFIG_KEYS.PRODUCT_CODE]
          is_review_product_code_different = SC.update_review_state(true, review_product_code)
        end
        E.LOG.debug(TAG, "review state, review_pcode:" .. tostring(review_product_code) .. ", changes:" .. tostring(is_review_product_code_different) .. ", is_review:" .. tostring(is_reivew))
        if is_review_product_code_different then
          self:_switch_to_review_env(review_product_code, qz_endpoints)
          self:_request_namespace_res_update(startup_ns_arr, local_res_params, request_result_handler, request_ext_info)
        else
          ECC.set_prioritized_base_urls(qz_endpoints)
          self:_cache_update_infos(game_res_ns_map, update_infos, update_namespace_exts, function(_succ)
            startup_check_complete(_succ)
          end)
        end
      end
    else
      local err_code, err_msg = ...
      STAT.stat_request_ns_res_update_end(false, "", err_code, err_msg)
      E.LOG.warn(TAG, "check_namespace_res_update failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
      startup_check_complete(false, err_code, err_msg)
    end
  end
  
  self:_request_namespace_res_update(startup_ns_arr, local_res_params, request_result_handler, request_ext_info)
end

function M:_check_for_override_install_startup(cb)
  local is_override_install = SU.is_override_install_startup()
  if not is_override_install then
    local override_flag = QZ_EJ_OVERRIDE_PROCESS_STATUS:get()
    if "true" == override_flag then
      is_override_install = true
    else
      is_override_install = false
    end
  end
  QZ_EJ_OVERRIDE_PROCESS_STATUS:set(tostring(is_override_install))
  EL.LOG.debug(TAG, "_check_for_override_install_startup is_override_install:" .. tostring(is_override_install) .. ", testOverride:" .. tostring(SC.DEBUG.TestOverride))
  if not is_override_install and not SC.DEBUG.TestOverride then
    E.LOG.debug(TAG, "current startup is not override install startup, now return")
    cb(true)
    return
  end
  local is_force_check_update = SC.is_force_check_update()
  EL.LOG.debug(TAG, "_check_for_override_install_startup, state:" .. tostring(start_init_states.state_check_for_override_install) .. ", " .. tostring(SC.DEBUG.TestResKeyIncompatible) .. ", " .. tostring(SC.DEBUG.TestOverride) .. ", is_force:" .. tostring(is_force_check_update))
  if start_init_states.state_check_for_override_install == true and not is_force_check_update and not SC.DEBUG.TestResKeyIncompatible and not SC.DEBUG.TestOverride then
    EL.LOG.debug(TAG, "_check_for_override_install_startup alreay succ, now return")
    cb(true)
    return
  end
  
  local function complete_cb(succ, ...)
    start_init_states.state_check_for_override_install = succ
    if succ then
      QZ_EJ_OVERRIDE_PROCESS_STATUS:set("false")
    end
    cb(succ, ...)
  end
  
  local game_res_local_infos = self._data.module_instance.game_res_local_infos()
  if next(game_res_local_infos) == nil then
    EL.LOG.debug(TAG, "_check_for_override_install_startup not find local infos, just return true")
    complete_cb(true)
    return
  else
    EL.LOG.debug(TAG, "_check_for_override_install_startup load local resources")
    local cache_ns_infos = ER.get_all_cached_namespace_resources()
    E.LOG.debug(TAG, cache_ns_infos)
    E.LOG.debug(TAG, game_res_local_infos)
    local incompatible_res_list = {}
    for ns, l_ns_obj in pairs(game_res_local_infos) do
      if SC.DEBUG.TestResKeyIncompatible then
        for rk, l_rk_obj in pairs(l_ns_obj) do
          if SC.DEBUG.TestResKeyIncompatible then
            local incompatible_data = {
              _namespace = ns,
              _res_key = rk,
              _pkg_res_version = l_rk_obj.pkg_res_version,
              _cache_res_version = l_rk_obj.pkg_res_version,
              _cache_res_key = "_test_incompatible_res_key",
              _cache_res_infos = l_rk_obj
            }
            table.insert(incompatible_res_list, incompatible_data)
          end
        end
      end
      if cache_ns_infos[ns] then
        local cache_ns_data = cache_ns_infos[ns]
        for rk, l_rk_obj in pairs(l_ns_obj) do
          local using_res_type = l_rk_obj.res_type
          for cache_rk, cache_rk_obj in pairs(cache_ns_data) do
            E.LOG.debug(TAG, "cache_rk_obj >>>>>")
            E.LOG.debug(TAG, cache_rk_obj)
            local cache_res_using_info = cache_rk_obj[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
            local cache_res_type = cache_res_using_info.res_type
            E.LOG.debug(TAG, "local res key is " .. tostring(rk) .. ", cache res key is " .. tostring(cache_rk))
            E.LOG.debug(TAG, "local res key type is " .. tostring(using_res_type) .. ", cache res key type is " .. tostring(cache_res_type))
            if using_res_type and cache_res_type and using_res_type == cache_res_type and rk ~= cache_rk then
              local pkg_res_version = l_rk_obj.pkg_res_version
              local cache_rk_data = cache_ns_data[cache_rk] or {}
              local cache_update_info = cache_rk_data[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_RES_UPDATE_STATE] or {}
              local cache_res_version = cache_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME] or ""
              local res_save_storage_type = l_rk_obj.res_save_storage_type
              local res_save_base_path = l_rk_obj.res_save_base_path
              local res_real_save_storage_type = ER_UTILS.try_get_storage_type(res_save_storage_type, res_save_base_path)
              local incompatible_data = {
                _namespace = ns,
                _res_key = rk,
                _pkg_res_version = pkg_res_version,
                _cache_res_version = cache_res_version,
                _cache_res_key = cache_rk,
                _cache_res_infos = cache_rk_data,
                _res_save_storage_type = res_real_save_storage_type
              }
              table.insert(incompatible_res_list, incompatible_data)
            end
          end
        end
        for rk, l_rk_obj in pairs(l_ns_obj) do
          if cache_ns_data[rk] then
            local cache_rk_data = cache_ns_data[rk]
            local cache_update_info = cache_rk_data[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_RES_UPDATE_STATE] or {}
            local cache_res_version = cache_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME] or ""
            local pkg_res_version = l_rk_obj.pkg_res_version
            local res_save_storage_type = l_rk_obj.res_save_storage_type
            local res_save_base_path = l_rk_obj.res_save_base_path
            local res_real_save_storage_type = ER_UTILS.try_get_storage_type(res_save_storage_type, res_save_base_path)
            if SC.DEBUG.TestVersionIncompatible then
              pkg_res_version = "9.9.9.9"
              cache_res_version = "0.0.0.1"
            end
            local incompatible_data = {
              _namespace = ns,
              _res_key = rk,
              _pkg_res_version = pkg_res_version,
              _cache_res_version = cache_res_version,
              _cache_res_infos = cache_rk_data,
              _cache_res_key = rk,
              _res_save_storage_type = res_real_save_storage_type
            }
            if pkg_res_version and cache_res_version and "" ~= cache_res_version and VER_CHECK.compare_versions(pkg_res_version, cache_res_version) >= 0 then
              table.insert(incompatible_res_list, incompatible_data)
            end
          end
        end
      end
    end
    if next(incompatible_res_list) ~= nil then
      local list_size = #incompatible_res_list
      E.LOG.debug(TAG, "incompatible_res_list not empty, size:" .. tostring(list_size))
      local _index = 1
      local loop_process_fun
      
      function loop_process_fun(index)
        E.LOG.debug(TAG, "dispatch_cache_res_incompatible index:" .. tostring(index))
        local data = incompatible_res_list[index]
        local ns = data._namespace
        local rk = data._res_key
        local cache_res_version = data._cache_res_version
        local cache_res_type = data._cache_res_type
        local pkg_res_version = data._pkg_res_version
        local cache_res_key = data._cache_res_key
        local cache_res_infos = data._cache_res_infos
        local is_res_key_incompatible = rk ~= cache_res_key
        local is_version_incompatible = pkg_res_version ~= cache_res_version
        local res_save_storage_type = data._res_save_storage_type
        if is_res_key_incompatible then
          is_version_incompatible = false
        end
        local incompatible_data = {
          pkg_res_version = pkg_res_version,
          res_version = cache_res_version,
          res_key = rk,
          cache_res_key = cache_res_key,
          cache_res_type = cache_res_type,
          is_version_incompatible = is_version_incompatible,
          is_res_key_incompatible = is_res_key_incompatible
        }
        E.LOG.debug(TAG, "incompatible_data is >> ")
        E.LOG.debug(TAG, incompatible_data)
        if is_version_incompatible then
          E.LOG.debug(TAG, "version incompatible, now remove old version res")
          ER.remove_res_version(ns, cache_res_key, cache_res_version, {res_save_storage_type = res_save_storage_type})
        end
        if is_res_key_incompatible then
          E.LOG.debug(TAG, "res_key incompatible, now remove old res_key res")
          ER.remove_res_version(ns, cache_res_key, nil, {res_save_storage_type = res_save_storage_type})
        end
        if is_version_incompatible or is_res_key_incompatible then
          local group_rk_arr = RTM.static_get_res_group_rk_arr(ns, cache_res_key) or {}
          if next(group_rk_arr) then
            E.LOG.debug(TAG, "incompatible, now remove old group res")
            for _, group_rk in ipairs(group_rk_arr) do
              ER.remove_res_version(ns, group_rk, nil, {res_save_storage_type = res_save_storage_type})
              ER.publish_using_res_version(ns, group_rk, nil, nil, nil)
            end
          end
          local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
          ERS.static_remove_res_cache_files(ns, cache_res_key, nil, {res_save_storage_type = res_save_storage_type})
        end
        END.dispatch_cache_res_incompatible(ns, rk, incompatible_data, cache_res_infos, function(succ, ...)
          if succ then
            E.LOG.debug(TAG, "dispatch_cache_res_incompatible result:" .. tostring(succ))
            _index = _index + 1
            if _index <= list_size then
              loop_process_fun(_index)
            else
              E.LOG.debug(TAG, "dispatch_cache_res_incompatible all complete, now run next step")
              STAT.stat_on_cache_res_incompatible_end(true)
              complete_cb(true)
            end
          else
            local code, msg = ...
            E.LOG.debug(TAG, "dispatch_cache_res_incompatible result:" .. tostring(succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            STAT.stat_on_cache_res_incompatible_end(false, code, msg)
            complete_cb(false, code, msg)
          end
        end)
      end
      
      STAT.stat_on_cache_res_incompatible_begin()
      loop_process_fun(_index)
    else
      E.LOG.debug(TAG, "no incompatible res list, now run next step")
      complete_cb(true)
    end
  end
end

function M:_init(_module_mgr_instance)
  self._data = {module_instance = _module_mgr_instance}
end

function M:res_valid_check(cb)
  local res_valid_check_arr = {}
  local game_startup_params = SC.get_game_startup_params()
  if game_startup_params and next(game_startup_params) then
    for ns, ns_infos in pairs(game_startup_params) do
      for rk, rk_infos in pairs(ns_infos) do
        table.insert(res_valid_check_arr, {
          ns = ns,
          rk = rk,
          version = rk_infos.version
        })
      end
    end
    local total_count = #res_valid_check_arr
    local index = 0
    for _, info in ipairs(res_valid_check_arr) do
      END.dispatch_res_valid_check(info.ns, info.rk, function(check_result)
        index = index + 1
        if false == check_result then
          EL.LOG.debug(TAG, "res_key:" .. tostring(info.rk) .. " is invalid, now remove res")
          local game_res_local_infos = self._data.module_instance.game_res_local_infos() or {}
          local game_local_ns_info = game_res_local_infos[info.ns] or {}
          local game_local_rk_info = game_local_ns_info[info.rk] or {}
          local res_save_storage_type = game_local_rk_info.res_save_storage_type
          ER.remove_res_version(info.ns, info.rk, info.version, {res_save_storage_type = res_save_storage_type})
          ER.publish_using_res_version(info.ns, info.rk, nil, nil, nil)
          game_local_rk_info.version = game_local_rk_info.pkg_res_version
          EL.LOG.debug(TAG, "res_key:" .. tostring(info.rk) .. " is invalid res, change it's version to pkg_res_version" .. ", version is " .. tostring(game_local_rk_info.version) .. ", pkg_res_version is " .. tostring(game_local_rk_info.pkg_res_version))
        end
        if index == total_count then
          cb()
        end
      end)
    end
  else
    EL.LOG.debug(TAG, "do not need res_valid_check, params is empty, now return true")
    cb()
  end
end

function M:_init_cdn_config(cb)
  if start_init_states.state_cdn_config then
    EL.LOG.debug(TAG, "_init_cdn_config already succ, now return true")
    cb(true)
    return
  end
  
  local function init_cdn_result_cb(succ, ...)
    EL.LOG.debug(TAG, "_init_cdn_config result:" .. tostring(succ))
    start_init_states.state_cdn_config = succ
    cb(succ, ...)
  end
  
  EGC.init_config(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "init_config succ >>")
      STAT.init_jf()
      init_cdn_result_cb(true)
    else
      local status, message = ...
      E.LOG.warn(TAG, "init_config failed, status:" .. (status or "nil") .. ", message:" .. (message or "nil"))
      init_cdn_result_cb(false, status, message)
    end
  end)
end

function M:_check_app_update(cb)
  local game_enabled_update = E.CONFIG.get_config(E.CONFIG.KEY.APP_VERSION_UPDATE_CHECK_QZ)
  local config_enabled_update = SC.is_qz_startup_app_update_enable()
  if true == game_enabled_update and config_enabled_update then
    E.LOG.debug(TAG, "_check_app_update begin, enabled")
    local APP_Update = require("ejoysdk_lua.app_update.app_update")
    local update_params = {
      package_name = E.Sysinfo.package_name(),
      app_version_name = E.Sysinfo.app_version_name(),
      app_version_code = E.Sysinfo.app_version_code()
    }
    if APP_Update.is_app_update_checked() then
      cb(true)
    else
      APP_Update.set_windows_alert_callback(update_params, function(update_info, close_cb)
        END.dispatch_show_app_update_ui_listener(update_info, close_cb)
      end)
      APP_Update.check_update_app_version(function(_succ, ...)
        local _code, _msg = ...
        E.LOG.debug(TAG, "_check_app_update result:" .. tostring(_succ) .. ", code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
        local params = {
          p1 = E.Sysinfo.app_version_name(),
          p2 = E.Sysinfo.app_version_code()
        }
        STAT.stat_update_result(_succ, params, _code, _msg)
        cb(_succ, ...)
      end)
    end
  else
    E.LOG.debug(TAG, "_check_app_update begin, NOT enabled, skip")
    STAT.stat_app_update_not_enable(game_enabled_update, config_enabled_update)
    cb(true)
  end
end

function M:run()
  E.LOG.debug(TAG, "begin run")
  END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_UPDATE_PREPARING)
  
  local function check_app_update_cb(succ2, ...)
    if succ2 then
      EL.LOG.debug(TAG, "_app_update_check succ, startup_init finish, now run next")
      STAT.stat_startup_init_end(true)
      self:run_next()
    else
      local code, msg = ...
      E.LOG.debug(TAG, "_app_update_check failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      STAT.stat_startup_init_end(false, code, msg)
      self._data.module_instance.on_global_failed(code, msg)
    end
  end
  
  local function request_startup_config_cb(succ2, ...)
    if succ2 then
      EL.LOG.debug(TAG, "_request_startup_configs succ, startup_init finish, now run next")
      self:_check_app_update(function(succ, ...)
        check_app_update_cb(succ, ...)
      end)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "_request_startup_configs failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      STAT.stat_startup_init_end(false, code, msg)
      self._data.module_instance.on_global_failed(code, msg)
    end
  end
  
  local function init_cdn_cb(succ, ...)
    if succ then
      EL.LOG.debug(TAG, "_init_cdn_configs succ, now run next")
      self:_request_startup_configs(request_startup_config_cb)
    else
      local code, msg = ...
      EL.LOG.debug(TAG, "_init_cdn_configs failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      STAT.stat_startup_init_end(false, code, msg)
      self._data.module_instance.on_global_failed(code, msg)
    end
  end
  
  local function check_override_install_cb(succ1, ...)
    if succ1 then
      self:_init_cdn_config(init_cdn_cb)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "_check_for_override_install_startup failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      STAT.stat_startup_init_end(false, code, msg)
      self._data.module_instance.on_global_failed(code, msg)
    end
  end
  
  local function res_valid_check_cb()
    EL.LOG.debug(TAG, "res_valid_check end")
    self:_check_for_override_install_startup(check_override_install_cb)
  end
  
  local function res_init_callback(succ, ...)
    EL.LOG.debug(TAG, "res_init_callback result: " .. tostring(succ))
    if succ then
      self:res_valid_check(res_valid_check_cb)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "init failed due to ejoysdk_res init failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      STAT.stat_startup_init_end(false, code, msg)
      self._data.module_instance.on_global_failed(code, msg)
    end
  end
  
  STAT.stat_startup_init_begin()
  ER.init(res_init_callback)
end

return M
