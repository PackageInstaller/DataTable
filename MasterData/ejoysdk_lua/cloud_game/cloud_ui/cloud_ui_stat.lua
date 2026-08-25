local E = require("ejoysdk_lua.ejoysdk")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local TAG = "cloud_ui_state"
local need_show_confirm = false
local _state_manager_instance
local M = {}

local function get_state_manager()
  if not _state_manager_instance then
    _state_manager_instance = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  end
  return _state_manager_instance
end

local function has_remain_time_stat_val()
  local state_info = get_state_manager().get_cloud_state_info()
  local remain_experience_time = state_info.time_limit_state.remain_experience_play_time_min or 0
  E.LOG.debug(TAG, "has_remain_time_stat_val:" .. tostring(remain_experience_time))
  local stat_val_has_remain_time = "0"
  if remain_experience_time > 0 then
    stat_val_has_remain_time = "1"
  end
  return stat_val_has_remain_time
end

function M.set_need_show_confirm(_need_show_confirm)
  need_show_confirm = _need_show_confirm
end

function M.stat_splash_show()
  E.LOG.debug(TAG, "stat_splash_show >>")
  local is_4g = CA.is_mobile_network()
  local stat_has_remain_val = has_remain_time_stat_val()
  if not is_4g then
    local stat_open = "0"
    if need_show_confirm then
      stat_open = "1"
    end
    CSTAT.stat_action("mini_client_wifi_splash_frequency", stat_open)
  else
    CSTAT.stat_action("mini_client_mobilenet_splash_frequency", stat_has_remain_val)
  end
end

function M.stat_click_mobile_try_play()
  CSTAT.stat_action("mini_client_mobilenet_splash_tryplay_button")
end

function M.stat_click_mobile_play_with_download()
  local stat_val = has_remain_time_stat_val()
  CSTAT.stat_action("mini_client_mobilenet_splash_download_button", stat_val)
end

function M.stat_splash_exit()
  local is_4g = CA.is_mobile_network()
  if is_4g then
    local stat_has_remain_val = has_remain_time_stat_val()
    CSTAT.stat_action("mini_client_mobilenet_splash_refuse_button", stat_has_remain_val)
  else
    CSTAT.stat_action("mini_client_wifi_splash_refuse_button")
  end
end

function M.stat_splash_confirm()
  CSTAT.stat_action("mini_client_wifi_splash_agree_button")
end

function M.stat_time_limit_end_coming()
  CSTAT.stat_action("mobilenet_tryplayend_page")
end

function M.stat_show_experience_time_end()
  CSTAT.stat_action("mobilenet_tryplayend_page")
end

function M.stat_experience_time_end_download()
  CSTAT.stat_action("mobilenet_tryplayend_page_download_button")
end

function M.stat_experience_time_end_reject_download()
  CSTAT.stat_action("mobilenet_tryplayend_page_refuse_button")
end

function M.stat_show_total_time_end()
  CSTAT.stat_action("download_status_tryplayend_page")
end

function M.stat_total_time_end_reject_download()
  CSTAT.stat_action("download_status_tryplayend_page_pause_button")
end

function M.stat_splash_tips()
  CSTAT.stat_action("mini_client_splash_tips")
end

function M.click_error_retry()
  CSTAT.stat_action("mini_client_click_error_retry")
end

function M.click_error_exit()
  CSTAT.stat_action("mini_client_click_error_exit")
end

function M.stat_download_popup()
  local params = {}
  params.popupTime = os.time()
  CSTAT.commit_event("sdk.download.popup", params)
end

function M.stat_open_popup()
  local params = {}
  params.popupTime = os.time()
  CSTAT.commit_event("sdk.open.popup", params)
end

function M.stat_download_button_click()
  local params = {}
  params.clickTime = os.time()
  CSTAT.commit_event("sdk.download.button.click", params)
end

M.PAGE_KEY = {
  FLOAT_PANEL = "float_panel",
  TOP_TIPS = "top_tips",
  MODE_DIALOG = "mode_dialog"
}

function M.stat_open_button_click(page)
  local params = {}
  params.clickTime = os.time()
  params.page = page
  CSTAT.commit_event("sdk.open.button.click", params)
end

return M
