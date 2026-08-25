local E = require("ejoysdk_lua.ejoysdk")
local txt = require("ejoysdk_lua.cloud_game.cloud_ui.cloud_web_text_res")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local CA = require("ejoysdk_lua.cloud_game.cloud_adapter")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local M = {}
local TAG = "cloud_web_content"
local web_ui_txt_cache
M.SCENE = {
  SPLASH_WIFI = "splash_wifi",
  SPLASH_4G_1 = "splash_4g_1",
  SPLASH_4G_2 = "splash_4g_2",
  CLOUD_CONNECT_FAILED = "cloud_connect_failed",
  CLOUD_CONNECT_FAILED_WITH_DOWNLOADING = "cloud_connect_failed_with_downloading",
  CLOUD_CONNECT_FAILED_AND_EXIT = "cloud_connect_failed_and_exit",
  CLOUD_CONNECT_FAILED_WITH_PKG_INSTALLED = "cloud_connect_failed_with_pkg_installed",
  CLOUD_CONNECT_FAILED_WITH_NO_NETWORK = "cloud_connect_failed_with_no_network",
  CLOUD_CONNECT_FAILED_WITH_UNKNOWN_REASON = "cloud_connect_failed_with_unknown_reason",
  MEMORY_SPACE_LOWER_1 = "memory_space_lower_1",
  MEMORY_SPACE_LOWER_2 = "memory_space_lower_2",
  DOWNLOAD_FINISH_1 = "download_finish_1",
  DOWNLOAD_FINISH_2 = "download_finish_2",
  EXPER_TIME_OVER = "exper_time_over",
  EXPER_TIME_OVER_WITH_DOWNLOAD_FINISH = "exper_time_over_with_download_finish",
  MORE_EXPER_OVER = "more_exper_over",
  NETWORK_ERROR = "network_error",
  NETWORK_ERROR_RETRY = "network_error_retry",
  NETWORK_WEAK = "network_weak",
  MOBILE_NETWORK_TIPS = "mobile_network_tips",
  RESOURCE_UPDATE_TIPS_1 = "resource_update_tips_1",
  RESOURCE_UPDATE_TIPS_2 = "resource_update_tips_2",
  UPDATE_DOWNLOAD_FINISH_1 = "update_download_finish_1",
  UPDATE_DOWNLOAD_FINISH_2 = "update_download_finish_2",
  FREE_EXPER_TIME_OVER = "free_exper_time_over",
  DOWNLOAD_EXPER_TIME_OVER = "download_exper_time_over",
  DOWNLOAD_EXPER_TIME_OVER_COUNTING = "download_exper_time_over_counting",
  EXPER_TIME_COMING = "exper_time_coming",
  EXPER_TIME_COMING_2 = "exper_time_coming_tips_2",
  GAME_RES_CHECKING = "game_res_checking",
  DOWNLOAD_COMPLETE = "download_complete",
  PLAY_TIME_OVER = "play_time_over",
  PLAY_TIME_OVER_WITH_DOWNLOAD_FINISH = "play_time_over_with_download_finish",
  PLAY_TIME_OVER_SELF_START = "play_time_over_selfstart",
  NETWORK_QUALITY_LOW = "network_quality_low",
  BLUETOOTH_CLOSE_TIPS = "bluetooth_close_tips",
  NOT_WIFI_REMAIN = "not_wifi_remain",
  FREE_CG_TIPS = "free_cg_tips",
  CONNECT_FAIL_TIPS = "connect_fail_tips",
  EXIT_CONFIRM = "exit_confirm",
  EXIT_CONFIRM_WITH_DOWNLOADED = "exit_confirm_with_download_finish",
  ON_CG_ERROR = "on_cg_error",
  ON_CG_ERROR_KICK_OUT = "on_cg_error_kick_out",
  START_DOWNLOAD_WIFI_TIPS = "start_download_wifi_tips",
  START_DOWNLOAD_MOBILE_TIPS = "start_download_mobile_tips",
  PKG_INSTALL_COMPLETE = "pkg_install_complete",
  PKG_INSTALL_COMPLETE_WITHOUT_CONNECT = "pkg_install_complete_without_connect",
  PKG_INSTALLED_TIPS = "pkg_installed_tips",
  TIME_END_WITH_INSTALLED = "time_end_with_installed",
  TIME_END_WITH_NOT_INSTALLED = "time_end_with_not_installed",
  TIME_COMING_WITH_INSTALLED_TIPS = "time_coming_with_installed_tips",
  TIME_COMING_WITH_NOT_INSTALLED_TIPS = "time_coming_with_not_installed_tips"
}
M.TIPS_SCENE = {
  DOWNLOAD_COMPLETE = "download_complete",
  PLAY_TIME_OVER = "play_time_over",
  NETWORK_QUALITY_LOW = "network_quality_low",
  NOT_WIFI_REMAIN = "not_wifi_remain",
  FREE_CG_TIPS = "free_cg_tips",
  CONNECT_FAIL_TIPS = "connect_fail_tips"
}
local init_tag = false

function M.init()
  if init_tag then
    return
  end
  init_tag = true
end

local function check_remote_content_cache()
  if web_ui_txt_cache then
    return web_ui_txt_cache
  end
  local cloud_game_config = CA.get_cloud_static_config()
  if cloud_game_config and next(cloud_game_config) ~= nil then
    local config_data = cloud_game_config.config
    web_ui_txt_cache = config_data and config_data.web_ui_content or nil
  end
  return web_ui_txt_cache
end

local function find_ui_content_in_config(config_data, scene)
  local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  local mode = facade.cloud_game_play_mode()
  E.LOG.debug(TAG, "current cloud game mode >> " .. tostring(mode))
  local dialog_infos = config_data.dialog_infos
  if mode == facade.CLOUD_GAME_PLAY_MODE.CLOUD_MOBILE_SELF_STARTUP then
    dialog_infos = config_data.dialog_infos
  elseif mode == facade.CLOUD_GAME_PLAY_MODE.CLOUD_MOBILE_TRY_PLAY then
    dialog_infos = config_data.dialog_infos_try_play
  end
  local content
  if dialog_infos then
    for _, v in ipairs(dialog_infos) do
      if v.scene == scene then
        content = utils.deepcopy(v)
      end
    end
  end
  return content
end

local function find_tips_content_in_config(config_data, scene)
  local content
  for _, v in ipairs(config_data.tips_infos) do
    if v.scene == scene then
      content = utils.deepcopy(v)
    end
  end
  return content
end

function M.get_txt(scene)
  E.LOG.debug(TAG, "get text with >> " .. tostring(scene))
  local content
  local remote_config_data = check_remote_content_cache()
  if remote_config_data and next(remote_config_data) ~= nil then
    E.LOG.warn(TAG, "web ui content from remote is not nil, now find with remote config for scene:" .. tostring(scene))
    content = find_ui_content_in_config(remote_config_data, scene)
  end
  if not content then
    E.LOG.debug(TAG, "not find config in remote, use local instead:" .. tostring(scene))
    content = find_ui_content_in_config(txt, scene)
    CSTAT.stat_action("web_content_ui_use_local_scene", tostring(scene))
  end
  if not content then
    E.LOG.warn(TAG, "do not find the content for scene >> " .. tostring(scene))
    CSTAT.stat_action("web_content_ui_not_found_scene", tostring(scene))
    return nil
  end
  return content
end

function M.get_tips(scene)
  local content = find_tips_content_in_config(txt, scene)
  return content
end

return M
