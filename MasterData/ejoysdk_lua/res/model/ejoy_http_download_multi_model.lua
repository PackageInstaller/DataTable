local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local MODEL_NAME = "EjoyHttpMultiModel"
local M = ERB:Inherit(MODEL_NAME)
local DMT = require("ejoysdk_lua.res.model.http_download_multi_task_facade")
local uuid = require("ejoysdk_lua.ejoysdk_uuid")
M.DOWNLOAD_STATE = DMT.DOWNLOAD_STATE
M.DOWNLOAD_ERROR_CODES = EC.DOWNLOAD_ERROR_CODES
M.STATE_KEY = DMT.STATE_KEY
M.PROGRESS_INFO_KEY = DMT.PROGRESS_INFO_KEY
M.LOG_LEVEL = ERB.INNER_LOG_LEVEL
M.NETWORK_STRATEGY = NS.STRATEGY
local TAG = MODEL_NAME
local DEFAULT_MAX_RETRY_TIME = 3
local DEFAULT_CONNECT_TIMEOUT = 5000
local DEFAULT_READ_TIMEOUT = 10000
local DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS = DMT.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS
local HTTP_INTERVAL_LIMIT = 0.2
local READ_BUFFER_SIZE_BYTES = 16384
local _global_uuid_val
local _global_multi_task_id_index = 0

function M:_init(p_model_name)
  self._data = {
    model_name = p_model_name,
    single_model = nil,
    runtime_task_infos = {task_id = nil, task = nil},
    runtime_taskid_tag_map = {},
    global_config = {
      download_state_listener = nil,
      max_retry_times = DEFAULT_MAX_RETRY_TIME,
      max_bandwidth_kbytes_per_sec = 0,
      connect_timeout = DEFAULT_CONNECT_TIMEOUT,
      read_timeout = DEFAULT_READ_TIMEOUT,
      temp_download_dir = nil,
      need_stat_progress = true,
      progress_notify_interval_millis = DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS,
      foreground_notification_enabled = nil,
      use_independent_pool = true,
      use_cache_complete_file_md5 = true,
      log_output_level = ERB.INNER_LOG_LEVEL.INFO,
      enable_limit_speed = true,
      enable_download_range = true,
      use_download_multi_task2 = true
    },
    downloading_file_range_info = nil,
    cache_downloading_range_info = nil,
    download_server_config = nil,
    cache_md5_file_name_prefix = "_ej_md5_cache"
  }
  local emm = require("ejoysdk_lua.res.ejoy_res_model_factory")
  local single_model = emm.get_http_res_model("single_model")
  self._data.single_model = single_model
  if not self._data.download_server_config then
    local CC = require("ejoysdk_lua.ejoysdk_config_center")
    
    local function init_config()
      local _biz_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
      E.log("init config begin biz_config >>")
      E.log(_biz_config)
      
      local function apply_with_biz_config(biz_config)
        if biz_config.config and biz_config.config.cloud_download_switch then
          self._data.download_server_config = biz_config.config.cloud_download_switch
          E.LOG.debug(TAG, "get cloud_download_switch in multi init>>")
          E.log(self._data.download_server_config)
          self._data.global_config.use_cache_complete_file_md5 = self._data.download_server_config.use_cache_complete_file_md5
          self._data.global_config.max_downloading_count = self._data.download_server_config.max_downloading_count
          self._data.global_config.use_independent_pool = self._data.download_server_config.use_independent_pool
          self._data.global_config.foreground_notification_enabled = self._data.download_server_config.foreground_notification_enabled
          if type(self._data.download_server_config.use_download_multi_task2) == "boolean" then
            self._data.global_config.use_download_multi_task2 = self._data.download_server_config.use_download_multi_task2
          end
          E.LOG.debug(TAG, "update global_config multi, use_cache_complete_file_md5:" .. tostring(self._data.global_config.use_cache_complete_file_md5) .. ", max_downloading_count:" .. tostring(self._data.global_config.max_downloading_count) .. ", use_independent_pool:" .. tostring(self._data.global_config.use_independent_pool) .. ", foreground_notification_enabled:" .. tostring(self._data.global_config.foreground_notification_enabled) .. ", use_download_multi_task2:" .. tostring(self._data.global_config.use_download_multi_task2))
        else
          E.LOG.warn(TAG, "get cloud_download_switch nil, use default config")
        end
      end
      
      if _biz_config then
        apply_with_biz_config(_biz_config)
      end
    end
    
    init_config()
  end
  self:log_debug("_init begin:" .. tostring(p_model_name))
end

function M:get_model_name()
  return self._data.model_name
end

function M:get_module_log_prefix()
  return TAG
end

local function gen_multi_task_id()
  if not _global_uuid_val then
    _global_uuid_val = uuid()
  end
  _global_multi_task_id_index = _global_multi_task_id_index + 1
  local n_task_id = _global_uuid_val .. "_" .. tostring(_global_multi_task_id_index)
  _ejoysdk.log("gen_multi_task_id:" .. tostring(n_task_id))
  return n_task_id
end

function M:query_runtime_task_with_tag(tag_name)
  if not tag_name or "" == tag_name then
    self:log_warn(TAG, "query_download_task_with_id return nil, for tag_name is nil")
    return nil, EC.DOWNLOAD_ERROR_CODES.INVALID_PARAMS, "tag or task_id is nil"
  end
  local download_task_info = self._data.runtime_task_infos[tag_name]
  if download_task_info and download_task_info.task then
    return download_task_info.task
  else
    return nil, EC.DOWNLOAD_ERROR_CODES.UNKNOWN_TASK, "unknown task:" .. tostring(tag_name)
  end
end

function M:query_runtime_task(task_id)
  local tag_name = self._data.runtime_taskid_tag_map[task_id]
  do return self.query_runtime_task_with_tag, self end
  return self.query_runtime_task_with_tag, self, tag_name
end

function M:_inner_create_download_task(task_id, file_list, file_ext, opts, download_state_listener, download_progress_listener, model_instance)
  local params = {download_state_listener = download_state_listener, download_progress_listener = download_progress_listener}
  opts = opts or {}
  local download_task = DMT:New(task_id, file_list, file_ext, opts, params, model_instance, self._data.single_model, self._data.global_config.use_download_multi_task2)
  return download_task
end

function M:create_task_impl(file_list, file_ext, opts, download_state_listener, download_progress_listener)
  self:log_debug("create task begin")
  if type(file_list) ~= "table" then
    return nil, EC.DOWNLOAD_ERROR_CODES.INVALID_PARAMS, "file_list is not a table(array)"
  elseif #file_list <= 0 then
    return nil, EC.DOWNLOAD_ERROR_CODES.INVALID_PARAMS, "file_list is empty"
  end
  if file_ext.total_size and _ejoysdk.os() ~= "windows" and _ejoysdk.os() ~= "ios" then
    local total_size = file_ext.total_size
    local storage = E.Sysinfo.storage()
    if storage then
      local available_size = storage.availableInternalStorage or -1
      E.LOG.debug(TAG, "available_size:" .. tostring(available_size))
      if available_size > 0 then
        local more_mb_size = total_size * 0.1
        if available_size < total_size + more_mb_size then
          return nil, EC.DOWNLOAD_ERROR_CODES.DOWNLOAD_DISK_NOT_ENOUGH, "not enough disk to download"
        end
      end
    end
  end
  local task_id = gen_multi_task_id()
  local tag_name = file_ext and file_ext.tag or task_id
  file_ext.priority = file_ext.priority or 0
  local runtime_task
  runtime_task = self:_inner_create_download_task(task_id, file_list, file_ext, opts, download_state_listener, download_progress_listener, self)
  self._data.runtime_taskid_tag_map[task_id] = tag_name
  self._data.runtime_task_infos[tag_name] = {task = runtime_task}
  return runtime_task
end

local function update_default_config(global_config)
  local _band_width = global_config.max_bandwidth_kbytes_per_sec or 0
  local _read_buffer_size_bytes = global_config.read_buffer_size_bytes or READ_BUFFER_SIZE_BYTES
  local progress_notify_interval_millis = global_config.progress_notify_interval_millis or DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS
  local conf_params = {
    limit_speed = _band_width,
    limit_interval = HTTP_INTERVAL_LIMIT,
    read_buffer_size_bytes = _read_buffer_size_bytes,
    progress_notify_interval = progress_notify_interval_millis
  }
  E.LOG.debug(TAG, "update_download_limit:" .. tostring(_band_width) .. ", read_buffer_size:" .. tostring(_read_buffer_size_bytes) .. ", progress_notify_interval:" .. tostring(progress_notify_interval_millis))
  ERB.update_http_config(conf_params)
end

function M:update_download_config_impl(config)
  E.LOG.d(TAG, {update_config = config})
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
  if "boolean" == type(config.need_stat_progress) then
    self._data.global_config.need_stat_progress = config.need_stat_progress
  end
  if "boolean" == type(config.foreground_notification_enabled) then
    self._data.global_config.foreground_notification_enabled = config.foreground_notification_enabled
  end
  if type(config.max_downloading_count) == "number" then
    self._data.global_config.max_downloading_count = config.max_downloading_count
  end
  if "boolean" == type(config.use_independent_pool) then
    self._data.global_config.use_independent_pool = config.use_independent_pool
  end
  if "boolean" == type(config.use_cache_complete_file_md5) then
    self._data.global_config.use_cache_complete_file_md5 = config.use_cache_complete_file_md5
  end
  if "number" == type(config.log_output_level) then
    self._data.global_config.log_output_level = config.log_output_level
  end
  if "boolean" == type(config.enable_limit_speed) then
    self._data.global_config.enable_limit_speed = config.enable_limit_speed
  end
  if "boolean" == type(config.enable_download_range) then
    self._data.global_config.enable_download_range = config.enable_download_range
  end
  if "number" == type(config.default_progress_style) then
    local ANP = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
    ANP.set_default_progress_style(config.default_progress_style)
  end
  update_default_config(self._data.global_config)
  self._data.single_model:update_download_config(config)
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

function M:remove_download_by_tag_impl(tag_name, cb)
  local task = self:query_runtime_task_with_tag(tag_name)
  if task then
    self:_inner_remove_download(task, task:task_tag_name(), cb)
  end
end

function M:get_download_state_by_tag_impl(tag_name)
  local task = self:query_runtime_task_with_tag(tag_name)
  self:log_debug("get_download_state_by_tag downloading result:" .. type(task))
  if task then
    do return task.get_download_state end
    return task.get_download_state, task, "get_download_state_by_tag downloading result:" .. type(task), type(task), task
  else
    return nil, EC.DOWNLOAD_ERROR_CODES.UNKNOWN_TASK, "unknown task tag:" .. tostring(tag_name)
  end
end

function M:_get_cache_filename_for_md5_list(tag_name)
  local model_tag_name = tostring(self._data.model_name) .. "_" .. tostring(tag_name)
  local model_tag_hash_data = _ejoysdk_crypt.hashkey(model_tag_name)
  local model_tag_hash_name = _ejoysdk_crypt.hexencode(model_tag_hash_data)
  return self._data.cache_md5_file_name_prefix .. "_" .. tostring(model_tag_hash_name)
end

function M:save_file_list_md5(tag_name, task_id_md5_map)
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local data_str = CJSON.encode(task_id_md5_map)
  local cache_file_name = self:_get_cache_filename_for_md5_list(tag_name)
  if data_str and "" ~= data_str then
    E.File.writefile(cache_file_name, data_str)
  else
    self:log_debug("save_file_list_md5 data is nil then remove it:" .. tostring(self._data.cache_md5_file_name_prefix))
    E.File.removefile(cache_file_name)
  end
end

function M:load_file_list_md5(tag_name)
  local cache_file_name = self:_get_cache_filename_for_md5_list(tag_name)
  local data_str = E.File.readfile(cache_file_name)
  if not data_str or "" == data_str then
    self:log_warn("load_file_list_md5 failed, data is empty from " .. tostring(cache_file_name))
    return nil
  end
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  local task_id_md5_map_cache = CJSON.decode(data_str)
  return task_id_md5_map_cache
end

return M
