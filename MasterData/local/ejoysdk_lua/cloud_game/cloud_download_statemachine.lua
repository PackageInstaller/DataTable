local E = require("ejoysdk_lua.ejoysdk")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FSM = UTILS.fsm
local cloud_download_manager = require("ejoysdk_lua.cloud_game.cloud_download_manager")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local cloud_ui = require("ejoysdk_lua.cloud_game.cloud_ui")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local DST = require("ejoysdk_lua.cloud_game.cloud_download_strategy")
local FREE_FLOW = require("ejoysdk_lua.cloud_game.cloud_free_data_pkg")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local M = {}
local TAG = "cloud_res_statemachine"
M.STATES = {
  IDLE = "idle",
  INITTING = "initting",
  WAITTING_DOWNLOAD = "waitting_download",
  DOWNLOADING = "downloading",
  DOWNLOAD_COMPLETE = "complete",
  DOWNLOAD_PAUSED = "paused",
  DOWNLOAD_DISABLED = "disabled"
}
M.STATE_INFO_KEY = {
  KEY_STATE = "state",
  KEY_TOTAL_SIZE = "total_size",
  KEY_PROGRESS = "progress",
  KEY_SPEED = "speed",
  KEY_DOWNLOADING_SIZE = "downloading_size",
  KEY_REMAIN_SIZE = "remain_size",
  KEY_IS_UPDATING = "is_updating",
  KEY_IS_UPDATE_WITH_PLAY = "is_update_with_play",
  KEY_DOWNLOAD_STRATEGY = "download_strategy"
}
local _EVENTS = {
  INIT = "init",
  INIT_SUCC = "init_succ",
  START_DOWNLOAD = "start_download",
  PAUSE_DOWNLOAD = "pause_download",
  RESUME_DOWNLOAD = "resume_download",
  DOWNLOAD_EVENT_COMPLETE = "download_event_complete",
  DELETE_RES = "delete_res"
}
M.DOWNLOAD_STRATEGYS = DST.DOWNLOAD_STRATEGYS
M.STARTUP_RES_STATE = cloud_download_manager.CLOUD_RES_STATE
local _download_fsm, _cloud_manager, is_show_start_download_tips, is_show_download_with_mobile_tips
local data = {
  product = nil,
  download_time_begin = 0,
  current_state = {
    [M.STATE_INFO_KEY.KEY_STATE] = M.STATES.IDLE,
    [M.STATE_INFO_KEY.KEY_IS_UPDATING] = false,
    [M.STATE_INFO_KEY.KEY_IS_UPDATE_WITH_PLAY] = false,
    [M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = -1,
    [M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = -1,
    [M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = -1,
    [M.STATE_INFO_KEY.KEY_DOWNLOAD_STRATEGY] = M.DOWNLOAD_STRATEGYS.STRATEGY_UNKNOWN
  },
  download_state_change_listener = nil,
  startup_res_state = nil
}

function M.get_current_download_strategy()
  do return end
  return DST.current_strategy, nil
end

local function show_error_retry_ui(err_code, err_msg, retry_fun)
  E.LOG.warn(TAG, "show_error_retry_ui failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
  CSTAT.stat_action_fail("show_error_retry_ui", nil, err_code, err_msg)
  cloud_ui._show_network_error_retry(cloud_ui.ErrorType.NetworkError, err_code, function()
    E.LOG.debug(TAG, "show_error_retry_ui failed and retry")
    retry_fun()
  end)
end

local function _fsm_enqueue_event_at_front(event_name, ...)
  _download_fsm:enqueue_event(event_name, true, ...)
end

local function _fsm_enqueue_event(event_name, ...)
  _download_fsm:enqueue_event(event_name, false, ...)
end

local function _fsm_transition_to(from_state, to_state, ...)
  local fsm = _download_fsm
  from_state = from_state or fsm.current
  E.LOG.debug(TAG, "_fsm_transition_to, from:" .. tostring(from_state) .. ", to_state:" .. tostring(to_state))
  fsm:transition(from_state, to_state, ...)
end

local function _fsm_on_async_event_finished(event_name)
  local fsm = _download_fsm
  fsm:notify_async_finish(event_name)
end

local function notify_state_changed()
  if not data.download_state_change_listener then
    return
  end
  data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOAD_STRATEGY] = DST.current_strategy()
  data.download_state_change_listener(data.current_state)
end

local function update_downloading_info(total_size, downloading_size, progress, speed)
  total_size = total_size or 0
  downloading_size = downloading_size or 0
  progress = progress or 0
  speed = speed or 0
  data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = downloading_size
  data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = total_size
  data.current_state[M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = total_size - downloading_size
  data.current_state[M.STATE_INFO_KEY.KEY_PROGRESS] = progress
  data.current_state[M.STATE_INFO_KEY.KEY_SPEED] = speed
end

local _test_download_finish_begin_time = 0

local function download_progress_handler(progress_info)
  E.LOG.debug(TAG, "receive download progress change >> " .. tostring(progress_info.state) .. ", and current state >> " .. tostring(data.current_state.state))
  if cloud_config.DEBUG_OPTIONS.TestDownloadFinish then
    E.LOG.debug(TAG, "TestDownloadFinish enabled")
    if 0 == _test_download_finish_begin_time then
      _test_download_finish_begin_time = os.time()
    elseif -1 == _test_download_finish_begin_time then
      E.LOG.debug(TAG, "TestDownloadFinish return, for already finished")
      return
    elseif os.time() - _test_download_finish_begin_time > 5 then
      progress_info.state = cloud_download_manager.DOWNLOAD_STATE.COMPLETE
      progress_info.downloading_size = 100
      progress_info.total_size = 100
      _test_download_finish_begin_time = -1
    end
  end
  if progress_info.state == cloud_download_manager.DOWNLOAD_STATE.COMPLETE then
    E.LOG.debug(TAG, "[cloud game] down_assets_ok")
    local params = {
      downloading_size = progress_info.downloading_size,
      total_size = progress_info.total_size
    }
    cloud_ui.set_download_progress(progress_info.downloading_size, progress_info.total_size)
    _fsm_enqueue_event(_EVENTS.DOWNLOAD_EVENT_COMPLETE, params)
  else
    if data.current_state.state == M.STATES.DOWNLOAD_COMPLETE then
      E.LOG.debug(TAG, "enqueue delete res event")
      _fsm_enqueue_event(_EVENTS.DELETE_RES, {})
    end
    update_downloading_info(progress_info.total_size, progress_info.downloading_size, progress_info.progress, progress_info.speed)
    notify_state_changed()
    cloud_ui.set_download_progress(progress_info.downloading_size, progress_info.total_size)
  end
end

local function can_download_in_current_strategy()
  local download_strategy = M.get_current_download_strategy()
  if download_strategy == M.DOWNLOAD_STRATEGYS.STRATEGY_UNKNOWN then
    E.LOG.warn(TAG, "can_download_in_current_strategy, current waitting user confirm")
    return false
  end
  local could_download
  local is_free = FREE_FLOW.get_current_data_pay_type()
  if is_free and is_free == FREE_FLOW.DATA_PAY_TYPE.FREE then
    could_download = true
  elseif download_strategy == M.DOWNLOAD_STRATEGYS.DOWNLOAD_IN_WIFI_ONLY then
    could_download = false
  else
    could_download = true
  end
  E.LOG.debug(TAG, "can_download_in_current_strategy, strategy:" .. tostring(download_strategy) .. ", could_download:" .. tostring(could_download))
  return could_download
end

local function check_downloading_strategy()
  local could_download = can_download_in_current_strategy()
  E.LOG.debug(TAG, "print current download state")
  E.log(data.current_state)
  if could_download then
    E.LOG.debug(TAG, "check_downloading_strategy result: could download")
    _fsm_enqueue_event(_EVENTS.RESUME_DOWNLOAD)
  else
    E.LOG.debug(TAG, "check_downloading_strategy result: could NOT download")
    _fsm_enqueue_event(_EVENTS.PAUSE_DOWNLOAD)
  end
end

local function _network_state_change_listener()
  E.LOG.debug(TAG, "receive network state change >> ")
  check_downloading_strategy()
end

local function pay_type_change_listener()
  E.LOG.debug(TAG, "receive pay type state change >> ")
  check_downloading_strategy()
end

local function check_game_res_update(prepare_cb)
  local retry_prepare
  
  local function prepare_game_res_fun()
    M.prepare_game_res_quietly(function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "prepare_game_newest_resource succ")
        prepare_cb(...)
      else
        E.LOG.warn(TAG, "prepare_game_newest_resource failed, retrying")
        retry_prepare()
      end
    end)
  end
  
  function retry_prepare()
    E.Timer.once(3, function()
      prepare_game_res_fun()
    end)
  end
  
  local retry_remote_cfg_cb
  
  local function request_cloud_config_fun()
    cloud_download_manager.check_game_res_update(function(succ, ...)
      if succ then
        local res_update_info = (...)
        local _total_size = res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE]
        local _downloading_size = res_update_info[RTM.UPDATE_INFO_KEY.DOWNLOADING_SIZE]
        E.LOG.debug(TAG, "check_game_res_update succ, now begin prepare, total_size:" .. tostring(_total_size) .. ", downloading_size:" .. tostring(_downloading_size))
        update_downloading_info(_total_size, _downloading_size)
        prepare_game_res_fun()
      else
        local code, msg = ...
        E.LOG.warn(TAG, "check_game_res_update failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        retry_remote_cfg_cb()
      end
    end)
  end
  
  function retry_remote_cfg_cb()
    E.Timer.once(3, function()
      request_cloud_config_fun()
    end)
  end
  
  E.LOG.debug(TAG, "begin prepare_game_newest_resource")
  request_cloud_config_fun()
end

local function on_network_change()
  E.LOG.debug(TAG, "receive network change callback, check is download and if show mobile tips")
  local is_mobile_network = CA.is_mobile_network()
  if not is_mobile_network then
    E.LOG.debug(TAG, "is not mobile network, do nothing")
    return
  end
  if not is_show_start_download_tips or is_show_download_with_mobile_tips then
    E.LOG.debug(TAG, "download did not start or has show mobile tips, do nothing")
    return
  end
  if is_show_start_download_tips and not is_show_download_with_mobile_tips then
    E.LOG.debug(TAG, "download is started and did not show mobile network tips, show it")
    cloud_ui.show_download_with_mobile_floater_tips()
    is_show_download_with_mobile_tips = true
  end
end

local function do_init(_params, res_check_cb)
  E.LOG.debug(TAG, "start do_init")
  _cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
  data.product = _cloud_manager.get_product()
  local game_assets_downloader = data.product.asset_download
  cloud_download_manager.init(game_assets_downloader)
  E.CONFIG.autoconfig("", cloud_config.ProductId)
  E.LOG.debug(TAG, "check_game_res_state begin")
  
  local function on_init_succ_callback(res_state)
    _fsm_enqueue_event_at_front(_EVENTS.INIT_SUCC, res_state)
    _fsm_on_async_event_finished(_EVENTS.INIT)
    if res_state.state == cloud_download_manager.CLOUD_RES_STATE.FINISH then
      local downloading_size = res_state.downloading_size
      local total_size = res_state.total_size
      E.LOG.debug(TAG, "on_init_succ_callback finished, downloading_size:" .. tostring(downloading_size) .. ", total_size:" .. tostring(total_size))
      cloud_ui.set_download_progress(downloading_size, total_size)
    elseif res_state.state == cloud_download_manager.CLOUD_RES_STATE.DOWNLOADING or res_state.state == cloud_download_manager.CLOUD_RES_STATE.UPDATING then
      local downloading_size = res_state.downloading_size
      local total_size = res_state.total_size
      E.LOG.debug(TAG, "on_init_succ_callback, its downloading or updating, downloading_size:" .. tostring(downloading_size) .. ", total_size:" .. tostring(total_size))
      cloud_ui.set_download_progress(downloading_size, total_size)
    end
  end
  
  local function prepare_game_res_succ_callback(state_obj, ...)
    local _file_list, _total_size, _downloading_size = ...
    E.LOG.debug(TAG, "prepare_game_res_config end:" .. tostring(_total_size) .. ", downloading_size:" .. tostring(_downloading_size))
    local res_state = state_obj or {}
    res_state.total_size = _total_size
    res_state.downloading_size = _downloading_size
    E.log(res_state)
    if cloud_config.DEBUG_OPTIONS.TestInitDownloading then
      res_state.downloading_size = 31
      res_state.total_size = 100
    end
    on_init_succ_callback(res_state)
  end
  
  cloud_download_manager.check_game_res_state(function(state_info)
    local _state = state_info[cloud_download_manager.STATE_INFO_KEY.STATE]
    data.startup_res_state = _state
    CSTAT.stat_action("cloud_res_state", tostring(_state))
    E.LOG.debug(TAG, "check game res state >> " .. _state)
    local res_state = {state = _state}
    if cloud_config.DEBUG_OPTIONS.TestInitDownloadFinish then
      E.LOG.debug(TAG, "TestInitDownloadFinish enabled")
      res_state.state = cloud_download_manager.CLOUD_RES_STATE.FINISH
    elseif cloud_config.DEBUG_OPTIONS.TestInitDownloading then
      E.LOG.debug(TAG, "TestInitDownloading enabled")
      res_state.state = cloud_download_manager.CLOUD_RES_STATE.DOWNLOADING
    end
    if res_check_cb then
      E.LOG.debug(TAG, "check game res state complete, and callback succ")
      res_check_cb(true, res_state)
    end
    if _state == cloud_download_manager.CLOUD_RES_STATE.FINISH then
      local downloading_size = state_info[cloud_download_manager.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] or 0
      res_state.total_size = downloading_size
      res_state.downloading_size = downloading_size
      on_init_succ_callback(res_state)
      cloud_download_manager.register_download_progress_listener(download_progress_handler)
    elseif _state == cloud_download_manager.CLOUD_RES_STATE.DOWNLOADING or _state == cloud_download_manager.CLOUD_RES_STATE.UPDATING then
      cloud_download_manager.register_download_progress_listener(download_progress_handler)
      check_game_res_update(function(...)
        E.LOG.debug(TAG, "prepare_game_newest_resource succ")
        prepare_game_res_succ_callback(res_state, ...)
      end)
    elseif _state == cloud_download_manager.CLOUD_RES_STATE.DISABLE then
      on_init_succ_callback(res_state)
    end
  end)
end

local function on_download_strategy_changed()
  E.LOG.debug(TAG, "on_download_strategy_changed received")
  notify_state_changed()
  check_downloading_strategy()
end

local fsm_callbacks = {
  ["on" .. _EVENTS.INIT] = function(_f_self, from, ...)
    local params, res_check_cb = ...
    
    local function res_check_cb_wrapper(succ, ...)
      res_check_cb(succ, ...)
    end
    
    if from ~= M.STATES.IDLE then
      E.LOG.warn(TAG, "init event always processed by idle state")
      local last_res_state_info = {
        state = data.startup_res_state
      }
      res_check_cb(true, last_res_state_info)
      return FSM.SYNC
    end
    E.LOG.debug(TAG, "begin init event")
    _fsm_transition_to(M.STATES.IDLE, M.STATES.INITTING)
    do_init(params, res_check_cb_wrapper)
    return FSM.ASYNC
  end,
  ["on" .. _EVENTS.INIT_SUCC] = function(_f_self, from, ...)
    if from ~= M.STATES.INITTING then
      E.LOG.warn(TAG, "init succ not from initting state, return")
      return FSM.SYNC
    end
    E.LOG.debug(TAG, "on process event init_succ")
    local params = (...)
    if params.state == cloud_download_manager.CLOUD_RES_STATE.FINISH then
      _fsm_transition_to(M.STATES.INITTING, M.STATES.DOWNLOAD_COMPLETE, params)
    elseif params.state == cloud_download_manager.CLOUD_RES_STATE.DOWNLOADING or params.state == cloud_download_manager.CLOUD_RES_STATE.UPDATING then
      _fsm_transition_to(M.STATES.INITTING, M.STATES.WAITTING_DOWNLOAD, params)
    elseif params.state == cloud_download_manager.CLOUD_RES_STATE.DISABLE then
      _fsm_transition_to(M.STATES.INITTING, M.STATES.DOWNLOAD_DISABLED, params)
    end
    if cloud_config.DEBUG_OPTIONS.TestEnableLuaProfile then
      E.LOG.debug(TAG, "lua profile enabled, init succ, now stop lua profile")
      local profile = require("ejoysdk_lua.cloud_game.debug.profile")
      profile.lua_profile_stop()
    end
    return FSM.SYNC
  end,
  ["on" .. _EVENTS.START_DOWNLOAD] = function(_f_self, from)
    E.LOG.debug(TAG, "start download event received:" .. tostring(from))
    data.download_time_begin = os.time()
    local could_download = can_download_in_current_strategy()
    if could_download then
      cloud_download_manager.start_download()
      local _csm = require("ejoysdk_lua.cloud_game.cloud_state_manager")
      local is_cloud_connected = _csm.is_cloud_connected()
      if not is_show_start_download_tips and is_cloud_connected then
        local is_mobile_net = CA.is_mobile_network()
        if is_mobile_net then
          cloud_ui.show_start_download_tips(false)
          is_show_download_with_mobile_tips = true
        else
          cloud_ui.show_start_download_tips(true)
        end
        ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change)
        is_show_start_download_tips = true
      end
      return FSM.SYNC, M.STATES.DOWNLOADING
    else
      cloud_download_manager.mark_download_state_paused()
      cloud_download_manager.start_download()
      return FSM.SYNC, M.STATES.DOWNLOAD_PAUSED
    end
  end,
  ["on" .. _EVENTS.PAUSE_DOWNLOAD] = function(_f_self, from)
    E.LOG.debug(TAG, "pause download event received")
    if from == M.STATES.DOWNLOAD_PAUSED then
      E.LOG.debug(TAG, "pause_download event, current already paused, skip")
      return FSM.SYNC
    else
      cloud_download_manager.mark_download_state_paused()
      return FSM.SYNC, M.STATES.DOWNLOAD_PAUSED
    end
  end,
  ["on" .. _EVENTS.RESUME_DOWNLOAD] = function(_f_self, from)
    E.LOG.debug(TAG, "resume download event received")
    if from == M.STATES.DOWNLOADING then
      E.LOG.debug(TAG, "resume_download event, current already downloading, skip")
      return FSM.SYNC
    else
      cloud_download_manager.resume_download()
      return FSM.SYNC, M.STATES.DOWNLOADING
    end
  end,
  ["on" .. _EVENTS.DOWNLOAD_EVENT_COMPLETE] = function(_f_self, _from, params)
    local finish_time = os.time()
    local start_time = data.download_time_begin
    E.LOG.debug(TAG, "[cloud game] download_assets finish ,time pass " .. tostring(finish_time - start_time))
    return FSM.SYNC, M.STATES.DOWNLOAD_COMPLETE, params
  end,
  ["on" .. _EVENTS.DELETE_RES] = function(_f_self, _from, params)
    E.LOG.debug(TAG, "[cloud game] download_assets res been deleted")
    return FSM.SYNC, M.STATES.DOWNLOADING, params
  end,
  ["onenter" .. M.STATES.IDLE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter idle state")
    data.current_state.state = M.STATES.IDLE
    data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = -1
    data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = -1
    data.current_state[M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = -1
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.INITTING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter initting state")
    data.current_state.state = M.STATES.INITTING
    data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = -1
    data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = -1
    data.current_state[M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = -1
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.WAITTING_DOWNLOAD] = function(_fsm, _from, ...)
    local params = (...)
    data.current_state[M.STATE_INFO_KEY.KEY_STATE] = M.STATES.WAITTING_DOWNLOAD
    data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = params.total_size
    data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = params.downloading_size
    data.current_state[M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = params.total_size - params.downloading_size
    data.current_state[M.STATE_INFO_KEY.KEY_PROGRESS] = math.floor(params.downloading_size / params.total_size * 100)
    E.LOG.debug(TAG, "subscribe NETWORK_STATE_CHANGE2")
    FREE_FLOW.register_data_pay_type_changed_cb(pay_type_change_listener)
    FREE_FLOW.register_receive_data_pkg_over_cb(pay_type_change_listener)
    local total_size = params.total_size
    local downloading_size = params.downloading_size
    if params.state == cloud_download_manager.CLOUD_RES_STATE.DOWNLOADING then
      data.current_state[M.STATE_INFO_KEY.KEY_IS_UPDATING] = false
    elseif params.state == cloud_download_manager.CLOUD_RES_STATE.UPDATING then
      E.LOG.debug(TAG, "it updating and need continue download")
      data.current_state[M.STATE_INFO_KEY.KEY_IS_UPDATING] = true
      local remain_size = total_size - downloading_size
      local is_update_with_play = remain_size > cloud_config.UPDATING_WITH_CONNECT_LIMIT
      data.current_state[M.STATE_INFO_KEY.KEY_IS_UPDATE_WITH_PLAY] = is_update_with_play
    end
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.DOWNLOADING] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter downloading state, _from >> " .. tostring(_from))
    data.current_state.state = M.STATES.DOWNLOADING
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.DOWNLOAD_COMPLETE] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter download complete state")
    local params = (...)
    data.current_state.state = M.STATES.DOWNLOAD_COMPLETE
    data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = params.total_size
    data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = params.total_size
    data.current_state[M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = 0
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.DOWNLOAD_PAUSED] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter download pause state")
    data.current_state.state = M.STATES.DOWNLOAD_PAUSED
    notify_state_changed()
  end,
  ["onenter" .. M.STATES.DOWNLOAD_DISABLED] = function(_fsm, _from, ...)
    E.LOG.debug(TAG, "onenter download disable state")
    data.current_state.state = M.STATES.DOWNLOAD_DISABLED
    data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] = -1
    data.current_state[M.STATE_INFO_KEY.KEY_DOWNLOADING_SIZE] = -1
    data.current_state[M.STATE_INFO_KEY.KEY_REMAIN_SIZE] = -1
    notify_state_changed()
  end
}

function M.init()
  _download_fsm = FSM.create({
    initial = M.STATES.IDLE,
    events = {
      {
        name = _EVENTS.INIT,
        from = M.STATES.IDLE,
        to = M.STATES.INITTING
      },
      {
        name = _EVENTS.INIT,
        from = M.STATES.INITTING
      },
      {
        name = _EVENTS.INIT,
        from = M.STATES.WAITTING_DOWNLOAD
      },
      {
        name = _EVENTS.INIT,
        from = M.STATES.DOWNLOAD_COMPLETE
      },
      {
        name = _EVENTS.INIT,
        from = M.STATES.DOWNLOADING
      },
      {
        name = _EVENTS.INIT,
        from = M.STATES.DOWNLOAD_DISABLED
      },
      {
        name = _EVENTS.INIT,
        from = M.STATES.DOWNLOAD_PAUSED
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.WAITTING_DOWNLOAD
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.DOWNLOAD_COMPLETE
      },
      {
        name = _EVENTS.INIT_SUCC,
        from = M.STATES.INITTING,
        to = M.STATES.DOWNLOAD_DISABLED
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = M.STATES.IDLE
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = M.STATES.INITTING
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = M.STATES.WAITTING_DOWNLOAD,
        to = M.STATES.DOWNLOADING
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = M.STATES.WAITTING_DOWNLOAD,
        to = M.STATES.DOWNLOAD_PAUSED
      },
      {
        name = _EVENTS.START_DOWNLOAD,
        from = M.STATES.DOWNLOADING,
        to = M.STATES.DOWNLOADING
      },
      {
        name = _EVENTS.PAUSE_DOWNLOAD,
        from = M.STATES.DOWNLOADING,
        to = M.STATES.DOWNLOAD_PAUSED
      },
      {
        name = _EVENTS.PAUSE_DOWNLOAD,
        from = M.STATES.DOWNLOAD_PAUSED,
        to = M.STATES.DOWNLOAD_PAUSED
      },
      {
        name = _EVENTS.RESUME_DOWNLOAD,
        from = M.STATES.DOWNLOAD_PAUSED,
        to = M.STATES.DOWNLOADING
      },
      {
        name = _EVENTS.RESUME_DOWNLOAD,
        from = M.STATES.DOWNLOADING,
        to = M.STATES.DOWNLOADING
      },
      {
        name = _EVENTS.DOWNLOAD_EVENT_COMPLETE,
        from = M.STATES.DOWNLOADING,
        to = M.STATES.DOWNLOAD_COMPLETE
      },
      {
        name = _EVENTS.DELETE_RES,
        from = M.STATES.DOWNLOAD_COMPLETE,
        to = M.STATES.DOWNLOADING
      }
    },
    callbacks = fsm_callbacks
  })
  DST.init()
  DST.register_strategy_changed(on_download_strategy_changed)
end

function M.init_game_res(params, res_check_cb)
  _fsm_enqueue_event(_EVENTS.INIT, params, res_check_cb)
end

function M.start_download()
  E.LOG.debug(TAG, "start_download event received, current state:" .. _download_fsm.current)
  _fsm_enqueue_event(_EVENTS.START_DOWNLOAD)
end

function M.pause_download()
  _fsm_enqueue_event(_EVENTS.PAUSE_DOWNLOAD)
end

function M.resume_download()
  _fsm_enqueue_event(_EVENTS.RESUME_DOWNLOAD)
end

function M.update_download_strategy(strategy, user_confirmed)
  E.LOG.debug(TAG, "update_download_strategy:" .. tostring(strategy) .. ", is_user_confirmed:" .. tostring(user_confirmed))
  DST.update_download_strategy(strategy, user_confirmed)
end

function M.is_user_confirmed_download_strategy()
  do return end
  return DST.is_user_confirmed_strategy, nil
end

function M.current_download_state()
  return data.current_state[M.STATE_INFO_KEY.KEY_STATE]
end

function M.current_download_state_info()
  local _state = data.current_state[M.STATE_INFO_KEY.KEY_STATE]
  local _total_size = data.current_state[M.STATE_INFO_KEY.KEY_TOTAL_SIZE] or 0
  E.LOG.debug(TAG, "current_download_state_info, state:" .. tostring(_state) .. ", total_size:" .. tostring(_total_size))
  if (_state == M.STATES.IDLE or _state == M.STATES.INITTING) and _total_size < 0 then
    local total_size, downloading_size = cloud_download_manager.get_init_res_downloading_size()
    update_downloading_info(total_size, downloading_size)
  end
  local res_state_info = cloud_download_manager.get_res_state()
  if res_state_info and res_state_info[RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] then
    local progress_info = res_state_info[RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO]
    update_downloading_info(progress_info.total_size, progress_info.downloading_size, progress_info.progress, progress_info.speed)
  end
  return data.current_state
end

function M.register_download_state_changed(state_change_listener)
  data.download_state_change_listener = state_change_listener
end

function M.get_init_res_downloading_size()
  do return end
  return cloud_download_manager.get_init_res_downloading_size, nil
end

function M.prepare_game_res_config(cb)
  local prepare_callback
  
  local function retry_cb()
    M.prepare_game_res_quietly(prepare_callback)
  end
  
  cloud_ui.show_update_checking()
  
  function prepare_callback(succ, ...)
    cloud_ui.hide_update_checking()
    if succ then
      cb(...)
    else
      local code, msg = ...
      show_error_retry_ui(code, msg, retry_cb)
    end
  end
  
  M.prepare_game_res_quietly(prepare_callback)
end

function M.prepare_game_res_quietly(prepare_callback)
  E.LOG.debug(TAG, "prepare_game_res_config begin")
  CSTAT.stat_action("cloud_res_state_begin_prepare")
  cloud_download_manager.prepare_game_res_config(function(succ, ...)
    if succ then
      CSTAT.stat_action("cloud_res_state_begin_prepare_succ")
    else
      local code, msg = ...
      CSTAT.stat_action_fail("cloud_res_state_begin_prepare_failed", "", code, msg)
    end
    prepare_callback(succ, ...)
  end)
end

function M.is_init_succ()
  return data.current_state.state ~= M.STATES.INITTING and data.current_state.state ~= M.STATES.IDLE
end

function M.mark_download_finish()
  E.LOG.debug(TAG, "mark_download_finish begin")
  cloud_ui.mark_download_finish()
end

function M.set_download_limit(speed)
  cloud_download_manager.set_download_limit(speed)
end

return M
