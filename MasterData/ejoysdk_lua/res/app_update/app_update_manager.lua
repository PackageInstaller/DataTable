local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local VC = require("ejoysdk_lua.ejoysdk_version_check")
local LANG = require("ejoysdk_lua.lang.util")
local MB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local BER = require("ejoysdk_lua.res.base_ejoysdk_res")
local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local BUM = require("ejoysdk_lua.res.download_setting.background_update_manager")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ES = require("ejoysdk_lua.ejoysdk_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Class = require("ejoysdk_lua.ejoysdk_class")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local MODEL_NAME = "EjoyAppUpdate#Manger"
local PACK_CONFIG_FILE
do
  local _os = E.Sysinfo.os()
  if "ios" == _os then
    PACK_CONFIG_FILE = "ejoysdk/ejoy_pack_config.json"
  elseif "android" == _os then
    PACK_CONFIG_FILE = "unisdk/ejoy_pack_config.json"
  elseif "harmonyos" == _os then
    PACK_CONFIG_FILE = "ejoysdk/ejoy_pack_config.json"
  elseif "windows" == _os then
    PACK_CONFIG_FILE = "ejoy_pack_config.json"
  else
    PACK_CONFIG_FILE = "ejoy_pack_config.json"
  end
end
local M = {}
local TAG = MODEL_NAME
M.APP_UPDATE_NAMESPACE = ECC.NAMESPACE.APP_UPDATE
M.APP_UPDATE_STATE = {
  DOWNLOAD_NOT_STARTED = "download_not_started",
  DOWNLOADING = "downloading",
  DOWNLOAD_FAILED = "download_failed",
  DOWNLOAD_STOPPED = "download_stopped",
  DOWNLOAD_COMPLETE = "download_complete",
  DOWNLOAD_WAITING = "download_waiting",
  INSTALLING = "installing",
  INSTALL_FAILED = "install_failed",
  PKG_AUTO_REMOVED = "pkg_auto_removed",
  INSTALL_SUCCESS = "install_success"
}
local UPDATE_URL_TYPE = {DOWNLOAD = "download", STORE = "store"}
local ANDROID_INSTALL_DIR_PATH = "ejoysdk_file_provider"
local WINDOWS_INSTALL_DIR_PATH = ANDROID_INSTALL_DIR_PATH
local WINDOW_INSTALL_INFO_JSON = "ejoysdk_install.json"
local game_listeners = {}
local app_update_res_src_model
local Controller = Class:Inherit("EjoyQzAppUpdateController")
local APP_UPDATE_STEP = {DOWNLOAD = "download", INSTALL = "install"}
local app_update_res_key
local app_update_install_version_key_store = E.LazyKeyStore:New("app_update_install_version")
local app_update_download_version_key_store = E.LazyKeyStore:New("app_update_download_version")
local app_update_state_change_listeners = {}
local app_update_manager_static_info = {
  current_version = "0",
  latest_version = "0",
  has_app_update_config = false,
  need_app_update = false,
  is_mandatory_force_update = false,
  show_popup = false,
  update_url = "",
  update_url_type = nil,
  state = M.APP_UPDATE_STATE.DOWNLOAD_NOT_STARTED,
  download_info = nil,
  size = 0,
  error_info = nil
}

local function reset_app_update_manager_static_info()
  app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_NOT_STARTED
  app_update_manager_static_info.download_info.percent = 0
  app_update_manager_static_info.download_info.downloading_size = 0
  app_update_manager_static_info.download_info.finish_count = 0
  app_update_manager_static_info.error_info = nil
end

local function trigger_app_update_state_change_listeners()
  local data = {
    download_info = app_update_manager_static_info.download_info,
    state = app_update_manager_static_info.state,
    state_info = app_update_manager_static_info.error_info and {
      code = app_update_manager_static_info.error_info.code,
      msg = app_update_manager_static_info.error_info.msg
    } or {}
  }
  for _, listener in ipairs(app_update_state_change_listeners) do
    if type(listener) == "function" then
      listener(data)
    else
      E.LOG.error(TAG, "trigger_app_update_state_change_listeners: listener is not function")
    end
  end
end

function M.get_app_install_success()
  local app_install_version = app_update_install_version_key_store:get()
  local current_version = M.get_app_update_current_version()
  E.LOG.debug(TAG, "get_app_install_success app_install_version: " .. tostring(app_install_version) .. ", current version: " .. tostring(current_version))
  return 0 == VC.compare_versions(app_install_version, current_version)
end

function M.remove_state_change_listener(listener)
  for i, v in ipairs(app_update_state_change_listeners) do
    if v == listener then
      table.remove(app_update_state_change_listeners, i)
      return
    end
  end
end

local function get_pack_version_info()
  local pack_config_content = _ejoysdk.lread(PACK_CONFIG_FILE)
  local pack_config = JSON.safe_decode(pack_config_content)
  if not pack_config then
    E.LOG.warn(TAG, "load_game_res_config: failed to decode config content")
    return nil
  end
  local version_code = E.Sysinfo.app_version_code()
  local version_name = E.Sysinfo.app_version_name()
  return {
    main_version = pack_config.main_version,
    build = pack_config.build,
    version_code = version_code,
    version_name = version_name
  }
end

local pack_version_info = get_pack_version_info()

local function format_version_number(value)
  local str = tostring(value)
  if not str:match("^%d+$") then
    return str
  end
  local trimmed = str:match("^0*(%d+)")
  return trimmed
end

local current_version

function M.get_app_update_current_version()
  if not UTILS.is_text_empty(current_version) then
    return current_version
  end
  if not pack_version_info then
    E.LOG.warn(TAG, "get_app_update_current_version: pack_version_info is empty use 1.0.0 version")
    current_version = "1.0.0"
    return current_version
  end
  local main_version = pack_version_info.main_version
  local version_code = pack_version_info.version_code
  local build = pack_version_info.build
  local number_main_version = format_version_number(main_version)
  local number_version_code = format_version_number(version_code)
  local number_build = format_version_number(build)
  if E.Sysinfo.os() == "ios" then
    local str = tostring(version_code)
    if not str:match("^%d+$") then
      E.LOG.warn(TAG, "ios get_app_update_current_version: version_code is not number")
      number_version_code = 1
    end
  end
  if not (number_main_version and number_version_code) or not number_build then
    E.LOG.warn(TAG, string.format("get_app_update_current_version invalid, origin main_version: %s, version_code: %s, build: %s", tostring(main_version), tostring(version_code), tostring(build)))
    E.LOG.warn(TAG, string.format("get_app_update_current_version invalid, format_version_number main_version: %s, version_code: %s, build: %s", tostring(number_main_version), tostring(number_version_code), tostring(number_build)))
  end
  current_version = string.format("%s.%s.%s", number_main_version or 1, number_version_code or 0, number_build or 0)
  return current_version
end

local function get_pkg_save_path()
  local os = E.Sysinfo.os()
  if "android" == os then
    return "files/" .. ANDROID_INSTALL_DIR_PATH
  elseif "windows" == os then
    return WINDOWS_INSTALL_DIR_PATH
  else
    E.LOG.error(TAG, "get_pkg_save_path os is not android or windows, os: " .. tostring(os))
    return ""
  end
end

local function get_pkg_download_full_path()
  local os = E.Sysinfo.os()
  local file_dir = E.File.get_ext_file_dir()
  if "android" == os then
    do return E.Path.join, file_dir end
    return E.Path.join, file_dir, ANDROID_INSTALL_DIR_PATH, nil, nil
  elseif "windows" == os then
    do return E.Path.join, file_dir end
    return E.Path.join, file_dir, WINDOWS_INSTALL_DIR_PATH, nil, nil
  else
    E.LOG.debug(TAG, "get_pkg_download_full_path os is not android or windows return nil, os: " .. tostring(os))
    return ""
  end
end

local function get_pkg_install_file_infos()
  local pkg_download_full_path = get_pkg_download_full_path()
  local local_file_list_path = E.Path.join(pkg_download_full_path, RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST)
  E.LOG.debug(TAG, "get_pack_version_info, local_file_list_path: " .. tostring(local_file_list_path))
  local exits = E.File.exists(local_file_list_path, true)
  if true ~= exits then
    E.LOG.debug(TAG, "get_pkg_install_file_infos: local_file_list_path not exits")
    return {}
  end
  local local_file_list_content = E.File.readfile_fullpath(local_file_list_path)
  local local_file_list_json = JSON.safe_decode(local_file_list_content) or {}
  local file_name, file_info = next(local_file_list_json)
  local md5 = file_info and file_info.md5 or nil
  E.LOG.debug(TAG, "get_pack_version_info, file_name: " .. tostring(file_name) .. ", md5: " .. tostring(md5))
  if not file_name or not md5 then
    E.LOG.error(TAG, "get_pkg_install_file_infos: file_name or md5 is empty")
    return {}
  end
  local file_path = E.Path.join(pkg_download_full_path, file_name)
  return {
    file_name = file_name,
    md5 = md5,
    file_path = file_path
  }
end

local function check_is_pkg_downloaded()
  local os = E.Sysinfo.os()
  local pkg_install_path = get_pkg_install_file_infos().file_path
  E.LOG.debug(TAG, "get_pkg_install_file_infos, pkg_install_path: " .. tostring(pkg_install_path))
  if not pkg_install_path then
    return false
  end
  if "android" == os or "windows" == os then
    do return E.File.exists, pkg_install_path end
    return E.File.exists, pkg_install_path, true, tostring(pkg_install_path), pkg_install_path
  else
    E.LOG.error(TAG, "check_is_pkg_downloaded os is not android or windows, os: " .. tostring(os))
    return false
  end
end

local function check_is_native_support_install()
  local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
  E.LOG.debug(TAG, "get_app_update_config sdk_version: " .. tostring(sdk_version))
  if E.Sysinfo.os() == "android" then
    local result = VC.compare_versions(sdk_version, "2.10.75")
    return tonumber(result) >= 0
  elseif E.Sysinfo.os() == "windows" then
    local result = VC.compare_versions(sdk_version, "2.9.1")
    return tonumber(result) >= 0
  else
    return true
  end
end

local function check_is_windows_native_md5_support(pkg_size)
  local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
  local OLD_WINDOWS_MD5_MAX_SIZE = 3221225472
  if E.Sysinfo.os() == "windows" and pkg_size > OLD_WINDOWS_MD5_MAX_SIZE then
    local result = VC.compare_versions(sdk_version, "3.0.6")
    E.LOG.debug(TAG, "check_is_windows_native_md5_support get_app_update_config sdk_version: " .. tostring(sdk_version) .. ", size: " .. tostring(pkg_size))
    return tonumber(result) >= 0
  end
  return true
end

local function get_app_update_config(_params, cb)
  local update_config_info = ECC.get_config(M.APP_UPDATE_NAMESPACE) or {}
  local update_config = update_config_info.config
  E.LOG.debug(TAG, "get_app_update_config update_config >>>")
  E.log(update_config)
  local is_native_support_install = check_is_native_support_install()
  E.LOG.debug(TAG, "get_app_update_config is_native_support_install: " .. tostring(is_native_support_install))
  local is_install_success = M.get_app_install_success()
  E.LOG.debug(TAG, "get_app_update_config is_install_success: " .. tostring(is_install_success))
  if update_config and is_native_support_install then
    local _current_version = M.get_app_update_current_version()
    local force_update_config = update_config.forceUpdate or {}
    local latest_update_config = update_config.latest or {}
    app_update_res_key = latest_update_config.updateResourceKey
    app_update_manager_static_info.has_app_update_config = true
    app_update_manager_static_info.current_version = _current_version
    app_update_manager_static_info.latest_version = latest_update_config.version
    app_update_manager_static_info.update_url = latest_update_config.updateUrl
    app_update_manager_static_info.update_url_type = latest_update_config.updateUrlType
    app_update_manager_static_info.show_popup = latest_update_config.showPopup
    local is_version_below_force = -1 == VC.compare_versions(_current_version, force_update_config.version)
    local is_version_below_latest = -1 == VC.compare_versions(_current_version, latest_update_config.version)
    if not is_version_below_latest then
      app_update_manager_static_info.need_app_update = false
    else
      app_update_manager_static_info.need_app_update = true
      app_update_manager_static_info.is_mandatory_force_update = is_version_below_force
    end
    if latest_update_config.updateUrlType == UPDATE_URL_TYPE.DOWNLOAD then
      if not update_config[app_update_res_key] or not update_config[app_update_res_key].origin then
        E.LOG.debug(TAG, "update_config resource_key is empty or origin is empty, ignore app_update")
        app_update_manager_static_info.need_app_update = false
        cb(app_update_manager_static_info)
        return
      end
      app_update_manager_static_info.size = update_config[app_update_res_key].origin.size
      local is_windows_native_md5_support = check_is_windows_native_md5_support(app_update_manager_static_info.size)
      if not is_windows_native_md5_support then
        E.LOG.debug(TAG, "is_windows_native_md5_support is false, ignore app_update: " .. tostring(is_windows_native_md5_support))
        app_update_manager_static_info.need_app_update = false
        cb(app_update_manager_static_info)
        return
      end
      local is_pkg_downloaded = check_is_pkg_downloaded()
      app_update_manager_static_info.download_info = {
        total_size = update_config[app_update_res_key].origin.size,
        percent = is_pkg_downloaded and 100 or 0,
        downloading_size = is_pkg_downloaded and app_update_manager_static_info.size or 0,
        finish_count = is_pkg_downloaded and update_config[app_update_res_key].cnt or 0,
        total_count = update_config[app_update_res_key].cnt,
        last_finish_item = {},
        speed = 0
      }
      if app_update_manager_static_info.need_app_update and is_pkg_downloaded then
        app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_COMPLETE
      elseif app_update_manager_static_info.need_app_update == false and is_install_success then
        app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALL_SUCCESS
        E.LOG.debug(TAG, "pkg is install success, has_app_update_config true")
      else
        app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_NOT_STARTED
        app_update_install_version_key_store:set("")
      end
      trigger_app_update_state_change_listeners()
    end
  else
    app_update_manager_static_info.has_app_update_config = false
    app_update_manager_static_info.need_app_update = false
    if is_install_success then
      app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALL_SUCCESS
      E.LOG.debug(TAG, "pkg is install success, has_app_update_config false")
      trigger_app_update_state_change_listeners()
    end
  end
  E.LOG.debug(TAG, "get_app_update_config app_update_manager_static_info >>>")
  E.log(app_update_manager_static_info)
  E.LOG.debug(TAG, "get_app_update_config app_update_res_key: " .. tostring(app_update_res_key))
  cb(app_update_manager_static_info)
end

local function get_announcement_config_from_server(_params, cb)
  cb(false, nil)
end

function M.show_timeout_install_modal(cb, code)
  ES.stat_bizid_pfcomm({
    biz_group = "lq",
    biz_prod = "qz",
    biz_mod = "game_full_update",
    biz_func = "force_update_page",
    biz_act = "installer_invoke_failed",
    biz_st = "fail",
    biz_co = code or "400"
  })
  local title = LANG.getStringSuitCNOverseas("install_failed_title", "")
  local content = LANG.getStringSuitCNOverseas("install_failed_content", "")
  E.Modal.open(title, {
    message = content,
    buttons = {
      LANG.getStringSuitCNOverseas("install_failed_cancel", ""),
      LANG.getStringSuitCNOverseas("install_now", "")
    }
  }, function(action)
    E.LOG.debug(TAG, "show_timeout_install_modal clicked action" .. tostring(action))
    if 1 == action then
      cb(true)
    else
      cb(false)
    end
  end)
end

local function check_can_download_install()
  if E.Sysinfo.os() ~= "android" and E.Sysinfo.os() ~= "windows" then
    return false
  end
  E.LOG.debug(TAG, "check_can_download_install app_update_manager_static_info.update_url_type: " .. tostring(app_update_manager_static_info.update_url_type))
  return app_update_manager_static_info.update_url_type == UPDATE_URL_TYPE.DOWNLOAD
end

local function jump_outside_update()
  local update_url = app_update_manager_static_info.update_url
  if not update_url then
    E.LOG.error(TAG, "check_can_download_install update_url is empty")
  end
  E.LOG.debug(TAG, "check_can_download_install openURLUpdateApp update_url: " .. tostring(update_url))
  local AU = require("ejoysdk_lua.app_update.app_update")
  AU.openURLUpdateApp(update_url, {harmony_need_go_market_delay = false})
end

local function get_disable_param_if_range()
  local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
  E.LOG.debug(TAG, "get_app_update_config sdk_version: " .. tostring(sdk_version))
  if E.Sysinfo.os() == "android" then
    local result = VC.compare_versions(sdk_version, "2.10.78")
    return tonumber(result) >= 0
  end
  return false
end

local function download_update(params, cb)
  local on_download_complete = params.on_download_complete
  if not on_download_complete then
    E.LOG.error(TAG, "download_update on_download_complete is nil")
    cb(false, EC.EJOYSDK_ERROR_CODES.PARAMS_INVALID, "on_download_complete is nil")
    return
  end
  local res_info = {
    res_key = app_update_res_key,
    version = app_update_manager_static_info.current_version,
    res_save_storage_type = MB.STORAGE_TYPE.INTERNAL_APP_PRIVATE,
    res_save_base_path = get_pkg_save_path()
  }
  E.LOG.debug(TAG, "download_update res_info: ")
  E.log(res_info)
  local disable_param_if_range = get_disable_param_if_range()
  E.LOG.debug(TAG, "get_disable_param_if_range disable_param_if_range: " .. tostring(disable_param_if_range))
  local opts = {
    force_check_update = false,
    foreground_notification_enabled = true,
    priority = RTM.RES_PRIORITY.LOW,
    sub_priority = 3,
    disable_param_if_range = disable_param_if_range,
    network_strategy = NS.get_strategy()
  }
  E.LOG.debug(TAG, "download_update opts: ")
  E.log(opts)
  local is_already_cb = false
  local listeners = {
    on_confirm_res_update = function(_res_info, confirm_cb)
      E.LOG.debug(TAG, "on_confirm_res_update")
      E.log(_res_info)
      confirm_cb(true)
    end,
    on_res_download_progress_change_listener = function(state, progress_info)
      E.LOG.debug(TAG, "download progress change, state: " .. tostring(state) .. ", progress_info is >>>")
      E.log(progress_info)
      app_update_manager_static_info.download_info.state = state
      if state == RTM.PUBLIC_DOWNLOAD_STATE.DOWNLOADING or state == RTM.PUBLIC_DOWNLOAD_STATE.WAITTING then
        app_update_manager_static_info.download_info = UTILS.deepcopy(progress_info) or {}
        if not app_update_manager_static_info.download_info.total_size or 0 == app_update_manager_static_info.download_info.total_size then
          E.LOG.debug(TAG, "download_update, progress_info.total_size is 0, set total_size: " .. tostring(app_update_manager_static_info.size))
          app_update_manager_static_info.download_info.total_size = app_update_manager_static_info.size
        end
        if state == RTM.PUBLIC_DOWNLOAD_STATE.DOWNLOADING then
          app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOADING
        elseif state == RTM.PUBLIC_DOWNLOAD_STATE.WAITTING then
          app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_WAITING
        end
        trigger_app_update_state_change_listeners()
        if false == is_already_cb then
          cb(true)
          is_already_cb = true
        end
      end
    end,
    on_res_update_complete = function(update_result, ...)
      E.LOG.d(TAG, "on_res_update_complete update_namespace_res complete update_result: " .. tostring(update_result))
      if update_result then
        E.LOG.debug(TAG, "on_res_update_complete update_namespace_res complete")
        if false == is_already_cb then
          cb(true)
          is_already_cb = true
        end
        local trigger_update = (...)
        local is_pkg_downloaded = check_is_pkg_downloaded()
        E.LOG.debug(TAG, "on_res_update_complete update_namespace_res complete, is_pkg_downloaded: " .. tostring(is_pkg_downloaded) .. ", trigger_update: " .. tostring(trigger_update))
        if is_pkg_downloaded then
          app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_COMPLETE
          on_download_complete(true)
        else
          E.LOG.error(TAG, "on_res_update_complete update_namespace_res complete, but pkg not downloaded")
          app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_FAILED
          app_update_manager_static_info.error_info = {
            code = EC.APP_UPDATE_CODE.PKG_RES_NOT_FOUND,
            msg = "pkg res_info not found"
          }
          on_download_complete(false)
        end
      else
        local code, msg = ...
        E.LOG.debug(TAG, "on_res_update_complete update_namespace_res failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if false == is_already_cb then
          cb(false, ...)
          is_already_cb = true
        end
        if code ~= EC.DOWNLOAD_ERROR_CODES.CANCELLED then
          app_update_manager_static_info.error_info = {code = code, msg = msg}
          app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_FAILED
          on_download_complete(false, ...)
        end
      end
    end
  }
  BER.check_and_update(M.APP_UPDATE_NAMESPACE, res_info, opts, listeners)
  app_update_res_src_model = EMF.get_ejoy_res_source_model(M.APP_UPDATE_NAMESPACE, app_update_res_key)
end

local function install_update(_params, cb)
  local update_url_type = app_update_manager_static_info.update_url_type
  local pkg_install_path = get_pkg_install_file_infos().file_path
  local is_pkg_downloaded = check_is_pkg_downloaded()
  E.LOG.debug(TAG, "install_update, update_url_type: " .. tostring(update_url_type) .. ", pkg_install_path: " .. tostring(pkg_install_path))
  if not pkg_install_path or false == is_pkg_downloaded then
    E.LOG.error(TAG, "install_update failed, pkg_install_path is " .. tostring(pkg_install_path))
    cb(false, EC.EJOYSDK_ERROR_CODES.RES_FILE_NOT_EXISTS, "pkg_install_path is not exit")
    return
  end
  app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALLING
  trigger_app_update_state_change_listeners()
  if E.Sysinfo.os() == "windows" then
    local exe_relate_file_path = ""
    local pkg_download_full_path = get_pkg_download_full_path()
    local install_info_file_path = E.Path.join(pkg_download_full_path, WINDOW_INSTALL_INFO_JSON)
    local is_install_json_exits = E.File.exists(install_info_file_path, true)
    if not is_install_json_exits then
      E.LOG.error(TAG, "install_update failed, cannot find install_info_file_path")
      app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALL_FAILED
      app_update_manager_static_info.error_info = {
        code = EC.APP_UPDATE_CODE.PKG_INSTALL_JSON_INVALID,
        msg = "pkg install json invalid"
      }
      cb(false, EC.APP_UPDATE_CODE.PKG_INSTALL_JSON_INVALID, "pkg install json invalid")
      return
    end
    local install_info_content = E.File.readfile_fullpath(install_info_file_path)
    local install_info_json = JSON.safe_decode(install_info_content)
    if install_info_json then
      exe_relate_file_path = install_info_json.launcher_path
    end
    if not exe_relate_file_path or "" == exe_relate_file_path then
      E.LOG.error(TAG, "install_update failed, cannot find launcher_path")
      app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALL_FAILED
      app_update_manager_static_info.error_info = {
        code = EC.APP_UPDATE_CODE.PKG_INSTALL_JSON_INVALID,
        msg = "pkg install json invalid"
      }
      cb(false, EC.APP_UPDATE_CODE.PKG_INSTALL_JSON_INVALID, "pkg install json invalid")
      return
    end
    local exe_file_path = E.Path.join(pkg_download_full_path, exe_relate_file_path)
    E.LOG.debug(TAG, "install_update exe_file_path: " .. tostring(exe_file_path))
    local exe_file_exits = E.File.exists(exe_file_path, true)
    if exe_file_exits then
      pkg_install_path = exe_file_path
    else
      E.LOG.error(TAG, "install_update failed, pkg_install_path cannot find exe, exe_file_path: " .. tostring(exe_file_path))
      app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALL_FAILED
      app_update_manager_static_info.error_info = {
        code = EC.APP_UPDATE_CODE.PKG_INSTALL_JSON_INVALID,
        msg = "pkg install json invalid"
      }
      cb(false, EC.APP_UPDATE_CODE.PKG_INSTALL_JSON_INVALID, "pkg install json invalid")
      return
    end
  end
  E.LOG.debug(TAG, "install_app pkg_install_path: " .. tostring(pkg_install_path))
  ES.stat_bizid_pfcomm({
    biz_group = "lq",
    biz_prod = "qz",
    biz_mod = "game_full_update",
    biz_func = "force_update_page",
    biz_act = "installer_invoke",
    biz_st = "succ",
    biz_co = "200"
  })
  app_update_install_version_key_store:set(app_update_manager_static_info.latest_version)
  E.Sysinfo.install_app(pkg_install_path, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "install pkg succ")
      cb(true)
    else
      local code, msg = ...
      E.LOG.error(TAG, "install pkg failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      app_update_manager_static_info.state = M.APP_UPDATE_STATE.INSTALL_FAILED
      trigger_app_update_state_change_listeners()
      M.show_timeout_install_modal(function(is_retry)
        E.LOG.debug(TAG, "show_timeout_install_modal is_retry: " .. tostring(is_retry))
        if is_retry then
          install_update(nil, cb)
        else
          cb(false, code, msg)
        end
      end, code)
    end
  end)
end

function Controller:execute(options, cb)
  app_update_manager_static_info.error_info = nil
  local can_app_download_install = check_can_download_install()
  if false == can_app_download_install then
    local need_jump_outside_update = false ~= options.need_jump_outside_update
    if need_jump_outside_update then
      E.LOG.debug(TAG, "Controller jump_outside_update is true jump outside")
      jump_outside_update()
    else
      E.LOG.debug(TAG, "Controller jump_outside_update is false")
    end
    cb(true)
    return
  end
  local is_pkg_downloaded = check_is_pkg_downloaded()
  if options.step == APP_UPDATE_STEP.DOWNLOAD then
    E.LOG.debug(TAG, "Controller download is_pkg_downloaded: " .. tostring(is_pkg_downloaded))
    if is_pkg_downloaded then
      cb(true)
      return
    end
    download_update({
      on_download_complete = function(_is_download_success)
        trigger_app_update_state_change_listeners()
      end
    }, cb)
    return
  elseif options.step == APP_UPDATE_STEP.INSTALL then
    if not is_pkg_downloaded then
      E.LOG.error(TAG, "Controller install is_pkg_downloaded is false")
      cb(false, EC.EJOYSDK_ERROR_CODES.RES_FILE_NOT_EXISTS, "pkg is not exits, cant install")
    else
      install_update(nil, cb)
    end
    return
  else
    E.LOG.warn(TAG, "Controller step invalid, options.step: " .. tostring(options.step))
    return
  end
end

function M.get_app_update_manager_static_info()
  do return UTILS.deepcopy end
  return UTILS.deepcopy, app_update_manager_static_info
end

function M.request_config_and_run_update(_params, cb)
  ECC.get_configs_with_options({disable_update_cache = true}, {
    APP_UPDATE = M.APP_UPDATE_NAMESPACE
  }, function(is_success, ...)
    if is_success then
      local config_list = (...)
      E.LOG.debug(TAG, "get_configs_with_options success, config_list is >>>")
      E.log(config_list)
      M.run_main_update(_params, cb)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "get_configs_with_options error, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.run_main_update(params, cb)
  params = params or {}
  get_app_update_config(nil, function()
    if app_update_manager_static_info.latest_version ~= "0" then
      app_update_download_version_key_store:set(app_update_manager_static_info.latest_version)
    end
    if app_update_manager_static_info.need_app_update and app_update_manager_static_info.is_mandatory_force_update then
      E.LOG.debug(TAG, "app_res_update has_app_update_config and is_mandatory_force_update, show announcement")
      get_announcement_config_from_server(nil, function(is_success, announcement_config)
        local EFUP = require("ejoysdk_lua.res.app_update.presenters.ejoy_force_update_presenter")
        
        local function show_announcement_cb(is_show_success)
          E.LOG.debug(TAG, "show announcement result: " .. tostring(is_show_success))
          E.log(app_update_manager_static_info)
        end
        
        if is_success then
          E.LOG.debug(TAG, "get announcement config success, show announcement")
          EFUP.init(announcement_config, show_announcement_cb)
        else
          E.LOG.debug(TAG, "get announcement config failed, show default announcement")
          EFUP.init(nil, show_announcement_cb)
        end
        cb(true, {has_new_update = true, is_mandatory_force_update = true})
      end)
    elseif app_update_manager_static_info.need_app_update and not app_update_manager_static_info.is_mandatory_force_update then
      ES.stat_bizid_pfcomm({
        biz_group = "lq",
        biz_prod = "qz",
        biz_mod = "game_full_update",
        biz_func = "force_update_check",
        biz_act = "force_update_check",
        biz_params = {need_app_update = true, is_mandatory_force_update = false},
        biz_st = "succ",
        biz_co = "200"
      })
      local is_pkg_downloaded = check_is_pkg_downloaded()
      local admin_show_popup = app_update_manager_static_info.show_popup
      local user_show_popup = BUM.get_new_version_modal_visible()
      local need_show_install_guide = params.need_show_install_guide
      E.LOG.debug(TAG, string.format("app_res_update need_app_update and not is_mandatory_force_update: " .. "is_pkg_downloaded=%s, admin_show_popup=%s, user_show_popup=%s, need_show_install_guide=%s", tostring(is_pkg_downloaded), tostring(admin_show_popup), tostring(user_show_popup), tostring(need_show_install_guide)))
      if need_show_install_guide and is_pkg_downloaded and (admin_show_popup or true == user_show_popup) then
        ES.stat_bizid_pfcomm({
          biz_group = "lq",
          biz_prod = "qz",
          biz_mod = "game_full_update",
          biz_func = "optional_update_install_check",
          biz_act = "optional_update_downloaded_detect",
          biz_st = "succ",
          biz_co = "200"
        })
        E.Modal.open(LANG.getStringSuitCNOverseas("tips"), {
          message = LANG.getStringSuitCNOverseas("install_confirm_content", ""),
          buttons = {
            LANG.getStringSuitCNOverseas("install_next_time", ""),
            LANG.getStringSuitCNOverseas("install_now", "")
          }
        }, function(action)
          E.LOG.debug(TAG, "show_timeout_install_modal clicked action: " .. tostring(action))
          if 1 == action then
            ES.stat_bizid_pfcomm({
              biz_group = "lq",
              biz_prod = "qz",
              biz_mod = "game_full_update",
              biz_func = "optional_update_install_check",
              biz_act = "install_click",
              biz_st = "succ",
              biz_co = "200",
              is_priority_high = true
            })
            Controller:execute({
              step = APP_UPDATE_STEP.INSTALL
            }, cb)
          else
            ES.stat_bizid_pfcomm({
              biz_group = "lq",
              biz_prod = "qz",
              biz_mod = "game_full_update",
              biz_func = "optional_update_install_check",
              biz_act = "skip_click",
              biz_st = "succ",
              biz_co = "200",
              is_priority_high = true
            })
            cb(true, {has_new_update = true, is_mandatory_force_update = false})
          end
        end)
      else
        cb(true, {has_new_update = true, is_mandatory_force_update = false})
      end
    else
      E.LOG.debug(TAG, "app_res_update not need_app_update and not is_mandatory_force_update, now call cb")
      ES.stat_bizid_pfcomm({
        biz_group = "lq",
        biz_prod = "qz",
        biz_mod = "game_full_update",
        biz_func = "force_update_check",
        biz_act = "force_update_check",
        biz_params = {need_app_update = false, is_mandatory_force_update = false},
        biz_st = "succ",
        biz_co = "200"
      })
      cb(true, {has_new_update = false, is_mandatory_force_update = false})
    end
  end)
end

ET.subscribe(ET.gangplank.INITED, function(_succ, ...)
  local pkg_download_full_path = get_pkg_download_full_path()
  local exits = E.File.exists(pkg_download_full_path, true)
  local pkg_download_version = app_update_download_version_key_store:get()
  local _current_version = M.get_app_update_current_version()
  E.LOG.debug(TAG, "get_app_install_success pkg_download_version: " .. tostring(pkg_download_version) .. ", current version: " .. tostring(_current_version))
  local can_remove_pkg = VC.compare_versions(_current_version, pkg_download_version) >= 0
  if exits and can_remove_pkg then
    E.LOG.debug(TAG, "find app_update install_pkg, auto remove")
    local ret, code, msg = E.File.remove_fullpath(pkg_download_full_path, true)
    if ret then
      E.LOG.debug(TAG, "auto remove install_pkg succ")
      app_update_manager_static_info.state = M.APP_UPDATE_STATE.PKG_AUTO_REMOVED
    else
      E.LOG.warn(TAG, "remove remove install_pkg failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      app_update_manager_static_info.code = code
      app_update_manager_static_info.msg = "remove install_pkg failed"
    end
    trigger_app_update_state_change_listeners()
  end
end)

function M.set_game_listeners(listeners)
  listeners = listeners or {}
  game_listeners = listeners
end

function M.get_game_listeners()
  return game_listeners
end

function M.start(params, cb)
  E.LOG.debug(TAG, "start_task, need_app_update: " .. tostring(app_update_manager_static_info.need_app_update))
  if app_update_manager_static_info.state == M.APP_UPDATE_STATE.DOWNLOADING then
    E.LOG.debug(TAG, "start_task is downloading")
    cb(true)
    return
  end
  if app_update_manager_static_info.need_app_update == false then
    E.LOG.debug(TAG, "need_app_update is false, cannot start")
    cb(true)
    return
  end
  params = params or {}
  Controller:execute({
    step = APP_UPDATE_STEP.DOWNLOAD,
    need_jump_outside_update = params.need_jump_outside_update
  }, function(is_success, ...)
    cb(is_success, ...)
  end)
end

function M.stop(_params, cb)
  E.LOG.debug(TAG, "stop_task")
  if app_update_res_src_model then
    app_update_res_src_model:cancel_download(function(is_success, ...)
      E.LOG.debug(TAG, "app_update_res_src_model:cancel_download result:" .. tostring(is_success))
      E.log(...)
      if is_success then
        app_update_manager_static_info.state = M.APP_UPDATE_STATE.DOWNLOAD_STOPPED
        trigger_app_update_state_change_listeners()
      end
      cb(is_success, ...)
    end)
  else
    cb(true)
  end
end

function M.remove(_params, cb)
  E.LOG.debug(TAG, "remove_task")
  
  local function remove_download_cb(is_succ, ...)
    app_update_res_src_model = nil
    E.LOG.debug(TAG, "app_update_res_src_model remove_download cb")
    local pkg_download_full_path = get_pkg_download_full_path()
    local exits = E.File.exists(pkg_download_full_path, true)
    if exits then
      local local_file_list_path = E.Path.join(pkg_download_full_path, RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST)
      local file_remove_ret = E.File.remove_fullpath(local_file_list_path, true)
      E.LOG.debug(TAG, "remove local_file_list_path ret:" .. tostring(file_remove_ret))
      local ret, code, msg = E.File.remove_fullpath(pkg_download_full_path, true)
      if ret then
        E.LOG.debug(TAG, "remove succ")
        reset_app_update_manager_static_info()
        trigger_app_update_state_change_listeners()
        cb(true)
      else
        E.LOG.warn(TAG, "remove failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        reset_app_update_manager_static_info()
        app_update_manager_static_info.code = code
        app_update_manager_static_info.msg = "remove install_pkg failed"
        trigger_app_update_state_change_listeners()
        cb(false, code, msg)
      end
    else
      reset_app_update_manager_static_info()
      trigger_app_update_state_change_listeners()
      cb(is_succ, ...)
    end
  end
  
  if app_update_res_src_model then
    app_update_res_src_model:remove_download(function(is_success, ...)
      remove_download_cb(is_success, ...)
    end)
  else
    remove_download_cb(true)
  end
end

function M.install(_params, cb)
  E.LOG.debug(TAG, "install_task")
  if app_update_manager_static_info.need_app_update == false then
    E.LOG.debug(TAG, "need_app_update is false, cannot install")
    cb(true)
    return
  end
  Controller:execute({
    step = APP_UPDATE_STEP.INSTALL
  }, cb)
end

function M.get_task_info(_params, cb)
  E.LOG.debug(TAG, "get_task_info")
  E.log(app_update_manager_static_info)
  cb({
    task_info = {
      namespace = M.APP_UPDATE_NAMESPACE,
      res_id = nil,
      res_key = app_update_res_key,
      res_version = app_update_manager_static_info.latest_version,
      current_version = app_update_manager_static_info.current_version,
      total_size = app_update_manager_static_info.size,
      has_new_update = app_update_manager_static_info.need_app_update
    }
  })
end

function M.get_task_state(_params, cb)
  local download_info = app_update_manager_static_info.download_info
  local app_update_state = app_update_manager_static_info.state
  cb({
    state = app_update_state,
    download_info = download_info,
    state_info = app_update_manager_static_info.error_info and {
      code = app_update_manager_static_info.error_info.code,
      msg = app_update_manager_static_info.error_info.msg
    } or {}
  })
end

function M.set_state_change_listener(listener)
  if type(listener) == "function" then
    for _, v in ipairs(app_update_state_change_listeners) do
      if v == listener then
        return
      end
    end
    table.insert(app_update_state_change_listeners, listener)
  else
    E.LOG.warn(TAG, "set_state_change_listener listener must be a function")
  end
end

return M
