local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local Class = require("ejoysdk_lua.ejoysdk_class")
local bitutil = compat.bitutil
local ORDERED_QUEUE = Class:Inherit("OrderedTaskQueue")
local PRIORITY_QUEUE = Class:Inherit("PriorityTaskQueue")
local TAG = "DOWNLOAD_PRIORITY_MGR"
local _current_task_info
local PRIORITY = {
  IMMEDIATE = 99,
  CRITICAL = RTM.RES_PRIORITY.CRITICAL,
  HIGH = RTM.RES_PRIORITY.HIGH,
  NORMAL = RTM.RES_PRIORITY.NORMAL,
  LOW = RTM.RES_PRIORITY.LOW,
  BACKGROUND = RTM.RES_PRIORITY.BACKGROUND,
  MINIMUM = -99
}
local DEFAULT_SUB_PRIORITY = 1

local function _calc_priority(task)
  do return bitutil.bor, (bitutil.lshift(task:priority() or PRIORITY.NORMAL, 24)) end
  return bitutil.bor, bitutil.lshift(task:priority() or PRIORITY.NORMAL, 24), task:sub_priority() or DEFAULT_SUB_PRIORITY, task
end

function ORDERED_QUEUE:_init(queue_name)
  self.name = queue_name
  self.queue = {}
  self._next = nil
end

function ORDERED_QUEUE:_findInsertPosition(_start, _end, _task_priority)
  local _left = _start or 1
  local _right = _end or #self.queue + 1
  while _left < _right do
    local _mid = math.floor((_left + _right) / 2)
    if _task_priority <= self.queue[_mid].priority then
      _left = _mid + 1
    else
      _right = _mid
    end
  end
  return _left
end

function ORDERED_QUEUE:insert(task)
  local _task_priority = _calc_priority(task)
  local _start_index = 1
  local _end_index = #self.queue + 1
  local _pos = self:_findInsertPosition(_start_index, _end_index, _task_priority)
  E.LOG.d(TAG, "insert task:" .. task:task_id_impl() .. ",queuename:" .. self.name)
  table.insert(self.queue, _pos, {priority = _task_priority, task = task})
  E.LOG.d(TAG, "insert task:" .. task:task_id_impl() .. ",priority:" .. tostring(_task_priority))
end

function PRIORITY_QUEUE:_init()
  self._queues = {}
  self._head = nil
  local _priority_keys = {}
  for _, priority in pairs(PRIORITY) do
    local _queue = ORDERED_QUEUE:New(tostring(priority))
    self._queues[priority] = _queue
    table.insert(_priority_keys, priority)
  end
  table.sort(_priority_keys, function(a, b)
    return b < a
  end)
  local _current_queue
  for _, _p in ipairs(_priority_keys) do
    local _queue = self._queues[_p]
    if _current_queue then
      _current_queue._next = _queue
    else
      self._head = _queue
    end
    _current_queue = _queue
  end
end

function PRIORITY_QUEUE:_findIfExist(_task_id, _task_priority)
  local _priority = bitutil.rshift(_task_priority, 24)
  E.LOG.d(TAG, "find exists priority:" .. tostring(_priority))
  local _queue = (self._queues[_priority] or {}).queue
  E.LOG.d(TAG, "priority queue size :" .. #(_queue or {}))
  for _index = #(_queue or {}), 1, -1 do
    local _task = (_queue[_index] or {}).task
    E.LOG.d(TAG, "find exists task:" .. tostring(_task:task_id_impl()))
    if _task:task_id_impl() == _task_id then
      return _queue, _index
    end
  end
  return nil, -1
end

function PRIORITY_QUEUE:insert(task)
  if task then
    local _priority = task:priority()
    local _queue = self._queues[_priority]
    if _queue then
      _queue:insert(task)
      self:_test_dump_queue()
    end
  end
end

function PRIORITY_QUEUE:removeIfExists(task, _pre_task_priority)
  if not task then
    return
  end
  local _task_id = task:task_id_impl()
  local _queue, _location = self:_findIfExist(_task_id, _pre_task_priority)
  if _queue and _location > 0 then
    do return table.remove, _queue end
    return table.remove, _queue, _location
  end
  return nil
end

function PRIORITY_QUEUE:peek(delete)
  local _p = self._head
  while _p do
    for _i, _task_info in ipairs(_p.queue) do
      if _task_info.task._data.auto_start == true then
        if true == delete then
          table.remove(_p.queue, _i)
        end
        return _task_info
      end
    end
    _p = _p._next
  end
  return nil
end

function PRIORITY_QUEUE:_test_dump_queue()
  local str = "current task:"
  if _current_task_info and _current_task_info.task then
    str = str .. _current_task_info.task:task_id_impl()
  end
  str = str .. [[

task list:]]
  local _p = self._head
  while _p do
    for _, task_info in pairs(_p.queue) do
      str = str .. [[

->]] .. task_info.task:task_id_impl() .. "(" .. _p.name .. ")"
    end
    _p = _p._next
  end
  E.LOG.d(TAG .. "_dump", "dump list:" .. str)
end

local _task_queue = PRIORITY_QUEUE:New()
local _task_pool = {}
local M = {}
M.DOWNLOAD_PRIORITY = PRIORITY
M.DOWNLOAD_DEFAULT_SUB_PRIORITY = DEFAULT_SUB_PRIORITY
local _start_download

local function _next_task()
  M._test_dump_queue()
  E.LOG.d(TAG, "next task")
  if not _current_task_info then
    E.LOG.d(TAG, "current task is nil")
    local _task_info = _task_queue:peek(true)
    if _task_info and _task_info.task then
      _current_task_info = _task_info
      local _task = _current_task_info.task
      E.LOG.d(TAG, "start download task:" .. _task:task_id_impl())
      _start_download(_task)
    end
  end
end

local function _is_task_exists(task_id)
  return nil ~= _task_pool[task_id]
end

local function _compare_task_priority(task_1, task_2)
  if not task_1 or not task_2 then
    if not task_1 and task_2 then
      return -1
    elseif task_1 and not task_2 then
      return 1
    else
      return 0
    end
  end
  
  local function __calc(num_1, num_2)
    if num_1 == num_2 then
      return 0
    else
      return num_2 < num_1 and 1 or -1
    end
  end
  
  do return __calc, _calc_priority(task_1), _calc_priority(task_2) end
  return __calc, _calc_priority(task_1), _calc_priority(task_2)
end

local function _insert_task(task)
  local function __insert_op(_task, _running_task, _cb)
    local c_priority = _compare_task_priority(_task, _running_task)
    
    local should_pause = c_priority > 0 and nil ~= _running_task
    if should_pause then
      local function _pause_cb(succ, ...)
        if true == succ then
          E.LOG.d(TAG, "pause download succ,task:" .. _running_task:task_id_impl())
        end
      end
      
      M.pause_download(_running_task, _pause_cb, "task has been preempted")
    end
    return should_pause
  end
  
  local _current_task = _current_task_info and _current_task_info.task
  if _current_task ~= task then
    _task_queue:insert(task)
    _task_pool[task:task_id_impl()] = _calc_priority(task)
    __insert_op(task, _current_task)
  else
    local _top_task = _task_queue:peek()
    if _top_task then
      __insert_op(_top_task.task, _current_task)
    end
    return
  end
end

local function _update_task(task)
  local _task_id = task:task_id_impl()
  E.LOG.d(TAG, "try to remove task:" .. tostring(_task_id) .. ",priority:" .. tostring(_task_pool[_task_id]))
  if _task_queue:removeIfExists(task, _task_pool[_task_id]) then
    E.LOG.d(TAG, "remove exists task:" .. task:task_id_impl())
  end
  _insert_task(task)
end

local _download_listeners = {
  download_state_listener = function(_task, _state, _state_obj)
    E.LOG.d(TAG, string.format("state_change, task_id:%s,state:%s,tag:%s", _task:task_id_impl(), _state, _state_obj.tag))
    if _state == RTM.PUBLIC_DOWNLOAD_STATE.STOPPED or _state == RTM.PUBLIC_DOWNLOAD_STATE.WAITTING or _state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE or _state == RTM.PUBLIC_DOWNLOAD_STATE.FAILED then
      local _current_task = (_current_task_info or {}).task
      if _current_task and _current_task == _task then
        _current_task_info = nil
        if _state == RTM.PUBLIC_DOWNLOAD_STATE.WAITTING then
          _update_task(_current_task)
        else
          _task_pool[_current_task:task_id_impl()] = nil
        end
      end
      _next_task()
    end
  end,
  download_progress_listener = function(_task, _progress_info)
  end
}

function M.update_task(task)
  if not task then
    return
  end
  task:register_download_listeners({
    download_state_listener = function(...)
      _download_listeners.download_state_listener(task, ...)
    end,
    download_progress_listener = function(...)
      _download_listeners.download_progress_listener(task, ...)
    end
  })
  local _task_id = task:task_id_impl()
  if _task_id and _task_pool[_task_id] then
    E.LOG.d(TAG, "update task:" .. _task_id)
    _update_task(task)
  else
    _insert_task(task)
  end
  _next_task()
end

function _start_download(proxy_task, ...)
  E.LOG.d(TAG, "call start_download:" .. proxy_task:task_id_impl())
  proxy_task:get_task():start_download_impl()
end

local function _clean_unuse_task(proxy_task)
  if _current_task_info and proxy_task ~= _current_task_info.task then
    local _task_id = proxy_task:task_id_impl()
    local _remove_task = _task_queue:removeIfExists(proxy_task, _task_pool[_task_id])
    if _remove_task then
      _task_pool[_task_id] = nil
    end
  end
end

function M.stop_download(proxy_task, ...)
  E.LOG.d(TAG, "call stop_download:" .. proxy_task:task_id_impl())
  proxy_task:get_task():stop_download_impl(...)
  _clean_unuse_task(proxy_task)
  M._test_dump_queue()
end

function M.remove_download(proxy_task, ...)
  E.LOG.d(TAG, "call remove_download:" .. proxy_task:task_id_impl())
  proxy_task:get_task():remove_download_impl(...)
  _clean_unuse_task(proxy_task)
  M._test_dump_queue()
end

function M.pause_download(proxy_task, ...)
  E.LOG.d(TAG, "call pause_download:" .. proxy_task:task_id_impl())
  proxy_task:get_task():pause_download_impl(...)
  if _current_task_info and proxy_task ~= _current_task_info.task then
    proxy_task._data.auto_start = false
  end
  M._test_dump_queue()
end

function M._test_dump_queue()
  _task_queue:_test_dump_queue()
end

return M
