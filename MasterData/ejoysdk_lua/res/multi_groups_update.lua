local E = require("ejoysdk_lua.ejoysdk")
local MODEL = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local unpack = unpack or table.unpack
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("MULTI_GROUPS")
local TAG = "MultiUpdates"
local MAX_STACK_DEPTH = 30
local _DOWNLOAD_STATE_INDEX = {
  [MODEL.PUBLIC_DOWNLOAD_STATE.UNKNOWN] = 0,
  [MODEL.PUBLIC_DOWNLOAD_STATE.IDLE] = 1,
  waitting = 2,
  [MODEL.PUBLIC_DOWNLOAD_STATE.SKIP] = 3,
  [MODEL.PUBLIC_DOWNLOAD_STATE.DOWNLOADING] = 4,
  [MODEL.PUBLIC_DOWNLOAD_STATE.COMPLETE] = 5,
  [MODEL.PUBLIC_DOWNLOAD_STATE.STOPPED] = 98,
  [MODEL.PUBLIC_DOWNLOAD_STATE.FAILED] = 99
}
local _PROCESS_STATE = {
  CHECKING = 1,
  CONFIRMING = 2,
  DOWNLOADING = 3,
  PATCHING = 4,
  APPLYING = 5
}
M.DOWNLOAD_STATE_INDEX = _DOWNLOAD_STATE_INDEX
M.PROCESS_STATE = _PROCESS_STATE

function M:_init()
  self._confirm_update_index = 0
  self._complete_update_index = 0
  self._confirm_patch_index = 0
  self._confirm_apply_index = 0
  self._update_group_infos = {}
  self._process_state = _PROCESS_STATE.CHECKING
  self._update_res_info = {}
  self._has_update_completed = false
  self._download_state = MODEL.PUBLIC_DOWNLOAD_STATE.IDLE
  self._apply_state = RTM.APPLY_STATE.IDLE
  self._download_progress = {}
  self._apply_progress = {}
  self._outer_listeners = {}
  self._download_state = MODEL.PUBLIC_DOWNLOAD_STATE.IDLE
  self._apply_state = RTM.APPLY_STATE.IDLE
  self._confirm_update_info = {}
  self._need_update_count = 0
  self._need_patch_count = 0
  self._global_result = {succ = true, data = nil}
end

local function _res_confirm_next(self, result, ...)
  self._confirm_update_index = self._confirm_update_index + 1
  E.LOG.d(TAG, "confirm res update:" .. tostring(self._confirm_update_index))
  if self._confirm_update_index <= #self._update_group_infos then
    local res_info = self._update_group_infos[self._confirm_update_index]
    E.LOG.d(TAG, "confirm group update:" .. res_info.name)
    if type(res_info.on_confirm_res_update) == "function" then
      if false == result then
        res_info.has_confirmed = false
      end
      E.LOG.d(TAG, "confirm group update:" .. tostring(res_info.has_confirmed) .. ",result=" .. tostring(result))
      if 0 == self._confirm_update_index % MAX_STACK_DEPTH then
        E.Timer.once(0, function()
          res_info.on_confirm_res_update(res_info.has_confirmed)
        end)
      else
        res_info.on_confirm_res_update(res_info.has_confirmed)
      end
    end
  end
end

local _res_patch_next, _res_apply_next, __res_update_complete

local function __res_patch_next(self, result)
  E.LOG.d(TAG, "confirm patch update:" .. tostring(self._confirm_patch_index) .. ",complete_index:" .. tostring(self._complete_update_index) .. ",total:" .. tostring(#self._update_group_infos) .. ",state:" .. tostring(self._process_state))
  if self._confirm_patch_index + self._complete_update_index >= #self._update_group_infos or self._process_state == _PROCESS_STATE.PATCHING then
    local __confirm_patch
    
    function __confirm_patch()
      self._confirm_patch_index = self._confirm_patch_index + 1
      
      local function ___inner_confirm_patch()
        if self._confirm_patch_index <= #self._update_group_infos then
          local task = self._update_group_infos[self._confirm_patch_index] or {}
          if task.has_completed == true then
            E.LOG.d(TAG, "task has completed, skip to patch")
            __confirm_patch()
          elseif type(task.on_confirm_res_patch) == "function" then
            E.LOG.d(TAG, "patching index:" .. tostring(self._confirm_patch_index))
            task.on_confirm_res_patch()
          end
        end
      end
      
      if 0 == self._confirm_patch_index % MAX_STACK_DEPTH then
        E.Timer.once(0, function()
          ___inner_confirm_patch()
        end)
      else
        ___inner_confirm_patch()
      end
    end
    
    if self._process_state ~= _PROCESS_STATE.PATCHING then
      self._confirm_patch_index = 0
      self._process_state = _PROCESS_STATE.PATCHING
      if type(self._outer_listeners.on_confirm_res_patch) == "function" then
        E.LOG.d(TAG, "confirm patch update in confirm")
        self._outer_listeners.on_confirm_res_patch(__confirm_patch)
        return
      end
    end
    __confirm_patch()
  else
    _res_confirm_next(self, false ~= result)
  end
end

local function __res_apply_next(self, result)
  E.LOG.d(TAG, "confirm apply update:" .. tostring(self._confirm_apply_index) .. ",complete_index:" .. tostring(self._complete_update_index) .. ",state:" .. tostring(self._process_state))
  if self._confirm_apply_index + self._complete_update_index >= #self._update_group_infos or self._process_state == _PROCESS_STATE.APPLYING then
    local __confirm_apply
    
    function __confirm_apply()
      self._confirm_apply_index = self._confirm_apply_index + 1
      if self._confirm_apply_index <= #self._update_group_infos then
        E.LOG.d(TAG, "apply index:" .. tostring(self._confirm_apply_index))
        local task = self._update_group_infos[self._confirm_apply_index] or {}
        if task.has_completed == true then
          E.LOG.d(TAG, "task has completed, skip to apply")
          __confirm_apply()
        elseif type(task.on_confirm_res_apply) == "function" then
          E.LOG.d(TAG, "applying index:" .. tostring(self._confirm_apply_index))
          task.on_confirm_res_apply()
        end
      end
    end
    
    if self._process_state ~= _PROCESS_STATE.APPLYING then
      self._confirm_apply_index = 0
      self._process_state = _PROCESS_STATE.APPLYING
      if type(self._outer_listeners.on_confirm_res_apply) == "function" then
        self._outer_listeners.on_confirm_res_apply(__confirm_apply)
        return
      end
    end
    __confirm_apply()
  else
    E.LOG.d(TAG, "patch finish index:" .. tostring(self._confirm_patch_index))
    __res_patch_next(self, result)
  end
end

function __res_update_complete(self, result, ...)
  E.LOG.d(TAG, "complete res update:" .. tostring(self._complete_update_index) .. ",group_size:" .. tostring(#self._update_group_infos))
  if self._complete_update_index >= #self._update_group_infos or self._confirm_update_index >= #self._update_group_infos and false == result then
    if type(self._outer_listeners.on_group_res_update_complete) == "function" and false == self._has_update_completed then
      self._has_update_completed = true
      self._outer_listeners.on_group_res_update_complete(result, ...)
    end
  else
    E.LOG.d(TAG, "apply finish index:" .. tostring(self._confirm_apply_index))
    __res_apply_next(self, result)
  end
end

function _res_patch_next(self)
  self._confirm_patch_index = self._confirm_patch_index + 1
  __res_patch_next(self)
end

function _res_apply_next(self)
  self._confirm_apply_index = self._confirm_apply_index + 1
  __res_apply_next(self)
end

local function _res_update_complete(self, result, ...)
  self._complete_update_index = self._complete_update_index + 1
  __res_update_complete(self, result, ...)
end

local function _request_group_update(self, group_info, res_update_info, _opts, confirm_cb)
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local NOTIF = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
  local opts = UTILS.deepcopy(_opts or {})
  opts.default_progress_style = opts.default_progress_style or NOTIF.PROGRESS_STYLE.PROGRESS_STYLE_NO_PROGRESS
  if not opts.version then
    opts.version = group_info.version
  end
  if not opts.pkg_res_version then
    opts.pkg_res_version = group_info.pkg_res_version
  end
  local _listeners
  _listeners = {
    on_confirm_res_update = function(group_update_info, group_confirm_cb)
      E.LOG.d(TAG, "confirm_res_update group_name:" .. group_info.name)
      E.LOG.d(TAG, {group_update_info = group_update_info})
      if group_update_info.has_new_update == true and group_update_info.file_list_type ~= "origin" then
        self._need_patch_count = self._need_patch_count + 1
      end
      E.LOG.d(TAG, "need_patch_count:" .. tostring(self._need_patch_count))
      local multi_res_update_info = UTILS.deepcopy(res_update_info)
      if multi_res_update_info.has_new_update == false then
        if group_update_info.has_new_update == false then
          multi_res_update_info = UTILS.deepcopy(group_update_info)
        else
          multi_res_update_info.total_size = 0
          multi_res_update_info.remain_size = 0
          multi_res_update_info.total_count = 0
          multi_res_update_info.remain_count = 0
        end
      end
      multi_res_update_info.has_new_update = multi_res_update_info.has_new_update or group_update_info.has_new_update
      if group_update_info.has_new_update == true then
        multi_res_update_info.total_size = (multi_res_update_info.total_size or 0) + group_update_info.total_size
        multi_res_update_info.remain_size = (multi_res_update_info.remain_size or 0) + group_update_info.remain_size
        multi_res_update_info.remain_count = (multi_res_update_info.remain_count or 0) + group_update_info.remain_count
        multi_res_update_info.total_count = (multi_res_update_info.total_count or 0) + group_update_info.total_count
      end
      multi_res_update_info.new_version = group_update_info.new_version
      if multi_res_update_info.file_list_type ~= "patch" then
        multi_res_update_info.file_list_type = group_update_info.file_list_type
      end
      group_info.total_size = group_update_info.total_size
      group_info.remain_size = group_update_info.remain_size
      group_info.remain_count = group_update_info.remain_count
      group_info.total_count = group_update_info.total_count
      group_info.new_version = group_update_info.new_version
      group_info.has_new_update = group_update_info.has_new_update
      group_info.file_list_type = group_update_info.file_list_type
      group_info.on_confirm_res_update = group_confirm_cb
      self._download_progress[group_info.name] = {}
      self._apply_progress[group_info.name] = {}
      confirm_cb(multi_res_update_info)
    end,
    on_res_download_progress_change_listener = function(state, progress_info)
      if group_info.has_confirmed ~= true then
        return
      end
      local multi_res_download_progress_info = UTILS.deepcopy(progress_info)
      if true == group_info.has_new_update and (not self._download_progress[group_info.name] or not next(self._download_progress[group_info.name])) and state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
        progress_info = {
          [MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = group_info.total_count,
          [MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = group_info.total_size,
          [MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = group_info.total_count,
          [MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = group_info.total_size
        }
      end
      self._download_progress[group_info.name] = progress_info
      progress_info.state = state
      local progress_keys = {
        MODEL.PROGRESS_INFO_KEY.FINISH_COUNT,
        MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE
      }
      for _, KEY in pairs(progress_keys) do
        multi_res_download_progress_info[KEY] = 0
      end
      local confirm_keys = {
        MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT,
        MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE
      }
      for _, KEY in pairs(confirm_keys) do
        multi_res_download_progress_info[KEY] = self._confirm_update_info[KEY] or 0
      end
      local download_state = state
      for _group_name, download_progress in pairs(self._download_progress) do
        for _, KEY in pairs(progress_keys) do
          multi_res_download_progress_info[KEY] = (multi_res_download_progress_info[KEY] or 0) + (download_progress[KEY] or 0)
        end
      end
      if type(_DOWNLOAD_STATE_INDEX[download_state]) == "number" then
        if _DOWNLOAD_STATE_INDEX[self._download_state] < _DOWNLOAD_STATE_INDEX[download_state] and (download_state ~= MODEL.PUBLIC_DOWNLOAD_STATE.COMPLETE or self._confirm_update_index >= self._need_update_count) then
          self._download_state = download_state
        else
          download_state = self._download_state
        end
      end
      if multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] > 0 then
        multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] = math.floor((multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] or 0) / multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] * 100)
        E.LOG.d(TAG .. "#download_progress", string.format("group_name:%s,origin_state=%s, state:%s,percent:%d", group_info.name, state, download_state, multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT]))
        self._outer_listeners.on_res_download_progress_change(download_state, multi_res_download_progress_info)
      end
    end,
    on_res_apply_progress_change_listener = function(state, progress_info)
      if group_info.has_confirmed ~= true then
        return
      end
      if state ~= RTM.APPLY_STATE.RE_DOWNLOAD then
        self._apply_progress[group_info.name] = progress_info
      end
      progress_info.state = state
      local multi_res_apply_progress_info = {
        [MODEL.PROGRESS_INFO_KEY.PERCENT] = 0
      }
      local apply_state = state
      for _group_name, apply_progress in pairs(self._apply_progress) do
        multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] = (multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] or 0) + (apply_progress[MODEL.PROGRESS_INFO_KEY.PERCENT] or 0)
        if self._apply_state ~= RTM.APPLY_STATE.FAIL and apply_progress.state == RTM.APPLY_STATE.FAIL then
          self._apply_state = apply_progress.state
        end
      end
      if self._need_update_count > 0 then
        multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] = math.floor(multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] / self._need_patch_count)
        E.LOG.d(TAG .. "#apply_progress", string.format("group_name:%s,state:%s,percent:%d", group_info.name, self._apply_state, multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT]))
        self._outer_listeners.on_res_apply_progress_change(apply_state, multi_res_apply_progress_info)
      end
    end,
    on_confirm_res_patch = function(patch_confirm_cb)
      E.LOG.d(TAG, "patch has confirm:" .. tostring(group_info.has_confirmed))
      if group_info.has_confirmed ~= true then
        patch_confirm_cb()
        return
      end
      E.LOG.d(TAG, "confirm_res_patch:" .. group_info.name)
      group_info.on_confirm_res_patch = patch_confirm_cb
      _res_patch_next(self)
    end,
    on_confirm_res_apply = function(apply_confirm_cb)
      E.LOG.d(TAG, "apply has confirm:" .. tostring(group_info.has_confirmed))
      if group_info.has_confirmed ~= true then
        apply_confirm_cb()
        return
      end
      E.LOG.d(TAG, "confirm_res_apply:" .. group_info.name)
      group_info.on_confirm_res_apply = apply_confirm_cb
      _res_apply_next(self)
    end,
    on_group_res_update_complete = function(result, ...)
      E.LOG.d(TAG, "group_res_update complete, succ:" .. tostring(result) .. ",groupname=" .. group_info.name)
      E.LOG.d(TAG, "complete_index:" .. tostring(self._complete_update_index) .. ",groupsize:" .. tostring(#self._update_group_infos))
      E.LOG.d(TAG, "group_info.has_confirmed: " .. tostring(group_info.has_confirmed))
      group_info.has_completed = true
      if true == result and true == group_info.has_new_update and group_info.has_confirmed == true then
        if not self._download_progress[group_info.name] or not next(self._download_progress[group_info.name]) then
          self._download_progress[group_info.name] = {
            [MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = group_info.total_count,
            [MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = group_info.total_size,
            [MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = group_info.total_count,
            [MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = group_info.total_size,
            state = RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE
          }
          if self._process_state == _PROCESS_STATE.DOWNLOADING then
            _listeners.on_res_download_progress_change_listener(RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE, self._download_progress[group_info.name])
          end
        end
        if (not self._apply_progress[group_info.name] or not next(self._apply_progress[group_info.name])) and group_info.file_list_type ~= "origin" then
          self._apply_progress[group_info.name] = {
            state = RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE,
            [MODEL.PROGRESS_INFO_KEY.PERCENT] = 100
          }
          if self._process_state == _PROCESS_STATE.APPLYING then
            _listeners.on_res_apply_progress_change_listener(RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE, self._apply_progress[group_info.name])
          end
        end
      end
      if true == group_info.has_new_update or self._complete_update_index >= #self._update_group_infos then
        if true == self._global_result.succ and false == result then
          self._global_result.data = {
            ...
          }
        end
        self._global_result.succ = self._global_result.succ and result
        local _data = {
          ...
        }
        if self._global_result.data then
          _data = self._global_result.data
        end
        _res_update_complete(self, self._global_result.succ, unpack(_data))
      end
    end
  }
  EF.group_res_update(group_info.name, nil, opts, _listeners)
end

function M:groups_update(group_infos, opts, listeners)
  E.LOG.d(TAG, "request group update")
  listeners = listeners or {}
  local applied_group = group_infos or {}
  
  local function default_cb()
  end
  
  self._outer_listeners = {
    on_res_download_progress_change = listeners.on_res_download_progress_change_listener or default_cb,
    on_res_apply_progress_change = listeners.on_res_apply_progress_change_listener or default_cb,
    on_group_res_update_complete = listeners.on_group_res_update_complete or default_cb,
    on_confirm_res_apply = listeners.on_confirm_res_apply,
    on_confirm_res_patch = listeners.on_confirm_res_patch
  }
  
  local function __confirm_cb(has_confirmed, update_group_infos)
    local update_group_info = {
      total_count = 0,
      total_size = 0,
      remain_size = 0
    }
    local _filter_group_infos = {}
    local _completed_group_infos = {}
    for _, g_info in pairs(update_group_infos) do
      if g_info.has_new_update == true then
        update_group_info.total_count = update_group_info.total_count + g_info.total_count
        update_group_info.total_size = update_group_info.total_size + g_info.total_size
        update_group_info.remain_size = update_group_info.remain_size + g_info.remain_size
        g_info.has_confirmed = has_confirmed
        self._need_update_count = self._need_update_count + 1
        table.insert(_filter_group_infos, g_info)
      else
        table.insert(_completed_group_infos, g_info)
      end
      E.LOG.d(TAG, string.format("group name :%s,size:%d,remain_size:%d,count:%d", g_info.name, g_info.total_size, g_info.remain_size, g_info.total_count))
    end
    self._update_res_info = update_group_info or {}
    self._update_group_infos = _filter_group_infos or {}
    for _, g_info in pairs(_completed_group_infos) do
      g_info.on_confirm_res_update(has_confirmed)
    end
    E.LOG.d(TAG, "start group confirm :" .. tostring(has_confirmed))
    self._process_state = _PROCESS_STATE.DOWNLOADING
    _res_confirm_next(self, has_confirmed)
  end
  
  local _group_infos = {}
  local i = 1
  local current_update_info = {
    total_size = 0,
    total_count = 0,
    remain_size = 0,
    has_new_update = false
  }
  
  local function _request_groups()
    if i <= #applied_group then
      local group_info = applied_group[i]
      E.LOG.d(TAG, "request group:" .. group_info.name .. ",version:" .. tostring(group_info.version) .. ",pkg_res_version:" .. tostring(group_info.pkg_res_version))
      _request_group_update(self, group_info, current_update_info, opts, function(multi_res_update_info)
        table.insert(_group_infos, group_info)
        current_update_info = multi_res_update_info
        i = i + 1
        if 0 == i % MAX_STACK_DEPTH then
          E.Timer.once(0, _request_groups)
        else
          _request_groups()
        end
      end)
    else
      self._confirm_update_info = UTILS.deepcopy(current_update_info)
      self._process_state = _PROCESS_STATE.CONFIRMING
      listeners.on_confirm_res_update(current_update_info, function(is_confirm)
        E.LOG.d(TAG, "request_confirm finish")
        __confirm_cb(is_confirm, _group_infos)
      end)
    end
  end
  
  if #applied_group <= 0 then
    self._outer_listeners.on_group_res_update_complete(true)
  else
    _request_groups()
  end
end

return M
