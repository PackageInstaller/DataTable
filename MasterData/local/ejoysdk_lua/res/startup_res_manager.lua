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
  local _wrapper_listener = listeners
  if listeners and listeners.on_request_groups_filter then
    local MULTI_UPDATE = require("ejoysdk_lua.res.startup.startup_groups_update")
    local groups = {}
    _wrapper_listener = MULTI_UPDATE:New(groups, opts):multi_update_intercept(listeners)
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
  local res_ready_flow = SMM.get_module_by_name(SC.STARTUP_CORE_MODULE_NAME.RES_READY, M)
  init_module:SetSuccessor(self_update_module)
  self_update_module:SetSuccessor(update_prepare_flow)
  update_prepare_flow:SetSuccessor(check_update_flow)
  check_update_flow:SetSuccessor(res_ready_flow)
  init_module:run()
end

function M.game_res_local_infos()
  return game_res_local_infos
end

function M.is_startup_res_update_in_progress()
  return is_startup_res_update_in_progress
end

return M
