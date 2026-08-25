local EU = require("ejoysdk_lua.ejoysdk_utils")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
M.NAMESPACES = {GAME_RES = "GAME_RES"}
M.RES_INFO_KEY = RTM.USING_RES_INFO_PARAM_KEY
M.DOWNLOAD_STATE = RTM.PUBLIC_DOWNLOAD_STATE
M.RES_DOWNLOAD_STATE_KEY = RTM.RES_STATE_INFO_KEY
M.PROGRESS_INFO_KEY = RTM.PROGRESS_INFO_KEY
M.RES_STATE_INFOS = RTM.INFO_TYPE_KEY
M.UPDATE_INFO_KEY = RTM.UPDATE_INFO_KEY
M.USING_RES_INFO_KEY = RTM.USING_RES_STATE_INFO_KEY
M.FILE_LIST_ITEM_KEY = RTM.FILE_LIST_ITEM_KEY
M.NAMESPACE_UPDATE_OPTIONS = END.NAMESPACE_UPDATE_OPTIONS
M.NAMESPACE_UPDATE_EXT_INFOS = {
  QZ_PRODUCT_CODE = "qz_product_code"
}
M.STARTUP_UPDATE_OPTIONS = END.STARTUP_UPDATE_OPTIONS
M.NAMESPACE_RES_UPDATE_OPTIONS = END.NAMESPACE_RES_UPDATE_OPTIONS
M.STORAGE_TYPE = RTM.STORAGE_TYPE
M.STARTUP_NAMESPACES = SC.STARTUP_NAMESPACES
M.STARTUP_UPDATE_STATES = SC.PUB_STARTUP_STATES
M.TOPIC_STARTUP_UPDATE_STATE_CHANGED = ET.qz_startup_update.QZ_STARTUP_UPDATE_STATE_CHANGED
M.FILE_LIST_TYPE = RTM.FILE_LIST_TYPE
M.STORAGE_TYPE = ERB.STORAGE_TYPE
M.STARTUP_CONFIG_KEY = END.STARTUP_CONFIG_KEY

function M.startup_check_update(current_res_info_arr, opts, listeners, ext_infos)
  local EM = require("ejoysdk_lua.res.startup_res_manager")
  ext_infos = ext_infos or {}
  local params = {
    current_res_info_arr = current_res_info_arr,
    qz_product_code = ext_infos[M.NAMESPACE_UPDATE_EXT_INFOS.QZ_PRODUCT_CODE]
  }
  EM.startup_check_update(params, opts, listeners)
end

function M.init_startup_res(product_code, params, opts, listeners)
  local EM = require("ejoysdk_lua.res.startup_res_manager")
  EM.init_startup_res(product_code, params, opts, listeners)
end

function M.check_namespace_res_update(namespace, res_key, params, opts, update_cb)
  ER.check_namespace_res_update(namespace, res_key, params, opts, update_cb)
end

function M.confirm_update_namespace_res(namespace, res_key, res_ver, params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
  ER.confirm_update_namespace_res(namespace, res_key, res_ver, params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
end

function M.register_res_update_namespace(namespace, listeners, opts)
  ER.register_res_update_namespace(namespace, listeners, opts)
end

function M.unregister_res_update_namespace(namespace)
  ER.unregister_res_update_namespace(namespace)
end

function M.publish_res_update(_namespace, _res_key, _res_version, _ext)
end

function M.get_game_res_locations()
  do return M.get_res_locations end
  return M.get_res_locations, M.NAMESPACES.GAME_RES
end

function M.get_game_res_location(res_key)
  do return M.get_res_location, M.NAMESPACES.GAME_RES end
  return M.get_res_location, M.NAMESPACES.GAME_RES, res_key
end

function M.get_res_locations(namespace)
  if EU.is_text_empty(namespace) then
    return nil, EC.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "namespace is invalid"
  end
  do return ER.get_res_locations_with_namespace end
  return ER.get_res_locations_with_namespace, namespace, "namespace is invalid"
end

function M.get_res_location(namespace, res_key)
  if EU.is_text_empty(namespace) or EU.is_text_empty(res_key) then
    return nil, EC.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "namespace or res_key is invalid"
  end
  do return ER.get_res_location_with_namespace, namespace end
  return ER.get_res_location_with_namespace, namespace, res_key
end

function M.get_game_res_states()
end

function M.get_game_res_state(_res_key)
end

function M.get_res_states(_namespace)
  do return ER.get_res_states end
  return ER.get_res_states, _namespace
end

function M.get_res_state(_namespace, _res_key)
  do return ER.get_res_state, _namespace end
  return ER.get_res_state, _namespace, _res_key
end

function M.start_download_game_res(_res_key)
end

function M.stop_download_game_res(_res_key, _cb)
end

function M.remove_download_game_res(_res_key, _cb)
end

function M.start_download(_namespace, _res_key)
end

function M.stop_download(_namespace, _res_key, _cb)
end

function M.remove_download(_namespace, _res_key, _cb)
end

function M.register_res_state_listener(namespace, res_key, listener)
  ER.register_res_state_change_listener(namespace, res_key, listener)
end

function M.unregister_res_state_listener(namespace, res_key, listener)
  ER.unregister_res_state_change_listener(namespace, res_key, listener)
end

function M.register_res_progress_listener(namespace, res_key, listener)
  ER.register_res_progress_listener(namespace, res_key, listener)
end

function M.unregister_res_progress_listener(namespace, res_key, listener)
  ER.unregister_res_progress_listener(namespace, res_key, listener)
end

function M.publish_using_res_version(namespace, res_key, res_version, res_project_name)
  ER.publish_using_res_version(namespace, res_key, res_version, res_project_name)
end

function M.remove_res_version(namespace, res_key, res_version)
  ER.remove_res_version(namespace, res_key, res_version)
end

function M.unsubscribe_startup_state_changed(listener)
  END.unsubscribe_startup_state_changed(listener)
end

function M.subscribe_startup_state_changed(listener)
  END.subscribe_startup_state_changed(listener)
end

function M.download_res_files(namespace, res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
  ER.download_res_files(namespace, res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
end

function M.get_storage_path_by_type(storage_type)
  storage_type = storage_type or M.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  local storage_type_path_base = ERB.static_get_storage_path_by_type(storage_type)
  local storage_dir = E.Utils.trim_end(storage_type_path_base, "/")
  return storage_dir
end

return M
