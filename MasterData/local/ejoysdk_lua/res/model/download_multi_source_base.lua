local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local MODULE = "download_multi_source_base"
local TAG = MODULE
local M = Class:Inherit("EjoyHttpDownloadMultiRequestBase")
M.DEFAULT_THREAD_COUNT = 20
M.DOWNLOADING_COUNT_DEFAULT = 10
M.DOWNLOADING_COUNT_ALL = -1
M.MAX_DOWNLOADING_COUNT = M.DOWNLOADING_COUNT_DEFAULT
M.BACKGROUND_DOWNLOAD_ENABLE_MIN_TASK_COUNT = 50
M.BACKGROUND_DOWNLOAD_ENABLE_MIN_SIZE = 104857600
local downloading_task_pool = {}
local reuse_task_id_listener_map = {}
M.Test_downloading_task_pool = downloading_task_pool
M.Test_reuse_task_id_listener_map = reuse_task_id_listener_map

function M:log_debug(msg)
  E.LOG.debug(self._data.tag, msg)
end

function M:log_warn(msg)
  E.LOG.warn(self._data.tag, msg)
end

function M:_init(multi_task, file_ext, opts, params, on_global_failed_listener, state_listener, progress_listener)
  local multi_model = multi_task:_multi_model()
  local _multi_task_id = multi_task:task_id_impl()
  self._data = {
    multi_task_id = _multi_task_id,
    tag = MODULE .. "#" .. _multi_task_id,
    multi_task = multi_task,
    init_params = params,
    total_list_count = params.total_list_count,
    multi_model = multi_model,
    single_model = multi_task:_single_model(),
    state_listener = state_listener,
    progress_listener = progress_listener,
    on_global_failed_listener = on_global_failed_listener,
    file_ext = file_ext or {},
    opts = opts,
    network_strategy = opts.network_strategy,
    multi_submit_cbid = 0
  }
  self._data.total_size = file_ext and file_ext.total_size or 0
  self._private_data = {}
  self:constructor()
end

function M._create_single_file_ext_from_item_info(file_item_info)
  return {
    name = file_item_info.name,
    dest_path = file_item_info.dest_path,
    md5 = file_item_info.md5,
    tag = file_item_info.tag,
    size = file_item_info.size
  }
end

function M:_get_url_for_path(item_path)
  if not self._data.file_ext.base_url then
    return item_path
  end
  local url = E.Path.join(self._data.file_ext.base_url, item_path)
  return url
end

function M:_check_download_state_with_file_item(file_item_info, task_init_info)
  local single_file_ext = M._create_single_file_ext_from_item_info(file_item_info)
  local url = self:_get_url_for_path(file_item_info.path)
  local checked_file_state, checked_file_state_info = self._data.single_model:check_file_state(url, single_file_ext, self._data.opts, task_init_info)
  local DTM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
  local checked_file_size = checked_file_state_info[DTM.INIT_FILE_STATE_KEY.REAL_SIZE] or 0
  return checked_file_state, checked_file_state_info, checked_file_size
end

function M:check_download_state(_task_id, _file_item_info, _task_init_info)
end

function M:constructor()
  assert(false, "constructor unimplemented")
end

function M:_before_start(unfinished_file_list, start_params)
  unfinished_file_list = unfinished_file_list or {}
  local _task_id_init_info_map = start_params.task_id_init_info_map
  self._data.start_params = start_params
  self._data.unfinished_file_list = unfinished_file_list
  self._data.unfinished_file_list_count = #unfinished_file_list
  self._data.task_id_init_info_map = _task_id_init_info_map
  self:log_debug("_before_start:" .. tostring(self._data.unfinished_file_list_count))
end

function M:do_start()
  assert(false, "child class should implements this method")
end

function M:start(unfinished_file_list, params)
  self:_before_start(unfinished_file_list, params)
  self:do_start()
end

function M:on_download_all_removed()
end

function M:on_stop_all_download(_cb)
  assert(false, "need child implements on_stop_all_download method")
end

function M:need_present_notification_progress()
end

function M:need_lua_present_notification_progress()
end

function M:need_background_downloading()
  local global_config = self._data.multi_model:get_global_config()
  local max_downloading_count_config = self._data.opts and self._data.opts.max_downloading_count or nil
  if type(max_downloading_count_config) ~= "number" then
    max_downloading_count_config = global_config.max_downloading_count or M.MAX_DOWNLOADING_COUNT
  end
  local need_background_downloading = max_downloading_count_config <= 0 or self._data.total_list_count >= M.BACKGROUND_DOWNLOAD_ENABLE_MIN_TASK_COUNT or self._data.total_size > M.BACKGROUND_DOWNLOAD_ENABLE_MIN_SIZE
  self:log_debug("need_background_downloading, max_downloading_count_config:" .. tostring(max_downloading_count_config) .. ", total_list_count:" .. tostring(self._data.total_list_count) .. ", total_size:" .. tostring(self._data.total_size) .. ", need_background_downloading:" .. tostring(need_background_downloading))
  return need_background_downloading
end

function M:on_global_error(code, msg)
  self:log_warn("on_global_error received, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
  if self._data.on_global_failed_listener then
    self._data.on_global_failed_listener(code, msg)
  end
end

local function remove_task_downloading_state(task_id, multi_task_id)
  local has_remain_downloading_task
  if not multi_task_id then
    downloading_task_pool[task_id] = nil
    has_remain_downloading_task = false
  else
    local multi_task_infos = downloading_task_pool[task_id]
    if multi_task_infos then
      multi_task_infos[multi_task_id] = nil
      if nil == next(multi_task_infos) then
        downloading_task_pool[task_id] = nil
        has_remain_downloading_task = false
      else
        has_remain_downloading_task = true
      end
    end
  end
  return has_remain_downloading_task
end

local function has_downloading_task(task_id)
  return downloading_task_pool[task_id] and next(downloading_task_pool[task_id]) ~= nil
end

local function add_task_downloading_state(req_task_id, req_priority, multi_task_id)
  local task_submit_action
  if downloading_task_pool[req_task_id] then
    E.LOG.debug(TAG, "taskId:" .. tostring(req_task_id) .. " already in downloading_task_pool, reuse it")
    local downloading_multi_priority = downloading_task_pool[req_task_id]
    local current_max_priority = 0
    for _, priority in pairs(downloading_multi_priority) do
      if priority > current_max_priority then
        current_max_priority = priority
      end
    end
    if req_priority > current_max_priority then
      E.LOG.debug(TAG, "taskId:" .. tostring(req_task_id) .. " already in downloading_task_pool, but priority changed, update task priority, current:" .. tostring(current_max_priority) .. ", new:" .. tostring(req_priority))
      task_submit_action = "update_priority"
    else
      task_submit_action = "download_reuse"
    end
  else
    downloading_task_pool[req_task_id] = {}
    task_submit_action = "submit_new_task"
  end
  downloading_task_pool[req_task_id][multi_task_id] = req_priority
  return task_submit_action
end

function M:submit_download_list(list, file_ext, opts, submit_cb, single_cb, single_progress_cb, single_header_cb)
  local before = E.system_clock()
  local multi_task_id = self._data.multi_task:task_id_impl()
  reuse_task_id_listener_map[multi_task_id] = {
    single_cb = single_cb,
    single_progress_cb = single_progress_cb,
    single_header_cb = single_header_cb
  }
  local submit_list = {}
  local update_priority_map = {}
  for _, req_item in ipairs(list) do
    local req_task_id = req_item.taskId
    local req_priority = req_item.priority
    local submit_action = add_task_downloading_state(req_task_id, req_priority, multi_task_id)
    if "update_priority" == submit_action then
      update_priority_map[req_task_id] = req_priority
    elseif "download_reuse" == submit_action then
      self:log_debug("submit_download_list taskId:" .. tostring(req_task_id) .. " already in downloading_task_pool, reuse it")
    elseif "submit_new_task" == submit_action then
      table.insert(submit_list, req_item)
    end
  end
  local submit_cbid = 0
  if 0 == #submit_list then
    self:log_debug("submit_download_list, no task need to submit, just return")
    if submit_cb then
      submit_cb(true)
    end
  else
    self:log_debug("submit_download_list, submit_list:" .. tostring(#submit_list) .. ", cost:" .. tostring(E.system_clock() - before))
    submit_cbid = E.HTTP.submit_download_list(submit_list, file_ext, opts, submit_cb, function(task_id, info)
      local reuse_task_infos = downloading_task_pool[task_id]
      remove_task_downloading_state(task_id)
      if reuse_task_infos then
        for id, _ in pairs(reuse_task_infos) do
          local listener = reuse_task_id_listener_map[id]
          if listener and listener.single_cb then
            listener.single_cb(task_id, info)
          end
        end
      else
        self:log_warn("submit_download_list callback taskId:" .. tostring(task_id) .. ", no reuse_task_infos")
      end
    end, function(task_id, ...)
      local reuse_task_infos = downloading_task_pool[task_id]
      if reuse_task_infos then
        for id, _ in pairs(reuse_task_infos) do
          local listener = reuse_task_id_listener_map[id]
          if listener and listener.single_progress_cb then
            listener.single_progress_cb(task_id, ...)
          end
        end
      else
        self:log_warn("submit_download_list progress callback taskId:" .. tostring(task_id) .. ", no reuse_task_infos")
      end
    end, function(task_id, ...)
      local reuse_task_infos = downloading_task_pool[task_id]
      if reuse_task_infos then
        for id, _ in pairs(reuse_task_infos) do
          local listener = reuse_task_id_listener_map[id]
          if listener and listener.single_header_cb then
            listener.single_header_cb(task_id, ...)
          end
        end
      else
        self:log_warn("submit_download_list header callback taskId:" .. tostring(task_id) .. ", no reuse_task_infos")
      end
    end)
  end
  if next(update_priority_map) ~= nil then
    self:log_debug("submit_download_list update_download_priority, has priority data, now begin update:")
    E.HTTP.update_download_priority(update_priority_map, function(_succ)
      self:log_debug("update_download_priority succ:" .. tostring(_succ))
    end)
  end
  self._data.multi_submit_cbid = submit_cbid
  self:log_debug("submit_download_list, submit_cbid:" .. tostring(submit_cbid))
  return submit_cbid
end

function M:http_get(url, params, cb)
  local task_id = params.taskId
  local multi_task_id = self._data.multi_task:task_id_impl()
  local retry_task_id = "retry_" .. tostring(multi_task_id) .. "_" .. tostring(task_id)
  reuse_task_id_listener_map[retry_task_id] = {single_cb = cb}
  local retry_priority = RTM.PRIORITY.HIGH
  params.priority = retry_priority
  local submit_action = add_task_downloading_state(task_id, retry_priority, retry_task_id)
  if "update_priority" == submit_action then
    local update_priority_map = {}
    update_priority_map[task_id] = retry_priority
    self:log_debug("update_download_priority, has priority data, now begin update:")
    E.HTTP.update_download_priority(update_priority_map, function(_succ)
      self:log_debug("http_get update_download_priority succ:" .. tostring(_succ))
    end)
  elseif "download_reuse" == submit_action then
    self:log_debug("http_get retry with http get taskId:" .. tostring(task_id) .. " already in downloading_task_pool, reuse it")
  elseif "submit_new_task" == submit_action then
    E.HTTP.process_get(url, params, function(...)
      local retry_task_infos = downloading_task_pool[task_id]
      remove_task_downloading_state(task_id)
      if retry_task_infos then
        for id, _ in pairs(retry_task_infos) do
          local listener = reuse_task_id_listener_map[id]
          reuse_task_id_listener_map[id] = nil
          self:log_debug("http_get retry with http get taskId:" .. tostring(task_id) .. ", id:" .. tostring(id) .. ", listener:" .. tostring(listener))
          if listener and listener.single_cb then
            listener.single_cb(task_id, ...)
          end
        end
      else
        self:log_warn("http_get retry with http callback get taskId:" .. tostring(task_id) .. ", no reuse_task_infos")
      end
    end)
  end
end

function M:http_stop(pending_stop_task_id_list, params, cb)
  reuse_task_id_listener_map[self._data.multi_task_id] = nil
  local before = E.system_clock()
  local real_pending_stop_task_id_list = {}
  for _, tid in ipairs(pending_stop_task_id_list) do
    local has_remain_downloading_task = remove_task_downloading_state(tid, self._data.multi_task_id)
    if not has_remain_downloading_task then
      table.insert(real_pending_stop_task_id_list, tid)
    end
  end
  if 0 == #real_pending_stop_task_id_list then
    self:log_debug("http_stop, no task need to stop just return succ")
    if cb then
      cb(true)
    end
    return
  end
  params.submit_cbid = self._data.multi_submit_cbid
  params.multi_task_id = self._data.multi_task_id
  self:log_debug("http_stop, pending_stop_task_id_list:" .. tostring(#real_pending_stop_task_id_list) .. ", cost:" .. tostring(E.system_clock() - before) .. ", submit_cbid:" .. tostring(self._data.multi_submit_cbid))
  E.HTTP.stop(real_pending_stop_task_id_list, params, function(_succ)
    if _succ then
      for _, task_id in ipairs(real_pending_stop_task_id_list) do
        if not has_downloading_task(task_id) then
          E.HTTP.unregister_progress_cb(task_id, true)
        end
      end
    end
    if cb then
      cb(_succ)
    end
  end)
end

return M
