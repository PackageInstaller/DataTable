local E = require("ejoysdk_lua.ejoysdk")
local AUM = require("ejoysdk_lua.res.app_update.app_update_manager")
local BUM = require("ejoysdk_lua.res.download_setting.background_update_manager")
local Task = {}
local M = {}
local TAG = "EjoyAppUpdate#Task"
local state_map = {
  [AUM.APP_UPDATE_STATE.DOWNLOAD_NOT_STARTED] = BUM.TASK_UPDATE_STATE.DOWNLOAD_NOT_STARTED,
  [AUM.APP_UPDATE_STATE.DOWNLOADING] = BUM.TASK_UPDATE_STATE.DOWNLOADING,
  [AUM.APP_UPDATE_STATE.DOWNLOAD_FAILED] = BUM.TASK_UPDATE_STATE.DOWNLOAD_FAILED,
  [AUM.APP_UPDATE_STATE.DOWNLOAD_STOPPED] = BUM.TASK_UPDATE_STATE.DOWNLOAD_STOPPED,
  [AUM.APP_UPDATE_STATE.DOWNLOAD_COMPLETE] = BUM.TASK_UPDATE_STATE.DOWNLOAD_COMPLETE,
  [AUM.APP_UPDATE_STATE.DOWNLOAD_WAITING] = BUM.TASK_UPDATE_STATE.DOWNLOAD_WAITING,
  [AUM.APP_UPDATE_STATE.INSTALLING] = BUM.TASK_UPDATE_STATE.INSTALLING,
  [AUM.APP_UPDATE_STATE.INSTALL_FAILED] = BUM.TASK_UPDATE_STATE.INSTALL_FAILED,
  [AUM.APP_UPDATE_STATE.PKG_AUTO_REMOVED] = BUM.TASK_UPDATE_STATE.PKG_AUTO_REMOVED,
  [AUM.APP_UPDATE_STATE.INSTALL_SUCCESS] = BUM.TASK_UPDATE_STATE.INSTALL_SUCCESS
}

function M.create_background_task(_opts, cb)
  AUM.request_config_and_run_update({need_show_install_guide = false}, function(is_success, ...)
    if is_success then
      local update_info = (...)
      if update_info and update_info.is_mandatory_force_update then
        E.LOG.warn(TAG, "request_config_and_run_update is_mandatory_force_update is true, wait for force update")
      else
        cb(true, Task)
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "request_config_and_run_update error, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function Task.start_task(params, cb)
  E.LOG.debug(TAG, "start_task")
  E.log(params)
  AUM.start({
    need_jump_outside_update = params.need_jump_outside_update
  }, cb)
end

function Task.stop_task(params, cb)
  E.LOG.debug(TAG, "stop_task")
  AUM.stop(params, cb)
end

function Task.remove_task(params, cb)
  E.LOG.debug(TAG, "remove_task")
  AUM.remove(params, cb)
end

function Task.install_task(params, cb)
  E.LOG.debug(TAG, "install_task")
  AUM.install(params, cb)
end

function Task.get_task_info(params, cb)
  E.LOG.debug(TAG, "get_task_info")
  AUM.get_task_info(params, cb)
end

function Task.get_task_state(params, cb)
  E.LOG.debug(TAG, "get_task_state")
  AUM.get_task_state(params, function(task_state)
    if task_state.state then
      task_state.state = state_map[task_state.state]
    end
    cb(task_state)
  end)
end

function Task.set_state_change_listener(listener)
  E.LOG.debug(TAG, "set_state_change_listener")
  AUM.set_state_change_listener(function(task_state)
    if task_state.state then
      task_state.state = state_map[task_state.state]
    end
    listener(task_state)
  end)
end

return M
