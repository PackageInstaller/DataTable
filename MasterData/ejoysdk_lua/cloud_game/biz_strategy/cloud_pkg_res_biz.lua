local E = require("ejoysdk_lua.ejoysdk")
local DOWNLOAD_BIZ = require("ejoysdk_lua.cloud_game.cloud_biz_download_statemachine")
local CONNECT_BIZ = require("ejoysdk_lua.cloud_game.cloud_biz_connect_statemachine")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui")
local CC = require("ejoysdk_lua.cloud_game.cloud_config")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CG = require("ejoysdk_lua.vendors.cloud_game")
local cloud_floater = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_floater")
local CTM = require("ejoysdk_lua.cloud_game.cloud_time_limit_checker")
local download_rules = require("ejoysdk_lua.cloud_game.cloud_download_rules")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local TAG = "CloudDownloadBiz#PkgResBiz"
local M = {}
local current_download_biz_state = {}
local current_connect_biz_state = {}
local _cloud_facade
local _download_complete_future_time_sec = -1
local is_install_page_open = false
local is_time_end_but_not_show_ui = false
local is_install_complete_but_not_show_ui = false

local function run_local_cb()
  CSTAT.stat_init_start_local_game()
  M.start_game_activity()
end

local function install_cb()
  local CSM = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  CSM.start_download()
end

local start_launch_loop = false
local has_show_launch_tip = false

local function has_installed()
  local download_state = current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]
  return download_state == DOWNLOAD_BIZ.STATES.GAME_RES_READY
end

local function has_not_installed()
  local download_state = current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]
  return download_state ~= DOWNLOAD_BIZ.STATES.GAME_RES_READY
end

local function start_launch_installed_pkg_tip_loop()
  if not start_launch_loop then
    local tip_interval = CC.LaunchInstalledPkgTipInterval
    local loop_func
    
    function loop_func()
      E.Timer.once(tip_interval, function()
        if has_installed() then
          if not has_show_launch_tip then
            has_show_launch_tip = true
            E.LOG.debug(TAG, "show launch installed pkg tips first time")
            UI.show_pkg_installed_tips(run_local_cb)
          else
            E.LOG.debug(TAG, "show launch installed pkg floater tips last times")
            cloud_floater.show_pkg_installed(3)
          end
        end
        loop_func()
      end)
    end
    
    loop_func()
    start_launch_loop = true
  end
end

local start_install_loop = false

local function start_show_install_pkg_floater_loop()
  if not start_install_loop then
    local interval = CC.ShowInstallPkgFloaterInterval
    local loop_func
    
    function loop_func()
      E.Timer.once(interval, function()
        if has_not_installed() then
          E.LOG.debug(TAG, "show install pkg tips")
          cloud_floater.show_install_pkg(3)
        end
        loop_func()
      end)
    end
    
    loop_func()
    start_install_loop = true
  end
end

local function show_install_pkg_floater_delay()
  if has_not_installed() then
    E.Timer.once(CC.ShowInstallPkgFloaterDelay, function()
      if has_not_installed() then
        cloud_floater.show_install_pkg(3)
        start_show_install_pkg_floater_loop()
      end
    end)
  end
end

local function download_enter_download_with_play(from)
  CA.refresh_app_download_state(false)
  if from == DOWNLOAD_BIZ.STATES.GAME_RES_READY then
    _ejoysdk.log(TAG .. "#download biz state from ready change to downloading")
    start_show_install_pkg_floater_loop()
    UI.mark_download_not_finish()
  end
end

local function show_install_complete_without_connect()
  UI.show_pkg_install_complete_without_connect(run_local_cb)
end

local function download_enter_game_res_ready(from)
  E.LOG.debug(TAG, "download enter game res ready >> " .. tostring(from))
  CA.refresh_app_download_state(true)
  UI.mark_download_finish()
  if from == DOWNLOAD_BIZ.STATES.INITTING then
    E.LOG.debug(TAG, "download complete from initting state, so directly run local game")
    
    local function try_play_cb()
      CONNECT_BIZ.init({}, function()
        E.LOG.debug(TAG, "start launch installed pkg tip loop")
        start_launch_installed_pkg_tip_loop()
      end)
    end
    
    try_play_cb()
  elseif from == DOWNLOAD_BIZ.STATES.QUICK_UPDATING then
    E.LOG.debug(TAG, "download complete from quick update")
    UI.hide_single_updating_ui()
    if is_install_page_open then
      is_install_complete_but_not_show_ui = true
    else
      UI.show_pkg_install_complete_without_connect(run_local_cb)
    end
  elseif from == DOWNLOAD_BIZ.STATES.DOWNLOAD_WITH_PLAY and CONNECT_BIZ.current_connect_state() ~= CONNECT_BIZ.CONNECT_STATE.CONNECTED then
    E.LOG.debug(TAG, "download complete from download with play but current connect state is not connected")
    UI.hide_single_updating_ui()
    if is_install_page_open then
      is_install_complete_but_not_show_ui = true
    else
      UI.show_pkg_install_complete_without_connect(run_local_cb)
    end
  else
    E.LOG.debug(TAG, "download complete from other then initting state, show download finish ui")
    UI.show_pkg_installed_tips(run_local_cb)
    has_show_launch_tip = true
    start_launch_installed_pkg_tip_loop()
    CSTAT.stat_action("mini_client_progress_100_tips")
  end
end

local function connect_enter_idle(_from)
end

local function notify_show_time_coming(stage)
  E.LOG.debug(TAG, "notify_show_time_coming begin, stage >> " .. tostring(stage))
  if stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING then
    cloud_floater.show_try_play_time_coming(5)
    CSTAT.stat_action("mini_client_limit_time1")
  elseif stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2 then
    local download_state = current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]
    if download_state == DOWNLOAD_BIZ.STATES.GAME_RES_READY then
      UI.show_time_coming_with_installed_tips(run_local_cb)
    else
      UI.show_time_coming_with_not_installed_tips(install_cb)
    end
    CSTAT.stat_action("mini_client_limit_time2")
  end
end

local function time_limit_state_change(_limit_state_obj)
  local stage = _limit_state_obj[CTM.STATE_INFO_KEY.KEY_STAGE]
  E.LOG.debug(TAG, "on_time_limit_state_change, current stage:" .. tostring(stage))
  if stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_END then
    _cloud_facade.notify_total_time_end(_limit_state_obj)
  elseif stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING or stage == CTM.TIME_LIMIT_STAGE.PLAY_TOTAL_TIME_COMING_2 then
    E.LOG.debug(TAG, "on_time_limit_state_change, total time coming")
    notify_show_time_coming(stage)
  end
end

local function on_network_change()
  E.LOG.debug(TAG, "receive network change callback, check is network available")
  if current_connect_biz_state[CONNECT_BIZ.CONNECT_BIZ_INFO_KEY.STATE] == CONNECT_BIZ.STATES.TIME_END then
    E.LOG.debug(TAG, "current connect biz state is time end, do nothing")
    return
  end
  if CA.is_network_available() and CA.is_mobile_network() then
    E.LOG.debug(TAG, "current network is not wifi, show no wifi remain tips-1")
    UI.show_not_wifi_remain()
  end
end

local function show_time_end_ui()
  local download_state = current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]
  E.LOG.debug(TAG, "enter time end and download state >> " .. tostring(download_state))
  if download_state == DOWNLOAD_BIZ.STATES.GAME_RES_READY then
    UI.show_time_end_with_installed(run_local_cb)
  else
    UI.show_time_end_with_not_installed(install_cb)
  end
end

local function connect_enter_has_time(_from)
  E.LOG.debug(TAG, "connect enter has time >> " .. tostring(_from))
  show_install_pkg_floater_delay()
  CTM.register_time_limit_state_changed(time_limit_state_change)
  E.Timer.once(10, function()
    if CA.is_network_available() and CA.is_mobile_network() then
      E.LOG.debug(TAG, "current network is not wifi, show no wifi remain tips")
      UI.show_not_wifi_remain()
    else
      E.LOG.debug(TAG, "is wifi, do not show no wifi remain tips")
    end
  end)
  ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change)
end

local function connect_enter_time_end(_from)
  CA.set_retry_connected_tip("")
  UI.set_is_retry_connecting(false)
  UI.reset_error_ui_state()
  if CC.SelfStart then
    if not is_install_page_open then
      E.LOG.debug(TAG, "install page is not open")
      show_time_end_ui()
    else
      E.LOG.debug(TAG, "install page is open")
      is_time_end_but_not_show_ui = true
    end
  else
    _cloud_facade.close_cloud_game_view()
  end
end

local function start_download_listener()
  E.LOG.debug(TAG, "download package, do not auto start")
end

local function install_page_state_listener(is_open)
  E.LOG.debug(TAG, "receive install page state change >> " .. tostring(is_open) .. ", " .. tostring(is_time_end_but_not_show_ui))
  is_install_page_open = is_open
  if is_install_complete_but_not_show_ui then
    is_install_complete_but_not_show_ui = false
    show_install_complete_without_connect()
    return
  end
  if is_time_end_but_not_show_ui then
    is_time_end_but_not_show_ui = false
    show_time_end_ui()
  end
end

function M.init()
  _cloud_facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  download_rules.register_start_download_listener(start_download_listener)
  CG.set_install_page_state_change_listener(install_page_state_listener)
end

function M.handle_download_biz_state_change(download_biz_state)
  E.LOG.debug(TAG, "handle download biz state change >> " .. tostring(download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]))
  local from_state = current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE] or DOWNLOAD_BIZ.STATES.IDLE
  local to_state = download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE]
  if from_state == to_state then
    return
  end
  if to_state == DOWNLOAD_BIZ.STATES.GAME_RES_READY then
    download_enter_game_res_ready(from_state)
  elseif to_state == DOWNLOAD_BIZ.STATES.DOWNLOAD_WITH_PLAY then
    download_enter_download_with_play(from_state)
  end
  current_download_biz_state[DOWNLOAD_BIZ.DOWNLOAD_BIZ_INFO_KEY.STATE] = to_state
end

function M.handle_connect_biz_state_change(connect_biz_state)
  E.LOG.debug(TAG, "handle connect biz state change >> " .. tostring(connect_biz_state[CONNECT_BIZ.CONNECT_BIZ_INFO_KEY.STATE]))
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
  cloud_manager.start_installed_local_game()
end

function M.open_full_download()
end

return M
