local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local CONST = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local UT = require("ejoysdk_lua.res.startup.modules.update_task")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local RDM = require("ejoysdk_lua.res.res_download_mutex")
local Task = Class:Inherit("EjoyBackgroundBaseTask")
local TAG = "EjoyBackground#BaseTask"
local _TASK_STATUS = {
  IDLE = 0,
  CHECKING = 1,
  UPDATING = 2,
  STOPPED = 3,
  FINISHED = 4,
  FAILED = 99
}

function Task:_init(ns, rk, real_rk, update_info, namespace_ext, startup_params_info, opts)
  self._res_key = rk
  self._namespace = ns
  self._real_res_key = real_rk
  E.LOG.debug(TAG, "_init res_key: " .. tostring(self._res_key) .. ", _real_res_key: " .. tostring(self._real_res_key))
  self._opts = UTILS.deepcopy(opts) or {}
  self._data = {
    update_info = update_info,
    namespace_ext = namespace_ext,
    startup_info = startup_params_info or {},
    confirm_info = {}
  }
  self._progress_info = {
    state = RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN,
    progress = {}
  }
  self._update_task = nil
  self._task_info = {}
  self._trigger = {}
  self._trigger.has_confirmed = false
  self._task_state = _TASK_STATUS.IDLE
end

local using_res_info_key = {
  "res_type",
  "pkg_res_path",
  "use_default_engine_handler",
  "pkg_project_name",
  "pkg_res_version",
  "res_save_storage_type"
}

function Task:create(listener, cb)
  self._listeners = listener
  local _using_version = UIM.get_using_version(self._namespace, self._res_key, self._opts)
  local _curr_local_res_state = RTM.static_get_local_res_state(self._namespace, self._real_res_key) or {}
  local _curr_using_res_info = _curr_local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  local _current_using_res_info = (RTM.static_get_local_res_state(self._namespace, self._res_key) or {}).using_res_info or {}
  for _, type in ipairs(using_res_info_key) do
    _current_using_res_info[type] = _current_using_res_info[type] or _curr_using_res_info[type] or self._data.startup_info[type]
  end
  _current_using_res_info.version = _using_version or ""
  _current_using_res_info.res_save_base_path = self._data.startup_info.res_save_base_path
  self._data.using_res_info = _current_using_res_info
  local patches = (self._data.update_info or {}).patches
  if UTILS.is_text_empty(_current_using_res_info.version) then
    local current_version = _curr_using_res_info.version
    if patches and next(patches) then
      for _, patch in ipairs(patches) do
        if patch.targetVersion == current_version then
          _current_using_res_info.version = current_version
          break
        end
      end
    end
  end
  if not UTILS.is_text_empty(_current_using_res_info.version) and patches and next(patches) then
    for _, patch_info in ipairs(patches) do
      if patch_info.targetVersion == _current_using_res_info.version then
        self._data.update_info.patch = patch_info
        break
      end
    end
  end
  self._data.req_params = {}
  self._data.req_params[self._namespace] = {}
  self._data.req_params[self._namespace][self._res_key] = {
    version = _current_using_res_info.version,
    res_save_base_path = _current_using_res_info.res_save_base_path,
    res_save_storage_type = _current_using_res_info.res_save_storage_type
  }
  local _listeners = {
    on_confirm_res_update = function(__res_update_info, __confirm_cb)
      E.LOG.d(TAG, {confirm_info = __res_update_info})
      __res_update_info.confirm_cb = __confirm_cb
      self._data.task_info = __res_update_info
      __confirm_cb(self._trigger.has_confirmed)
    end,
    on_res_download_progress_change_listener = function(__state, __progress_info)
      self._progress_info.state = __state
      self._progress_info.progress = __progress_info
      listener.on_res_download_progress_change_listener(self, __state, __progress_info)
    end,
    on_res_update_complete = function(__succ, ...)
      E.LOG.d(TAG, "complete:" .. tostring(__succ))
      if false == __succ then
        self._task_state = _TASK_STATUS.FAILED
      end
      if self._trigger.has_confirmed == true then
        if true == __succ then
          self._task_state = _TASK_STATUS.FINISHED
        end
        listener.on_res_update_complete(self, __succ, ...)
      elseif true == __succ then
        cb(true, self._data.task_info)
      else
        local code, msg = ...
        E.LOG.d(TAG, "complete fail, code: %s,msg: %s", tostring(code), msg or "nil")
        cb(false, code, msg)
      end
    end
  }
  local DEFAULT_ENGINE_HANDLER = require("ejoysdk_lua.res.ejoysdk_default_engine_handler")
  END.register_res_update_namespace(self._namespace, self._res_key, _listeners, self._opts, DEFAULT_ENGINE_HANDLER)
  
  function self._update_listener(_ns, _task_key, __state, _state_obj, ...)
    _state_obj = _state_obj or {}
    if _listeners.on_res_update_complete then
      if __state == UT.PUB_STATES.FINISH then
        E.LOG.d(TAG, "background finished:true")
        _listeners.on_res_update_complete(true)
      elseif __state == UT.PUB_STATES.APPLY_FAILED or __state == UT.PUB_STATES.DOWNLOAD_FAILED or __state == UT.PUB_STATES.IDLE then
        E.LOG.d(TAG, "background finished:false")
        local err_code = _state_obj.err_code
        local err_msg = _state_obj.err_msg
        _listeners.on_res_update_complete(false, err_code, err_msg)
        E.LOG.d(TAG, string.format("background fail, code: %s,msg: %s", tostring(err_code), err_msg or "nil"))
      end
    end
  end
  
  self._task_state = _TASK_STATUS.CHECKING
  self:_inner_start(function(succ, ...)
    if false == succ then
      self._task_state = _TASK_STATUS.FAILED
      cb(false, ...)
    end
  end)
end

function Task:_inner_start(cb)
  E.LOG.d(TAG, "========start_task========")
  cb = cb or function()
  end
  if self._task_state ~= _TASK_STATUS.FINISHED then
    self._task = UT:New(self._namespace, self._res_key, self._data.update_info, self._data.using_res_info, self._data.namespace_ext, self._data.req_params, self._opts, self._update_listener)
    if self._task then
      self._task_state = _TASK_STATUS.UPDATING
      E.LOG.d(TAG, "start task reset")
      self._task:reset()
      cb(true)
    end
  else
    cb(true)
    self._listeners.on_res_download_progress_change_listener(self, self._progress_info.state, self._progress_info.progress)
    self._listeners.on_res_update_complete(self, true)
  end
end

function Task:start(cb)
  self._trigger.has_confirmed = true
  self._opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_NETWORK_STRATEGY] = NS.get_strategy()
  local lock_ok, lock_err = RDM.try_acquire_download_lock()
  if not lock_ok then
    E.LOG.debug(TAG, "multi_update_tasks create lock failed: " .. tostring(lock_err))
    cb = cb or function()
    end
    local err_code = CONST.RESOURCE_UPDATE_ERROR_CODES.RES_UPDATE_MUTEX_LOCKED
    local err_msg = "Another process is updating resources"
    cb(false, err_code, err_msg)
    return
  end
  self:_inner_start(cb)
end

function Task:stop(cb)
  E.LOG.d(TAG, "========stop_task========")
  if self._task_state ~= _TASK_STATUS.FINISHED then
    if self._task then
      self._task:cancel_update(function(succ, ...)
        if true == succ then
          self._task_state = _TASK_STATUS.STOPPED
        else
          local code, msg = ...
          E.LOG.d(TAG, string.format("res_key:%s,stop code:%d,msg=%s", self._res_key, code, msg))
        end
        cb(succ, ...)
      end)
    end
  else
    cb(true)
  end
end

function Task:clean(cb)
  E.LOG.d(TAG, "========clean_task========")
  local ERMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
  local ER = require("ejoysdk_lua.res.ejoysdk_res")
  ER.repair(self._namespace, self._res_key)
  RTM.static_clear_cached_res_info(self._namespace, self._res_key)
  ERMF.clear_ejoy_res_source_model(self._namespace, self._res_key)
  if self._task then
    self._task:remove_update(function(succ, ...)
      if true == succ then
        E.LOG.d(TAG, "========clean_task========:" .. tostring(succ))
        self._task_state = _TASK_STATUS.STOPPED
      end
      cb(succ, ...)
    end)
  end
end

return Task
