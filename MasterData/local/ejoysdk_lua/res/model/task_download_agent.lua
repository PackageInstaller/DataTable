local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local SF = require("ejoysdk_lua.res.model.strategies.strategy_factory")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local TM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local TAG = "EjoyDownloadStrategyAgent"
local M = Class:Inherit(TAG)
local AGENT_MAX_RETRY_TIMES = 10
M.AGENT_STATE = {
  UNKNOWN = TM.PUBLIC_DOWNLOAD_STATE.UNKNOWN,
  IDLE = TM.PUBLIC_DOWNLOAD_STATE.IDLE,
  FAILED = TM.PUBLIC_DOWNLOAD_STATE.FAILED,
  DOWNLOADING = TM.PUBLIC_DOWNLOAD_STATE.DOWNLOADING,
  COMPLETE = TM.PUBLIC_DOWNLOAD_STATE.COMPLETE,
  WATTING = "waitting"
}

function M:_init(task, strategy_name, state_listener)
  local strategy_processor = SF.get_strategy_processor(strategy_name)
  E.LOG.debug(TAG, "create agent begin:" .. tostring(strategy_name) .. ", strategy_processor:" .. tostring(type(strategy_processor)) .. ", task_id:" .. tostring(task:task_id()))
  local task_model_name = task:task_info().model_name
  local task_tag = task:task_tag_name()
  self._data = {
    task = task,
    task_tag = task:task_tag_name(),
    task_model_name = task_model_name,
    strategy_name = strategy_name,
    strategy_processor = strategy_processor,
    state_listener = state_listener,
    state = M.AGENT_STATE.UNKNOWN,
    state_info = {}
  }
  
  function self._data.strategy_state_change_listener(strategy_satisfied)
    self:_on_strategy_state_changed(strategy_satisfied)
  end
  
  function self._data.download_state_change_listener(model_name, tag, state_obj)
    if model_name ~= task_model_name or tag ~= task_tag then
      return
    end
    self:_on_download_state_changed(state_obj)
  end
end

function M:update_strategy(strategy_name)
  local strategy_processor = SF.get_strategy_processor(strategy_name)
  if not strategy_processor then
    E.LOG.warn(TAG, "update_strategy skip, strategy_name not find strategy")
    return
  end
  if strategy_name ~= self._data.strategy_name then
    E.LOG.debug(TAG, "update_strategy:" .. tostring(strategy_name))
    self._data.strategy_name = strategy_name
    self._data.strategy_processor = strategy_processor
    self._data.strategy_processor.register_state_change_listener(self._data.strategy_state_change_listener, strategy_name)
  else
    E.LOG.warn(TAG, "update_strategy skip, strategy name not changes:" .. tostring(strategy_name))
  end
end

function M:_on_strategy_state_changed(strategy_satisfied)
  if not self._data.task then
    E.LOG.debug(TAG, "task has complete or failed, should not notify network state change")
    return
  end
  if strategy_satisfied then
    E.LOG.debug(TAG, "receive strategy state satisfied, now start download")
    self._data.task:start_download()
  else
    E.LOG.warn(TAG, "received strategy not satisfied, now stop download")
    self._data.task:stop_download()
  end
end

function M:_on_download_state_changed(state_obj)
  local state = state_obj.state
  if state == TM.DOWNLOAD_STATE.STOPPED then
    state = M.AGENT_STATE.WATTING
    E.LOG.debug(TAG, "task enter waitting state, current strategy:" .. tostring(self._data.strategy_name) .. ", strategy state:" .. tostring(self._data.strategy_processor.tostring()))
  end
  self._data.state = state
  local state_info = EU.deepcopy(state_obj)
  state_info.state = state
  self._data.state_info = state_info
  if self._data.state_listener then
    self._data.state_listener(state, state_info)
  end
  _ejoysdk.log("_on_download_state_changed:" .. tostring(state) .. ", code:" .. tostring(state_obj.err_code) .. ", msg:" .. tostring(state_obj.err_msg) .. ", tid:" .. tostring(self._data.task:task_id()))
  if state == TM.PUBLIC_DOWNLOAD_STATE.COMPLETE or state == TM.PUBLIC_DOWNLOAD_STATE.FAILED then
    E.LOG.debug(TAG, "task is complete or failed, now begin close agent")
    self:close()
  end
end

function M:open()
  E.LOG.debug(TAG, "agent open received")
  local _properties = self._data.task:get_download_properties()
  self._data.origin_max_retry_times = _properties.max_retry_times
  self._data.task:update_download_properties({max_retry_times = AGENT_MAX_RETRY_TIMES})
  ET.subscribe(ET.download.DOWNLOAD_MULTI_TASK_STATE_CHANGED, self._data.download_state_change_listener)
  local state_obj = self._data.task:get_download_state(true)
  self:_on_download_state_changed(state_obj)
  if self._data.task then
    local strategy_name = self._data.strategy_name
    self._data.strategy_processor.register_state_change_listener(self._data.strategy_state_change_listener, strategy_name)
  end
end

function M:close(cb)
  E.LOG.debug(TAG, "agent close received")
  if self._data.task == nil then
    E.LOG.debug(TAG, "already closed.")
    if cb then
      cb(true)
    end
    return
  end
  if self._data.origin_max_retry_times then
    self._data.task:update_download_properties({
      max_retry_times = self._data.origin_max_retry_times
    })
  end
  ET.unsubscribe(ET.download.DOWNLOAD_MULTI_TASK_STATE_CHANGED, self._data.download_state_change_listener)
  self._data.strategy_processor.unregister_state_change_listener(self._data.strategy_state_change_listener)
  self._data.task:stop_download(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "close succ")
    else
      local code, msg = ...
      E.LOG.warn(TAG, "close failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    self._data.task = nil
    self._data.state_listener = nil
    if cb then
      cb(succ, ...)
    end
  end)
end

return M
