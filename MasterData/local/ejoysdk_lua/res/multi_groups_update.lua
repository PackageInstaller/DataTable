local E = require("ejoysdk_lua.ejoysdk")
local MODEL = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("MULTI_GROUPS")
local TAG = "MultiUpdates"
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
M.DOWNLOAD_STATE_INDEX = _DOWNLOAD_STATE_INDEX

function M:_init()
  self._update_index = 0
  self._confirm_update_index = 0
  self._complete_update_index = 0
  self._update_group_infos = {}
  self._update_res_info = {}
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
end

local function _res_confirm_next(self, result, ...)
  self._confirm_update_index = self._confirm_update_index + 1
  E.LOG.d(TAG, "confirm res update:" .. tostring(self._confirm_update_index))
  if self._confirm_update_index <= #self._update_group_infos then
    local res_info = self._update_group_infos[self._confirm_update_index]
    E.LOG.d(TAG, "confirm group update:" .. res_info.name)
    if type(res_info.on_confirm_res_update) == "function" then
      local __result = res_info.has_confirmed
      if false == result then
        __result = false
      end
      res_info.on_confirm_res_update(__result)
    end
  end
end

local function __res_patch_next(self)
  E.LOG.d(TAG, "confirm patch update:" .. tostring(self._update_index) .. ",complete_index:" .. tostring(self._complete_update_index) .. ",total:" .. tostring(#self._update_group_infos))
  if self._update_index + self._complete_update_index >= #self._update_group_infos then
    local function __confirm_patch()
      self._update_index = 0
      
      for _, task in ipairs(self._update_group_infos) do
        if type(task.on_confirm_res_patch) == "function" then
          task.on_confirm_res_patch()
        end
      end
    end
    
    if type(self._outer_listeners.on_confirm_res_patch) == "function" then
      self._outer_listeners.on_confirm_res_patch(__confirm_patch)
    else
      __confirm_patch()
    end
  else
    _res_confirm_next(self, true)
  end
end

local function _res_patch_next(self)
  self._update_index = self._update_index + 1
  __res_patch_next(self)
end

local function _res_apply_next(self)
  self._update_index = self._update_index + 1
  E.LOG.d(TAG, "confirm apply update:" .. tostring(self._update_index) .. ",complete_index:" .. tostring(self._complete_update_index))
  if self._update_index + self._complete_update_index >= #self._update_group_infos then
    local function __confirm_apply()
      self._update_index = 0
      
      for _, task in ipairs(self._update_group_infos) do
        if type(task.on_confirm_res_apply) == "function" then
          task.on_confirm_res_apply()
        end
      end
    end
    
    if type(self._outer_listeners.on_confirm_res_apply) == "function" then
      self._outer_listeners.on_confirm_res_apply(__confirm_apply)
    else
      __confirm_apply()
    end
  end
end

local function _res_update_complete(self, result, ...)
  self._complete_update_index = self._complete_update_index + 1
  E.LOG.d(TAG, "complete res update:" .. tostring(self._complete_update_index) .. ",group_size:" .. tostring(#self._update_group_infos))
  if self._complete_update_index >= #self._update_group_infos or self._confirm_update_index >= #self._update_group_infos and false == result then
    if type(self._outer_listeners.on_group_res_update_complete) == "function" then
      self._outer_listeners.on_group_res_update_complete(result, ...)
    end
  else
    __res_patch_next(self)
  end
end

local function _request_group_update(self, group_info, res_update_info, _opts, confirm_cb)
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local opts = UTILS.deepcopy(_opts or {})
  if not opts.version then
    opts.version = group_info.version
  end
  EF.group_res_update(group_info.name, nil, opts, {
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
      group_info.on_confirm_res_update = group_confirm_cb
      self._download_progress[group_info.name] = {}
      self._apply_progress[group_info.name] = {}
      E.LOG.d(TAG, {multi_res_update_info = multi_res_update_info})
      confirm_cb(multi_res_update_info)
    end,
    on_res_download_progress_change_listener = function(state, progress_info)
      if group_info.has_confirmed ~= true then
        return
      end
      local multi_res_download_progress_info = UTILS.deepcopy(progress_info)
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
      E.LOG.d(TAG, "res_update_complete:" .. group_info.name)
      E.LOG.d(TAG, "group_res_update, succ:" .. tostring(result) .. ",groupname=" .. group_info.name)
      E.LOG.d(TAG, "complete :" .. tostring(result))
      _res_confirm_next(self, result, ...)
      _res_update_complete(self, result, ...)
    end
  })
end

function M:groups_update(group_infos, opts, listeners)
  E.LOG.d(TAG, "request group update")
  listeners = listeners or {}
  local applied_group = group_infos or {}
  local __request, __confirm_cb
  local _group_infos = {}
  
  local function default_cb()
  end
  
  self._outer_listeners = {
    on_res_download_progress_change = listeners.on_res_download_progress_change_listener or default_cb,
    on_res_apply_progress_change = listeners.on_res_apply_progress_change_listener or default_cb,
    on_group_res_update_complete = listeners.on_group_res_update_complete or default_cb,
    on_confirm_res_apply = listeners.on_confirm_res_apply,
    on_confirm_res_patch = listeners.on_confirm_res_patch
  }
  
  function __confirm_cb(has_confirmed, update_res_info, update_group_infos)
    self._update_res_info = update_res_info or {}
    self._update_group_infos = update_group_infos or {}
    for _, g_info in pairs(self._update_group_infos) do
      g_info.has_confirmed = has_confirmed
      if g_info.has_new_update == true then
        self._need_update_count = self._need_update_count + 1
      end
    end
    E.LOG.d(TAG, "start group confirm :" .. tostring(has_confirmed))
    _res_confirm_next(self, has_confirmed)
  end
  
  function __request(i, update_info)
    E.LOG.d(TAG, table.concat({
      "i=",
      i,
      ",group_size:",
      #applied_group
    }))
    if i <= #applied_group then
      local group_info = applied_group[i]
      E.LOG.d(TAG, "request group:" .. group_info.name .. ",version:" .. tostring(group_info.version))
      _request_group_update(self, group_info, update_info, opts, function(multi_res_update_info)
        table.insert(_group_infos, group_info)
        __request(i + 1, multi_res_update_info)
      end)
    else
      E.LOG.d(TAG, {confirm_update_info = update_info})
      self._confirm_update_info = UTILS.deepcopy(update_info)
      listeners.on_confirm_res_update(update_info, function(is_confirm)
        E.LOG.d(TAG, "request_confirm finish")
        local update_group_info = {
          total_count = 0,
          total_size = 0,
          remain_size = 0
        }
        for _, g_info in pairs(_group_infos) do
          update_group_info.total_count = update_group_info.total_count + g_info.total_count
          update_group_info.total_size = update_group_info.total_size + g_info.total_size
          update_group_info.remain_size = update_group_info.remain_size + g_info.remain_size
          E.LOG.d(TAG, string.format("group name :%s,size:%d,remain_size:%d,count:%d", g_info.name, g_info.total_size, g_info.remain_size, g_info.total_count))
        end
        __confirm_cb(is_confirm, update_group_info, _group_infos)
      end)
    end
  end
  
  if #applied_group <= 0 then
    self._outer_listeners.on_group_res_update_complete(true)
  else
    __request(1, {
      total_size = 0,
      total_count = 0,
      remain_size = 0,
      has_new_update = false
    })
  end
end

return M
