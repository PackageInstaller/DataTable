local E = require("ejoysdk_lua.ejoysdk")
local ui_manager = require("ejoysdk_lua.ejoysdk_ui_manager")
local cloud_ui = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_normal")
local instant_ui = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_instant")
local UI = cloud_ui
local is_instant_mode, network_error_tip
local M = {}
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

function M.show_flash_screen()
  UI.show_flash_screen()
end

function M.hide_flash_screen()
  E.Toast.hide()
end

function M.show_storage_error(retry_cb)
  local ui_content = UI.get_storage_error(retry_cb)
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_StorageError,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.NORMAL)
end

function M.show_updating_as_download_ui(exit_cb, connect_remote_cb)
  local ui_content = UI.get_updating_as_download_ui(exit_cb, connect_remote_cb)
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_AppUpdating,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_single_updating_ui(exit_cb)
  local ui_content = UI.get_single_updating_ui(exit_cb)
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_AppUpdating,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_mobile_network_tips(type, is_ab_test_for_btn_one)
  local ui_content = UI.get_mobile_network_tips(type, is_ab_test_for_btn_one)
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_DownloadSizeConfirm,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_download_finish(had_cg_error, connect_with_remote_enabled)
  local ui_content = UI.get_download_finish(had_cg_error, connect_with_remote_enabled)
  local ui_type
  if had_cg_error then
    ui_type = M.UIType.UI_CloudCGError
  else
    ui_type = M.UIType.UI_FinishDownLoad
  end
  local dialog = {
    ui_content = ui_content,
    name = ui_type,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_stop_cloud_game_with_finish_download()
  local ui_content = UI.stop_cloud_game_with_finish_download()
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_FinishCloudTime,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_stop_cloud_game_by_server_and_download_finish()
  local ui_content = UI.stop_cloud_game_by_server_and_download_finish()
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_FinishDownLoad,
    is_cancel = false
  }
  ui_manager.show_dialog(dialog)
end

function M.show_stop_cloud_game_by_server(notify_install_cb)
  local ui_content = UI.stop_cloud_game_by_server(notify_install_cb)
  local dialog = {
    ui_content = ui_content,
    name = M.UIType.UI_FinishCloudTimeByServer,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_network_error(error_type, error_code)
  local ui_type = M.UIType.UI_NetworkError
  network_error_tip = {
    ui_content = UI.network_error(error_type, error_code),
    name = ui_type,
    is_cancel = false
  }
  ui_manager.add_dialog(network_error_tip, ui_manager.UI_PRIORITY.HIGH)
end

function M.hide_network_error()
  if network_error_tip then
    ui_manager.close(network_error_tip.name)
    network_error_tip = nil
  end
end

function M.show_network_error_retry(error_type, error_code, retry_cb)
  local dialog = {
    ui_content = UI.network_error_retry(error_type, error_code, retry_cb),
    name = M.UIType.UI_NetworkError,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.HIGH)
end

function M.show_cloud_error(error_type, error_code, is_cloud_start_error, param, notify_install_cb)
  local dialog = {
    ui_content = UI.cloud_error(error_type, error_code, is_cloud_start_error, param, notify_install_cb),
    name = M.UIType.UI_CloudCGError,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.NORMAL)
end

function M.show_cloud_error_without_download(error_type, error_code, is_cloud_start_error)
  local dialog = {
    ui_content = UI.cloud_error_without_download(error_type, error_code, is_cloud_start_error),
    name = M.UIType.UI_CloudCGError,
    is_cancel = false
  }
  ui_manager.add_dialog(dialog, ui_manager.UI_PRIORITY.NORMAL)
end

function M.close_cg_error()
  ui_manager.close(M.UIType.UI_CloudCGError)
end

function M.set_instant_mode()
  is_instant_mode = "instant"
  UI = instant_ui
end

function M.is_instant_mode()
  return "instant" == is_instant_mode
end

return M
