local E = require("ejoysdk_lua.ejoysdk")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ERF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ANP = require("ejoysdk_lua.res.ui.download_android_notif_presenter")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "[down]cloud_down_mgr"
M.DOWNLOAD_STATE = RTM.DOWNLOAD_STATE
M.LOCAL_RES_STATE_INFO_KEY = RTM.LOCAL_RES_STATE_INFO_KEY
M.STATE_INFO_KEY = download_utils.STATE_KEY
M.CLOUD_RES_STATE = download_utils.CLOUD_RES_STATE
local cloud_res_model
local is_init = false

function M.init()
  local res_type = cloud_config.ResourceType
  if res_type == cloud_config.RESOURCE_TYPE.GAME_RES then
    cloud_res_model = ERF.get_android_cloud_cn_oss_model()
  elseif res_type == cloud_config.RESOURCE_TYPE.ODR then
    cloud_res_model = ERF.get_ios_cloud_odr_model()
  elseif res_type == cloud_config.RESOURCE_TYPE.PACKAGE then
    cloud_res_model = ERF.get_install_pkg_model()
  end
  is_init = true
end

function M.check_game_res_state(state_cb)
  cloud_res_model:check_local_res_state(RTM.RES_NAMES.CLOUD_GAME_FULL_SRC, function(assets_down_state_info)
    E.LOG.debug(TAG, "check_game_res_state >>")
    E.LOG.debug(TAG, assets_down_state_info)
    state_cb(assets_down_state_info)
  end)
end

function M.is_odr()
  if cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.ODR then
    return true
  end
  return false
end

function M.prepare_game_res_config(cb)
  E.LOG.debug(TAG, "prepare_game_res_config begin")
  cloud_res_model:prepare_res_list_for_download(RTM.RES_NAMES.CLOUD_GAME_FULL_SRC, function(succ, ...)
    if succ then
      local res_file_list, res_update_info, local_res_state_info = ...
      local downloading_size = local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE]
      local total_size = res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE]
      E.LOG.debug(TAG, "prepare_res_list_for_download succ, now cb")
      cb(true, res_file_list, total_size, downloading_size)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.check_game_res_update(cb)
  E.LOG.debug(TAG, "prepare_game_res_config begin")
  cloud_res_model:check_res_update(function(succ, ...)
    cb(succ, ...)
  end)
end

function M.get_init_res_downloading_size()
  local res_state = cloud_res_model:get_res_state()
  local local_res_state = res_state[RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO] or {}
  local downloading_size = local_res_state[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] or 0
  local res_update_info = res_state[RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] or {}
  local total_size = res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] or 0
  E.LOG.debug(TAG, "get_init_res_downloading_size, total:" .. tostring(total_size) .. ", downloading_size:" .. tostring(downloading_size))
  return total_size, downloading_size
end

function M.get_res_state()
  do return cloud_res_model.get_res_state end
  return cloud_res_model.get_res_state, cloud_res_model
end

function M.start_download()
  if cloud_config.DEBUG_OPTIONS.TestDisableDownload then
    E.LOG.warn(TAG, "download disabled, return")
    CSTAT.stat_action("cloud_start_download_state", "disable", false)
    return
  end
  cloud_res_model:start_download()
end

local function _download_progress_listener(progress_info)
  local is_progress_notification_enable = cloud_config.is_download_progress_notification_enable()
  if progress_info.state ~= RTM.DOWNLOAD_STATE.UNDEFINED and is_progress_notification_enable then
    ANP.present_download_progress(progress_info)
  else
    E.LOG.debug(TAG, "_download_progress_listener, undefined state, skip update download progress, progress notification enable:" .. tostring(is_progress_notification_enable))
  end
end

function M.register_download_progress_listener(listener)
  cloud_res_model:register_res_state_listener(function(progress_info)
    _download_progress_listener(progress_info)
    listener(progress_info)
  end)
end

function M.mark_download_state_paused()
  cloud_res_model:pause_download()
end

function M.resume_download()
  cloud_res_model:resume_download()
end

function M.set_download_limit(speed)
  if not is_init then
    E.LOG.warn(TAG, "set_dowload_limit skip, for not init")
    return
  end
  cloud_res_model:set_download_speed(speed)
end

function M.update_limit_for_wifi(limit_for_wifi)
  cloud_config.update_limit_for_wifi(limit_for_wifi)
end

function M.current_download_state_info()
  local res_state_info = cloud_res_model:get_res_state()
  local progress_info = res_state_info[RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO]
  return progress_info
end

function M.current_download_state()
  local state_info = M.current_download_state_info()
  local current_state = state_info.state or M.DOWNLOAD_STATE.UNDEFINED
  E.LOG.debug(TAG, "current_download_state:" .. tostring(current_state))
  return current_state
end

return M
