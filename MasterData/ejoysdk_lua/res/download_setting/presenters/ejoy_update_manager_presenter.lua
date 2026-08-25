local E = require("ejoysdk_lua.ejoysdk")
local BUM = require("ejoysdk_lua.res.download_setting.background_update_manager")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local BACKGROUND_DOWNLOAD_ERROR_CODES = CONSTANTS.BACKGROUND_DOWNLOAD_ERROR_CODES
local TAG = "DOWNLOAD_SETTING#presenters#ejoy_update_manager_presenter"
local M = {}

function M.update_network_strategy(strategy_name)
  if "both_mobile_wifi_network" == strategy_name or "wifi_only" == strategy_name then
    BUM.set_background_network_strategy(strategy_name)
    local ST = require("ejoysdk_lua.res.model.strategies.network_strategy")
    ST.update_strategy(strategy_name)
  else
    E.LOG.debug("update_network_strategy", "invalid network strategy name:" .. tostring(strategy_name))
    return
  end
end

function M.set_background_download_switch(switch_state)
  if true == switch_state then
    BUM.jf_commit_open_background_download_event()
  end
  BUM.set_background_download_switch_state(switch_state)
end

local function control_task_util(operate_type, params, cb)
  local all_tasks = BUM.get_background_download_tasks()
  local task = all_tasks[params.task_id]
  if task then
    local method = task[operate_type]
    local task_method_params = {}
    if params.task_type == BUM.BACKGROUND_UPDATE_TYPE.APP_UPDATE and "start_task" == operate_type and params.is_slient then
      task_method_params.need_jump_outside_update = false
    end
    if method and type(method) == "function" then
      local RDM = require("ejoysdk_lua.res.res_download_mutex")
      local lock_ok, lock_err = RDM.try_acquire_download_lock()
      if not lock_ok then
        E.LOG.debug(TAG, "startup_res_update lock failed: " .. tostring(lock_err))
        local err_code = CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_UPDATE_MUTEX_LOCKED
        local err_msg = "Another process is updating resources"
        cb(false, err_code, err_msg)
        return
      end
      method(task_method_params, function(succ, ...)
        if succ then
          E.LOG.debug("control_task_util", "success:", operate_type, params.task_id)
          cb(true)
          if "remove_task" == operate_type then
            BUM.remove_task_from_cache(params.task_id)
          end
        else
          cb(false, ...)
        end
        RDM.release_download_lock()
      end)
      return
    else
      cb(false, BACKGROUND_DOWNLOAD_ERROR_CODES.METHOD_NOT_FOUND, "method not found: " .. tostring(operate_type))
      return
    end
  end
  cb(false, BACKGROUND_DOWNLOAD_ERROR_CODES.TASK_NOT_FOUND, "task not found")
end

function M.stop_task(params, cb)
  control_task_util("stop_task", params, cb)
end

function M.start_task(params, cb)
  local ST = require("ejoysdk_lua.res.model.strategies.network_strategy")
  local strategy_name = BUM.get_background_network_strategy()
  ST.update_strategy(strategy_name)
  control_task_util("start_task", params, cb)
  local all_tasks = BUM.get_background_download_tasks()
  local task_instance = all_tasks[params.task_id]
  task_instance.get_task_info({}, function(result)
    if result and result.task_info then
      local version_name = result.task_info.res_version
      BUM.add_user_trigger_task(params.task_id, version_name)
      E.LOG.debug("start_task", "start_task: task_id=" .. params.task_id .. ", version=" .. version_name)
      E.log(result)
      BUM.clear_download_btn_red_dot(params.task_id, version_name)
    end
  end)
end

function M.remove_task(params, cb)
  control_task_util("remove_task", params, cb)
end

function M.install_task(params, cb)
  local all_tasks = BUM.get_background_download_tasks()
  local task = all_tasks[params.task_id]
  if task then
    task.get_task_info({}, function(result)
      local res_version = result.task_info.res_version
      if res_version then
        E.LOG.debug(TAG, "clear install btn red dot, task type:" .. tostring(params.task_id))
        BUM.clear_install_btn_red_dot(params.task_id, res_version)
      end
    end)
  end
  control_task_util("install_task", params, cb)
end

local function copy_task_state_from_cache(cached_task_state)
  return {
    state = cached_task_state.status,
    download_info = {
      percent = cached_task_state.progress,
      downloading_size = cached_task_state.downloadedSize,
      speed = 0,
      total_size = cached_task_state.totalSize
    },
    state_info = {
      code = cached_task_state.errorCode,
      msg = cached_task_state.errorMsg,
      type = cached_task_state.errorType
    }
  }
end

function M.get_task_state(params, cb)
  local background_download_task_states = BUM.get_background_download_task_states()
  local task_state = background_download_task_states[params.task_id]
  E.LOG.debug(TAG, "get_task_state, background_download_task_states: ")
  E.log(background_download_task_states)
  local cached_task_state = BUM.get_task_info_from_cache()[params.task_id]
  if task_state then
    task_state.has_update_notification = BUM.get_btn_reddot_state({
      task_id = params.task_id,
      res_version = params.res_version,
      reddot_btn_type = BUM.REDDOT_BTN_TYPE.DONWLOAD_RED_DOT
    })
    task_state.has_install_notification = BUM.get_btn_reddot_state({
      task_id = params.task_id,
      res_version = params.res_version,
      reddot_btn_type = BUM.REDDOT_BTN_TYPE.INSTALL_RED_DOT
    })
    if task_state.state == BUM.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED and next(cached_task_state) ~= nil and cached_task_state.status == BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE then
      task_state = copy_task_state_from_cache(cached_task_state)
    end
    cb(task_state)
  elseif cached_task_state then
    local _task_state = copy_task_state_from_cache(cached_task_state)
    cb(_task_state)
  else
    cb("task state not found")
  end
end

function M.set_new_version_modal_visible(visible)
  E.LOG.debug(TAG, "set_new_version_modal_visible: " .. tostring(visible))
  if type(visible) == "boolean" then
    BUM.set_new_version_modal_visible(visible)
  end
end

function M.get_background_tasks_detail(cb)
  if type(cb) == "function" then
    BUM.get_tasks_detail({}, cb)
  else
    cb(false, BACKGROUND_DOWNLOAD_ERROR_CODES.PARAMS_NOT_COMPLETE, "cb is invalid")
  end
end

function M.get_user_download_settings(cb)
  local network_strategy = BUM.get_background_network_strategy()
  local new_version_modal_visible = BUM.get_new_version_modal_visible()
  local silent_download = BUM.get_background_download_switch_state()
  local display_new_pkg_switch = false
  if BUM.REGISTERED_TASK_TYPES[BUM.BACKGROUND_UPDATE_TYPE.APP_UPDATE] then
    display_new_pkg_switch = true
  end
  local settings = {
    network_strategy = network_strategy,
    new_version_modal_visible = new_version_modal_visible,
    silent_download = silent_download,
    display_new_pkg_switch = display_new_pkg_switch
  }
  if cb and type(cb) == "function" then
    E.LOG.debug(TAG, "user download settings:")
    E.log(settings)
    cb(settings)
  end
end

function M.get_model_type(cb)
  local modal_type = BUM.MODAL_TYPE
  if cb and type(cb) == "function" then
    cb(modal_type)
  end
end

function M.get_current_network_type(cb)
  local network_type = E.Sysinfo.network_type()
  local result = ""
  if 0 == network_type then
    result = "no_network"
  elseif 1 == network_type then
    result = "wifi"
  elseif 2 == network_type or 3 == network_type then
    result = "mobile"
  else
    result = "unknown"
  end
  if cb and type(cb) == "function" then
    E.LOG.debug("get_current_network_type", "network_type:" .. tostring(network_type) .. ", result:" .. result)
    cb(result)
  end
end

function M.page_track(funciton_name, action_name, _params)
  E.LOG.debug("page_track", "function_name:" .. funciton_name .. ", action_name:" .. action_name)
  BUM.background_download_track(funciton_name, action_name, _params)
end

local current_confirm_cb, current_clear_complete_cb

function M.is_support_clear(_params, cb)
  cb(BUM.is_enable_clear())
end

function M.get_clear_info(_params, cb)
  E.LOG.debug(TAG, "get_clear_info called")
  cb = cb or function()
  end
  current_confirm_cb = nil
  current_clear_complete_cb = nil
  local ERF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  ERF.clear_invalid_res({
    on_confirm_res_clear = function(clear_info, confirm_cb)
      E.LOG.debug(TAG, "on_confirm_res_clear: ")
      E.log(clear_info)
      current_confirm_cb = confirm_cb
      local result = {
        success = true,
        need_clear = clear_info.need_clear or false,
        clear_info = clear_info
      }
      cb(result)
    end,
    on_res_clear_complete = function(is_succ, code, msg)
      E.LOG.debug(TAG, "on_res_clear_complete, is_succ:" .. tostring(is_succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      if current_clear_complete_cb then
        local result = {success = is_succ}
        if not is_succ then
          result.error_info = {
            code = code or -1,
            message = msg or "clear failed"
          }
        end
        current_clear_complete_cb(result)
        current_clear_complete_cb = nil
      end
      if not current_confirm_cb and cb then
        E.LOG.debug(TAG, "on_res_clear_complete: no confirm_cb, callback to get_clear_info")
        local result = {
          success = is_succ,
          need_clear = false,
          error_info = not is_succ and {
            code = code or -1,
            message = msg or "clear failed"
          } or nil
        }
        cb(result)
        
        function cb()
        end
      end
      if is_succ then
        BUM.background_download_track("clear_cache", "clear_complete", {is_priority_high = true})
      else
        BUM.background_download_track("clear_cache", "clear_failed", {is_priority_high = true, error_code = code})
      end
    end
  })
end

function M.start_clear_res(_params, cb)
  E.LOG.debug(TAG, "start_clear_res called")
  cb = cb or function()
  end
  if not current_confirm_cb then
    E.LOG.e(TAG, "start_clear_res: no confirm_cb available")
    cb({
      success = false,
      error_info = {
        code = -1,
        message = "no confirm_cb available"
      }
    })
    return
  end
  current_clear_complete_cb = cb
  current_confirm_cb(true)
end

function M.cancel_clear_res(_params, cb)
  E.LOG.debug(TAG, "cancel_clear_res called")
  cb = cb or function()
  end
  if not current_confirm_cb then
    E.LOG.e(TAG, "cancel_clear_res: no confirm_cb available")
    cb({
      success = false,
      error_info = {
        code = -1,
        message = "no confirm_cb available"
      }
    })
    return
  end
  current_confirm_cb(false)
  current_confirm_cb = nil
  current_clear_complete_cb = nil
  cb({success = true})
end

return M
