local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local startup_local_res_infos_cache = E.LazyKeyStore:New("EJOYSDK_START_UP_LOCAL_RES_INFO", false, true, false)
local startup_update_infos_cache = E.LazyKeyStore:New("EJOYSDK_START_UP_UPDATE_INFOS", false, true, false)
local startup_namespace_ext_info_cache = E.LazyKeyStore:New("EJOYSDK_START_UP_NAMESPACE_EXT_INFOS", false, true, false)
local startup_game_params_cache = E.LazyKeyStore:New("EJOYSDK_START_UP_GAME_PARAMS", false, true, false)
local M = {}
local TAG = "STARTUP#startup_res_config"
M.STARTUP_NAMESPACES = {
  QZ_CONFIG = ECC.NAMESPACE.QZ_CONFIG,
  QZ_BOOT = ECC.NAMESPACE.QZ_BOOT,
  QZ_PATCH = ECC.NAMESPACE.QZ_PATCH,
  APM = ECC.NAMESPACE.APM,
  APP_UPDATE = ECC.NAMESPACE.APP_UPDATE
}
M.DISABLE_UPDATE_CACHE_NS_ARR = {
  M.STARTUP_NAMESPACES.QZ_CONFIG,
  M.STARTUP_NAMESPACES.QZ_BOOT,
  M.STARTUP_NAMESPACES.QZ_PATCH
}
M.QZ_CONFIG_KEYS = {
  QZ_ENDPOINTS = "qz_endpoints",
  REVIEW_CONFIG = "review_config",
  PRODUCT_CODE = "product_code",
  IS_REVIEW = "is_review"
}
M.STARTUP_CORE_MODULE_NAME = {
  INIT_FLOW = "STARTUP#INIT",
  SELF_UPDATE_FLOW = "STARTUP#SELF_UPDATE",
  RES_UPDATE_PREPARE = "STARTUP#RES_UPDATE_PREPARE",
  RES_UPDATE_CHECK = "STARTUP#RES_UPDATE_CHECK",
  RES_UPDATE_APPLY = "STARTUP#RES_UPDATE_APPLY",
  RES_INTEGRITY_CHECK = "STARTUP#RES_INTEGRITY_CHECK",
  RES_READY = "STARTUP#RES_READY_FLOW"
}
M.PUB_STARTUP_STATES = {
  STARTUP_UPDATE_PREPARING = "startup_update_preparing",
  STARTUP_UPDATE_PREPARE_SUCC = "startup_update_prepare_succ",
  STARTUP_LOCAL_RES_CHECKING = "startup_local_res_checking",
  STARTUP_RES_DOWNLOADING = "startup_res_downloading",
  STARTUP_RES_DOWNLOAD_COMPLETE = "startup_res_download_complete",
  STARTUP_RES_APPLYING = "startup_res_applying",
  STARTUP_RES_APPLY_SUCC = "startup_res_apply_succ",
  STARTUP_UPDATE_READY = "startup_update_ready",
  STARTUP_UPDATE_FAILED = "startup_update_failed"
}
M.DEBUG = {
  debuggable = true,
  TestOverride = false,
  TestResKeyIncompatible = false,
  TestVersionIncompatible = false
}
M.RES_TYPE_EJOY_LUA = "ejoysdk_lua"
local DEFAULT_MAX_RETRY_TIMES = 3
local public_startup_config = {}
local review_startup_config = {}
local boot_res_update_info = {}
local game_startup_res_infos = {}
local ns_ext_infos = {}
local startup_local_res_infos = {}
local gm_params_local_res_infos = {}
local gm_params_update_opts = {}
local is_force_check_update = false
local max_retry_times = DEFAULT_MAX_RETRY_TIMES
local app_review_state = false
local in_review_state_with_productcode_changes = false
local review_product_code, public_product_code, qz_product_code, qz_startup_enable_app_update, update_file_list

function M.update_public_startup_config(_startup_config)
  public_startup_config = _startup_config or {}
end

function M.update_review_startup_config(_review_startup_config)
  review_startup_config = _review_startup_config
end

function M.get_public_startup_config()
  return public_startup_config
end

function M.get_review_startup_config()
  return review_startup_config
end

function M.update_boot_res_update_info(update_info)
  boot_res_update_info = update_info or {}
end

function M.get_boot_res_update_info()
  return boot_res_update_info
end

function M.update_game_startup_res_update_infos(update_infos)
  E.LOG.debug(TAG, "update_game_startup_res_update_infos received")
  game_startup_res_infos = update_infos or {}
end

function M.get_game_startup_res_update_infos()
  local infos = game_startup_res_infos
  return infos
end

function M.update_namespace_ext_infos(_ns_ext_infos)
  ns_ext_infos = _ns_ext_infos or {}
  startup_namespace_ext_info_cache:set(ns_ext_infos)
end

function M.get_namespace_ext_infos()
  local infos = ns_ext_infos
  return infos
end

function M.get_namespace_ext_infos_cache()
  return startup_namespace_ext_info_cache:get() or {}
end

function M.update_startup_local_res_infos(_local_res_params)
  startup_local_res_infos = _local_res_params or {}
  startup_local_res_infos_cache:set(startup_local_res_infos)
end

function M.get_startup_local_res_infos()
  local infos = startup_local_res_infos
  return infos
end

function M.get_startup_local_res_infos_cache()
  return startup_local_res_infos_cache:get() or {}
end

function M.get_startup_update_infos()
  return startup_update_infos_cache:get() or {}
end

function M.update_startup_update_infos(update_infos)
  startup_update_infos_cache:set(update_infos)
end

function M.update_game_startup_params(_game_res_local_infos, _startup_update_opts)
  gm_params_local_res_infos = _game_res_local_infos or {}
  gm_params_update_opts = _startup_update_opts or {}
  is_force_check_update = gm_params_update_opts.force_check_update
  max_retry_times = gm_params_update_opts.max_retry_times or DEFAULT_MAX_RETRY_TIMES
  E.LOG.debug(TAG, "update_game_startup_params is_force_check_update:" .. tostring(is_force_check_update))
end

function M.is_force_check_update()
  return is_force_check_update
end

function M.get_game_startup_params()
  return gm_params_local_res_infos, gm_params_update_opts
end

function M.get_max_retry_times()
  return max_retry_times
end

function M.is_qz_pcode_equals_current_pcode()
  local current_product_code = M.get_current_product_code()
  local upper_current_product_code = current_product_code and current_product_code:upper()
  local upper_qz_product_code = qz_product_code and qz_product_code:upper()
  return upper_current_product_code and upper_qz_product_code and upper_current_product_code == upper_qz_product_code
end

function M.update_review_state(_is_review, _review_product_code)
  E.LOG.debug(TAG, "update_review_state:" .. tostring(_is_review) .. ", review_product_code:" .. tostring(_review_product_code) .. ", public_product_code:" .. tostring(public_product_code))
  app_review_state = _is_review or false
  review_product_code = _review_product_code
  local upper_public_product_code = public_product_code and public_product_code:upper()
  local upper_review_product_code = review_product_code and review_product_code:upper()
  if _is_review and upper_public_product_code and upper_review_product_code and upper_public_product_code ~= upper_review_product_code then
    in_review_state_with_productcode_changes = true
  else
    in_review_state_with_productcode_changes = false
  end
  return in_review_state_with_productcode_changes
end

function M.update_public_product_code(product_code)
  E.LOG.debug(TAG, "update_public_product_code:" .. tostring(product_code))
  public_product_code = product_code
end

function M.update_qz_product_code(_product_code)
  E.LOG.debug(TAG, "update_qz_product_code:" .. tostring(_product_code))
  qz_product_code = _product_code
end

function M.get_review_state()
  return app_review_state, in_review_state_with_productcode_changes, review_product_code
end

function M.get_review_product_code()
  return review_product_code
end

function M.get_public_product_code()
  return public_product_code
end

function M.get_qz_product_code()
  return qz_product_code
end

function M.get_current_product_code()
  local cur_product_code = E.CONFIG.get_config("product")
  return cur_product_code
end

function M.is_qz_startup_app_update_enable()
  if type(qz_startup_enable_app_update) == "boolean" then
    return qz_startup_enable_app_update
  end
  local ecc = require("ejoysdk_lua.ejoysdk_config_center")
  local biz_config = ecc.get_config(ecc.NAMESPACE.EJOYSDK_BIZ)
  if biz_config and biz_config.config and biz_config.config.qz_update_configs then
    local qz_update_server_config = biz_config.config.qz_update_configs
    E.LOG.debug(TAG, "get qz_update_configs in init>>")
    E.log(qz_update_server_config)
    qz_startup_enable_app_update = qz_update_server_config.qz_startup_enable_app_update
  end
  if nil == qz_startup_enable_app_update then
    qz_startup_enable_app_update = true
  end
  E.LOG.debug(TAG, "is_qz_startup_app_update_enable result:" .. tostring(qz_startup_enable_app_update))
  return qz_startup_enable_app_update
end

function M._test_reset_qz_startup_enable_app_update()
  qz_startup_enable_app_update = nil
end

function M.update_startup_game_origin_params(params)
  startup_game_params_cache:set(params or {})
end

function M.get_startup_game_origin_params()
  return startup_game_params_cache:get() or {}
end

function M.set_startup_update_file_list(_list)
  update_file_list = _list
end

function M.get_startup_update_file_list()
  return update_file_list
end

return M
