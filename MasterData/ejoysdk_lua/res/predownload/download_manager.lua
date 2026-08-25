local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local CONFIG = require("ejoysdk_lua.res.predownload.predown_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local MULTI_TASK = require("ejoysdk_lua.res.predownload.multi_update_tasks")
local M = Class:Inherit("EjoyQzPreDownloadManager")
local TAG = "EjoyPredownload#DownloadMgr"
local _instance = {}
M.STATUS = {
  NONE = "none",
  OPEN = "open",
  FINISH = "finish",
  CANCEL = "cancel",
  RESTART = "restart"
}

function M.static_get_mgr(namespace, reskey)
  local key_name = namespace .. "_" .. reskey
  local instance = _instance[key_name]
  if not instance then
    instance = M:New(namespace, reskey)
    _instance[key_name] = instance
  end
  return instance
end

local function update_status(self)
  local local_info = self._data.local_info
  local update_info = self._data.info
  if not update_info then
    return M.STATUS.NONE
  end
  local switch = {
    [M.STATUS.OPEN] = function()
      if local_info then
        return M.STATUS.OPEN
      else
        return M.STATUS.OPEN
      end
    end,
    [M.STATUS.FINISH] = function()
      if local_info then
        return M.STATUS.FINISH
      else
        return M.STATUS.NONE
      end
    end,
    [M.STATUS.CANCEL] = function()
      if local_info then
        return M.STATUS.CANCEL
      else
        return M.STATUS.NONE
      end
    end
  }
  local status = (switch[update_info.status] or function()
    return M.STATUS.NONE
  end)()
  E.LOG.d(TAG, {status = status})
  return status
end

local function _update_predownload_info(self, update_info)
  if update_info then
    self._data.info = update_info
    self._data.status = update_status(self)
    local switch = {
      [M.STATUS.OPEN] = M.open,
      [M.STATUS.CANCEL] = M.cancel
    }
    ;(switch[self._data.status] or function()
    end)(self)
  end
end

function M:_init(namespace, res_key)
  self._data = {namespace = namespace, res_key = res_key}
  self._keystore = E.LazyKeyStore:New(string.format("EJOY_PREDOWNLOAD_UPDATE_INFO-%s-%s", string.upper(namespace), string.upper(res_key)), false, true, false)
  local _update_info = self._keystore:get()
  if _update_info and next(_update_info) then
    _update_predownload_info(self, _update_info)
  end
end

function M:update_info(origin_info)
  local predownload_info = (origin_info or {}).predownload
  if predownload_info then
    local info = UTILS.deepcopy(predownload_info)
    local copy_keys = {
      RTM.RES_CONFIG_KEY.KEY_BASE_URL,
      RTM.RES_CONFIG_KEY.KEY_RES_TYPE,
      RTM.RES_CONFIG_KEY.KEY_PACK_KEY,
      RTM.RES_CONFIG_KEY.KEY_EXT,
      RTM.RES_CONFIG_KEY.KEY_HANDLER,
      RTM.RES_CONFIG_KEY.KEY_BASE_PATH
    }
    for _, key in ipairs(copy_keys) do
      info[key] = origin_info[key]
    end
    self._keystore:set(info)
    _update_predownload_info(self, info)
  else
    self._keystore:delete()
  end
end

function M:get_state()
  return self._data.status or M.STATUS.NONE
end

function M:local_info(info)
  self._data.local_info = info
end

function M:get_local_info()
  return UTIL.deepcopy(self._data.local_info) or {}
end

function M:open()
  E.LOG.d(TAG, "open state")
  self._data.status = M.STATUS.OPEN
  local start_time = (self._data.info or {}).start
  E.LOG.d(TAG, "open status, update start time:" .. tostring(start_time))
end

function M:clean(cb)
  E.LOG.d(TAG, "clean resource")
  cb = cb or function()
  end
  local namespace = self._data.namespace
  local real_key = self._data.res_key
  local startup_local_res_info = SC.get_startup_local_res_infos_cache()
  local startup_res_info = startup_local_res_info[namespace] and startup_local_res_info[namespace][real_key]
  if startup_res_info then
    local res_save_base_path = startup_res_info.res_save_base_path
    local res_save_storage_type = startup_res_info.res_save_storage_type
    local apply_dest_path = ER_UTILS.get_apply_dest_path(res_save_storage_type, res_save_base_path) .. "/" .. CONSTANTS.RES_PREDOWNLOAD.FOLDER_NAME
    RTM.static_update_using_res_file_list(apply_dest_path, {})
    E.File.remove_fullpath(apply_dest_path)
  end
  if self.download_task then
    self.download_task:clean(cb)
  else
    local ERMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
    local ER = require("ejoysdk_lua.res.ejoysdk_res")
    local GMR = require("ejoysdk_lua.res.group_res_manager")
    local all_ns_resources = ER.get_all_cached_namespace_resources()
    for _ns, res_map in pairs(all_ns_resources) do
      if _ns == self._data.namespace then
        for _res_key, _res_info in pairs(res_map) do
          E.LOG.d(TAG, "clean key:" .. _res_key)
          if M.UTILS.is_predownload(_res_key) then
            local __real_res_key = GMR.get_real_res_key(M.UTILS.get_real_res_key(_res_key))
            if self._data.res_key == __real_res_key then
              ER.repair(_ns, _res_key)
              RTM.static_clear_cached_res_info(_ns, _res_key)
              ERMF.clear_ejoy_res_source_model(_ns, _res_key)
            end
          end
        end
      end
    end
    cb(true)
  end
end

function M:cancel(cb)
  E.LOG.d(TAG, "cancel update")
  cb = cb or function()
  end
  self:stop(function(succ, ...)
    if true == succ then
      self:clean(cb)
    else
      cb(false, ...)
    end
  end)
end

function M:finish()
  E.LOG.d(TAG, "has finished")
  self:clean()
  CONFIG.clean()
  self._data.status = M.STATUS.NONE
end

function M:stop(cb)
  E.LOG.d(TAG, "stop update")
  if self.download_task then
    self.download_task:stop(function(succ, ...)
      E.LOG.d(TAG, "stop update:" .. tostring(succ))
      cb(succ, ...)
    end)
  end
end

function M:start(cb)
  E.LOG.d(TAG, "start update")
  if self.download_task then
    E.LOG.d(TAG, "start task reset")
    self.download_task:start(cb)
  end
end

local function _convert_extended_group_infos(groups, res_key)
  local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local _extended_group_infos = UTILS.deepcopy(groups) or {}
  table.insert(_extended_group_infos, {name = "default"})
  for _, group_info in ipairs(_extended_group_infos) do
    local group_name = group_info.name
    group_info._res_key = res_key
    group_info._real_res_key = res_key
    if group_info.name ~= "default" then
      group_info._real_res_key = GRM.get_task_key(res_key, group_name)
    end
    group_info._res_key = PREDOWNLOAD_MGR.UTILS.get_task(group_info._real_res_key)
  end
  return _extended_group_infos
end

function M:create(groups, opts, listeners, cb)
  E.LOG.d(TAG, "======create_download_task======")
  local _state = self:get_state()
  if _state == M.STATUS.RESTART then
    self:cancel()
    self:open()
  end
  E.LOG.d(TAG, "current state:" .. tostring(_state))
  if self:get_state() ~= M.STATUS.OPEN then
    E.LOG.d(TAG, "state is not open:" .. tostring(_state))
    cb(false, CONSTANTS.RES_PREDOWNLOAD.ERROR_CODE.NOT_IN_OPEN, "not in open")
    return nil
  end
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local update_info = self._data.info
  local _listeners = UTILS.deepcopy(listeners)
  
  function _listeners.on_res_update_complete(succ, ...)
    if true == succ and groups and next(groups) and self.download_task then
      local _update_groups = {}
      local _update_info = self.download_task:get_task_info()
      local _new_version = (_update_info or {}).new_version
      for _, g_info in ipairs(groups) do
        table.insert(_update_groups, {
          name = g_info.name,
          version = _new_version
        })
      end
      E.LOG.d(TAG, {save_groups = _update_groups})
      CONFIG.update(CONFIG.KEY.GROUPS, _update_groups)
    end
    listeners.on_res_update_complete(succ, ...)
  end
  
  local function _create_task(_attach_groups)
    E.LOG.d(TAG, {request_groups = _attach_groups})
    local _extended_group_infos = _convert_extended_group_infos(_attach_groups, res_key)
    local _startup_params_info = (SC.get_startup_local_res_infos_cache() or {})[namespace] or {}[res_key] or {}
    local _predownload_startup_params_info = UTILS.deepcopy(_startup_params_info)
    if _predownload_startup_params_info.res_save_base_path then
      _predownload_startup_params_info.res_save_base_path = _predownload_startup_params_info.res_save_base_path .. "/" .. CONSTANTS.RES_PREDOWNLOAD.FOLDER_NAME
    end
    opts = opts or {}
    opts.priority = RTM.RES_PRIORITY.LOW
    local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
    local Lang = require("ejoysdk_lua.lang.util")
    local _notify_title = Lang.getString("noti_pre_downloading_static_title", "游戏资源更新中，不影响游戏体验")
    opts[END.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG] = {
      complete_title = _notify_title,
      complete_left_txt = "",
      downloading_title = _notify_title
    }
    self.download_task = MULTI_TASK:New(namespace, res_key, _extended_group_infos, update_info, _predownload_startup_params_info)
    self.download_task:create(opts, _listeners, cb)
  end
  
  if type(listeners.on_request_groups_filter) == "function" and update_info and next(update_info[RTM.UPDATE_INFO_KEY.ORIGIN]) then
    local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
    local ERU = require("ejoysdk_lua.res.ejoysdk_res_utils")
    local QZ_FILE_LIST_MGR = require("ejoysdk_lua.res.model.res_src.ejoy_qz_res_file_list_mgr")
    local startup_res_info = SC.get_startup_game_origin_params() or {}
    local last_version = update_info.version
    local _dest_path = ERS.static_get_index_file_cache_path(namespace, M.UTILS.get_task(res_key), last_version, "", {
      [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = ERU.try_get_storage_type(startup_res_info[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE], startup_res_info[RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH])
    })
    local _file_list_cache = QZ_FILE_LIST_MGR.static_get_qz_file_list(_dest_path, ERS.RES_FILE_LIST_CACHE_KEY.FILE_NAME_INFO_LIST_JSON)
    local _origin_info = update_info[RTM.UPDATE_INFO_KEY.ORIGIN]
    local _download_info = {
      url = string.format("%s/%s/%s", update_info[RTM.RES_CONFIG_KEY.KEY_BASE_URL] or "", _origin_info[RTM.RES_CONFIG_KEY.KEY_FOLDER] or "", _origin_info[RTM.RES_CONFIG_KEY.KEY_INDEX_INFO_FILE] or ""),
      md5 = _origin_info[RTM.RES_CONFIG_KEY.KEY_INDEX_INFO_MD5] or ""
    }
    _file_list_cache:get_file_list(_download_info, function(_succ, ...)
      if true == _succ then
        local _, _index_file_cache_path, _index_file_cache_content = ...
        local file_list_obj = _index_file_cache_content
        local _all_group_infos = {}
        for _, group_info in ipairs((file_list_obj or {}).group or {}) do
          local group_name = group_info.g
          if "default" ~= group_name then
            local tags = group_info.tags
            local ext = group_info.ext
            table.insert(_all_group_infos, {
              name = group_name,
              tags = tags,
              ext = ext
            })
          end
        end
        listeners.on_request_groups_filter(_all_group_infos, function(_confirm_groups_info)
          local _merge_groups_index = {}
          local _merge_group_infos = {}
          for _, confirm_group in ipairs(_confirm_groups_info or {}) do
            local _g_name = confirm_group.name
            if not _merge_groups_index[_g_name] then
              _merge_groups_index[_g_name] = true
              table.insert(_merge_group_infos, confirm_group)
            end
          end
          for _, pass_group in ipairs(groups or {}) do
            local _g_name = pass_group.name
            if not UTIL.is_text_empty(_g_name) and true ~= _merge_groups_index[_g_name] then
              table.insert(_merge_group_infos, pass_group)
            end
          end
          _create_task(_merge_group_infos)
        end)
      else
        local _err_code, _err_msg = ...
        E.LOG.e(TAG, string.format("failed to get file info list:%d,%s", _err_code, _err_msg))
        _create_task(groups)
      end
    end)
  else
    _create_task(groups)
  end
  E.LOG.d(TAG, {
    data_info = self._data.info
  })
  return (self._data.info or {}).activity_id or ""
end

function M:reset(cb)
  if self.download_task then
    self.download_task:reset(cb)
  end
end

M.UTILS = require("ejoysdk_lua.res.predownload.pre_download_util")
return M
