local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UT = require("ejoysdk_lua.res.startup.modules.update_task")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local M = {}
local TAG = "SPLITPKG#" .. EM.MODULE.RES .. "splitpkg_res_manager"

function M.spitpkg_res_update(namespace, res_key, res_info, opts, listeners)
  E.LOG.debug(TAG, "splitpkg_res_update namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  END.register_res_update_namespace(namespace, res_key, listeners, opts, res_info.engine_handler)
  local path_valid, startup_pkg_res_path, config_pkg_res_path = M.check_pkg_res_path()
  if not path_valid then
    E.LOG.warn(TAG, "spitpkg_res_update failed, startup pkg_res_path not equals with config pkg_res_path, startup_pkg_res_path:" .. tostring(startup_pkg_res_path) .. ", config_pkg_res_path:" .. tostring(config_pkg_res_path))
    END.notify_splitpkg_update_complete(false, EC.SPLIT_PKG_CODE.PKG_RES_PATH_INVALID, "split pkg pkg res path not valid")
    return
  end
  local emf = require("ejoysdk_lua.res.ejoy_res_model_factory")
  emf.clear_ejoy_res_source_model(namespace, res_key)
  local sl = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
  sl.reset_file_list_cache()
  local EI = require("ejoysdk_lua.ejoysdk_init")
  local public_product_code = EI.get_public_product_code()
  SC.update_public_product_code(public_product_code)
  local qz_product_code = opts.qz_product_code or public_product_code
  SC.update_qz_product_code(qz_product_code)
  local local_res_state = RTM.static_get_local_res_state(namespace, res_key) or {}
  local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  local local_res_version = using_res_info.version
  local update_info = UIM.get_res_update_info(namespace, res_key, nil, local_res_version)
  E.LOG.debug(TAG, "splitpkg update info >>>")
  E.LOG.debug(TAG, update_info)
  
  local function update_splitpkg(_update_info, _namespace_ext)
    local current_res_params = {}
    current_res_params[namespace] = {}
    current_res_params[namespace][res_key] = {
      version = local_res_version,
      res_save_base_path = res_info.res_save_base_path,
      res_save_storage_type = res_info.res_save_storage_type
    }
    E.LOG.debug(TAG, "splitpkg res params is >>>>")
    E.LOG.debug(TAG, current_res_params)
    
    local function update_state_listener(_ns, _task_key, _state, _state_obj, ...)
      E.LOG.debug(TAG, "_update_state_listener ns:" .. tostring(_ns) .. ", task_key:" .. tostring(_task_key) .. ", state:" .. tostring(_state))
      E.log(_state_obj)
      _state_obj = _state_obj or {}
      if _state == UT.PUB_STATES.FINISH then
        E.LOG.debug(TAG, "state complete")
        END.notify_splitpkg_update_complete(true)
      elseif _state == UT.PUB_STATES.APPLY_FAILED or _state == UT.PUB_STATES.DOWNLOAD_FAILED or _state == UT.PUB_STATES.IDLE then
        local err_code = _state_obj.err_code
        local err_msg = _state_obj.err_msg
        E.LOG.warn(TAG, "resource process failed, ns:" .. tostring(_ns) .. ", task_key:" .. tostring(_task_key) .. ", state:" .. tostring(_state) .. ", code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        END.notify_splitpkg_update_complete(false, err_code, err_msg)
      end
    end
    
    local update_task = UT:New(namespace, res_key, update_info, using_res_info, _namespace_ext, current_res_params, opts, update_state_listener)
    update_task:reset(update_info, using_res_info)
  end
  
  if nil == update_info or nil == next(update_info) then
    local err_code = EC.RESOURCE_UPDATE_ERROR_CODES.RES_UPDATE_INFO_EMPTY
    local err_msg = "update info is empty, should call default startup update function first"
    E.LOG.warn(TAG, "request_update_info failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
    END.notify_splitpkg_update_complete(false, err_code, err_msg)
    return
  else
    local namespace_ext = res_info.namespace_ext
    update_splitpkg(update_info, namespace_ext)
  end
end

function M.is_local_res_complete()
  local is_complete = true
  local si = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
  local is_split_pkg = si.is_split_pkg()
  local is_res_downloaded
  if is_split_pkg then
    is_res_downloaded = si.is_split_pkg_downloaded()
    is_complete = is_res_downloaded
  end
  E.LOG.debug(TAG, "is_local_res_complete:" .. tostring(is_complete) .. ", is_split_pkg:" .. tostring(is_split_pkg) .. ", is_res_downloaded:" .. tostring(is_res_downloaded))
  return is_complete
end

function M.get_pkg_res_path()
  local si = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
  do return end
  return si.get_pkg_res_path
end

function M.check_pkg_res_path()
  local si = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
  do return end
  return si.check_pkg_res_path
end

function M.get_removed_res_list()
  local si = require("ejoysdk_lua.res.startup.interceptors.split_pkg_interceptor")
  do return end
  return si.get_removed_res_list
end

return M
