local AbsReceiver = require("ejoysdk_lua.cloud_game.ctrl_proxys.abs_res_download_state_ctrl_proxy")
local RECEIVER_NAME = "CDLC_GAME_LISTENERS"
local TAG = RECEIVER_NAME
local M = AbsReceiver:Inherit(RECEIVER_NAME)
local E = require("ejoysdk_lua.ejoysdk")
local ctrl_type, set_download_speed_listener, get_cur_download_speed_listener, get_cur_download_progress_listener

function M.set_download_speed_limit(speed)
  if not set_download_speed_listener then
    E.LOG.warn(TAG, "skip set_download_speed_limit for listener is nil")
    return
  end
  set_download_speed_listener(speed)
end

function M.get_current_download_speed(cb)
  if not get_cur_download_speed_listener then
    E.LOG.warn(TAG, "skip get_current_download_speed for listener is nil")
    return
  end
  get_cur_download_speed_listener(function(speed_info)
    cb(speed_info)
  end)
end

function M.get_current_download_progress(cb)
  if not get_cur_download_progress_listener then
    E.LOG.warn(TAG, "skip get_current_download_progress for listener is nil")
    return
  end
  get_cur_download_progress_listener(function(progress_data)
    cb(progress_data)
  end)
end

function M.set_impl(download_controller_type, ctrl_impl_info)
  if not ctrl_impl_info then
    E.LOG.warn(TAG, "setup skip for controller data is invalid")
    return
  end
  ctrl_type = download_controller_type
  if ctrl_impl_info[AbsReceiver.CONTROLLER_LISTENER_NAMES.LISTENER_SET_DOWNLOAD_SPEED] then
    set_download_speed_listener = ctrl_impl_info[AbsReceiver.CONTROLLER_LISTENER_NAMES.LISTENER_SET_DOWNLOAD_SPEED]
  end
  if ctrl_impl_info[AbsReceiver.CONTROLLER_LISTENER_NAMES.LISTENER_GET_CUR_DOWNLOAD_SPEED] then
    get_cur_download_speed_listener = ctrl_impl_info[AbsReceiver.CONTROLLER_LISTENER_NAMES.LISTENER_GET_CUR_DOWNLOAD_SPEED]
  end
  if ctrl_impl_info[AbsReceiver.CONTROLLER_LISTENER_NAMES.LISTENER_GET_CUR_DOWNLOAD_PROGRESS] then
    get_cur_download_progress_listener = ctrl_impl_info[AbsReceiver.CONTROLLER_LISTENER_NAMES.LISTENER_GET_CUR_DOWNLOAD_PROGRESS]
  end
end

function M.get_ctrl_type()
  return ctrl_type
end

function M.close()
  set_download_speed_listener = nil
  get_cur_download_speed_listener = nil
  get_cur_download_progress_listener = nil
end

return M
