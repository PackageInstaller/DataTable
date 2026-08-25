local CG = require("ejoysdk_lua.vendors.cloud_game")
local E = require("ejoysdk_lua.ejoysdk")
local LUTIL = require("ejoysdk_lua.native.utils.Utils")
local NCGM = require("ejoysdk_lua.cloud_game.cloud_game_facade")
local TAG = "modules/cloud_game"
local M = {}
local cloud_event_listener
local is_register_event_listener = false
local inner_get_cur_progress_listeners = {}
local inner_get_cur_speed_listeners = {}
M.EVENT_TYPE = {
  SET_SPEED = "set_speed",
  GET_SPEED = "get_speed",
  GET_DOWNLOAD_PROGRESS = "get_download_progress",
  VISIBILITY_CHANGE = "visibility_change",
  SESSION_TIME_DOWN = "session_time_down"
}
M.PARAMS_KEY = {
  TYPE = "type",
  MAX_SPEED = "max_speed",
  ACTUAL_SPEED = "actual_speed",
  VISIBILITY = "visibility",
  DOWNLOAD_PROGRESS = "download_progress",
  TIME_DOWN = "remain_time",
  SET_SPEED_RESULT = "set_speed_result",
  RESULT_CODE = "result_code"
}
M.START_GAME_RESULT_CODE = {
  CODE_SUCCESS = 0,
  CODE_FAILED = 1,
  CODE_GO_MINI_GAME = 2
}

function M.is_cloud_game_available(cb)
  if cb then
    local data = {available = true}
    LUTIL.notify(cb, LUTIL.Status.SUCC, "get cloud game available success", data)
  end
end

function M.start_cloud_game(cb)
  NCGM.start_cloud_game(function(succ)
    E.LOG.debug(TAG, "")
    local cb_params = {}
    if succ then
      cb_params[M.PARAMS_KEY.RESULT_CODE] = M.START_GAME_RESULT_CODE.CODE_SUCCESS
    else
      cb_params[M.PARAMS_KEY.RESULT_CODE] = M.START_GAME_RESULT_CODE.CODE_FAILED
    end
    LUTIL.notify(cb, LUTIL.Status.SUCC, "start cloud game success", cb_params)
  end)
end

function M.register_cloud_event_listener(listener)
  E.LOG.debug(TAG, "register download speed listener, is_register_event_listener >> " .. tostring(is_register_event_listener))
  cloud_event_listener = listener
  if not is_register_event_listener then
    local function get_cur_progress_listener(cb)
      table.insert(inner_get_cur_progress_listeners, cb)
      
      if #inner_get_cur_progress_listeners > 1 then
        return
      end
      E.LOG.debug(TAG, "trigger get download progress")
      local params = {
        [M.PARAMS_KEY.TYPE] = M.EVENT_TYPE.GET_DOWNLOAD_PROGRESS
      }
      LUTIL.notify(cloud_event_listener, LUTIL.Status.SUCC, "", params)
    end
    
    local function get_cur_speed_listener(cb)
      table.insert(inner_get_cur_speed_listeners, cb)
      if #inner_get_cur_speed_listeners > 1 then
        return
      end
      E.LOG.debug(TAG, "notify get actual speed to native")
      local params = {
        [M.PARAMS_KEY.TYPE] = M.EVENT_TYPE.GET_SPEED
      }
      E.log(params)
      LUTIL.notify(cloud_event_listener, LUTIL.Status.SUCC, "", params)
    end
    
    local function set_speed_limit_listener(speed_kbps)
      M.cb_set_download_speed(speed_kbps)
    end
    
    local opts = {
      [NCGM.OPTIONS.DOWNLOAD_CONTROLLER_TYPE] = NCGM.DOWNLOAD_CTRL_TYPES.TYPE_GAME_LISTENERS,
      [NCGM.OPTIONS.DOWNLOAD_CONTROLLER_DATA] = {
        [NCGM.DOWNLOAD_CTRL_LISTENER_NAMES.LISTENER_GET_CUR_DOWNLOAD_PROGRESS] = get_cur_progress_listener,
        [NCGM.DOWNLOAD_CTRL_LISTENER_NAMES.LISTENER_GET_CUR_DOWNLOAD_SPEED] = get_cur_speed_listener,
        [NCGM.DOWNLOAD_CTRL_LISTENER_NAMES.LISTENER_SET_DOWNLOAD_SPEED] = set_speed_limit_listener
      }
    }
    local listeners = {
      [NCGM.LISTENER_NAMES.VISIBILITY_CHANGE_LISTENER] = function(visible)
        E.LOG.debug(TAG, "notify cloud game visibility change >> " .. tostring(visible))
        local params = {
          [M.PARAMS_KEY.TYPE] = M.EVENT_TYPE.VISIBILITY_CHANGE,
          [M.PARAMS_KEY.VISIBILITY] = visible
        }
        LUTIL.notify(cloud_event_listener, LUTIL.Status.SUCC, "", params)
      end,
      [NCGM.LISTENER_NAMES.ALIVE_COUNT_DOWN_LISTENER] = function(remain_time)
        E.LOG.debug(TAG, "notify cloud game alive remain time >> " .. tostring(remain_time))
        local params = {
          [M.PARAMS_KEY.TYPE] = M.EVENT_TYPE.SESSION_TIME_DOWN,
          [M.PARAMS_KEY.TIME_DOWN] = remain_time
        }
        LUTIL.notify(cloud_event_listener, LUTIL.Status.SUCC, "", params)
      end
    }
    NCGM.setup(opts, listeners)
    is_register_event_listener = true
  end
end

function M.cb_set_download_speed(speed_kbps)
  E.LOG.debug(TAG, "notify speed data to native, speed >> " .. tostring(speed_kbps))
  local params = {
    [M.PARAMS_KEY.TYPE] = M.EVENT_TYPE.SET_SPEED,
    [M.PARAMS_KEY.MAX_SPEED] = speed_kbps
  }
  E.log(params)
  LUTIL.notify(cloud_event_listener, LUTIL.Status.SUCC, "", params)
end

function M.notify_actual_download_speed(speed_info)
  if next(inner_get_cur_speed_listeners) == nil then
    E.LOG.warn(TAG, "notify_actual_download_speed skip, for no listener")
    return
  end
  for _, lis in ipairs(inner_get_cur_speed_listeners) do
    lis(speed_info)
  end
  inner_get_cur_speed_listeners = {}
end

function M.notify_download_progress(progress_info)
  if next(inner_get_cur_progress_listeners) == nil then
    E.LOG.warn(TAG, "notify_download_progress skip for not listener")
    return
  end
  for _, lis in ipairs(inner_get_cur_progress_listeners) do
    lis(progress_info)
  end
  inner_get_cur_progress_listeners = {}
end

function M.notify_download_finish()
  E.LOG.debug(TAG, "receive download finish message ")
end

function M.notify_set_speed_result(result)
  if result and result[M.PARAMS_KEY.SET_SPEED_RESULT] then
    local is_success = result[M.PARAMS_KEY.SET_SPEED_RESULT]
    NCGM.handle_set_download_speed_result(is_success)
  end
end

function M.show_input_method(params, cb)
  CG.show_input_method(function(succ, ...)
    if succ then
      local text = (...)
      E.LOG.debug(TAG, "show_input_method succ, text:" .. tostring(text))
    else
      local code, msg = ...
      E.LOG.warn(TAG, "show_input_method failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end, params)
end

return M
