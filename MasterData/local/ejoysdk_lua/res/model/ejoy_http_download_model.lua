local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local E = require("ejoysdk_lua.ejoysdk")
local _UNI = require("ejoysdk_lua.vendors.unisdk")
local DT = require("ejoysdk_lua.res.model.http_download_task_facade")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local EHR = require("ejoysdk_lua.res.ejoy_http_res_utils")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local DST = require("ejoysdk_lua.res.model.http_download_stat")
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local MODEL_NAME = "EjoyHttpDownloadModel"
local M = ERB:Inherit(MODEL_NAME)
M.DOWNLOAD_STATE = DT.DOWNLOAD_STATE
M.DOWNLOAD_CHECK_STATE = DT.DOWNLOAD_CHECK_STATE
M.DOWNLOAD_ERROR_CODES = EC.DOWNLOAD_ERROR_CODES
M.STATE_KEY = DT.STATE_KEY
M.PROGRESS_INFO_KEY = DT.PROGRESS_INFO_KEY
M.LOG_LEVEL = ERB.INNER_LOG_LEVEL
M.TASK_INIT_PARAMS = DT.TASK_INIT_PARAMS
M.INIT_FILE_STATE_KEY = DT.CHCKED_FILE_STATE_KEY
M.FILE_DEST_INFO_KEY = DT.FILE_DEST_INFO_KEY
local TAG = MODEL_NAME
local DEFAULT_CACHED_PATH_NAME = "ejoy_download_temp"
local DEFAULT_IOS_CACHED_PATH_NAME = "Documents/" .. DEFAULT_CACHED_PATH_NAME
local DEFAULT_HARMONY_OS_CACHED_PATH_NAME = "cache/" .. DEFAULT_CACHED_PATH_NAME
local DEFAULT_MAX_RETRY_TIME = 3
local DEFAULT_STORAGE_TYPE = M.STORAGE_TYPE.INTERNAL_APP_PRIVATE
local DEFAULT_CONNECT_TIMEOUT = 5000
local DEFAULT_READ_TIMEOUT = 10000
local DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS = DT.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS
local DEFAULT_HTTP_EVENT_PROGRESS_INTERVAL_MILLS = DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS
local HTTP_INTERVAL_LIMIT = 0.2
local READ_BUFFER_SIZE_BYTES = 16384
local IOS_RELA_PATH_WHITE_PREFIX = {
  "Documents",
  "Library",
  "tmp"
}
local global_download_config = {}
local cur_os = _ejoysdk.os and _ejoysdk.os()
local last_update_limit_val, last_update_read_buffer_size, last_progress_notify_interval_millis

function M:_init(p_model_name)
  self._data = {
    model_name = p_model_name,
    runtime_task_infos = {
      task = nil,
      url = nil,
      name = nil,
      path = nil,
      storage_type = nil
    },
    runtime_taskid_tag_map = {},
    global_config = {
      download_state_listener = nil,
      max_retry_times = DEFAULT_MAX_RETRY_TIME,
      max_bandwidth_kbytes_per_sec = 0,
      connect_timeout = DEFAULT_CONNECT_TIMEOUT,
      read_timeout = DEFAULT_READ_TIMEOUT,
      temp_download_dir = nil,
      progress_notify_interval_millis = DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS,
      use_independent_pool = false,
      use_cache_complete_file_md5 = true,
      log_output_level = ERB.INNER_LOG_LEVEL.INFO,
      enable_limit_speed = true,
      enable_download_range = true
    },
    downloading_file_range_info = nil,
    last_update_range_info_time = 0,
    last_save_task_md5_time = 0,
    downloading_range_keystore = nil,
    cache_md5_cfg_json = {},
    download_server_config = nil
  }
  if not self._data.download_server_config then
    local CC = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
    if biz_config and biz_config.config and biz_config.config.cloud_download_switch then
      self._data.download_server_config = biz_config.config.cloud_download_switch
      E.LOG.debug(TAG, "get cloud_download_switch in single init>>")
      E.log(self._data.download_server_config)
      self._data.global_config.use_cache_complete_file_md5 = self._data.download_server_config.use_cache_complete_file_md5
      self._data.global_config.use_independent_pool = self._data.download_server_config.use_independent_pool
      E.LOG.debug(TAG, "update global_config single, use_cache_complete_file_md5:" .. tostring(self._data.global_config.use_cache_complete_file_md5) .. ", use_independent_pool:" .. tostring(self._data.global_config.use_independent_pool))
    end
  end
  self:_init_download_config()
  self:log_debug("_init begin:" .. tostring(p_model_name))
end

function M:get_model_name()
  return self._data.model_name
end

function M:get_module_log_prefix()
  return TAG
end

function M:get_log_output_level()
  return self._data.global_config.log_output_level
end

local function guess_file_name_from_url(url)
  local file_name = EHR.guess_url_filename(url)
  return file_name
end

function M._test_guess_file_name_from_url(url)
  do return guess_file_name_from_url end
  return guess_file_name_from_url, url
end

local function _check_ios_path_valid(path, _storage_type)
  if "ios" == cur_os and path then
    local tmp_path = path
    if _storage_type == M.STORAGE_TYPE.EXTERNAL_OTHER then
      local _base_path = ERB.static_get_storage_path_by_type(M.STORAGE_TYPE.INTERNAL_APP_PRIVATE)
      local _begin, _end = path:find(_base_path, 1, true)
      if _end then
        if _end < string.len(path) then
          tmp_path = path:sub(_end + 1)
        else
          tmp_path = ""
        end
      end
    end
    tmp_path = E.Path.trim_begin_separator(tmp_path)
    local is_prefix_valid = false
    for _, wp in ipairs(IOS_RELA_PATH_WHITE_PREFIX) do
      if E.Utils.start_with(tmp_path, wp) then
        is_prefix_valid = true
        break
      end
    end
    if not is_prefix_valid then
      return false, "dest_path in ios inner storage directory should begin with 'Documents', 'Library', 'tmp', current storage type:" .. tostring(_storage_type) .. ", path:" .. tostring(path)
    else
      return true
    end
  else
    return true
  end
end

function M._test_check_ios_path_valid(path, _storage_type)
  do return _check_ios_path_valid, path end
  return _check_ios_path_valid, path, _storage_type
end

local function get_file_dest_info_with_params(url, path, name, _storage_type)
  local file_info = {}
  file_info[DT.FILE_DEST_INFO_KEY.URL] = url
  local dest_file_name
  if not name or "" == name then
    dest_file_name = guess_file_name_from_url(url)
    if DST.is_log_allow_with_level(DST.INNER_LOG_LEVEL.DEBUG) then
      DST.log_debug(TAG, "gen_task_id check file name empty, now guess from url:" .. tostring(url) .. ", " .. tostring(dest_file_name))
    end
  else
    dest_file_name = name
  end
  file_info[DT.FILE_DEST_INFO_KEY.NAME] = dest_file_name
  local dest_path = path
  if nil == dest_path then
    if "ios" == cur_os then
      dest_path = DEFAULT_IOS_CACHED_PATH_NAME
    elseif "harmonyos" == cur_os then
      dest_path = DEFAULT_HARMONY_OS_CACHED_PATH_NAME
    else
      dest_path = DEFAULT_CACHED_PATH_NAME
    end
  end
  dest_path = E.Utils.trim_end(dest_path, "/")
  local dest_path_relative = dest_path
  local dest_file_path_relative = dest_path_relative .. "/" .. dest_file_name
  local storage_type = _storage_type or DEFAULT_STORAGE_TYPE
  local storage_path = ERB.static_get_storage_path_by_type(storage_type)
  if storage_path then
    if dest_path and "" ~= dest_path then
      dest_path = E.Path.trim_begin_separator(dest_path)
      dest_path = storage_path .. "/" .. dest_path
    else
      dest_path = storage_path
    end
  end
  file_info[DT.FILE_DEST_INFO_KEY.STORAGE_PATH] = storage_path
  file_info[DT.FILE_DEST_INFO_KEY.DEST_RELA_PATH] = dest_file_path_relative
  file_info[DT.FILE_DEST_INFO_KEY.DEST_FILE_DIR] = dest_path
  file_info[DT.FILE_DEST_INFO_KEY.DEST_FILE_PATH] = dest_path .. "/" .. dest_file_name
  if "ios" == cur_os and storage_path then
    local temp = M.get_parent_folder(storage_path)
    local dest_file_path_ios_no_application = temp .. dest_file_path_relative
    file_info.dest_file_path_ios_no_application = dest_file_path_ios_no_application
  end
  return file_info
end

function M._test_mock_os(os_val)
  cur_os = os_val
end

function M._test_get_file_dest_info_with_params(url, path, name, _storage_type)
  do return get_file_dest_info_with_params, url, path, name end
  return get_file_dest_info_with_params, url, path, name, _storage_type
end

local function get_file_signature_info(url, file_ext, opts)
  local signature_info = {}
  signature_info.url = url
  signature_info.path = file_ext and file_ext.dest_path or nil
  signature_info.name = file_ext and file_ext.name or nil
  signature_info.storage_type = opts and opts.storage_type or nil
  return signature_info
end

function M._test_get_file_signature_info(url, file_ext, opts)
  do return get_file_signature_info, url, file_ext end
  return get_file_signature_info, url, file_ext, opts
end

function M.get_file_dest_info(url, file_ext, opts)
  local file_signature_info = get_file_signature_info(url, file_ext, opts)
  local path = file_signature_info.path
  local name = file_signature_info.name
  local storage_type = file_signature_info.storage_type
  do return get_file_dest_info_with_params, url, path, name end
  return get_file_dest_info_with_params, url, path, name, storage_type
end

function M._test_get_file_dest_info(url, file_ext, opts)
  do return M.get_file_dest_info, url, file_ext end
  return M.get_file_dest_info, url, file_ext, opts
end

local function gen_task_id(url, file_ext, opts)
  local file_signature_info = get_file_signature_info(url, file_ext, opts)
  local path = file_signature_info.path
  local name = file_signature_info.name
  local storage_type = file_signature_info.storage_type
  do return M.find_task_id, url, path, name end
  return M.find_task_id, url, path, name, storage_type
end

function M.static_get_task_id(url, file_ext, opts)
  do return gen_task_id, url, file_ext end
  return gen_task_id, url, file_ext, opts
end

function M.find_task_id(url, dest_path, name, storage_type)
  local file_dest_info = get_file_dest_info_with_params(url, dest_path, name, storage_type)
  do return M._do_find_task_id end
  return M._do_find_task_id, file_dest_info, name, storage_type
end

function M._do_find_task_id(file_dest_info)
  local dest_download_file_path = file_dest_info.dest_file_path
  if "ios" == cur_os and file_dest_info.dest_file_path_ios_no_application then
    dest_download_file_path = file_dest_info.dest_file_path_ios_no_application
  end
  local taskid_hash = _ejoysdk_crypt.hashkey(dest_download_file_path)
  local taskid = _ejoysdk_crypt.hexencode(taskid_hash)
  return taskid, file_dest_info
end

function M:check_file_state(url, file_ext, opts, init_check_params)
  local task_id, file_dest_info
  if init_check_params then
    task_id = init_check_params[DT.TASK_INIT_PARAMS.TASK_ID]
    file_dest_info = init_check_params[DT.TASK_INIT_PARAMS.DEST_FILE_INFO]
  else
    task_id, file_dest_info = M.static_get_task_id(url, file_ext, opts)
  end
  local state, state_info = DT._static_check_init_download_state(url, task_id, file_ext, file_dest_info, self, init_check_params)
  return state, state_info, task_id
end

function M:get_task_init_params(url, file_ext, opts)
  local file_signature_info = get_file_signature_info(url, file_ext, opts)
  local _file_dest_info = get_file_dest_info_with_params(url, file_signature_info.path, file_signature_info.name, file_signature_info.storage_type)
  local _task_id = M._do_find_task_id(_file_dest_info)
  local _file_temp_path, _tmp_rela_path = self:_get_download_temp_file_path_rela(_file_dest_info[DT.FILE_DEST_INFO_KEY.STORAGE_PATH], _file_dest_info[DT.FILE_DEST_INFO_KEY.DEST_RELA_PATH])
  return {
    [DT.TASK_INIT_PARAMS.DEST_FILE_PATH] = _file_dest_info[DT.FILE_DEST_INFO_KEY.DEST_FILE_PATH],
    [DT.TASK_INIT_PARAMS.FILE_RELA_PATH] = _file_dest_info[DT.FILE_DEST_INFO_KEY.DEST_RELA_PATH],
    [DT.TASK_INIT_PARAMS.FILE_TEMP_PATH] = _file_temp_path,
    [DT.TASK_INIT_PARAMS.TEMP_RELA_PATH] = _tmp_rela_path,
    [DT.TASK_INIT_PARAMS.STORAGE_PATH] = _file_dest_info[DT.FILE_DEST_INFO_KEY.STORAGE_PATH],
    [DT.TASK_INIT_PARAMS.TASK_ID] = _task_id,
    [DT.TASK_INIT_PARAMS.DEST_FILE_INFO] = _file_dest_info
  }
end

function M:query_runtime_task_with_tag(tag_name)
  if not tag_name or "" == tag_name then
    self:log_debug("query_download_task_with_id return nil, for tag_name is nil")
    return nil, EC.DOWNLOAD_ERROR_CODES.INVALID_PARAMS, "tag is nil"
  end
  local download_task_info = self._data.runtime_task_infos[tag_name]
  if download_task_info and download_task_info.task then
    return download_task_info.task
  else
    return nil, EC.DOWNLOAD_ERROR_CODES.UNKNOWN_TASK, "unknown task:" .. tostring(tag_name)
  end
end

function M:query_runtime_task(url, dest_path, name, storage_type)
  local task_id = M.find_task_id(url, dest_path, name, storage_type)
  local tag_name = self._data.runtime_taskid_tag_map[task_id]
  do return self.query_runtime_task_with_tag, self end
  return self.query_runtime_task_with_tag, self, tag_name
end

function M:_inner_create_download_task_with_init_params(url, file_ext, opts, download_state_listener, download_progress_listener, model_instance, init_check_params)
  local task_id = init_check_params[DT.TASK_INIT_PARAMS.TASK_ID]
  local file_dest_info = init_check_params[DT.TASK_INIT_PARAMS.DEST_FILE_INFO]
  do return self._inner_do_create_task, self, task_id, url, file_ext, opts, file_dest_info, download_state_listener, download_progress_listener, model_instance end
  return self._inner_do_create_task, self, task_id, url, file_ext, opts, file_dest_info, download_state_listener, download_progress_listener, model_instance, init_check_params
end

function M:_inner_create_download_task(url, file_ext, opts, download_state_listener, download_progress_listener, model_instance)
  file_ext = file_ext or {}
  local task_id = file_ext.task_id
  task_id = task_id or gen_task_id(url, file_ext, opts)
  local file_dest_info = M.get_file_dest_info(url, file_ext, opts)
  do return self._inner_do_create_task, self, task_id, url, file_ext, opts, file_dest_info, download_state_listener, download_progress_listener end
  return self._inner_do_create_task, self, task_id, url, file_ext, opts, file_dest_info, download_state_listener, download_progress_listener, model_instance
end

function M:_inner_do_create_task(task_id, url, file_ext, opts, file_dest_info, download_state_listener, download_progress_listener, model_instance, init_check_params)
  local params = {
    file_dest_info = file_dest_info,
    download_state_listener = download_state_listener,
    download_progress_listener = download_progress_listener,
    init_check_params = init_check_params
  }
  local download_task = DT:New(task_id, url, file_ext, opts, params, model_instance)
  return download_task
end

function M:_query_runtime_downloading_task(task_id, tag_name, _url)
  tag_name = tag_name or task_id
  local runtime_task = self:query_runtime_task_with_tag(tag_name)
  self:log_debug("create_task query_runtime_task_with_tag task_id:" .. tostring(task_id) .. ", tag:" .. tostring(tag_name) .. ", downloading_task:" .. tostring(runtime_task))
  if runtime_task and runtime_task:is_downloading() then
    local runtime_task_info = runtime_task:task_info()
    if _url == runtime_task_info.url then
      self:log_debug("same url and same task_id is downloading, return downloading task")
      return true, runtime_task
    else
      self:log_warn("different url and same task_id is downloading, current task is invalid, create failed")
      return true, nil, EC.DOWNLOAD_ERROR_CODES.TASK_ALREADY_RUNNING, "downloading task already exists"
    end
  end
  local last_bind_tag_name = self._data.runtime_taskid_tag_map[task_id]
  local last_id_bind_runtime_task = self:query_runtime_task_with_tag(last_bind_tag_name)
  if last_id_bind_runtime_task and last_id_bind_runtime_task:is_downloading() then
    local runtime_task_info = last_id_bind_runtime_task:task_info()
    if _url == runtime_task_info.url then
      self:log_debug("same url and same task_id is downloading, return downloading task")
      return true, last_id_bind_runtime_task
    else
      self:log_warn("different url and same task_id is downloading, current task is invalid, create failed")
      return true, nil, EC.DOWNLOAD_ERROR_CODES.TASK_ALREADY_RUNNING, "downloading task already exists for task_id:" .. tostring(task_id) .. ", tag:" .. tostring(last_bind_tag_name) .. ", new tag:" .. task_id
    end
  end
  return false
end

function M:_update_runtime_task_info(runtime_task, file_signature_info, _url, task_id, tag_name)
  tag_name = tag_name or task_id
  local _name = file_signature_info.name
  local _path = file_signature_info.path
  local _storage_type = file_signature_info.storage_type
  self._data.runtime_taskid_tag_map[task_id] = tag_name
  self._data.runtime_task_infos[tag_name] = {
    task = runtime_task,
    url = _url,
    name = _name,
    path = _path,
    storage_type = _storage_type
  }
end

local function check_save_path_valid(_storage_type, _dest_path)
  local storage_path_check_result = _storage_type ~= M.STORAGE_TYPE.EXTERNAL_OTHER or _storage_type == M.STORAGE_TYPE.EXTERNAL_OTHER and _dest_path
  _ejoysdk.log("check_save_path_valid:" .. tostring(storage_path_check_result) .. ", _storage_type:" .. tostring(_storage_type) .. ", _dest_path:" .. tostring(_dest_path))
  if not storage_path_check_result then
    return false, "storage is set to external_other, so dest_path should NOT be nil!!!, storage:" .. tostring(_storage_type) .. ", path:" .. tostring(_dest_path)
  end
  do return _check_ios_path_valid, _dest_path end
  return _check_ios_path_valid, _dest_path, _storage_type, ", path:", tostring(_dest_path), _dest_path, tostring(_dest_path), _dest_path
end

function M._test_check_save_path_valid(_storage_type, _dest_path)
  do return check_save_path_valid, _storage_type end
  return check_save_path_valid, _storage_type, _dest_path
end

function M:create_task_impl(_url, file_ext, opts, download_state_listener, download_progress_listener)
  self:log_debug("create task begin")
  opts = opts or {}
  file_ext = file_ext or {}
  local _storage_type = opts and opts.storage_type
  local _dest_path = file_ext.dest_path
  if not opts.disable_check_ios_path_valid then
    assert(check_save_path_valid(_storage_type, _dest_path))
  end
  local task_id = gen_task_id(_url, file_ext, opts)
  local tag_name = file_ext.tag or task_id
  file_ext.task_id = task_id
  file_ext.priority = file_ext.priority or 0
  local runtime_task = self:_inner_create_download_task(_url, file_ext, opts, download_state_listener, download_progress_listener, self)
  local file_signature_info = get_file_signature_info(_url, file_ext, opts)
  self:_update_runtime_task_info(runtime_task, file_signature_info, _url, task_id, tag_name)
  return runtime_task
end

function M:create_task_with_init_params_impl(_url, file_ext, opts, download_state_listener, download_progress_listener, init_check_params)
  self:log_debug("create_task_with_init_params begin")
  opts = opts or {}
  local _storage_type = opts.storage_type
  local _dest_path = file_ext and file_ext.dest_path
  if not opts.disable_check_ios_path_valid then
    assert(check_save_path_valid(_storage_type, _dest_path))
  end
  local task_id = init_check_params[DT.TASK_INIT_PARAMS.TASK_ID]
  local exists_downloading_runtime_task, runtime_task, code, msg = self:_query_runtime_downloading_task(task_id, nil, _url)
  if exists_downloading_runtime_task then
    return runtime_task, code, msg
  end
  runtime_task = self:_inner_create_download_task_with_init_params(_url, file_ext, opts, download_state_listener, download_progress_listener, self, init_check_params)
  local file_signature_info = get_file_signature_info(_url, file_ext, opts)
  local disable_cache_task_instance = opts.disable_cache_task_instance or false
  local cache_task
  if not disable_cache_task_instance then
    cache_task = runtime_task
  end
  self:_update_runtime_task_info(cache_task, file_signature_info, _url, task_id)
  return runtime_task
end

local function update_download_limit(global_config)
  local _band_width = global_config.max_bandwidth_kbytes_per_sec or 0
  local _read_buffer_size_bytes = global_config.read_buffer_size_bytes or READ_BUFFER_SIZE_BYTES
  local _progress_notify_interval_millis = global_config.progress_notify_interval_millis or DEFAULT_HTTP_EVENT_PROGRESS_INTERVAL_MILLS
  if _band_width == last_update_limit_val and _read_buffer_size_bytes == last_update_read_buffer_size and _progress_notify_interval_millis == last_progress_notify_interval_millis then
    return
  else
    last_update_limit_val = _band_width
    last_update_read_buffer_size = _read_buffer_size_bytes
  end
  global_download_config = {
    limit_speed = _band_width,
    limit_interval = HTTP_INTERVAL_LIMIT,
    read_buffer_size_bytes = _read_buffer_size_bytes,
    progress_notify_interval = _progress_notify_interval_millis
  }
  E.LOG.debug(TAG, "update_download_limit:" .. tostring(_band_width) .. ", read_buffer_size:" .. tostring(_read_buffer_size_bytes) .. ", progress_notify_interval:" .. tostring(_progress_notify_interval_millis))
  ERB.update_http_config(global_download_config)
end

function M:_init_download_config()
  update_download_limit(self._data.global_config)
end

function M._test_update_download_limit(global_config)
  update_download_limit(global_config)
end

function M:update_download_config_impl(config)
  E.LOG.debug(TAG, "update_download_config >>")
  E.log(config)
  if config.max_retry_times then
    self._data.global_config.max_retry_times = config.max_retry_times
  end
  if config.max_band_width_kbytes_per_sec then
    self._data.global_config.max_bandwidth_kbytes_per_sec = config.max_band_width_kbytes_per_sec
  end
  if config.connect_timeout then
    self._data.global_config.connect_timeout = config.connect_timeout
  end
  if config.read_timeout then
    self._data.global_config.read_timeout = config.read_timeout
  end
  if config.temp_download_dir then
    self._data.global_config.temp_download_dir = config.temp_download_dir
  end
  if type(config.debug_enable) == "boolean" then
    self._data.global_config.debug_enable = config.debug_enable
  end
  if config.read_buffer_size_bytes then
    self._data.global_config.read_buffer_size_bytes = config.read_buffer_size_bytes
  end
  if config.progress_notify_interval_millis then
    self._data.global_config.progress_notify_interval_millis = config.progress_notify_interval_millis
  end
  if "boolean" == type(config.use_independent_pool) then
    self._data.global_config.use_independent_pool = config.use_independent_pool
  end
  if "boolean" == type(config.use_cache_complete_file_md5) then
    self._data.global_config.use_cache_complete_file_md5 = config.use_cache_complete_file_md5
  end
  if type(config.log_output_level) == "number" then
    self._data.global_config.log_output_level = config.log_output_level
  end
  if "boolean" == type(config.enable_limit_speed) then
    self._data.global_config.enable_limit_speed = config.enable_limit_speed
  end
  if "boolean" == type(config.enable_download_range) then
    self._data.global_config.enable_download_range = config.enable_download_range
  end
  update_download_limit(self._data.global_config)
end

function M.static_get_global_download_config()
  return global_download_config
end

function M:get_global_config()
  return self._data.global_config
end

function M:stop_download_impl(tag_name, cb)
  local task = self:query_runtime_task_with_tag(tag_name)
  if not task then
    self:log_debug("stop_download with no downloading state task, just return true")
    cb(true)
  else
    task:stop_download(function(succ, ...)
      if cb then
        cb(succ, ...)
      end
    end)
  end
end

function M:_create_offline_download_task(_url, _path, _name, _storage_type)
  local file_ext = {name = _name, dest_path = _path}
  local opts = {storage_type = _storage_type}
  local temp_task = self:_inner_create_download_task(_url, file_ext, opts, nil, nil, self)
  return temp_task
end

function M:_inner_remove_download(task, tag_name, cb)
  local function remove_cb(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end
  
  task:remove_download(function(succ, ...)
    if succ and tag_name then
      self:log_debug("remove_download succ, clear downloading tasks cache with task_id:" .. tostring(tag_name))
    end
    remove_cb(succ, ...)
  end)
end

function M:remove_download_impl(url, _path, _name, _storage_type, cb)
  local task = self:query_runtime_task(url, _path, _name, _storage_type)
  task = task or self:_create_offline_download_task(url, _path, _name, _storage_type)
  self:_inner_remove_download(task, task:task_tag_name(), cb)
end

function M:remove_download_by_tag_impl(tag_name, cb)
  local task = self:query_runtime_task_with_tag(tag_name)
  if not task then
    local task_cache = self._data.runtime_task_infos[tag_name]
    if task_cache and next(task_cache) ~= nil then
      task = self:_create_offline_download_task(task_cache.url, task_cache.path, task_cache.name, task_cache.storage_type)
    end
  end
  if not task then
    cb(false, EC.DOWNLOAD_ERROR_CODES.UNKNOWN_TASK, "unknown task tag:" .. tostring(tag_name))
  else
    self:_inner_remove_download(task, task:task_tag_name(), cb)
  end
end

function M:get_download_state_impl(url, _path, _name, _storage_type)
  local task = self:query_runtime_task(url, _path, _name, _storage_type)
  if task then
    do return task.get_download_state end
    return task.get_download_state, task, _path, _name, _storage_type, nil
  else
    local offline_task = self:_create_offline_download_task(url, _path, _name, _storage_type)
    local download_state = offline_task:get_download_state()
    local task_id = offline_task:task_id()
    local tag_name = self._data.runtime_taskid_tag_map[task_id]
    tag_name = tag_name or task_id
    download_state.tag = tag_name
    return download_state
  end
end

function M:get_download_state_by_tag_impl(tag_name)
  local task = self:query_runtime_task_with_tag(tag_name)
  self:log_debug("get_download_state_by_tag downloading result:" .. type(task))
  if task then
    do return task.get_download_state end
    return task.get_download_state, task, "get_download_state_by_tag downloading result:" .. type(task), type(task), task, nil, nil
  else
    local task_cache = self._data.runtime_task_infos[tag_name]
    if task_cache and next(task_cache) ~= nil then
      local offline_task = self:_create_offline_download_task(task_cache.url, task_cache.path, task_cache.name, task_cache.storage_type)
      local download_state = offline_task:get_download_state()
      download_state.tag = tag_name
      return download_state
    else
      return nil, EC.DOWNLOAD_ERROR_CODES.UNKNOWN_TASK, "unknown task tag:" .. tostring(tag_name)
    end
  end
end

function M:_get_downloading_range_cache()
  if self._data.downloading_range_keystore then
    return self._data.downloading_range_keystore
  end
  local model_name = self:get_model_name()
  local cache = E.SPKeyStore:New("download_range_info_cache", model_name)
  self._data.downloading_range_keystore = cache
  E.LOG.debug(TAG, "init local model downloading cache:" .. tostring(model_name))
  return cache
end

function M:on_receive_download_response_header(task_id, url, headers, expect_size)
  local content_length = headers["Content-Length"] or headers["content-length"] or 0
  content_length = tonumber(content_length)
  if 0 == content_length then
    expect_size = expect_size or 0
    if expect_size > 0 then
      content_length = expect_size
    end
    self:log_debug("on_receive_download_response_header, for content_length is 0, use expect_size:" .. tostring(expect_size))
  end
  local range_info = {
    [DT.RANGE_INFO_KEY.ETAG] = headers.ETag or headers.Etag or headers.etag,
    [DT.RANGE_INFO_KEY.LAST_MODIFIED] = headers["Last-Modified"] or headers["last-modified"],
    [DT.RANGE_INFO_KEY.COMPLETE_SIZE] = content_length,
    [DT.RANGE_INFO_KEY.URL] = url
  }
  self:_update_file_range_info(task_id, range_info)
end

function M:_update_file_range_info(task_id, range_info)
  local downloading_range_cache = self:_get_downloading_range_cache()
  if not self._data.downloading_file_range_info then
    local all_downloading_range_info = downloading_range_cache:get()
    self._data.downloading_file_range_info = all_downloading_range_info and CJSON.decode(all_downloading_range_info) or {}
  end
  local old_range_info = self._data.downloading_file_range_info[task_id]
  local range_info_changed = true
  local complete_size = range_info and range_info[DT.RANGE_INFO_KEY.COMPLETE_SIZE] or 0
  if nil == old_range_info and nil == range_info then
    range_info_changed = false
  elseif old_range_info == range_info then
    range_info_changed = false
  elseif nil ~= old_range_info and nil ~= range_info then
    local etag_equals = old_range_info[DT.RANGE_INFO_KEY.ETAG] == range_info[DT.RANGE_INFO_KEY.ETAG]
    local lastmodify_equals = old_range_info[DT.RANGE_INFO_KEY.LAST_MODIFIED] == range_info[DT.RANGE_INFO_KEY.LAST_MODIFIED]
    local url_equals = old_range_info[DT.RANGE_INFO_KEY.URL] == range_info[DT.RANGE_INFO_KEY.URL]
    local all_equals = etag_equals and lastmodify_equals and url_equals
    range_info_changed = not all_equals
  elseif nil ~= range_info then
    range_info_changed = true
  end
  if range_info_changed then
    self._data.downloading_file_range_info[task_id] = range_info
  else
    return
  end
  local cur_time = E.system_clock()
  local need_save_to_disk = range_info_changed and complete_size > 2097152
  if need_save_to_disk then
    self._data.last_update_range_info_time = cur_time
    local cache_data_str = CJSON.encode(self._data.downloading_file_range_info)
    downloading_range_cache:set(cache_data_str, true)
  end
end

function M:_get_file_range_info_by_id(task_id)
  local downloading_range_cache = self:_get_downloading_range_cache()
  if not self._data.downloading_file_range_info then
    local all_downloading_range_info = downloading_range_cache:get()
    self._data.downloading_file_range_info = all_downloading_range_info and CJSON.decode(all_downloading_range_info) or {}
  end
  local range_info = self._data.downloading_file_range_info[task_id]
  if DST.is_log_allow_with_level(DST.INNER_LOG_LEVEL.DEBUG) then
    DST.log_debug(TAG, "_get_file_range_info_by_id:" .. tostring(task_id))
  end
  return range_info
end

function M:_update_complete_file_md5(task_id, dest_path, md5)
  if not (task_id and "" ~= task_id and dest_path and "" ~= dest_path and md5) or "" == md5 then
    self:log_warn("_update_complete_file_md5 skip, for params is invalid")
    return
  end
  local task_hex_bucket_prefix = task_id:sub(1, 1)
  local parent_dir = EHR.get_parent_folder(dest_path)
  local bucket_key = parent_dir .. "@" .. task_hex_bucket_prefix
  local md5_cfg_data = self._data.cache_md5_cfg_json[bucket_key] or {}
  self._data.cache_md5_cfg_json[bucket_key] = md5_cfg_data
  md5_cfg_data[task_id] = md5
  local cur_time = E.system_clock()
  local need_save_to_disk = cur_time - self._data.last_save_task_md5_time > 1000
  self._data.last_update_range_info_time = cur_time
  if need_save_to_disk then
    local md5_cfg_file = parent_dir .. "_dl_finish_md5@" .. task_hex_bucket_prefix .. ".json"
    local file = io.open(md5_cfg_file, "wb")
    if not file and _ejoysdk.os() == "windows" and _ejoysdk.utf8_to_acp then
      md5_cfg_file = _ejoysdk.utf8_to_acp(md5_cfg_file)
      file = io.open(md5_cfg_file, "wb")
    end
    if file then
      local data_str = CJSON.encode(md5_cfg_data)
      file:write(data_str)
      file:close()
    end
  end
end

function M:_mark_file_incomplete(task_id, dest_path)
  if not (task_id and "" ~= task_id and dest_path) or "" == dest_path then
    self:log_warn("_mark_file_incomplete skip, for params is invalid")
    return
  end
  local task_hex_bucket_prefix = task_id:sub(1, 1)
  local parent_dir = EHR.get_parent_folder(dest_path)
  local bucket_key = parent_dir .. "@" .. task_hex_bucket_prefix
  local md5_cfg_data = self._data.cache_md5_cfg_json[bucket_key]
  if not md5_cfg_data then
    return
  end
  md5_cfg_data[task_id] = nil
  local md5_cfg_file = parent_dir .. "_dl_finish_md5@" .. task_hex_bucket_prefix .. ".json"
  local file = io.open(md5_cfg_file, "wb")
  if not file and _ejoysdk.os() == "windows" and _ejoysdk.utf8_to_acp then
    md5_cfg_file = _ejoysdk.utf8_to_acp(md5_cfg_file)
    file = io.open(md5_cfg_file, "wb")
  end
  if file then
    local data_str = CJSON.encode(md5_cfg_data)
    file:write(data_str)
    file:close()
  end
end

function M:_get_complete_file_md5_cache(task_id, dest_path)
  if not E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    return nil
  end
  local task_hex_bucket_prefix = task_id:sub(1, 1)
  local parent_dir = EHR.get_parent_folder(dest_path)
  local bucket_key = parent_dir .. "@" .. task_hex_bucket_prefix
  local md5_cfg_data = self._data.cache_md5_cfg_json[bucket_key]
  local md5_result
  if not md5_cfg_data then
    local md5_cfg_file = parent_dir .. "_dl_finish_md5@" .. task_hex_bucket_prefix .. ".json"
    local file = io.open(md5_cfg_file, "rb")
    if not file and _ejoysdk.os() == "windows" and _ejoysdk.utf8_to_acp then
      md5_cfg_file = _ejoysdk.utf8_to_acp(md5_cfg_file)
      file = io.open(md5_cfg_file, "rb")
    end
    if file then
      local content = file:read()
      file:close()
      local content_table = {}
      if content then
        content_table = CJSON.decode(content)
      end
      content_table = content_table or {}
      self._data.cache_md5_cfg_json[bucket_key] = content_table
      md5_result = content_table[task_id]
    else
      self._data.cache_md5_cfg_json[bucket_key] = {}
    end
  else
    md5_result = md5_cfg_data[task_id]
  end
  return md5_result
end

function M:_get_download_temp_file_path(dest_file_dir, name)
  local global_config = self:get_global_config()
  local temp_download_dir = global_config.temp_download_dir
  if not temp_download_dir or "" == temp_download_dir then
    temp_download_dir = dest_file_dir
  end
  temp_download_dir = E.Utils.trim_end(temp_download_dir, "/")
  local temp_file_path = temp_download_dir .. "/" .. name .. DT.DOWNLOADING_FILE_SUFFIX
  return temp_file_path, temp_download_dir
end

function M:_get_download_temp_file_path_rela(storage_path, dest_file_rela_path)
  if not dest_file_rela_path or "" == dest_file_rela_path then
    return nil
  end
  local tmp_dest_file_rela_path = dest_file_rela_path .. DT.DOWNLOADING_FILE_SUFFIX
  if not storage_path or "" == storage_path then
    return tmp_dest_file_rela_path, tmp_dest_file_rela_path
  end
  tmp_dest_file_rela_path = E.Path.trim_begin_separator(tmp_dest_file_rela_path)
  local tmp_file_dest_full_path = storage_path .. "/" .. tmp_dest_file_rela_path
  return tmp_file_dest_full_path, tmp_dest_file_rela_path, storage_path
end

function M:_is_download_response_status_succ(status)
  return status >= 200 and status < 300 or 0 == status
end

function M:_is_download_response_fail_need_rm_file(code)
  return code == EC.EJOYSDK_ERROR_CODES.RES_DOWNLOAD_MD5_MISMATCH or code >= 400 and code < 500 and 408 ~= code and 429 ~= code and 499 ~= code
end

function M:_on_download_complete_check_file_md5_and_size_valid(downloading_file_path, expect_md5_str, expect_file_size)
  local check_md5_result = true
  if _ejoysdk.os() == "windows" and expect_md5_str then
    local md5_hex_str = HRU.check_file_md5(downloading_file_path)
    check_md5_result = md5_hex_str == expect_md5_str
    E.LOG.debug(TAG, "windows check md5 result, cur:" .. tostring(md5_hex_str) .. ", expect:" .. tostring(expect_md5_str) .. ", result:" .. tostring(check_md5_result))
  end
  local file_real_size, file_size_check
  if not expect_file_size or 0 == expect_file_size then
    local file_exists, file_size = HRU.is_file_exists(downloading_file_path)
    if file_exists then
      file_size_check = true
      file_real_size = file_size
    else
      file_size_check = false
      file_real_size = 0
    end
  else
    local is_valid, _file_exists, file_size = HRU.check_file_valid(downloading_file_path, expect_file_size)
    if is_valid then
      file_size_check = true
    else
      file_size_check = false
    end
    file_real_size = file_size
  end
  self:log_debug("recv file download succ, file_size_check result:" .. tostring(file_size_check) .. ", size:" .. tostring(file_real_size) .. ", check md5 result:" .. tostring(check_md5_result))
  return file_size_check and check_md5_result, file_real_size
end

function M:_on_download_complete_rename_temp_file(temp_file_path, dest_file_path)
  local result, _msg = E.File.rename_fullpath(temp_file_path, dest_file_path)
  if not result then
    if E.File.exists_fullpath(temp_file_path) then
      E.File.remove_fullpath(dest_file_path)
      result, _msg = E.File.rename_fullpath(temp_file_path, dest_file_path)
      self:log_debug("_rename_local_downloading_to_complete_file temp exists, rename twice result:" .. tostring(result))
      if not result then
        return false, _msg
      end
    elseif E.File.exists_fullpath(dest_file_path) then
      self:log_debug("_rename_local_downloading_to_complete_file temp not exists but dest exists, just return succ:")
      return true
    end
  end
  return result, _msg
end

return M
