local instant_text = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_text_instant")
local E = require("ejoysdk_lua.ejoysdk")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local ELU = require("ejoysdk_lua.lang.util")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local CloudUI = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_content_interface")
local EM = require("ejoysdk_lua.ejoysdk_module")
local UI_NAME = "INSTANT"
local M = CloudUI:Inherit(UI_NAME)
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_content_instant"

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
  local message
  if cloud_adapter.is_mobile_network() then
    message = ELU.getString(instant_text.FlashScreen.text_mobile)
  else
    message = ELU.getString(instant_text.FlashScreen.text_wifi)
  end
  E.Toast.show(message, {modal = true})
end

function M.get_mobile_network_tips(type, is_ab_test_for_btn_one)
  local btn
  if is_ab_test_for_btn_one then
    CSTAT.stat_action("network_switch_page_btn", "btn_one", true)
    btn = {
      ELU.getString(instant_text.NetworkSwitch.btn_one[1])
    }
  else
    CSTAT.stat_action("network_switch_page_btn", "btn_two", false)
    btn = {
      ELU.getString(instant_text.NetworkSwitch.btn[1]),
      ELU.getString(instant_text.NetworkSwitch.btn[2])
    }
  end
  local msg = ELU.getString(instant_text.NetworkSwitch.text)
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(index)
      if 0 == index then
        CSTAT.stat_action("network_switch_page_click_continue_button", type)
        download_utils.set_donwload_pause(false)
        CSTAT.stat_action("cloud_pause_download", nil, false)
      else
        CSTAT.stat_action("network_switch_page_click_refused_button", type, true, {})
        cloud_adapter.exit_app()
      end
    end
  }
  return ui_content
end

function M.stop_cloud_game_by_server(notify_install_cb)
  local txt = ELU.getString(instant_text.StopCloudPlayByServer.text)
  local msg = format(txt, cloud_config.CloudGamePlayTimeLimit)
  local btn = {
    ELU.getString(instant_text.StopCloudPlayByServer.btn[1]),
    ELU.getString(instant_text.StopCloudPlayByServer.btn[2])
  }
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(index)
      if 0 == index then
        CSTAT.stat_action("cloud_time_limit_click_exit")
        cloud_adapter.exit_app()
      elseif notify_install_cb then
        notify_install_cb()
      end
    end
  }
  return ui_content
end

function M.network_error(error_type, error_code)
  local txt = ELU.getString(instant_text.NetworkError.text)
  local msg = txt .. format("(%s-%s)", error_type or "", error_code or "")
  local btn = ELU.getString(instant_text.NetworkError.btn[1])
  E.LOG.debug(TAG, "_show_network_error: " .. msg)
  local ui_content = {
    title = "",
    msg = msg,
    btn = {btn},
    modal = true,
    cb = function(_)
      cloud_adapter.cloud_stat_action_upload("network_link_failed_page_click_replay_button")
      cloud_adapter.exit_app()
    end
  }
  return ui_content
end

function M.network_error_retry(error_type, error_code, retry_cb)
  local txt = ELU.getString(instant_text.NetworkErrorRetry.text)
  local msg = txt .. format("(%s-%s)", error_type or "", error_code or "")
  local btn = {
    ELU.getString(instant_text.NetworkErrorRetry.btn[1]),
    ELU.getString(instant_text.NetworkErrorRetry.btn[2])
  }
  E.LOG.debug(TAG, "_show_network_error: " .. msg)
  local ui_content = {
    title = "",
    msg = msg,
    btn = {btn},
    modal = true,
    cb = function(index)
      if 0 == index then
        cloud_adapter.cloud_stat_action_upload("network_link_failed_page_click_replay_button")
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

function M.cloud_error(error_type, error_code, _is_cloud_start_error, param, notify_install_cb)
  local txt = ELU.getString(instant_text.CloudError.text)
  local msg = txt .. format("(%s-%s)", error_type or "", error_code or "")
  local btn = {
    ELU.getString(instant_text.CloudError.btn[1]),
    ELU.getString(instant_text.CloudError.btn[2])
  }
  local ui_content = {
    title = "",
    msg = msg,
    btn = btn,
    modal = true,
    cb = function(index)
      if 0 == index then
        cloud_adapter.cloud_stat_action_fail_upload("cloud_link_failed_page_click_install_button", nil, error_code)
        if notify_install_cb then
          notify_install_cb()
        end
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

return M
