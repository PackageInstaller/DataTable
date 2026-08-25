local E = require("ejoysdk_lua.ejoysdk")
local DOWNLOAD_BIZ = require("ejoysdk_lua.cloud_game.cloud_biz_download_statemachine")
local CONNECT_BIZ = require("ejoysdk_lua.cloud_game.cloud_biz_connect_statemachine")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CTM = require("ejoysdk_lua.cloud_game.cloud_time_limit_checker")
local cloud_floater = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_floater")
local download_rules = require("ejoysdk_lua.cloud_game.cloud_download_rules")
local TAG = "CloudDownloadBiz#GameResBiz"
local M = {}
local current_download_biz_state = {}
local current_connect_biz_state = {}
local _cloud_facade
local _download_complete_future_time_sec = -1
local show_floater_threshold = 50
local has_show_floater = false

local function download_enter_game_res_ready(from)
  CTM.stop_poll_time()
  UI.mark_download_finish()
  if from == DOWNLOAD_BIZ.STATES.INITTING then
    E.LOG.debug(TAG, "download complete from initting state, so directly run local game")
    _cloud_facade.start_game_activity(true)
    CSTAT.stat_init_start_local_game()
  elseif from == DOWNLOAD_BIZ.STATES.QUICK_UPDATING then
    E.LOG.debug(TAG, "download complete from quick update")
    UI.hide_single_updating_ui()
    UI.show_update_res_finish()
  elseif from == DOWNLOAD_BIZ.STATES.DOWNLOAD_WITH_PLAY and CONNECT_BIZ.current_connect_state() ~= CONNECT_BIZ.CONNECT_STATE.CONNECTED then
    E.LOG.debug(TAG, "download complete from download with play but current connect state is not connected")
    UI.hide_single_updating_ui()
    UI.show_update_res_finish()
  else
    E.LOG.debug(TAG, "download complete from other then initting state, show download finish ui")
    _download_complete_future_time_sec = os.time() + CC.FinishDownloadContinuePlayTime * 60
    UI.show_download_finish(_download_complete_future_time_sec)
    CSTAT.stat_action("mini_client_progress_100_tips")
  end
end

local function connect_enter_idle(_from)
end

local function notify_total_end(start_local_cb, count_down)
  E.LOG.debug(TAG, "notify total end")
  UI.show_play_time_over(start_local_cb, count_down)
  CSTAT.stat_action("mini_client_limit_time_end")
end

local function notify_show_time_coming(stage)
  E.LOG.debug(TAG, "notify_show_time_coming begin, stage >> " .. tostring(stage))
  if stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING then
    E.LOG.debug(TAG, "show play total time coming on floater")
    cloud_floater.show_try_play_time_coming(5)
    CSTAT.stat_action("mini_client_limit_time1")
  elseif stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2 then
    UI.show_exper_time_coming_2()
    CSTAT.stat_action("mini_client_limit_time2")
  end
end

local function time_limit_state_change(_limit_state_obj)
  local stage = _limit_state_obj[CTM.STATE_INFO_KEY.KEY_STAGE]
  E.LOG.debug(TAG, "on_time_limit_state_change, current stage:" .. tostring(stage))
  if stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
    E.LOG.debug(TAG, "on_time_limit_state_change, time end")
    local count_down = 45
    if CC.DEBUG_OPTIONS.TestTimeLimitComing then
      E.LOG.warn(TAG, "TestTimeLimitComing enable, now make count_down smaller")
      count_down = 5
    end
    local is_notify_time_end = false
    
    local function notify_time_end_event()
      E.LOG.debug(TAG, "receive notify_time_end_event:" .. tostring(is_notify_time_end))
      local EJCSM = require("ejoysdk_lua.cloud_game.cloud_state_manager")
      if EJCSM.is_download_complete() then
        E.LOG.debug(TAG, "download complete, do not go to time end ")
        return
      end
      if not is_notify_time_end then
        is_notify_time_end = true
        _cloud_facade.notify_total_time_end(_limit_state_obj)
      end
    end
    
    notify_total_end(notify_time_end_event, count_down)
    E.Timer.once(count_down, notify_time_end_event)
  elseif stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING or stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2 then
    E.LOG.debug(TAG, "on_time_limit_state_change, total time coming")
    notify_show_time_coming(stage)
  end
  _cloud_facade.update_time_limit_state_info(_limit_state_obj)
end

local function connect_enter_has_time(_from)
  E.LOG.debug(TAG, "connect enter has time >> " .. tostring(_from))
  CTM.register_time_limit_state_changed(time_limit_state_change)
end

local function connect_enter_time_end(_from)
  CA.set_retry_connected_tip("")
  CA.set_cloud_visibility(false)
  CA.set_floater_visibility(false)
  UI.set_is_retry_connecting(false)
  UI.reset_error_ui_state()
  if CC.SelfStart then
    UI.show_download_exper_time_over()
  else
    _cloud_facade.close_cloud_game_view()
  end
end

local function start_download_listener()
  E.LOG.debug(TAG, "start download res")
  local CSM = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  CSM.start_download()
end

local function download_state_info_change(download_state_info)
  E.LOG.debug(TAG, "handle download state info change")
  E.log(download_state_info)
  if not has_show_floater and download_state_info and download_state_info[DOWNLOAD_BIZ.DOWNLOAD_STATE_INFO_KEY.KEY_PROGRESS] then
    local progress = download_state_info[DOWNLOAD_BIZ.DOWNLOAD_STATE_INFO_KEY.KEY_PROGRESS]
    if progress > show_floater_threshold then
      E.LOG.debug(TAG, "download progress >> " .. tostring(show_floater_threshold))
      has_show_floater = cloud_floater.mark_can_show_floater()
    end
  end
end

function M.init()
  _cloud_facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  download_rules.register_start_download_listener(start_download_listener)
end

function M.handle_download_biz_state_change(download_biz_state, download_state_info)
  if download_state_info then
    download_state_info_change(download_state_info)
  end
  local from_state = current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE] or DOWNLOAD_BIZ.STATES.IDLE
  local to_state = download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]
  if from_state == to_state then
    return
  end
  if to_state == DOWNLOAD_BIZ.STATES.GAME_RES_READY then
    download_enter_game_res_ready(from_state)
  end
  current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE] = to_state
end

function M.handle_connect_biz_state_change(connect_biz_state)
  local from_state = current_connect_biz_state[CONNECT_BIZ.CONNECT_BIZ_INFO_KEY.STATE] or CONNECT_BIZ.STATES.IDLE
  local to_state = connect_biz_state[CONNECT_BIZ.CONNECT_BIZ_INFO_KEY.STATE]
  if from_state == to_state then
    return
  end
  if to_state == CONNECT_BIZ.STATES.IDLE then
    connect_enter_idle(from_state)
  elseif to_state == CONNECT_BIZ.STATES.TIME_END then
    connect_enter_time_end(from_state)
  elseif to_state == CONNECT_BIZ.STATES.HAS_TIME then
    connect_enter_has_time(from_state)
  end
  current_connect_biz_state[CONNECT_BIZ.CONNECT_BIZ_INFO_KEY.STATE] = to_state
end

function M.download_complete_future_time_sec()
  return _download_complete_future_time_sec
end

function M.start_game_activity()
  local cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
  cloud_manager.run_local_game()
end

function M.open_full_download()
  DOWNLOAD_BIZ.open_full_download()
end

return M
