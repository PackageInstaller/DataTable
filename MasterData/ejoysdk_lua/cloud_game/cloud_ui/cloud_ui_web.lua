local E = require("ejoysdk_lua.ejoysdk")
local UI = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_normal_web")
local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
local instant_ui = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_instant")
local tips_helper = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_tips_helper")
local state_manager
local M = {}
local INJECTION_PATH = "/android_asset/demo/js/cloud_game/modal.html"
if _ejoysdk.os() == "ios" then
  local paths = _ejoysdk.sysinfo_paths()
  local bundle_path_ios = paths.bundle_path .. "/cloudgame.bundle/"
  INJECTION_PATH = bundle_path_ios .. "cloud_game/modal.html"
end
local TAG = "cloud_ui_web"
local is_instant_mode
M.UIType = {
  UI_SPLASH = "splash",
  UI_CloudCGError = "cloud_cg_error",
  UI_NetworkError = "network_error",
  UI_NetworkErrorRetry = "network_error_retry",
  UI_StorageError = "storage_error",
  UI_DownloadSizeConfirm = "download_size_confirm",
  UI_FinishDownLoad = "finish_download",
  UI_FinishCloudTime = "finish_cloud_time",
  UI_FinishCloudTimeByServer = "finish_cloud_time_by_server",
  UI_InstantInstallGuide = "instant_install_guide",
  UI_AppUpdating = "app_updating",
  UI_MOBILENETWORKTIPS = "mobile_network_tips",
  UI_WEAK_NETWORK_TOAST = "weak_network_toast",
  UI_RES_CHECKING = "checking_game_res",
  UI_FreeExperTimeOver = "free_exper_time_over",
  UI_DownExperTimeOver = "download_exper_time_over",
  UI_ExperTimeComing = "exper_time_coming",
  UI_ExperTimeOver = "exper_time_over",
  UI_MoreExperTimeOver = "more_exper_time_over_with_download_finish",
  UI_StopCloudGameByServer = "stop_cloud_game_by_server",
  UI_ExitConfirm = "exit_confirm",
  UI_OnCGError = "on_cg_error",
  UI_PkgInstallComplete = "pkg_install_complete",
  UI_PkgInstallCompleteWithoutConnect = "pkg_install_complete_without_connect",
  UI_TimeEndWithInstalled = "time_end_with_installed",
  UI_TimeEndWithNotInstalled = "time_end_with_not_installed"
}

local function get_state_manager()
  state_manager = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  return state_manager
end

local function merge_content_data(origin_default_data, target_data)
  if not origin_default_data or next(origin_default_data) == nil then
    return target_data
  end
  for k, v in pairs(target_data) do
    origin_default_data[k] = v
  end
  return origin_default_data
end

local function open_web(ui_content, type, close_cb)
  local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  if not facade.is_cloud_game_visible() then
    E.LOG.debug(TAG, "current cloud state is pause, do not show any view")
    return
  end
  local view_type = ui_content.startupData.type
  if "tips" == view_type then
    tips_helper.show_tips(ui_content)
    return
  end
  local url = ui_content.url
  local data = get_state_manager().get_download_info_for_ui()
  local content_data = merge_content_data(ui_content.startupData.data, data)
  ui_content.startupData.data = content_data
  E.LOG.debug(TAG, "get_download_info_for_ui")
  E.log(data)
  local injection = {
    [INJECTION_PATH] = {
      transparent = true,
      startupData = {
        init_params = {
          dialog_info = ui_content.startupData
        }
      }
    }
  }
  local options = {
    use_fragment = true,
    compactMode = true,
    hide_close_btn = true,
    use_cutout = true,
    disable_backkey_press = true
  }
  local js_callback = ui_content.js_callback
  if ui_content.startupData.priority and ui_content.startupData.priority == "high" then
    EWB.add_webview_priority(url, injection, options, js_callback, close_cb, type)
  else
    EWB.add_webview(url, injection, options, js_callback, close_cb, type)
  end
end

local function close_web(type)
  EWB.close_view(type)
end

function M.show_free_exper_time_over(download_cb)
  local ui_content = UI.get_free_exper_time_over(download_cb)
  open_web(ui_content, M.UIType.UI_FreeExperTimeOver)
end

function M.show_download_exper_time_over()
  local state = get_state_manager().get_cloud_state_info()
  local download_state = state.download_state.state
  local ui_content
  if "complete" == download_state then
    ui_content = UI.get_down_finish_with_no_exp_time()
    open_web(ui_content, M.UIType.UI_DownExperTimeOver)
  else
    ui_content = UI.get_exp_time_over_with_download_unfinish()
    open_web(ui_content, M.UIType.UI_DownExperTimeOver)
  end
end

function M.show_flash_screen(download_cb, need_user_confirm)
  local ui_content = UI.get_flash_screen(download_cb, need_user_confirm)
  E.log("show splash screen-1")
  E.log(ui_content)
  open_web(ui_content, M.UIType.UI_SPLASH)
end

function M.hide_flash_screen()
  close_web(M.UIType.UI_SPLASH)
end

function M.show_storage_error(retry_cb)
  local ui_content = UI.get_storage_error(retry_cb)
  open_web(ui_content, M.UIType.UI_StorageError)
end

function M.show_exper_time_coming()
  local ui_content = UI.get_exper_time_coming()
  open_web(ui_content, M.UIType.UI_ExperTimeComing)
end

function M.show_exper_time_coming_2()
  local ui_content = UI.get_exper_time_coming_2()
  open_web(ui_content)
end

function M.show_updating_as_download_ui(exit_cb, connect_remote_cb)
  local ui_content = UI.get_resource_update_tips_2(exit_cb, connect_remote_cb)
  open_web(ui_content, M.UIType.UI_AppUpdating)
end

function M.hide_single_updating_ui()
  close_web(M.UIType.UI_AppUpdating)
end

function M.show_single_updating_ui(exit_cb)
  local ui_content = UI.get_resource_update_tips_1(exit_cb)
  open_web(ui_content, M.UIType.UI_AppUpdating)
end

function M.show_mobile_network_tips(type, is_ab_test_for_btn_one, confirm_cb)
  local ui_content = UI.get_mobile_network_tips(type, is_ab_test_for_btn_one, confirm_cb)
  open_web(ui_content, M.UIType.UI_MOBILENETWORKTIPS)
end

function M.hide_mobile_network_tips()
  close_web(M.UIType.UI_MOBILENETWORKTIPS)
end

function M.show_weak_network_toast()
  E.LOG.debug(TAG, "show_weak_network_toast begin")
  local ui_content = UI.get_weak_network_toast_content()
  open_web(ui_content, M.UIType.UI_WEAK_NETWORK_TOAST)
end

function M.hide_weak_network_toast()
  E.LOG.debug(TAG, "hide_weak_network_toast begin")
  close_web(M.UIType.UI_WEAK_NETWORK_TOAST)
end

function M.show_update_checking()
  E.LOG.debug(TAG, "show_update_checking begin")
  local ui_content = UI.get_game_res_checking_ui()
  open_web(ui_content, M.UIType.UI_RES_CHECKING)
end

function M.hide_upate_checking()
  E.LOG.debug(TAG, "hide_upate_checking begin")
  close_web(M.UIType.UI_RES_CHECKING)
end

function M.show_download_finish(had_cg_error, connect_with_remote_enabled)
  local ui_content = UI.get_download_finish(had_cg_error, connect_with_remote_enabled)
  open_web(ui_content, M.UIType.UI_FinishDownLoad)
end

function M.show_cloud_error(error_type, error_code, is_cloud_start_error, param, _notify_install_cb)
  local ui_content = UI.get_cloud_error(error_type, error_code, is_cloud_start_error, param)
  open_web(ui_content, M.UIType.UI_CloudCGError)
end

function M.show_cloud_error_without_download(error_type, error_code, is_cloud_start_error, download_cb)
  local ui_content = UI.get_cloud_error_without_download(error_type, error_code, download_cb, is_cloud_start_error)
  open_web(ui_content, M.UIType.UI_CloudCGError)
end

function M.show_cloud_error_with_pkg_installed(start_local_cb)
  local ui_content = UI.get_cloud_error_with_pkg_installed(start_local_cb)
  open_web(ui_content, M.UIType.UI_CloudCGError)
end

function M.show_cloud_error_with_reason(error_type, error_code, is_network_available, retry_cb)
  local ui_content = UI.get_cloud_error_with_reason(error_type, error_code, is_network_available, retry_cb)
  open_web(ui_content, M.UIType.UI_CloudCGError)
end

function M.show_stop_cloud_game_with_finish_download()
  local ui_content = UI.get_more_exper_time_over_with_download_finish()
  open_web(ui_content, M.UIType.UI_MoreExperTimeOver)
end

function M.show_stop_cloud_game_by_server()
  local ui_content = UI.get_exper_time_over()
  open_web(ui_content, M.UIType.UI_ExperTimeOver)
end

function M.show_stop_cloud_game_by_server_and_download_finish()
  local ui_content = UI.get_exp_over_and_download_finish()
  open_web(ui_content, M.UIType.UI_StopCloudGameByServer)
end

function M.show_network_error(error_type, error_code)
  local ui_content = UI.get_network_error(error_type, error_code)
  open_web(ui_content, M.UIType.UI_NetworkError)
end

function M.hide_network_error()
  EWB.close_view(M.UIType.UI_NetworkError)
end

function M.show_exit_confirm(download_finish, cb)
  local ui_content = UI.get_exit_confirm(download_finish, cb)
  open_web(ui_content, M.UIType.UI_ExitConfirm)
end

function M.show_pkg_install_complete(try_play_cb, run_local_cb)
  local ui_content = UI.get_pkg_install_complete(try_play_cb, run_local_cb)
  open_web(ui_content, M.UIType.UI_PkgInstallComplete)
end

function M.show_pkg_install_complete_without_connect(run_local_cb)
  local ui_content = UI.get_pkg_install_complete_without_connect(run_local_cb)
  open_web(ui_content, M.UIType.UI_PkgInstallCompleteWithoutConnect)
end

function M.show_time_end_with_installed(run_local_cb)
  local ui_content = UI.get_time_end_with_installed(run_local_cb)
  open_web(ui_content, M.UIType.UI_TimeEndWithInstalled)
end

function M.show_time_end_with_not_installed(install_cb)
  local ui_content = UI.get_time_end_with_not_installed(install_cb)
  open_web(ui_content, M.UIType.UI_TimeEndWithNotInstalled)
end

function M.show_on_cg_error(retry_cb, is_kick_out, code, msg)
  local ui_content = UI.get_on_cg_error(retry_cb, is_kick_out, code, msg)
  open_web(ui_content, M.UIType.UI_OnCGError)
end

function M.show_network_error_retry(error_type, error_code, retry_cb)
  local ui_content = UI.get_network_error_retry(error_type, error_code, retry_cb)
  open_web(ui_content, M.UIType.UI_NetworkErrorRetry)
end

function M.show_download_complete(start_local_cb)
  local ui_content = UI.get_download_complete(start_local_cb)
  open_web(ui_content)
end

function M.show_play_time_over(start_local_cb, count_down)
  local ui_content = UI.get_play_over(start_local_cb, count_down)
  open_web(ui_content)
end

function M.show_play_time_over_with_download_finish(start_local_cb, count_down)
  local ui_content = UI.get_play_over_with_download_finish(start_local_cb, count_down)
  open_web(ui_content)
end

function M.show_network_quality_low()
  local ui_content = UI.get_network_quality_low()
  open_web(ui_content)
end

function M.show_close_bluetooth_tips()
  local ui_content = UI.get_close_bluetooth_tips()
  open_web(ui_content)
end

function M.show_not_wifi_remain()
  local ui_content = UI.get_not_wifi_remain()
  open_web(ui_content)
end

function M.show_free_cg_tips()
  local ui_content = UI.get_free_cg_tips()
  open_web(ui_content)
end

function M.show_connect_fail_tips()
  local ui_content = UI.get_connect_fail_tips()
  open_web(ui_content)
end

function M.show_pkg_installed_tips(run_local_cb)
  local ui_content = UI.get_pkg_installed_tips(run_local_cb)
  open_web(ui_content)
end

function M.show_time_coming_with_installed_tips(install_cb)
  local ui_content = UI.get_time_coming_with_installed_tips(install_cb)
  open_web(ui_content)
end

function M.show_time_coming_with_not_installed_tips(run_local_cb)
  local ui_content = UI.get_time_coming_with_not_installed_tips(run_local_cb)
  open_web(ui_content)
end

function M.show_start_download_tips(is_wifi)
  local ui_content = UI.get_start_download_tips(is_wifi)
  open_web(ui_content)
end

function M.hide_cg_error()
  EWB.close_view(M.UIType.UI_CloudCGError)
end

function M.set_instant_mode()
  is_instant_mode = "instant"
  UI = instant_ui
end

function M.is_instant_mode()
  return "instant" == is_instant_mode
end

function M.hide_all_ui()
  E.LOG.debug(TAG, "hide all ui ")
  tips_helper.hide_all_tips()
  EWB.hide_all_web()
end

return M
