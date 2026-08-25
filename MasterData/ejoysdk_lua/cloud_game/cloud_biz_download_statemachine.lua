local E = require("ejoysdk_lua.ejoysdk")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FSM = UTILS.fsm
local DSM = require("ejoysdk_lua.cloud_game.cloud_download_statemachine")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local BaseFsm = require("ejoysdk_lua.cloud_game.cloud_biz_base_statemachine")
local FSM_NAME = "CloudDownloadBiz"
local TAG = FSM_NAME
local M = BaseFsm:Inherit(FSM_NAME)
M.DOWNLOAD_STRATEGY = DSM.DOWNLOAD_STRATEGYS
M.DOWNLOAD_STATE_INFO_KEY = DSM.STATE_INFO_KEY
M.DOWNLOAD_STATES = DSM.STATES
M.DOWNLOAD_BIZ_INFO_KEY = {STATE = "state"}
M.STATES = {
  IDLE = "idle",
  INITTING = "initting",
  GAME_RES_READY = "game_res_ready",
  QUICK_UPDATING = "quick_updating",
  DOWNLOAD_WITH_PLAY = "download_with_play",
  DOWNLOAD_DISABLE = "download_disable"
}
M.STARTUP_RES_STATE = DSM.STARTUP_RES_STATE
local _EVENTS = {
  INIT = "init",
  INIT_SUCC = "init_succ",
  ON_GAME_RES_READY = "on_game_res_ready",
  DELETE_RES = "delete_res"
}
local _biz_fsm, _cloud_biz_fsm, _cloud_facade, _cloud_manager
local _download_biz_state_change_listeners = {}
local _download_state = {}
local _download_biz_state = {}
local _download_complete_future_time_sec = -1

local function on_cloud_state_changed()
  E.log(_download_state)
  for _, cb in ipairs(_download_biz_state_change_listeners) do
    cb(_download_state, _download_biz_state)
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

local function on_download_state_change_listener(download_state_info)
  _download_state = download_state_info or {}
  on_cloud_state_changed()
  local state = download_state_info[M.DOWNLOAD_STATE_INFO_KEY.KEY_STATE]
  E.LOG.debug(TAG, "on_download_state_change_listener: " .. tostring(state))
  if state == M.DOWNLOAD_STATES.DOWNLOAD_COMPLETE then
    E.LOG.debug(TAG, "on_download_state_change_listener receive download succ")
    _fsm_enqueue_event(_EVENTS.ON_GAME_RES_READY)
  elseif state == M.DOWNLOAD_STATES.DOWNLOADING and _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] == M.STATES.GAME_RES_READY then
    E.LOG.debug(TAG, "receive dsm download state change event and enqueue event delete res  ")
    _fsm_enqueue_event(_EVENTS.DELETE_RES)
  end
end

local function check_startup_gameres_state(res_state, cb)
  if CC.DEBUG_OPTIONS.TestUpdating then
    E.LOG.warn(TAG, "TestUpdating enabled")
    res_state.state = M.STARTUP_RES_STATE.UPDATING
  end
  if res_state.state == M.STARTUP_RES_STATE.DOWNLOADING or res_state.state == M.STARTUP_RES_STATE.UPDATING then
    if res_state.state == M.STARTUP_RES_STATE.DOWNLOADING then
      E.LOG.debug(TAG, "check_startup_gameres_state is incomplete, now play with download begin")
      _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.DOWNLOAD_WITH_PLAY)
      cb(true)
    else
      E.LOG.debug(TAG, "check_startup_gameres_state is updating, before check_cloud_config")
      local request_cloud_config_fun
      
      function request_cloud_config_fun()
        BaseFsm.static_check_cloud_config(function(succ, ...)
          if succ then
            E.LOG.debug(TAG, "check_startup_gameres_state is updating, after check_cloud_config")
            DSM.prepare_game_res_config(function(...)
              E.LOG.debug(TAG, "check_startup_gameres_state is updating, after prepare_game_res_config")
              local _file_list, _total_size, _downloading_size = ...
              E.LOG.debug(TAG, "it updating and need continue download")
              local _remain_size = _total_size - _downloading_size
              local is_update_with_play = _remain_size > CC.UPDATING_WITH_CONNECT_LIMIT
              if is_update_with_play then
                E.LOG.debug(TAG, "check_startup_gameres_state, current updating, and remain size larger than limit, begin play with download")
                local params = {is_update = true}
                _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.DOWNLOAD_WITH_PLAY, params)
              else
                E.LOG.debug(TAG, "check_startup_gameres_state, current updating, and remain size smaller than limit, begin quick updating")
                local params = {remain_size = _remain_size}
                _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.QUICK_UPDATING, params)
              end
              cb(true)
            end)
          else
            local _code, _msg = ...
            
            local function retry_cb()
              request_cloud_config_fun()
            end
            
            BaseFsm.static_show_error_retry_ui(_code, _msg, retry_cb)
          end
        end)
      end
      
      request_cloud_config_fun()
    end
  elseif res_state.state == M.STARTUP_RES_STATE.FINISH then
    E.LOG.debug(TAG, "check_startup_gameres_state is finish, now ready for start game")
    _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.GAME_RES_READY)
    cb(true)
  end
end

local fsm_callbacks = {
  ["on" .. _EVENTS.INIT] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "download biz receive event INIT")
    _fsm_transition_to(M.STATES.IDLE, M.STATES.INITTING)
    local _params, _cb = ...
    if not CC.DisableDownload then
      DSM.init()
      DSM.register_download_state_changed(on_download_state_change_listener)
      DSM.init_game_res({}, function(_success, ...)
        local res_state = (...)
        if _cb then
          _cb(true, res_state)
        end
        check_startup_gameres_state(res_state, function(_succ)
          _fsm_on_async_event_finished(_EVENTS.INIT)
        end)
      end)
      return FSM.ASYNC
    else
      E.LOG.debug(TAG, "init with download disable state")
      if _cb then
        _cb(true)
      end
      _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, M.STATES.DOWNLOAD_DISABLE)
      return FSM.SYNC
    end
  end,
  ["on" .. _EVENTS.INIT_SUCC] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "download biz receive event INIT_SUCC")
    local download_biz_state, params = ...
    E.LOG.debug(TAG, "download biz INIT_SUCC transition to :" .. tostring(download_biz_state))
    _fsm_transition_to(nil, download_biz_state, params)
    return FSM.SYNC
  end,
  ["on" .. _EVENTS.ON_GAME_RES_READY] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event ON_GAME_RES_READY")
    return FSM.SYNC, M.STATES.GAME_RES_READY
  end,
  ["on" .. _EVENTS.DELETE_RES] = function(_f_self, _from, ...)
    E.LOG.debug(TAG, "receive event DELETE_RES")
    return FSM.SYNC, M.STATES.DOWNLOAD_WITH_PLAY
  end,
  ["onenter" .. M.STATES.IDLE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter idle")
    _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] = M.STATES.IDLE
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.INITTING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter initting")
    _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] = M.STATES.INITTING
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.GAME_RES_READY] = function(_fsm, from, ...)
    E.LOG.debug(TAG, "onenter dbs GAME_RES_READY, from >> " .. tostring(from))
    _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] = M.STATES.GAME_RES_READY
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.QUICK_UPDATING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter dbs QUICK_UPDATING")
    _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] = M.STATES.QUICK_UPDATING
    local params = (...)
    local remain_size = params.remain_size
    CSTAT.stat_action("cloud_res_state_update_only_down", tostring(remain_size))
    E.LOG.debug(TAG, "its updating and its a small update, so just download")
    _cloud_facade.open_full_download()
    UI.show_updating()
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.DOWNLOAD_WITH_PLAY] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter dbs DOWNLOAD_WITH_PLAY, _from >> " .. tostring(_from))
    _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] = M.STATES.DOWNLOAD_WITH_PLAY
    if _from ~= M.STATES.GAME_RES_READY then
      _cloud_manager.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE)
      CSTAT.mini_start_begin()
      local params = (...)
      if CC.SelfStart then
        E.LOG.debug(TAG, "its selfstart, now init cloud biz fsm, and wait for it notify notify start download")
        if params and params.is_update then
          E.LOG.debug(TAG, "download res is update, show update ui and start download res")
          _cloud_facade.open_full_download()
          UI.show_updating_as_play(function()
            _cloud_biz_fsm.init()
          end)
        else
          _cloud_biz_fsm.init()
        end
      else
        _cloud_facade.open_full_download()
      end
    end
    on_cloud_state_changed()
  end,
  ["onenter" .. M.STATES.DOWNLOAD_DISABLE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter dbs DOWNLOAD_DISABLE")
    _download_biz_state[M.DOWNLOAD_BIZ_INFO_KEY.STATE] = M.STATES.DOWNLOAD_DISABLE
    on_cloud_state_changed()
  end
}

function M.init(params, cb)
  E.LOG.debug(TAG, "begin init download_biz_fsm")
  _cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
  _cloud_facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  _cloud_biz_fsm = require("ejoysdk_lua.cloud_game.cloud_biz_connect_statemachine")
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
        to = M.STATES.GAME_RES_READY
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.QUICK_UPDATING
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.DOWNLOAD_WITH_PLAY
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.DOWNLOAD_DISABLE
      },
      {
        name = _EVENTS.ON_GAME_RES_READY,
        from = M.STATES.GAME_RES_READY,
        to = M.STATES.GAME_RES_READY
      },
      {
        name = _EVENTS.ON_GAME_RES_READY,
        from = M.STATES.QUICK_UPDATING,
        to = M.STATES.GAME_RES_READY
      },
      {
        name = _EVENTS.ON_GAME_RES_READY,
        from = M.STATES.DOWNLOAD_WITH_PLAY,
        to = M.STATES.GAME_RES_READY
      },
      {
        name = _EVENTS.ON_GAME_RES_READY,
        from = M.STATES.DOWNLOAD_DISABLE,
        to = M.STATES.GAME_RES_READY
      },
      {
        name = _EVENTS.DELETE_RES,
        from = M.STATES.GAME_RES_READY,
        to = M.STATES.DOWNLOAD_WITH_PLAY
      }
    },
    callbacks = fsm_callbacks
  })
  _fsm_enqueue_event(_EVENTS.INIT, params, cb)
end

function M.current_state()
  return _biz_fsm.current
end

function M.current_download_state()
  do return end
  return DSM.current_download_state, nil
end

function M.current_download_state_info()
  do return end
  return DSM.current_download_state_info, nil
end

function M.current_download_biz_state_info()
  return _download_biz_state
end

function M.is_user_confirmed_download_strategy()
  do return end
  return DSM.is_user_confirmed_download_strategy, nil
end

function M.update_download_strategy(download_strategy, user_confirmed_strategy)
  DSM.update_download_strategy(download_strategy, user_confirmed_strategy)
end

function M.start_download()
  E.LOG.debug(TAG, "receive start_download")
  DSM.start_download()
end

function M.open_full_download()
  local current_download_state = DSM.current_download_state()
  DSM.update_download_strategy(M.DOWNLOAD_STRATEGY.DOWNLOAD_FORCE_IN_MOBILE_NETWORK, true)
  E.LOG.debug(TAG, "open_full_download, current download_state:" .. tostring(current_download_state))
  if current_download_state == M.DOWNLOAD_STATES.DOWNLOAD_PAUSED then
    E.LOG.debug(TAG, "open_full_download, begin resume download")
    DSM.resume_download()
  elseif current_download_state ~= M.DOWNLOAD_STATES.DOWNLOADING or current_download_state ~= M.DOWNLOAD_STATES.DOWNLOAD_COMPLETE then
    E.LOG.debug(TAG, "open_full_download, begin start download")
    DSM.start_download()
  end
  CC.force_http_kps_limit(-1)
  local connect_state = _cloud_biz_fsm.current_connect_state()
  CSTAT.stat_action("cloud_open_full_download", connect_state, E.time())
end

function M.is_download_res_init_succ()
  local is_init_succ = DSM.is_init_succ()
  E.LOG.debug(TAG, "is_download_res_init_succ:" .. tostring(is_init_succ))
  return is_init_succ
end

function M.set_download_limit(speed)
  DSM.set_download_limit(speed)
end

function M.on_game_res_ready()
  E.LOG.debug(TAG, "on_game_res_ready received")
  _fsm_enqueue_event(_EVENTS.ON_GAME_RES_READY)
end

function M.register_download_biz_state_change_listener(cb)
  for _, handler in ipairs(_download_biz_state_change_listeners) do
    if handler == cb then
      return
    end
  end
  _download_biz_state_change_listeners[#_download_biz_state_change_listeners + 1] = cb
  E.LOG.debug(TAG, "register_download_biz_state_change_listener succ")
end

function M.unregister_download_biz_state_change_listener(cb)
  local new = {}
  for _, handler in ipairs(_download_biz_state_change_listeners) do
    if cb ~= handler then
      new[#new + 1] = handler
    end
  end
  _download_biz_state_change_listeners = new
  E.LOG.debug(TAG, "unregister_download_biz_state_change_listener succ")
end

function M.download_complete_future_time_sec()
  return _download_complete_future_time_sec
end

return M
