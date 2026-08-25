local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local MODEL = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local BASE_TASK = require("ejoysdk_lua.res.predownload.base_task")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local NETWORK_STRATEGY = require("ejoysdk_lua.res.model.strategies.network_strategy")
local RDM = require("ejoysdk_lua.res.res_download_mutex")
local unpack = unpack or table.unpack
local M = Class:Inherit("EjoyHttpDownloadTask")
local TAG = "EjoyBackground#DownloadMgr#Groups"
local _DOWNLOAD_STATE_INDEX = {
  [MODEL.PUBLIC_DOWNLOAD_STATE.UNKNOWN] = 0,
  [MODEL.PUBLIC_DOWNLOAD_STATE.IDLE] = 1,
  [MODEL.PUBLIC_DOWNLOAD_STATE.WAITTING] = 2,
  [MODEL.PUBLIC_DOWNLOAD_STATE.SKIP] = 3,
  [MODEL.PUBLIC_DOWNLOAD_STATE.DOWNLOADING] = 4,
  [MODEL.PUBLIC_DOWNLOAD_STATE.COMPLETE] = 5,
  [MODEL.PUBLIC_DOWNLOAD_STATE.STOPPED] = 98,
  [MODEL.PUBLIC_DOWNLOAD_STATE.FAILED] = 99
}

local function _reset(self)
  self._data.res_update_infos = {}
  self._data.res_update_progress = {
    state = RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN,
    progress = {}
  }
  self._data.tasks = {
    list = {},
    running_task = nil
  }
end

function M:_init(_namespace, _res_key, _extended_group_infos, _update_info, _startup_params_info)
  self._data = {}
  self._data.namespace = _namespace
  self._data.res_key = _res_key
  self._data.extended_group_infos = _extended_group_infos
  self._data.update_info = _update_info
  self._data.startup_params_info = _startup_params_info
  self._create_params = nil
  _reset(self)
end

function M:reset(cb)
  E.LOG.d(TAG, "======reset_task======")
  _reset(self)
  self:create(self._create_params.opts, self._create_params.listeners, cb)
end

function M:create(opts, listeners, cb)
  local original_on_res_update_complete = listeners.on_res_update_complete
  
  function listeners.on_res_update_complete(succ, ...)
    RDM.release_download_lock()
    if original_on_res_update_complete then
      original_on_res_update_complete(succ, ...)
    end
  end
  
  E.LOG.d(TAG, "======create_download_task======")
  opts = UTILS.deepcopy(opts) or {}
  opts.is_v2_facade = true
  opts.foreground_notification_enabled = true
  opts.network_strategy = opts.network_strategy or NETWORK_STRATEGY.STRATEGY.BOTH_MOBILE_WIFI_NETWORK
  local NOTIF = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
  opts.default_progress_style = opts.default_progress_style or NOTIF.PROGRESS_STYLE.PROGRESS_STYLE_NO_PROGRESS
  if not self._create_params then
    self._create_params = {}
    self._create_params.listeners = listeners
    self._create_params.opts = opts
    self._create_params.callback = cb
  end
  cb = cb or function()
  end
  local _namespace = self._data.namespace
  local _res_key = self._data.res_key
  local _extended_group_infos = self._data.extended_group_infos or {}
  local _update_namespace_exts = SC.get_namespace_ext_infos()
  local _namespace_ext = _update_namespace_exts[_namespace] or {}
  local _previous_task
  
  local function _insert_task(_update_task)
    if _previous_task then
      _previous_task.__next = _update_task
    end
    _previous_task = _update_task
    table.insert(self._data.tasks.list, _update_task)
  end
  
  local _create_task_params = {}
  local _progress_info = self._data.res_update_progress
  
  local function _assemble_progress_info(_cur_task, _progress_cb)
    local _multi_state = _progress_info.state
    local _multi_progress_info = {
      [MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = _progress_info.progress[MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT],
      [MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = _progress_info.progress[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE],
      [MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = 0,
      [MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = 0,
      [MODEL.PROGRESS_INFO_KEY.PERCENT] = 0
    }
    if self._data.tasks.list and next(self._data.tasks.list) then
      local _task = self._data.tasks.list[1]
      while _task do
        local __progress_info = _task.__task_params.progress_info
        local __state = __progress_info.state
        local __progress = __progress_info.progress
        _multi_progress_info[MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = _multi_progress_info[MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] + (__progress[MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] or 0)
        _multi_progress_info[MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = _multi_progress_info[MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] + (__progress[MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] or 0)
        _task = _task.__next
      end
    end
    local _task_progress_info = _cur_task.__task_params.progress_info
    if _cur_task.__next and _progress_info.state == MODEL.PUBLIC_DOWNLOAD_STATE.COMPLETE then
      _multi_state = MODEL.PUBLIC_DOWNLOAD_STATE.DOWNLOADING
    else
      _multi_state = _task_progress_info.state
    end
    _progress_cb(_multi_state, _multi_progress_info)
  end
  
  local _task_info = self._data.res_update_infos
  
  local function _assemble_task_info(_multi_res_update_info, _new_task_info)
    if _multi_res_update_info.has_new_update == false then
      if _new_task_info.has_new_update == false then
        _multi_res_update_info.total_size = _new_task_info.total_size
        _multi_res_update_info.remain_size = _new_task_info.remain_size
        _multi_res_update_info.total_count = _new_task_info.total_count
        _multi_res_update_info.remain_count = _new_task_info.remain_count
      else
        _multi_res_update_info.total_size = 0
        _multi_res_update_info.remain_size = 0
        _multi_res_update_info.total_count = 0
        _multi_res_update_info.remain_count = 0
      end
    end
    _multi_res_update_info.has_new_update = _multi_res_update_info.has_new_update or _new_task_info.has_new_update
    if _new_task_info.has_new_update == true then
      _multi_res_update_info.total_size = (_multi_res_update_info.total_size or 0) + _new_task_info.total_size
      _multi_res_update_info.remain_size = (_multi_res_update_info.remain_size or 0) + _new_task_info.remain_size
      _multi_res_update_info.remain_count = (_multi_res_update_info.remain_count or 0) + _new_task_info.remain_count
      _multi_res_update_info.total_count = (_multi_res_update_info.total_count or 0) + _new_task_info.total_count
    end
    _multi_res_update_info.new_version = _new_task_info.new_version
    _multi_res_update_info.using_version = _new_task_info.using_version
    if _multi_res_update_info.file_list_type ~= "patch" then
      _multi_res_update_info.file_list_type = _new_task_info.file_list_type
    end
    return _multi_res_update_info
  end
  
  local _listeners = {
    on_res_download_progress_change_listener = function(__task, __state, __progress_info)
      local ___confirm_info = __task.__task_params.task_info
      local ___progress_info = __task.__task_params.progress_info
      if not ___confirm_info or not ___progress_info then
        return
      end
      if ___confirm_info.has_new_update == true and (not __task.__task_params.progress_info.progress or not next(__task.__task_params.progress_info.progress)) and __state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
        __progress_info = {
          [MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = ___confirm_info.total_count,
          [MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = ___confirm_info.total_size,
          [MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = ___confirm_info.total_count,
          [MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = ___confirm_info.total_size,
          [MODEL.PROGRESS_INFO_KEY.PERCENT] = 100
        }
      end
      E.LOG.d(TAG, string.format("multi_state2:%s", __state))
      ___progress_info.state = __state
      ___progress_info.progress = __progress_info
      _assemble_progress_info(__task, function(___state, ___progress)
        _progress_info.state = ___state
        _progress_info.progress = ___progress
        ___progress[MODEL.PROGRESS_INFO_KEY.SPEED] = __progress_info[MODEL.PROGRESS_INFO_KEY.SPEED]
        if type(___progress[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE]) == "number" and ___progress[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] > 0 then
          ___progress[MODEL.PROGRESS_INFO_KEY.PERCENT] = math.floor((___progress[MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] or 0) / ___progress[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] * 100)
          listeners.on_res_download_progress_change_listener(___state, ___progress)
        end
      end)
    end,
    on_res_update_complete = function(__task, __succ, ...)
      E.LOG.d(TAG, "========update_complete========:" .. tostring(__succ))
      if false == __succ then
        listeners.on_res_update_complete(false, ...)
      elseif __task and __task.__next and self._data.tasks.running_task then
        self._data.tasks.running_task = __task.__next
        self._data.tasks.running_task:start(function(___succ, ...)
          if false == ___succ then
            listeners.on_res_update_complete(false, ...)
          end
        end)
      else
        listeners.on_res_update_complete(__succ, ...)
      end
    end
  }
  local _create_task
  
  function _create_task(__index)
    E.LOG.d(TAG, "========create_task========:" .. tostring(__index))
    if __index <= #_create_task_params then
      local __task_params = _create_task_params[__index]
      local __namespace, __res_key, __real_res_key, __update_info, __namespace_ext, __startup_params, __opts = unpack(__task_params.params)
      local __update_task = BASE_TASK:New(__namespace, __res_key, __real_res_key, __update_info, __namespace_ext, __startup_params, __opts)
      __update_task.__task_params = __task_params
      __update_task:create(_listeners, function(succ, ...)
        E.LOG.d(TAG, "========create_task========:" .. tostring(__index) .. ",succ:" .. tostring(succ))
        if true == succ then
          local ___task_info = (...)
          if not ___task_info then
            E.LOG.e(TAG, "failed to create background task: task_info is nil")
            cb(false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.CREATE_TASK_FAIL, "task_info is nil")
            return
          end
          __task_params.task_info = ___task_info
          __task_params.progress_info = {
            state = RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN,
            progress = {}
          }
          E.LOG.d(TAG, {
            task_info = ___task_info or "nil"
          })
          _assemble_task_info(_task_info, ___task_info)
          _insert_task(__update_task)
          _create_task(__index + 1)
        else
          cb(false, ...)
        end
      end)
    else
      _progress_info.progress[MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = _task_info.total_count
      _progress_info.progress[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = _task_info.total_size
      cb(true, self._data.res_update_infos)
    end
  end
  
  for _, group_info in ipairs(_extended_group_infos) do
    local _group_name = group_info.name
    local _group_opts = group_info.opts or {}
    local _group_res_key = group_info._res_key
    local _group_real_res_key = group_info._real_res_key
    E.LOG.d(TAG, {
      _group_name = _group_name,
      _group_res_key = _group_res_key,
      _group_real_res_key = _group_real_res_key,
      startup_info = self._data.startup_params_info
    })
    table.insert(_create_task_params, {
      params = {
        _namespace,
        _group_res_key,
        _group_real_res_key,
        UTILS.deepcopy(self._data.update_info),
        _namespace_ext,
        self._data.startup_params_info,
        UTILS.merge_table(_group_opts, opts)
      }
    })
  end
  _create_task(1)
  return (self._data.info or {}).activity_id or ""
end

function M:start(cb)
  E.LOG.d(TAG, "========start_task========")
  cb = cb or function()
  end
  if self._data.tasks.list and next(self._data.tasks.list) then
    local _head_task = self._data.tasks.list[1]
    while _head_task do
      local _task_info = _head_task.__task_params.task_info
      if _task_info.has_new_update == true then
        _head_task:start(function(succ, ...)
          E.LOG.d(TAG, "========start_task========:" .. tostring(succ))
          if true == succ then
            self._data.tasks.running_task = _head_task
          else
            local code, msg = ...
            E.LOG.d(TAG, string.format("res_key:%s,stop code:%d,msg=%s", self._res_key, code, msg))
          end
          cb(succ, ...)
        end)
        return
      else
        _head_task = _head_task.__next
      end
    end
    cb(true, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.TASK_HAS_FINISHED, "all tasks have finished")
  else
    cb(false, CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES.TASK_NOT_FOUND, "task not found")
  end
end

function M:stop(cb)
  E.LOG.d(TAG, "========stop_task========")
  local _running_task = self._data.tasks.running_task
  if _running_task then
    _running_task:stop(function(succ, ...)
      E.LOG.d(TAG, "========stop_task========:" .. tostring(succ))
      if true == succ then
        self._data.tasks.running_task = nil
      end
      cb(succ, ...)
    end)
  else
    cb(true)
  end
end

function M:clean(cb)
  E.LOG.d(TAG, "========clean_task========size:" .. #(self._data.tasks.list or {}))
  if self._data.tasks.list and next(self._data.tasks.list) then
    E.LOG.d(TAG, "========clean_task_start========")
    local _succ = true
    local _ret_obj = {}
    local _clean
    
    function _clean(index)
      if index <= #self._data.tasks.list then
        local _task = self._data.tasks.list[index]
        _task:clean(function(__succ, ...)
          if false == __succ then
            local _namespace, _res_key = unpack(_task.__task_params.params)
            E.LOG.d(TAG, string.format("clean %s_%s fail", _namespace, _res_key))
            _succ = _succ and __succ
            _ret_obj = {
              ...
            }
          end
          _clean(index + 1)
        end)
      else
        cb(_succ, type(_ret_obj) == "table" and unpack(_ret_obj))
      end
    end
    
    _clean(1)
  else
    cb(true)
  end
end

function M:get_task_info()
  do return UTILS.deepcopy end
  return UTILS.deepcopy, self._data.res_update_infos
end

return M
