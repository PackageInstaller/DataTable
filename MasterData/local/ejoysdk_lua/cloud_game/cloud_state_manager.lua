local E = require("ejoysdk_lua.ejoysdk")
local CG = require("ejoysdk_lua.vendors.cloud_game")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local DOWNLOAD_BIZ = require("ejoysdk_lua.cloud_game.cloud_biz_download_statemachine")
local CONNECT_BIZ = require("ejoysdk_lua.cloud_game.cloud_biz_connect_statemachine")
local BIZ_STRATEGY = require("ejoysdk_lua.cloud_game.biz_strategy.cloud_biz_strategy")
local timer_ticker = require("ejoysdk_lua.cloud_game.cloud_time_pass_ticker")
local M = {}
local TAG = "cloud_state_manager"
local DOWNLOAD_STATE_INFO_KEY = DOWNLOAD_BIZ.DOWNLOAD_STATE_INFO_KEY
local CONNECT_STATE_INFO_KEY = CONNECT_BIZ.CONNECT_STATE_INFO_KEY
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
M.STATE_INFO_KEY = {
  DOWNLOAD_STATE = "download_state",
  DOWNLOAD_BIZ_STATE = "download_biz_state",
  CONNECT_STATE = "connect_state",
  TIME_LIMIT_STATE = "time_limit_state"
}
M.CLOUD_GAME_PLAY_MODE = {
  CLOUD_MOBILE_TRY_PLAY = "cloud_mobile_try_play",
  CLOUD_MOBILE_SELF_STARTUP = "cloud_mobile_self_startup",
  CLOUD_REMOTE_PKG = "cloud_remote_pkg",
  NORMAL_GAME = "normal_game"
}
M.TIME_LIMIT_STAGES = CONNECT_BIZ.LIMIT_STAGES
M.CONNECT_STATES = CONNECT_BIZ.CONNECT_STATE
M.CONNECT_PARAMS = CONNECT_BIZ.CONNECT_PARAMS
M.CONNECT_STATE_INFO_KEY = CONNECT_BIZ.CONNECT_STATE_INFO_KEY
M.DOWNLOAD_STATES = DOWNLOAD_BIZ.DOWNLOAD_STATES
M.DOWNLOAD_BIZ_STATES = DOWNLOAD_BIZ.STATES
M.DOWNLOAD_STATE_INFO_KEY = DOWNLOAD_BIZ.DOWNLOAD_STATE_INFO_KEY
M.DOWNLOAD_BIZ_STATE_INFO_KEY = DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY
local current_state_info = {
  download_state = {},
  download_biz_state = {},
  connect_state = {},
  connect_biz_state = {},
  time_limit_state = {}
}
local _cloud_manager
local cloud_state_change_listeners = {}

local function check_static_config_update()
  E.LOG.debug(TAG, "check_static_config_update begin")
  
  local function check_ab_flag()
    local static_config_cache = CA.get_cloud_static_config()
    if static_config_cache and next(static_config_cache) ~= nil then
      local config_data = static_config_cache.config
      local web_txt_cache = config_data and config_data.web_ui_content or nil
      local ab_flag = web_txt_cache and web_txt_cache.ext and web_txt_cache.ext.ab_flag or ""
      E.LOG.debug(TAG, "find ab_flag:" .. tostring(ab_flag))
      local UIM = require("ejoysdk_lua.user_info_manager")
      CC.update_ab_test_flag(ab_flag)
      UIM.set_ab_flag(ab_flag)
    else
      E.LOG.warn(TAG, "check_static_config_update failed, config is empty")
    end
  end
  
  CA.request_cloud_static_config(function(succ, ...)
    E.LOG.debug(TAG, "request_cloud_static_config result:" .. tostring(succ))
    check_ab_flag()
  end)
  check_ab_flag()
end

local function on_cloud_state_changed()
  E.log(current_state_info)
  for _, cb in ipairs(cloud_state_change_listeners) do
    cb(current_state_info)
  end
end

local function dispatch_download_biz_state(download_biz_state, download_state_info)
  BIZ_STRATEGY.dispatch_download_biz_state(download_biz_state, download_state_info)
end

local function dispatch_connect_biz_state(connect_biz_state)
  BIZ_STRATEGY.dispatch_connect_biz_state(connect_biz_state)
end

local function on_connect_state_change_listener(connect_state_info, connect_biz_state_info, time_limit_state_info)
  E.LOG.debug(TAG, "on_connect_state_change_listener >>")
  E.log(connect_state_info)
  current_state_info.connect_state = connect_state_info
  current_state_info.connect_biz_state = connect_biz_state_info
  current_state_info.time_limit_state = time_limit_state_info
  on_cloud_state_changed()
  dispatch_connect_biz_state(connect_biz_state_info)
end

local function on_download_state_change_listener(download_state_info, download_biz_state_info)
  current_state_info.download_state = download_state_info
  current_state_info.download_biz_state = download_biz_state_info
  on_cloud_state_changed()
  local state = download_state_info[M.DOWNLOAD_STATE_INFO_KEY.KEY_STATE]
  E.LOG.debug(TAG, "on_download_state_change_listener: " .. tostring(state))
  dispatch_download_biz_state(download_biz_state_info, download_state_info)
end

function M.init(cb)
  E.LOG.debug(TAG, "======== init begin =========")
  CSTAT.init_begin()
  _cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
  check_static_config_update()
  CONNECT_BIZ.register_conn_biz_state_change_listener(on_connect_state_change_listener)
  DOWNLOAD_BIZ.register_download_biz_state_change_listener(on_download_state_change_listener)
  DOWNLOAD_BIZ.init({}, function()
  end)
  if not CC.DisableDownload then
    E.LOG.debug(TAG, "its not download disable and selfstart, directly init download and wait download connect remote")
    if cb then
      cb(true)
    end
  elseif CC.SelfStart then
    E.LOG.debug(TAG, "its download disable and selfstart, directly connect")
    _cloud_manager.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE)
    CSTAT.mini_start_begin()
    CONNECT_BIZ.connect_remote({}, function()
    end)
    if cb then
      cb(true)
    end
  else
    _cloud_manager.set_mobile_run_mode(CSTAT.MOBILE_RUN_MODE.MODE_NORMAL_GAME)
    E.LOG.debug(TAG, "its download disable and not selfstart, directly return true")
    if cb then
      cb(true)
    end
  end
end

function M.connect_remote(params, cb)
  E.LOG.debug(TAG, "connect_remote received")
  CSTAT.mini_start_begin()
  CONNECT_BIZ.connect_remote(params, function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "connect_with_remote_game failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M.stop_connect_remote(params, cb)
  CONNECT_BIZ.stop_connect_remote(params, function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "stop_connect_remote failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

function M.get_cloud_state_info()
  if CC.DisableDownload then
    current_state_info.download_state = {}
  else
    current_state_info.download_state = DOWNLOAD_BIZ.current_download_state_info()
  end
  current_state_info.download_biz_state = DOWNLOAD_BIZ.current_download_biz_state_info()
  local connect_info, time_limit_info = CONNECT_BIZ.current_state_info()
  current_state_info.connect_state = connect_info
  current_state_info.time_limit_state = time_limit_info
  return current_state_info
end

function M.is_download_complete()
  local download_biz_state = DOWNLOAD_BIZ.current_download_biz_state_info()
  if download_biz_state then
    E.LOG.debug(TAG, "is download state >> " .. tostring(download_biz_state[M.DOWNLOAD_BIZ_STATE_INFO_KEY.STATE]))
    local state = download_biz_state[M.DOWNLOAD_BIZ_STATE_INFO_KEY.STATE]
    return state == M.DOWNLOAD_BIZ_STATES.GAME_RES_READY
  end
  return false
end

function M.on_connect_error(err_type, err_code, _err_msg)
  E.LOG.warn(TAG, "on_connect_error err_type:" .. tostring(err_type) .. ", errcode:" .. tostring(err_code) .. ", err_msg:" .. tostring(_err_msg))
  CONNECT_BIZ.on_connect_error(err_type, err_code)
end

function M.start_download()
  if CC.DisableDownload then
    E.LOG.debug(TAG, "start_download, skip inner download component start")
    return
  end
  E.LOG.debug(TAG, "start_download begin")
  DOWNLOAD_BIZ.start_download()
end

function M.open_full_download()
  E.LOG.debug(TAG, "open_full_download begin")
  BIZ_STRATEGY.open_full_download()
end

local function format_size(byte_size)
  if not byte_size then
    return 0
  end
  do return math.floor end
  return math.floor, byte_size / 1024 / 1024
end

local function format_time(minute)
  if not minute then
    return 0
  end
  do return math.floor end
  return math.floor, minute
end

function M.get_download_info_for_ui()
  E.log("get download info for ui")
  local current_state = M.get_cloud_state_info(true)
  E.log(current_state)
  local recv_bytes = format_size(current_state.download_state[DOWNLOAD_STATE_INFO_KEY.KEY_DOWNLOADING_SIZE]) or 0
  local total_bytes = format_size(current_state.download_state[DOWNLOAD_STATE_INFO_KEY.KEY_TOTAL_SIZE]) or 0
  local remain_size = format_size(current_state.download_state[DOWNLOAD_STATE_INFO_KEY.KEY_REMAIN_SIZE]) or 0
  local download_progress = current_state.download_state[DOWNLOAD_STATE_INFO_KEY.KEY_PROGRESS] or 0
  local download_speed = current_state.download_state[DOWNLOAD_STATE_INFO_KEY.KEY_SPEED] or 0
  local download_state = current_state.download_state[DOWNLOAD_STATE_INFO_KEY.KEY_STATE]
  local connect_state = current_state.connect_state[CONNECT_STATE_INFO_KEY.KEY_STATE]
  download_speed = download_speed / 1024
  local remain_download_time = -1
  local free_exper_min = format_time(current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_EXPERIENCE_PLAY_TOTAL_TIME_MIN])
  local total_exper_min = format_time(current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_PLAY_TOTAL_TIME_MIN])
  local more_exper_min = format_time(current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_DOWNLOAD_COMPLETE_EXPERIENCE_TIME_MIN])
  local remain_free_exper_time = format_time(current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REMAIN_EXPERIENCE_PLAY_TIME_MIN])
  local current_play_time_min = format_time(current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_CURRENT_PLAY_TIME_MIN])
  local refresh_time = current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_REFRESH_TIME_STAMP]
  local next_interval = current_state.time_limit_state[M.TIME_LIMIT_STATE_INFO_KEY.KEY_NEXT_INTERVAL]
  local stub_recv_total_bytes
  if recv_bytes >= 0 then
    stub_recv_total_bytes = recv_bytes .. "M/" .. total_bytes .. "M"
  else
    stub_recv_total_bytes = "正在进行资源检查..."
  end
  local remain_play_time_min = total_exper_min - current_play_time_min
  if remain_play_time_min < 0 then
    remain_play_time_min = 0
  end
  if download_state == M.DOWNLOAD_STATES.DOWNLOAD_COMPLETE and BIZ_STRATEGY.if_need_refresh_remain_time_when_download_complete() then
    local download_complete_future_time_sec = M.download_complete_future_time_sec()
    if download_complete_future_time_sec > 0 then
      remain_play_time_min = download_complete_future_time_sec - os.time()
      if remain_play_time_min < 0 then
        remain_play_time_min = 0
      end
    else
      remain_play_time_min = CC.FinishDownloadContinuePlayTime * 60
    end
  end
  local tick_remain_time = timer_ticker.tick_remain_time(remain_play_time_min, next_interval, refresh_time)
  E.LOG.debug(TAG, "remain_play_time_min-1 >> " .. tostring(remain_play_time_min) .. ", tick_remain_time >> " .. tostring(tick_remain_time))
  return {
    recvBytes = recv_bytes,
    totalBytes = total_bytes,
    remainBytes = remain_size,
    purePlayTotalTimeMin = free_exper_min,
    downloadAsPlayTotalTimeMin = total_exper_min,
    downloadAsPlayTotalTimeMinute = total_exper_min / 60,
    remainTimeTemplete = CC.RemainTimeTemplete,
    downloadCompleteRemainTimeMin = more_exper_min,
    remainPurePlayTimeMin = remain_free_exper_time,
    remainPlayTimeMin = remain_play_time_min,
    resourceType = CC.ResourceType,
    curPlayTimeMin = current_play_time_min,
    downloadProgress = download_progress,
    stubRecvTotalBytes = stub_recv_total_bytes,
    downloadSpeed = download_speed,
    remainDownloadTime = remain_download_time,
    downloadState = download_state,
    connectState = connect_state,
    remainTimeRefreshTimeStamp = refresh_time,
    remainTimeTick = tick_remain_time
  }
end

function M.is_download_res_init_succ()
  do return end
  return DOWNLOAD_BIZ.is_download_res_init_succ, nil
end

function M.register_cloud_state_change_listener(cb)
  for _, handler in ipairs(cloud_state_change_listeners) do
    if handler == cb then
      return
    end
  end
  cloud_state_change_listeners[#cloud_state_change_listeners + 1] = cb
  E.LOG.debug(TAG, "register_download_biz_state_change_listener succ")
end

function M.unregister_cloud_state_change_listener(cb)
  local new = {}
  for _, handler in ipairs(cloud_state_change_listeners) do
    if cb ~= handler then
      new[#new + 1] = handler
    end
  end
  cloud_state_change_listeners = new
  E.LOG.debug(TAG, "unregister_download_biz_state_change_listener succ")
end

function M.get_quality_info()
  local quality_info = CG.get_network_quality() or {}
  local network_type = E.Sysinfo.network_type()
  quality_info.network_type = network_type
  return quality_info
end

function M.change_quality_level(params, cb)
  E.LOG.debug(TAG, "change quality level >> " .. tostring(params.quality_level))
  if params and params.quality_level then
    CG.change_quality_level(params.quality_level, function(succ, current_level)
      E.LOG.debug(TAG, "change quality level result >> " .. tostring(succ))
      if cb then
        cb(succ, current_level)
      end
    end)
  end
end

function M.start_game_activity()
  E.LOG.debug(TAG, "receive js start_game_activity >> ")
  BIZ_STRATEGY.start_game_activity()
end

function M.start_installed_local_game()
  E.LOG.debug(TAG, "start installed local game >> ")
  _cloud_manager.start_installed_local_game()
end

function M.close_cloud_game_view(params, cb)
  CONNECT_BIZ.close_cloud_game_view(params, cb)
end

function M.switch_to_local_game(cb)
  if CC.SelfStart then
    E.LOG.debug(TAG, "switch_to_local_game, its self start, now directly run_local_game")
    M.start_game_activity()
    if cb then
      cb(true)
    end
  else
    E.LOG.debug(TAG, "switch_to_local_game, its not self start, so directly close cloud view")
    M.close_cloud_game_view({}, cb)
  end
end

function M.show_network_state(is_show)
  E.LOG.debug(TAG, "receive js show network state >> ")
  CG.change_native_network_quality_visible(is_show)
end

function M.set_download_limit(speed_kbps)
  if CC.DisableDownload then
    E.LOG.debug(TAG, "set_dowload_limit skip, inner download module is disabled")
    return
  end
  DOWNLOAD_BIZ.set_download_limit(speed_kbps)
end

function M.on_game_res_ready()
  DOWNLOAD_BIZ.on_game_res_ready()
end

function M.is_cloud_connected()
  local connect_info, _ = CONNECT_BIZ.current_state_info()
  if connect_info then
    local connect_state = connect_info[M.CONNECT_STATE_INFO_KEY.KEY_STATE]
    if connect_state and connect_state == M.CONNECT_STATES.CONNECTED then
      return true
    end
  end
  return false
end

function M.check_cloud_available(cb)
  E.LOG.debug(TAG, "check_cloud_available begin")
  CONNECT_BIZ.check_cloud_available(cb)
end

function M.cloud_game_play_mode()
  local cloud_mode = CC.get_cloud_mode()
  local is_cloud_game = cloud_mode == CC.CLOUD_MODE.MOBILE or cloud_mode == CC.CLOUD_MODE.CLOUD
  E.LOG.debug(TAG, "cloud_game_play_mode, is_cloud_game:" .. tostring(is_cloud_game) .. ", selfstart:" .. tostring(CC.SelfStart))
  if is_cloud_game then
    if cloud_mode == CC.CLOUD_MODE.MOBILE then
      if CC.is_self_start() then
        E.LOG.debug(TAG, "cloud_game_play_mode, is cloud_startup")
        return M.CLOUD_GAME_PLAY_MODE.CLOUD_MOBILE_SELF_STARTUP
      else
        E.LOG.debug(TAG, "cloud_game_play_mode, is cloud_tryplay")
        return M.CLOUD_GAME_PLAY_MODE.CLOUD_MOBILE_TRY_PLAY
      end
    else
      E.LOG.debug(TAG, "cloud_game_play_mode, its cloud side")
      return M.CLOUD_GAME_PLAY_MODE.CLOUD_REMOTE_PKG
    end
  else
    E.LOG.debug(TAG, "its normal game")
    return M.CLOUD_GAME_PLAY_MODE.NORMAL_GAME
  end
end

function M.download_complete_future_time_sec()
  local download_complete_future_time = BIZ_STRATEGY.get_biz_strategy().download_complete_future_time_sec()
  E.LOG.debug(TAG, "download_complete_future_time:" .. tostring(download_complete_future_time))
  return download_complete_future_time
end

function M.notify_total_time_end(_limit_state_obj)
  CONNECT_BIZ.notify_total_time_end(_limit_state_obj)
end

function M.update_time_limit_state_info(limit_state_obj)
  CONNECT_BIZ.update_time_limit_state_info(limit_state_obj)
end

return M
