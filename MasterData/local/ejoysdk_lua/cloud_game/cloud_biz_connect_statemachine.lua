local E = require("ejoysdk_lua.ejoysdk")
local CTM = require("ejoysdk_lua.cloud_game.cloud_time_limit_checker")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local CSM = require("ejoysdk_lua.cloud_game.cloud_connect_statemachine")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local BaseFsm = require("ejoysdk_lua.cloud_game.cloud_biz_base_statemachine")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local FREE_FLOW = require("ejoysdk_lua.cloud_game.cloud_free_data_pkg")
local UI_STAT = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_ui_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FSM = UTILS.fsm
local FSM_NAME = "CloudConnBiz"
local TAG = FSM_NAME
local M = BaseFsm:Inherit(FSM_NAME)
M.LIMIT_STAGES = CSM.LIMIT_STAGES
M.CONNECT_STATE = CSM.STATES
M.CONNECT_PARAMS = CSM.PARAMS
M.CONNECT_STATE_INFO_KEY = CSM.STATE_INFO_KEY
M.CONNECT_BIZ_INFO_KEY = {STATE = "state"}
M.STATES = {
  IDLE = "idle",
  INITTING = "initting",
  TIME_END = "time_end",
  HAS_TIME = "has_time"
}
M.TIME_LIMIT_STATE_INFO_KEY = {
  KEY_STAGE = "stage",
  KEY_IS_EXPERIENCE_END = "is_experience_time_end",
  KEY_IS_TOTAL_PLAY_END = "is_total_play_time_end",
  KEY_EXPERIENCE_PLAY_TOTAL_TIME_MIN = "experience_play_total_time_min",
  KEY_PLAY_TOTAL_TIME_MIN = "play_total_time_min",
  KEY_CURRENT_PLAY_TIME_MIN = "current_play_time_min",
  KEY_REMAIN_EXPERIENCE_PLAY_TIME_MIN = "remain_experience_play_time_min",
  KEY_REMAIN_PLAY_TOTAL_TIME_MIN = "remain_play_total_time_min",
  KEY_DOWNLOAD_COMPLETE_EXPERIENCE_TIME_MIN = "download_complete_experience_time_min",
  KEY_REFRESH_TIME_STAMP = "refresh_time_stamp",
  KEY_NEXT_INTERVAL = "next_interval"
}
local _EVENTS = {
  INIT = "init",
  INIT_SUCC = "init_succ",
  INIT_FAILED = "init_failed",
  CONNECT_REMOTE = "connect_remote",
  ON_LIMIT_TIME_CHANGED_TO_END = "on_limit_time_changed_to_end",
  CHECK_CLOUD_AVAILABLE = "check_cloud_available"
}
local _biz_fsm, _download_biz_fsm, _cloud_manager
local _conn_biz_state_change_listeners = {}
local _connect_state
local _connect_biz_state = {}
local _time_limit_state
local is_inited = false
local data = {on_data_pay_type_change_cb = nil}

local function on_cloud_state_changed()
  E.log(_connect_state)
  E.log(_connect_biz_state)
  for _, cb in ipairs(_conn_biz_state_change_listeners) do
    cb(_connect_state, _connect_biz_state, _time_limit_state)
  end
end

local function _fsm_enqueue_event_at_front(event_name, ...)
  _biz_fsm:enqueue_event(event_name, true, ...)
end

local function _fsm_enqueue_event(event_name, ...)
  _biz_fsm:enqueue_event(event_name, false, ...)
end

local function _fsm_transition_to(from_state, to_state, ...)
  from_state = from_state or _biz_fsm.current
  E.LOG.debug(TAG, "_fsm_transition_to, from:" .. tostring(from_state) .. ", to_state:" .. tostring(to_state))
  _biz_fsm:transition(from_state, to_state, ...)
end

local function _fsm_on_async_event_finished(event_name)
  _biz_fsm:notify_async_finish(event_name)
end

local function parse_time_limit_state_info(limit_state_obj, keep_time_sec)
  local state_info = {}
  local stage = limit_state_obj[CTM.STATE_INFO_KEY.KEY_STAGE]
  state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_STAGE] = stage
  if stage == CTM.TIME_LIMIT_STAGE.UNKNOWN then
    E.LOG.debug("parse_time_limit_state_info, its unkown, skip set other info")
    return state_info
  end
  E.LOG.warn(TAG, "update_time_limit_state_info skip, current stage is unknown")
  local experience_time_limit_min, total_time_limit_min, current_play_time_min
  if keep_time_sec then
    experience_time_limit_min = limit_state_obj[CTM.STATE_INFO_KEY.KEY_EXPERIENCE_TIME_LIMIT_SEC]
    total_time_limit_min = limit_state_obj[CTM.STATE_INFO_KEY.KEY_TOTAL_TIME_LIMIT_SEC]
    current_play_time_min = limit_state_obj[CTM.STATE_INFO_KEY.KEY_PLAY_TIME_SEC]
  else
    experience_time_limit_min = limit_state_obj[CTM.STATE_INFO_KEY.KEY_EXPERIENCE_TIME_LIMIT_SEC] / 60
    total_time_limit_min = limit_state_obj[CTM.STATE_INFO_KEY.KEY_TOTAL_TIME_LIMIT_SEC] / 60
    current_play_time_min = limit_state_obj[CTM.STATE_INFO_KEY.KEY_PLAY_TIME_SEC] / 60
  end
  state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_EXPERIENCE_PLAY_TOTAL_TIME_MIN] = experience_time_limit_min
  state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_PLAY_TOTAL_TIME_MIN] = total_time_limit_min
  state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_CURRENT_PLAY_TIME_MIN] = current_play_time_min
  state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REFRESH_TIME_STAMP] = limit_state_obj[CTM.STATE_INFO_KEY.KEY_REFRESH_TIME_STAMP]
  state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_NEXT_INTERVAL] = limit_state_obj[CTM.STATE_INFO_KEY.KEY_NEXT_INTERVAL]
  if keep_time_sec then
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_DOWNLOAD_COMPLETE_EXPERIENCE_TIME_MIN] = limit_state_obj[CTM.STATE_INFO_KEY.KEY_DOWNLOAD_COMPLETE_EXPERIENCE_LIMIT_SEC]
  else
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_DOWNLOAD_COMPLETE_EXPERIENCE_TIME_MIN] = limit_state_obj[CTM.STATE_INFO_KEY.KEY_DOWNLOAD_COMPLETE_EXPERIENCE_LIMIT_SEC] / 60
  end
  if stage == CTM.TIME_LIMIT_STAGE.IN_EXPERIENCE_TIME then
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_EXPERIENCE_END] = false
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_TOTAL_PLAY_END] = false
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_EXPERIENCE_PLAY_TIME_MIN] = experience_time_limit_min - current_play_time_min
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_PLAY_TOTAL_TIME_MIN] = total_time_limit_min - current_play_time_min
  elseif stage == CTM.TIME_LIMIT_STAGE.EXPERIENCE_TIME_END then
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_EXPERIENCE_END] = true
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_TOTAL_PLAY_END] = false
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_EXPERIENCE_PLAY_TIME_MIN] = 0
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_PLAY_TOTAL_TIME_MIN] = total_time_limit_min - current_play_time_min
  elseif stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING then
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_EXPERIENCE_END] = true
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_TOTAL_PLAY_END] = false
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_EXPERIENCE_PLAY_TIME_MIN] = 0
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_PLAY_TOTAL_TIME_MIN] = total_time_limit_min - current_play_time_min
  elseif stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_EXPERIENCE_END] = true
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_IS_TOTAL_PLAY_END] = true
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_EXPERIENCE_PLAY_TIME_MIN] = 0
    state_info[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_PLAY_TOTAL_TIME_MIN] = 0
  end
  return state_info
end

function M.update_time_limit_state_info(limit_state_obj)
  _time_limit_state = parse_time_limit_state_info(limit_state_obj)
  E.LOG.debug(TAG, "on_time_limit_state_change >>")
  E.log(_time_limit_state)
  on_cloud_state_changed()
end

local function _show_splash_ui(wifi_need_user_confirm, download_confirm_cb, connect_confirm_cb, splash_dismiss_cb)
  E.LOG.debug(TAG, "_show_splash_ui begin, wifi_need_user_confirm:" .. tostring(wifi_need_user_confirm))
  
  local function splash_ui_dimiss_listener()
    E.LOG.debug(TAG, "splash dismissed, now show peding errors")
    if splash_dismiss_cb then
      splash_dismiss_cb()
    end
  end
  
  UI_STAT.set_need_show_confirm(wifi_need_user_confirm)
  local need_show_user_confirm = wifi_need_user_confirm or CA.is_mobile_network()
  if not need_show_user_confirm then
    UI.show_flash_screen()
    UI.hide_flash_screen(5, function()
      E.LOG.debug(TAG, "begin delay hide flash screen")
      splash_ui_dimiss_listener()
    end)
    if download_confirm_cb then
      download_confirm_cb(false, M.DOWNLOAD_STRATEGY.DOWNLOAD_IN_WIFI_ONLY, false)
    end
    if connect_confirm_cb then
      connect_confirm_cb(true)
    end
  else
    local is_mobile_network = CA.is_mobile_network()
    if not is_mobile_network and connect_confirm_cb then
      E.LOG.debug(TAG, "_show_splash_ui, need user confirm. its wifi, could connect first")
      connect_confirm_cb(true)
    end
    UI.show_exper_flash_screen(function(is_download, is_user_confirmed_strategy)
      if is_mobile_network and connect_confirm_cb then
        E.LOG.debug(TAG, "_show_splash_ui, user confirmed, now begin connect")
        connect_confirm_cb(true)
      end
      local download_strategy = M.DOWNLOAD_STRATEGY.DOWNLOAD_IN_WIFI_ONLY
      if is_download then
        download_strategy = M.DOWNLOAD_STRATEGY.DOWNLOAD_FORCE_IN_MOBILE_NETWORK
      end
      if download_confirm_cb then
        download_confirm_cb(false, download_strategy, is_user_confirmed_strategy)
      end
      splash_ui_dimiss_listener()
    end, need_show_user_confirm)
  end
end

local function is_total_play_time_end()
  local state_obj = CSM.current_state_info()
  local stage = state_obj[CTM.STATE_INFO_KEY.KEY_STAGE]
  return stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END
end

local function on_data_pay_type_change()
  if is_total_play_time_end() then
    return
  end
  if data.on_data_pay_type_change_cb then
    data.on_data_pay_type_change_cb()
  end
end

local function on_network_change()
  E.LOG.debug(TAG, "receive network change callback, check is network available")
  if is_total_play_time_end() then
    return
  end
  local is_network_available = CA.is_network_available()
  E.LOG.debug(TAG, "cloud_state_manager on_download_type_change, is available: " .. tostring(is_network_available))
end

function M.user_confirmed_download_state(is_force_download, is_confirmed)
  local strategy = M.DOWNLOAD_STRATEGY.DOWNLOAD_IN_WIFI_ONLY
  if is_force_download then
    strategy = M.DOWNLOAD_STRATEGY.DOWNLOAD_FORCE_IN_MOBILE_NETWORK
  end
  E.LOG.debug(TAG, "update_download_strategy click force result:" .. tostring(is_force_download) .. ", strategy:" .. tostring(strategy) .. ", is_confirmed:" .. tostring(is_confirmed))
  _download_biz_fsm.update_download_strategy(strategy, is_confirmed)
end

function M.check_data_type_change()
  local pay_type = FREE_FLOW.get_current_data_pay_type()
  E.LOG.debug(TAG, "subscribe DOWNLOAD_TYPE_CHANGE2")
  
  function data.on_data_pay_type_change_cb()
    pay_type = FREE_FLOW.get_current_data_pay_type()
    E.LOG.debug(TAG, "check pay type change invoke, current pay type >> " .. tostring(pay_type))
    if _download_biz_fsm.current_download_state() == _download_biz_fsm.DOWNLOAD_STATES.DOWNLOAD_COMPLETE then
      E.LOG.debug(TAG, "on_download_type_change skip in download_complete state")
      data.on_data_pay_type_change_cb = nil
      return
    end
    UI_STAT.stat_splash_show()
    E.LOG.debug(TAG, "check is show network tips, is network available " .. tostring(CA.is_network_available()))
    E.LOG.debug(TAG, "data pay type >> " .. tostring(pay_type))
  end
  
  E.LOG.debug(TAG, "begin subscribe download type change >>")
  FREE_FLOW.register_data_pay_type_changed_cb(on_data_pay_type_change)
  ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change)
end

local function on_connect_state_change_listener(connect_state_info)
  E.LOG.debug(TAG, "on_connect_state_change_listener received")
  _connect_state = connect_state_info
  on_cloud_state_changed()
end

local fsm_callbacks = {
  ["on" .. _EVENTS.INIT] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event init")
    _fsm_transition_to(M.STATES.IDLE, M.STATES.INITTING)
    local params, cb = ...
    params = params or {}
    local is_reiniting = params.is_reiniting
    if is_reiniting then
      E.LOG.debug(TAG, "init from reiniting, now show loading")
      CA.show_loading()
    end
    CSM.register_connect_state_changed(on_connect_state_change_listener)
    CTM.init()
    local on_time_limit_handler
    
    function on_time_limit_handler()
      E.LOG.debug(TAG, "request_time_config succ, now init sdk")
      local current_state_info = CTM.current_state_info()
      M.update_time_limit_state_info(current_state_info)
      local current_stage = current_state_info[CTM.STATE_INFO_KEY.KEY_STAGE]
      if CC.DEBUG_OPTIONS.TestConnectTimeEnd then
        E.LOG.warn(TAG, "TestConnectTimeEnd enabled")
        current_stage = CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END
      end
      if CC.DEBUG_OPTIONS.TestConnectedDelayTimeEnd then
        E.LOG.warn(TAG, "TestConnectedDelayTimeEnd enabled")
        E.Timer.once(6, function()
          _fsm_enqueue_event(_EVENTS.ON_LIMIT_TIME_CHANGED_TO_END, {})
        end)
      end
      if current_stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
        E.LOG.warn(TAG, "current time end, start send event to ON_LIMIT_CHECK_TIME_END")
        _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.TIME_END)
      else
        E.LOG.debug(TAG, "current not time end, start send event to ON_LIMIT_CHECK_HAS_TIME")
        _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.HAS_TIME)
      end
    end
    
    BaseFsm.static_check_cloud_config(function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "request cloud config succ")
        CTM.on_change_from_cloud_config()
        on_time_limit_handler()
      else
        local _code, _msg = ...
        _fsm_enqueue_event_at_front(_EVENTS.INIT_FAILED, _code, _msg, params, cb)
      end
      if cb then
        cb(succ, ...)
      end
      _fsm_on_async_event_finished(_EVENTS.INIT)
    end)
    return FSM.ASYNC
  end,
  ["on" .. _EVENTS.INIT_SUCC] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event INIT_SUCC")
    CA.hide_loading()
    local state = (...)
    CSM.init({}, function()
    end)
    return FSM.SYNC, state
  end,
  ["on" .. _EVENTS.INIT_FAILED] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event INIT_FAILED")
    CA.hide_loading()
    local _code, _msg, params, cb = ...
    return FSM.SYNC, M.STATES.IDLE, _code, _msg, params, cb
  end,
  ["on" .. _EVENTS.ON_LIMIT_TIME_CHANGED_TO_END] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event: ON_LIMIT_TIME_CHANGED_TO_END")
    CSTAT.stat_action("mini_client_limit_time_end_exit")
    return FSM.SYNC, M.STATES.TIME_END
  end,
  ["on" .. _EVENTS.CHECK_CLOUD_AVAILABLE] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event: CHECK_CLOUD_AVAILABLE")
    local cb = (...)
    if _from == M.STATES.INITTING then
      _fsm_enqueue_event(_EVENTS.CHECK_CLOUD_AVAILABLE, cb)
      return
    else
      local is_available = _biz_fsm.current ~= M.STATES.TIME_END
      E.LOG.debug(TAG, "check avaiable, current:" .. tostring(_biz_fsm.current) .. ", is_available:" .. tostring(is_available))
      if cb then
        cb(true, is_available)
      end
    end
    return FSM.SYNC
  end,
  ["on" .. _EVENTS.CONNECT_REMOTE] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event CONNECT_REMOTE: " .. tostring(_from))
    local params, cb = ...
    if _from == M.STATES.IDLE then
      _fsm_enqueue_event_at_front(_EVENTS.INIT, params, function(succ, ...)
        if succ then
          E.LOG.debug(TAG, "init succ, now continue connect remote")
          _fsm_enqueue_event(_EVENTS.CONNECT_REMOTE, params, cb)
        else
          local _code, _msg = ...
          if cb then
            cb(false, _code, _msg)
          end
        end
      end)
      return FSM.SYNC
    elseif _from == M.STATES.INITTING then
      E.LOG.debug(TAG, "init succ, now continue connect remote")
      _fsm_enqueue_event(_EVENTS.CONNECT_REMOTE, params, cb)
      return FSM.SYNC
    elseif _from == M.STATES.TIME_END then
      if cb then
        E.LOG.debug(TAG, "connect remote from time end, directly return")
        cb(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.CLOUD_TIME_END, "cloud time end")
      end
      return FSM.SYNC
    elseif _from == M.STATES.HAS_TIME then
      CSM.connect_remote(params, function(_succ1, ...)
        if _succ1 then
          E.LOG.debug(TAG, "init_and_connect_cloud, connect succ:" .. tostring(_succ1))
        else
          local code, msg = ...
          E.LOG.warn("init_and_connect_cloud, connect failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
        if cb then
          cb(_succ1, ...)
        end
      end)
      return FSM.SYNC
    end
    return FSM.SYNC
  end,
  ["onenter" .. M.STATES.INITTING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter cbc INITTING")
    _connect_biz_state[M.CONNECT_BIZ_INFO_KEY.STATE] = M.STATES.INITTING
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.IDLE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter cbc IDLE")
    _connect_biz_state[M.CONNECT_BIZ_INFO_KEY.STATE] = M.STATES.IDLE
    if _from == M.STATES.INITTING then
      local _code, _msg, params, cb = ...
      params = params or {}
      if not params[M.CONNECT_PARAMS.IS_MANUAL_CONNECT] then
        E.LOG.debug(TAG, "its not manual connect, now show error UI")
        
        local function retry_cb()
          params.is_reiniting = true
          _fsm_enqueue_event(_EVENTS.INIT, params, cb)
        end
        
        BaseFsm.static_show_error_retry_ui(_code, _msg, retry_cb)
      end
    end
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.HAS_TIME] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter cbc HAS_TIME")
    _connect_biz_state[M.CONNECT_BIZ_INFO_KEY.STATE] = M.STATES.HAS_TIME
    
    local function download_confirm_handler(start_now, download_strategy, user_confirmed_strategy)
      E.LOG.debug(TAG, "check_download_while_play_state, user_confirmed_strategy:" .. tostring(user_confirmed_strategy))
      _download_biz_fsm.update_download_strategy(download_strategy, user_confirmed_strategy)
      if start_now then
        _download_biz_fsm.start_download()
      end
    end
    
    local function connect_confirm_handler(connect_now)
      if connect_now then
        _cloud_manager.connect_with_remote_game({}, function(_succ, ...)
        end)
      end
    end
    
    local function splash_dismiss_handler()
      E.LOG.debug(TAG, "splash_dismiss_handler received")
    end
    
    CSTAT.stat_splash_show()
    local connect_now = CC.SelfStart
    
    local function show_download_conn_splash()
      E.LOG.debug(TAG, "its updating and its a big update, so use play as download")
      local wifi_need_user_confirm_switch = CC.get_is_splash_btn()
      if not _download_biz_fsm.is_user_confirmed_download_strategy() then
        if not CA.is_mobile_network() then
          _show_splash_ui(wifi_need_user_confirm_switch, download_confirm_handler, connect_confirm_handler, splash_dismiss_handler)
        else
          FREE_FLOW.check_and_show_ctcc_splash(function()
            connect_confirm_handler(true)
            download_confirm_handler(false, M.DOWNLOAD_STRATEGY.DOWNLOAD_IN_WIFI_ONLY, false)
          end)
        end
      else
        E.LOG.debug(TAG, "download strategy is confirmed, now no need wait user confirm")
        connect_confirm_handler(connect_now)
      end
    end
    
    if not CC.DisableDownload then
      E.LOG.debug(TAG, "download not disable, now check and show splash")
      local current_download_biz_state = _download_biz_fsm.current_state()
      if current_download_biz_state == _download_biz_fsm.STATES.QUICK_UPDATING then
        CSTAT.stat_action("cloud_res_state_update_connect")
        UI.show_updating_as_play(function()
          show_download_conn_splash()
        end)
      else
        show_download_conn_splash()
      end
    else
      E.LOG.debug(TAG, "download disable, check connect, connect_now:" .. tostring(connect_now))
      connect_confirm_handler(connect_now)
    end
    E.LOG.debug(TAG, "_show_splash_ui and begin listen network state change")
    M.check_data_type_change()
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.TIME_END] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter cbc TIME_END")
    _connect_biz_state[M.CONNECT_BIZ_INFO_KEY.STATE] = M.STATES.TIME_END
    CSM.on_connect_time_end()
    UI_STAT.stat_show_total_time_end()
    on_cloud_state_changed()
  end
}

function M.init(_params, cb)
  if is_inited then
    E.LOG.debug(TAG, "already inited, return")
    return
  end
  E.LOG.debug(TAG, "begin init conn_biz_fsm")
  _cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
  _download_biz_fsm = require("ejoysdk_lua.cloud_game.cloud_biz_download_statemachine")
  _biz_fsm = FSM.create({
    initial = M.STATES.IDLE,
    events = {
      {
        name = _EVENTS.INIT,
        from = M.STATES.IDLE,
        to = M.STATES.INITTING
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.TIME_END
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.HAS_TIME
      },
      {
        name = _EVENTS.INIT_FAILED,
        from = M.STATES.INITTING,
        to = M.STATES.IDLE
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.TIME_END,
        to = M.STATES.TIME_END
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.HAS_TIME
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.IDLE
      },
      {
        name = _EVENTS.CONNECT_REMOTE,
        from = M.STATES.INITTING
      },
      {
        name = _EVENTS.CHECK_CLOUD_AVAILABLE,
        from = M.STATES.TIME_END
      },
      {
        name = _EVENTS.CHECK_CLOUD_AVAILABLE,
        from = M.STATES.HAS_TIME
      },
      {
        name = _EVENTS.CHECK_CLOUD_AVAILABLE,
        from = M.STATES.IDLE
      },
      {
        name = _EVENTS.CHECK_CLOUD_AVAILABLE,
        from = M.STATES.INITTING
      },
      {
        name = _EVENTS.ON_LIMIT_TIME_CHANGED_TO_END,
        from = M.STATES.HAS_TIME,
        to = M.STATES.TIME_END
      }
    },
    callbacks = fsm_callbacks
  })
  _fsm_enqueue_event(_EVENTS.INIT, _params, function(succ, ...)
    is_inited = succ
    if succ then
      E.LOG.debug(TAG, "init succ")
    else
      local _code, _msg = ...
      E.LOG.debug(TAG, "init failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.register_conn_biz_state_change_listener(cb)
  for _, handler in ipairs(_conn_biz_state_change_listeners) do
    if handler == cb then
      return
    end
  end
  _conn_biz_state_change_listeners[#_conn_biz_state_change_listeners + 1] = cb
  E.LOG.debug(TAG, "register_download_biz_state_change_listener succ")
end

function M.unregister_conn_biz_state_change_listener(cb)
  local new = {}
  for _, handler in ipairs(_conn_biz_state_change_listeners) do
    if cb ~= handler then
      new[#new + 1] = handler
    end
  end
  _conn_biz_state_change_listeners = new
  E.LOG.debug(TAG, "unregister_download_biz_state_change_listener succ")
end

function M.connect_remote(params, cb)
  local function do_connect_fun()
    E.LOG.debug(TAG, "connect_remote begin")
    
    _fsm_enqueue_event(_EVENTS.CONNECT_REMOTE, params, cb)
  end
  
  if not is_inited then
    M.init(params, function(succ, ...)
      if succ then
        do_connect_fun()
      elseif cb then
        cb(false, ...)
      end
    end)
  else
    do_connect_fun()
  end
end

function M.stop_connect_remote(params, cb)
  if not is_inited then
    E.LOG.debug(TAG, "stop_connect_remote in not inited state, directly return stop true")
    if cb then
      cb(true)
    end
    return
  end
  E.LOG.debug(TAG, "stop_connect_remote begin")
  CSM.stop_connect_remote(params, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.current_state_info()
  local connect_state_info = CSM.current_state_info()
  local time_limit_info = CTM.current_state_info()
  time_limit_info = parse_time_limit_state_info(time_limit_info, true)
  return connect_state_info, time_limit_info
end

function M.current_connect_state()
  do return end
  return CSM.current_connect_state, nil
end

function M.on_connect_error(err_type, err_code, _err_msg)
  E.LOG.warn(TAG, "on_connect_error err_type:" .. tostring(err_type) .. ", errcode:" .. tostring(err_code) .. ", err_msg:" .. tostring(_err_msg))
  CSM.on_connect_error(err_type, err_code)
end

function M.close_cloud_game_view(params, cb)
  E.LOG.debug(TAG, "close cloud game view begin")
  CSM.close_cloud_game_view(params, cb)
end

function M.notify_total_time_end(_limit_state_obj)
  _fsm_enqueue_event(_EVENTS.ON_LIMIT_TIME_CHANGED_TO_END, _limit_state_obj)
end

function M.check_cloud_available(cb)
  local function do_check_fun()
    E.LOG.debug(TAG, "connect_remote begin")
    
    _fsm_enqueue_event(_EVENTS.CHECK_CLOUD_AVAILABLE, cb)
  end
  
  if not is_inited then
    M.init({}, function(succ, ...)
      if succ then
        do_check_fun()
      elseif cb then
        cb(false, ...)
      end
    end)
  else
    do_check_fun()
  end
end

return M
