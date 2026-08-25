local E = require("ejoysdk_lua.ejoysdk")
local BUM = require("ejoysdk_lua.res.download_setting.background_update_manager")
local Class = require("ejoysdk_lua.ejoysdk_class")
local GROUPS_UPDATE_MGR = require("ejoysdk_lua.res.download_setting.groups_update.groups_update_manager")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local CONST = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local Task = Class:Inherit("EjoyQzGroupsUpdateTask")
local TAG = "EjoyGroupsUpdate#Task"
local _interfaces = {
  "start_task",
  "stop_task",
  "remove_task",
  "get_task_info",
  "get_task_state"
}

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
  self._data.task_state_info.download_info = {
    percent = 0,
    total_size = _task_info.remain_size
  }
  E.LOG.debug(TAG, {
    task_info = self._data.task_info
  })
end

local _task_instances = {}
local _create_task_resume_flags = {}

function M.create_task(ns, rk, card_id, groups, opts, cb)
  E.LOG.debug(TAG, "======create_task======")
  E.LOG.debug(TAG, {
    create_task_params = {card_id = card_id, groups = groups}
  })
  if not groups or not next(groups) then
    cb(false, CONST.BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_INVALID, "invalid groups")
    return
  end
  opts = opts or {}
  
  local function _create_task_inside()
    local _task = Task:New(ns, rk, groups, opts)
    _task_instances[card_id] = _task
    _task:_create_task(function(succ, ...)
      E.LOG.debug(TAG, "======create_task_cb======")
      if true == succ then
        local _wrapper_task = {}
        for _, _method in ipairs(_interfaces) do
          _wrapper_task[_method] = function(...)
            _task[_method](_task, ...)
          end
        end
        
        function _wrapper_task.set_state_change_listener(_callback)
          E.LOG.debug(TAG, "register state change_listener")
          _task._listeners.on_state_changed_listener = _callback
        end
        
        if _create_task_resume_flags[card_id] then
          E.LOG.debug(TAG, "create_task last task is downloading, now resume task, card_id: " .. tostring(card_id))
          _task:start_task({}, function()
            _create_task_resume_flags[card_id] = nil
          end)
          cb(true, _wrapper_task)
        else
          cb(true, _wrapper_task)
        end
      else
        cb(false, CONST.BACKGROUND_DOWNLOAD_ERROR_CODES.CREATE_TASK_FAIL, "create task failed")
      end
    end)
  end
  
  if _task_instances[card_id] then
    _task_instances[card_id]:get_task_state({}, function(_task_state_info)
      if _task_state_info and _task_state_info.state == BUM.TASK_UPDATE_STATE.DOWNLOADING then
        E.LOG.debug(TAG, "create_task last task is downloading, now stop task, card_id: " .. tostring(card_id))
        _task_instances[card_id]:stop_task({}, function()
          _create_task_resume_flags[card_id] = true
          _task_instances[card_id] = nil
          _create_task_inside()
        end)
      end
    end)
  else
    _create_task_inside()
  end
end

function Task:_init(ns, rk, groups, opts)
  self._namespace = ns
  self._res_key = rk
  self._groups_info = groups
  self._opts = opts
  self._mgr = GROUPS_UPDATE_MGR:New(self._namespace, self._res_key, self._groups_info) or {}
  self._data = {
    task_info = nil,
    task_state_info = {
      state = nil,
      download_info = {
        percent = 0,
        total_size = 0,
        downloading_size = 0,
        finish_count = 0,
        total_count = 0
      },
      state_info = {code = nil, msg = nil}
    }
  }
  self._listeners = {}
  E.LOG.debug(TAG, "init task with namespace:" .. tostring(ns) .. ",res_key:" .. tostring(rk) .. ",groups:")
  E.log(self._groups_info)
end

local function _task_state_change(self, state, progress_info, error_info)
  if state then
    self._data.task_state_info.state = state
  end
  if progress_info then
    self._data.task_state_info.download_info = progress_info
  end
  self._data.task_state_info.state_info = error_info or {}
  E.LOG.debug(TAG, "package:mine download_info, download state:" .. tostring(self._data.task_state_info.state) .. ",percent:" .. tostring(self._data.task_state_info.download_info.percent))
  if type(self._listeners.on_state_changed_listener) == "function" then
    self._listeners.on_state_changed_listener(self._data.task_state_info)
  end
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
    on_confirm_res_update = function(res_update_info, confirm_cb)
      E.LOG.debug(TAG, "======on_confirm_res_update======")
      E.LOG.debug(TAG, {res_update_info = res_update_info})
      confirm_cb(true)
    end,
    on_res_download_progress_change_listener = function(state, progress_info)
      E.LOG.debug(TAG, "======on_res_download_progress_change_listener======")
      E.LOG.debug(TAG, {state = state, progress_info = progress_info})
      local _progress_info = progress_info or self._data.task_state_info.download_info
      if state == RTM.DOWNLOAD_STATE.COMPLETE and progress_info.percent < 100 then
        _progress_info.percent = 100
        _progress_info.downloading_size = _progress_info.total_size
        _progress_info.finish_count = _progress_info.total_count
      end
      _task_state_change(self, _state_map[state] or self._data.task_state_info.state, _progress_info, nil)
    end,
    on_res_apply_progress_change_listener = function(state, progress_info)
      E.LOG.debug(TAG, "apply state:" .. tostring(state) .. ",percent:" .. tostring(progress_info.percent))
    end,
    on_res_update_complete = function(succ, ...)
      E.LOG.debug(TAG, "======on_res_update_complete======" .. tostring(succ))
      E.log(...)
      local _state, _error_info
      local _progress_info = self._data.task_state_info.download_info or {}
      if true == succ then
        _state = BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE
        _progress_info.percent = 100
        _progress_info.downloading_size = self._data.task_state_info.download_info.total_size
        _progress_info.finish_count = _progress_info.total_count
      else
        local _code, _msg = ...
        _state = BUM.TASK_UPDATE_STATE.DOWNLOAD_FAILED
        E.LOG.debug(TAG, string.format("code:%s,msg=%s", tostring(_code or "nil"), _msg or "nil"))
        _error_info = {code = _code, msg = _msg}
      end
      _task_state_change(self, _state, _progress_info, _error_info)
    end
  }
  self._data.res_id = self._mgr:create(self._opts, _listener, function(succ, ...)
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
  E.LOG.debug(TAG, "======start_task======")
  E.LOG.debug(TAG, {
    task_data = self._data
  })
  if self._data.task_state_info.state ~= BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
    _task_state_change(self, BUM.TASK_UPDATE_STATE.DOWNLOADING)
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
  E.LOG.debug(TAG, "======stop_task======")
  self._mgr:stop(function(succ, ...)
    E.LOG.debug(TAG, "groups_update_mgr stop result:" .. tostring(succ))
    E.log(...)
    _task_state_change(self, BUM.TASK_UPDATE_STATE.DOWNLOAD_STOPPED)
    cb(succ, ...)
  end)
end

function Task:remove_task(_params, cb)
  E.LOG.debug(TAG, "======remove_task======")
  self._mgr:cancel(function(succ, ...)
    E.LOG.debug(TAG, "groups_update_mgr cancel result:" .. tostring(succ))
    E.log(...)
    if true == succ then
      self._mgr:reset(function(_succ, ...)
        if true == _succ then
          local _task_info = (...)
          _init_task_info(self, _task_info)
          E.LOG.debug(TAG, {reset_task_info = _task_info})
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
    E.LOG.debug(TAG, {
      get_task_info = self._data.task_info
    })
    cb({
      task_info = self._data.task_info
    })
  end
end

function Task:get_task_state(_params, cb)
  if type(cb) == "function" then
    E.LOG.debug(TAG, {
      get_task_state = self._data.task_state_info
    })
    cb(self._data.task_state_info)
  end
end

return M
