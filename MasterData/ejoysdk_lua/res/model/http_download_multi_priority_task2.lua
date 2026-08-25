local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local TASK2 = require("ejoysdk_lua.res.model.http_download_multi_task2")
local PRIORITY_MGR = require("ejoysdk_lua.res.model.strategies.ejoy_download_priority_task_manager")
local TAG = "MULTI_DOWNLOAD_PRIORITY_TASK"
local M = Class:Inherit("EjoyHttpDownloadMultiPriorityTask2")

function M:_init(_task_id, _file_list, _file_ext, _opts, params, _model_instance, _single_model)
  E.LOG.d(TAG, "model_name2:" .. _model_instance:get_model_name())
  params = params or {}
  
  local function default_cb()
  end
  
  local _origin_download_state_listener = params.download_state_listener or default_cb
  local _origin_download_progress_listener = params.download_progress_listener or default_cb
  
  function params.download_state_listener(_state, _state_obj)
    E.LOG.d(TAG .. "_listener_state", {state = _state})
    _origin_download_state_listener(_state, _state_obj)
    if self._listeners and type(self._listeners.download_state_listener) == "function" then
      self._listeners.download_state_listener(_state, _state_obj)
    end
  end
  
  function params.download_progress_listener(progress_info)
    _origin_download_progress_listener(progress_info)
    if self._listeners and type(self._listeners.download_progress_listener) == "function" then
      self._listeners.download_progress_listener(progress_info)
    end
  end
  
  local _origin_task = TASK2:New(_task_id, _file_list, _file_ext, _opts, params, _model_instance, _single_model)
  self._origin_task = _origin_task
  setmetatable(self, {
    __index = function(_, key)
      local _proxy = M[key]
      if _proxy then
        return _proxy
      end
      local _caller = _origin_task[key]
      if type(_caller) == "function" then
        return function(_, ...)
          do return _caller, _origin_task, ... end
          return _caller, _origin_task, ...
        end
      else
        return _caller
      end
    end
  })
  self._data.priority = _opts.priority or PRIORITY_MGR.DOWNLOAD_PRIORITY.NORMAL
  self._data.sub_priority = _opts.sub_priority or PRIORITY_MGR.DOWNLOAD_DEFAULT_SUB_PRIORITY
  self._data.auto_start = true
end

function M:start_download_impl()
  self._data.auto_start = true
  PRIORITY_MGR.update_task(self)
end

function M:stop_download_impl(cb, stop_reason)
  PRIORITY_MGR.stop_download(self, cb, stop_reason)
end

function M:remove_download_impl(cb)
  PRIORITY_MGR.remove_download(self, cb)
end

function M:pause_download_impl(cb, stop_reason)
  PRIORITY_MGR.pause_download(self, cb, stop_reason)
end

function M:get_task()
  return self._origin_task
end

function M:priority()
  return self._data.priority
end

function M:sub_priority()
  return self._data.sub_priority
end

function M:register_download_listeners(listeners)
  self._listeners = listeners
end

function M:update_download_config(config)
  E.LOG.d(TAG, {update_config = config})
  local _priority = self:priority()
  local _sub_priority = self:sub_priority()
  if type(config.priority) == "number" and _priority ~= config.priority or type(config.sub_priority) == "number" and _sub_priority ~= config.sub_priority then
    self._data.priority = config.priority or _priority
    self._data.sub_priority = config.sub_priority or _sub_priority
    PRIORITY_MGR.update_task(self)
  end
  self._origin_task:update_download_config(config)
end

return M
