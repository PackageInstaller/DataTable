local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FSM = UTILS.fsm
local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local CLOUD_UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local ELU = require("ejoysdk_lua.lang.util")
local UI_TEXT = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_text_normal")
local CTM = require("ejoysdk_lua.cloud_game.cloud_time_limit_checker")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local DOWNLOAD_RULES = require("ejoysdk_lua.cloud_game.cloud_download_rules")
local CG = require("ejoysdk_lua.vendors.cloud_game")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local TAG = "cloud_connect_statemachine"
local M = {}
M.STATES = {
  IDLE = "idle",
  INITTING = "initting",
  INITTED = "init_succ",
  INIT_FAILED = "init_failed",
  CONNECTING = "connecting",
  CONNECTED = "connected",
  DIS_CONNECT = "dis_connect",
  CONNECT_TIME_END = "connect_time_end",
  CONNECT_PAUSE = "connect_pause"
}
M.LIMIT_STAGES = CTM.TIME_LIMIT_STAGE
local _EVENTS = {
  INIT_EJOY = "init_ejoy",
  ON_INIT_EJOY_SUCC = "on_init_ejoy_succ",
  ON_INIT_EJOY_FAILED = "on_init_ejoy_failed",
  CONNECT_REMOTE = "connect_remote",
  STOP_CONNECT_REMOTE = "stop_connect_remote",
  CLOSE_CLOUD_GAME_VIEW = "close_cloud_game_view",
  ON_CONNECT_TIME_END = "connect_time_end",
  ON_CONNECT_ERROR = "on_connect_error",
  ON_CONNECT_SUCC = "on_connect_succ",
  RETRY_CONNECT = "retry_connect",
  ON_PAUSE_GAME = "on_pause_game",
  ON_RESUME_GAME = "on_resume_game",
  ON_STOP_GAME = "on_stop_game"
}
M.ErrorType = {
  CloudStartError = 1,
  CloudCGError = 2,
  NetworkError = 3,
  InitSdkError = 4
}
M.STATE_INFO_KEY = {
  KEY_STATE = "state",
  KEY_FAIL_TYPE = "err_type",
  KEY_FAIL_CODE = "err_code",
  KEY_FAIL_MSG = "err_msg"
}
M.PARAMS = {
  SHOW_RATIONALE = "show_rationale",
  IS_MANUAL_CONNECT = "is_manual_connect",
  FROM = "from"
}
local data = {
  is_ejoy_initted = false,
  is_retry_connecting = false,
  is_first_time_connect = true,
  has_sync_local_device_info = false,
  current_state = {
    [M.STATE_INFO_KEY.KEY_STATE] = M.STATES.IDLE,
    [M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil,
    [M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0,
    [M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
  },
  connect_state_change_listener = nil
}
local _connect_fsm, _cloud_manager, _cloud_facade
local _pause_state_disconn_pending_actions = {}
local auto_retry_connect_error_code
local is_inited = false
local has_call_connect_remote = false
local connect_remote_params = {}
local connect_remote_cb

local function _fsm_enqueue_event_at_front(event_name, ...)
  _connect_fsm:enqueue_event(event_name, true, ...)
end

local function _fsm_enqueue_event(event_name, ...)
  _connect_fsm:enqueue_event(event_name, false, ...)
end

local function _fsm_transition_to(from_state, to_state, ...)
  from_state = from_state or _connect_fsm.current
  E.LOG.debug(TAG, "_fsm_transition_to, from:" .. tostring(from_state) .. ", to_state:" .. tostring(to_state))
  _connect_fsm:transition(from_state, to_state, ...)
end

local function _fsm_on_async_event_finished(event_name)
  _connect_fsm:notify_async_finish(event_name)
end

local function notify_state_changed()
  if not data.connect_state_change_listener then
    return
  end
  data.connect_state_change_listener(data.current_state)
end

local function stat_init_start()
  CSTAT.stat_action("mini_client_init_start", nil, true)
end

function M.need_intercept_error(error_code)
  local code = tostring(error_code)
  if "nil" ~= code and 7 == #code then
    local prefix = string.sub(code, 1, 4)
    local prefix_number = tonumber(prefix)
    if prefix_number then
      return prefix_number < 5002 or prefix_number > 7000
    end
  end
  return true
end

function M._retry_connect_cloud(cb, last_err_code)
  CLOUD_UI.set_is_retry_connecting(true)
  CLOUD_UI.reconnect()
  local connect_time_begin = os.time()
  local request_time_out = 20
  local request_interval = 4
  local request_time = request_time_out - request_interval
  local retry_cnt = 0
  local finish = false
  local run_fail_code = last_err_code
  
  local function request_connect_cloud()
    if finish then
      return
    end
    E.LOG.debug(TAG, "[cloud game] start_cloud_game retry " .. tostring(retry_cnt))
    retry_cnt = retry_cnt + 1
    CSTAT.stat_action("server_send_relink_actual_frequency retry cnt:" .. tostring(retry_cnt))
    _cloud_manager.start_cloud_game(function(succ2, ...)
      E.LOG.debug(TAG, "[cloud game] start_cloud_game retry result " .. tostring(succ2) .. ", retry cnt:" .. tostring(retry_cnt))
      if succ2 then
        finish = true
        CSTAT.stat_action("click_relink_enter_game_success")
        cb(succ2, ...)
      else
        run_fail_code = (...)
      end
    end)
  end
  
  E.LOG.debug(TAG, "_retry_connect_cloud begin request_connect_cloud")
  request_connect_cloud()
  local update_time_fun
  
  function update_time_fun()
    local time_left = request_time_out - math.ceil(os.time() - connect_time_begin)
    if time_left < 1 then
      time_left = 0
    end
    E.LOG.debug(TAG, "[cloud game] -------cancel_update_time=" .. tostring(time_left) .. ", is_retry_connecting:" .. tostring(data.is_retry_connecting))
    cloud_adapter.set_retry_connected_tip(string.format(ELU.getString(UI_TEXT.RetryConnect.text), time_left))
    if not data.is_retry_connecting or finish or time_left <= 0 then
      if not finish then
        cb(false, run_fail_code)
        CLOUD_UI.check_and_show_error()
        E.LOG.debug(TAG, "[cloud game] -------超时没有连接成功")
      end
      finish = true
      data.is_retry_connecting = false
      cloud_adapter.set_retry_connected_tip("")
      return
    end
    if time_left <= request_time then
      request_time = time_left - request_interval
      request_connect_cloud()
    end
    E.Timer.once(1, function()
      update_time_fun()
    end)
  end
  
  CSTAT.stat_action("click_relink_page")
  update_time_fun()
end

local function start_connect_remote(_params, cb)
  local last_err_code, last_err_msg
  
  local function on_request_cloud_cb(succ2, ...)
    E.LOG.debug(TAG, "[cloud game] start_cloud_game result " .. tostring(succ2))
    if succ2 then
      _fsm_enqueue_event_at_front(_EVENTS.ON_CONNECT_SUCC, _params, cb)
    else
      last_err_code, last_err_msg = ...
      _fsm_enqueue_event_at_front(_EVENTS.ON_CONNECT_ERROR, CLOUD_UI.ErrorType.CloudStartError, last_err_code, last_err_msg, _params, cb)
    end
    _fsm_on_async_event_finished(_EVENTS.CONNECT_REMOTE)
  end
  
  _cloud_manager.start_cloud_game(on_request_cloud_cb, _params)
end

local function cancel_download_speed_limit()
  E.LOG.debug(TAG, "cancel_download_speed_limit begin")
  _cloud_facade.open_full_download()
end

local function enable_download_speed_limit()
  E.LOG.debug(TAG, "enable_download_speed_limit begin")
  CC.force_http_kps_limit(nil)
  local min_speed = cloud_adapter.get_min_download_speed()
  DOWNLOAD_RULES.update_download_speed_kbps(min_speed)
end

local function resume_check_pause_pending_actions(from)
  if from == M.STATES.DIS_CONNECT then
    E.LOG.debug(TAG, "resume from DIS_CONNECT state, now check disconnect actions")
    for idx, ac in ipairs(_pause_state_disconn_pending_actions) do
      local succ = pcall(ac)
      E.LOG.debug(TAG, "process pending action idx:" .. tostring(idx) .. ", result:" .. tostring(succ))
    end
    _pause_state_disconn_pending_actions = {}
  end
end

local function is_auto_retry_connect(error_code)
  if auto_retry_connect_error_code and auto_retry_connect_error_code == error_code then
    auto_retry_connect_error_code = nil
    return false
  end
  if 5001005 == error_code then
    return false
  end
  if error_code and 8022 ~= error_code then
    auto_retry_connect_error_code = error_code
    return true
  end
  return false
end

local current_activity_state
local cache_8022_error = {}

local function on_native_activity_state_changed(state_info)
  if state_info and state_info.state then
    current_activity_state = state_info.state
    if state_info.state == CC.ACTIVITY_STATE.ON_START and cache_8022_error.cb then
      E.LOG.debug(TAG, "on start and has cache 8022 error")
      local ctm_state = CTM.current_state_info()
      if ctm_state.stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
        E.LOG.debug(TAG, "play total time end, do not reconnect")
      else
        cache_8022_error.cb()
        cache_8022_error = {}
      end
    end
  end
end

local fsm_callbacks = {
  ["on" .. _EVENTS.INIT_EJOY] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "init_ejoy event received")
    local _params, cb = ...
    if not _cloud_manager.is_network_available() then
      if cb then
        cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.NETWORK_ERROR, "network unavailable")
      end
      _fsm_enqueue_event_at_front(_EVENTS.ON_INIT_EJOY_FAILED, CONSTANTS.CLOUD_GAME_ERROR_CODES.NETWORK_ERROR, "network unavailable", cb)
      return FSM.SYNC, M.STATES.INIT_FAILED, CONSTANTS.CLOUD_GAME_ERROR_CODES.NETWORK_ERROR, "network unavailable", _params, cb
    end
    local init_sdk_cb
    
    function init_sdk_cb(succ, ...)
      E.LOG.debug(TAG, "init_sdk_cb received, succ:" .. tostring(succ))
      if succ then
        _cloud_manager.init_local_logic()
        CLOUD_UI.reset_error_ui_state()
        local play_config = _cloud_manager.get_play_config()
        CSTAT.stat_action("mini_client_init_result", nil, true, play_config)
        E.LOG.debug(TAG, "[cloud game] -------gangplank init success-------")
        _fsm_enqueue_event_at_front(_EVENTS.ON_INIT_EJOY_SUCC, _params, cb)
      else
        E.LOG.warn(TAG, "[cloud game] -------gangplank init failure-------")
        local error_code, error_msg = ...
        _fsm_enqueue_event_at_front(_EVENTS.ON_INIT_EJOY_FAILED, error_code, error_msg, _params, cb)
      end
      ET.subscribe(CC.CLOUD_TOPIC.TOPIC_ACTIVITY_STATE_CHANGED_INNER, on_native_activity_state_changed)
      _fsm_on_async_event_finished(_EVENTS.INIT_EJOY)
    end
    
    _fsm_transition_to(nil, M.STATES.INITTING)
    stat_init_start()
    E.LOG.debug(TAG, "begin init ejoy sdk")
    local current_state_info = CTM.current_state_info()
    local current_stage = current_state_info[CTM.STATE_INFO_KEY.KEY_STAGE]
    if current_stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
      E.LOG.warn(TAG, "current time end, start transition to time end")
      _fsm_enqueue_event_at_front(_EVENTS.ON_CONNECT_TIME_END)
      _fsm_on_async_event_finished(_EVENTS.INIT_EJOY)
      if cb then
        cb(true)
      end
    else
      E.LOG.debug(TAG, "current not time end, start init cloud")
      data.product.init_sdk(init_sdk_cb)
    end
    return FSM.ASYNC
  end,
  ["on" .. _EVENTS.ON_INIT_EJOY_FAILED] = function(_f_self, _from, ...)
    data.is_ejoy_initted = false
    local error_code, error_msg, _params, cb = ...
    E.LOG.warn(TAG, "error msg: " .. tostring(error_msg) .. ", error_code:" .. tostring(error_code))
    CSTAT.stat_action_fail("mini_client_init_result", nil, -1, error_msg)
    return FSM.SYNC, M.STATES.INIT_FAILED, error_code, error_msg, _params, cb
  end,
  ["on" .. _EVENTS.ON_INIT_EJOY_SUCC] = function(_f_self, _from, ...)
    data.is_ejoy_initted = true
    local _params, cb = ...
    if cb then
      cb(true)
    end
    E.LOG.debug(TAG, "receive event on init succ")
    return FSM.SYNC, M.STATES.INITTED
  end,
  ["on" .. _EVENTS.ON_CONNECT_SUCC] = function(_f_self, _from, ...)
    local _params, cb = ...
    _params = _params or {}
    if _from == M.STATES.CONNECTING and type(data.splash_time_begin) == "number" and (_params[M.PARAMS.IS_MANUAL_CONNECT] or CC.SelfStart and not data.is_record_splash_time) then
      local splash_time = os.time() - data.splash_time_begin
      CSTAT.stat_action("mini_client_splash_time", tostring(splash_time), true)
      data.is_record_splash_time = true
    end
    if not data.has_sync_local_device_info then
      E.LOG.debug(TAG, "not sync device info, begin sync")
      _cloud_manager.notify_remote_local_device_info()
      data.has_sync_local_device_info = true
    end
    if auto_retry_connect_error_code then
      E.LOG.debug(TAG, "reset auto_retry_connect_error_code nil")
      auto_retry_connect_error_code = nil
    end
    if cb then
      cb(true)
    end
    return FSM.SYNC, M.STATES.CONNECTED, _params
  end,
  ["on" .. _EVENTS.CONNECT_REMOTE] = function(_f_self, from, ...)
    E.LOG.debug(TAG, "CONNECT_REMOTE received, from:" .. tostring(from))
    if from == M.STATES.INITTING or from == M.STATES.CONNECTING or from == M.STATES.INIT_FAILED then
      E.LOG.warn(TAG, "connect remote from initing or connecting or init failed state, schedule connect_remote event")
      _fsm_enqueue_event(_EVENTS.CONNECT_REMOTE, ...)
      return FSM.SYNC
    end
    local params, cb = ...
    params = params or {}
    if not params[M.PARAMS.IS_MANUAL_CONNECT] then
      params[M.PARAMS.IS_MANUAL_CONNECT] = false
    end
    if from == M.STATES.INITTED or from == M.STATES.DIS_CONNECT then
      _fsm_transition_to(nil, M.STATES.CONNECTING)
      data.splash_time_begin = os.time()
      start_connect_remote(params, function(_succ, ...)
        if cb then
          cb(_succ, ...)
        end
        if params[M.PARAMS.IS_MANUAL_CONNECT] == true then
          E.LOG.debug(TAG, "manual called connect")
          if _succ then
            if from == M.STATES.DIS_CONNECT then
              CSTAT.stat_action("mini_client_connect_stop_game_result", nil, _succ)
            else
              CSTAT.stat_action("mini_client_invoke_connect_result", nil, _succ)
            end
          else
            local _code, _msg = ...
            if from == M.STATES.DIS_CONNECT then
              CSTAT.stat_action_fail("mini_client_connect_stop_game_result", nil, _code, _msg)
            else
              CSTAT.stat_action_fail("mini_client_invoke_connect_result", nil, _code, _msg)
            end
          end
        end
      end)
      CSTAT.stat_connect_begin()
      return FSM.ASYNC
    elseif from == M.STATES.CONNECT_PAUSE then
      E.LOG.debug(TAG, "connect remote, current is pause, so resume instead")
      cloud_adapter.resume_game()
      if cb then
        cb(true)
      end
      CSTAT.stat_action("mini_client_resume_pause_game_result", nil, true)
      return FSM.SYNC, M.STATES.CONNECTED
    elseif from == M.STATES.CONNECTED then
      E.LOG.debug(TAG, "connect remote, already connected, directly cb true")
      if cb then
        cb(true)
      end
      return FSM.SYNC
    end
  end,
  ["on" .. _EVENTS.STOP_CONNECT_REMOTE] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "STOP_CONNECT_REMOTE received, from:" .. tostring(_from))
    if _from == M.STATES.CONNECTING then
      E.LOG.warn(TAG, "stop connect remote from connecting state, schedule connect_remote event")
      _fsm_enqueue_event(_EVENTS.STOP_CONNECT_REMOTE, ...)
      return FSM.SYNC
    end
    local _params, cb = ...
    if _from == M.STATES.DIS_CONNECT then
      E.LOG.debug(TAG, "STOP_CONNECT_REMOTE received in disconnect state, directly return true")
      if cb then
        cb(true)
      end
      return FSM.SYNC
    else
      E.LOG.debug(TAG, "its connected state, now stop game")
      _cloud_manager.stop_game(function(_succ, ...)
        local code, msg = ...
        E.LOG.debug(TAG, "stop game result:" .. tostring(_succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        if cb then
          cb(_succ, ...)
        end
      end)
      _cloud_facade.open_full_download()
      return FSM.SYNC, M.STATES.DIS_CONNECT
    end
  end,
  ["on" .. _EVENTS.CLOSE_CLOUD_GAME_VIEW] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW received")
    local _params, cb = ...
    _params = _params or {}
    local should_show_rationale = true
    if type(_params[M.PARAMS.SHOW_RATIONALE]) == "boolean" then
      should_show_rationale = _params[M.PARAMS.SHOW_RATIONALE]
    end
    if _from == M.STATES.CONNECTED and should_show_rationale then
      E.LOG.debug(TAG, "begin show exit rational")
      
      local function click_cb(is_confirmed_exit)
        if cb then
          cb(is_confirmed_exit)
        end
        local is_exit = 2
        if is_confirmed_exit then
          is_exit = 1
        end
        CSTAT.stat_action("mini_client_exit_dialog_click", is_exit)
      end
      
      CLOUD_UI.show_exit_confirm(click_cb)
      CSTAT.stat_action("mini_client_exit_confirm_btn")
      return FSM.SYNC
    elseif _from == M.STATES.CONNECTING then
      E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW, from:" .. tostring(_from))
      cloud_adapter.close_cloud_game_view(_params, cb)
      return FSM.SYNC, M.STATES.CONNECT_PAUSE
    elseif _from == M.STATES.DIS_CONNECT then
      E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW, from:" .. tostring(_from))
      cloud_adapter.close_cloud_game_view(_params, cb)
      return FSM.SYNC
    elseif _from == M.STATES.CONNECT_PAUSE then
      E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW, from:" .. tostring(_from))
      if cb then
        cb(true)
      end
      return FSM.SYNC
    elseif _from == M.STATES.CONNECTED then
      E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW, from:" .. tostring(_from))
      cloud_adapter.close_cloud_game_view(_params, cb)
      return FSM.SYNC, M.STATES.CONNECT_PAUSE
    elseif _from == M.STATES.CONNECT_TIME_END then
      E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW, from:" .. tostring(_from))
      cloud_adapter.close_cloud_game_view(_params, cb)
      return FSM.SYNC
    else
      E.LOG.debug(TAG, "CLOSE_CLOUD_GAME_VIEW, from:" .. tostring(_from))
      cloud_adapter.close_cloud_game_view(_params, cb)
      return FSM.SYNC, M.STATES.CONNECT_PAUSE
    end
  end,
  ["on" .. _EVENTS.ON_CONNECT_ERROR] = function(_f_self, _from, ...)
    local err_type, err_code, err_msg, params, cb = ...
    E.LOG.debug(TAG, "last err code >> " .. err_code)
    return FSM.SYNC, M.STATES.DIS_CONNECT, err_type, err_code, err_msg, params, cb
  end,
  ["on" .. _EVENTS.RETRY_CONNECT] = function(_f_self, _from, ...)
    local err_type, err_code, _err_msg, params, cb = ...
    local last_err_code = err_code
    
    local function on_request_cloud_cb(succ2, ...)
      E.LOG.debug(TAG, "[cloud game] retry_connect result " .. tostring(succ2))
      if succ2 then
        _fsm_enqueue_event_at_front(_EVENTS.ON_CONNECT_SUCC, params, cb)
      else
        last_err_code = (...)
        _fsm_enqueue_event_at_front(_EVENTS.ON_CONNECT_ERROR, err_type, err_code, nil, params, cb)
      end
      data.is_retry_connecting = false
      _fsm_on_async_event_finished(_EVENTS.RETRY_CONNECT)
    end
    
    data.is_retry_connecting = true
    _fsm_transition_to(nil, M.STATES.CONNECTING)
    M._retry_connect_cloud(on_request_cloud_cb, last_err_code)
    return FSM.ASYNC
  end,
  ["on" .. _EVENTS.ON_CONNECT_TIME_END] = function(_f_self, from, ...)
    E.LOG.debug(TAG, "receive event ON_CONNECT_TIME_END, from:" .. tostring(from))
    if from == M.STATES.ON_CONNECT_TIME_END then
      E.LOG.debug(TAG, "already connect_time_end state, skip")
      return FSM.SYNC
    end
    if from == M.STATES.CONNECTED then
      E.LOG.debug(TAG, "its connected state, now stop game")
      _cloud_manager.stop_game(function(_succ)
        E.LOG.debug(TAG, "stop game result:" .. tostring(_succ))
      end)
    end
    CG.change_native_network_quality_visible(false)
    _cloud_facade.open_full_download()
    return FSM.SYNC, M.STATES.CONNECT_TIME_END
  end,
  ["on" .. _EVENTS.ON_PAUSE_GAME] = function(_f_self, _from, ...)
    return FSM.SYNC, M.STATES.CONNECT_PAUSE
  end,
  ["on" .. _EVENTS.ON_RESUME_GAME] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "resume game from not pause state, check pause pending actions")
    resume_check_pause_pending_actions(_from)
    if _from ~= M.STATES.CONNECT_PAUSE then
      return
    end
    return FSM.SYNC, M.STATES.CONNECTED
  end,
  ["on" .. _EVENTS.ON_STOP_GAME] = function(_f_self, _from, ...)
    return FSM.SYNC, M.STATES.DIS_CONNECT
  end,
  ["onenter" .. M.STATES.IDLE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm idle")
    data.current_state.state = M.STATES.IDLE
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.INITTING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm initting")
    data.current_state.state = M.STATES.INITTING
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.INITTED] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm initted")
    data.current_state.state = M.STATES.INITTED
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.INIT_FAILED] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm init faild")
    data.current_state.state = M.STATES.INIT_FAILED
    notify_state_changed()
    local code, msg, params, cb = ...
    local err_type = CLOUD_UI.ErrorType.InitSdkError
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = err_type
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = code
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = msg
    
    local function retry_cb()
      E.LOG.debug(TAG, "on click retry btn, now re init ejoy")
      _fsm_enqueue_event(_EVENTS.INIT_EJOY, params, cb)
    end
    
    E.LOG.warn(TAG, "begin show InitSdkError type ui, code:" .. tostring(code))
    CLOUD_UI.set_ui_error(CLOUD_UI.ErrorType.InitSdkError, code, retry_cb)
    cancel_download_speed_limit()
  end,
  ["onenter" .. M.STATES.CONNECTING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm connecting")
    data.current_state.state = M.STATES.CONNECTING
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
    notify_state_changed()
    enable_download_speed_limit()
    if not data.is_retry_connecting and not E.WebView.is_opened() then
      CG.show_loading()
    end
  end,
  ["onleave" .. M.STATES.CONNECTING] = function()
    E.LOG.debug(TAG, "onleave csm connecting")
    CG.hide_loading()
  end,
  ["onenter" .. M.STATES.CONNECTED] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm connected")
    data.current_state.state = M.STATES.CONNECTED
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
    CTM.start_poll_time()
    enable_download_speed_limit()
    cloud_adapter.set_retry_connected_tip("")
    cloud_adapter.set_cloud_visibility(true)
    CLOUD_UI.set_is_retry_connecting(false)
    CLOUD_UI.reset_error_ui_state()
    notify_state_changed()
    local params = (...)
    params = params or {}
    E.LOG.debug(TAG, "onenter connected is_first_time_connect:" .. tostring(data.is_first_time_connect) .. ", from:" .. tostring(_from))
    if (data.is_first_time_connect or params[M.PARAMS.IS_MANUAL_CONNECT] == true) and _from == M.STATES.CONNECTING then
      E.LOG.debug(TAG, "show_free_cg_tips begin")
      data.is_first_time_connect = false
    end
    if CC.DEBUG_OPTIONS.TestConnectedRecvFailed then
      E.LOG.debug(TAG, "TestConnectedRecvFailed")
      E.Timer.once(8, function()
        local cg = require("ejoysdk_lua.cloud_game.cloud_manager")
        cg.on_cg_error(10086, "测试错误")
        cg.stop_connect_with_remote_game()
      end)
    end
    CSTAT.stat_connect_end(true)
  end,
  ["onenter" .. M.STATES.DIS_CONNECT] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm connect disconnect")
    CTM.stop_poll_time()
    _cloud_facade.open_full_download()
    cancel_download_speed_limit()
    local err_type, err_code, err_msg, params, cb = ...
    params = params or {}
    if nil == err_type and nil == err_code and nil == err_msg then
      E.LOG.debug(TAG, "error msg is nil, do not retry connect ")
      data.current_state.state = M.STATES.DIS_CONNECT
      notify_state_changed()
      if cb then
        cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.CLOUD_CONNECT_STOPPED, "connect stopped")
      end
    else
      data.current_state.state = M.STATES.DIS_CONNECT
      data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = err_type
      data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = err_code
      data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = err_msg
      notify_state_changed()
      local retry_cb
      
      function retry_cb()
        E.LOG.debug(TAG, "retry_cb clicked, err_code >> " .. tostring(err_code))
        _fsm_enqueue_event_at_front(_EVENTS.RETRY_CONNECT, err_type, err_code, err_msg, params, cb)
      end
      
      if not params[M.PARAMS.IS_MANUAL_CONNECT] and M.need_intercept_error(err_code) then
        E.LOG.warn(TAG, "on_connect_error, before set_ui_error type:" .. tostring(err_type) .. ", code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        if is_auto_retry_connect(err_code) then
          retry_cb()
        else
          local function show_err_ui_action()
            if err_code and 8022 == err_code then
              if current_activity_state == CC.ACTIVITY_STATE.ON_STOP then
                E.LOG.debug(TAG, "current activity state is on stop, do not show error and wait on start")
                
                cache_8022_error.cb = retry_cb
              else
                CLOUD_UI.show_on_cg_error(retry_cb, true, err_code)
              end
            else
              CLOUD_UI.show_on_cg_error(retry_cb, false, err_code)
            end
          end
          
          if _from ~= M.STATES.CONNECT_PAUSE then
            show_err_ui_action()
          else
            E.LOG.debug(TAG, "on_cg_error from pause state, then add pending action")
            table.insert(_pause_state_disconn_pending_actions, show_err_ui_action)
          end
        end
      else
        E.LOG.warn(TAG, "connect error not show for errcode not intercept:" .. tostring(err_code))
        local _params = {
          [M.PARAMS.SHOW_RATIONALE] = false
        }
        M.close_cloud_game_view(_params)
        if cb then
          cb(false, err_code, err_msg)
        end
      end
      CSTAT.stat_connect_end(false, err_code, err_msg)
    end
  end,
  ["onleave" .. M.STATES.DIS_CONNECT] = function()
    E.LOG.debug(TAG, "onleave csm DIS_CONNECT, clear disconnect pending actions")
    _pause_state_disconn_pending_actions = {}
  end,
  ["onenter" .. M.STATES.CONNECT_TIME_END] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm CONNECT_TIME_END")
    data.current_state.state = M.STATES.CONNECT_TIME_END
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
    notify_state_changed()
    cancel_download_speed_limit()
  end,
  ["onenter" .. M.STATES.CONNECT_PAUSE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter csm ON_PAUSE_GAME")
    data.current_state.state = M.STATES.CONNECT_PAUSE
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_TYPE] = nil
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_CODE] = 0
    data.current_state[M.STATE_INFO_KEY.KEY_FAIL_MSG] = nil
    notify_state_changed()
  end
}

function M.init(params, cb)
  _cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
  _cloud_facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  data.product = _cloud_manager.get_product()
  E.LOG.debug(TAG, "csm init begin")
  _connect_fsm = FSM.create({
    initial = M.STATES.IDLE,
    events = {
      {
        name = _EVENTS.INIT_EJOY,
        from = M.STATES.IDLE,
        to = M.STATES.INITTING
      },
      {
        name = _EVENTS.INIT_EJOY,
        from = M.STATES.IDLE,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.INIT_EJOY,
        from = M.STATES.INIT_FAILED,
        to = M.STATES.INITTING
      },
      {
        name = _EVENTS.ON_INIT_EJOY_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.INITTED
      },
      {
        name = _EVENTS.ON_INIT_EJOY_FAILED,
        from = M.STATES.INITTING,
        to = M.STATES.INIT_FAILED
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.INITTED,
        to = M.STATES.CONNECTING
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.DIS_CONNECT,
        to = M.STATES.CONNECTING
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.INIT_FAILED
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.INITTING
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.CONNECTED,
        to = M.STATES.CONNECTED
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.CONNECTING,
        to = M.STATES.CONNECTED
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.CONNECT_PAUSE,
        to = M.STATES.CONNECTED
      },
      {
        name = _EVENTS.STOP_CONNECT_REMOTE,
        from = M.STATES.CONNECT_PAUSE,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.STOP_CONNECT_REMOTE,
        from = M.STATES.CONNECTED,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.STOP_CONNECT_REMOTE,
        from = M.STATES.CONNECTING,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.STOP_CONNECT_REMOTE,
        from = M.STATES.DIS_CONNECT,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.STOP_CONNECT_REMOTE,
        from = M.STATES.CONNECT_TIME_END,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.CLOSE_CLOUD_GAME_VIEW,
        from = M.STATES.CONNECTED,
        to = M.STATES.CONNECT_PAUSE
      },
      {
        name = _EVENTS.CLOSE_CLOUD_GAME_VIEW,
        from = M.STATES.CONNECTING,
        to = M.STATES.CONNECT_PAUSE
      },
      {
        name = _EVENTS.CLOSE_CLOUD_GAME_VIEW,
        from = M.STATES.DIS_CONNECT,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.CLOSE_CLOUD_GAME_VIEW,
        from = M.STATES.CONNECT_TIME_END,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.CLOSE_CLOUD_GAME_VIEW,
        from = M.STATES.CONNECT_PAUSE,
        to = M.STATES.CONNECT_PAUSE
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.INITTING,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.INITTED,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.INIT_FAILED,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.CONNECTING,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.DIS_CONNECT,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.CONNECTED,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_TIME_END,
        from = M.STATES.CONNECT_TIME_END,
        to = M.STATES.CONNECT_TIME_END
      },
      {
        name = _EVENTS.ON_CONNECT_ERROR,
        from = M.STATES.CONNECTING,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.ON_CONNECT_ERROR,
        from = M.STATES.CONNECTED,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.ON_CONNECT_ERROR,
        from = M.STATES.CONNECT_PAUSE,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.ON_CONNECT_ERROR,
        from = M.STATES.DIS_CONNECT,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.ON_STOP_GAME,
        from = M.STATES.CONNECTED,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.ON_STOP_GAME,
        from = M.STATES.CONNECT_PAUSE,
        to = M.STATES.DIS_CONNECT
      },
      {
        name = _EVENTS.ON_CONNECT_SUCC,
        from = M.STATES.CONNECTING,
        to = M.STATES.CONNECTED
      },
      {
        name = _EVENTS.RETRY_CONNECT,
        from = M.STATES.DIS_CONNECT,
        to = M.STATES.CONNECTING
      },
      {
        name = _EVENTS.ON_PAUSE_GAME,
        from = M.STATES.CONNECTED,
        to = M.STATES.CONNECT_PAUSE
      },
      {
        name = _EVENTS.ON_PAUSE_GAME,
        from = M.STATES.CONNECTING,
        to = M.STATES.CONNECT_PAUSE
      },
      {
        name = _EVENTS.ON_RESUME_GAME,
        from = M.STATES.CONNECT_PAUSE,
        to = M.STATES.CONNECTED
      },
      {
        name = _EVENTS.ON_RESUME_GAME,
        from = M.STATES.DIS_CONNECT
      }
    },
    callbacks = fsm_callbacks
  })
  _fsm_enqueue_event(_EVENTS.INIT_EJOY, params, function(succ, ...)
    is_inited = succ
    if succ then
      E.LOG.debug(TAG, "init succ")
      if has_call_connect_remote and connect_remote_cb then
        E.LOG.debug(TAG, "has connect remote is true, connect")
        M.connect_remote(connect_remote_params, connect_remote_cb)
        has_call_connect_remote = false
      end
    else
      local _code, _msg = ...
      E.LOG.debug(TAG, "init failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.connect_remote(params, cb)
  E.LOG.debug(TAG, "connect remote >>")
  if is_inited then
    _fsm_enqueue_event(_EVENTS.CONNECT_REMOTE, params, cb)
  else
    has_call_connect_remote = true
    connect_remote_params = params
    connect_remote_cb = cb
    M.init({}, function()
    end)
  end
end

function M.stop_connect_remote(params, cb)
  _fsm_enqueue_event(_EVENTS.STOP_CONNECT_REMOTE, params, cb)
end

function M.on_connect_error(err_type, error_code)
  E.LOG.warn(TAG, "on_connect_error, err_type:" .. tostring(err_type) .. ", err_code:" .. tostring(error_code) .. ", is_retrying:" .. tostring(data.is_retry_connecting))
  if data.is_retry_connecting then
    E.LOG.warn(TAG, "on_connect_error skip, for current retry connecting")
    return
  end
  _fsm_enqueue_event(_EVENTS.ON_CONNECT_ERROR, err_type, error_code)
end

function M.on_connect_time_end()
  _fsm_enqueue_event(_EVENTS.ON_CONNECT_TIME_END)
end

function M.on_pause_game()
  _fsm_enqueue_event(_EVENTS.ON_PAUSE_GAME)
end

function M.on_resume_game()
  _fsm_enqueue_event(_EVENTS.ON_RESUME_GAME)
end

function M.register_connect_state_changed(state_change_listener)
  data.connect_state_change_listener = state_change_listener
end

function M.current_connect_state()
  return data.current_state[M.STATE_INFO_KEY.KEY_STATE]
end

function M.current_state_info()
  return data.current_state
end

function M.is_connect_pause()
  local state = data.current_state[M.STATE_INFO_KEY.KEY_STATE]
  return state == M.STATES.CONNECT_PAUSE
end

function M.close_cloud_game_view(params, cb)
  E.LOG.debug(TAG, "close cloud game view begin")
  if _connect_fsm then
    _fsm_enqueue_event(_EVENTS.CLOSE_CLOUD_GAME_VIEW, params, cb)
  elseif CC.SelfStart then
    E.LOG.debug(TAG, "exit_app kill process")
    if cb then
      cb(true)
    end
    E.kill_game_process()
  else
    E.LOG.debug(TAG, "connect fsm is nil, close cloud game view")
    cloud_adapter.close_cloud_game_view(params, cb)
  end
end

return M
