local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local ERF = require("ejoysdk_lua.res.base_ejoysdk_res")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local M = {}
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
local m_namespace = ECC.NAMESPACE.QZ_SUB_PACKAGE

function M.check_res_update(params, update_cb)
  local inner_res_key = params.res_key
  local inner_res_version = params.version
  local inner_params = {
    using_res_info = {version = inner_res_version}
  }
  local opts = params.opts or {}
  ERF.check_namespace_res_update(m_namespace, inner_res_key, inner_params, opts, update_cb)
end

function M.check_and_update(res_info, opts, listeners)
  ERF.check_and_update(m_namespace, res_info, opts, listeners)
end

function M.remove_res_version(_res_key, res_version, _opts)
  ER.remove_res_version(m_namespace, _res_key, res_version, _opts)
end

function M.repair(res_key)
  ER.repair(m_namespace, res_key)
end

function M.publish_using_res_version(res_key, version)
  ER.publish_using_res_version(m_namespace, res_key, version, nil, nil)
end

function M.get_res_state(_res_key)
  do return ERF.get_simple_res_state, m_namespace end
  return ERF.get_simple_res_state, m_namespace, _res_key
end

function M.get_res_all_state_info(_res_key)
  do return ERF.get_res_state, m_namespace end
  return ERF.get_res_state, m_namespace, _res_key
end

function M.static_get_using_res_config_path(res_key)
  do return RTM.static_get_using_res_config_path, m_namespace end
  return RTM.static_get_using_res_config_path, m_namespace, res_key
end

function M.update_res_download_strategy(res_key, strategy)
  ER.update_res_download_strategy(m_namespace, res_key, strategy)
end

return M
