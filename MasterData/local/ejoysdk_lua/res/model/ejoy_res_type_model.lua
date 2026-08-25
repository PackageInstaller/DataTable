local E = require("ejoysdk_lua.ejoysdk")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local EHR = require("ejoysdk_lua.res.ejoy_http_res_utils")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local M = ERB:Inherit("EjoyResTypeModel")
local TAG = "ejoy_res_type_model"
local RES_BUILTIN_PATH = "ejoysdk_res"
local USING_RES_CONFIG = "config"
local DOWNLOADING_RES_CONFIG = "dl_config"
local NAMESPACE_CONFIG = "namespace_config"
local namespace_res_collection, app_ext_file_dir
M.FILE_ITEM_EXT_KEY = {
  EX_COMPLETE_PATH = "ex_complete_path",
  EX_TMP_PATH = "ex_tmp_path",
  EXT = "_ej_ext"
}
M.USING_RES_INFO_PARAM_KEY = {
  NAMESPACE = "namespace",
  RES_KEY = "res_key",
  VERSION = "version",
  PROJECT_NAME = "project_name",
  RES_TYPE = "res_type"
}
M.RES_NAMES = {
  CLOUD_GAME_FULL_SRC = "CLOUD_GAME_FULL_SRC"
}
M.USING_RES_STATE_INFO_KEY = {VERSION_NAME = "version"}
M.LOCAL_RES_STATE_INFO_KEY = {
  STATE = "state",
  VERSION_NAME = "version",
  DOWNLOADING_SIZE = "downloading_size"
}
M.RES_STATE_INFO_KEY = {
  STATE = "state",
  VERSION_NAME = "version",
  FILE_LIST_TYPE = "file_list_type",
  RES_LOCATION = "res_location",
  ERR_CODE = "err_code",
  ERR_MSG = "err_msg",
  LOCAL_VERSION = "local_version"
}
M.PROGRESS_INFO_KEY = {
  TOTAL_SIZE = "total_size",
  DOWNLOADING_SIZE = "downloading_size",
  PERCENT = "percent",
  TOTAL_COUNT = "total_count",
  FINISH_COUNT = "finish_count",
  LAST_FINISH_ITEM = "last_finish_item",
  SPEED = "speed",
  TAG = "tag"
}
M.UPDATE_INFO_KEY = {
  VERSION_NAME = "version",
  TOTAL_SIZE = "total_size",
  TOTAL_COUNT = "total_count",
  HAS_NEW_UPDATE = "has_new_update",
  FILE_LIST_TYPE = "file_list_type",
  UPDATE_BODY = "update_body",
  KEY_TYPE = "type",
  TARGET_VERSION = "targetVersion",
  PATCHES = "patches",
  PATCH = "patch"
}
M.EJOY_RES_TYPE = {TYPE_QZ_H5_RES = "qzH5Res", TYPE_QZ_GAME_RES = "qzGameRes"}
M.FILE_LIST_TYPE = {
  UNKNOWN = "unknown",
  ORIGIN = "origin",
  PATCH = "patch"
}
M.INFO_TYPE_KEY = {
  TYPE_DOWNLOADING_INFO = "res_downloading_info",
  TYPE_DOWNLOAD_PROGRESS_INFO = "res_progress_info",
  TYPE_RES_UPDATE_STATE = "res_update_info",
  TYPE_USING_RES_INFO = "using_res_info",
  TYPE_PENDING_FILE_LIST_INFO = "pending_file_list_info"
}
M.NAMESPACE_RES_CONFIG_KEY = M.INFO_TYPE_KEY
M.DOWNLOAD_STATE = {
  UNDEFINED = "undefined",
  DOWNLOADING = "downloading",
  COMPLETE = "complete",
  STOPPED = "stopped"
}
M.APPLY_STATE = {
  IDLE = "idle",
  PATCH = "patch",
  CHECK = "check",
  RE_DOWNLOAD = "re_download",
  COMPLETE = "complete",
  FAIL = "fail"
}
M.PUBLIC_DOWNLOAD_STATE = {
  UNKNOWN = "unknown",
  IDLE = "idle",
  FAILED = "failed",
  STOPPED = "stopped",
  DOWNLOADING = "downloading",
  COMPLETE = "complete",
  SKIP = "skip"
}
M.DOWNLOAD_TASK_TYPE = {MULTI = "multi", SINGLE = "single"}
M.RES_CONFIG_KEY = {
  KEY_VERSION = "version",
  KEY_RES_TYPE = "key",
  KEY_PATH = "path",
  KEY_RESOURCE_UPDATED = "res_updated",
  KEY_NEED_RELEASE_FROM_BUNDLE = "need_release_from_bundle",
  KEY_TOTAL_SIZE = "size",
  KEY_ORIGIN = "origin",
  KEY_PATCH = "patch",
  KEY_BASE_URL = "baseUrl",
  KEY_BASE_URLS = "baseUrls",
  KEY_BASE_PATH = "basePath",
  KEY_FILE = "file",
  KEY_FILE_MD5 = "file_md5",
  KEY_FOLDER = "folder",
  KEY_INDEX_FILE = "indexFile",
  KEY_INDEX_INFO_FILE = "indexInfoFile",
  KEY_INDEX_MD5 = "indexMd5",
  KEY_INDEX_INFO_MD5 = "indexInfoMd5",
  KEY_INIT_CONFIG = "initConf",
  KEY_ADDRESS_LIST = "addressList",
  KEY_DOWNLOAD_TIMING = "downloadTiming",
  KEY_TARGET_VERSION = "targetVersion",
  KEY_PATCHES = "patches"
}
M.DOWNLOAD_TIMING_TYPE = {
  TYPE_IMMEDIATELY = 1,
  TYPE_STARTUP_ONLY = 2,
  TYPE_AFTER_STARTUP_ONLY = 3
}
M.FILE_LIST_ITEM_KEY = {
  KEY_FROM = "from",
  KEY_TO = "to",
  KEY_MD5 = "md5",
  KEY_SIZE = "size",
  KEY_FROM_FOLDER = "from_folder"
}
M.MULTI_TASK_INFO_KEY = {
  KEY_PATH = "path",
  KEY_DEST_PATH = "dest_path",
  KEY_TOTAL_SIZE = "total_size",
  KEY_SIZE = "size",
  KEY_BASE_URL = "base_url",
  KEY_MD5 = "md5",
  KEY_NAME = "name",
  KEY_DEST_PARENT_PATH = "dest_parent_path"
}
M.RES_UPDATES_OPTIONS = {
  RES_SAVE_BASE_PATH = "res_save_base_path",
  RES_SAVE_STORAGE_TYPE = "res_save_storage_type",
  FOREGROUND_NOTIFICATION_ENABLED = "foreground_notification_enabled",
  FOREGROUND_NOTIFICATION_CUSTOM_CONFIG = "foreground_notification_custom_config",
  RES_TYPE = "res_type",
  FORCE_CHECK_UPDATE = "force_check_update"
}
M.NOTIFICATION_CUSTOM_CONFIG_OPTIONS = {
  IS_PROGRESS_VISIBLE = "is_progress_visible",
  IS_STATUS_ICON_VISIBLE = "is_status_icon_visible",
  COMPLETE_TITLE = "complete_title",
  COMPLETE_LEFT_TXT = "complete_left_txt",
  COMPLETE_RIGHT_TXT = "complete_right_txt",
  DOWNLOADING_TITLE = "downloading_title",
  DOWNLOADING_LEFT_TXT = "downloading_left_txt",
  DOWNLOADING_RIGHT_TXT = "downloading_right_txt"
}
M.RES_GROUP_INFO_KEY = {
  PREFIX = "qz_res_group-"
}
M.RES_CACHE_KEY = {
  EJOY_QZ_LOCAL_RESOURCE_CONFIG = "ejoy_qz_resource_config.json",
  EJOY_QZ_LOCAL_RESOURCE_FILE_LIST = "ejoy_qz_local_resource_file_list.json"
}
M.STORAGE_TYPE = ERB.STORAGE_TYPE
M.PRIORITY = {DEFAULT = 0, HIGH = 1}

function M:prepare_res_list_for_download(_res_tag_name, _cb)
  assert(false, "prepare_res_list_for_download not implements")
end

function M:check_res_update(_cb, _update_info)
  assert(false, "check_res_update not implements")
end

function M:check_local_res_state(_res_tag_name, _cb)
  assert(false, "check_res_state not implements")
end

function M:get_res_state()
  assert(false, "get_res_state not implements")
end

function M:get_res_location()
  assert(false, "get_res_location not implements")
end

function M:register_res_state_listener()
  assert(false, "register_res_state_listener not implements")
end

function M:unregister_res_state_listener(_listener)
  assert(false, "unregister_res_state_change_listener not implements")
end

function M:register_progress_listener()
end

function M:unregister_progress_listener()
end

function M:remove_res()
  assert(false, "remove_res not implements")
end

function M:start_download()
  assert(false, "start_download not implements")
end

function M:pause_download(_cb)
  assert(false, "pause_download not implements")
end

function M:resume_download()
  assert(false, "resume_download not implements")
end

function M:is_download_paused()
  assert(false, "is_download_paused not implements")
end

function M:set_download_speed()
  assert(false, "set_download_speed not implements")
end

function M:update_using_res_version(_res_version, _ext)
end

function M.static_load_all_local_namespace_res()
  local ns_arr_config_data = E.File.readfile(RES_BUILTIN_PATH .. "/" .. NAMESPACE_CONFIG) or ""
  local namespace_list = E.Utils.split_string(ns_arr_config_data, "\n")
  local namespace_res_map = {}
  for _, namespace in ipairs(namespace_list) do
    if not EU.is_text_empty(namespace) then
      E.LOG.debug(TAG, "init_all_local_namespace_res, namespace:" .. tostring(namespace))
      local ns_base_path = RES_BUILTIN_PATH .. "/" .. namespace .. "/"
      local using_ns_config_path = ns_base_path .. USING_RES_CONFIG
      if M.static_is_file_exists(using_ns_config_path) then
        local ns_res_config_data = E.File.readfile(using_ns_config_path) or ""
        local res_list = E.Utils.split_string(ns_res_config_data, "\n")
        for _, res_key in ipairs(res_list) do
          E.LOG.debug(TAG, "init_all_local_namespace_res namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
          if not EU.is_text_empty(res_key) then
            local ns_res_key_base_path = ns_base_path .. res_key .. "/"
            local ns_res_key_cfg_path = ns_res_key_base_path .. USING_RES_CONFIG
            if M.static_is_file_exists(ns_res_key_cfg_path) then
              namespace_res_map[namespace] = namespace_res_map[namespace] or {}
              namespace_res_map[namespace][res_key] = true
            end
          end
        end
      else
        EL.LOG.warn(TAG, "static_load_all_local_namespace_res failed, namespace config file not exists:" .. tostring(using_ns_config_path))
      end
    end
  end
  namespace_res_collection = {}
  for ns, res_set in pairs(namespace_res_map) do
    local ns_base_path = RES_BUILTIN_PATH .. "/" .. ns
    for res_key, _ in pairs(res_set) do
      local ns_res_key_base_path = ns_base_path .. "/" .. res_key .. "/"
      local using_ns_res_key_cfg_path = ns_res_key_base_path .. USING_RES_CONFIG
      local dl_ns_res_key_cfg_path = ns_res_key_base_path .. DOWNLOADING_RES_CONFIG
      E.LOG.debug(TAG, "init_all_local_namespace_res namespace:" .. tostring(ns) .. ", res_key:" .. tostring(res_key))
      local using_res = JSON.decode(E.File.readfile(using_ns_res_key_cfg_path))
      local dl_res = JSON.decode(E.File.readfile(dl_ns_res_key_cfg_path))
      namespace_res_collection[ns] = namespace_res_collection[ns] or {}
      local res_data = namespace_res_collection[ns][res_key] or {}
      namespace_res_collection[ns][res_key] = res_data
      res_data[M.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] = using_res
      if dl_res then
        res_data[M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = dl_res.progress_info
        res_data[M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOADING_INFO] = dl_res.downloading_info
        res_data[M.NAMESPACE_RES_CONFIG_KEY.TYPE_RES_UPDATE_STATE] = dl_res.update_info
      else
        EL.LOG.warn(TAG, "load dl_config failed, its nil")
      end
    end
  end
  return namespace_res_collection
end

function M.static_get_all_local_namespace_res()
  if nil == namespace_res_collection then
    E.LOG.warn(TAG, "static_get_local_res_state, res_state not loaded, now begin load")
    M.static_load_all_local_namespace_res()
  end
  return namespace_res_collection
end

function M.static_get_local_res_state(namespace, res_key)
  if not namespace or not res_key then
    EL.LOG.warn(TAG, "static_get_local_res_state failed, namespace or res_key is nil")
    return nil
  end
  if nil == namespace_res_collection then
    E.LOG.warn(TAG, "static_get_local_res_state, res_state not loaded, now begin load")
    M.static_load_all_local_namespace_res()
  end
  local res_map = namespace_res_collection[namespace] or {}
  local res_info = res_map[res_key]
  return res_info
end

function M.static_get_app_ext_file_dir()
  if not app_ext_file_dir then
    app_ext_file_dir = E.File.get_ext_file_dir()
  end
  return app_ext_file_dir
end

function M.static_is_file_exists(res_path)
  local ejoy_res_parent_dir = M.static_get_app_ext_file_dir()
  local abs_using_ns_cfg_path = ejoy_res_parent_dir .. "/" .. res_path
  do return EHR.is_file_exists end
  return EHR.is_file_exists, abs_using_ns_cfg_path
end

function M.static_get_res_path(namespace, res_key)
  local ns_base_path = RES_BUILTIN_PATH .. "/" .. namespace .. "/"
  local ns_res_key_base_path = ns_base_path .. res_key .. "/"
  return ns_res_key_base_path
end

function M.static_get_res_storage_rela_path(namespace, res_key)
  local res_path = M.static_get_res_path(namespace, res_key)
  local _os = E.Sysinfo.os()
  if "ios" == _os then
    res_path = "Documents/" .. tostring(res_path)
  elseif "android" == _os then
    res_path = "files/" .. tostring(res_path)
  end
  return res_path
end

function M.static_ensure_res_path(namespace, res_key)
  local rela_res_path = M.static_get_res_path(namespace, res_key)
  local download_dir = E.File.get_ext_file_dir()
  local complete_path = download_dir .. "/" .. rela_res_path
  local result = false
  if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    EL.LOG.debug(TAG, "begin make_dirs:" .. tostring(complete_path))
    result = E.File.make_dirs(complete_path)
  end
  return result, complete_path
end

function M.static_get_namespace_config_path(namespace)
  local ns_base_path = RES_BUILTIN_PATH .. "/" .. namespace .. "/"
  local using_ns_config_path = ns_base_path .. USING_RES_CONFIG
  return using_ns_config_path
end

function M.static_get_res_group_rk_arr(namespace, res_key)
  local ns_config_path = M.static_get_namespace_config_path(namespace)
  local rk_arr_config_data = E.File.readfile(ns_config_path) or ""
  local rk_list = E.Utils.split_string(rk_arr_config_data, "\n")
  local group_rk_prefix = M.RES_GROUP_INFO_KEY.PREFIX .. tostring(res_key) .. "-"
  local group_rk = {}
  for _, rk in ipairs(rk_list) do
    if E.Utils.start_with(rk, group_rk_prefix) then
      table.insert(group_rk, rk)
    end
  end
  return group_rk
end

function M.static_get_namespace_arr_config_path()
  local ns_arr_config_path = RES_BUILTIN_PATH .. "/" .. NAMESPACE_CONFIG
  return ns_arr_config_path
end

function M.static_get_using_res_config_path(namespace, res_key)
  local ns_res_key_base_path = M.static_get_res_path(namespace, res_key)
  local using_ns_res_key_cfg_path = ns_res_key_base_path .. USING_RES_CONFIG
  return using_ns_res_key_cfg_path, ns_res_key_base_path
end

function M.static_get_using_res_file_list_path(game_apply_dest_path)
  local using_ns_res_key_file_list_path = E.Path.join(game_apply_dest_path, M.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST)
  return using_ns_res_key_file_list_path
end

function M.static_get_using_res_file_list(game_apply_dest_path)
  local LOCAL_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
  local local_file_list = LOCAL_FILE_LIST.static_get_file_list(game_apply_dest_path, false)
  do return local_file_list.get_file_list end
  return local_file_list.get_file_list, local_file_list
end

function M.static_update_using_res_file_list(game_apply_dest_path, file_list)
  local LOCAL_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
  local local_file_list = LOCAL_FILE_LIST.static_get_file_list(game_apply_dest_path, false)
  local_file_list:update_file_list(file_list)
  E.LOG.debug(TAG, "update static_update_using_res_file_list, file path is " .. tostring(game_apply_dest_path))
end

function M.static_get_downloading_config_path(namespace, res_key)
  local ns_res_key_base_path = M.static_get_res_path(namespace, res_key)
  local downloading_ns_res_key_cfg_path = ns_res_key_base_path .. DOWNLOADING_RES_CONFIG
  return downloading_ns_res_key_cfg_path, ns_res_key_base_path
end

function M.static_update_cached_res_info(namespace, res_key, using_res_info, _downloading_info, _progress_info)
  if not namespace or not res_key then
    EL.LOG.warn(TAG, "static_update_cached_res_info skip, namespace or res_key is nil")
    return
  end
  if not namespace_res_collection then
    namespace_res_collection = {}
  end
  local res_map_info = namespace_res_collection[namespace] or {}
  namespace_res_collection[namespace] = res_map_info
  local res_info = res_map_info[res_key] or {}
  res_map_info[res_key] = res_info
  res_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] = using_res_info
  res_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = _progress_info
  res_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOADING_INFO] = _downloading_info
  local ns_arr_cfg_path = M.static_get_namespace_arr_config_path()
  local ns_arr_str = ""
  for ns, res_map in pairs(namespace_res_collection) do
    ns_arr_str = ns_arr_str .. ns .. "\n"
    local ns_cfg_path = M.static_get_namespace_config_path(ns)
    local res_list_str = ""
    for rk, _ in pairs(res_map) do
      res_list_str = res_list_str .. rk .. "\n"
    end
    E.File.writefile(ns_cfg_path, res_list_str, false)
  end
  E.File.writefile(ns_arr_cfg_path, ns_arr_str, false)
  M.static_ensure_res_path(namespace, res_key)
  local using_ns_res_key_cfg_path = M.static_get_using_res_config_path(namespace, res_key)
  E.LOG.debug(TAG, "static_update_res_info: " .. tostring(using_ns_res_key_cfg_path))
  if not using_res_info then
    E.File.writefile(using_ns_res_key_cfg_path, "", false)
  else
    local res_info_str = JSON.encode(using_res_info) or ""
    E.File.writefile(using_ns_res_key_cfg_path, res_info_str, false)
  end
  local dl_res_obj = {
    progress_info = _progress_info,
    downloading_info = _downloading_info,
    update_info = res_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_RES_UPDATE_STATE]
  }
  local dl_info_str = JSON.encode(dl_res_obj) or ""
  local ns_res_key_dl_path = M.static_get_downloading_config_path(namespace, res_key)
  E.LOG.debug(TAG, "static_update_res_info: " .. tostring(ns_res_key_dl_path))
  E.File.writefile(ns_res_key_dl_path, dl_info_str, false)
end

local function static_save_namespace_res_collection(namespace, res_key, change_info_type)
  if not namespace_res_collection then
    E.LOG.warn(TAG, "static_save_namespace_res_collection skip namespace_res_collection is nil")
    return
  end
  local ns_arr_cfg_path = M.static_get_namespace_arr_config_path()
  local ns_arr_str = ""
  for ns, res_map in pairs(namespace_res_collection) do
    ns_arr_str = ns_arr_str .. ns .. "\n"
    local ns_cfg_path = M.static_get_namespace_config_path(ns)
    local res_list_str = ""
    for rk, _r_info in pairs(res_map) do
      res_list_str = res_list_str .. rk .. "\n"
    end
    E.File.writefile(ns_cfg_path, res_list_str, false)
  end
  E.File.writefile(ns_arr_cfg_path, ns_arr_str, false)
  local _ns_info = namespace_res_collection[namespace] or {}
  local _ns_rs_info = _ns_info[res_key]
  M.static_ensure_res_path(namespace, res_key)
  local using_ns_res_key_cfg_path = M.static_get_using_res_config_path(namespace, res_key)
  E.LOG.debug(TAG, "static_update_res_info: " .. tostring(using_ns_res_key_cfg_path))
  if change_info_type == M.INFO_TYPE_KEY.TYPE_USING_RES_INFO then
    local info = _ns_rs_info and _ns_rs_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO]
    if not info then
      E.File.writefile(using_ns_res_key_cfg_path, "", false)
    else
      local res_info_str = JSON.encode(info) or ""
      E.File.writefile(using_ns_res_key_cfg_path, res_info_str, false)
    end
  else
    local _progress_info = _ns_rs_info and _ns_rs_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOAD_PROGRESS_INFO]
    local _downloading_info = _ns_rs_info and _ns_rs_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOADING_INFO]
    local _update_info = _ns_rs_info and _ns_rs_info[M.NAMESPACE_RES_CONFIG_KEY.TYPE_RES_UPDATE_STATE]
    local dl_res_obj = {
      progress_info = _progress_info,
      downloading_info = _downloading_info,
      update_info = _update_info
    }
    local dl_info_str = JSON.encode(dl_res_obj) or ""
    local ns_res_key_dl_path = M.static_get_downloading_config_path(namespace, res_key)
    E.LOG.debug(TAG, "static_update_res_info: " .. tostring(ns_res_key_dl_path))
    E.File.writefile(ns_res_key_dl_path, dl_info_str, false)
  end
end

function M.static_update_cached_res_info_by_type(namespace, res_key, info_type, info)
  if not namespace or not res_key then
    EL.LOG.warn(TAG, "static_update_cached_res_info skip, namespace or res_key is nil")
    return
  end
  if not namespace_res_collection then
    namespace_res_collection = {}
  end
  local res_map_info = namespace_res_collection[namespace] or {}
  namespace_res_collection[namespace] = res_map_info
  local res_info = res_map_info[res_key] or {}
  res_map_info[res_key] = res_info
  local config_key
  if info_type == M.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE then
    config_key = M.NAMESPACE_RES_CONFIG_KEY.TYPE_RES_UPDATE_STATE
  elseif info_type == M.INFO_TYPE_KEY.TYPE_USING_RES_INFO then
    config_key = M.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO
  elseif info_type == M.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO then
    config_key = M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOAD_PROGRESS_INFO
  elseif info_type == M.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO then
    config_key = M.NAMESPACE_RES_CONFIG_KEY.TYPE_DOWNLOADING_INFO
  end
  if config_key then
    res_info[config_key] = info
  end
  static_save_namespace_res_collection(namespace, res_key, info_type)
end

function M.static_save_downloading_res_info(namespace, res_key, downloading_res_info, _progress_info)
  local res_info = {progress_info = _progress_info, downloading_info = downloading_res_info}
  M.static_ensure_res_path(namespace, res_key)
  local downloading_info_str = JSON.encode(res_info)
  local save_path = M.static_get_downloading_config_path(namespace, res_key)
  E.LOG.debug(TAG, "save downloading info to:" .. tostring(save_path))
  E.File.writefile(save_path, downloading_info_str, false)
end

function M.static_get_res_version_path(namespace, res_key, version)
  if not (namespace and res_key) or not version then
    EL.LOG.warn(TAG, "static_get_res_version_path skip, for invalid parameter, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", version:" .. tostring(version))
    return
  end
  local ns_res_key_path_base = M.static_get_res_path(namespace, res_key)
  local res_ver_path = ns_res_key_path_base .. tostring(version)
  local download_dir = M.static_get_app_ext_file_dir()
  local _dest_path = download_dir .. "/" .. res_ver_path
  return _dest_path
end

function M.static_get_res_version_rela_path(namespace, res_key, version)
  if not (namespace and res_key) or not version then
    EL.LOG.warn(TAG, "static_get_res_version_path skip, for invalid parameter, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", version:" .. tostring(version))
    return
  end
  local ns_res_key_path_base = M.static_get_res_path(namespace, res_key)
  local res_ver_path = ns_res_key_path_base .. tostring(version)
  return res_ver_path
end

function M.test_static_mark_namespace_config_cache_empty()
  namespace_res_collection = {}
end

return M
