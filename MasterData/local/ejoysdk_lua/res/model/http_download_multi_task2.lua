local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ERU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local DST = require("ejoysdk_lua.res.model.http_download_stat")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local DTM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local MRB = require("ejoysdk_lua.res.model.download_multi_source_base")
local RB = require("ejoysdk_lua.res.model.download_multi_source_batch")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local FSM = UTILS.fsm
local M = Class:Inherit("EjoyHttpDownloadMultiTask2")
M.TASK_TYPE = RTM.DOWNLOAD_TASK_TYPE.MULTI
local TAG = "http_down_multi_task"
M.DOWNLOAD_STATE = RTM.PUBLIC_DOWNLOAD_STATE
M.PROGRESS_INFO_KEY = RTM.PROGRESS_INFO_KEY
M.STATE_KEY = {
  STATE = "state",
  ERR_CODE = "err_code",
  ERR_MSG = "err_msg",
  ERR_URL = "err_url",
  STATE_CHANGED = "state_changed",
  TAG = "tag",
  TOTAL_SIZE = M.PROGRESS_INFO_KEY.TOTAL_SIZE,
  DOWNLOADING_SIZE = M.PROGRESS_INFO_KEY.DOWNLOADING_SIZE,
  TOTAL_COUNT = M.PROGRESS_INFO_KEY.TOTAL_COUNT,
  FINISH_COUNT = M.PROGRESS_INFO_KEY.FINISH_COUNT,
  PERCENT = M.PROGRESS_INFO_KEY.PERCENT,
  LAST_FINISH_ITEM = M.PROGRESS_INFO_KEY.LAST_FINISH_ITEM
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
local FILE_ITEM_EXT_KEY = RTM.FILE_ITEM_EXT_KEY
M._UNITEST_EVENT_EXPORT = _EVENTS
M.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS = 1000
M.NORMAL_STARTTIME_SUBMIT_DOWNLOADING_TASK_MAX_COUNT = 20
M.NORMAL_STARTTIME_SUBMIT_MAX_COST_TIME_MS = 20
local DEFAULT_THREAD_COUNT = MRB.DEFAULT_THREAD_COUNT

function M:model_task_name()
  local tag
  if self then
    tag = self._data.tag
  end
  local model_name = self._data.model_instance:get_model_name()
  local name
  if tag then
    name = tostring(model_name) .. tostring("_") .. tostring(tag)
  else
    name = model_name
  end
  return name
end

function M:get_log_tag()
  if self._data.log_tag then
    return self._data.log_tag
  end
  local ext_tag
  if self then
    ext_tag = self._data.tag
  end
  local log_prefix = self._data.model_instance:get_module_log_prefix()
  local model_name = self._data.model_instance:get_model_name()
  local tag = tostring(log_prefix) .. "#" .. tostring(model_name)
  if ext_tag and "" ~= ext_tag then
    tag = tag .. "#" .. tostring(ext_tag)
  end
  self._data.log_tag = tag
  return tag
end

function M:log_warn(message)
  if not message or "" == message then
    return
  end
  if self._data.log_level > DST.INNER_LOG_LEVEL.WARN then
    return
  end
  local tag = self:get_log_tag()
  E.LOG.warn(tag, message)
end

function M:log_debug(message)
  if not message or "" == message then
    return
  end
  if self._data.log_level > DST.INNER_LOG_LEVEL.DEBUG then
    return
  end
  local tag = self:get_log_tag()
  _ejoysdk.log(tag .. "#" .. message)
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
  self:_stat_download_state_changed()
  ET.publish(ET.download.DOWNLOAD_MULTI_TASK_STATE_CHANGED, self._data.model_name, self._data.tag, current_state_obj)
  if self._data.download_state_listener then
    self._data.download_state_listener(current_state_obj.state, current_state_obj)
  end
end

function M:_is_notification_progress_enabled()
  local _foreground_notification_enabled
  if type(self._data.foreground_notification_enabled) == "boolean" then
    _foreground_notification_enabled = self._data.foreground_notification_enabled
  else
    local global_config = self._data.model_instance:get_global_config()
    _foreground_notification_enabled = global_config.foreground_notification_enabled
  end
  self:log_debug("_foreground_notification_enabled:" .. tostring(_foreground_notification_enabled) .. ", state:" .. tostring(self._data.download_state.state) .. ", percent:" .. tostring(self._data.download_state[M.STATE_KEY.PERCENT]))
  return _foreground_notification_enabled
end

function M:_need_present_notification_progress()
  local is_notification_enabled = self:_is_notification_progress_enabled()
  if type(is_notification_enabled) == "boolean" then
    self:log_debug("_need_present_notification_progress1:" .. tostring(is_notification_enabled))
    return is_notification_enabled
  end
  local need_present_notification_progress = self._data.download_multi_source:need_present_notification_progress()
  return need_present_notification_progress
end

function M:_stat_download_progress()
  if self._data.download_state.speed > 0 then
    self._data.last_stat_cal_avg_speed_cnt = self._data.last_stat_cal_avg_speed_cnt + 1
    if 0 == self._data.last_stat_avg_speed then
      self._data.last_stat_avg_speed = self._data.download_state.speed
    else
      self._data.last_stat_avg_speed = math.floor(self._data.last_stat_avg_speed + (self._data.download_state.speed - self._data.last_stat_avg_speed) / self._data.last_stat_cal_avg_speed_cnt)
    end
  end
  local cur_percent = self._data.download_state.percent
  local cur_stat_percent = math.floor(cur_percent / 5) * 5
  if cur_stat_percent == self._data.last_stat_percent then
    return
  end
  self._data.last_stat_percent = cur_stat_percent
  self:_stat_download_state_changed()
end

function M:_stat_download_state_changed()
  if self._data.disable_stat then
    self:log_debug("skip stat for disable_stat is true")
    return
  end
  local present_downloading_size = self._data.notification_present_ext.base_finish_downloading_size or 0
  present_downloading_size = present_downloading_size + (self._data.download_state[M.STATE_KEY.DOWNLOADING_SIZE] or 0)
  local present_total_size = self._data.notification_present_ext.base_total_size or self._data.download_state[M.STATE_KEY.TOTAL_SIZE] or 0
  local present_finish_count = self._data.notification_present_ext.base_finish_count or 0
  present_finish_count = present_finish_count + (self._data.download_state[M.STATE_KEY.FINISH_COUNT] or 0)
  local present_total_count = self._data.notification_present_ext.base_total_count or self._data.download_state[M.STATE_KEY.TOTAL_COUNT] or 0
  local _percent = self._data.last_stat_percent
  if present_total_size > 0 then
    _percent = math.floor(present_downloading_size / present_total_size * 100)
    _percent = math.floor(_percent / 5) * 5
  end
  local ext = self._data.opts.ext or {}
  ext._present_progress_info = {
    downloading_size = present_downloading_size,
    finish_count = present_finish_count,
    total_size = present_total_size,
    total_count = present_total_count,
    speed = self._data.last_stat_avg_speed,
    progress = _percent,
    state = self._data.download_state.state,
    duration = self._data.download_state.duration
  }
  DST.stat_multi_download_state(self._data.download_state, self._data.model_name, ext)
end

function M:_notify_download_progress_changed(force_notify, from, task_id, event_time_mills)
  if not self._data.initted or not self._data.download_progress_listener then
    self:log_debug("skip notify while initting")
    return
  end
  self:_update_duration(event_time_mills)
  local should_notify_progress = force_notify
  if not should_notify_progress then
    local current_noti_clock = E.system_clock()
    local global_config = self._data.model_instance:get_global_config()
    local progress_notify_interval_millis = self._data.progress_notify_interval_millis or global_config.progress_notify_interval_millis
    local last_noti_clock = self._data.last_noti_clock or 0
    if progress_notify_interval_millis < current_noti_clock - last_noti_clock then
      self._data.last_noti_clock = current_noti_clock
      should_notify_progress = true
    end
  end
  if not should_notify_progress then
    return
  end
  if self:is_downloading_impl() then
    if task_id then
      local bandwidth_kbps = ERB.get_download_bandwidth_kbps()
      local biz_name = self:model_task_name()
      local speed = ERU.check_download_speed(biz_name, task_id, self._data.download_state.downloading_size, self._data.download_state.total_size, event_time_mills, bandwidth_kbps)
      if speed <= 0 and self._data.download_state.speed <= 0 then
        local max_speed_kbps = bandwidth_kbps <= 0 and 1024 or bandwidth_kbps
        speed = math.random(max_speed_kbps)
        self:log_debug("init speed:" .. tostring(speed))
      end
      if speed > 0 then
        self._data.download_state.speed = speed
      end
    end
  else
    self._data.download_state.speed = 0
  end
  local progress_info = {
    [M.PROGRESS_INFO_KEY.TOTAL_SIZE] = self._data.download_state.total_size,
    [M.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = self._data.download_state.downloading_size,
    [M.PROGRESS_INFO_KEY.PERCENT] = self._data.download_state.percent,
    [M.PROGRESS_INFO_KEY.TOTAL_COUNT] = self._data.total_task_count,
    [M.PROGRESS_INFO_KEY.FINISH_COUNT] = self._data.download_state.finish_count,
    [M.PROGRESS_INFO_KEY.LAST_FINISH_ITEM] = self._data.download_state.last_finish_item,
    [M.PROGRESS_INFO_KEY.SPEED] = self._data.download_state.speed,
    [M.PROGRESS_INFO_KEY.TAG] = self._data.download_state.tag
  }
  self:log_debug("_notify_download_progress_changed model_name is " .. tostring(self._data.model_name) .. "download percent is " .. tostring(self._data.download_state.percent) .. ", downloading_size:" .. tostring(self._data.download_state.downloading_size) .. ", total_size:" .. tostring(self._data.download_state.total_size) .. ", speed:" .. tostring(self._data.download_state.speed) .. ", finish_count:" .. tostring(self._data.download_state.finish_count) .. ", total_count:" .. tostring(self._data.total_task_count))
  self:_stat_download_progress()
  if self._data.download_progress_listener then
    self._data.download_progress_listener(progress_info)
  end
  ET.publish(ET.download.DOWNLOAD_MULTI_TASK_DOWNLOAD_PROGRESS_CHANGED, self._data.model_name, self._data.tag, progress_info)
  if self:_need_present_notification_progress() and (self._data.download_multi_source:need_lua_present_notification_progress() or from == RTM.DOWNLOAD_STATE.DOWNLOADING and self._data.download_state.state == RTM.DOWNLOAD_STATE.COMPLETE) and self._data.download_state.state ~= M.DOWNLOAD_STATE.UNKNOWN and self._data.download_state.state ~= M.DOWNLOAD_STATE.IDLE then
    _ejoysdk.log("present download progress state in:" .. tostring(self._data.download_state.state))
    local present_downloading_size = self._data.notification_present_ext.base_finish_downloading_size or 0
    present_downloading_size = present_downloading_size + (self._data.download_state[M.STATE_KEY.DOWNLOADING_SIZE] or 0)
    local present_total_size = self._data.notification_present_ext.base_total_size or self._data.download_state[M.STATE_KEY.TOTAL_SIZE] or 0
    local _percent = self._data.download_state[M.STATE_KEY.PERCENT] or 0
    if present_total_size > 0 then
      _percent = math.floor(present_downloading_size / present_total_size * 100)
    end
    local present_progress_info = {
      downloading_size = present_downloading_size,
      total_size = present_total_size,
      speed = self._data.download_state.speed or 0,
      progress = _percent,
      state = self._data.download_state.state
    }
    local ANP = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
    ANP.present_download_progress(present_progress_info)
    if self._data.download_state.state == RTM.DOWNLOAD_STATE.COMPLETE then
      _ejoysdk.log("its download complete, now cancel download notification")
      ANP.cancel_download_notification()
    end
  end
end

function M:_set_single_download_log_level(log_level)
  if self._data.enable_single_download_log_config or self._data.current_log_level == log_level then
    self:log_debug("_set_single_download_log_level skip, enable_log:" .. tostring(self._data.enable_single_download_log_config) .. ", cur level:" .. tostring(self._data.current_log_level) .. ", log_level:" .. tostring(log_level))
    return
  end
  self:log_debug("_set_single_download_log_level:" .. tostring(log_level))
  self._data.current_log_level = log_level
  self._data.single_model:update_download_config({log_output_level = log_level})
  DST.set_log_level(log_level)
end

function M:_set_log_level(log_level)
  self._data.log_level = log_level
  DST.set_log_level(log_level)
end

function M:_single_model()
  return self._data.single_model
end

function M:_multi_model()
  return self._data.model_instance
end

function M:_fsm_equeue_event_at_front(event_name, ...)
  if self._data.debug_enable then
    self:log_debug("_fsm_send_event at_front:" .. tostring(event_name))
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

function M:_fsm_current_event()
  local current_event = self._data.download_fsm.current_event
  return current_event
end

function M:_fsm_current_state()
  local current_state = self._data.download_fsm.current
  self:log_debug("current state:" .. tostring(current_state))
  return current_state
end

function M:_do_stop_download_task(cb, _from)
  self:log_debug("_do_stop_download_task begin, from:" .. tostring(_from))
  self._data.download_multi_source:on_stop_all_download(cb)
end

function M:_inner_remove_download(cb)
  self:log_debug("_inner_remove_download begin")
  
  local function rm_fun()
    local to_rm_file_list = {}
    for item_idx = 1, self._data.total_list_count do
      local file_item = self._data.file_list[item_idx]
      local task_id = file_item.task_id
      if self._data.finish_map[task_id] then
        local item_complete_path = file_item[FILE_ITEM_EXT_KEY.EXT][FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
        if item_complete_path then
          table.insert(to_rm_file_list, item_complete_path)
        else
          self:log_warn("_inner_remove_download could not find complete path for item:" .. tostring(file_item.name))
        end
      else
        local item_tmp_path = file_item[FILE_ITEM_EXT_KEY.EXT][FILE_ITEM_EXT_KEY.EX_TMP_PATH]
        if item_tmp_path then
          table.insert(to_rm_file_list, item_tmp_path)
        else
          self:log_warn("_inner_remove_download could not find temp path for item:" .. tostring(file_item.name))
        end
      end
    end
    local before = E.system_clock()
    
    local function batch_rm_cb(succ, code, msg)
      self._data.download_multi_source:on_download_all_removed()
      local cost = E.system_clock() - before
      self:log_debug("_inner_remove_download, cnt:" .. tostring(self._data.total_list_count) .. ", cost:" .. tostring(cost))
      if not self._data.disable_stat then
        DST.stat_action("ejoy_multi_http_download_rm", tostring(self._data.total_list_count), tostring(cost))
      end
      if cb then
        cb(succ, code, msg)
      end
    end
    
    local _opts = {is_fullpath = true}
    self:log_debug("_inner_remove_download batch_remove size:" .. tostring(#to_rm_file_list))
    E.File.batch_remove(to_rm_file_list, function(succ, ...)
      local code, msg
      if not succ then
        code, msg = ...
        self:log_warn("_inner_remove_download failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      end
      batch_rm_cb(succ, code, msg)
    end, _opts)
  end
  
  self:_check_all_file_state_if_need(function()
    self:log_debug("_inner_remove_download _check_all_file_state_if_need complete")
    rm_fun()
  end)
end

local function create_single_file_ext_from_item_info(file_item_info)
  return {
    name = file_item_info.name,
    dest_path = file_item_info.dest_path,
    md5 = file_item_info.md5,
    tag = file_item_info.tag,
    size = file_item_info.size
  }
end

function M:_start_download_for_resume(cb)
  self:_check_all_file_state_if_need(function()
    local unfinished_file_list = {}
    for _, item in ipairs(self._data.file_list) do
      local _task_id = item.task_id
      if not _task_id then
        local single_file_ext = create_single_file_ext_from_item_info(item)
        _task_id = DTM.static_get_task_id(item.path, single_file_ext, self._data.opts)
      end
      if not self._data.finish_map[_task_id] then
        table.insert(unfinished_file_list, item)
      end
    end
    self._data.unfinished_file_list = unfinished_file_list
    self._data.unfinished_file_list_count = #unfinished_file_list
    self:_start_with_multi_request_adapter(unfinished_file_list)
    if cb then
      cb(true)
    end
  end)
end

function M:_start_download_for_reset(cb)
  self:_check_all_file_state_if_need(function()
    local unfinished_file_list = {}
    local need_native_download_task_id_map = {}
    local _task_count = 0
    for _, item in ipairs(self._data.file_list) do
      local _task_id = item.task_id
      if not _task_id then
        local single_file_ext = create_single_file_ext_from_item_info(item)
        _task_id = DTM.static_get_task_id(item.path, single_file_ext, self._data.opts)
      end
      if not need_native_download_task_id_map[_task_id] then
        need_native_download_task_id_map[_task_id] = true
        _task_count = _task_count + 1
        table.insert(unfinished_file_list, item)
      end
    end
    self._data.unfinished_file_list = unfinished_file_list
    self._data.unfinished_file_list_count = #unfinished_file_list
    self._data.total_task_count = _task_count
    self:_start_with_multi_request_adapter(unfinished_file_list, need_native_download_task_id_map)
    if cb then
      cb(true)
    end
  end)
end

function M:_get_url_for_path(item_path)
  local final_path = E.Path.trim_begin_separator(item_path)
  local url = self._data.base_url .. "/" .. final_path
  return url
end

function M:_check_all_file_state_if_need(cb, _force)
  if self._data.has_checked_all_file_state and not _force then
    cb(true)
    return
  end
  self._data.finish_map = {}
  self._data.download_state.finish_count = 0
  self._data.finish_downloading_size = 0
  self._data.total_task_count = 0
  self._data.unfinished_file_list = {}
  self._data.unfinished_file_list_count = 0
  local unfinished_file_list = {}
  local unfinished_task_count = 0
  local need_native_download_task_id_map = {}
  local b1 = E.system_clock()
  local tag_name = self._data._file_ext and self._data._file_ext.tag or "default"
  local history_task_id_md5_map = self._data.model_instance:load_file_list_md5(tag_name)
  history_task_id_md5_map = history_task_id_md5_map or {}
  local opt_all_files_is_incomplete = self._data.opts.all_files_in_list_incomplete or false
  self:log_debug("opt_all_files_is_incomplete:" .. tostring(opt_all_files_is_incomplete))
  local complete_rela_path_list = {}
  local incomplete_rela_path_list = {}
  local fin_rela_path_taskid_map = {}
  local tmp_rela_path_taskid_map = {}
  local taskid_tmp_rela_path_map = {}
  local task_id_local_info_map = {}
  for item_idx = 1, self._data.total_list_count do
    local file_item_info = self._data.file_list[item_idx]
    local single_file_ext = create_single_file_ext_from_item_info(file_item_info)
    local init_params = self._data.single_model:get_task_init_params(file_item_info.path, single_file_ext, self._data.opts)
    local complete_file_path = init_params[DTM.TASK_INIT_PARAMS.DEST_FILE_PATH]
    local downloading_tmp_file_path = init_params[DTM.TASK_INIT_PARAMS.FILE_TEMP_PATH]
    file_item_info.size = type(file_item_info.size) == "number" and file_item_info.size or -1
    local task_id = init_params.task_id
    file_item_info.task_id = task_id
    file_item_info[FILE_ITEM_EXT_KEY.EXT] = file_item_info[FILE_ITEM_EXT_KEY.EXT] or {}
    local item_ext_info = file_item_info[FILE_ITEM_EXT_KEY.EXT]
    item_ext_info[FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH] = complete_file_path
    item_ext_info[FILE_ITEM_EXT_KEY.EX_TMP_PATH] = downloading_tmp_file_path
    self._data.task_id_init_info_map[task_id] = init_params
    task_id_local_info_map[task_id] = {
      [DTM.TASK_INIT_PARAMS.LOCAL_MD5] = history_task_id_md5_map[task_id]
    }
    local complete_file_rela_path = init_params[DTM.TASK_INIT_PARAMS.FILE_RELA_PATH]
    local downloading_tmp_rela_path = init_params[DTM.TASK_INIT_PARAMS.TEMP_RELA_PATH]
    if opt_all_files_is_incomplete then
      table.insert(incomplete_rela_path_list, downloading_tmp_rela_path)
    else
      table.insert(complete_rela_path_list, complete_file_rela_path)
    end
    fin_rela_path_taskid_map[complete_file_rela_path] = task_id
    taskid_tmp_rela_path_map[task_id] = downloading_tmp_rela_path
    tmp_rela_path_taskid_map[downloading_tmp_rela_path] = task_id
  end
  _ejoysdk.log("_check_all_file_state2 2, count:" .. tostring(self._data.total_list_count) .. ", cost1:" .. tostring(E.system_clock() - b1))
  
  local function on_local_info_initted_cb()
    local b2 = E.system_clock()
    local new_list_task_id_md5_map = {}
    local checked_invalid_file_list = {}
    local unfinished_task_id_set = {}
    for item_idx = 1, self._data.total_list_count do
      local file_item_info = self._data.file_list[item_idx]
      local item_task_id = file_item_info.task_id
      new_list_task_id_md5_map[item_task_id] = file_item_info.md5
      local task_init_info = self._data.task_id_init_info_map[item_task_id]
      task_init_info[DTM.TASK_INIT_PARAMS.LOCAL_INFO] = task_id_local_info_map[item_task_id]
      local checked_file_state, checked_file_state_info, checked_file_size = self._data.download_multi_source:check_download_state(item_task_id, file_item_info, task_init_info)
      task_init_info[DTM.TASK_INIT_PARAMS.CHECKED_INIT_STATE] = checked_file_state
      task_init_info[DTM.TASK_INIT_PARAMS.CHECKED_STATE_INFO] = checked_file_state_info
      if checked_file_state == DTM.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID then
        if not self._data.finish_map[item_task_id] then
          self._data.finish_map[item_task_id] = true
          self._data.download_state.finish_count = (self._data.download_state.finish_count or 0) + 1
          self._data.finish_downloading_size = self._data.finish_downloading_size + checked_file_size
        end
      else
        if not unfinished_task_id_set[item_task_id] then
          unfinished_task_id_set[item_task_id] = true
          unfinished_task_count = unfinished_task_count + 1
          table.insert(unfinished_file_list, file_item_info)
        end
        if checked_file_state ~= DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_VALID and not need_native_download_task_id_map[item_task_id] then
          need_native_download_task_id_map[item_task_id] = true
        end
        if checked_file_state == DTM.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_INVALID then
          local ci_path = file_item_info[FILE_ITEM_EXT_KEY.EXT][FILE_ITEM_EXT_KEY.EX_COMPLETE_PATH]
          table.insert(checked_invalid_file_list, ci_path)
        elseif checked_file_state == DTM.DOWNLOAD_CHECK_STATE.DOWNLOADING_FILE_INVALID then
          local ci_path = file_item_info[FILE_ITEM_EXT_KEY.EXT][FILE_ITEM_EXT_KEY.EX_TMP_PATH]
          table.insert(checked_invalid_file_list, ci_path)
        end
      end
    end
    local b3 = E.system_clock()
    _ejoysdk.log("_check_all_file_state2 cost2:" .. tostring(b3 - b2) .. ", cnt:" .. tostring(self._data.total_list_count) .. ", invalid size:" .. tostring(#checked_invalid_file_list))
    self._data.total_task_count = self._data.download_state.finish_count + unfinished_task_count
    self._data.unfinished_file_list = unfinished_file_list
    self._data.unfinished_file_list_count = #unfinished_file_list
    self:_update_downloading_size(self._data.finish_downloading_size)
    
    local function all_check_complete_handler()
      self._data.model_instance:save_file_list_md5(tag_name, new_list_task_id_md5_map)
      local b4 = E.system_clock()
      E.LOG.debug(TAG, "_check_all_file_state2 complete downloading_size:" .. tostring(self._data.finish_downloading_size) .. ", total_count:" .. tostring(self._data.total_task_count) .. ", cost:" .. tostring(b4 - b1))
      self._data.has_checked_all_file_state = true
      cb(true, unfinished_file_list, need_native_download_task_id_map)
    end
    
    local invalid_size = #checked_invalid_file_list
    if invalid_size > 0 then
      self:log_warn("complete_invalid_file_list > 0, need wait for remove")
      local _rm_opts = {is_fullpath = true}
      E.File.batch_remove(checked_invalid_file_list, function()
        all_check_complete_handler()
        if not self._data.disable_stat then
          DST.stat_action("ejoy_multi_http_download", "checked_invalid_list_size", invalid_size)
        end
      end, _rm_opts)
    else
      self:log_warn("no complete_invalid_file_list, now directly callback complete")
      all_check_complete_handler()
    end
  end
  
  local batch_info_opts = {
    is_full_path = not self._data.storage_path or self._data.storage_path == "",
    check_size = true,
    base_path = self._data.storage_path
  }
  
  local function incomplete_file_list_checker(incomplete_rela_file_list)
    local incomplete_size = #incomplete_rela_file_list
    _ejoysdk.log("incomplete_file_list_checker >>>>>>" .. tostring(incomplete_size))
    if 0 == incomplete_size then
      on_local_info_initted_cb()
    else
      local need_check_incomplete_batch_info_count = math.min(incomplete_size, DEFAULT_THREAD_COUNT)
      local need_check_incomplete_batch_info_list = {}
      for i = 1, need_check_incomplete_batch_info_count do
        table.insert(need_check_incomplete_batch_info_list, incomplete_rela_file_list[i])
      end
      self:log_debug("incomplete_rela_file_list size:" .. tostring(need_check_incomplete_batch_info_count) .. ", total:" .. tostring(incomplete_size) .. ", basePath:" .. tostring(self._data.storage_path))
      local b2 = E.system_clock()
      E.File.batch_info(need_check_incomplete_batch_info_list, function(incomplete_result)
        local b3 = E.system_clock()
        for rpath, result in pairs(incomplete_result) do
          local task_id = tmp_rela_path_taskid_map[rpath]
          local item_local_info = task_id_local_info_map[task_id]
          item_local_info[DTM.TASK_INIT_PARAMS.LOCAL_TMP_EXISTS] = result.exists
          item_local_info[DTM.TASK_INIT_PARAMS.LOCAL_TMP_SIZE] = result.size
        end
        if need_check_incomplete_batch_info_count < incomplete_size then
          for i = need_check_incomplete_batch_info_count + 1, incomplete_size do
            local rpath = incomplete_rela_file_list[i]
            local task_id = tmp_rela_path_taskid_map[rpath]
            local item_local_info = task_id_local_info_map[task_id]
            item_local_info[DTM.TASK_INIT_PARAMS.LOCAL_TMP_EXISTS] = false
            item_local_info[DTM.TASK_INIT_PARAMS.LOCAL_TMP_SIZE] = 0
          end
        end
        local b4 = E.system_clock()
        _ejoysdk.log("_check_all_file_state2 batch_info2, t1:" .. tostring(b3 - b2) .. ", t2:" .. tostring(b4 - b3) .. ", cnt:" .. tostring(incomplete_size))
        on_local_info_initted_cb()
      end, batch_info_opts)
    end
  end
  
  if opt_all_files_is_incomplete then
    self:log_debug("opt_all_files_is_incomplete true, now directly check incomplete file list")
    incomplete_file_list_checker(incomplete_rela_path_list)
  else
    self:log_debug("opt_all_files_is_incomplete false, now check complete file list:" .. tostring(#complete_rela_path_list))
    local b2 = E.system_clock()
    E.File.batch_info(complete_rela_path_list, function(complete_file_result_data)
      _ejoysdk.log("_check_all_file_state2 batch_info back")
      local b3 = E.system_clock()
      for rp, result in pairs(complete_file_result_data) do
        local task_id = fin_rela_path_taskid_map[rp]
        local item_local_info = task_id_local_info_map[task_id]
        item_local_info[DTM.TASK_INIT_PARAMS.LOCAL_FIN_EXISTS] = result.exists
        item_local_info[DTM.TASK_INIT_PARAMS.LOCAL_FIN_SIZE] = result.size
        if not result.exists then
          local tmp_rela_file_path = taskid_tmp_rela_path_map[task_id]
          table.insert(incomplete_rela_path_list, tmp_rela_file_path)
        end
      end
      local b4 = E.system_clock()
      _ejoysdk.log("_check_all_file_state2 batch_info1, t1:" .. tostring(b3 - b2) .. ", t2:" .. tostring(b4 - b3) .. ", cnt:" .. tostring(#complete_rela_path_list))
      incomplete_file_list_checker(incomplete_rela_path_list)
    end, batch_info_opts)
  end
end

function M:_setup_notification_present_progress_info(need_native_download_task_id_map)
  if not self:_need_present_notification_progress() then
    self:log_debug("_setup_notification_present_progress_info skip, not enabled")
    return
  end
  self:log_debug("notification progress is enabled or need_submit_all_task, now begin setup_passive_mode_progress_presenter_info, " .. "is_notification_progress_enabled:" .. tostring(self:_is_notification_progress_enabled()) .. ", is_need_submit_all_task:" .. tostring(self._data.submit_rule_background_enabled))
  local downloading_list_info = {task_ids = need_native_download_task_id_map}
  local present_downloading_size = self._data.notification_present_ext.base_finish_downloading_size or 0
  present_downloading_size = present_downloading_size + (self._data.download_state[M.STATE_KEY.DOWNLOADING_SIZE] or 0)
  local present_total_size = self._data.notification_present_ext.base_total_size or self._data.download_state[M.STATE_KEY.TOTAL_SIZE] or 0
  local _percent = self._data.download_state[M.STATE_KEY.PERCENT] or 0
  if present_total_size > 0 then
    _percent = math.floor(present_downloading_size / present_total_size * 100)
  end
  local present_progress_info = {
    downloading_size = present_downloading_size,
    total_size = present_total_size,
    speed = self._data.download_state.speed or 0,
    progress = _percent,
    state = self._data.download_state.state
  }
  local _opts = {
    native_update_only = true,
    custom_config = self._data.notification_present_ext.custom_config
  }
  self:log_debug("_setup_notification_present_progress_info >>")
  E.log(present_progress_info)
  local ANP = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
  ANP.setup_passive_mode_progress_presenter_info(present_progress_info, downloading_list_info, _opts)
end

function M:_start_with_multi_request_adapter(unfinished_file_list, need_native_download_task_id_map)
  local unfinished_file_list_count = unfinished_file_list and #unfinished_file_list or 0
  if 0 == unfinished_file_list_count then
    self:log_debug("_start_with_multi_request_adapter unfinished_file_list_count is 0, will finish, finish_count = " .. tostring(self._data.download_state.finish_count))
    self:_fsm_transition_to(nil, _STATES.COMPLETE)
    return
  end
  if need_native_download_task_id_map then
    self:_setup_notification_present_progress_info(need_native_download_task_id_map)
  end
  self:_fsm_transition_to(nil, _STATES.DOWNLOADING)
  local params = {
    task_id_init_info_map = self._data.task_id_init_info_map
  }
  self._data.download_multi_source:start(unfinished_file_list, params)
end

function M:_inner_start_download(cb)
  self:_check_all_file_state_if_need(function(succ, ...)
    _ejoysdk.log("_check_all_file_state_if_need result:" .. tostring(succ))
    if succ then
      local _unfinished_file_list, need_native_download_task_id_map = ...
      self:_start_with_multi_request_adapter(_unfinished_file_list, need_native_download_task_id_map)
    else
      local code, msg = ...
      self:_on_download_failed(code, msg)
    end
    if cb then
      cb(true)
    end
  end, true)
end

function M:_update_downloading_size(downloading_size)
  downloading_size = tonumber(downloading_size)
  local percent = 0
  if self._data.download_state.total_size > 0 then
    percent = math.floor(downloading_size / self._data.download_state.total_size * 100)
  elseif self._data.total_task_count > 0 then
    percent = self._data.download_state.finish_count / self._data.total_task_count * 100
    _ejoysdk.log("_update_downloading_size percent:" .. tostring(percent) .. ", finish_count:" .. tostring(self._data.download_state.finish_count) .. ", total_count:" .. tostring(self._data.total_task_count))
  end
  self._data.download_state[M.STATE_KEY.PERCENT] = percent
  self._data.download_state[M.STATE_KEY.DOWNLOADING_SIZE] = downloading_size
end

function M:_init_duration()
  if self._data.disable_stat then
    self:log_debug("_init_duration skip, disable_stat is true")
    return
  end
  local duration_cache = self._data.duration_info_cache
  local last_dur_str = duration_cache:get()
  self._data.last_duration = tonumber(last_dur_str) or 0
  self._data.duration_begin_time_mills = E.system_ms()
  self._data.download_state.duration = self._data.last_duration
  self._data.duration_save_interval_sec = self._data.download_state.total_size < 209715200 and 5 or 10
  self:log_debug("_init_duration last_duration:" .. tostring(self._data.last_duration) .. ", save interval:" .. tostring(self._data.duration_save_interval_sec) .. ", total_size:" .. tostring(self._data.download_state.total_size))
end

function M:_update_duration(event_time_mills)
  if self._data.disable_stat or nil == event_time_mills or self._data.download_state.state ~= _STATES.DOWNLOADING then
    return
  end
  local current_time_sec = os.time()
  local _duration_within_current_startup_sec = (event_time_mills - self._data.duration_begin_time_mills) / 1000
  self._data.duration_within_current_startup_sec = math.max(self._data.duration_within_current_startup_sec, _duration_within_current_startup_sec)
  self._data.download_state.duration = self._data.last_duration + self._data.duration_within_current_startup_sec
  if current_time_sec - self._data.duration_save_last_time_sec >= self._data.duration_save_interval_sec then
    self._data.duration_save_last_time_sec = current_time_sec
    local duration_cache = self._data.duration_info_cache
    duration_cache:set(self._data.download_state.duration, true)
  end
end

function M:_delete_cache_duration_info()
  if self._data.disable_stat then
    self:log_debug("_delete_cache_duration_info skip, disable_stat is true")
    return
  end
  E.LOG.debug(TAG, "_reset_duration_info begin")
  self._data.duration_within_current_startup_sec = 0
  self._data.duration_save_last_time_sec = os.time()
  self._data.duration_begin_time_mills = E.system_ms()
  local duration_cache = self._data.duration_info_cache
  duration_cache:delete()
  self._data.last_duration = 0
end

function M:_update_unfinished_downloading_size(task_id, recv_bytes)
  if 0 == self._data.unfinished_downloading_size then
    local downloading_task_recv_bytes = 0
    for _, v in pairs(self._data.unfinished_task_downloading_sizes) do
      downloading_task_recv_bytes = downloading_task_recv_bytes + v
    end
    self._data.unfinished_downloading_size = downloading_task_recv_bytes
  end
  local last_item_unfinished_downloading_size = self._data.unfinished_task_downloading_sizes[task_id]
  if last_item_unfinished_downloading_size and not recv_bytes then
    self._data.unfinished_task_downloading_sizes[task_id] = nil
    self._data.unfinished_downloading_size = self._data.unfinished_downloading_size - last_item_unfinished_downloading_size
  elseif not last_item_unfinished_downloading_size and recv_bytes then
    self._data.unfinished_task_downloading_sizes[task_id] = recv_bytes
    self._data.unfinished_downloading_size = self._data.unfinished_downloading_size + recv_bytes
  elseif last_item_unfinished_downloading_size and recv_bytes and recv_bytes > last_item_unfinished_downloading_size then
    self._data.unfinished_task_downloading_sizes[task_id] = recv_bytes
    local recv_diff = recv_bytes - last_item_unfinished_downloading_size
    self._data.unfinished_downloading_size = self._data.unfinished_downloading_size + recv_diff
  elseif last_item_unfinished_downloading_size and recv_bytes and recv_bytes < last_item_unfinished_downloading_size then
    self._data.unfinished_task_downloading_sizes[task_id] = recv_bytes
    local last_diff = last_item_unfinished_downloading_size - recv_bytes
    self._data.unfinished_downloading_size = self._data.unfinished_downloading_size - last_diff
  end
  return self._data.unfinished_downloading_size
end

function M:_on_download_failed(code, msg, url)
  local current_download_state = self._data.download_state
  current_download_state.err_code = code or -1
  current_download_state.err_msg = msg
  current_download_state.state = M.DOWNLOAD_STATE.FAILED
  current_download_state.err_url = url
  self:stop_download_impl(function(_succ, ...)
    self:_fsm_transition_to(nil, _STATES.STOPPED)
  end)
end

function M:_on_receive_progress_changed(progress_info)
  if not self._data.download_progress_listener then
    return
  end
  if self:is_downloading_impl() and not self:_is_stop_processing() then
    local task_id = progress_info[DTM.PROGRESS_INFO_KEY.TASK_ID]
    local recv_bytes = progress_info[DTM.PROGRESS_INFO_KEY.RECV_BYTES] or -1
    local downloading_task_recv_bytes = self:_update_unfinished_downloading_size(task_id, recv_bytes)
    local file_downloading_size = (self._data.finish_downloading_size or 0) + downloading_task_recv_bytes
    self:_update_downloading_size(file_downloading_size)
    self:_notify_download_progress_changed(false, DTM.DOWNLOAD_STATE.DOWNLOADING, task_id, progress_info.event_time)
  end
end

local function _to_simple_file_item_info(file_item_info)
  local simple_file_item_info = {
    name = file_item_info.name,
    path = file_item_info.path,
    dest_path = file_item_info.dest_path,
    size = file_item_info.size,
    md5 = file_item_info.md5
  }
  return simple_file_item_info
end

local function _to_simple_file_state_info(state_info)
  local DT = require("ejoysdk_lua.res.model.http_download_task")
  local simple_state_info = {
    [DT.STATE_KEY.STATE] = state_info[DT.STATE_KEY.STATE],
    [DT.STATE_KEY.FILE_PATH] = state_info[DT.STATE_KEY.FILE_PATH],
    [DT.STATE_KEY.SIZE] = state_info[DT.STATE_KEY.SIZE],
    [DT.STATE_KEY.RECV_BYTES] = state_info[DT.STATE_KEY.RECV_BYTES],
    [DT.STATE_KEY.ERR_CODE] = state_info[DT.STATE_KEY.ERR_CODE],
    [DT.STATE_KEY.ERR_MSG] = state_info[DT.STATE_KEY.ERR_MSG],
    [DT.STATE_KEY.PERCENT] = state_info[DT.STATE_KEY.PERCENT]
  }
  return simple_state_info
end

function M:_on_receive_state_changed(file_item_info, _state, _state_obj)
  if _state == DTM.DOWNLOAD_STATE.COMPLETE then
    local last_finish_item_info = file_item_info
    local downloading_task_recv_bytes = self:_update_unfinished_downloading_size(_state_obj.task_id, nil)
    local _t_id = _state_obj.task_id
    local finish_count = self._data.download_state.finish_count or 0
    if not self._data.finish_map[_state_obj.task_id] then
      finish_count = finish_count + 1
      self._data.finish_map[_state_obj.task_id] = true
      local item_size = file_item_info.size or 0
      if 0 == item_size then
        item_size = _state_obj.size or 0
      end
      self._data.finish_downloading_size = (self._data.finish_downloading_size or 0) + item_size
    end
    local file_downloading_size = self._data.finish_downloading_size + downloading_task_recv_bytes
    self._data.download_state[M.STATE_KEY.FINISH_COUNT] = finish_count
    self._data.download_state[M.STATE_KEY.LAST_FINISH_ITEM] = last_finish_item_info
    self:_update_downloading_size(file_downloading_size)
    self:_notify_download_progress_changed(false, DTM.DOWNLOAD_STATE.DOWNLOADING, _t_id, _state_obj.event_time)
    if self._data.download_state.finish_count == self._data.total_task_count then
      self:log_debug("will finish, finish_count = " .. tostring(self._data.download_state.finish_count))
      self:_fsm_transition_to(nil, _STATES.COMPLETE)
    end
  elseif _state == DTM.DOWNLOAD_STATE.FAILED then
    self:_on_download_failed(_state_obj.err_code, _state_obj.err_msg, _state_obj.url)
  end
  if self._data.single_file_state_listener and (_state == DTM.DOWNLOAD_STATE.COMPLETE or _state == DTM.DOWNLOAD_STATE.FAILED) then
    self._data.single_file_state_listener(_to_simple_file_item_info(file_item_info), _state, _to_simple_file_state_info(_state_obj))
  end
end

function M:_get_model_cache_key()
  local total_size = self._data.notification_present_ext.base_total_size or self._data.download_state[M.STATE_KEY.TOTAL_SIZE] or 0
  local key = self._data.model_name .. "_" .. tostring(total_size)
  return key
end

function M:_init(_task_id, _file_list, _file_ext, _opts, params, _model_instance, _single_model)
  E.log("init multi task version 2 >>>>>")
  E.log(_opts)
  assert(self, "call task New with missing ':'mark")
  local _total_list_count = _file_list and #_file_list or 0
  _file_ext = _file_ext or {}
  local fsm_callbacks = {
    ["on" .. _EVENTS.INIT] = function(_f_self, from)
      if from ~= _STATES.IDLE then
        self:log_debug("init event always processed by undefined state")
        return FSM.SYNC
      end
      local total_complete_count = 0
      local has_incomplete_task = false
      if 0 == _total_list_count then
        self:log_warn("file list count is 0, just to complete state")
        self:_fsm_equeue_event_at_front(_EVENTS.INIT_SUCC)
        return FSM.SYNC, _STATES.COMPLETE
      end
      local before = E.system_clock()
      local opt_all_files_is_incomplete = self._data.opts.all_files_in_list_incomplete or false
      if not opt_all_files_is_incomplete then
        self:log_debug("_init opt_all_files_is_incomplete false, now check all file state")
        for item_index = _total_list_count, 1, -1 do
          local item = _file_list[item_index]
          local item_ext = create_single_file_ext_from_item_info(item)
          local url = self:_get_url_for_path(item.path)
          local file_state = self._data.single_model:check_file_state(url, item_ext, _opts)
          if file_state == DTM.DOWNLOAD_CHECK_STATE.COMPLETE_FILE_VALID then
            total_complete_count = total_complete_count + 1
          else
            has_incomplete_task = true
            break
          end
        end
      else
        self:log_debug("_init opt_all_files_is_incomplete true, skip check all file state")
        has_incomplete_task = true
      end
      if not self._data.disable_stat then
        local after = E.system_clock()
        local cost_total = after - before
        E.LOG.debug(TAG, "create_task stage total:" .. tostring(cost_total) .. ", total_count:" .. tostring(_total_list_count))
        DST.stat_action("ej_muli_task_create_total_cost", cost_total, _total_list_count)
      else
        self:log_debug("stat disabled, skip stat create_task cost")
      end
      self._data.download_state[M.STATE_KEY.TOTAL_COUNT] = _total_list_count
      if has_incomplete_task then
        self:_fsm_transition_to(_STATES.IDLE, _STATES.STOPPED)
        self:log_debug("_init had not finish file, transition to stop state")
      elseif total_complete_count == _total_list_count then
        self:_fsm_transition_to(_STATES.IDLE, _STATES.COMPLETE)
        self:log_debug("_init already exists valid files, transition to complete state")
      end
      self:_fsm_equeue_event_at_front(_EVENTS.INIT_SUCC)
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.INIT_SUCC] = function(_fsm, _from, ...)
      self:log_debug("init succ")
      self._data.initted = true
      self:_init_duration()
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.START_DOWNLOAD] = function(_fsm, from, ...)
      self:log_debug("receive start_download event, from:" .. tostring(from))
      if from == _STATES.IDLE then
        self:_inner_start_download(function()
          self:_fsm_on_async_event_finished(_EVENTS.START_DOWNLOAD)
        end)
        return FSM.ASYNC
      elseif from == _STATES.STOPPED then
        if not self._data.has_checked_all_file_state then
          self:log_debug("download task not init, now begin call _inner_start_download")
          self:_inner_start_download(function()
            self:_fsm_on_async_event_finished(_EVENTS.START_DOWNLOAD)
          end)
          return FSM.ASYNC
        else
          self:log_debug("download task has init, now begin call resume_download")
          self:_fsm_equeue_event_at_front(_EVENTS.RESUME_DOWNLOAD, ...)
          return FSM.SYNC
        end
      elseif from == _STATES.DOWNLOADING then
        self:log_debug("start_download already downloading, now callback directly")
        self:_notify_download_progress_changed(true)
        self:_notify_download_state_changed()
        return FSM.SYNC
      elseif from == _STATES.COMPLETE then
        self:log_debug("start_download already downloaded, now callback downloaded state directly")
        self:_notify_download_progress_changed(true)
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
      self:_start_download_for_resume(function()
        self:_fsm_on_async_event_finished(_EVENTS.RESUME_DOWNLOAD)
      end)
      return FSM.ASYNC
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
        self:_do_stop_download_task(function(succ, ...)
          if succ then
            self:_fsm_transition_to(from, _STATES.STOPPED)
            p_cb_wrapper(true)
          else
            local cd_code, cd_msg = ...
            p_cb_wrapper(false, cd_code, cd_msg)
          end
          self:_fsm_on_async_event_finished(_EVENTS.STOP_DOWNLOAD)
        end, from)
        return FSM.ASYNC
      end
    end,
    ["on" .. _EVENTS.RESET_DOWNLOAD] = function(_fsm, from, ...)
      self:log_debug("reset download from:" .. tostring(from))
      local reset_download_cb = (...)
      
      local function download_cb_wrapper(succ, ...)
        if reset_download_cb then
          reset_download_cb(succ, ...)
        end
      end
      
      if from == _STATES.IDLE then
        self:_start_download_for_reset(function()
          self:_fsm_on_async_event_finished(_EVENTS.RESET_DOWNLOAD)
        end)
        return FSM.ASYNC
      elseif from == _STATES.STOPPED then
        self:_inner_remove_download(function(_succ)
          self:_fsm_transition_to(_STATES.STOPPED, _STATES.IDLE)
          self:_fsm_equeue_event_at_front(_EVENTS.RESET_DOWNLOAD, reset_download_cb)
          self:_fsm_on_async_event_finished(_EVENTS.RESET_DOWNLOAD)
        end)
        return FSM.ASYNC
      elseif from == _STATES.DOWNLOADING then
        self:_do_stop_download_task(function(rd_succ, ...)
          if rd_succ then
            self:_fsm_transition_to(from, _STATES.STOPPED)
            self:_fsm_equeue_event_at_front(_EVENTS.RESET_DOWNLOAD, reset_download_cb)
          else
            download_cb_wrapper(false, EC.DOWNLOAD_ERROR_CODES.STOP_DOWNLOAD_FAILED, "stop download task failed")
          end
          self:_fsm_on_async_event_finished(_EVENTS.RESET_DOWNLOAD)
        end, from)
        return FSM.ASYNC
      elseif from == _STATES.COMPLETE then
        self:_inner_remove_download(function(_succ)
          self:_fsm_transition_to(from, _STATES.IDLE)
          self:_fsm_equeue_event_at_front(_EVENTS.RESET_DOWNLOAD, reset_download_cb)
          self:_fsm_on_async_event_finished(_EVENTS.RESET_DOWNLOAD)
        end)
        return FSM.ASYNC
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
        self:_inner_remove_download(function(_succ)
          self:_fsm_transition_to(_STATES.STOPPED, _STATES.IDLE)
          self:_fsm_equeue_event_at_front(_EVENTS.REMOVE_DOWNLOAD, rd_cb)
          self:_fsm_on_async_event_finished(_EVENTS.REMOVE_DOWNLOAD)
        end)
        return FSM.ASYNC
      elseif from == _STATES.DOWNLOADING then
        self:_do_stop_download_task(function(rd_succ, ...)
          if rd_succ then
            self:_fsm_transition_to(from, _STATES.STOPPED)
            self:_fsm_equeue_event_at_front(_EVENTS.REMOVE_DOWNLOAD, rd_cb)
          else
            local c_code, c_message = ...
            self:log_warn("event remove_download, cancel download task faild, code:" .. tostring(c_code) .. ", message:" .. tostring(c_message))
            rd_cb_wrapper(false, c_code, c_message)
          end
          self:_fsm_on_async_event_finished(_EVENTS.REMOVE_DOWNLOAD)
        end, from)
        return FSM.ASYNC
      elseif from == _STATES.COMPLETE then
        self:_inner_remove_download(function(_succ)
          self:_fsm_transition_to(_STATES.COMPLETE, _STATES.IDLE)
          self:_fsm_equeue_event_at_front(_EVENTS.REMOVE_DOWNLOAD, rd_cb)
          self:_fsm_on_async_event_finished(_EVENTS.REMOVE_DOWNLOAD)
        end)
        return FSM.ASYNC
      end
    end,
    ["onenter" .. _STATES.IDLE] = function(_fsm, from, ...)
      self:log_debug("onenter idle, from:" .. tostring(from) .. ", reset current download state")
      local current_download_state = self._data.download_state
      current_download_state.state = M.DOWNLOAD_STATE.IDLE
      current_download_state.downloading_size = 0
      current_download_state.err_code = 0
      current_download_state.err_msg = nil
      current_download_state.err_url = nil
      current_download_state.percent = -1
      current_download_state.finish_count = 0
      current_download_state.speed = 0
      current_download_state.duration = 0
      self._data.unfinished_task_downloading_sizes = {}
      self._data.unfinished_downloading_size = 0
      self._data.finish_map = {}
      self._data.finish_downloading_size = 0
      self._data.last_finish_item_info = nil
      self._data.unfinished_file_list = {}
      self._data.unfinished_file_list_count = 0
      for _tid, info_obj in pairs(self._data.task_id_init_info_map) do
        info_obj[DTM.TASK_INIT_PARAMS.LOCAL_INFO] = {}
        info_obj[DTM.TASK_INIT_PARAMS.CHECKED_STATE_INFO] = info_obj[DTM.TASK_INIT_PARAMS.CHECKED_STATE_INFO] or {}
        info_obj[DTM.TASK_INIT_PARAMS.CHECKED_INIT_STATE] = DTM.DOWNLOAD_CHECK_STATE.NOT_DOWNLOAD
        local checked_info = info_obj[DTM.TASK_INIT_PARAMS.CHECKED_STATE_INFO]
        checked_info[DTM.INIT_FILE_STATE_KEY.REAL_SIZE] = 0
      end
      self:_delete_cache_duration_info()
      local biz_name = self:model_task_name()
      ERU.reset_download_speed(biz_name)
      self:_notify_download_progress_changed(true)
      self:_notify_download_state_changed()
    end,
    ["onenter" .. _STATES.STOPPED] = function(_fsm, from, ...)
      self:log_debug("onenter stopped, from:" .. tostring(from))
      local current_download_state = self._data.download_state
      if 0 == current_download_state.err_code then
        current_download_state.err_code = EC.DOWNLOAD_ERROR_CODES.CANCELLED
        current_download_state.err_msg = "download cancelled"
        current_download_state.err_url = nil
        current_download_state.state = M.DOWNLOAD_STATE.STOPPED
      else
        current_download_state.state = M.DOWNLOAD_STATE.FAILED
      end
      current_download_state.speed = 0
      local biz_name = self:model_task_name()
      ERU.reset_download_speed(biz_name)
      self:_notify_download_progress_changed(true)
      self:_notify_download_state_changed()
    end,
    ["onenter" .. _STATES.COMPLETE] = function(_f_self, from, ...)
      self:log_debug("onenter complete, from:" .. tostring(from))
      local current_download_state = self._data.download_state
      current_download_state.state = M.DOWNLOAD_STATE.COMPLETE
      current_download_state.err_code = 0
      current_download_state.err_msg = nil
      current_download_state.err_url = nil
      current_download_state.percent = 100
      current_download_state.downloading_size = current_download_state.total_size
      current_download_state.finish_count = self._data.total_task_count
      current_download_state.speed = 0
      self:_notify_download_progress_changed(true, from)
      self:_notify_download_state_changed()
      self:_delete_cache_duration_info()
    end,
    ["onenter" .. _STATES.DOWNLOADING] = function(_f_self, _from, ...)
      self:log_debug("onenter downloading, from:" .. tostring(_from))
      local current_download_state = self._data.download_state
      current_download_state.state = M.DOWNLOAD_STATE.DOWNLOADING
      current_download_state.err_code = 0
      current_download_state.err_msg = nil
      current_download_state.err_url = nil
      self:_notify_download_state_changed()
      self:_notify_download_progress_changed(true)
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
  local _foreground_notification_enabled
  if _opts and type(_opts.foreground_notification_enabled) == "boolean" then
    _foreground_notification_enabled = _opts.foreground_notification_enabled
  end
  self._data = {
    initted = false,
    model_name = _model_instance:get_model_name(),
    task_id = _task_id,
    tag = _file_ext and _file_ext.tag or _task_id,
    max_retry_times = _opts and _opts.max_retry_times or nil,
    use_independent_pool = nil,
    progress_notify_interval_millis = _opts and _opts.progress_notify_interval_millis or nil,
    disable_deepcopy_result = _opts and _opts.disable_deepcopy_result or false,
    _file_ext = _file_ext,
    file_list = _file_list or {},
    total_list_count = _total_list_count,
    opts = _opts or {},
    download_state_listener = params.download_state_listener,
    download_state = {
      state = _STATES.IDLE,
      tag = _file_ext and _file_ext.tag or _task_id,
      total_size = _file_ext and _file_ext.total_size or 0,
      downloading_size = 0,
      finish_count = 0,
      err_code = 0,
      err_msg = 0,
      err_url = nil,
      percent = -1,
      duration = 0,
      last_finish_item = nil,
      speed = 0
    },
    download_progress_listener = params.download_progress_listener,
    download_fsm = _download_fsm,
    model_instance = _model_instance,
    single_model = _single_model,
    debug_enable = _model_instance:get_global_config().debug_enable,
    unfinished_task_downloading_sizes = {},
    unfinished_downloading_size = 0,
    unfinished_file_list = {},
    unfinished_file_list_count = 0,
    finish_map = {},
    last_finish_item_info = nil,
    finish_downloading_size = 0,
    last_stat_percent = 0,
    last_stat_avg_speed = 0,
    last_stat_cal_avg_speed_cnt = 0,
    foreground_notification_enabled = _foreground_notification_enabled,
    last_noti_clock = E.system_clock(),
    total_task_count = _total_list_count,
    submit_rule_submit_all_enabled = false,
    submit_rule_background_enabled = false,
    notification_present_ext = _opts and _opts.notification_present_ext or {},
    multi_download_configs = nil,
    log_level = _opts and _opts.log_level or DST.INNER_LOG_LEVEL.DEBUG,
    current_log_level = nil,
    task_id_init_info_map = {},
    storage_path = nil,
    base_url = nil,
    has_checked_all_file_state = false,
    enable_single_download_log_config = false,
    last_duration = 0,
    duration_begin_time_mills = 0,
    duration_info_cache = nil,
    duration_save_interval_sec = 5,
    duration_heartbeat_last_time_sec = 0,
    duration_save_last_time_sec = 0,
    duration_within_current_startup_sec = 0,
    download_multi_source = nil,
    single_file_state_listener = nil,
    disable_stat = _opts and _opts.disable_stat or false
  }
  self:_set_log_level(self._data.log_level)
  if not self._data.opts.network_strategy then
    self._data.opts.network_strategy = NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK
  end
  E.LOG.debug(TAG, "init end >> _foreground_notification_enabled:" .. tostring(_foreground_notification_enabled) .. ", total_size:" .. tostring(self._data.download_state.total_size) .. ", total_count:" .. tostring(_total_list_count) .. ", strategy:" .. tostring(self._data.opts.network_strategy))
  local storage_type = _opts and _opts.storage_type or ERB.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  self._data.storage_path = ERB.static_get_storage_path_by_type(storage_type)
  if _opts and "boolean" == type(_opts.use_independent_pool) then
    self._data.use_independent_pool = _opts.use_independent_pool
  end
  self._data.base_url = E.Path.trim_end_separator(_file_ext.base_url)
  if not self._data.multi_download_configs then
    local ecc = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = ecc.get_config(ecc.NAMESPACE.EJOYSDK_BIZ)
    if biz_config and biz_config.config and biz_config.config.multi_download_configs then
      self._data.multi_download_configs = biz_config.config.multi_download_configs
      self:log_debug("get multi_download_configs in init>>")
      E.log(self._data.multi_download_configs)
    end
  end
  local key = self:_get_model_cache_key()
  self._data.duration_info_cache = E.SPKeyStore:New("download_multi_duration_cache", key)
  
  local function on_single_state_listener(_file_item_info, _state, _state_obj)
    self:_on_receive_state_changed(_file_item_info, _state, _state_obj)
  end
  
  local function on_single_progress_listener(_file_item_info, progress_info)
    self:_on_receive_progress_changed(progress_info)
  end
  
  local function on_global_failed(code, msg)
    self:log_warn("on_global_failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    self:_on_download_failed(code, msg)
  end
  
  local source_params = {
    multi_download_configs = self._data.multi_download_configs,
    total_list_count = self._data.total_list_count
  }
  self._data.download_multi_source = RB:New(self, self._data._file_ext, self._data.opts, source_params, on_global_failed, on_single_state_listener, on_single_progress_listener)
  self:_fsm_equeue_event_at_front(_EVENTS.INIT)
end

function M:update_download_properties(properties)
  if type(properties.max_retry_times) == "number" then
    local max_retry_times = properties.max_retry_times
    E.LOG.debug(TAG, "update_download_properties max_retry_times:" .. tostring(properties.max_retry_times))
    self._data.max_retry_times = max_retry_times
    self._data.opts = self._data.opts or {}
    self._data.opts.max_retry_times = max_retry_times
  end
end

function M:get_download_properties()
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

function M:_is_stop_processing()
  return self:_fsm_current_event() == _EVENTS.STOP_DOWNLOAD
end

function M:stop_download_impl(cb)
  assert(self, "call stop_download missing ':' mark!")
  local current_proccessing_stop = self:_is_stop_processing()
  if current_proccessing_stop then
    return
  end
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

function M:get_download_state_impl()
  local state_obj = self._data.download_state
  if not self._data.disable_deepcopy_result then
    state_obj = UTILS.deepcopy(self._data.download_state)
  end
  state_obj[M.STATE_KEY.STATE_CHANGED] = nil
  return state_obj
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
    task_count = self._data.total_task_count,
    download_state = self:get_download_state_impl(),
    model_name = self._data.model_name
  }
end

function M:is_downloading_impl()
  return self._data.download_state.state == _STATES.DOWNLOADING
end

function M:set_single_file_state_listener_impl(listener)
  self._data.single_file_state_listener = listener
end

return M
