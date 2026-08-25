local E = require("ejoysdk_lua.ejoysdk")
local BUM = require("ejoysdk_lua.res.download_setting.background_update_manager")
local Class = require("ejoysdk_lua.ejoysdk_class")
local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local Task = Class:Inherit("EjoyQzPreDownloadTask")
local TAG = "EjoyPredownload#Task"
local _interfaces = {
  "start_task",
  "stop_task",
  "remove_task",
  "get_task_info",
  "get_task_state"
}

function M.create_task(ns, rk, groups, opts, listeners, cb)
  E.LOG.d(TAG, "======create_task======")
  local FACADE = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  if FACADE.is_splitpkg_res_complete() ~= true then
    cb(false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.SPLIT_NOT_COMPLETE, "splited-res is not ready yet")
    return
  end
  if true == M._is_initing then
    cb(false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.TASK_IN_INIT, "a task has been created")
    return
  end
  local _task = Task:New(ns, rk, groups, opts, listeners)
  M._is_initing = true
  _task:_create_task(function(succ, ...)
    E.LOG.d(TAG, "======create_task_cb======" .. tostring(succ))
    if true == succ then
      local _wrapper_task = {}
      for _, _method in ipairs(_interfaces) do
        _wrapper_task[_method] = function(...)
          _task[_method](_task, ...)
        end
      end
      
      function _wrapper_task.set_state_change_listener(_callback)
        E.LOG.d(TAG, "register state change_listener")
        _task._listeners.on_state_changed_listener = _callback
      end
      
      cb(true, _wrapper_task)
    else
      cb(false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.CREATE_TASK_FAIL, "create task failed")
    end
    M._is_initing = false
  end)
end

function Task:_init(ns, rk, groups, opts, listeners, cb)
  self._namespace = ns
  self._res_key = rk
  self._groups_info = groups
  self._opts = opts
  self._callback = cb
  self._mgr = PREDOWNLOAD_MGR.static_get_mgr(self._namespace, self._res_key) or {}
  self._data = {}
  self._data.task_info = {}
  self._data.download_info = {
    state = BUM.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED,
    download_info = {}
  }
  self._listeners = listeners or {}
end

local function _task_state_change(self, state, progress_info, state_info)
  if state then
    self._data.download_info.state = state
  end
  if progress_info then
    self._data.download_info.download_info = progress_info
  end
  self._data.download_info.state_info = state_info or {}
  E.LOG.d(TAG, string.format("download state:%s,downloading_size:%s,percent:%s", tostring(self._data.download_info.state), tostring(self._data.download_info.download_info.downloading_size), tostring(self._data.download_info.download_info.percent)))
  if type(self._listeners.on_state_changed_listener) == "function" then
    self._listeners.on_state_changed_listener(self._data.download_info)
  end
end

local function _init_task_info(self, _task_info)
  self._data.task_info = {
    namespace = self._namespace,
    res_key = self._res_key,
    res_id = self._data.res_id,
    res_version = _task_info.new_version,
    current_version = _task_info.using_version,
    has_new_update = _task_info.has_new_update,
    total_size = _task_info.total_size,
    remain_size = _task_info.remain_size
  }
  E.LOG.d(TAG, {
    res_update_info2 = self._data.task_info
  })
  self._data.download_info.download_info = {
    percent = 0,
    total_size = _task_info.remain_size
  }
end

function Task:_create_task(cb)
  local _state_map = {
    [RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE] = BUM.TASK_UPDATE_STATE.APPLYING,
    [RTM.PUBLIC_DOWNLOAD_STATE.FAILED] = BUM.TASK_UPDATE_STATE.DOWNLOAD_FAILED,
    [RTM.PUBLIC_DOWNLOAD_STATE.DOWNLOADING] = BUM.TASK_UPDATE_STATE.DOWNLOADING,
    [RTM.PUBLIC_DOWNLOAD_STATE.WAITTING] = BUM.TASK_UPDATE_STATE.DOWNLOAD_WAITING,
    [RTM.PUBLIC_DOWNLOAD_STATE.STOPPED] = BUM.TASK_UPDATE_STATE.DOWNLOAD_STOPPED,
    [RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN] = BUM.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED
  }
  local _listener = {
    on_res_download_progress_change_listener = function(state, progress_info)
      _task_state_change(self, _state_map[state] or self._data.download_info.state, progress_info or self._data.download_info.progress_info)
    end,
    on_res_apply_progress_change_listener = function(state, progress_info)
      E.LOG.d(TAG, "apply state:" .. tostring(state) .. ",percent:" .. tostring(progress_info.percent))
    end,
    on_res_update_complete = function(succ, ...)
      E.LOG.d(TAG, "======on_res_update_complete======" .. tostring(succ))
      local _state, _state_info
      if true == succ then
        _state = BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE
      else
        local _code, _msg = ...
        _state = BUM.TASK_UPDATE_STATE.DOWNLOAD_FAILED
        E.LOG.d(TAG, string.format("code:%s,msg=%s", tostring(_code or "nil"), _msg or "nil"))
        _state_info = {code = _code, msg = _msg}
      end
      _task_state_change(self, _state, nil, _state_info)
    end,
    on_request_groups_filter = (self._listeners or {}).on_request_groups_filter
  }
  E.LOG.d(TAG, "======create_task======")
  self._data.res_id = self._mgr:create(self._groups_info, self._opts, _listener, function(succ, ...)
    if true == succ then
      local _task_info = (...)
      _init_task_info(self, _task_info)
      cb(true, self._data.task_info and true == self._data.task_info.has_new_update or false)
    else
      cb(false, ...)
    end
  end)
end

function Task:start_task(_params, cb)
  E.LOG.d(TAG, "======start_task======")
  if self._data.download_info.state ~= BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
    _task_state_change(self, BUM.TASK_UPDATE_STATE.WAITTING)
    self._mgr:start(function(succ, ...)
      if true ~= succ then
        _task_state_change(self, BUM.TASK_UPDATE_STATE.DOWNLOAD_FAILED)
      end
      if type(cb) == "function" then
        cb(succ, ...)
      end
    end)
  else
    cb(true)
  end
end

function Task:stop_task(_params, cb)
  E.LOG.d(TAG, "======stop_task======")
  self._mgr:stop(function(succ, ...)
    _task_state_change(self, BUM.TASK_UPDATE_STATE.DOWNLOAD_STOPPED)
    cb(succ, ...)
  end)
end

function Task:remove_task(_params, cb)
  E.LOG.d(TAG, "======remove_task======")
  self._mgr:cancel(function(succ, ...)
    if true == succ then
      self._mgr:reset(function(_succ, ...)
        if true == _succ then
          local _task_info = (...)
          _init_task_info(self, _task_info)
          E.LOG.d(TAG, {reset_task_info = _task_info})
        else
          local __download_info = (self._data.download_info or {}).download_info or {}
          __download_info.percent = 0
          __download_info.downloading_size = 0
          __download_info.finish_count = 0
        end
        _task_state_change(self, BUM.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED, (self._data.download_info or {}).download_info)
        cb(true)
      end)
    else
      cb(succ, ...)
    end
  end)
end

function Task:get_task_info(_params, cb)
  if type(cb) == "function" then
    E.LOG.d(TAG, {
      get_task_info = self._data.task_info
    })
    cb({
      task_info = self._data.task_info
    })
  end
end

function Task:get_task_state(_params, cb)
  if type(cb) == "function" then
    E.LOG.d(TAG, {
      get_task_state = self._data.download_info
    })
    cb(self._data.download_info)
  end
end

return M
