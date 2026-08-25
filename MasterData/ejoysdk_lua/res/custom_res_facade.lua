local ERF = require("ejoysdk_lua.res.base_ejoysdk_res")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
M.NAMESPACES = {
  QZ_CUSTOM_RES = "qz_custom_res"
}
M.RES_INFO_KEY = RTM.USING_RES_INFO_PARAM_KEY
M.DOWNLOAD_STATE = RTM.PUBLIC_DOWNLOAD_STATE
M.RES_DOWNLOAD_STATE_KEY = RTM.RES_STATE_INFO_KEY
M.PROGRESS_INFO_KEY = RTM.PROGRESS_INFO_KEY
M.RES_STATE_INFOS = RTM.INFO_TYPE_KEY
M.UPDATE_INFO_KEY = RTM.UPDATE_INFO_KEY
M.USING_RES_INFO_KEY = RTM.USING_RES_STATE_INFO_KEY
M.FILE_LIST_ITEM_KEY = RTM.FILE_LIST_ITEM_KEY
M.NAMESPACE_UPDATE_OPTIONS = END.NAMESPACE_UPDATE_OPTIONS
M.STORAGE_TYPE = RTM.STORAGE_TYPE
local TAG = "CustomResFacade"

function M.check_res_update(params, update_cb)
  local inner_res_key = params.res_key
  local inner_res_version = params.version
  local inner_params = {
    using_res_info = {version = inner_res_version}
  }
  local opts = params.opts or {}
  ERF.check_namespace_res_update(ECC.NAMESPACE.QZ_CUSTOM_RES, inner_res_key, inner_params, opts, update_cb)
end

function M.check_and_update(res_info, opts, listeners)
  ERF.check_and_update(ECC.NAMESPACE.QZ_CUSTOM_RES, res_info, opts, listeners)
end

function M.get_res_state(_res_key)
  do return ERF.get_simple_res_state, ECC.NAMESPACE.QZ_CUSTOM_RES end
  return ERF.get_simple_res_state, ECC.NAMESPACE.QZ_CUSTOM_RES, _res_key
end

function M.get_res_all_state_info(_res_key, info_flags)
  do return ERF.get_res_state, ECC.NAMESPACE.QZ_CUSTOM_RES, _res_key end
  return ERF.get_res_state, ECC.NAMESPACE.QZ_CUSTOM_RES, _res_key, info_flags
end

function M.group_res_update(res_key, group_name, opts, listeners)
  ERF.group_res_update(ECC.NAMESPACE.QZ_CUSTOM_RES, res_key, group_name, opts, listeners)
end

function M.remove_res_version(_res_key, res_version, _opts)
  ER.remove_res_version(M.NAMESPACES.QZ_CUSTOM_RES, _res_key, res_version, _opts)
end

function M.repair(res_key)
  local cache_res_info = ERF.get_check_update_res_info_cache(M.NAMESPACES.QZ_CUSTOM_RES, res_key)
  local save_storage_type, apply_dest_path, using_version
  E.LOG.debug(TAG, "repair start, res_key:" .. tostring(res_key))
  E.log(cache_res_info)
  if cache_res_info and next(cache_res_info) then
    local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
    local UTILS = require("ejoysdk_lua.ejoysdk_utils")
    save_storage_type = cache_res_info.res_save_storage_type
    apply_dest_path = ER_UTILS.get_apply_dest_path(save_storage_type, cache_res_info.res_save_base_path)
    if not UTILS.is_text_empty(apply_dest_path) then
      local local_res_state = M.get_res_state(res_key)
      E.LOG.debug(TAG, "local_res_state >")
      E.log(local_res_state)
      using_version = local_res_state.using_version
    else
      E.LOG.warn(TAG, "repair get using_version failed, apply_dest_path is nil, storage_type:" .. tostring(save_storage_type) .. ", res_save_base_path:" .. tostring(cache_res_info.res_save_base_path))
    end
  end
  E.LOG.debug(TAG, "repair received, res_key:" .. tostring(res_key) .. ", using_version:" .. tostring(using_version) .. ", apply_dest_path:" .. tostring(apply_dest_path))
  ER.repair(M.NAMESPACES.QZ_CUSTOM_RES, res_key)
  if using_version then
    local FP = require("ejoysdk_lua.res.qz_file_list_parser")
    local target_file_list = FP.get_file_list_cache(M.NAMESPACES.QZ_CUSTOM_RES, res_key, nil, using_version, true, save_storage_type) or {}
    local current_file_list_info = RTM.static_get_using_res_file_list(apply_dest_path) or {}
    if next(current_file_list_info) then
      for _, item in ipairs(target_file_list) do
        current_file_list_info[item.to] = nil
      end
      RTM.static_update_using_res_file_list(apply_dest_path, current_file_list_info)
    end
  end
end

function M.publish_using_res_version(res_key, version)
  ER.publish_using_res_version(M.NAMESPACES.QZ_CUSTOM_RES, res_key, version, nil, nil)
end

function M.static_get_using_res_config_path(res_key)
  do return RTM.static_get_using_res_config_path, ECC.NAMESPACE.QZ_CUSTOM_RES end
  return RTM.static_get_using_res_config_path, ECC.NAMESPACE.QZ_CUSTOM_RES, res_key
end

return M
