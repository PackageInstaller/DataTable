local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local M = Class:Inherit("EjoyResModelBase")
local TAG = "ejoy_res_model_base"
M.LOCAL_FILE_STATUS = {
  COMPLETE = "complete",
  INVALID = "invalid",
  DOWNLOADING = "downloading"
}
M.STORAGE_TYPE = {
  INTERNAL_APP_PRIVATE = "internal_app_private",
  EXTERNAL_APP_PRIVATE = "external_app_private",
  EXTERNAL_OTHER = "external_other"
}
M.INNER_LOG_LEVEL = EU.INNER_LOG_LEVEL
local internal_app_private_root_path, external_app_private_root_path
local sys_dirs_cache = E.File.get_sys_dirs()
local DEFAULT_MAX_BANDWIDTH_KBYTES_PER_SEC = -1
local global_max_bandwidth_kbytes_per_sec = DEFAULT_MAX_BANDWIDTH_KBYTES_PER_SEC

function M.get_download_bandwidth_kbps()
  return global_max_bandwidth_kbytes_per_sec
end

function M:get_model_name()
  return TAG
end

function M:get_module_log_tag()
  local log_prefix = ""
  if self.get_module_log_prefix then
    log_prefix = self:get_module_log_prefix()
    log_prefix = tostring(log_prefix) .. "#"
  end
  return log_prefix .. "#" .. tostring(self:get_model_name())
end

function M:log_debug(message)
  local log_level
  if self.get_log_output_level then
    log_level = self:get_log_output_level()
  end
  if type(log_level) == "number" and log_level > M.INNER_LOG_LEVEL.DEBUG then
    return
  end
  E.LOG.debug(self:get_module_log_tag(), message)
end

function M:log_warn(message)
  local log_level
  if self.get_log_output_level then
    log_level = self:get_log_output_level()
  end
  if type(log_level) == "number" and log_level > M.INNER_LOG_LEVEL.WARN then
    return
  end
  E.LOG.warn(self:get_module_log_tag(), message)
end

function M.split_url(full_url)
  if not full_url then
    E.LOG.warn(TAG, "split_url failed, url is nil")
    return nil
  end
  local temp = string.reverse(full_url)
  local _, i = string.find(temp, "/")
  if nil == _ or nil == i then
    return full_url, ""
  end
  local offset = string.len(full_url) - i + 1
  return string.sub(full_url, 1, offset), string.sub(full_url, offset + 1, string.len(full_url))
end

function M.get_parent_folder(path)
  if not path then
    return path
  end
  if string.sub(path, string.len(path)) == "/" then
    path = string.sub(path, 1, string.len(path) - 1)
  end
  path = M.split_url(path)
  return path
end

local function static_get_internal_private_root_path()
  if internal_app_private_root_path then
    return internal_app_private_root_path
  end
  local os = _ejoysdk.os()
  if "ios" == os then
    local paths = sys_dirs_cache
    local document_path = paths.document_path
    internal_app_private_root_path = M.get_parent_folder(document_path)
  elseif "android" == os then
    local function android_default_path()
      return "/data/data/" .. E.Sysinfo.package_name()
    end
    
    local dirs = sys_dirs_cache
    if not dirs then
      local default_data_path = android_default_path()
      E.LOG.warn(TAG, "static_get_internal_private_root_path not support, use default:" .. tostring(default_data_path))
      internal_app_private_root_path = default_data_path
    else
      local root_dir = dirs.internal_app_root_dir
      if not root_dir or "" == root_dir then
        local default_data_path = android_default_path()
        root_dir = default_data_path
      end
      internal_app_private_root_path = root_dir
    end
    E.LOG.debug(TAG, "android internal app private root dir:" .. tostring(internal_app_private_root_path))
  elseif "windows" == os then
    local files = sys_dirs_cache
    if files then
      internal_app_private_root_path = files.program_private_dir
    else
      internal_app_private_root_path = ""
    end
  elseif "harmonyos" == os then
    local dirs = sys_dirs_cache
    local root_dir = dirs.internal_app_root_dir
    internal_app_private_root_path = root_dir
  end
  internal_app_private_root_path = E.Path.trim_end_separator(internal_app_private_root_path)
  E.LOG.debug(TAG, "static_get_app_private_root_path:" .. tostring(internal_app_private_root_path))
  return internal_app_private_root_path
end

local function static_get_external_private_root_path()
  if external_app_private_root_path then
    return external_app_private_root_path
  end
  local os = _ejoysdk.os()
  if "ios" == os then
    external_app_private_root_path = static_get_internal_private_root_path()
  elseif "android" == os then
    local dirs = sys_dirs_cache
    local root_dir
    if dirs then
      root_dir = dirs.external_app_files_dir
    end
    if not root_dir or "" == root_dir then
      root_dir = static_get_internal_private_root_path()
    else
      root_dir = M.get_parent_folder(root_dir)
    end
    E.LOG.debug(TAG, "android external app root dir:" .. tostring(root_dir))
    external_app_private_root_path = root_dir
  elseif "windows" == os then
    external_app_private_root_path = static_get_internal_private_root_path()
  elseif "harmonyos" == os then
    external_app_private_root_path = static_get_internal_private_root_path()
  end
  external_app_private_root_path = E.Path.trim_end_separator(external_app_private_root_path)
  E.LOG.debug(TAG, "static_get_external_private_root_path:" .. tostring(external_app_private_root_path))
  return external_app_private_root_path
end

function M.static_get_storage_path_by_type(storage_type)
  if storage_type == M.STORAGE_TYPE.EXTERNAL_APP_PRIVATE then
    do return end
    return static_get_external_private_root_path
  elseif storage_type == M.STORAGE_TYPE.INTERNAL_APP_PRIVATE then
    do return end
    return static_get_internal_private_root_path
  else
    return nil
  end
end

function M.get_target_res_save_full_path(save_base_path, save_storage_type)
  E.LOG.debug(TAG, "get_target_res_save_full_path save_base_path:" .. tostring(save_base_path) .. ", save_storage_type:" .. tostring(save_storage_type))
  local full_path
  if save_base_path and "" ~= save_base_path then
    local root_path
    if save_storage_type == M.STORAGE_TYPE.EXTERNAL_APP_PRIVATE then
      root_path = M.static_get_storage_path_by_type(M.STORAGE_TYPE.EXTERNAL_APP_PRIVATE)
    elseif save_storage_type == M.STORAGE_TYPE.INTERNAL_APP_PRIVATE then
      root_path = M.static_get_storage_path_by_type(M.STORAGE_TYPE.INTERNAL_APP_PRIVATE)
    else
      root_path = nil
    end
    if not root_path then
      full_path = save_base_path
    else
      root_path = E.Utils.trim_end(root_path, "/")
      save_base_path = E.Utils.trim_start(save_base_path, "/")
      full_path = root_path .. "/" .. save_base_path
    end
  end
  E.LOG.debug(TAG, "get_target_res_save_full_path:" .. tostring(full_path))
  return full_path
end

function M.get_disk_capcity(cb)
  E.LOG.debug(TAG, "[cloud game] request_disk_capacity")
  local storage = E.Sysinfo.storage()
  E.LOG.debug(TAG, string.format("[cloud game] get_disk_capacity %.2f", storage.availableInternalStorage / 1024 / 1024))
  cb(storage.availableInternalStorage)
end

function M.update_http_config(params)
  if not params then
    E.LOG.warn(TAG, "update_http_config failed, params is nil")
    return
  end
  local _limit_speed = params.limit_speed
  if type(_limit_speed) == "number" and 0 ~= _limit_speed then
    E.LOG.debug(TAG, "update_http_config limit_speed changed:" .. tostring(_limit_speed) .. ", old:" .. tostring(global_max_bandwidth_kbytes_per_sec))
    global_max_bandwidth_kbytes_per_sec = _limit_speed
  else
    E.LOG.debug(TAG, "update_http_config limit_speed not set or is 0, param _limit_speed:" .. tostring(_limit_speed) .. ", now keep global limit:" .. tostring(global_max_bandwidth_kbytes_per_sec))
    params.limit_speed = global_max_bandwidth_kbytes_per_sec
  end
  E.HTTP.update_with_config(params)
end

local available_storage_bytes = -1
local available_storage_cost_time = 0
local _get_storage_time = 0

function M.get_available_storage()
  if available_storage_bytes > 0 then
    if os.time() - _get_storage_time > 60 then
      _get_storage_time = os.time()
      E.Sysinfo.async_storage(function(info)
        available_storage_bytes = info and info.availableInternalStorage or available_storage_bytes or -1
      end)
    end
    return available_storage_bytes
  else
    local storage = E.Sysinfo.storage()
    available_storage_bytes = storage and storage.availableInternalStorage or -1
    return available_storage_bytes
  end
end

function M.get_total_required_storage(size)
  local buffer_percentage = 0.1
  local more_mb_size = size * buffer_percentage
  local total_required_size = size + more_mb_size
  return total_required_size, more_mb_size, buffer_percentage
end

function M.check_storage_available(size)
  if not size or size <= 0 then
    E.LOG.warn(TAG, "check_storage_available skip and return true, size param is invalid:" .. tostring(size))
    return true
  end
  local available_size = M.get_available_storage()
  if available_size <= 0 then
    E.LOG.warn(TAG, "check_storage_available skip for get system available storage failed:" .. tostring(available_size))
    return true
  end
  local total_required_size = M.get_total_required_storage(size)
  local is_enough = available_size > total_required_size
  return is_enough, available_size
end

function M.get_available_storage_cost_time()
  return available_storage_cost_time
end

do
  local before = E.system_clock()
  E.Sysinfo.async_storage(function(info)
    available_storage_cost_time = E.system_clock() - before
    available_storage_bytes = info and info.availableInternalStorage or -1
    _get_storage_time = os.time()
    E.LOG.debug(TAG, "async_storage received:" .. tostring(available_storage_bytes))
  end)
end
return M
