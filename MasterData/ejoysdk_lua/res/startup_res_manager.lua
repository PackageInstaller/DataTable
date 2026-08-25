local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local SMM = require("ejoysdk_lua.res.startup.startup_module_manager")
local STAT = require("ejoysdk_lua.res.res_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "STARTUP#" .. EM.MODULE.RES .. "startup_res_manager"
local DEFAULT_GAME_RES_NAMESPACE = "game_res_namespace"
local DEFAULT_RES_TYPE = "qz_patch"
local _game_res_namespace_list = {}
local ejoy_config_inited = false
local startup_update_opts
local game_res_local_infos = {}
local is_startup_res_update_in_progress = false

local function callback_global(succ, ...)
  is_startup_res_update_in_progress = false
  if not succ then
    local code, msg = ...
    E.LOG.warn(TAG, "callback_global failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    local type = tostring(msg) .. ":" .. tostring(code)
    STAT.stat_err("res_update_err", type, code, msg)
  else
    STAT.stat("res_update_succ", nil, true)
  end
  E.LOG.warn(TAG, "notify_startup_update_complete result:" .. tostring(succ))
  STAT.stat_on_startup_update_complete_begin()
  if succ then
    END.notify_startup_update_complete(true)
  else
    END.notify_startup_update_complete(false, ...)
  end
  STAT.stat_on_startup_update_complete_end(true)
end

function M.on_global_succ()
  END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_UPDATE_READY)
  EL.LOG.debug(TAG, "on_global_succ >>")
  callback_global(true)
  SMM.reload()
end

function M.on_global_failed(code, msg)
  STAT.stat_startup_res_update_end(false, code, msg)
  E.LOG.warn(TAG, "init_app_start_res failed for res ejoysdk_lua, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
  END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_UPDATE_FAILED, code, msg)
  callback_global(false, code, tostring(msg))
end

function M.init_startup_res(product_code, params, opts, listeners, ext)
  params = params or {}
  ext = ext or {}
  E.LOG.debug("init_startup_res begin")
  local init_config = params.init_config or params
  opts = opts or {}
  local force_update = opts.force_check_update
  if not ejoy_config_inited or force_update then
    E.LOG.debug(TAG, "begin init ejoy config")
    local EI = require("ejoysdk_lua.ejoysdk_init")
    EI.config(product_code, init_config)
    local product_code_config = E.CONFIG.get_config("product")
    if not product_code_config or "" == product_code_config then
      E.LOG.warn(TAG, "product code is invalid, return failed")
      if listeners and listeners.on_startup_update_complete then
        listeners.on_startup_update_complete(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "product code invalid")
      end
      return
    end
    local succ, _code, _msg = E.check_compatibility()
    if false == succ then
      if listeners and listeners.on_startup_update_complete then
        listeners.on_startup_update_complete(false, _code or CONSTANTS.ENV_ERROR.CODE_NOT_COMPATIBILITY, _msg or "Incompatible with your system")
      end
      return
    end
    ejoy_config_inited = true
  end
  local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
  local UIM = require("ejoysdk_lua.res.update_info_manager")
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local _origin_request_group_filter_listener = listeners and listeners.on_request_groups_filter
  local _origin_startup_res_update_complete_listener = listeners and listeners.on_startup_update_complete
  local _confirm_listener = listeners and listeners.on_confirm_res_update
  local _confirm_groups_info = {}
  local _wrapper_listener = listeners
  if params.res_info then
    listeners = listeners or {}
    local _namespace, _res_key = params.res_info.namespace, params.res_info.res_key
    
    function listeners.on_startup_update_complete(__succ, ...)
      E.LOG.d(TAG, "be-official update complete:" .. tostring(__succ))
      if true == __succ and PREDOWNLOAD_MGR.UTILS.will_become_official(_namespace, _res_key) then
        local _predownload_mgr = PREDOWNLOAD_MGR.static_get_mgr(_namespace, _res_key)
        _predownload_mgr:finish()
      end
      _origin_startup_res_update_complete_listener(__succ, ...)
    end
    
    function listeners.on_confirm_res_update(_update_res_info, ...)
      _update_res_info.ext = {update_groups = _confirm_groups_info}
      _confirm_listener(_update_res_info, ...)
    end
    
    function listeners.on_request_groups_filter(group_infos, confirm_cb)
      local UTILS = require("ejoysdk_lua.ejoysdk_utils")
      local _merge_filter_groups = {}
      local _tmp_merger_filter_groups = {}
      
      local function _insert_groups(_group_infos)
        if _group_infos and next(_group_infos) then
          for _, g_info in ipairs(_group_infos) do
            local _g_name = g_info.name
            if not _tmp_merger_filter_groups[_g_name] then
              _tmp_merger_filter_groups[_g_name] = g_info
              table.insert(_merge_filter_groups, g_info)
            end
          end
        end
      end
      
      local function _insert_official_groups()
        local _game_groups_info = {}
        if type(ext.groups_info) == "table" then
          for _, _g_g_info in ipairs(ext.groups_info) do
            _game_groups_info[_g_g_info.name] = {
              version = _g_g_info.version,
              pkg_res_version = _g_g_info.pkg_res_version
            }
          end
        end
        if PREDOWNLOAD_MGR.UTILS.will_become_official(_namespace, _res_key) then
          local CONFIG = require("ejoysdk_lua.res.predownload.predown_config")
          local become_official_groups = UTILS.deepcopy(CONFIG.get(CONFIG.KEY.GROUPS) or {})
          for _, g_info in ipairs(become_official_groups) do
            local _g_name = g_info.name
            local _g_g_info = _game_groups_info[_g_name]
            g_info.version = UIM.get_using_version(_namespace, GRM.get_task_key(_res_key, _g_name), _g_g_info)
          end
          _confirm_groups_info = UTILS.deepcopy(become_official_groups)
          _insert_groups(become_official_groups)
        end
      end
      
      if type(_origin_request_group_filter_listener) == "function" then
        _origin_request_group_filter_listener(group_infos, function(filter_groups)
          _insert_official_groups()
          _insert_groups(params.startup_groups)
          if type(filter_groups) == "table" and next(filter_groups) then
            _insert_groups(filter_groups)
          end
          confirm_cb(_merge_filter_groups)
        end)
      else
        _insert_official_groups()
        _insert_groups(params.startup_groups)
        confirm_cb(_merge_filter_groups)
      end
    end
    
    local MULTI_UPDATE = require("ejoysdk_lua.res.startup.startup_groups_update")
    _wrapper_listener = MULTI_UPDATE:New({}, opts):multi_update_intercept(listeners)
  end
  local ELF = require("ejoysdk_lua.ejoysdk_log_file")
  ELF.init()
  M.startup_check_update(params, opts, _wrapper_listener, ext)
end

function M.startup_check_update(params, opts, listeners, ext)
  is_startup_res_update_in_progress = true
  params = params or {}
  local current_res_info_arr = params.current_res_info_arr
  EL.LOG.debug(TAG, "startup_check_update begin")
  local EI = require("ejoysdk_lua.ejoysdk_init")
  local public_product_code = EI.get_public_product_code()
  SC.update_public_product_code(public_product_code)
  local qz_product_code = params.qz_product_code or public_product_code
  SC.update_qz_product_code(qz_product_code)
  startup_update_opts = opts
  E.log(opts)
  if current_res_info_arr and #current_res_info_arr > 0 then
    for _, loc_res_info in ipairs(current_res_info_arr) do
      local namespace = loc_res_info.namespace or DEFAULT_GAME_RES_NAMESPACE
      _game_res_namespace_list[namespace] = true
      local res_key = loc_res_info.res_key
      local _version = loc_res_info.version
      local _pkg_project_name = loc_res_info.pkg_project_name or ""
      local _game_res_save_base_path = loc_res_info.res_save_base_path
      local _game_res_save_storage_type = loc_res_info.res_save_storage_type
      local _pkg_res_version = loc_res_info.pkg_res_version
      local _pkg_res_path = loc_res_info.pkg_res_path
      local _res_type = loc_res_info.res_type or DEFAULT_RES_TYPE
      local _use_default_engine_handler = loc_res_info.use_default_engine_handler
      if nil == _version then
        EL.LOG.debug(TAG, "_version is nil, now check it")
        _version = _pkg_res_version
        local local_res_state = RTM.static_get_local_res_state(namespace, res_key) or {}
        local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
        local local_res_version = using_res_info.version
        if local_res_version then
          E.LOG.debug(TAG, "startup_check_update, local_res_version:" .. tostring(local_res_version))
          if local_res_version then
            EL.LOG.debug(TAG, "pkg_res_version is " .. tostring(_pkg_res_version) .. ", local res version is " .. tostring(local_res_version))
            if VER_CHECK.compare_versions(local_res_version, _version) > 0 then
              _version = local_res_version
              EL.LOG.debug(TAG, "_version use local_res_version")
            end
          end
        end
      end
      game_res_local_infos[namespace] = game_res_local_infos[namespace] or {}
      game_res_local_infos[namespace][res_key] = {
        version = _version,
        pkg_res_version = _pkg_res_version,
        pkg_res_path = _pkg_res_path,
        pkg_project_name = _pkg_project_name,
        res_save_base_path = _game_res_save_base_path,
        res_save_storage_type = _game_res_save_storage_type,
        res_type = _res_type,
        use_default_engine_handler = _use_default_engine_handler
      }
      local engine_handler = loc_res_info.engine_handler
      END.register_res_update_namespace(namespace, res_key, listeners, opts, engine_handler)
    end
  end
  local request_ext = {
    custom_infos = (ext or {}).filter_infos or {}
  }
  
  function M.get_startup_ext_info()
    return request_ext
  end
  
  SC.update_game_startup_params(game_res_local_infos, startup_update_opts)
  local init_module = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.INIT_FLOW, M)
  local self_update_module = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.SELF_UPDATE_FLOW, M)
  local update_prepare_flow = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_PREPARE, M)
  local check_update_flow = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_CHECK, M)
  local res_integrity_check = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.RES_INTEGRITY_CHECK, M)
  local res_ready_flow = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.RES_READY, M)
  init_module:SetSuccessor(self_update_module)
  self_update_module:SetSuccessor(update_prepare_flow)
  update_prepare_flow:SetSuccessor(check_update_flow)
  check_update_flow:SetSuccessor(res_integrity_check)
  res_integrity_check:SetSuccessor(res_ready_flow)
  init_module:run()
end

function M.game_res_local_infos()
  return game_res_local_infos
end

function M.is_startup_res_update_in_progress()
  return is_startup_res_update_in_progress
end

return M
