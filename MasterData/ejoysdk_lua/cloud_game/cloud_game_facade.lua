local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local cloud_download_rules = require("ejoysdk_lua.cloud_game.cloud_download_rules")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local CSM = require("ejoysdk_lua.cloud_game.cloud_connect_statemachine")
local CM = require("ejoysdk_lua.cloud_game.cloud_manager")
local DSC = require("ejoysdk_lua.cloud_game.ctrl_proxys.abs_res_download_state_ctrl_proxy")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CSG = require("ejoysdk_lua.cloud_game.cloud_state_manager")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "native_cloud_game_mgr"
local STOP_CLOUD_GAME_COUNTDOWN_INTERVAL = 120
local GET_DOWNLOAD_PROGRESS_POLL_INTERVAL = 5
M.DOWNLOAD_CTRL_TYPES = {
  TYPE_SDK_RES_MODEL = "sdk_res_model",
  TYPE_GAME_LISTENERS = "game_listeners"
}
M.DOWNLOAD_CTRL_PARAMS = DSC.CONTROLLER_PARAMS
M.DOWNLOAD_CTRL_LISTENER_NAMES = DSC.CONTROLLER_LISTENER_NAMES
M.PROGRESS_INFO_KEY = DSC.PROGRESS_INFO_KEY
M.LISTENER_NAMES = {
  START_LISTENER = "start_listener",
  EXIT_LISTENER = "exit_listener",
  ALIVE_COUNT_DOWN_LISTENER = "alive_count_down_listener",
  VISIBILITY_CHANGE_LISTENER = "visibility_change_listener"
}
M.OPTIONS = {
  DOWNLOAD_CONTROLLER_TYPE = "download_controller_type",
  DOWNLOAD_CONTROLLER_DATA = "download_controller_data"
}
M.EXIT_CODE = {CONNECT_INTERRUPTED = 1, CONNECT_END = 2}
M.CLOUD_GAME_PLAY_MODE = CSG.CLOUD_GAME_PLAY_MODE
local is_init = false
local download_ctrl_proxy, visibility_change_listener, alive_count_down_listener, start_listener, exit_listener, current_progress_info, current_download_speed, current_download_state, last_startup_result
local last_timeout = false
local current_visible = false
local time_tick = false

local function start_time_down(interval, cb)
  time_tick = true
  local countdown = interval
  local before_time = os.time()
  local tick
  
  function tick()
    E.Timer.once(1, function()
      if time_tick then
        local last_time = os.time() - before_time
        E.LOG.debug(TAG, "time tick, interval >> " .. tostring(countdown) .. ", last_time:" .. tostring(last_time))
        if last_time < interval and countdown > 0 then
          M._alive_count_down(countdown)
          countdown = countdown - 1
          tick()
        else
          M._alive_count_down(-1)
          cb()
        end
      else
        E.LOG.debug(TAG, "time tick is false, stop tick")
      end
    end)
  end
  
  countdown = countdown - 1
  tick()
end

local is_download_progress_poll_started = false
local get_download_progress_poll

local function start_download_progress_poll()
  if is_download_progress_poll_started then
    return
  end
  E.LOG.debug(TAG, "start_download_progress_poll begin")
  is_download_progress_poll_started = true
  
  function get_download_progress_poll()
    E.Timer.once(GET_DOWNLOAD_PROGRESS_POLL_INTERVAL, function()
      E.LOG.debug(TAG, "start_download_progress_poll _trigger_get_download_progress")
      M._trigger_get_download_progress()
      if get_download_progress_poll then
        get_download_progress_poll()
      else
        is_download_progress_poll_started = false
      end
    end)
  end
  
  get_download_progress_poll()
end

local function cloud_game_visibility_change_listener(visible)
  M._notify_visibility_change(visible)
  current_visible = visible
  E.LOG.debug(TAG, "cloud_game_visibility_change_listener received:" .. tostring(visible))
  if not visible then
    CSM.on_pause_game()
    CM.cloud_view_not_visible()
    local cloud_state = CSG.get_cloud_state_info()
    local connect_state_info = cloud_state[CSG.STATE_INFO_KEY.CONNECT_STATE] or {}
    local connect_state = connect_state_info[CSG.CONNECT_STATE_INFO_KEY.KEY_STATE]
    E.LOG.debug(TAG, "cloud_game_visibility_change_listener not visible, exit_listener:" .. tostring(exit_listener) .. ", connect_state:" .. tostring(connect_state) .. ", percent:" .. tostring(current_progress_info and current_progress_info[M.PROGRESS_INFO_KEY.PERCENT]))
    if current_progress_info and 1 == current_progress_info[M.PROGRESS_INFO_KEY.PERCENT] then
      E.LOG.debug(TAG, "current exit for download is complete, so exit with connect end code")
      if exit_listener then
        exit_listener(M.EXIT_CODE.CONNECT_END)
      end
    elseif connect_state == CSG.CONNECT_STATES.DIS_CONNECT then
      E.LOG.debug(TAG, "current exit for download is not complete, so exit with connect interrupted code")
      local fail_code = connect_state_info[CSG.CONNECT_STATE_INFO_KEY.KEY_FAIL_CODE]
      local fail_msg = connect_state_info[CSG.CONNECT_STATE_INFO_KEY.KEY_FAIL_MSG]
      if exit_listener then
        exit_listener(M.EXIT_CODE.CONNECT_INTERRUPTED, 0, fail_code, fail_msg)
      end
    elseif connect_state == CSG.CONNECT_STATES.CONNECT_TIME_END then
      if exit_listener then
        exit_listener(M.EXIT_CODE.CONNECT_END)
      end
      CSTAT.stat_action("mini_client_time_end_exit_btn")
    elseif connect_state == CSG.CONNECT_STATES.CONNECT_PAUSE then
      if exit_listener then
        exit_listener(M.EXIT_CODE.CONNECT_INTERRUPTED, STOP_CLOUD_GAME_COUNTDOWN_INTERVAL)
      end
      CSTAT.stat_action("mini_client_exit_pause")
      if cloud_config.DEBUG_OPTIONS.TestCountDownStopSmall then
        E.LOG.warn(TAG, "TestCountDownStopSmall enabled, so countdown is 3")
        STOP_CLOUD_GAME_COUNTDOWN_INTERVAL = 3
      elseif cloud_config.DEBUG_OPTIONS.TestCountDownStopBig then
        E.LOG.warn(TAG, "TestCountDownStopBig enabled, so countdown is 180")
        STOP_CLOUD_GAME_COUNTDOWN_INTERVAL = 180
      end
      start_time_down(STOP_CLOUD_GAME_COUNTDOWN_INTERVAL, function()
        E.LOG.debug(TAG, "time down, stop cloud game")
        CM.stop_connect_with_remote_game()
        last_timeout = true
        CSTAT.stat_action("mini_client_pause_timeout")
      end)
    end
  end
end

local function download_speed_limit_listener(speed_kbps)
  E.LOG.debug(TAG, "receive download speed limit >> " .. tostring(speed_kbps))
  local kbps_speed = speed_kbps
  if not download_ctrl_proxy then
    E.LOG.warn(TAG, "download_speed_limit_listener set limit skip for no download_controller ")
    return
  end
  download_ctrl_proxy.set_download_speed_limit(kbps_speed)
end

local function cloud_state_change_listener(_cloud_state_info)
  E.LOG.debug("cloud_state_change_listener")
end

function M.init()
  if not is_init then
    is_init = true
    E.LOG.debug(TAG, "init register visible listener")
    CA.set_cloud_game_visibility_change_listener(cloud_game_visibility_change_listener)
    CA.set_get_current_download_speed_listener(function()
      M._trigger_get_download_speed()
    end)
    cloud_download_rules.register_download_speed_limit_listener(download_speed_limit_listener)
    CM.register_cloud_state_change_listener(cloud_state_change_listener)
  else
    E.LOG.debug(TAG, "the module has initialized")
  end
end

function M.is_init()
  return is_init
end

function M._test_reset_init()
  is_init = false
end

function M.start_cloud_game(cb, _opts)
  M.init()
  CSTAT.stat_action("mini_client_invoke_start_cloud", last_timeout, last_startup_result)
  
  local function startup_cb_wrapper(succ, ...)
    E.LOG.debug(TAG, "startup result:" .. tostring(succ))
    if start_listener then
      start_listener(succ, ...)
    end
    if cb then
      cb(succ, ...)
    end
    if not succ then
      E.LOG.debug(TAG, "start_cloud_game failed")
      local code, msg = ...
      CSTAT.stat_action_fail("mini_client_start_failed", nil, code, msg)
      download_speed_limit_listener(cloud_config.DEFAULT_MAX_DOWN_SPEED)
      CM.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_NORMAL_GAME)
    else
      last_timeout = false
      time_tick = false
      CM.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE)
      local download_info = M.get_download_info_for_ui()
      CSTAT.stat_action("mini_client_start_succ", download_info.downloadProgress, download_info.curPlayTimeMin)
    end
    last_startup_result = succ
  end
  
  E.LOG.debug(TAG, "begin start cloud game")
  M._connect_cloud_game(function(succ, ...)
    startup_cb_wrapper(succ, ...)
  end)
end

function M.stop_cloud_game(cb)
  E.LOG.debug(TAG, "stop_cloud_game begin")
  CM.stop_connect_with_remote_game(function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "stop_cloud_game failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    else
      E.LOG.debug(TAG, "stop_cloud_game succ")
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M._connect_cloud_game(cb)
  local params = {
    [CSG.CONNECT_PARAMS.IS_MANUAL_CONNECT] = true
  }
  E.LOG.debug(TAG, "before connect_with_remote_game")
  CM.connect_with_remote_game(params, function(succ, ...)
    E.LOG.debug(TAG, "connect cloud game resut >> " .. tostring(succ))
    if cb then
      cb(succ, ...)
    end
    if succ then
      M._on_connect_cloud_success()
    end
  end)
end

function M._on_connect_cloud_success()
  start_download_progress_poll()
end

local function get_cur_speed_handler(speed_info)
  E.LOG.debug(TAG, "receive actual download speed >> ")
  E.log(speed_info)
  speed_info = speed_info or {}
  local actual_speed_kbps = speed_info.actual_speed or 0
  current_download_speed = actual_speed_kbps
  M._notify_actual_download_speed(actual_speed_kbps)
end

function M._trigger_get_download_speed()
  if not download_ctrl_proxy then
    E.LOG.warn(TAG, "trigger_get_download_speed skip for no download_controller ")
    return
  end
  download_ctrl_proxy.get_current_download_speed(get_cur_speed_handler)
end

function M.stop_get_download_progress()
  if get_download_progress_poll then
    get_download_progress_poll = nil
  end
end

local function get_progress_handler(progress_info)
  _ejoysdk.log("get_progress_handler >>")
  E.log(progress_info)
  if cloud_config.DEBUG_OPTIONS.TestDownloadFinish then
    E.LOG.warn(TAG, "get_progress_handler mock 100 begin")
    progress_info[M.PROGRESS_INFO_KEY.TOTAL_BYTES] = 1000
    progress_info[M.PROGRESS_INFO_KEY.RECV_BYTES] = 1000
    progress_info[M.PROGRESS_INFO_KEY.PERCENT] = 1
    progress_info[M.PROGRESS_INFO_KEY.DOWNLOAD_STATE] = CSG.DOWNLOAD_STATES.DOWNLOAD_COMPLETE
  end
  current_progress_info = progress_info or {}
  local last_download_state = current_download_state
  current_download_state = progress_info[M.PROGRESS_INFO_KEY.DOWNLOAD_STATE]
  local is_download_state_changed = last_download_state ~= current_download_state
  current_download_speed = progress_info[M.PROGRESS_INFO_KEY.SPEED]
  local download_progress = progress_info[M.PROGRESS_INFO_KEY.PERCENT] or 0
  local percent = tonumber(download_progress) * 100
  percent = math.floor(percent)
  if current_download_state == CSG.DOWNLOAD_STATES.DOWNLOAD_COMPLETE or 100 == percent then
    E.LOG.debug(TAG, "progress is 100, now notify play_with_download_statemachine download finish")
    CSG.on_game_res_ready()
    CSTAT.stat_action("mini_client_game_res_complete")
  elseif is_download_state_changed and current_download_state == CSG.DOWNLOAD_STATES.DOWNLOADING then
    E.LOG.debug(TAG, "game res is start downloading")
    CSTAT.stat_action("mini_client_game_res_downloading")
  end
  local params = {
    downloading_size = progress_info[M.PROGRESS_INFO_KEY.RECV_BYTES] or 0,
    total_download_size = progress_info[M.PROGRESS_INFO_KEY.TOTAL_BYTES] or 0
  }
  CA.notify_download_progress(params, percent)
  if cloud_config.DEBUG_OPTIONS.TestDownloadProgressSync then
    E.LOG.warn(TAG, "TestDownloadProgressSync enabled")
    if M._test_data._test_progress_notify_listener then
      M._test_data._test_progress_notify_listener(params, percent)
    end
  end
end

function M._trigger_get_download_progress()
  if not download_ctrl_proxy then
    E.LOG.warn(TAG, "trigger_get_download_progress skip for no download_controller ")
    return
  end
  download_ctrl_proxy.get_current_download_progress(get_progress_handler)
end

function M._alive_count_down(remain_time)
  if alive_count_down_listener then
    alive_count_down_listener(remain_time)
  end
end

function M._notify_visibility_change(visibility)
  if visibility_change_listener then
    visibility_change_listener(visibility)
  end
end

function M.set_visibility_change_listener(listener)
  visibility_change_listener = listener
end

function M.set_cloud_game_alive_count_down_listener(listener)
  alive_count_down_listener = listener
end

function M.handle_set_download_speed_result(is_success)
  E.LOG.debug(TAG, "receive the set download speed result >> " .. tostring(is_success))
end

function M.is_cloud_game_visible()
  return cloud_config.SelfStart or current_visible
end

function M._notify_actual_download_speed(speed_kbps)
  E.LOG.debug(TAG, "notify actual download speed >> " .. tostring(speed_kbps))
  local current_download_speed_info = {speed = speed_kbps}
  ET.publish(cloud_config.CLOUD_TOPIC.TOPIC_DOWNLOAD_STATE_CHANGED, current_download_speed_info)
end

function M.check_cloud_game_available(cb)
  CSG.check_cloud_available(function(succ, ...)
    if succ then
      local available = (...)
      E.LOG.debug(TAG, "check_cloud_game_available succ, available:" .. tostring(available))
    else
      local code, msg = ...
      E.LOG.warn(TAG, "check_cloud_game_available failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.exit_cloud_game(is_force, params, cb)
  params = params or {}
  local isRationale = not is_force
  params[CSG.CONNECT_PARAMS.SHOW_RATIONALE] = isRationale
  M.close_cloud_game_view(params, function(succ, ...)
    E.LOG.debug(TAG, "exit_cloud_game result:" .. tostring(succ))
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.get_cloud_state_info()
  do return end
  return CSG.get_cloud_state_info, nil
end

function M.get_download_info_for_ui()
  local info = CSG.get_download_info_for_ui()
  info = EU.deepcopy(info)
  if cloud_config.DisableDownload then
    current_progress_info = current_progress_info or {}
    info.recvBytes = math.floor((current_progress_info[M.PROGRESS_INFO_KEY.RECV_BYTES] or 0) / 1024 / 1024)
    info.totalBytes = math.floor((current_progress_info[M.PROGRESS_INFO_KEY.TOTAL_BYTES] or 0) / 1024 / 1024)
    info.remainBytes = tonumber(info.totalBytes) - tonumber(info.recvBytes)
    local percent = current_progress_info[M.PROGRESS_INFO_KEY.PERCENT] or 0
    if percent < 0 then
      percent = 0
    end
    info.downloadProgress = math.floor(percent * 100)
    info.downloadState = current_progress_info[M.PROGRESS_INFO_KEY.DOWNLOAD_STATE]
    if not current_download_speed then
      M._trigger_get_download_speed()
    end
    info.downloadSpeed = tonumber(string.format("%.2f", (current_download_speed or 0) / 1024))
  else
    E.LOG.debug(TAG, "cloud config disable download is true, speed:" .. tostring(info.downloadSpeed))
    info.downloadSpeed = tonumber(string.format("%.2f", info.downloadSpeed or 0))
  end
  if info.downloadSpeed > 0 then
    info.remainDownloadTime = info.remainBytes / info.downloadSpeed
  else
    info.remainDownloadTime = "-"
  end
  _ejoysdk.log(">>>>>>>>> current_download_speed：" .. tostring(current_download_speed) .. ", remain:" .. tostring(info.remainDownloadTime) .. ", state:" .. tostring(info.downloadState))
  return info
end

function M.open_full_download()
  if cloud_config.DisableDownload then
    E.LOG.debug(TAG, "open_full_download use outside download component")
    download_speed_limit_listener(cloud_config.DEFAULT_MAX_DOWN_SPEED)
  else
    E.LOG.debug(TAG, "open_full_download use inner download component")
    CSG.open_full_download()
  end
end

function M._test_limit_speed(speed)
  download_speed_limit_listener(speed)
end

function M.get_quality_info()
  do return end
  return CSG.get_quality_info, nil
end

function M.change_quality_level(params, cb)
  CSTAT.stat_action("mini_client_change_quality", nil, nil, params)
  CSG.change_quality_level(params, cb)
end

local function is_current_download_complete()
  local download_info = M.get_download_info_for_ui()
  return download_info.downloadState == CSG.DOWNLOAD_STATES.DOWNLOAD_COMPLETE
end

function M.start_game_activity(is_force)
  local function _start_finish_cb(game_res_ready)
    E.LOG.debug(TAG, "start_game_activity finished game_res_ready:" .. tostring(game_res_ready))
    
    if game_res_ready then
      CM.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES)
    else
      CM.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_NORMAL_GAME)
    end
  end
  
  if cloud_config.SelfStart then
    E.LOG.debug("Start game activity, its self start, now start game activity")
    CSG.start_game_activity()
    _start_finish_cb(true)
  elseif is_current_download_complete() then
    M.stop_cloud_game(function()
      M.exit_cloud_game(true, {})
      _start_finish_cb(true)
    end)
  else
    if nil == is_force then
      is_force = false
    end
    M.exit_cloud_game(is_force, {})
    _start_finish_cb(false)
  end
end

function M.js_close_cloud_game_view(params, cb)
  local cloud_mode = M.cloud_game_play_mode()
  if is_current_download_complete() and cloud_mode == CSG.CLOUD_GAME_PLAY_MODE.CLOUD_MOBILE_TRY_PLAY then
    M.stop_cloud_game(function()
      params = params or {}
      M.exit_cloud_game(true, {}, cb)
    end)
  else
    M.exit_cloud_game(false, params, cb)
  end
end

function M.close_cloud_game_view(params, cb)
  CSG.close_cloud_game_view(params, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "cloud_game exists succ")
      if is_current_download_complete() then
        CM.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_RUN_WITH_LOCAL_RES)
      else
        CM.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_NORMAL_GAME)
      end
      local download_info = M.get_download_info_for_ui()
      CSTAT.stat_action("mini_close_cloud_game_view", download_info.downloadProgress, download_info.curPlayTimeMin)
    else
      E.LOG.debug(TAG, "cloud_game exists quit")
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.show_network_state(params)
  if params then
    local is_show = params.is_show or false
    CSTAT.stat_action("mini_client_switch_show_network", is_show)
    CSG.show_network_state(is_show)
  end
end

function M.start_download()
  E.LOG.debug(TAG, "receive start download call")
  CSG.start_download()
end

local function inner_res_download_state_change_listener(_state)
  E.LOG.debug(TAG, "inner_res_download_state_change_listener download_state changed, state:" .. tostring(_state) .. ", poll download progress once")
  M._trigger_get_download_progress()
end

function M.notify_total_time_end(_limit_state_obj)
  CSG.notify_total_time_end(_limit_state_obj)
end

function M.update_time_limit_state_info(limit_state_obj)
  CSG.update_time_limit_state_info(limit_state_obj)
end

function M.setup(opts, listeners)
  M.init()
  opts = opts or {}
  local download_controller_type = opts[M.OPTIONS.DOWNLOAD_CONTROLLER_TYPE]
  local download_ctrl_impl_info = opts[M.OPTIONS.DOWNLOAD_CONTROLLER_DATA]
  E.LOG.debug(TAG, "setup received:" .. tostring(download_controller_type))
  if download_controller_type then
    local proxy
    if download_controller_type == M.DOWNLOAD_CTRL_TYPES.TYPE_SDK_RES_MODEL then
      proxy = require("ejoysdk_lua.cloud_game.ctrl_proxys.res_model_download_ctrl_proxy")
    elseif download_controller_type == M.DOWNLOAD_CTRL_TYPES.TYPE_GAME_LISTENERS then
      proxy = require("ejoysdk_lua.cloud_game.ctrl_proxys.game_listeners_download_ctrl_proxy")
    end
    if proxy then
      if download_ctrl_proxy then
        download_ctrl_proxy.close()
      end
      download_ctrl_proxy = proxy
      download_ctrl_proxy.set_impl(download_controller_type, download_ctrl_impl_info)
      if download_ctrl_proxy.set_download_state_listener then
        download_ctrl_proxy.set_download_state_listener(inner_res_download_state_change_listener)
      end
    end
  end
  if listeners then
    if listeners[M.LISTENER_NAMES.START_LISTENER] then
      start_listener = listeners[M.LISTENER_NAMES.START_LISTENER]
    end
    if listeners[M.LISTENER_NAMES.EXIT_LISTENER] then
      exit_listener = listeners[M.LISTENER_NAMES.EXIT_LISTENER]
    end
    if listeners[M.LISTENER_NAMES.VISIBILITY_CHANGE_LISTENER] then
      visibility_change_listener = listeners[M.LISTENER_NAMES.VISIBILITY_CHANGE_LISTENER]
    end
    if listeners[M.LISTENER_NAMES.ALIVE_COUNT_DOWN_LISTENER] then
      alive_count_down_listener = listeners[M.LISTENER_NAMES.ALIVE_COUNT_DOWN_LISTENER]
    end
  end
end

function M.cloud_game_play_mode()
  do return end
  return CSG.cloud_game_play_mode, nil
end

function M.clip_plain_text(label, text)
  E.LOG.debug(TAG, "clip_plain_text received, label:" .. tostring(label))
  do return CA.clip_plain_text, label end
  return CA.clip_plain_text, label, text, tostring(label), label
end

function M._test_get_proxy()
  return download_ctrl_proxy
end

function M._test_get_start_listener()
  return start_listener
end

function M._test_get_exit_listener()
  return exit_listener
end

function M._test_get_visibility_change_listener()
  return visibility_change_listener
end

function M._test_get_alive_count_down_listener()
  return alive_count_down_listener
end

M._test_data = {_test_progress_notify_listener = nil}

function M._test_set_progress_notify_listener(lis)
  M._test_data._test_progress_notify_listener = lis
end

return M
