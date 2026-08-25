local E = require("ejoysdk_lua.ejoysdk")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local M = {}
local TAG = "STARTUP#startup_utils"
local _is_override_install, _can_reuse_res
local LAST_APP_VERSION_NAME = E.LazyKeyStore:New("EJOY_STARTUP_LAST_APP_VERSION_NAME", false, false, false)
local LAST_APP_VERSION_CODE = E.LazyKeyStore:New("EJOY_STARTUP_LAST_APP_VERSION_CODE", false, false, false)
local LAST_PKG_RES_VERSION = E.LazyKeyStore:New("EJOY_STARTUP_LAST_PKG_RES_VERSION", false, false, false)

local function _is_override_install_startup()
  local is_override
  local app_version_name = E.Sysinfo.app_version_name()
  local app_version_code = E.Sysinfo.app_version_code()
  local last_app_version_name = LAST_APP_VERSION_NAME:get()
  local last_app_version_code = LAST_APP_VERSION_CODE:get()
  LAST_APP_VERSION_NAME:set(app_version_name)
  LAST_APP_VERSION_CODE:set(app_version_code)
  _ejoysdk.log(TAG .. "is_override_install_startup an:" .. tostring(app_version_name) .. ", ac:" .. tostring(app_version_code) .. ", lan:" .. tostring(last_app_version_name) .. ", lac:" .. tostring(last_app_version_code))
  if nil == last_app_version_name then
    _ejoysdk.log(TAG .. "#is_override_install result false, last_app_version_name is nil")
    is_override = false
  elseif last_app_version_name ~= app_version_name then
    _ejoysdk.log(TAG .. "#is_override_install result true, last_app_version_name:" .. tostring(last_app_version_name) .. ", cur app_version_name:" .. tostring(app_version_name))
    is_override = true
  else
    _ejoysdk.log(TAG .. "#app_version_name is same")
    if nil ~= last_app_version_code and tostring(last_app_version_code) ~= tostring(app_version_code) then
      _ejoysdk.log(TAG .. "#is_override_install result true, last_app_version_code:" .. tostring(last_app_version_code) .. ", cur app_version_code:" .. tostring(app_version_code))
      is_override = true
    else
      is_override = false
    end
  end
  _ejoysdk.log(TAG .. "#is_override_install_startup: " .. tostring(is_override))
  return is_override
end

function M.is_override_install_startup()
  if nil ~= _is_override_install then
    _ejoysdk.log(TAG .. "#is_override_install_startup cached: " .. tostring(_is_override_install))
    return _is_override_install
  end
  local startup_local_res_info = SC.get_startup_local_res_infos()
  local pkg_res_version = startup_local_res_info.pkg_res_version
  local last_pkg_res_version = LAST_PKG_RES_VERSION:get()
  if not last_pkg_res_version then
    _is_override_install = false
  elseif not UTIL.is_text_empty(pkg_res_version) then
    if pkg_res_version == last_pkg_res_version then
      _is_override_install = _is_override_install_startup()
    else
      _is_override_install = true
    end
  else
    _is_override_install = _is_override_install_startup()
  end
  return _is_override_install
end

function M._test_mock_is_override_install()
  E.LOG.debug(TAG, "mock is_override_install = true")
  _is_override_install = true
end

function M.update_last_version_info()
  local startup_local_res_info = SC.get_startup_game_origin_params()
  local pkg_res_version = (startup_local_res_info or {}).pkg_res_version
  if not UTIL.is_text_empty(pkg_res_version) then
    LAST_PKG_RES_VERSION:set(pkg_res_version)
  end
  local app_version_name = E.Sysinfo.app_version_name()
  local app_version_code = E.Sysinfo.app_version_code()
  LAST_APP_VERSION_NAME:set(app_version_name)
  LAST_APP_VERSION_CODE:set(app_version_code)
  local SUB_INTERCEPT = require("ejoysdk_lua.res.startup.interceptors.sub_pkg_interceptor.sub_pkg_interceptor")
  if M.can_reuse_res() == true and true == SUB_INTERCEPT.is_sub_pkg() then
    SUB_INTERCEPT.mark_complete()
  end
end

local function has_pkg_res_file_list(pkg_res_path)
  local RES_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
  local pkg_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(pkg_res_path, true)
  do return pkg_res_qz_local_file_list.exists end
  return pkg_res_qz_local_file_list.exists, pkg_res_qz_local_file_list
end

function M.can_reuse_res()
  if nil == _can_reuse_res then
    local SPM = require("ejoysdk_lua.res.splitpkg_res_manager")
    local is_override_install = M.is_override_install_startup()
    local is_local_res_complete = SPM.is_local_res_complete()
    E.LOG.debug(TAG, "can_reuse_res:" .. tostring(is_override_install) .. ", is_local_res_complete:" .. tostring(is_local_res_complete))
    if is_override_install or not is_local_res_complete then
      local GMR = require("ejoysdk_lua.res.group_res_manager")
      local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
      local startup_local_res_info = SC.get_startup_game_origin_params() or {}
      E.LOG.d("demonk", {startup_local_res_info = startup_local_res_info})
      local namespace = startup_local_res_info.namespace
      local res_key = startup_local_res_info.res_key and GMR.get_real_res_key(startup_local_res_info.res_key)
      local pkg_res_path = startup_local_res_info.pkg_res_path
      pkg_res_path = pkg_res_path or SPM.get_pkg_res_path()
      E.LOG.debug(TAG, "can_reuse_res pkg_res_path:" .. tostring(pkg_res_path))
      local has_process_file_list_handler = END.check_has_process_file_list_handler(namespace, res_key)
      local _has_pkg_file_list = has_pkg_res_file_list(pkg_res_path)
      E.LOG.debug(TAG, "can_reuse_res: has_process_file_list_handler:" .. tostring(has_process_file_list_handler) .. ", engine handler on_process_file_list type:" .. tostring(type((startup_local_res_info.engine_handler or {}).on_process_file_list)) .. ", startup pkg_res_path:" .. tostring(pkg_res_path) .. ", has_pkg_res_file_list:" .. tostring(has_pkg_res_file_list(pkg_res_path)))
      _can_reuse_res = (true == has_process_file_list_handler or type((startup_local_res_info.engine_handler or {}).on_process_file_list) == "function") and not UTIL.is_text_empty(pkg_res_path) and _has_pkg_file_list
    else
      _can_reuse_res = false
    end
  end
  E.LOG.debug(TAG, "can_reuse_res result:" .. tostring(_can_reuse_res))
  return _can_reuse_res
end

return M
