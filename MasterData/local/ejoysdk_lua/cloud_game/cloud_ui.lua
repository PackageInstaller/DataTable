local E = require("ejoysdk_lua.ejoysdk")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ELU = require("ejoysdk_lua.lang.util")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_ui_web")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UI_STAT = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_ui_stat")
local cloud_floater = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_floater")
local tips_helper = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_tips_helper")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "[cloud game]"
M.State = {
  Empty = 0,
  FlashScreen = 1,
  FlashScreenDismiss = 2,
  BeginDownload = 3,
  FinishDownload = 4
}
M.ErrorType = {
  CloudStartError = 1,
  CloudCGError = 2,
  NetworkError = 3,
  InitSdkError = 4
}
M.UIType = {
  UI_CloudCGError = "cloud_cg_error",
  UI_NetworkError = "network_error",
  UI_StorageError = "storage_error",
  UI_DownloadSizeConfirm = "download_size_confirm",
  UI_FinishDownLoad = "finish_download",
  UI_FinishCloudTime = "finish_cloud_time",
  UI_FinishCloudTimeByServer = "finish_cloud_time_by_server",
  UI_InstantInstallGuide = "instant_install_guide",
  UI_AppUpdating = "app_updating"
}
M.CLOUD_TOPIC = {
  TOPIC_DOWNLOAD_PROGRESS_CHANGED = "cloud_topic_download_progress_changed"
}
local data = {
  last_time_record = os.time(),
  last_stat_time = 0,
  begin_down_time_record = os.time(),
  total_download_size = 0,
  downloading_size = 0,
  cur_state = M.State.Empty,
  had_cg_error = false,
  cached_cg_error = nil,
  is_cancel_download = false,
  on_network_change_cb = nil,
  is_mobile_network_record = false,
  is_cloud_time_limit = false,
  cancel_update_progress = nil,
  is_retry_connecting = false,
  cur_ui = nil,
  mobile_network_tip = false,
  network_error_tip = nil,
  updating_refresh_cancel_callback = nil,
  connect_with_remote_enabled = true,
  last_retrict_show_time = 0
}
local PROGRESS_DOWNLOAD_INFO = E.LazyKeyStore:New("CLOUD_DOWNLOAD_PROGRESS_INFO", false, true, false)
local last_downloading_size = 0
local last_downloading_size_time = 0

local function format(f, ...)
  local ret, msg = pcall(string.format, f, ...)
  if not ret then
    E.LOG.debug(TAG, string.format([[
[cloud game] format error!!!!!!! %s 
%s]], f, msg))
    return f
  end
  return msg
end

local notify_install_cb
M.format = format
local is_switch_to_local = false

local function start_local_game()
  local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  is_switch_to_local = true
  if cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.PACKAGE then
    facade.start_game_activity(true)
  else
    facade.stop_cloud_game(function()
      E.LOG.debug(TAG, "stop cloud game over")
      facade.start_game_activity(true)
    end)
  end
end

function M.add_timer(delay, cb)
  local is_cannel
  E.Timer.once(delay, function()
    if not is_cannel then
      cb()
    end
  end)
  cb()
  return function()
    is_cannel = true
  end
end

function M.add_timer_loop(delay, cb)
  local is_cannel, loop_fun
  
  function loop_fun()
    E.Timer.once(delay, function()
      if not is_cannel then
        cb()
        loop_fun()
      end
    end)
  end
  
  cb()
  loop_fun()
  return function()
    is_cannel = true
  end
end

function M._get_size_show(total_size, downloading_size)
  total_size = total_size * cloud_config.DownloadSizeFix
  local total_str
  local down_str = 0
  if total_size < 1048576 then
    total_str = format("%.3fM", total_size / 1024 / 1024)
  else
    total_str = format("%.1fM", total_size / 1024 / 1024)
  end
  if downloading_size and downloading_size > 0 then
    downloading_size = downloading_size * cloud_config.DownloadSizeFix
    down_str = math.floor(downloading_size / total_size * 100)
  end
  return total_str, down_str
end

function M.show_storage_error(retry_cb)
  CSTAT.stat_action("storage_not_enough_page")
  UI.show_storage_error(retry_cb)
end

function M.show_updating_as_play(connect_remote_cb)
  CSTAT.stat_action("updating_as_play_dialog_show")
  
  local function exit_cb()
    CSTAT.stat_action("updating_as_play_dialog_exit")
    cloud_adapter.exit_app()
  end
  
  local function _connect_remote_cb()
    CSTAT.stat_action("updating_as_play_dialog_connect")
    connect_remote_cb()
  end
  
  UI.show_updating_as_download_ui(exit_cb, _connect_remote_cb)
end

function M.show_updating()
  if data.updating_refresh_cancel_callback then
    E.LOG.debug(TAG, "already showing, return")
    return
  end
  CSTAT.stat_action("updating_dialog_show")
  
  local function exit_cb()
    CSTAT.stat_action("updating_dialog_exit")
    cloud_adapter.exit_app()
  end
  
  data.connect_with_remote_enabled = false
  UI.show_single_updating_ui(exit_cb)
end

function M.hide_single_updating_ui()
  UI.hide_single_updating_ui()
end

function M.show_mobile_network_tip(is_change, user_confirmed_cb)
  if data.cur_state == M.State.FinishDownload then
    return
  end
  local type
  if is_change then
    type = 1
  else
    type = 0
  end
  local is_ab_test_for_btn_one = cloud_config.is_ab_test_switch_on()
  E.LOG.debug(TAG, "show_mobile_network_tip with ab_test_flag:" .. tostring(is_ab_test_for_btn_one))
  cloud_adapter.cloud_stat_action("network_switch_page", type)
  UI.show_mobile_network_tips(type, is_ab_test_for_btn_one, function(is_download)
    user_confirmed_cb(is_download, true)
  end)
end

function M.hide_mobile_network_tips()
  E.LOG.debug(TAG, "begin hide_mobile_network_tips")
  UI.hide_mobile_network_tips()
end

function M.show_flash_screen()
  _ejoysdk.log("start show flash screen")
  UI.show_flash_screen()
end

function M.show_exper_flash_screen(download_cb, need_user_confirm)
  UI.show_flash_screen(function(is_download, is_confirmed)
    if download_cb then
      download_cb(is_download, is_confirmed)
    end
  end, need_user_confirm)
end

function M.hide_flash_screen(hide_time, cb)
  if hide_time > 0 then
    E.Timer.once(hide_time, function()
      UI.hide_flash_screen()
      if cb then
        cb(true)
      end
    end)
  else
    UI.hide_flash_screen()
    if cb then
      cb(true)
    end
  end
end

function M.show_free_exper_time_over(download_cb)
  UI.show_free_exper_time_over(download_cb)
  UI_STAT.stat_show_experience_time_end()
end

function M.show_download_exper_time_over()
  UI.show_download_exper_time_over()
end

function M.mark_download_finish()
  E.LOG.debug(TAG, "[cloud game] mark_download_finish")
  M.set_state(M.State.FinishDownload)
  download_utils.set_finish_down_assets()
end

function M.mark_download_not_finish()
  E.LOG.debug(TAG, "[cloud game] mark_download_not_finish")
  M.set_state(M.State.BeginDownload)
  download_utils.set_not_finish_down_assets()
end

function M.show_update_res_finish()
  E.LOG.debug(TAG, "[cloud game] show update res finish")
  UI.show_download_finish(false)
end

function M.show_download_finish(force_to_local_time)
  CSTAT.stat_action("download_complete_page")
  E.LOG.debug(TAG, "[cloud game] open_change_to_local_dialog")
  M.hide_flash_screen(0)
  M._show_cloud_game_countdown_when_finish_down(force_to_local_time)
end

function M.show_restrict_toast(msg)
  data.last_retrict_show_time = os.time()
  CSTAT.stat_action("restrict_toast_show")
  UI.show_weak_network_toast()
end

function M.hide_restrict_toast()
  local last_time = data.last_retrict_show_time or 0
  local cost_time = 0
  if last_time > 0 then
    cost_time = os.time() - last_time
  end
  CSTAT.stat_action("restrict_toast_hide", tostring(cost_time))
  UI.hide_weak_network_toast()
end

function M.show_update_checking()
  UI.show_update_checking()
end

function M.hide_update_checking()
  UI.hide_upate_checking()
end

function M._show_cloud_game_countdown_when_finish_down(force_to_local_game_time)
  tips_helper.hide_all_tips()
  UI.show_download_complete(function()
    E.LOG.debug(TAG, "open_change_to_local_dialog click start game activity")
    start_local_game()
    CSTAT.stat_cloud_exit("complete_tips")
  end)
  
  local function finish_down_asset()
    cloud_adapter.cloud_stat_action("download_complete_play_again_timeup_page")
    local count_down = 30
    local is_count_down_end = false
    
    local function start_local_fun(is_click)
      if not is_count_down_end then
        is_count_down_end = true
        cloud_adapter.cloud_stat_action("download_complete_play_again_timeup_page_reload")
        local _from = "complete_tips_timeout"
        if is_click then
          _from = "complete_tips"
          CSTAT.stat_action("download_complete_play_again_timeup_page_click_reload")
        end
        local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
        is_switch_to_local = true
        E.LOG.debug(TAG, "stop cloud game and exit cloud game view")
        facade.start_game_activity(true)
        CSTAT.stat_cloud_exit(_from)
      end
    end
    
    local function click_start_fun()
      E.LOG.debug(TAG, "download complete with timeup, user click start")
      start_local_fun(true)
    end
    
    UI.show_play_time_over_with_download_finish(click_start_fun, count_down)
    E.Timer.once(count_down, start_local_fun)
  end
  
  data.force_to_local_game_time = force_to_local_game_time
  local is_show_download_complete_floater_tips = false
  local refresh_time_cb
  
  function refresh_time_cb(wait_time)
    E.Timer.once(wait_time, function()
      if is_switch_to_local then
        return
      end
      if not is_show_download_complete_floater_tips then
        is_show_download_complete_floater_tips = true
        local continue_play_time = cloud_config.FinishDownloadContinuePlayTime
        cloud_floater.show_download_complete(continue_play_time, 5)
      end
      local time_left = math.floor(data.force_to_local_game_time - os.time())
      if time_left < 0 then
        time_left = 0
      end
      if cloud_config.DEBUG_OPTIONS.TestDownloadCompleteAutoSwith then
        E.LOG.warn(TAG, "TestDownloadCompleteAutoSwith enabled")
        time_left = 0
      end
      E.LOG.debug(TAG, "[cloud game] will change to local game " .. tostring(time_left))
      if cloud_config.DEBUG_OPTIONS.TestDownloadFinishForceToLocal then
        E.LOG.debug(TAG, "TestDownloadFinishForceToLocal enabled")
        time_left = 0
      end
      if time_left <= 2 then
        finish_down_asset()
      elseif time_left < wait_time then
        refresh_time_cb(time_left)
      else
        refresh_time_cb(wait_time)
      end
    end)
  end
  
  refresh_time_cb(10)
end

function M.show_stop_cloud_game_by_server()
  E.LOG.debug(TAG, "show_stop_cloud_game_by_server ")
  data.is_cloud_time_limit = true
  M.reset_error_ui_state()
  cloud_config.force_http_kps_limit(-1)
  cloud_adapter.stop_cloud_game()
  
  local function finish_down_asset()
    cloud_adapter.cloud_stat_action("stop_cloud_game_" .. "download_complete_play_again_timeup_page")
    UI.show_stop_cloud_game_by_server_and_download_finish()
    E.Timer.once(30, function()
      cloud_adapter.cloud_stat_action("stop_cloud_game_" .. "download_complete_play_again_timeup_page_auto_reload")
      cloud_adapter.run_local_game()
    end)
  end
  
  local refresh_progress_cb
  
  function refresh_progress_cb(wait_time)
    UI.show_stop_cloud_game_by_server(notify_install_cb)
    E.Timer.once(wait_time, function()
      if data.cur_state == M.State.FinishDownload then
        finish_down_asset()
      else
        refresh_progress_cb(wait_time)
      end
    end)
  end
  
  if data.cur_state == M.State.FinishDownload then
    finish_down_asset()
  else
    refresh_progress_cb(10)
  end
end

function M._show_network_error(error_type, error_code)
  UI.show_network_error(error_type, error_code)
end

function M._hide_network_error()
  UI.hide_network_error()
end

function M._show_network_error_retry(error_type, error_code, retry_cb)
  UI.show_network_error_retry(error_type, error_code, retry_cb)
end

function M.get_download_progress_text()
  local total_str, down_str = M._get_size_show(data.total_download_size, data.downloading_size)
  return total_str, down_str
end

function M._show_cloud_error(error_type, error_code, param)
  M._cancel_updater_progress()
  local show_cnt = 1
  E.LOG.debug(TAG, "_show_cloud_error: cnt=" .. show_cnt)
  local is_cloud_start_error = error_type == M.ErrorType.CloudStartError
  UI.show_cloud_error(error_type, error_code, is_cloud_start_error, param, notify_install_cb)
end

function M.registerNotifyInstallCb(cb)
  notify_install_cb = cb
end

function M._show_cloud_error_without_download(error_type, error_code, download_cb)
  local is_cloud_start_error = error_type == M.ErrorType.CloudStartError
  UI.show_cloud_error_without_download(error_type, error_code, is_cloud_start_error, download_cb)
end

function M._show_error(error_type, error_code, param)
  if data.cur_state == M.State.FinishDownload then
    if cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.PACKAGE then
      UI.show_cloud_error_with_pkg_installed(function()
        local cloud_manager = require("ejoysdk_lua.cloud_game.cloud_manager")
        cloud_manager.start_installed_local_game()
      end)
    end
    return
  end
  local is_network_available = cloud_adapter.is_network_available()
  if not is_network_available then
    CSTAT.stat_action_fail("network_link_failed_page")
    UI.show_cloud_error_with_reason(error_type, error_code, false, param)
  else
    if error_type == M.ErrorType.CloudStartError then
      CSTAT.stat_action_fail("cloud_link_failed_page", nil, error_code)
    else
      CSTAT.stat_action_fail("cloud_cg_failed_page", nil, error_code)
    end
    UI.show_cloud_error_with_reason(error_type, error_code, true, param)
  end
end

function M.set_state(state)
  data.cur_state = state
end

function M.get_state()
  return data.cur_state
end

local function check_download_speed(downloading_size)
  if 0 == last_downloading_size or 0 == last_downloading_size_time then
    last_downloading_size_time = os.time()
    last_downloading_size = downloading_size
    return
  end
  local speed = 0
  local download_size_diff = downloading_size - last_downloading_size
  if download_size_diff > 0 then
    local diff_time = os.time() - last_downloading_size_time
    local diff_time_sec = diff_time
    if diff_time_sec > 0 then
      local download_size_diff_kb = download_size_diff / 1000
      speed = download_size_diff_kb / diff_time_sec
      speed = math.floor(speed)
    end
  end
  return speed
end

local function stat_download_progress(percent_index, downloading_size)
  local last_progress_info = PROGRESS_DOWNLOAD_INFO:get()
  if nil == last_progress_info then
    last_progress_info = {}
    last_progress_info.index = percent_index
    last_progress_info.index_time = os.time()
    last_progress_info.duration_time = 0
  else
    local last_index = last_progress_info.index or 0
    if percent_index ~= last_index then
      last_progress_info.index = percent_index
      local last_duration = last_progress_info.duration_time or 0
      local last_index_time = last_progress_info.index_time or os.time()
      local cur_duration = os.time() - last_index_time + last_duration
      last_progress_info.duration_time = cur_duration
    else
      local last_restart_times = last_progress_info.restart_times or 0
      last_progress_info.restart_times = last_restart_times + 1
      E.LOG.debug(TAG, "stat_download_progress index is same, it should be restart scene")
    end
    last_progress_info.index_time = os.time()
  end
  last_progress_info.speed = check_download_speed(downloading_size)
  local restart_times = last_progress_info.restart_times
  E.LOG.debug(TAG, "stat_download_progress, percent_index:" .. tostring(percent_index) .. ", restart_times:" .. tostring(restart_times) .. ", downloading_size:" .. tostring(downloading_size) .. ", speed:" .. tostring(last_progress_info.speed) .. ", dur:" .. tostring(last_progress_info.duration_time))
  E.LOG.debug(TAG, last_progress_info)
  local stat_params = {
    is_priority_high = true,
    duration = last_progress_info.duration_time,
    speed = last_progress_info.speed,
    restart_times = restart_times
  }
  cloud_adapter.cloud_stat_action("download_progress", percent_index, restart_times, stat_params)
  if 10 == last_progress_info.index then
    E.LOG.debug(TAG, "stat_download_progress download is complete")
    PROGRESS_DOWNLOAD_INFO:set(nil)
  else
    PROGRESS_DOWNLOAD_INFO:set(last_progress_info)
  end
end

function M.set_download_progress(downloading_size, total_size)
  local time = os.time()
  data.total_download_size = total_size or 0
  data.downloading_size = downloading_size or 0
  local percent = 0
  if total_size > 0 then
    percent = math.floor(downloading_size / total_size * 100)
  end
  if time >= data.last_time_record + 3 or percent ~= data.percent then
    E.LOG.debug(TAG, format("[cloud game] set_download_progress 下载=%.2f/%.2f time=%d", downloading_size / 1024 / 1024, total_size / 1024 / 1024, os.time() - data.begin_down_time_record))
    cloud_adapter.set_download_progress(total_size, downloading_size)
    data.percent = percent
    if time >= data.last_stat_time + 30 then
      cloud_adapter.cloud_stat_action("cloud_set_download_progress_percent", tostring(percent))
      data.last_stat_time = time
    end
    data.last_time_record = time
  end
  if downloading_size > 0 then
    local cur_index = math.floor(percent / 10)
    if not data.percent_index then
      stat_download_progress(cur_index, downloading_size)
      data.percent_index = cur_index + 1
    end
    if cur_index >= data.percent_index then
      stat_download_progress(cur_index, downloading_size)
      data.percent_index = cur_index + 1
    end
  end
  ET.publish(M.CLOUD_TOPIC.TOPIC_DOWNLOAD_PROGRESS_CHANGED)
end

function M.set_download_error(error_str)
  E.LOG.debug(TAG, "[cloud game] set_download_error " .. (error_str or "nil"))
end

function M.set_ui_error(error_type, error_code, param)
  M._show_error(error_type, error_code, param)
end

function M.set_is_retry_connecting(is_connecting)
  data.is_retry_connecting = is_connecting
end

function M.get_is_retry_connecting()
  return data.is_retry_connecting
end

function M.show_exper_time_coming()
  UI.show_exper_time_coming()
  UI_STAT.stat_time_limit_end_coming()
end

function M.show_exper_time_coming_2()
  UI.show_exper_time_coming_2()
  UI_STAT.stat_time_limit_end_coming()
end

function M.show_restrict_ui(restrict_state)
  if not restrict_state or next(restrict_state) == nil then
    E.LOG.debug(TAG, "show_restrict_ui skip, restrict_state is empty")
    return
  end
  if nil == restrict_state.msg or restrict_state.msg == "" then
    E.LOG.warn(TAG, "restrict msg is nil, now skip")
    E.log(restrict_state)
    return
  end
  E.LOG.debug(TAG, "show_restrict_ui begin")
  local _total_str, down_str = M.get_download_progress_text()
  local msg
  if not M.is_instant_mode() and _ejoysdk.os() ~= "ios" then
    local content = ELU.getString("cloud_mode_res_download_progress")
    local download_progress_msg = M.format(content, down_str)
    msg = restrict_state.msg .. "\n" .. download_progress_msg
  else
    msg = restrict_state.msg_no_download or restrict_state.msg
  end
  if restrict_state.notify_type == "dialog" then
    M.show_restrict_toast(msg)
  else
    cloud_adapter.show_tips(msg)
  end
end

function M.hide_restrict_ui(_restrict_state)
  M.hide_restrict_toast()
  cloud_adapter.hide_tips()
end

function M.check_and_show_error()
  E.LOG.debug(TAG, "check and show error")
  local cached_error = data.cached_cg_error
  if cached_error then
    E.LOG.debug(TAG, "cached error is not nil, handle it")
    M._show_error(cached_error.error_type, cached_error.error_code, cached_error.param)
    data.cached_cg_error = nil
  end
end

function M._cancel_updater_progress()
  if data.cancel_update_progress then
    data.cancel_update_progress()
    data.cancel_update_progress = nil
  end
end

function M.reconnect()
  M._cancel_updater_progress()
  UI.hide_cg_error()
end

function M.reset_error_ui_state()
  M._cancel_updater_progress()
  UI.hide_cg_error()
  data.cached_cg_error = nil
  data.had_cg_error = false
  cloud_adapter.set_retry_connected_tip("")
end

function M.set_instant_mode()
  UI.set_instant_mode()
end

function M.is_instant_mode()
  do return end
  return UI.is_instant_mode, nil
end

function M.show_network_quality_low()
  UI.show_network_quality_low()
end

function M.show_close_bluetooth_tips()
  UI.show_close_bluetooth_tips()
end

local is_show_not_wifi_tips = false

function M.show_not_wifi_remain()
  if not is_show_not_wifi_tips then
    is_show_not_wifi_tips = true
    UI.show_not_wifi_remain()
  end
end

function M.show_free_cg_tips()
  UI.show_free_cg_tips()
  UI_STAT.stat_splash_tips()
end

function M.show_pkg_installed_tips(run_local_cb)
  UI_STAT.stat_open_popup()
  UI.show_pkg_installed_tips(function()
    UI_STAT.stat_open_button_click(UI_STAT.PAGE_KEY.TOP_TIPS)
    if run_local_cb then
      run_local_cb()
    end
  end)
end

function M.show_time_coming_with_installed_tips(run_local_cb)
  UI_STAT.stat_open_popup()
  UI.show_time_coming_with_installed_tips(function()
    UI_STAT.stat_open_button_click(UI_STAT.PAGE_KEY.TOP_TIPS)
    if run_local_cb then
      run_local_cb()
    end
  end)
end

function M.show_time_coming_with_not_installed_tips(install_cb)
  UI_STAT.stat_download_popup()
  UI.show_time_coming_with_not_installed_tips(function()
    UI_STAT.stat_download_button_click()
    if install_cb then
      install_cb()
    end
  end)
end

function M.show_start_download_tips(is_wifi)
  if cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.PACKAGE then
    E.LOG.debug(TAG, "current download type id package, do not show start download tips")
    return
  end
  E.LOG.debug(TAG, "show start download tips, is_wifi >> " .. tostring(is_wifi))
  UI.show_start_download_tips(is_wifi)
end

function M.show_download_with_mobile_floater_tips()
  cloud_floater.show_download_with_mobile_net(3)
end

function M.show_on_cg_error(retry_cb, is_kick_out, code, msg)
  UI.show_on_cg_error(retry_cb, is_kick_out, code, msg)
end

function M.show_exit_confirm(cb)
  local download_state = M.get_state()
  local download_finish = download_state == M.State.FinishDownload
  if download_finish then
    UI_STAT.stat_open_popup()
  end
  UI.show_exit_confirm(download_finish, function(is_confirmed_exit)
    if download_finish and not is_confirmed_exit then
      UI_STAT.stat_open_button_click(UI_STAT.PAGE_KEY.MODE_DIALOG)
      start_local_game()
    end
    if cb then
      cb(is_confirmed_exit)
    end
  end)
end

function M.show_pkg_install_complete(try_play_cb, run_local_cb)
  UI.show_pkg_install_complete(try_play_cb, run_local_cb)
end

function M.show_pkg_install_complete_without_connect(run_local_cb)
  UI.show_pkg_install_complete_without_connect(run_local_cb)
end

function M.show_time_end_with_installed(run_local_cb)
  UI_STAT.stat_open_popup()
  UI.show_time_end_with_installed(function()
    UI_STAT.stat_open_button_click(UI_STAT.PAGE_KEY.MODE_DIALOG)
    if run_local_cb then
      run_local_cb()
    end
  end)
end

function M.show_time_end_with_not_installed(install_cb)
  UI_STAT.stat_download_popup()
  UI.show_time_end_with_not_installed(function()
    UI_STAT.stat_download_button_click()
    if install_cb then
      install_cb()
    end
  end)
end

function M.show_play_time_over(start_local_cb, count_down)
  UI.show_play_time_over(start_local_cb, count_down)
end

function M.hide_all_ui()
  UI.hide_all_ui()
end

return M
