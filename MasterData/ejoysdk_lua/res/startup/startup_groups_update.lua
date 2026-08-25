local E = require("ejoysdk_lua.ejoysdk")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local GROUPS = require("ejoysdk_lua.res.multi_groups_update")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local unpack = unpack or table.unpack
local MODEL = RTM
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("STARTUP_GROUPS")
local TAG = "DefaultMultiUpdates"

local function _res_confirm_next(self, result, ...)
  self._confirm_update_index = self._confirm_update_index + 1
  E.LOG.d(TAG, "confirm res update:" .. tostring(self._confirm_update_index))
  if self._confirm_update_index <= #self._update_list then
    local res_info = self._update_list[self._confirm_update_index]
    E.LOG.d(TAG, "confirm default update:" .. res_info.name)
    if type(res_info.on_confirm_res_update) == "function" then
      local __result = res_info.has_confirmed
      if false == result then
        __result = false
      end
      E.LOG.d(TAG, "confirm startup update:" .. tostring(__result) .. ",result=" .. tostring(result))
      res_info.on_confirm_res_update(__result)
    end
  end
end

local function __res_patch_next(self, result)
  E.LOG.d(TAG, table.concat({
    "confirm patch update:",
    self._confirm_patch_index,
    ",complete:",
    self._complete_update_index,
    ",state:",
    self._process_state
  }))
  if self._confirm_patch_index + self._complete_update_index >= #self._update_list or self._process_state == GROUPS.PROCESS_STATE.PATCHING then
    local __confirm_patch
    
    function __confirm_patch()
      self._confirm_patch_index = self._confirm_patch_index + 1
      if self._confirm_patch_index <= #self._update_list then
        local task = self._update_list[self._confirm_patch_index] or {}
        if task.has_completed == true then
          E.LOG.d(TAG, "task has completed, skip to patch")
          __confirm_patch()
        elseif task and type(task.on_confirm_res_patch) == "function" then
          E.LOG.d(TAG, "patching index:" .. tostring(self._confirm_patch_index))
          task.on_confirm_res_patch()
        end
      end
    end
    
    if self._process_state ~= GROUPS.PROCESS_STATE.PATCHING then
      self._confirm_patch_index = 0
      self._process_state = GROUPS.PROCESS_STATE.PATCHING
      if type(self._origin_listeners.on_confirm_res_patch) == "function" then
        self._origin_listeners.on_confirm_res_patch(__confirm_patch)
        return
      end
    end
    __confirm_patch()
  else
    _res_confirm_next(self, false ~= result)
  end
end

local function _res_patch_next(self)
  self._confirm_patch_index = self._confirm_patch_index + 1
  __res_patch_next(self)
end

local function __res_apply_next(self, result)
  E.LOG.d(TAG, table.concat({
    "confirm apply update:",
    self._confirm_apply_index,
    ",complete:" .. self._complete_update_index,
    ",state:",
    self._process_state
  }))
  if self._confirm_apply_index + self._complete_update_index >= #self._update_list or self._process_state == GROUPS.PROCESS_STATE.APPLYING then
    local __confirm_apply
    
    function __confirm_apply()
      self._confirm_apply_index = self._confirm_apply_index + 1
      if self._confirm_apply_index <= #self._update_list then
        E.LOG.d(TAG, "apply index:" .. tostring(self._confirm_apply_index))
        local task = self._update_list[self._confirm_apply_index] or {}
        if task.has_completed == true then
          E.LOG.d(TAG, "task has completed, skip to apply")
          __confirm_apply()
        elseif type(task.on_confirm_res_apply) == "function" then
          task.on_confirm_res_apply()
        end
      end
    end
    
    if self._process_state ~= GROUPS.PROCESS_STATE.APPLYING then
      self._confirm_apply_index = 0
      self._process_state = GROUPS.PROCESS_STATE.APPLYING
      if type(self._origin_listeners.on_confirm_res_apply) == "function" then
        self._origin_listeners.on_confirm_res_apply(__confirm_apply)
        return
      end
    end
    __confirm_apply()
  else
    E.LOG.d(TAG, "patch finish index:" .. tostring(self._confirm_patch_index))
    __res_patch_next(self, result)
  end
end

local function _res_apply_next(self)
  self._confirm_apply_index = self._confirm_apply_index + 1
  __res_apply_next(self)
end

local function _res_update_complete(self, result, ...)
  self._complete_update_index = self._complete_update_index + 1
  self._global_result.succ = true == result and self._global_result.succ == true
  local _result_data = {
    ...
  }
  if self._global_result.data then
    _result_data = self._global_result.data
  elseif not self._global_result.succ then
    self._global_result.data = _result_data
  end
  if self._complete_update_index >= #self._update_list or self._confirm_update_index >= #self._update_list and false == result then
    if type(self._origin_listeners.on_startup_update_complete) == "function" and false == self._has_update_completed then
      self._has_update_completed = true
      self._origin_listeners.on_startup_update_complete(self._global_result.succ, unpack(_result_data))
    end
  else
    E.LOG.d(TAG, "apply finish index:" .. tostring(self._confirm_apply_index))
    __res_apply_next(self, result)
  end
end

function M:_init(groups, opts)
  self._origin_listeners = {}
  self._request_groups = groups or {}
  self._opts = opts or {}
  self._update_list = {}
  self._confirm_update_index = 0
  self._complete_update_index = 0
  self._confirm_patch_index = 0
  self._confirm_apply_index = 0
  self._process_state = GROUPS.PROCESS_STATE.CHECKING
  self._has_update_completed = false
  self._download_state = MODEL.PUBLIC_DOWNLOAD_STATE.IDLE
  self._apply_state = RTM.APPLY_STATE.IDLE
  self._apply_state_info = {}
  self._need_update_count = 0
  self._need_patch_count = 0
  self._confirm_update_info = {}
  self._global_result = {succ = true, data = nil}
  self._wrapper_listeners = {
    on_confirm_res_update = function(res_update_info, confirm_cb)
      res_update_info.on_confirm_res_update = confirm_cb
      res_update_info.name = "default"
      local local_update_list = {}
      table.insert(local_update_list, res_update_info)
      
      local function __default_confirm(_update_list, _update_res_info)
        self._process_state = GROUPS.PROCESS_STATE.CONFIRMING
        self._confirm_update_info = UTILS.deepcopy(_update_res_info)
        self._origin_listeners.on_confirm_res_update(_update_res_info, function(has_confirmed)
          local _completed_res_info = {}
          for _, res_info in pairs(_update_list) do
            res_info.has_confirmed = has_confirmed
            if res_info.has_new_update == true then
              self._need_update_count = self._need_update_count + 1
              if res_info.file_list_type ~= "origin" then
                self._need_patch_count = self._need_patch_count + 1
              end
              table.insert(self._update_list, res_info)
            else
              table.insert(_completed_res_info, res_info)
            end
          end
          E.LOG.d(TAG, "need_patch_count:" .. tostring(self._need_patch_count))
          for _, res_info in pairs(_completed_res_info) do
            res_info.on_confirm_res_update(has_confirmed)
          end
          self._process_state = GROUPS.PROCESS_STATE.DOWNLOADING
          _res_confirm_next(self, has_confirmed)
        end)
      end
      
      local function __request_groups(filter_group_infos)
        GROUPS:New():groups_update(filter_group_infos, self._opts, {
          on_confirm_res_update = function(group_update_info, confirm_group_update_cb)
            group_update_info.on_confirm_res_update = confirm_group_update_cb
            group_update_info.name = "group"
            table.insert(local_update_list, group_update_info)
            local multi_res_update_info = UTILS.deepcopy(res_update_info)
            if multi_res_update_info.has_new_update == false then
              multi_res_update_info.total_size = 0
              multi_res_update_info.remain_size = 0
              multi_res_update_info.remain_count = 0
              multi_res_update_info.total_count = 0
            end
            multi_res_update_info.has_new_update = multi_res_update_info.has_new_update or group_update_info.has_new_update
            if group_update_info.has_new_update == true then
              multi_res_update_info.total_size = multi_res_update_info.total_size + group_update_info.total_size
              multi_res_update_info.remain_size = multi_res_update_info.remain_size + group_update_info.remain_size
              multi_res_update_info.remain_count = multi_res_update_info.remain_count + group_update_info.remain_count
              multi_res_update_info.total_count = multi_res_update_info.total_count + group_update_info.total_count
            end
            self._confirm_update_info = UTILS.deepcopy(multi_res_update_info)
            __default_confirm(local_update_list, multi_res_update_info)
          end,
          on_res_download_progress_change_listener = function(state, progress)
            self._wrapper_listeners.on_res_download_progress_change_listener(state, progress, #self._update_list)
          end,
          on_res_apply_progress_change_listener = function(state, progress)
            self._wrapper_listeners.on_res_apply_progress_change_listener(state, progress, #self._update_list)
          end,
          on_confirm_res_apply = function(apply_confirm_cb)
            self._wrapper_listeners.on_confirm_res_apply(apply_confirm_cb, #self._update_list)
          end,
          on_confirm_res_patch = function(confirm_patch_cb)
            self._wrapper_listeners.on_confirm_res_patch(confirm_patch_cb, #self._update_list)
          end,
          on_group_res_update_complete = function(result, ...)
            E.LOG.d(TAG, "group update complete")
            self._wrapper_listeners.on_startup_update_complete(result, ...)
          end
        })
      end
      
      if type(self._wrapper_listeners.on_request_groups_filter) == "function" then
        E.LOG.d(TAG, "request group filter")
        local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
        local ERU = require("ejoysdk_lua.res.ejoysdk_res_utils")
        local startup_res_info = SC.get_startup_game_origin_params() or {}
        local namespace = startup_res_info.namespace
        local res_key = startup_res_info.res_key
        local last_version = res_update_info.new_version
        local local_file_list_content = ERS.static_get_file_info_list_cache(namespace, res_key, last_version, "", {
          [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = ERU.try_get_storage_type(startup_res_info[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE], startup_res_info[RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH])
        })
        local group_infos = {}
        for _, group_info in ipairs((local_file_list_content or {}).group or {}) do
          local group_name = group_info.g
          if "default" ~= group_name then
            local tags = group_info.tags
            local ext = group_info.ext
            table.insert(group_infos, {
              name = group_name,
              tags = tags,
              ext = ext
            })
          end
        end
        self._wrapper_listeners.on_request_groups_filter(group_infos, function(filter_group_infos)
          if filter_group_infos and next(filter_group_infos) then
            __request_groups(filter_group_infos)
          else
            __default_confirm(local_update_list, res_update_info)
          end
        end)
      elseif self._request_groups and next(self._request_groups) then
        __request_groups(self._request_groups)
      else
        __default_confirm(local_update_list, res_update_info)
      end
    end,
    on_res_download_progress_change_listener = function(state, progress_info, _index)
      if self._confirm_update_index <= 0 or self._confirm_update_index > #self._update_list then
        return
      end
      _index = _index or 1
      local res_info = self._update_list[_index]
      if res_info.has_new_update == true and (not res_info.download_progress_info or not next(res_info.download_progress_info)) and state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
        res_info.download_progress_info = {
          [MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = res_info.total_count,
          [MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = res_info.total_size,
          [MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = res_info.total_count,
          [MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = res_info.total_size
        }
      else
        res_info.download_progress_info = progress_info
      end
      local multi_res_download_progress_info = UTILS.deepcopy(progress_info)
      local progress_keys = {
        MODEL.PROGRESS_INFO_KEY.FINISH_COUNT,
        MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE,
        MODEL.PROGRESS_INFO_KEY.PERCENT
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
      for _, info in ipairs(self._update_list) do
        for _, KEY in pairs(progress_keys) do
          multi_res_download_progress_info[KEY] = (multi_res_download_progress_info[KEY] or 0) + ((info.download_progress_info or {})[KEY] or 0)
        end
      end
      if type(GROUPS.DOWNLOAD_STATE_INDEX[download_state]) == "number" then
        if GROUPS.DOWNLOAD_STATE_INDEX[self._download_state] < GROUPS.DOWNLOAD_STATE_INDEX[download_state] and (download_state ~= MODEL.PUBLIC_DOWNLOAD_STATE.COMPLETE or self._confirm_update_index >= self._need_update_count) then
          self._download_state = download_state
        else
          download_state = self._download_state
        end
      end
      if multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] > 0 then
        multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] = math.floor((multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] or 0) / multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] * 100)
        E.LOG.d(TAG .. "#download_progress", string.format("index:%d,origin_state:%s, state:%s,percent:%d", _index, tostring(state), tostring(download_state), multi_res_download_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT]))
        self._origin_listeners.on_res_download_progress_change_listener(download_state, multi_res_download_progress_info)
      end
    end,
    on_res_apply_progress_change_listener = function(state, progress_info, _index)
      if self._confirm_patch_index <= 0 or self._confirm_patch_index > #self._update_list then
        return
      end
      _index = _index or 1
      local res_info = self._update_list[_index]
      if state ~= RTM.APPLY_STATE.RE_DOWNLOAD then
        res_info.apply_progress_info = progress_info
      end
      local multi_res_apply_progress_info = {
        [MODEL.PROGRESS_INFO_KEY.PERCENT] = 0
      }
      local apply_state = state
      for _, info in pairs(self._update_list) do
        local apply_progress = info.apply_progress_info or {}
        multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] = (multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] or 0) + (apply_progress[MODEL.PROGRESS_INFO_KEY.PERCENT] or 0)
        if self._apply_state ~= RTM.APPLY_STATE.FAIL and apply_progress.state == RTM.APPLY_STATE.FAIL then
          self._apply_state = apply_progress.state
        end
      end
      if self._need_patch_count > 0 then
        multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] = math.floor(multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT] / self._need_patch_count)
        E.LOG.d(TAG .. "#apply_progress", string.format("index:%d,completeindex:%d,state:%s,percent:%d", _index, self._complete_update_index, tostring(apply_state), multi_res_apply_progress_info[MODEL.PROGRESS_INFO_KEY.PERCENT]))
        local percent = progress_info.percent
        local current_time = os.time()
        local interval_time = current_time - (self._apply_state_info.last_notify_time or 0)
        local notify_interval_time = 1
        if self._apply_state_info.last_percent ~= percent and interval_time > notify_interval_time or self._apply_state_info.last_state ~= apply_state then
          self._apply_state_info.last_percent = percent
          self._apply_state_info.last_state = state
          self._apply_state_info.last_notify_time = current_time
          self._origin_listeners.on_res_apply_progress_change_listener(apply_state, multi_res_apply_progress_info)
        end
      end
    end,
    on_confirm_res_patch = function(patch_confirm_cb, _index)
      E.LOG.d(TAG, "confirm_patch,updateindex=" .. tostring(self._confirm_patch_index) .. ",update_size:" .. tostring(#self._update_list))
      if self._confirm_update_index <= 0 then
        patch_confirm_cb()
        return
      end
      _index = _index or 1
      local res_info = self._update_list[_index]
      if res_info then
        res_info.on_confirm_res_patch = patch_confirm_cb
      end
      _res_patch_next(self)
    end,
    on_confirm_res_apply = function(apply_confirm_cb, _index)
      if self._confirm_update_index <= 0 then
        apply_confirm_cb()
        return
      end
      _index = _index or 1
      local res_info = self._update_list[_index]
      if res_info then
        res_info.on_confirm_res_apply = apply_confirm_cb
      end
      _res_apply_next(self)
    end,
    on_startup_update_complete = function(result, ...)
      E.LOG.d(TAG, "complete :" .. tostring(result) .. ",process_state:" .. tostring(self._process_state))
      if self._complete_update_index >= 0 and self._complete_update_index < #self._update_list then
        local res_info = self._update_list[self._complete_update_index + 1]
        if self._process_state >= GROUPS.PROCESS_STATE.DOWNLOADING and true == result and true == res_info.has_new_update then
          res_info.has_completed = true
          if not res_info.download_progress_info or not next(res_info.download_progress_info) then
            res_info.download_progress_info = {
              [MODEL.PROGRESS_INFO_KEY.TOTAL_COUNT] = res_info.total_count,
              [MODEL.PROGRESS_INFO_KEY.TOTAL_SIZE] = res_info.total_size,
              [MODEL.PROGRESS_INFO_KEY.FINISH_COUNT] = res_info.total_count,
              [MODEL.PROGRESS_INFO_KEY.DOWNLOADING_SIZE] = res_info.total_size,
              state = RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE
            }
            if self._process_state == GROUPS.PROCESS_STATE.DOWNLOADING then
              self._wrapper_listeners.on_res_download_progress_change_listener(RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE, res_info.download_progress_info)
            end
          end
          if (not res_info.apply_progress_info or not next(res_info.apply_progress_info)) and res_info.file_list_type ~= "origin" then
            res_info.apply_progress_info = {
              state = RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE,
              [MODEL.PROGRESS_INFO_KEY.PERCENT] = 100
            }
            if self._process_state == GROUPS.PROCESS_STATE.APPLYING then
              self._wrapper_listeners.on_res_apply_progress_change_listener(RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE, res_info.apply_progress_info)
            end
          end
        end
      end
      if self._process_state > GROUPS.PROCESS_STATE.CONFIRMING or self._complete_update_index >= #self._update_list then
        _res_update_complete(self, result, ...)
      end
    end
  }
end

function M:multi_update_intercept(listeners)
  if listeners then
    for name, cb in pairs(listeners) do
      if type(cb) == "function" then
        self._origin_listeners[name] = cb
        if self._wrapper_listeners[name] == nil then
          self._wrapper_listeners[name] = cb
        end
      end
    end
  end
  return self._wrapper_listeners
end

return M
