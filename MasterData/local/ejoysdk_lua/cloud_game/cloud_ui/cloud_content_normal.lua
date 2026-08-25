local cloud_text = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_text_normal")
local E = require("ejoysdk_lua.ejoysdk")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local ELU = require("ejoysdk_lua.lang.util")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CloudUI = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_interface")
local UI_NAME = "NORMAL"
local M = CloudUI:Inherit(UI_NAME)
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_content_normal"
local data = {total_download_size = 0, downloading_size = 0}

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

function M.show_flash_screen()
  local total_str, down_str = M._get_size_show(data.total_download_size, data.downloading_size)
  local message
  if cloud_adapter.is_mobile_network() then
    if data.downloading_size > 0 then
      message = format(ELU.getString(cloud_text.FlashScreen.text_mobile_ex1), total_str, down_str)
    else
      message = format(ELU.getString(cloud_text.FlashScreen.text_mobile), total_str)
    end
  elseif data.downloading_size > 0 then
    message = format(ELU.getString(cloud_text.FlashScreen.text_wifi_ex1), total_str, down_str)
  else
    message = format(ELU.getString(cloud_text.FlashScreen.text_wifi), total_str, down_str)
  end
  E.Toast.show(message, {modal = true})
end

function M.get_storage_error(retry_cb)
  local total_str = M._get_size_show(data.total_download_size - (data.downloading_size or 0))
  local txt = ELU.getString(cloud_text.OutOfDiskSpace.text)
  local msg = format(txt, total_str)
  local btn = ELU.getString(cloud_text.OutOfDiskSpace.btn[1])
  local ui_content = {
    title = "",
    msg = msg,
    btn = {btn},
    modal = true,
    cb = function(_)
      cloud_adapter.cloud_stat_action("storage_not_enough_page_click_replay_button")
      retry_cb()
    end
  }
  return ui_content
end

function M.get_updating_as_download_ui(exit_cb, connect_remote_cb)
  local total_str, down_str = M._get_size_show(data.total_download_size, data.downloading_size)
  E.LOG.debug(TAG, "get_updating_as_download_ui, total_str:" .. tostring(total_str) .. ", down_str:" .. tostring(down_str))
  local message
  if data.downloading_size > 0 then
    message = format(ELU.getString(cloud_text.CloudUpdating.text), total_str, down_str)
  else
    message = format(ELU.getString(cloud_text.CloudUpdating.text_ext1), total_str)
  end
  local _btns = {
    ELU.getString(cloud_text.CloudUpdating.btn[1]),
    ELU.getString(cloud_text.CloudUpdating.btn[2])
  }
  local ui_content = {
    title = "",
    msg = message,
    btn = _btns,
    modal = true,
    cb = function(index)
      if 0 == index then
        exit_cb()
      else
        connect_remote_cb()
      end
    end
  }
  return ui_content
end

function M.get_single_updating_ui(exit_cb)
  local total_str, down_str = M._get_size_show(data.total_download_size, data.downloading_size)
  local message
  if data.downloading_size > 0 then
    message = format(ELU.getString(cloud_text.CloudUpdating.text), total_str, down_str)
  else
    message = format(ELU.getString(cloud_text.CloudUpdating.text_ext1), total_str)
  end
  local _btns = {
    ELU.getString(cloud_text.CloudUpdating.btn[1])
  }
  local ui_content = {
    title = "",
    msg = message,
    btn = _btns,
    modal = true,
    cb = function(_index)
      exit_cb()
    end
  }
  return ui_content
end

function M.get_mobile_network_tips(type, is_ab_test_for_btn_one)
  local total_str = M._get_size_show(data.total_download_size - (data.downloading_size or 0))
  local btn
  local ab_stat_params = {is_priority_high = true}
  if is_ab_test_for_btn_one then
    cloud_adapter.cloud_stat_action("network_switch_page_btn", "btn_one", true, ab_stat_params)
    btn = {
      ELU.getString(cloud_text.NetworkSwitch.btn_one[1])
    }
  else
    cloud_adapter.cloud_stat_action("network_switch_page_btn", "btn_two", false, ab_stat_params)
    btn = {
      ELU.getString(cloud_text.NetworkSwitch.btn[1]),
      ELU.getString(cloud_text.NetworkSwitch.btn[2])
    }
  end
  local msg = format(ELU.getString(cloud_text.NetworkSwitch.text), total_str)
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(index)
      if 0 == index then
        cloud_adapter.cloud_stat_action("network_switch_page_click_continue_button", type)
        download_utils.set_donwload_pause(false)
        cloud_adapter.cloud_stat_action("cloud_pause_download", nil, false)
      else
        CSTAT.stat_action("network_switch_page_click_refused_button", type, true, {})
        cloud_adapter.exit_app()
      end
    end
  }
  return ui_content
end

function M.get_download_finish(had_cg_error, connect_with_remote_enabled)
  local msg = ELU.getString(cloud_text.FinishAssetsDownload.text)
  local btn = cloud_text.FinishAssetsDownload.btn
  local ui_content
  if had_cg_error or not connect_with_remote_enabled then
    ui_content = {
      title = "",
      msg = msg,
      btn = {
        ELU.getString(btn[2])
      },
      modal = true,
      cb = function(_)
        cloud_adapter.cloud_stat_action("download_complete_page_click_reload_button")
        cloud_adapter.run_local_game()
      end
    }
  else
    ui_content = {
      title = "",
      msg = msg,
      btn = {
        format(ELU.getString(btn[1]), cloud_config.FinishDownloadContinuePlayTime),
        ELU.getString(btn[2])
      },
      modal = true,
      cb = function(index)
        if 1 == index or data.had_cg_error then
          cloud_adapter.cloud_stat_action("download_complete_page_click_reload_button")
          cloud_adapter.run_local_game()
        else
          cloud_adapter.cloud_stat_action("download_complete_page_click_continue_button")
        end
      end
    }
  end
  return ui_content
end

function M.stop_cloud_game_with_finish_download()
  local txt = ELU.getString(cloud_text.CloudPlayTimeoutWhenFinishDown.text)
  local msg = format(txt, cloud_config.FinishDownloadContinuePlayTime)
  local btn = ELU.getString(cloud_text.CloudPlayTimeoutWhenFinishDown.btn[1])
  local ui_content = {
    title = "",
    msg = msg,
    btn = {btn},
    modal = true,
    cb = function(_)
      cloud_adapter.cloud_stat_action("stop_cloud_game_" .. "download_complete_play_again_timeup_page_click_reload_button")
      cloud_adapter.run_local_game()
    end
  }
  return ui_content
end

function M.stop_cloud_game_by_server_and_download_finish()
  local txt = ELU.getString(cloud_text.StopCloudPlayByServerWhenFinishDownAsset.text)
  local msg = format(txt, cloud_config.CloudGamePlayTimeLimit)
  local btn = ELU.getString(cloud_text.StopCloudPlayByServerWhenFinishDownAsset.btn[1])
  local ui_content = {
    title = "",
    msg = msg,
    btn = {btn},
    modal = true,
    cb = function(_)
      cloud_adapter.cloud_stat_action("stop_cloud_game_" .. "download_complete_play_again_timeup_page_click_reload_button")
      cloud_adapter.run_local_game()
    end
  }
  return ui_content
end

function M.stop_cloud_game_by_server()
  local txt = ELU.getString(cloud_text.StopCloudPlayByServer.text)
  local total_str, down_str = M._get_size_show(data.total_download_size, data.downloading_size)
  E.LOG.debug(TAG, "stop cloud game by server >> " .. tostring(total_str) .. tostring(down_str))
  local msg = format(txt, cloud_config.CloudGamePlayTimeLimit, total_str, down_str)
  local btn = ELU.getString(cloud_text.StopCloudPlayByServer.btn[1])
  local ui_content = {
    title = "",
    msg = msg,
    btn = {btn},
    modal = true,
    cb = function(_)
      CSTAT.stat_action("cloud_time_limit_click_exit")
      cloud_adapter.exit_app()
    end
  }
  return ui_content
end

function M.network_error(error_type, error_code)
  local txt = ELU.getString(cloud_text.NetworkError.text)
  local msg = txt .. format("(%s-%s)", error_type or "", error_code or "")
  local btn = {
    ELU.getString(cloud_text.NetworkError.btn[1])
  }
  E.LOG.debug(TAG, "_show_network_error: " .. tostring(msg))
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(_)
      CSTAT.stat_action("network_link_failed_page_click_replay_button")
      cloud_adapter.exit_app()
    end
  }
  return ui_content
end

function M.network_error_retry(error_type, error_code, retry_cb)
  local txt = ELU.getString(cloud_text.NetworkErrorRetry.text)
  local msg = tostring(txt) .. format("(%s-%s)", error_type or "", error_code or "")
  local btn = {
    ELU.getString(cloud_text.NetworkErrorRetry.btn[1]),
    ELU.getString(cloud_text.NetworkErrorRetry.btn[2])
  }
  E.LOG.debug(TAG, "_show_network_error: " .. tostring(msg))
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(index)
      if 0 == index then
        CSTAT.stat_action("network_link_failed_page_click_replay_button")
        cloud_adapter.exit_app()
      elseif 1 == index then
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_relink_button", nil, error_code)
        if retry_cb then
          retry_cb()
        end
      end
    end
  }
  return ui_content
end

function M.cloud_error(error_type, error_code, is_cloud_start_error, param)
  local total_str, down_str = M._get_size_show(data.total_download_size, data.downloading_size)
  local txt = ELU.getString(cloud_text.CloudError.text)
  local msg = format(txt, total_str, down_str)
  msg = msg .. format("(%s-%s)", error_type or "", error_code or "")
  local btn = {
    ELU.getString(cloud_text.CloudError.btn[1]),
    ELU.getString(cloud_text.CloudError.btn[2])
  }
  local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
  if error_code == CONSTANTS.ClOUD_SDK_ERROR.connect_server_failed then
    msg = ELU.getString(cloud_text.CloudErrorReconnect.text)
    btn = {
      ELU.getString(cloud_text.CloudErrorReconnect.btn[1]),
      ELU.getString(cloud_text.CloudErrorReconnect.btn[2])
    }
    if _ejoysdk.os and _ejoysdk.os() == "ios" then
      btn = {
        ELU.getString(cloud_text.CloudErrorReconnect.btn[2])
      }
    end
  elseif _ejoysdk.os and _ejoysdk.os() == "ios" then
    msg = ELU.getString(cloud_text.CloudErrorWithoutDownloadIOS.text)
    btn = {
      ELU.getString(cloud_text.CloudErrorWithoutDownloadIOS.btn[1])
    }
  end
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(index)
      if _ejoysdk.os and _ejoysdk.os() == "ios" then
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_relink_button", nil, error_code)
        if param then
          param()
        end
      elseif 0 == index then
        if is_cloud_start_error then
          cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_drop_button", nil, error_code)
        else
          cloud_adapter.cloud_stat_action_fail_upload("cloud_cg_failed_page_click_drop_button", nil, error_code)
        end
        cloud_adapter.exit_app()
      elseif 1 == index then
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_relink_button", nil, error_code)
        if param then
          param()
        end
      end
    end
  }
  return ui_content
end

function M.cloud_error_without_download(error_type, error_code, is_cloud_start_error)
  local msg = ELU.getString(cloud_text.CloudErrorWithoutDownload.text)
  local btn = {
    ELU.getString(cloud_text.CloudErrorWithoutDownload.btn[1])
  }
  if cloud_config.DEBUG_OPTIONS.Debug then
    msg = msg .. format("(%s-%s)", error_type or "", error_code or "")
  end
  E.LOG.debug(TAG, "_show_cloud_error: " .. tostring(msg))
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function()
      if is_cloud_start_error then
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_drop_button", nil, error_code)
      else
        cloud_adapter.cloud_stat_action_fail_upload("cloud_cg_failed_page_click_drop_button", nil, error_code)
      end
      cloud_adapter.exit_app()
    end
  }
  return ui_content
end

function M._get_size_show(total_size, downloading_size)
  E.LOG.debug(TAG, "_get_size_show, total_size >> " .. tostring(total_size) .. ", downloading_size" .. tostring(downloading_size))
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

function M.set_download_progress(total_size, downloading_size)
  E.LOG.debug(TAG, "set download progress, total_size >> " .. tostring(total_size) .. ", downloading_size >> " .. tostring(downloading_size))
  data.total_download_size = total_size
  data.downloading_size = downloading_size
end

return M
