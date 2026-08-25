local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local DST = require("ejoysdk_lua.res.model.http_download_stat")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local HTTP = require("ejoysdk_lua.libs.http")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local FSM = UTILS.fsm
local M = Class:Inherit("EjoyHttpDownloadTask")
M.TASK_TYPE = RTM.DOWNLOAD_TASK_TYPE.SINGLE
local TAG = "http_down_task"
local is_download_log_enable
M.DOWNLOAD_STATE = {
  IDLE = "idle",
  FAILED = "failed",
  STOPPED = "stopped",
  DOWNLOADING = "downloading",
  COMPLETE = "complete"
}
M.DOWNLOAD_CHECK_STATE = {
  COMPLETE_FILE_VALID = "complete_valid",
  COMPLETE_FILE_INVALID = "complete_invalid",
  DOWNLOADING_FILE_INVALID = "downloading_invalid",
  DOWNLOADING_FILE_INCOMPLETE = "downloading_incomplete",
  DOWNLOADING_FILE_VALID = "downloading_valid",
  NOT_DOWNLOAD = "not_download",
  UNKNOWN = "unknown"
}
M.INNER_LOG_LEVEL = {
  INFO = 0,
  DEBUG = 1,
  WARN = 2,
  ERROR = 3
}
M.STATE_KEY = {
  STATE = "state",
  FILE_PATH = "file_path",
  SIZE = "size",
  RECV_BYTES = "recv_bytes",
  SPEED = "speed",
  ERR_CODE = "err_code",
  ERR_MSG = "err_msg",
  ERR_URL = "err_url",
  STATE_CHANGED = "state_changed",
  PERCENT = "percent",
  TAG = "tag",
  TASK_ID = "task_id"
}
M.PROGRESS_INFO_KEY = {
  FILE_PATH = "file_path",
  SIZE = "size",
  RECV_BYTES = "recv_bytes",
  SPEED = "speed",
  PERCENT = "percent",
  TAG = "tag",
  TASK_ID = "task_id"
}
M.RANGE_INFO_KEY = {
  ETAG = "etag",
  LAST_MODIFIED = "last_modified",
  COMPLETE_SIZE = "complete_size",
  URL = "url",
  TEMP_FILE_PATH = "temp_file_path"
}
M.TASK_INIT_PARAMS = {
  DEST_FILE_PATH = "dest_file_path",
  FILE_RELA_PATH = "file_rela_path",
  FILE_TEMP_PATH = "file_temp_path",
  TEMP_RELA_PATH = "temp_rela_path",
  STORAGE_PATH = "storage_path",
  TASK_ID = "task_id",
  DEST_FILE_INFO = "file_dest_info",
  CHECKED_INIT_STATE = "checked_init_state",
  LOCAL_INFO = "local_info",
  LOCAL_FIN_EXISTS = "fin_exists",
  LOCAL_FIN_SIZE = "fin_size",
  LOCAL_TMP_EXISTS = "tmp_exists",
  LOCAL_TMP_SIZE = "tmp_size",
  LOCAL_MD5 = "md5",
  CHECKED_STATE_INFO = "checked_init_info"
}
M.FILE_DEST_INFO_KEY = {
  URL = "url",
  NAME = "name",
  STORAGE_PATH = "storage_path",
  DEST_RELA_PATH = "dest_file_rela_path",
  DEST_FILE_DIR = "dest_file_dir",
  DEST_FILE_PATH = "dest_file_path"
}
local _STATES = {
  IDLE = "idle",
  STOPPED = "stopped",
  DOWNLOADING = "downloading",
  COMPLETE = "complete"
}
local _EVENTS = {
  INIT = "init",
  INIT_SUCC = "init_succ",
  START_DOWNLOAD = "start_download",
  REMOVE_DOWNLOAD = "remove_download",
  STOP_DOWNLOAD = "stop_download",
  STOP_DOWNLOAD_SUCC = "stop_download_succ",
  RESUME_DOWNLOAD = "resume_download",
  RESET_DOWNLOAD = "reset_download"
}
M._UNITEST_EVENT_EXPORT = _EVENTS
local DOWNLOADING_SUFFIX = "_dl_bak_"
local RETRY_TIME_DELAY = 1
M.DOWNLOADING_FILE_SUFFIX = DOWNLOADING_SUFFIX
M.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS = 1000
M.CHCKED_FILE_STATE_KEY = {REAL_SIZE = "real_size", TOTAL_SIZE = "total_size"}

function M.static_get_download_temp_file_path(model_instance, dest_file_dir, name)
  do return model_instance._get_download_temp_file_path, model_instance, dest_file_dir end
  return model_instance._get_download_temp_file_path, model_instance, dest_file_dir, name
end

function M:model_task_name()
  local task_id
  if self then
    task_id = self._data.task_id
  end
  local model_name = self._data.model_instance:get_model_name()
  return tostring(model_name) .. tostring("_") .. tostring(task_id)
end

function M:get_log_tag()
  local task_id
  if self then
    task_id = self._data.task_id
  end
  local log_prefix = self._data.model_instance:get_module_log_prefix()
  local model_name = self._data.model_instance:get_model_name()
  local tag = tostring(log_prefix) .. "#" .. tostring(model_name)
  tag = tag .. "#" .. task_id
  return tag
end

function M:get_log_level()
  if nil == is_download_log_enable then
    is_download_log_enable = E.get_ej_detail_debuggable()
  end
  if true == is_download_log_enable then
    return M.INNER_LOG_LEVEL.INFO
  end
  local gloabal_config = self._data.model_instance:get_global_config()
  local log_level = gloabal_config.log_output_level or M.INNER_LOG_LEVEL.INFO
  return log_level
end

function M:log_warn(message)
  if not message or "" == message then
    return
  end
  local log_level = self:get_log_level()
  if log_level > M.INNER_LOG_LEVEL.WARN then
    return
  end
  local tag = self:get_log_tag()
  E.LOG.warn(tag, message)
end

function M:log_debug(message)
  if not message or "" == message then
    return
  end
  local log_level = self:get_log_level()
  if log_level > M.INNER_LOG_LEVEL.DEBUG then
    return
  end
  local tag = self:get_log_tag()
  E.LOG.debug(tag, message)
end

function M:_is_log_level_allow(log_level)
  local cur_log_level = self:get_log_level()
  return log_level >= cur_log_level
end

local function char_to_hex(c)
  do return string.format, "%%%02X", string.byte(c) end
  return string.format, "%%%02X", string.byte(c)
end

local function hex_to_char(x)
  do return string.char, tonumber(x, 16) end
  return string.char, tonumber(x, 16)
end

local function url_encode(url)
  url = url:gsub("([^%w%-%.%_%~%!%*%'%(%)%;%/%?%:%@%&%=%$%,%#])", char_to_hex)
  return url
end

local function url_decode(url)
  url = url:gsub("%%(%x%x)", hex_to_char)
  return url
end

local function check_encode_url(url)
  local decode_url = url_decode(url)
  local is_url_encode = decode_url ~= url
  if not is_url_encode then
    url = url_encode(url)
  end
  url = url:gsub("%+", "%%20")
  return url
end

function M._test_check_encode_url(url)
  do return check_encode_url end
  return check_encode_url, url
end

function M:_notify_download_state_changed()
  assert("_notify_download_state_changed not call with ':'")
  if not self._data.initted then
    self:log_debug("skip notify while initting")
    return
  end
  local current_state_obj = self._data.download_state
  local last_state = self._data.last_download_state
  local current_state = current_state_obj.state
  if current_state ~= last_state then
    current_state_obj.state_changed = true
    self._data.last_download_state = current_state
  else
    current_state_obj.state_changed = false
  end
  local notify_state = current_state_obj
  if not self._data.disable_deepcopy_result then
    notify_state = utils.deepcopy(current_state_obj)
  end
  if not self._data.opts or not self._data.opts.disable_stat then
    local download_config = self._data.model_instance.static_get_global_download_config()
    local limit_speed = download_config.limit_speed
    DST.stat_download_state(notify_state, self._data.current_retry_times, limit_speed)
  end
  ET.publish(ET.download.DOWNLOAD_STATE_CHANGED, self._data.model_name, self._data.tag, notify_state)
  if self._data.download_state_listener then
    self._data.download_state_listener(notify_state.state, notify_state)
  end
end

function M:_notify_download_progress_changed()
  if not self._data.initted then
    self:log_debug("skip notify while initting")
    return
  end
  local speed
  if self:is_downloading() then
    speed = self._data.download_state.speed
  else
    speed = 0
  end
  local progress_info = {
    [M.PROGRESS_INFO_KEY.SIZE] = self._data.download_state.size,
    [M.PROGRESS_INFO_KEY.RECV_BYTES] = self._data.download_state.recv_bytes,
    [M.PROGRESS_INFO_KEY.PERCENT] = self._data.download_state.percent,
    [M.PROGRESS_INFO_KEY.FILE_PATH] = self._data.download_state.file_path,
    [M.PROGRESS_INFO_KEY.SPEED] = speed,
    [M.PROGRESS_INFO_KEY.TAG] = self._data.download_state.tag,
    [M.PROGRESS_INFO_KEY.TASK_ID] = self._data.download_state.task_id
  }
  if self._data.download_progress_listener then
    self._data.download_progress_listener(progress_info)
  end
  ET.publish(ET.download.DOWNLOAD_PROGRESS_CHANGED, self._data.model_name, self._data.tag, progress_info)
end

function M:_fsm_equeue_event_at_front(event_name, ...)
  if self._data.debug_enable then
    self:log_debug("_fsm_send_event:" .. tostring(event_name))
    ET.publish(ET.download.DOWNLOAD_EVENT_SUBMIT, self._data.model_name, self._data.tag, event_name)
  end
  self._data.download_fsm:enqueue_event(event_name, true, ...)
end

function M:_fsm_enqueue_event(event_name, ...)
  if self._data.debug_enable then
    self:log_debug("_fsm_send_event:" .. tostring(event_name))
    ET.publish(ET.download.DOWNLOAD_EVENT_SUBMIT, self._data.model_name, self._data.tag, event_name)
  end
  self._data.download_fsm:enqueue_event(event_name, false, ...)
end

function M:_fsm_transition_to(from_state, to_state, ...)
  local fsm = self._data.download_fsm
  from_state = from_state or fsm.current
  self:log_debug("_fsm_transition_to, from:" .. tostring(from_state) .. ", to_state:" .. tostring(to_state))
  fsm:transition(from_state, to_state, ...)
end

function M:_fsm_on_async_event_finished(event_name)
  local fsm = self._data.download_fsm
  fsm:notify_async_finish(event_name)
end

function M:_stop_download_task(cb, from)
  if self:_is_log_level_allow(M.INNER_LOG_LEVEL.DEBUG) then
    E.LOG.debug(TAG, "_stop_download_task begin:")
  end
  
  local function transition_handler()
    local current_state = self._data.download_fsm.current
    if current_state == _STATES.DOWNLOADING then
      self:_fsm_transition_to(from, _STATES.STOPPED)
    end
  end
  
  local is_support_http_stop = E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_STOP)
  if not is_support_http_stop then
    self:log_warn("_stop_download_task is not support")
    transition_handler()
    if cb then
      cb(true)
    end
  end
  local task_id = self:task_id_impl()
  E.HTTP.stop({task_id}, {}, function(succ)
    if self:_is_log_level_allow(M.INNER_LOG_LEVEL.DEBUG) then
      self:log_debug("_stop_download_task result:" .. tostring(succ))
    end
    if succ then
      transition_handler()
    end
    if cb then
      cb(succ)
    end
  end)
end

function M:_do_remove_file(file_path)
  local exists = HRU.is_file_exists(file_path)
  local result, err_code, err_msg
  if not exists then
    result = true
  else
    result, err_msg = HRU.os_remove(file_path)
    if not result then
      err_code = EC.DOWNLOAD_ERROR_CODES.REMOVE_FILE_FAILED
    end
  end
  self:log_debug("_do_remove_file result:" .. tostring(result) .. ", path:" .. tostring(file_path) .. ", code:" .. tostring(err_code) .. ", err_msg:" .. tostring(err_msg))
  return result, err_code, err_msg
end

function M:_remove_downloading_file()
  local downloading_file_path = self._data.temp_file_path
  local succ, code, msg = self:_do_remove_file(downloading_file_path)
  if succ then
    self:_fsm_transition_to(_STATES.STOPPED, _STATES.IDLE)
  end
  return succ, code, msg
end

function M:_remove_local_downloaded_file()
  local downloaded_file = self._data.dest_file_path
  local succ, code, msg = self:_do_remove_file(downloaded_file)
  local global_config = self._data.model_instance:get_global_config()
  local cache_config_enabled = true
  if type(global_config.use_cache_complete_file_md5) == "boolean" then
    cache_config_enabled = global_config.use_cache_complete_file_md5
  end
  if cache_config_enabled then
    self._data.model_instance:_mark_file_incomplete(self._data.task_id, self._data.dest_file_path)
  end
  return succ, code, msg
end

function M:_rename_local_downloading_to_complete_file()
  local result, err_msg = self._data.model_instance:_on_download_complete_rename_temp_file(self._data.temp_file_path, self._data.dest_file_path)
  if not result then
    return false, err_msg
  end
  local global_config = self._data.model_instance:get_global_config()
  local cache_config_enabled = true
  if type(global_config.use_cache_complete_file_md5) == "boolean" then
    cache_config_enabled = global_config.use_cache_complete_file_md5
  end
  if cache_config_enabled and not self._data.invoker_managed_md5_data then
    local md5_str = self._data.file_ext and self._data.file_ext.md5 or nil
    if md5_str and "" ~= md5_str then
      self._data.model_instance:_update_complete_file_md5(self._data.task_id, self._data.dest_file_path, md5_str)
    end
  end
  return true
end

function M:_remove_downloaded_file_state()
  local succ, code, msg = self:_remove_local_downloaded_file()
  if succ then
    self:_fsm_transition_to(_STATES.COMPLETE, _STATES.IDLE)
  end
  return succ, code, msg
end

function M:_check_complete_file_md5()
  local md5_result = M.static_check_complete_file_md5(self._data.model_instance, self._data.task_id, self._data.dest_file_path)
  return md5_result
end

function M.static_check_complete_file_md5(model_instance, task_id, dest_file_path)
  local global_config = model_instance:get_global_config()
  local cache_config_enabled = true
  if type(global_config.use_cache_complete_file_md5) == "boolean" then
    cache_config_enabled = global_config.use_cache_complete_file_md5
  end
  local md5_result
  if cache_config_enabled then
    md5_result = model_instance:_get_complete_file_md5_cache(task_id, dest_file_path)
  end
  if not md5_result or "" == md5_result then
    md5_result = HRU.check_file_md5(dest_file_path)
  end
  if DST.is_log_allow_with_level(DST.INNER_LOG_LEVEL.DEBUG) then
    DST.log_debug(TAG, "_check_complete_file_md5 path:" .. tostring(dest_file_path) .. ", md5:" .. tostring(md5_result))
  end
  return md5_result
end

function M:_update_downloading_range_info(range_info)
  self:log_debug("_update_downloading_range_info begin")
  self._data.model_instance:_update_file_range_info(self._data.task_id, range_info)
end

function M:_reset_downloading_range_info()
  self:log_debug("_reset_downloading_range_info begin")
  self:_update_downloading_range_info(nil)
end

function M:_on_receive_download_response_header(headers)
  self:log_debug("_on_receive_download_response_header, begin _update_downloading_range_info")
  self._data.model_instance:on_receive_download_response_header(self._data.task_id, self._data.url, headers)
end

function M:_do_start_download()
  local url = self._data.url
  local log_level = self:get_log_level()
  local retry_times = self._data.current_retry_times or 0
  if self._data.file_ext and self._data.file_ext.backup_urls and type(self._data.file_ext.backup_urls) == "table" and retry_times > 0 then
    local backup_urls_count = #self._data.file_ext.backup_urls
    if backup_urls_count > 0 then
      local retry_index = retry_times % (backup_urls_count + 1)
      if retry_index > 0 and backup_urls_count >= retry_index then
        url = self._data.file_ext.backup_urls[retry_index]
        if log_level <= M.INNER_LOG_LEVEL.DEBUG then
          self:log_debug("start_download, retry_times:" .. tostring(retry_times) .. " backup_url:" .. tostring(url))
        end
      end
    end
  end
  local task_id = self._data.task_id
  local global_config = self._data.model_instance:get_global_config()
  local file_expect_size = self._data.file_ext and self._data.file_ext.size or nil
  local max_retry_times = self._data.max_retry_times or global_config.max_retry_times
  local connect_timeout = global_config.connect_timeout
  local read_timeout = global_config.read_timeout
  local _use_independent_pool = self._data.use_independent_pool
  if type(_use_independent_pool) ~= "boolean" then
    _use_independent_pool = global_config.use_independent_pool
  end
  if log_level <= M.INNER_LOG_LEVEL.DEBUG then
    self:log_debug("do_start_download max retry times:" .. tostring(max_retry_times) .. ", connect_timeout:" .. tostring(connect_timeout) .. ", read timeout:" .. tostring(read_timeout) .. ", use_independent_pool:" .. tostring(_use_independent_pool))
  end
  local downloading_file_path = self._data.temp_file_path
  if log_level <= M.INNER_LOG_LEVEL.DEBUG then
    self:log_debug("start_download, temp_file_path:" .. downloading_file_path)
  end
  
  local function down_fail_handler(code, msg)
    self:log_warn("download error " .. tostring(self._data.name) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    if code == EC.DOWNLOAD_ERROR_CODES.CANCELLED then
      self:log_debug("down_fail_handler download cancelled received, already processed inner, skip")
      return
    end
    if self._data.model_instance:_is_download_response_fail_need_rm_file(code) then
      self:log_debug("download_fail_handler, md5 check failed:" .. tostring(code) .. ", begin rm file:" .. tostring(downloading_file_path))
      HRU.os_remove(downloading_file_path)
      self._data.download_state.recv_bytes = 0
      self._data.download_state.percent = 0
    end
    self._data.current_retry_times = self._data.current_retry_times + 1
    if self._data.current_retry_times > max_retry_times then
      self:log_warn("retry times reaches max times now send download failed event, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      self._data.download_state.err_code = code
      self._data.download_state.err_msg = msg
      self:_fsm_transition_to(_STATES.DOWNLOADING, _STATES.STOPPED)
    else
      E.Timer.once(RETRY_TIME_DELAY, function()
        if self._data.download_fsm.current ~= _STATES.DOWNLOADING then
          return
        end
        self:log_warn(string.format("down_file fail,retry cnt=%s file=%s", self._data.current_retry_times, tostring(self._data.name)))
        self:_do_start_download()
      end)
    end
  end
  
  local function down_succ_handler()
    self:log_debug("down_succ_handler received, send download_succ event:" .. tostring(self:task_tag_name()))
    self:_fsm_transition_to(_STATES.DOWNLOADING, _STATES.COMPLETE)
  end
  
  local function _down_cb(ret)
    ret.status = ret.status or EC.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_HTTP_RESPONSE_STATUS_INVALID
    local err_msg = ret.message or ret.msg
    if self._data.model_instance:_is_download_response_status_succ(ret.status) then
      local expect_md5_str = self._data.file_ext and self._data.file_ext.md5 or nil
      local is_valid, file_real_size = self._data.model_instance:_on_download_complete_check_file_md5_and_size_valid(downloading_file_path, expect_md5_str, file_expect_size)
      if is_valid then
        local result, msg = self:_rename_local_downloading_to_complete_file()
        if result then
          self:log_debug("succ move from:" .. tostring(downloading_file_path) .. ", to:" .. tostring(self._data.dest_file_path))
          self._data.download_state.size = file_real_size
          down_succ_handler()
        else
          DST.stat_action_fail("download_finish_rename_failed", self._data.dest_file_path, url, msg)
          down_fail_handler(EC.EJOYSDK_ERROR_CODES.RES_DOWNLOAD_RENAME_FAILED, "download finish file rename failed, " .. tostring(msg))
        end
      else
        down_fail_handler(EC.EJOYSDK_ERROR_CODES.RES_DOWNLOAD_MD5_MISMATCH, "download finish file invalid")
      end
    else
      self:log_warn("receive download failed:" .. tostring(ret.status) .. ", msg:" .. tostring(err_msg))
      down_fail_handler(ret.status, err_msg or "download failed")
    end
  end
  
  local last_noti_clock = 0
  
  local function _progress(_, _file, recv, total, _headers)
    if self._data.download_state.state ~= _STATES.DOWNLOADING then
      return
    end
    if self._data.download_state.size <= 0 and type(total) == "number" and total >= 0 and total ~= self._data.download_state.size then
      self._data.download_state.size = total
    end
    self._data.download_state.recv_bytes = recv
    local p = self._data.download_state.size > 0 and math.floor(recv / self._data.download_state.size * 100) or 0
    local current_percent = self._data.download_state.percent
    local progress_changed = p ~= current_percent
    self._data.download_state.percent = p
    self._data.download_state.duration = self._data.download_begin_time > 0 and E.time() - self._data.download_begin_time
    if log_level <= M.INNER_LOG_LEVEL.DEBUG then
      self:log_debug("lua recv progress:" .. tostring(recv) .. ", total:" .. tostring(total) .. ", p:" .. tostring(p) .. ", current_p:" .. tostring(current_percent) .. ", speed:" .. tostring(self._data.download_state.speed) .. ", limit:" .. tostring(self._data.model_instance:get_global_config().max_bandwidth_kbytes_per_sec))
    end
    local currnet_noti_clock = E.system_clock()
    local progress_notify_interval_millis = self._data.progress_notify_interval_millis or global_config.progress_notify_interval_millis
    if progress_notify_interval_millis < currnet_noti_clock - last_noti_clock then
      self:log_debug("lua recv progress:" .. tostring(recv) .. ", total:" .. tostring(total) .. ", p:" .. tostring(p) .. ", current_p:" .. tostring(current_percent) .. ", speed:" .. tostring(self._data.download_state.speed) .. ", limit:" .. tostring(self._data.model_instance:get_global_config().max_bandwidth_kbytes_per_sec))
      local disable_stat = self._data.opts and self._data.opts.disable_stat
      if not disable_stat then
        local biz_name = self:model_task_name()
        local speed_val = HRU.check_download_speed(biz_name, self._data.task_id, recv, total)
        if speed_val >= 0 then
          self._data.download_state.speed = speed_val
        end
      end
      last_noti_clock = currnet_noti_clock
      self:_notify_download_progress_changed()
    end
    if progress_changed then
      self:_notify_download_state_changed()
    end
  end
  
  local function _header_cb(_headers)
    self:_on_receive_download_response_header(_headers)
  end
  
  local _global_config = self._data.model_instance:get_global_config()
  local _enable_limit_speed = self._data.enable_limit_speed
  if nil == _enable_limit_speed then
    _enable_limit_speed = _global_config.enable_limit_speed
  end
  local _download_range_enable = self._data.enable_download_range
  if nil == _download_range_enable then
    _download_range_enable = _global_config.enable_download_range
  end
  if log_level <= M.INNER_LOG_LEVEL.DEBUG then
    self:log_debug("enable_limit_speed:" .. tostring(_enable_limit_speed) .. ", range enable:" .. tostring(_download_range_enable))
  end
  url = check_encode_url(url)
  if log_level <= M.INNER_LOG_LEVEL.DEBUG then
    self:log_debug("do http get with url:" .. tostring(url))
  end
  local request_builder = HTTP.Request.Builder:Instance(url, nil, nil, task_id)
  local if_range_field
  if _download_range_enable then
    if log_level <= M.INNER_LOG_LEVEL.DEBUG then
      self:log_debug("enabled download range")
    end
    local range_info = self._data.model_instance:_get_file_range_info_by_id(task_id)
    if range_info then
      local etag = range_info[M.RANGE_INFO_KEY.ETAG]
      local last_modified = range_info[M.RANGE_INFO_KEY.LAST_MODIFIED]
      if_range_field = etag
      if not if_range_field or "" == if_range_field then
        if_range_field = last_modified
      end
      self:log_debug("start download, param_if_range:" .. tostring(if_range_field))
    else
      self:log_debug("start download, no last range info, not set param_if_range")
    end
    local range_fun_name
    local _os = _ejoysdk.os()
    if "android" == _os then
      range_fun_name = E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE
    elseif "ios" == _os then
      range_fun_name = E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE
    else
      range_fun_name = E.NATIVE_SUPPORT_FUNCTION_NAMES.HTTP_DOWNLOAD_RANGE_V1
    end
    if E.is_support_function(range_fun_name) then
      if self._data.download_state.recv_bytes and self._data.download_state.recv_bytes > 0 then
        local _is_exist, size = HRU.is_file_exists(downloading_file_path)
        if _is_exist and size and size > 0 then
          request_builder:add_header("range", "bytes=" .. tostring(size) .. "-")
        else
          self:log_warn("range download continue recv_bytes > 0 but file not exists")
        end
        self:log_debug(" range download continue, start with size:" .. tostring(self._data.download_state.recv_bytes))
      else
        self:log_debug(" start download new file")
      end
    end
  elseif log_level <= M.INNER_LOG_LEVEL.DEBUG then
    self:log_debug("start download, enable_download_range false, skip set if-range")
  end
  local request = request_builder:build()
  local down_opts = {
    enable_download_range = _download_range_enable,
    connectionTimeout = connect_timeout,
    dataRetrievalTimeout = read_timeout
  }
  local down_params = {
    param_if_range = if_range_field,
    file = downloading_file_path,
    checksum = self._data.file_ext and self._data.file_ext.md5 or nil,
    use_independent_pool = _use_independent_pool,
    thread_count = self._data.thread_count,
    priority = self._data.priority,
    enable_limit_speed = _enable_limit_speed,
    expect_size = self._data.download_state.size
  }
  request:download_file(down_params, down_opts, _down_cb, _progress, _header_cb)
end

function M:_inner_start_download()
  self:_do_start_download()
  self:_fsm_transition_to(nil, _STATES.DOWNLOADING)
end

function M:_check_init_download_state()
  local checked_info = self._data.init_check_params[M.TASK_INIT_PARAMS.CHECKED_STATE_INFO]
  if checked_info then
    local checked_state = self._data.init_check_params[M.TASK_INIT_PARAMS.CHECKED_INIT_STATE]
    return checked_state, checked_info
  else
    do return M._static_check_init_download_state, self._data.url, self._data.task_id, self._data.file_ext, self._data.file_dest_info, self._data.model_instance end
    return M._static_check_init_download_state, self._data.url, self._data.task_id, self._data.file_ext, self._data.file_dest_info, self._data.model_instance, self._data.init_check_params
  end
end

function M._static_check_init_download_state(url, task_id, file_ext, file_dest_info, model_instance, init_check_params)
  local dest_file_path = file_dest_info.dest_file_path
  file_ext = file_ext or {}
  local size = file_ext.size or 0
  local file_has_md5 = file_ext.md5 and file_ext.md5 ~= ""
  local expect_file_md5_value = file_ext.md5
  init_check_params = init_check_params or {}
  local file_local_info = init_check_params[M.TASK_INIT_PARAMS.LOCAL_INFO]
  local finish_file_exists = false
  local tmp_file_exists = false
  local finish_file_size = 0
  local tmp_file_size = 0
  local fin_md5
  if file_local_info then
    finish_file_exists = file_local_info[M.TASK_INIT_PARAMS.LOCAL_FIN_EXISTS]
    tmp_file_exists = file_local_info[M.TASK_INIT_PARAMS.LOCAL_TMP_EXISTS]
    finish_file_size = file_local_info[M.TASK_INIT_PARAMS.LOCAL_FIN_SIZE] or 0
    tmp_file_size = file_local_info[M.TASK_INIT_PARAMS.LOCAL_TMP_SIZE] or 0
    fin_md5 = file_local_info[M.TASK_INIT_PARAMS.LOCAL_MD5]
  end
  local state_info = {
    [M.CHCKED_FILE_STATE_KEY.TOTAL_SIZE] = size
  }
  local fin_exists
  if file_local_info then
    fin_exists = finish_file_exists
  else
    fin_exists = HRU.file_exists(dest_file_path)
  end
  if fin_exists then
    if file_has_md5 then
      local real_file_md5 = fin_md5 or M.static_check_complete_file_md5(model_instance, task_id, dest_file_path)
      if real_file_md5 == expect_file_md5_value then
        if not size or 0 == size then
          if finish_file_size > 0 then
            size = finish_file_size
          else
            size = HRU.get_file_size(dest_file_path)
          end
        end
        state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = size
        state_info[M.CHCKED_FILE_STATE_KEY.TOTAL_SIZE] = size
        return M.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID, state_info
      else
        state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = 0
        return M.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_INVALID, state_info
      end
    else
      local real_size = finish_file_size
      if 0 == real_size then
        real_size = HRU.get_file_size(dest_file_path)
      end
      if real_size == size or 0 == size then
        state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = real_size
        state_info[M.CHCKED_FILE_STATE_KEY.TOTAL_SIZE] = real_size
        return M.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID, state_info
      else
        state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = 0
        return M.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_INVALID, state_info
      end
    end
  else
    local downloading_file_path = init_check_params[M.TASK_INIT_PARAMS.FILE_TEMP_PATH]
    downloading_file_path = downloading_file_path or M.static_get_download_temp_file_path(model_instance, file_dest_info.dest_file_dir, file_dest_info.name)
    local is_downloading, downloading_file_size
    if file_local_info then
      is_downloading = tmp_file_exists
      downloading_file_size = tmp_file_size
    else
      is_downloading, downloading_file_size = HRU.is_file_exists(downloading_file_path)
    end
    state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = downloading_file_size
    if is_downloading then
      local last_range_info = model_instance:_get_file_range_info_by_id(task_id)
      if last_range_info then
        local _last_url = last_range_info[M.RANGE_INFO_KEY.URL]
        if _last_url ~= url then
          E.LOG.warn(TAG, "last downloading file, url changes, last:" .. tostring(_last_url) .. ", current:" .. tostring(url))
          local stat_params = {
            last_url = _last_url,
            url = url,
            dest_file_path = downloading_file_path
          }
          DST.stat_action("resume_download_url_change", nil, false, stat_params)
          state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = 0
          return M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INVALID, state_info
        end
        local total_file_size = size
        if 0 == total_file_size then
          total_file_size = last_range_info[M.RANGE_INFO_KEY.COMPLETE_SIZE] or 0
        end
        total_file_size = tonumber(total_file_size)
        state_info[M.CHCKED_FILE_STATE_KEY.TOTAL_SIZE] = total_file_size
        if total_file_size >= 0 and downloading_file_size >= 0 and total_file_size ~= downloading_file_size then
          return M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE, state_info
        end
        if file_has_md5 then
          local downloading_file_md5 = HRU.check_file_md5(downloading_file_path)
          if downloading_file_md5 == expect_file_md5_value then
            return M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID, state_info
          else
            state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = 0
            return M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INVALID, state_info
          end
        else
          return M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID, state_info
        end
      else
        return M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE, state_info
      end
    else
      state_info[M.CHCKED_FILE_STATE_KEY.REAL_SIZE] = 0
      return M.DOWNLOAD_CHECK_STATE.NOT_DOWNLOAD, state_info
    end
  end
end

function M:_init(_task_id, _url, _file_ext, _opts, params, _model_instance)
  assert(self, "call task New with missing ':'mark")
  local fsm_callbacks = {
    ["on" .. _EVENTS.INIT] = function(_f_self, from)
      if from ~= _STATES.IDLE then
        self:log_debug("init event always processed by undefined state")
        return FSM.SYNC
      end
      local downloading_file_path = self._data.temp_file_path
      local file_state, checked_state_info = self:_check_init_download_state()
      if self:_is_log_level_allow(M.INNER_LOG_LEVEL.DEBUG) then
        self:log_debug("file_state:" .. tostring(file_state))
        E.log(checked_state_info)
        _ejoysdk.log("init param checked info >>")
        E.log(self._data.init_check_params[M.TASK_INIT_PARAMS.CHECKED_STATE_INFO])
      end
      local total_size = checked_state_info.total_size
      self._data.download_state.size = total_size
      if file_state == M.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID then
        self._data.download_state.size = checked_state_info.total_size
        self:_fsm_transition_to(_STATES.IDLE, _STATES.COMPLETE)
      elseif file_state == M.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_INVALID then
        self:_remove_local_downloaded_file()
      elseif file_state == M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INVALID then
        HRU.os_remove(downloading_file_path)
        self:_reset_downloading_range_info()
      elseif file_state == M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INCOMPLETE then
        local downloading_size = checked_state_info.real_size
        self._data.download_state.recv_bytes = downloading_size
        self._data.download_state.percent = 0
        if total_size > 0 then
          self._data.download_state.percent = math.floor(downloading_size / total_size * 100)
        end
        self:_fsm_transition_to(_STATES.IDLE, _STATES.STOPPED)
      elseif file_state == M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID then
        local result, msg = self:_rename_local_downloading_to_complete_file()
        if result then
          self:_fsm_transition_to(_STATES.IDLE, _STATES.COMPLETE)
        else
          self:log_warn("rename failed, " .. tostring(msg))
          self:_fsm_transition_to(_STATES.IDLE, _STATES.STOPPED)
        end
      elseif file_state == M.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INVALID then
        HRU.os_remove(downloading_file_path)
        self._data.download_state.recv_bytes = 0
        self._data.download_state.percent = 0
      end
      self:_fsm_equeue_event_at_front(_EVENTS.INIT_SUCC)
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.INIT_SUCC] = function(_fsm, _from, ...)
      self:log_debug("init succ")
      self._data.initted = true
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.START_DOWNLOAD] = function(_fsm, from, ...)
      self:log_debug("receive start_download event, from:" .. tostring(from))
      if from == _STATES.IDLE then
        self:_inner_start_download()
        return FSM.SYNC
      elseif from == _STATES.STOPPED then
        self:_fsm_equeue_event_at_front(_EVENTS.RESUME_DOWNLOAD, ...)
        return FSM.SYNC
      elseif from == _STATES.DOWNLOADING then
        self:log_debug("start_download already downloading, now callback directly")
        self:_notify_download_progress_changed()
        self:_notify_download_state_changed()
        return FSM.SYNC
      elseif from == _STATES.COMPLETE then
        self:log_debug("start_download already downloaded, now callback downloaded state directly")
        self:_notify_download_progress_changed()
        self:_notify_download_state_changed()
        return FSM.SYNC
      end
    end,
    ["on" .. _EVENTS.RESUME_DOWNLOAD] = function(_fsm, from, ...)
      if from ~= _STATES.STOPPED then
        self:log_debug("resume download in not paused state, return")
        return FSM.SYNC
      end
      self:log_debug("resume download begin")
      self:_inner_start_download()
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.STOP_DOWNLOAD] = function(_fsm, from, ...)
      local p_cb = (...)
      
      local function p_cb_wrapper(p_succ, ...)
        if p_succ then
          self:log_debug("stop_download succ")
        else
          local p_code, p_msg = ...
          self:log_warn("stop_download failed, code:" .. tostring(p_code) .. ", msg:" .. tostring(p_msg))
        end
        if p_cb then
          p_cb(p_succ, ...)
        end
      end
      
      if from == _STATES.IDLE then
        self:log_debug("pause in idle state, just return true")
        p_cb_wrapper(true)
        return FSM.SYNC
      elseif from == _STATES.STOPPED or from == _STATES.COMPLETE then
        self:log_debug("stop in state: " .. tostring(from) .. ", just return true")
        p_cb_wrapper(true)
        return FSM.SYNC
      elseif from == _STATES.DOWNLOADING then
        self:_stop_download_task(function(succ, ...)
          if succ then
            self:_fsm_equeue_event_at_front(_EVENTS.STOP_DOWNLOAD, p_cb)
          else
            local cd_code, cd_msg = ...
            p_cb_wrapper(false, cd_code, cd_msg)
          end
          self:_fsm_on_async_event_finished(_EVENTS.STOP_DOWNLOAD)
        end)
        return FSM.ASYNC
      end
    end,
    ["on" .. _EVENTS.RESET_DOWNLOAD] = function(_fsm, from, ...)
      local reset_download_cb = (...)
      
      local function download_cb_wrapper(succ, ...)
        if reset_download_cb then
          reset_download_cb(succ, ...)
        end
      end
      
      if from == _STATES.IDLE then
        self:_fsm_equeue_event_at_front(_EVENTS.START_DOWNLOAD, ...)
        return FSM.SYNC
      elseif from == _STATES.STOPPED then
        local r_succ = self:_remove_downloading_file()
        if r_succ then
          self:_fsm_equeue_event_at_front(_EVENTS.RESET_DOWNLOAD, ...)
        else
          download_cb_wrapper(false, EC.DOWNLOAD_ERROR_CODES.REMOVE_FILE_FAILED, "remove downloading file failed")
        end
        return FSM.SYNC
      elseif from == _STATES.DOWNLOADING then
        self:_stop_download_task(function(rd_succ, ...)
          if rd_succ then
            self:_fsm_equeue_event_at_front(_EVENTS.RESET_DOWNLOAD, reset_download_cb)
          else
            download_cb_wrapper(false, EC.DOWNLOAD_ERROR_CODES.STOP_DOWNLOAD_FAILED, "stop download task failed")
          end
          self:_fsm_on_async_event_finished(_EVENTS.RESET_DOWNLOAD)
        end)
        return FSM.ASYNC
      elseif from == _STATES.COMPLETE then
        local succ = self:_remove_downloaded_file_state()
        if succ then
          self:_fsm_equeue_event_at_front(_EVENTS.RESET_DOWNLOAD, ...)
        else
          download_cb_wrapper(false, EC.DOWNLOAD_ERROR_CODES.REMOVE_FILE_FAILED, "remove downloaded file failed")
        end
        return FSM.SYNC
      end
    end,
    ["on" .. _EVENTS.REMOVE_DOWNLOAD] = function(_fsm, from, ...)
      local rd_cb = (...)
      
      local function rd_cb_wrapper(rd_succ, ...)
        if rd_cb then
          rd_cb(rd_succ, ...)
        end
      end
      
      if from == _STATES.IDLE then
        self:log_debug("remove_download succ, begin callback")
        rd_cb_wrapper(true)
        return FSM.SYNC
      elseif from == _STATES.STOPPED then
        local succ, err_code, err_msg = self:_remove_downloading_file()
        if succ then
          self:_fsm_equeue_event_at_front(_EVENTS.REMOVE_DOWNLOAD, ...)
        else
          rd_cb_wrapper(false, err_code, err_msg)
        end
        return FSM.SYNC
      elseif from == _STATES.DOWNLOADING then
        self:_stop_download_task(function(rd_succ, ...)
          if rd_succ then
            self:_fsm_equeue_event_at_front(_EVENTS.REMOVE_DOWNLOAD, rd_cb)
          else
            local c_code, c_message = ...
            self:log_warn("event remove_download, cancel download task faild, code:" .. tostring(c_code) .. ", message:" .. tostring(c_message))
            rd_cb_wrapper(false, c_code, c_message)
          end
          self:_fsm_on_async_event_finished(_EVENTS.REMOVE_DOWNLOAD)
        end)
        return FSM.ASYNC
      elseif from == _STATES.COMPLETE then
        local r_result, r_code, r_msg = self:_remove_downloaded_file_state()
        if r_result then
          self:_fsm_equeue_event_at_front(_EVENTS.REMOVE_DOWNLOAD, ...)
        else
          rd_cb_wrapper(false, r_code, r_msg)
        end
        return FSM.SYNC
      end
    end,
    ["onenter" .. _STATES.IDLE] = function(_fsm, from, ...)
      self:log_debug("onenter idle, from:" .. tostring(from) .. ", reset current download state")
      local current_download_state = self._data.download_state
      current_download_state.state = M.DOWNLOAD_STATE.IDLE
      current_download_state.recv_bytes = 0
      current_download_state.err_code = 0
      current_download_state.err_msg = nil
      current_download_state.percent = -1
      current_download_state.speed = 0
      local biz_name = self:model_task_name()
      HRU.reset_download_speed(biz_name)
      self._data.current_retry_times = 0
      self:_notify_download_progress_changed()
      self:_notify_download_state_changed()
    end,
    ["onenter" .. _STATES.STOPPED] = function(_fsm, from, ...)
      self:log_debug("onenter stopped, from:" .. tostring(from))
      local current_download_state = self._data.download_state
      if 0 == current_download_state.err_code then
        current_download_state.err_code = EC.DOWNLOAD_ERROR_CODES.CANCELLED
        current_download_state.err_msg = "download cancelled"
        current_download_state.state = M.DOWNLOAD_STATE.STOPPED
      else
        current_download_state.state = M.DOWNLOAD_STATE.FAILED
      end
      current_download_state.speed = 0
      local biz_name = self:model_task_name()
      HRU.reset_download_speed(biz_name)
      self._data.current_retry_times = 0
      self:_notify_download_progress_changed()
      self:_notify_download_state_changed()
    end,
    ["onenter" .. _STATES.COMPLETE] = function(_f_self, from, ...)
      self:log_debug("onenter complete, from:" .. tostring(from))
      local current_download_state = self._data.download_state
      current_download_state.state = M.DOWNLOAD_STATE.COMPLETE
      current_download_state.err_code = 0
      current_download_state.err_msg = nil
      current_download_state.percent = 100
      current_download_state.recv_bytes = current_download_state.size
      current_download_state.speed = 0
      if self._data.download_begin_time > 0 then
        current_download_state.duration = E.time() - self._data.download_begin_time
      end
      if from == M.DOWNLOAD_STATE.DOWNLOADING then
        self:_reset_downloading_range_info()
      end
      self._data.current_retry_times = 0
      self:_notify_download_state_changed()
    end,
    ["onenter" .. _STATES.DOWNLOADING] = function(_f_self, _from, ...)
      self:log_debug("onenter downloading, from:" .. tostring(_from))
      local current_download_state = self._data.download_state
      current_download_state.state = M.DOWNLOAD_STATE.DOWNLOADING
      current_download_state.err_code = 0
      current_download_state.err_msg = nil
      if 0 == current_download_state.recv_bytes then
        current_download_state.recv_bytes = 0.1
      end
      self._data.download_begin_time = E.time()
      self:_notify_download_state_changed()
    end,
    ["onleave" .. _STATES.DOWNLOADING] = function(_f_self, _to, ...)
      self:log_debug("onleave downloading, to:" .. tostring(_to))
      E.HTTP.unregister_progress_cb(self._data.task_id)
    end
  }
  local _download_fsm = FSM.create({
    initial = _STATES.IDLE,
    events = {
      {
        name = _EVENTS.INIT,
        from = _STATES.IDLE,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.INIT,
        from = _STATES.IDLE,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.INIT,
        from = _STATES.IDLE,
        to = _STATES.COMPLETE
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = _STATES.IDLE
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = _STATES.STOPPED
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = _STATES.COMPLETE
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = _STATES.IDLE,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = _STATES.STOPPED,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = _STATES.COMPLETE,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.RESUME_DOWNLOAD,
        from = _STATES.STOPPED,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.STOP_DOWNLOAD,
        from = _STATES.IDLE,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_DOWNLOAD,
        from = _STATES.STOPPED,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_DOWNLOAD,
        from = _STATES.DOWNLOADING,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_DOWNLOAD,
        from = _STATES.COMPLETE,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.RESET_DOWNLOAD,
        from = _STATES.STOPPED,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.RESET_DOWNLOAD,
        from = _STATES.DOWNLOADING,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.RESET_DOWNLOAD,
        from = _STATES.COMPLETE,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.RESET_DOWNLOAD,
        from = _STATES.IDLE,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.REMOVE_DOWNLOAD,
        from = _STATES.IDLE,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.REMOVE_DOWNLOAD,
        from = _STATES.STOPPED,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.REMOVE_DOWNLOAD,
        from = _STATES.DOWNLOADING,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.REMOVE_DOWNLOAD,
        from = _STATES.COMPLETE,
        to = _STATES.IDLE
      }
    },
    callbacks = fsm_callbacks
  })
  params = params or {}
  local _init_check_params = params.init_check_params or {}
  local _file_dest_info = params.file_dest_info
  self._data = {
    initted = false,
    model_name = _model_instance:get_model_name(),
    task_id = _task_id,
    tag = _file_ext and _file_ext.tag or _task_id,
    max_retry_times = _opts and _opts.max_retry_times or nil,
    progress_notify_interval_millis = _opts and _opts.progress_notify_interval_millis or nil,
    use_independent_pool = nil,
    url = _url,
    name = _file_dest_info.name,
    dest_file_dir = _file_dest_info.dest_file_dir,
    dest_file_path = _file_dest_info.dest_file_path,
    temp_file_path = nil,
    current_retry_times = 0,
    download_begin_time = 0,
    file_ext = _file_ext,
    opts = _opts or {},
    enable_download_range = _opts and _opts.enable_download_range,
    enable_limit_speed = _opts and _opts.enable_limit_speed,
    priority = _opts and _opts.priority or nil,
    disable_deepcopy_result = _opts and _opts.disable_deepcopy_result or false,
    download_state_listener = params.download_state_listener,
    download_progress_listener = params.download_progress_listener,
    download_state = {
      state = _STATES.IDLE,
      tag = _file_ext and _file_ext.tag or _task_id,
      url = _url,
      file_path = _file_dest_info.dest_file_path,
      size = _file_ext and _file_ext.size or 0,
      recv_bytes = 0,
      err_code = 0,
      err_msg = 0,
      percent = -1,
      duration = 0,
      task_id = _task_id,
      speed = 0
    },
    download_fsm = _download_fsm,
    model_instance = _model_instance,
    debug_enable = _model_instance:get_global_config().debug_enable,
    init_check_params = _init_check_params,
    file_dest_info = _file_dest_info,
    invoker_managed_md5_data = false,
    thread_count = _opts and _opts.thread_count
  }
  if _opts and type(_opts.use_independent_pool) == "boolean" then
    self._data.use_independent_pool = _opts.use_independent_pool
  end
  local temp_file_path
  if _init_check_params[M.TASK_INIT_PARAMS.FILE_TEMP_PATH] then
    temp_file_path = _init_check_params[M.TASK_INIT_PARAMS.FILE_TEMP_PATH]
  else
    temp_file_path = M.static_get_download_temp_file_path(_model_instance, _file_dest_info.dest_file_dir, _file_dest_info.name)
  end
  self._data.temp_file_path = temp_file_path
  self._data.download_state.temp_file_path = temp_file_path
  local outside_local_info = _init_check_params[M.TASK_INIT_PARAMS.LOCAL_INFO]
  self._data.invoker_managed_md5_data = outside_local_info and nil ~= outside_local_info[M.TASK_INIT_PARAMS.LOCAL_MD5]
  self:log_debug("_init begin, task_id:" .. tostring(_task_id) .. ", url:" .. tostring(_url) .. ", file_name:" .. tostring(self._data.name) .. ", dest_path:" .. tostring(self._data.dest_file_dir) .. ", dest_file_path:" .. tostring(self._data.dest_file_path) .. ", outside managed md5:" .. tostring(self._data.invoker_managed_md5_data))
  self:_fsm_equeue_event_at_front(_EVENTS.INIT)
end

function M:update_download_properties_impl(properties)
  if type(properties.max_retry_times) == "number" then
    E.LOG.debug(TAG, "update_download_properties max_retry_times:" .. tostring(properties.max_retry_times))
    self._data.max_retry_times = properties.max_retry_times
  end
end

function M:get_download_properties_impl()
  return {
    max_retry_times = self._data.max_retry_times
  }
end

function M:start_download_impl()
  assert(self, "call start_download missing ':' mark!")
  self:log_debug("start_download invoke received begin:" .. tostring(self._data.download_fsm.current))
  self:_fsm_enqueue_event(_EVENTS.START_DOWNLOAD)
end

function M:reset_download_impl()
  assert(self, "call reset_download missing ':' mark!")
  self:log_debug("reset_download invoke received begin:" .. tostring(self._data.download_fsm.current))
  self:_fsm_enqueue_event(_EVENTS.RESET_DOWNLOAD)
end

function M:stop_download_impl(cb)
  assert(self, "call stop_download missing ':' mark!")
  self:log_debug("stop_download invoke received begin:" .. tostring(self._data.download_fsm.current))
  self:_fsm_enqueue_event(_EVENTS.STOP_DOWNLOAD, function(succ, ...)
    if succ then
      self:log_debug("stop_download succ")
    else
      local code, msg = ...
      self:log_debug("stop_download failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M:remove_download_impl(cb)
  assert(self, "call remove_download missing ':' mark!")
  self:log_debug("remove_download invoke begin")
  self:_fsm_enqueue_event(_EVENTS.REMOVE_DOWNLOAD, function(succ, ...)
    if succ then
      self:log_debug("remove_download succ")
    else
      local code, msg = ...
      self:log_debug("remove_download failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M:get_download_state_impl(no_copy)
  if not no_copy then
    local state_obj = UTILS.deepcopy(self._data.download_state)
    state_obj[M.STATE_KEY.STATE_CHANGED] = nil
    return state_obj
  else
    return self._data.download_state
  end
end

function M:task_id_impl()
  if not self then
    return nil
  end
  return self._data.task_id
end

function M:task_tag_name_impl()
  if not self then
    return nil
  end
  return self._data.tag
end

function M:task_info_impl()
  if not self then
    return nil
  end
  return {
    task_id = self._data.task_id,
    task_type = M.TASK_TYPE,
    tag = self._data.tag,
    url = self._data.url,
    dest_file_path = self._data.dest_file_path,
    temp_file_path = self._data.temp_file_path,
    download_state = self:get_download_state(),
    model_name = self._data.model_name
  }
end

function M:is_downloading_impl()
  return self._data.download_state.state == _STATES.DOWNLOADING
end

return M
