local E = require("ejoysdk_lua.ejoysdk")
local FLOW_TASK = require("ejoysdk_lua.libs.flow_task")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local STAT = require("ejoysdk_lua.res.res_stat")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local UT = require("ejoysdk_lua.res.startup.modules.update_task")
local UIM = require("ejoysdk_lua.res.update_info_manager")
local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
local MODULE_NAME = SC.STARTUP_CORE_MODULE_NAME.RES_UPDATE_CHECK
local TAG = MODULE_NAME
local M = FLOW_TASK:new(MODULE_NAME)
local RES_UPDATING_STATE = {
  CHECKING = 0,
  UPDATE_COMPLETE = 1,
  UPDATE_FAILED = -1
}
local updating_res_state = {}
local updating_tasks = {}
local startup_res_update_state = false

local function namespace_res_key(namespace, res_key)
  return tostring(namespace) .. "@" .. tostring(res_key)
end

local function current_res_update_state(namespace, res_key)
  local k = namespace_res_key(namespace, res_key)
  return updating_res_state[k]
end

local function update_res_updating_state(namespace, res_key, updating_state, update_complete_cb)
  if utils.is_text_empty(namespace) or utils.is_text_empty(res_key) then
    EL.LOG.warn(TAG, "update_res_updating_state skip for namespace or res_key is empty")
    return
  end
  EL.LOG.debug(TAG, string.format("update_res_updating_state ns:%s, rk:%s, state:%s", tostring(namespace), tostring(res_key), tostring(updating_state)))
  local key = namespace_res_key(namespace, res_key)
  updating_res_state[key] = updating_state
  local is_all_complete = true
  for _, state in pairs(updating_res_state) do
    if state ~= RES_UPDATING_STATE.UPDATE_COMPLETE then
      is_all_complete = false
      break
    end
  end
  local has_checking_task = false
  if is_all_complete then
    EL.LOG.debug(TAG, "update_res_updating_state all update complete, now cb succ")
    if update_complete_cb then
      update_complete_cb(true)
    end
  else
    for _, state in pairs(updating_res_state) do
      if state == RES_UPDATING_STATE.CHECKING then
        has_checking_task = true
        break
      end
    end
  end
  return is_all_complete, has_checking_task
end

function M:_check_res_update(cb)
  local startup_update_infos = SC.get_game_startup_res_update_infos()
  local update_namespace_exts = SC.get_namespace_ext_infos()
  local local_res_params = SC.get_startup_local_res_infos()
  local _startup_params, startup_update_opts = SC.get_game_startup_params()
  
  local function startup_update_complete(succ, ...)
    EL.LOG.debug(TAG, "_check_res_update_state update complete")
    startup_res_update_state = succ
    cb(succ, ...)
  end
  
  local is_force = SC.is_force_check_update()
  if startup_res_update_state and not is_force then
    EL.LOG.debug(TAG, "startup update has completed, return")
    startup_update_complete(true)
    return
  end
  EL.LOG.debug(TAG, "_check_res_update begin with startup_update_infos >>")
  E.log(startup_update_infos)
  if next(startup_update_infos) == nil then
    EL.LOG.debug(TAG, "no startup_update_infos, skip update, just return")
    startup_update_complete(true)
    return
  end
  EL.LOG.debug(TAG, "_startup_params >>>")
  E.log(_startup_params)
  local is_force_check_update = SC.is_force_check_update()
  if next(updating_res_state) == nil or is_force_check_update then
    for ns, res_map in pairs(startup_update_infos) do
      for rk, _ in pairs(res_map) do
        if _startup_params[ns] and _startup_params[ns][rk] then
          update_res_updating_state(ns, rk, RES_UPDATING_STATE.CHECKING)
        end
      end
    end
  end
  local pending_update_infos = {}
  for ns, res_map in pairs(startup_update_infos) do
    for rk, uinfo in pairs(res_map) do
      if _startup_params[ns] and _startup_params[ns][rk] then
        local cur_update_state = current_res_update_state(ns, rk)
        EL.LOG.debug(TAG, string.format("rk:%s, state is :%s ", tostring(rk), tostring(cur_update_state)))
        if cur_update_state ~= RES_UPDATING_STATE.UPDATE_COMPLETE then
          pending_update_infos[ns] = pending_update_infos[ns] or {}
          pending_update_infos[ns][rk] = uinfo
          update_res_updating_state(ns, rk, RES_UPDATING_STATE.CHECKING)
        end
      end
    end
  end
  EL.LOG.debug(TAG, "current pending update infos >>")
  E.log(pending_update_infos)
  self:_test_set_pending_list(pending_update_infos)
  if next(pending_update_infos) == nil then
    EL.LOG.debug(TAG, "pending_update_infos is empty")
    startup_update_complete(true)
    return
  end
  SC.update_startup_update_infos(pending_update_infos)
  UIM.add_update_infos(pending_update_infos)
  for ns, res_map in pairs(pending_update_infos) do
    update_namespace_exts = update_namespace_exts or {}
    local namespace_ext = update_namespace_exts[ns] or {}
    for _res_key, _ in pairs(res_map) do
      local _update_info = UIM.get_res_update_info(ns, _res_key)
      local ns_res_info = local_res_params[ns] or {}
      local res_info = ns_res_info[_res_key] or {}
      local using_res_info = res_info
      local task_key = namespace_res_key(ns, _res_key)
      local update_task = updating_tasks[task_key]
      if not update_task then
        local retry_times = 0
        local max_retry_times = SC.get_max_retry_times()
        
        local function _update_state_listener(_ns, _rk, _state, _state_obj, ...)
          EL.LOG.debug(TAG, string.format("_update_state_listener ns:%s, rk:%s, state:%s", tostring(_ns), tostring(_rk), tostring(_state)))
          E.log(_state_obj)
          _state_obj = _state_obj or {}
          if _state == UT.PUB_STATES.FINISH then
            EL.LOG.debug(TAG, "state complete")
            update_res_updating_state(_ns, _rk, RES_UPDATING_STATE.UPDATE_COMPLETE, startup_update_complete)
          elseif _state == UT.PUB_STATES.APPLY_FAILED or _state == UT.PUB_STATES.DOWNLOAD_FAILED or _state == UT.PUB_STATES.IDLE then
            local err_code = _state_obj.err_code
            local err_msg = _state_obj.err_msg
            EL.LOG.warn(TAG, string.format("resource process failed, ns:%s, rk:%s, state:%s, code:%s, msg:%s", tostring(_ns), tostring(_rk), tostring(_state), tostring(err_code), tostring(err_msg)))
            STAT.stat_on_res_update_fail(_ns, _rk, err_code, err_msg, _state, nil, true)
            local _is_all_complete, has_checking_task = update_res_updating_state(_ns, _rk, RES_UPDATING_STATE.UPDATE_FAILED)
            if not _is_all_complete and not has_checking_task then
              EL.LOG.warn(TAG, string.format("receive res err, now not is all complete and not has_checking_task, so notify on_global_failed, code:%s,msg:%s", tostring(err_code), tostring(err_msg)))
              startup_update_complete(false, err_code, err_msg)
            else
              local dispatch_retry_succ = END.dispatch_res_failed_retry_listener(_ns, _rk, function()
                EL.LOG.debug(TAG, "receive retry callback")
                retry_times = retry_times + 1
                if retry_times > max_retry_times then
                  EL.LOG.warn(TAG, "reach max retry times, now callback global failed")
                  retry_times = 0
                  startup_update_complete(false, err_code, err_msg)
                else
                  update_task:start()
                end
              end, err_code, err_msg)
              if not dispatch_retry_succ then
                EL.LOG.warn(TAG, "game not override on_res_failed_retry_listener, so callback global failed")
                startup_update_complete(false, err_code, err_msg)
              end
            end
          end
        end
        
        local preDownload_info = _update_info and _update_info.predownload
        if preDownload_info and next(preDownload_info) then
          local predownload_mgr = PREDOWNLOAD_MGR.static_get_mgr(ns, _res_key)
          predownload_mgr:update_info(_update_info)
        end
        update_task = UT:New(ns, _res_key, _update_info, using_res_info, namespace_ext, _startup_params, startup_update_opts, _update_state_listener)
        updating_tasks[task_key] = update_task
      end
      STAT.stat_check_res_update_state_begin(ns, _res_key, is_force_check_update)
      if is_force_check_update then
        EL.LOG.debug(TAG, string.format("is_force_check_update now do reset, ns:%s, rk:%s", tostring(ns), tostring(_res_key)))
        update_task:reset(_update_info, using_res_info)
      else
        EL.LOG.debug(TAG, string.format("now do start, ns:%s, rk:%s", tostring(ns), tostring(_res_key)))
        update_task:start()
      end
    end
  end
end

function M:_init(_module_mgr_instance)
  self._data = {module_instance = _module_mgr_instance}
end

function M:run()
  E.LOG.debug(TAG, "begin run")
  STAT.stat_update_check_begin()
  self:_check_res_update(function(succ, ...)
    if succ then
      EL.LOG.debug(TAG, "_check_res_update succ, now run next")
      STAT.stat_update_check_end(true)
      self:run_next()
    else
      local code, msg = ...
      E.LOG.debug(TAG, string.format("_check_res_update failed, code:%s, msg:%s", tostring(code), tostring(msg)))
      STAT.stat_update_check_end(false, code, msg)
      self._data.module_instance.on_global_failed(code, msg)
    end
  end)
end

function M:_test_set_pending_list(_pending_update_infos)
end

function M:get_update_task(namespace, res_key)
  local task_key = namespace_res_key(namespace, res_key)
  local update_task = updating_tasks[task_key]
  return update_task
end

return M
