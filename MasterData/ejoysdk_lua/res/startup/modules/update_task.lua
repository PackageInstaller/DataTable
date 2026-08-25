local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ER = require("ejoysdk_lua.res.ejoysdk_res")
local STAT = require("ejoysdk_lua.res.res_stat")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local CC = require("ejoysdk_lua.ejoysdk_constants")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local SU = require("ejoysdk_lua.res.startup.startup_utils")
local FSM = UTILS.fsm
local M = Class:Inherit("EjoyHttpDownloadTask")
local _tasks_cache = {}
local TAG = "STARTUP#update_task"
local _EVENTS = {
  START_UPDATE = "start_update",
  RESET_UPDATE = "reset_update",
  ON_CHECK_UPDATE_FAILED = "on_check_update_failed",
  ON_CHECK_UPDATE_SUCC = "on_check_update_succ",
  ON_UPDATE_CONFIRMED = "on_update_confirmed",
  ON_UPDATE_CONFIRM_SKIP = "on_update_confirm_skip",
  ON_DOWNLOAD_COMPLETE = "on_download_complete",
  ON_DOWNLOAD_WAITING = "on_download_waiting",
  ON_DOWNLOAD_ING = "on_downloading",
  ON_DOWNLOAD_COMPLETE_APPLY = "on_download_complete_apply",
  ON_DOWNLOAD_FAILED = "on_download_failed",
  ON_APPLY_FAILED = "on_apply_failed",
  ON_APPLY_SUCC = "on_apply_succ"
}
local _STATES = {
  IDLE = "idle",
  CHECKING = "checking",
  CONFIRMING = "confirming",
  DOWNLOADING = "downloading",
  DOWNLOAD_COMPLETE = "download_complete",
  DOWNLOAD_FAILED = "download_failed",
  DOWNLOAD_WAITING = "download_waiting",
  APPLYING = "applying",
  APPLY_FAILED = "apply_failed",
  FINISH = "finish"
}
M.PUB_STATES = _STATES

function M:get_log_tag()
  local tag = "[update]" .. self._data.namespace .. "#" .. self._data.res_key
  return tag
end

function M:log_debug(message)
  if not message or "" == message then
    return
  end
  local tag = self:get_log_tag()
  E.LOG.debug(tag, message)
end

function M:log_warn(message)
  if not message or "" == message then
    return
  end
  local tag = self:get_log_tag()
  E.LOG.warn(tag, message)
end

function M:_fsm_enqueue_event_at_front(event_name, ...)
  if self._data.debug_enable then
    self:log_debug("_fsm_send_event:" .. tostring(event_name))
  end
  self._data.fsm:enqueue_event(event_name, true, ...)
end

function M:_fsm_enqueue_event(event_name, ...)
  self._data.fsm:enqueue_event(event_name, false, ...)
end

function M:_fsm_transition_to(from_state, to_state, ...)
  local fsm = self._data.fsm
  from_state = from_state or fsm.current
  self:log_debug("_fsm_transition_to, from:" .. tostring(from_state) .. ", to_state:" .. tostring(to_state))
  fsm:transition(from_state, to_state, ...)
end

function M:_fsm_on_async_event_finished(event_name)
  local fsm = self._data.fsm
  fsm:notify_async_finish(event_name)
end

function M:_confirm_download(update_ver, _checked_update_info, cb)
  local ns = self._data.namespace
  local _res_key = self._data.res_key
  local inner_res_opts = self._data.inner_res_opts
  local state_listener, progress_listener
  
  local function _cb_wrapper(succ, ...)
    ER.unregister_res_state_change_listener(ns, _res_key, state_listener)
    ER.unregister_res_progress_listener(ns, _res_key, progress_listener)
    cb(succ, ...)
  end
  
  function state_listener(namespace, rk, state, state_obj, progress_info)
    EL.LOG.debug(TAG, string.format("res update change, ns:%s,res_key:%s,state:%s", tostring(ns), tostring(_res_key), tostring(state)))
    progress_listener(namespace, rk, progress_info, state_obj)
    if state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
      EL.LOG.debug(TAG, "res update complete, ns:" .. tostring(ns) .. ", res_key:" .. tostring(_res_key))
      local res_state_infos = ER.get_res_state(ns, _res_key)
      _cb_wrapper(true, res_state_infos)
      STAT.stat_res_download_result(ns, _res_key, update_ver, true)
    elseif state == RTM.PUBLIC_DOWNLOAD_STATE.FAILED then
      local code = state_obj[RTM.RES_STATE_INFO_KEY.ERR_CODE] or 0
      local msg = state_obj[RTM.RES_STATE_INFO_KEY.ERR_MSG]
      EL.LOG.warn(TAG, "res update failed, ns:" .. tostring(ns) .. ", res_key:" .. tostring(_res_key) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      _cb_wrapper(false, code, msg)
      STAT.stat_res_download_result(ns, _res_key, update_ver, false, code, msg)
    elseif state == RTM.PUBLIC_DOWNLOAD_STATE.WAITTING then
      cb(false, state, "downloading waiting")
    elseif state == RTM.PUBLIC_DOWNLOAD_STATE.DOWNLOADING then
      cb(false, state, "downloading")
    end
  end
  
  function progress_listener(namespace, rk, progress_info, state_obj)
    END.notify_res_update_change_listener(namespace, rk, state_obj, progress_info)
  end
  
  ER.register_res_progress_listener(ns, _res_key, progress_listener)
  local reg_result, code, msg = ER.register_res_state_change_listener(ns, _res_key, state_listener)
  if reg_result then
    local start_result, _code, _msg = ER.start_download_res_update(ns, _res_key, inner_res_opts, function(__succ, ...)
      if false == __succ then
        local _c, _m = ...
        _cb_wrapper(false, _c, _m)
      end
    end)
    EL.LOG.debug(TAG, string.format("start_download_res_update, ns:%s, rk:%s, result:%s, code:%s, msg:%s", tostring(ns), tostring(_res_key), tostring(start_result), tostring(_code), tostring(_msg)))
    if not start_result then
      _cb_wrapper(false, _code, _msg)
      return
    end
  else
    EL.LOG.warn(TAG, "register_res_state_change_listener failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    _cb_wrapper(false, code, msg)
    return
  end
end

function M:_check_update_confirm(has_new_update, checked_update_info, confirm_cb)
  local ns = self._data.namespace
  local _res_key = self._data.res_key
  local cur_res_state = ER.get_res_state(ns, _res_key)
  if has_new_update then
    local update_ver = checked_update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
    STAT.stat_update_wait_confirm(ns, _res_key, update_ver, nil, true)
    confirm_cb(true)
  else
    E.LOG.debug(TAG, "skip for no update with namespace:" .. tostring(ns) .. ", res_key:" .. tostring(_res_key))
    STAT.stat_update_wait_confirm(ns, _res_key, "", nil, true)
    END.dispatch_res_update_confirm(ns, _res_key, cur_res_state, function(_confirmed)
      EL.LOG.debug(TAG, "dispatch_res_update_confirm NOT has_new_update, always skip update namespace:" .. tostring(ns) .. ", res_key:" .. tostring(_res_key))
      STAT.stat_update_wait_confirm_result(ns, _res_key, "", "false")
      confirm_cb(false)
    end)
  end
end

function M:_init_task()
  local _namespace = self._data.namespace
  local _res_key = self._data.res_key
  local startup_update_params = self._data.startup_update_params
  local startup_res_params = startup_update_params[_namespace] and startup_update_params[_namespace][_res_key] or {}
  local game_patch_base_path = startup_res_params[RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH]
  local game_patch_storage_type = startup_res_params[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]
  local foreground_notification_enable = startup_res_params[RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED]
  local res_type = startup_res_params[RTM.RES_UPDATES_OPTIONS.RES_TYPE]
  if not game_patch_base_path or "" == game_patch_base_path then
    local origin_obj = self._data.server_update_info[RTM.RES_CONFIG_KEY.KEY_ORIGIN] or {}
    local origin_ext = origin_obj.ext or {}
    game_patch_base_path = origin_ext.to_folder
    game_patch_storage_type = origin_ext.to_storage_type
  end
  self._data.use_default_engine_handler = startup_res_params.use_default_engine_handler
  game_patch_storage_type = game_patch_storage_type or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  if game_patch_base_path and "" ~= game_patch_base_path then
    self._data.res_save_base_path = game_patch_base_path
    self._data.res_save_storage_type = game_patch_storage_type
  end
  if nil == foreground_notification_enable then
    foreground_notification_enable = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED]
  end
  local server_update_info = self._data.server_update_info or {}
  local local_infos = SC.get_startup_local_res_infos_cache() or {}
  local ns_infos = local_infos[_namespace] or {}
  local rk_infos = ns_infos[_res_key] or {}
  local local_version = rk_infos.version or ""
  local ext = {
    p1 = server_update_info.packKey or "",
    p2 = local_version,
    p3 = server_update_info.version or "",
    apus_options = {is_upload_now = true}
  }
  local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
  local game_res_real_save_storage_type = ER_UTILS.try_get_storage_type(game_patch_storage_type, game_patch_base_path)
  self._data.inner_res_opts = {
    [END.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED] = foreground_notification_enable,
    [END.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE] = game_res_real_save_storage_type,
    [END.NAMESPACE_UPDATE_OPTIONS.MAX_RETRY_TIMES] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.MAX_RETRY_TIMES],
    [END.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG],
    [END.NAMESPACE_UPDATE_OPTIONS.PROGRESS_UPDATE_INTERVAL_SEC] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.PROGRESS_UPDATE_INTERVAL_SEC],
    [END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_PRIORITY] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_PRIORITY],
    [END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_SUB_PRIORITY] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_SUB_PRIORITY],
    [END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_MAX_BAND_PER_SEC] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_MAX_BAND_PER_SEC],
    [END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_NOTIF_STYLE] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_NOTIF_STYLE],
    [END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_NETWORK_STRATEGY] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.DOWNLOAD_NETWORK_STRATEGY],
    [END.NAMESPACE_UPDATE_OPTIONS.PKG_RES_VERSION] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.PKG_RES_VERSION],
    [END.NAMESPACE_UPDATE_OPTIONS.RES_VERSION] = self._data.startup_update_opts[END.NAMESPACE_UPDATE_OPTIONS.RES_VERSION],
    ext = ext
  }
  self._data.res_type = res_type
  self:log_debug("_check_update_state, res_save_base_path:" .. tostring(game_patch_base_path) .. ", res_save_storage_type:" .. tostring(game_patch_storage_type))
  local emf = require("ejoysdk_lua.res.ejoy_res_model_factory")
  self._data.res_model = emf.get_ejoy_res_source_model(_namespace, _res_key, self._data.inner_res_opts)
  return true
end

function M:_check_update_state(cb)
  local ns = self._data.namespace
  local _res_key = self._data.res_key
  local _update_info = self._data.server_update_info
  local using_res_info = self._data.using_res_info
  local namespace_ext = self._data.namespace_ext
  local inner_res_opts = self._data.inner_res_opts
  ER.check_namespace_res_update_with_update_info(ns, _res_key, _update_info, using_res_info, namespace_ext, inner_res_opts, function(_succ, ...)
    if _succ then
      local has_new_update, _update_info2 = ...
      if false == has_new_update and SU.can_reuse_res() == true then
        has_new_update = true
        if _update_info2 and _update_info2.update_body and type(_update_info2.update_body[RTM.RES_CONFIG_KEY.KEY_PATCHES]) == "table" and next(_update_info2.update_body[RTM.RES_CONFIG_KEY.KEY_PATCHES]) then
          _update_info2[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE] = RTM.FILE_LIST_TYPE.PATCH
        end
        _update_info2.has_new_update = has_new_update
      end
      self._data.has_new_update = has_new_update
      self:log_debug("_check_update_state succ, has_new_update:" .. tostring(has_new_update))
      cb(true, has_new_update, _update_info2)
    else
      local code, msg = ...
      self:log_debug("_check_update_state failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
      return
    end
  end)
end

function M:_check_res_pre_apply(cb)
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  E.log("res_key is " .. tostring(res_key) .. "_check_res_pre_apply ")
  local res_state_infos = self._data.res_model:get_res_state()
  local ef = require("ejoysdk_lua.res.ejoysdk_res_facade")
  local downloading_info = res_state_infos[ef.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
  local res_location = downloading_info[ef.RES_DOWNLOAD_STATE_KEY.RES_LOCATION]
  local game_res_save_storage_type = self._data.res_save_storage_type or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  local apply_dest_path = self._data.res_model:_get_target_res_save_full_path(self._data.res_save_base_path, game_res_save_storage_type)
  END.dispatch_res_pre_apply(namespace, res_key, res_location, apply_dest_path, res_state_infos, cb)
end

function M:_check_res_patch_apply(_cb)
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local res_type = self._data.res_type
  E.log("res_key is " .. tostring(res_key) .. "_check_res_patch_apply res_type is " .. tostring(res_type))
  local res_state_infos = self._data.res_model:get_res_state()
  local ef = require("ejoysdk_lua.res.ejoysdk_res_facade")
  local downloading_info = res_state_infos[ef.RES_STATE_INFOS.TYPE_DOWNLOADING_INFO] or {}
  local update_info = res_state_infos[ef.RES_STATE_INFOS.TYPE_RES_UPDATE_STATE] or {}
  local res_ext_info = update_info.res_ext or {}
  local res_project_name = res_ext_info.project_name
  local res_location = downloading_info[ef.RES_DOWNLOAD_STATE_KEY.RES_LOCATION]
  local res_ver = downloading_info[ef.RES_DOWNLOAD_STATE_KEY.VERSION_NAME]
  E.LOG.debug(TAG, "_check_res_patch_apply")
  E.log(res_state_infos)
  local file_list_type = downloading_info[ef.RES_DOWNLOAD_STATE_KEY.FILE_LIST_TYPE]
  local ECC = require("ejoysdk_lua.ejoysdk_config_center")
  local game_res_save_storage_type = self._data.res_save_storage_type or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  local apply_dest_path = self._data.res_model:_get_target_res_save_full_path(self._data.res_save_base_path, game_res_save_storage_type)
  
  local function cb(apply_succ, ...)
    if apply_succ then
      local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
      local _update_info = self._data.server_update_info or {}
      local base_path = _update_info.basePath
      local origin_obj = _update_info.origin or {}
      local folder = origin_obj.folder
      ER_FILE_INFO_CACHE.update_using_res_config(apply_dest_path, res_ver, base_path, folder)
    end
    _cb(apply_succ, ...)
  end
  
  if file_list_type == ef.FILE_LIST_TYPE.PATCH or namespace == ECC.NAMESPACE.QZ_CUSTOM_RES then
    self:log_debug("_check_res_patch_apply its patch now notify patch apply")
    STAT.stat_on_res_complete_apply_begin()
    local has_apply_handler = END.check_has_apply_handler(namespace, res_key)
    if has_apply_handler then
      END.request_res_patch_apply(namespace, res_key, res_location, apply_dest_path, res_state_infos, function(succ, ...)
        if succ then
          local remove_downloading_dir = (...)
          self:log_debug("request_res_patch_apply succ, remove_downloading_dir:" .. tostring(remove_downloading_dir))
          self:log_debug("update_using_res_version:" .. tostring(res_ver) .. ", project_name is " .. tostring(res_project_name) .. ", res_type is " .. tostring(res_type))
          self._data.res_model:update_using_res_version(res_ver, res_project_name, res_type)
          if remove_downloading_dir then
            self._data.res_model:remove_res(res_ver)
          end
          STAT.stat_on_res_complete_apply_end(true, "patch", tostring(remove_downloading_dir))
          cb(true)
        else
          local code, msg = ...
          self:log_debug("request_res_patch_apply failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
          STAT.stat_on_res_complete_apply_end(false, "patch", code, msg)
          cb(false, code, msg)
        end
      end)
    else
      self:log_debug("not has apply handler, we not remove downloading dir and not update using res version, just notify outside succ")
      STAT.stat_on_res_complete_apply_end(true, "patch", "no_apply_handler")
      cb(true)
    end
  else
    self:log_debug("_check_res_patch_apply its origin now process origin, its already process in download stage:" .. tostring(self._data.res_save_base_path))
    if self._data.res_save_base_path then
      local has_origin_apply_handler = END.check_has_origin_apply_handler(namespace, res_key)
      if has_origin_apply_handler then
        END.request_origin_res_apply(namespace, res_key, res_location, apply_dest_path, function(succ, ...)
          if succ then
            local remove_downloading_dir = (...)
            self:log_debug("request_res_origin_patch_apply succ, remove_downloading_dir:" .. tostring(remove_downloading_dir))
            self:log_debug("update_using_res_version:" .. tostring(res_ver) .. ", project_name is " .. tostring(res_project_name) .. ", res_type is " .. tostring(res_type))
            self._data.res_model:update_using_res_version(res_ver, res_project_name, res_type)
            local res_save_storage_type = self._data.res_save_storage_type or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
            local stat_key = tostring(res_save_storage_type) .. ":" .. tostring(self._data.res_save_base_path)
            STAT.stat_on_res_complete_apply_end(true, "origin", stat_key)
            cb(true)
          else
            local code, msg = ...
            self:log_debug("request_res_patch_apply failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            STAT.stat_on_res_complete_apply_end(false, "origin", code, msg)
            cb(false, code, msg)
          end
        end)
      else
        local res_save_storage_type = self._data.res_save_storage_type or RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
        self._data.res_model:move_res_to_path(res_location, self._data.res_save_base_path, res_save_storage_type, true, function(move_result, dest_location)
          self:log_debug("inner apply for origin type res, move_res_to_path, from:" .. tostring(res_location) .. ", dest:" .. tostring(dest_location))
          self._data.res_model:update_using_res_version(res_ver, res_project_name, res_type)
          
          local function cache_file_list_fun(ns, rk, local_version, update_version, dest_apply_location, diff_file_array, cache_file_list_cb)
            if self._data.use_default_engine_handler then
              local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
              ER_FILE_INFO_CACHE.update_using_file_list_cache(ns, rk, local_version, update_version, dest_apply_location, diff_file_array, function()
                cache_file_list_cb()
              end)
            else
              self:log_debug("not use default_engine_handler, skip cache file list")
              cache_file_list_cb()
            end
          end
          
          cache_file_list_fun(self._data.namespace, self._data.res_key, nil, res_ver, dest_location, {}, function()
            if move_result then
              self._data.res_model:update_using_res_version(res_ver, res_project_name, res_type)
              local stat_key = tostring(res_save_storage_type) .. ":" .. tostring(self._data.res_save_base_path)
              STAT.stat_on_res_complete_apply_end(true, "origin", stat_key)
              cb(true)
            else
              local code = CC.RESOURCE_UPDATE_ERROR_CODES.RES_RENAME_PATH_FAILED
              local msg = "rename to dest path failed"
              self:log_debug("request_res_patch_apply failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
              STAT.stat_on_res_complete_apply_end(false, "origin", code, msg)
              cb(false, code, msg)
            end
          end)
        end)
      end
    else
      STAT.stat_on_res_complete_apply_end(true, "origin", nil)
      cb(true)
    end
  end
end

function M:_notify_state_changed(ext_info)
  if self._data.update_state_listener then
    self._data.update_state_listener(self._data.namespace, self._data.res_key, self._data.update_state.state, self._data.update_state, ext_info)
  end
end

function M:_test_notify_state_complete()
  self._data.update_state.state = _STATES.FINISH
  self:_notify_state_changed()
end

function M:_init(_namespace, _res_key, _update_info, _using_res_info, _namespace_ext, _startup_params, _startup_update_opts, _update_state_listener)
  local fsm_callbacks = {
    ["on" .. _EVENTS.START_UPDATE] = function(_fsm, from, ...)
      if from == _STATES.DOWNLOAD_FAILED then
        self:log_debug("START_UPDATE receive in download fail state")
        local confirmed_update_info = self._data.confirmed_update_info
        local confirmed_update_ver = self._data.confirmed_update_ver
        if not confirmed_update_ver or not confirmed_update_info then
          self:log_warn("resume update with local state error, transition to idle state")
          self:_fsm_enqueue_event_at_front(_EVENTS.RESET_UPDATE)
        else
          self:_fsm_enqueue_event_at_front(_EVENTS.ON_UPDATE_CONFIRMED, confirmed_update_ver, confirmed_update_info)
        end
        return FSM.SYNC
      elseif from == _STATES.APPLY_FAILED then
        self:log_debug("START_UPDATE receive in apply fail state")
        self:_fsm_enqueue_event_at_front(_EVENTS.ON_DOWNLOAD_COMPLETE_APPLY)
        return FSM.SYNC
      elseif from == _STATES.IDLE then
        self:log_debug("START_UPDATE received from idle state, now start check update state")
        self:_fsm_transition_to(from, _STATES.CHECKING)
        local init_result, code, msg = self:_init_task()
        if init_result then
          self:_check_update_state(function(succ, ...)
            if succ then
              self:_fsm_enqueue_event_at_front(_EVENTS.ON_CHECK_UPDATE_SUCC, ...)
            else
              self:_fsm_enqueue_event_at_front(_EVENTS.ON_CHECK_UPDATE_FAILED, ...)
            end
            self:_fsm_on_async_event_finished(_EVENTS.START_UPDATE)
          end)
          return FSM.AYNC
        else
          self:_fsm_enqueue_event_at_front(_EVENTS.ON_CHECK_UPDATE_FAILED, code, msg)
          return FSM.SYNC
        end
      else
        self.log_debug("START_UPDATE received from other state, now notify state changed")
        self:_notify_state_changed()
      end
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.RESET_UPDATE] = function(_fsm, from, ...)
      self:log_debug("RESET_UPDATE received at state:" .. tostring(from))
      if from == _STATES.IDLE then
        self:_fsm_enqueue_event_at_front(_EVENTS.START_UPDATE)
        return FSM.SYNC
      elseif from == _STATES.CHECKING or from == _STATES.CONFIRMING or from == _STATES.APPLYING then
        self:_fsm_enqueue_event_at_front(_EVENTS.RESET_UPDATE)
        return FSM.SYNC
      elseif from == _STATES.DOWNLOADING or from == _STATES.DOWNLOAD_COMPLETE or from == _STATES.DOWNLOAD_FAILED or from == _STATES.APPLY_FAILED or from == _STATES.FINISH then
        self:_fsm_transition_to(from, _STATES.CHECKING)
        self:_check_update_state(function(succ, ...)
          if succ then
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_CHECK_UPDATE_SUCC, ...)
          else
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_CHECK_UPDATE_FAILED, ...)
          end
          self:_fsm_on_async_event_finished(_EVENTS.RESET_UPDATE)
        end)
        return FSM.AYNC
      end
      return FSM.SYNC
    end,
    ["on" .. _EVENTS.ON_CHECK_UPDATE_FAILED] = function(_fsm, from, ...)
      if from ~= _STATES.CHECKING then
        return
      end
      local code, msg = ...
      return FSM.SYNC, _STATES.IDLE, code, msg
    end,
    ["on" .. _EVENTS.ON_CHECK_UPDATE_SUCC] = function(_fsm, from, ...)
      self:_fsm_transition_to(from, _STATES.CONFIRMING)
      local has_new_update, checked_update_info = ...
      checked_update_info = checked_update_info or {}
      self:log_debug("_check_update_state succ, now wait biz confirm, has_new_update:" .. tostring(has_new_update))
      self:_check_update_confirm(has_new_update, checked_update_info, function(is_confirmed, ...)
        self:log_debug("_check_update_confirm result:" .. tostring(is_confirmed))
        if is_confirmed then
          local update_ver = (...)
          self._data.confirmed_update_info = checked_update_info
          self._data.confirmed_update_ver = update_ver
          self:_fsm_enqueue_event_at_front(_EVENTS.ON_UPDATE_CONFIRMED, update_ver, checked_update_info)
        else
          self:_fsm_enqueue_event_at_front(_EVENTS.ON_UPDATE_CONFIRM_SKIP)
        end
        self:_fsm_on_async_event_finished(_EVENTS.ON_CHECK_UPDATE_SUCC)
      end)
      return FSM.ASYNC
    end,
    ["on" .. _EVENTS.ON_UPDATE_CONFIRM_SKIP] = function(_fsm, _from, ...)
      self:log_debug("ON_UPDATE_CONFIRM_SKIP received")
      return FSM.SYNC, _STATES.FINISH
    end,
    ["on" .. _EVENTS.ON_DOWNLOAD_FAILED] = function(_fsm, _from, ...)
      self:log_debug("ON_DOWNLOAD_FAILED received")
      return FSM.SYNC, _STATES.DOWNLOAD_FAILED, ...
    end,
    ["on" .. _EVENTS.ON_APPLY_SUCC] = function(_fsm, _from, ...)
      self:log_debug("ON_APPLY_SUCC received")
      return FSM.SYNC, _STATES.FINISH, ...
    end,
    ["on" .. _EVENTS.ON_APPLY_FAILED] = function(_fsm, _from, ...)
      self:log_debug("ON_APPLY_FAILED received")
      return FSM.SYNC, _STATES.APPLY_FAILED, ...
    end,
    ["on" .. _EVENTS.ON_DOWNLOAD_COMPLETE] = function(_fsm, _from, ...)
      self:log_debug("ON_DOWNLOAD_COMPLETE received")
      self:_fsm_enqueue_event_at_front(_EVENTS.ON_DOWNLOAD_COMPLETE_APPLY)
      return FSM.SYNC, _STATES.DOWNLOAD_COMPLETE, ...
    end,
    ["on" .. _EVENTS.ON_DOWNLOAD_COMPLETE_APPLY] = function(_fsm, _from, ...)
      self:log_debug("ON_DOWNLOAD_COMPLETE_APPLY received")
      self:_fsm_transition_to(nil, _STATES.APPLYING)
      
      local function __check_res_pre_apply()
        self:_check_res_pre_apply(function(pre_apply_succ, ...)
          if pre_apply_succ then
            self:_check_res_patch_apply(function(succ, ...)
              if succ then
                self:_fsm_enqueue_event_at_front(_EVENTS.ON_APPLY_SUCC)
              else
                self:_fsm_enqueue_event_at_front(_EVENTS.ON_APPLY_FAILED, ...)
              end
              self:_fsm_on_async_event_finished(_EVENTS.ON_DOWNLOAD_COMPLETE_APPLY)
            end)
          else
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_APPLY_FAILED, ...)
            self:_fsm_on_async_event_finished(_EVENTS.ON_DOWNLOAD_COMPLETE_APPLY)
          end
        end)
      end
      
      if self._data.has_new_update == true then
        END.dispatch_confirm_res_patch(self._data.namespace, self._data.res_key, __check_res_pre_apply)
      else
        __check_res_pre_apply()
      end
      return FSM.ASYNC
    end,
    ["on" .. _EVENTS.ON_UPDATE_CONFIRMED] = function(_fsm, _from, ...)
      self:log_debug("ON_UPDATE_CONFIRMED received")
      self:_fsm_transition_to(_from, _STATES.DOWNLOADING)
      local update_ver, checked_update_info = ...
      self:_confirm_download(update_ver, checked_update_info, function(succ, ...)
        if succ then
          local res_state_infos = (...)
          self:_fsm_enqueue_event_at_front(_EVENTS.ON_DOWNLOAD_COMPLETE, res_state_infos)
        else
          local code, msg = ...
          if code == RTM.PUBLIC_DOWNLOAD_STATE.SKIP then
            self:log_debug("SKIP DOWNLOAD CONFIRM: " .. tostring(msg or ""))
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_UPDATE_CONFIRM_SKIP)
          elseif code == RTM.PUBLIC_DOWNLOAD_STATE.WAITTING then
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_DOWNLOAD_WAITING)
            return
          elseif code == RTM.PUBLIC_DOWNLOAD_STATE.DOWNLOADING then
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_DOWNLOAD_ING)
            return
          else
            self:_fsm_enqueue_event_at_front(_EVENTS.ON_DOWNLOAD_FAILED, code, msg)
          end
        end
        self:_fsm_on_async_event_finished(_EVENTS.ON_UPDATE_CONFIRMED)
      end)
      return FSM.ASYNC
    end,
    ["on" .. _EVENTS.ON_DOWNLOAD_WAITING] = function(_fsm, _from, ...)
      self:log_debug("ON_DOWNLOAD_WAITING received")
      return FSM.SYNC, _STATES.DOWNLOAD_WAITING, ...
    end,
    ["on" .. _EVENTS.ON_DOWNLOAD_ING] = function(_fsm, _from, ...)
      self:log_debug("ON_DOWNLOADING received")
      return FSM.SYNC, _STATES.DOWNLOADING, ...
    end,
    ["onenter" .. _STATES.IDLE] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.IDLE))
      local code, msg = ...
      E.LOG.warn(TAG, "idle state, ns:" .. tostring(self._data.namespace) .. ", res_key:" .. tostring(self._data.res_key) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      self._data.update_state.state = _STATES.IDLE
      self._data.update_state.err_code = code
      self._data.update_state.err_msg = msg
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.CHECKING] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.CHECKING))
      self._data.update_state.state = _STATES.CHECKING
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.CONFIRMING] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.CONFIRMING))
      self._data.update_state.state = _STATES.CONFIRMING
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.DOWNLOADING] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.DOWNLOADING))
      self._data.update_state.state = _STATES.DOWNLOADING
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      local ns = self._data.namespace
      local rk = self._data.res_key
      END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_RES_DOWNLOADING, ns, rk)
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.DOWNLOAD_WAITING] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.DOWNLOAD_WAITING))
      self._data.update_state.state = _STATES.DOWNLOAD_WAITING
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.DOWNLOAD_COMPLETE] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.DOWNLOAD_COMPLETE))
      self._data.update_state.state = _STATES.DOWNLOAD_COMPLETE
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      local res_state_infos = (...)
      local ns = self._data.namespace
      local rk = self._data.res_key
      END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_RES_DOWNLOAD_COMPLETE, ns, rk, res_state_infos)
      self:_notify_state_changed(res_state_infos)
    end,
    ["onenter" .. _STATES.DOWNLOAD_FAILED] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.DOWNLOAD_FAILED))
      self._data.update_state.state = _STATES.DOWNLOAD_FAILED
      local code, msg = ...
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.DOWNLOAD_FAILED) .. ",code:" .. tostring(code) .. ",msg:" .. tostring(msg))
      self._data.update_state.err_code = code
      self._data.update_state.err_msg = msg
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.APPLYING] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.APPLYING))
      self._data.update_state.state = _STATES.APPLYING
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      local ns = self._data.namespace
      local rk = self._data.res_key
      END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_RES_APPLYING, ns, rk)
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.APPLY_FAILED] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.APPLY_FAILED))
      self._data.update_state.state = _STATES.APPLY_FAILED
      local code, msg = ...
      self._data.update_state.err_code = code
      self._data.update_state.err_msg = msg
      self:_notify_state_changed()
    end,
    ["onenter" .. _STATES.FINISH] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "update task onenter > " .. tostring(_STATES.FINISH))
      self._data.update_state.state = _STATES.FINISH
      self._data.update_state.err_code = 0
      self._data.update_state.err_msg = nil
      if _from == _STATES.APPLYING then
        local ns = self._data.namespace
        local rk = self._data.res_key
        local res_state_infos = self._data.res_model:get_res_state()
        END.publish_startup_state_changed(END.STARTUP_UPDATE_STATES.STARTUP_RES_APPLY_SUCC, ns, rk, res_state_infos)
      end
      self:_notify_state_changed()
    end
  }
  local _update_fsm = FSM.create({
    initial = _STATES.IDLE,
    events = {
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.IDLE,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.DOWNLOAD_FAILED,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.APPLY_FAILED,
        to = _STATES.APPLYING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.CHECKING,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.CONFIRMING,
        to = _STATES.CONFIRMING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.DOWNLOADING,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.DOWNLOAD_COMPLETE,
        to = _STATES.DOWNLOAD_COMPLETE
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.APPLYING,
        to = _STATES.APPLYING
      },
      {
        name = _EVENTS.START_UPDATE,
        from = _STATES.FINISH,
        to = _STATES.FINISH
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.IDLE,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.CHECKING,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.CONFIRMING,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.DOWNLOADING,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.DOWNLOAD_COMPLETE,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.DOWNLOAD_FAILED,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.APPLYING,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.APPLY_FAILED,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.RESET_UPDATE,
        from = _STATES.FINISH,
        to = _STATES.CHECKING
      },
      {
        name = _EVENTS.ON_CHECK_UPDATE_FAILED,
        from = _STATES.CHECKING,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.ON_CHECK_UPDATE_SUCC,
        from = _STATES.CHECKING,
        to = _STATES.CONFIRMING
      },
      {
        name = _EVENTS.ON_UPDATE_CONFIRMED,
        from = _STATES.CONFIRMING,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.ON_UPDATE_CONFIRMED,
        from = _STATES.DOWNLOAD_FAILED,
        to = _STATES.DOWNLOADING
      },
      {
        name = _EVENTS.ON_UPDATE_CONFIRM_SKIP,
        from = _STATES.CONFIRMING,
        to = _STATES.FINISH
      },
      {
        name = _EVENTS.ON_UPDATE_CONFIRM_SKIP,
        from = _STATES.DOWNLOADING,
        to = _STATES.FINISH
      },
      {
        name = _EVENTS.ON_DOWNLOAD_COMPLETE,
        from = _STATES.DOWNLOADING,
        to = _STATES.DOWNLOAD_COMPLETE
      },
      {
        name = _EVENTS.ON_DOWNLOAD_FAILED,
        from = _STATES.DOWNLOADING,
        to = _STATES.DOWNLOAD_FAILED
      },
      {
        name = _EVENTS.ON_DOWNLOAD_COMPLETE_APPLY,
        from = _STATES.DOWNLOAD_COMPLETE,
        to = _STATES.APPLYING
      },
      {
        name = _EVENTS.ON_DOWNLOAD_COMPLETE_APPLY,
        from = _STATES.APPLY_FAILED,
        to = _STATES.APPLYING
      },
      {
        name = _EVENTS.ON_APPLY_FAILED,
        from = _STATES.APPLYING,
        to = _STATES.APPLY_FAILED
      },
      {
        name = _EVENTS.ON_APPLY_SUCC,
        from = _STATES.APPLYING,
        to = _STATES.FINISH
      },
      {
        name = _EVENTS.ON_DOWNLOAD_WAITING,
        from = _STATES.DOWNLOADING,
        to = _STATES.DOWNLOAD_WAITING
      },
      {
        name = _EVENTS.ON_DOWNLOAD_ING,
        from = _STATES.DOWNLOAD_WAITING,
        to = _STATES.DOWNLOADING
      }
    },
    callbacks = fsm_callbacks
  })
  self._data = {
    namespace = _namespace,
    res_key = _res_key,
    res_type = nil,
    server_update_info = _update_info or {},
    update_state_listener = _update_state_listener,
    using_res_info = _using_res_info,
    namespace_ext = _namespace_ext,
    startup_update_opts = _startup_update_opts or {},
    startup_update_params = _startup_params or {},
    fsm = _update_fsm,
    has_new_update = nil,
    update_state = {
      state = _STATES.IDLE,
      err_code = 0,
      err_msg = nil
    },
    inner_res_opts = nil,
    res_model = nil,
    confirmed_update_ver = nil,
    confirmed_update_info = nil,
    res_save_base_path = nil,
    res_save_storage_type = RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  }
  _ejoysdk.log("init params:" .. tostring(_startup_params))
  E.log(_startup_params)
  _tasks_cache[_namespace] = _tasks_cache[_namespace] or {}
  _tasks_cache[_namespace][_res_key] = self
end

function M:start()
  self:log_debug("start invoke")
  self:_fsm_enqueue_event(_EVENTS.START_UPDATE)
end

function M:reset(_update_info, _using_res_info)
  self:log_debug("reset invoke")
  if _update_info and next(_update_info) ~= nil then
    self:log_debug("reset with new update_info")
    E.log(_update_info)
    self._data.server_update_info = _update_info
  end
  if _using_res_info and next(_using_res_info) ~= nil then
    self:log_debug("reset with new using_res_info")
    E.log(_using_res_info)
    self._data.using_res_info = _using_res_info
  end
  if self._data.res_model then
    self._data.res_model:_reset_downloading_info()
    self._data.res_model:_reset_downloading_state()
  end
  self:_fsm_enqueue_event_at_front(_EVENTS.RESET_UPDATE)
end

function M:cancel_update(cb)
  self:log_debug("cancel_update, state:" .. self._data.update_state.state)
  if self._data.update_state.state == _STATES.DOWNLOADING then
    self._data.res_model:cancel_download(function(succ, ...)
      if true == succ then
        self:log_debug("stop downloading")
      else
        local code, msg = ...
        self:log_debug("stop downloading failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      end
      cb(succ, ...)
    end)
  else
    cb(false, CC.RESOURCE_UPDATE_ERROR_CODES.RES_UPDATE_CANCEL_FAILED, "not in downloading, current_state:" .. self._data.update_state.state)
  end
end

function M:remove_update(cb)
  self._data.res_model:remove_download(function(succ, ...)
    if true == succ then
      self:log_debug("remove downloading succ")
    else
      local code, msg = ...
      self:log_debug("remove downloading failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M:update_config(config)
  E.LOG.d("demonk_config", {update_task_config = config})
  self._data.res_model:update_download_config(config)
end

function M.get_task(namespace, res_key)
  if not UTILS.is_text_empty(namespace) and not UTILS.is_text_empty(res_key) then
    return (_tasks_cache[namespace] or {})[res_key]
  end
  return nil
end

return M
