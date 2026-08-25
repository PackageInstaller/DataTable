local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local E = require("ejoysdk_lua.ejoysdk")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local ICOS = require("ejoysdk_lua.res.model.src_adapters.ios_cloud_odr_source")
local odr_downloader = require("ejoysdk_lua.cloud_game.asset_download_odr")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local cloud_ui = require("ejoysdk_lua.cloud_game.cloud_ui")
local RMB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local odr_speed = require("ejoysdk_lua.odr.speed_util")
local MODEL_NAME = "EjoyOdrResModel"
local M = RTM:Inherit(MODEL_NAME)
local TAG = "ejoy_odr_res_model"
local RETRY_INTERVAL = 6

function M:_init(_model_name)
  self._data = {
    model_name = _model_name,
    local_res_state_info = {
      [RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.UNDEFINED,
      [RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = 0
    },
    res_update_info = {
      [RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
    },
    current_down_progress_info = {
      state = RTM.DOWNLOAD_STATE.UNDEFINED,
      speed = 0,
      progress = 0,
      total_size = 0,
      downloading_size = 0
    }
  }
  self:log_debug("_init begin")
  odr_downloader.init()
end

function M:get_model_name()
  return self._data.model_name
end

function M:check_res_update(cb)
  E.LOG.debug(TAG, "check_res_update begin:")
  ICOS:check_res_update(function(succ, ...)
    if succ then
      local res_update_info = (...)
      E.LOG.debug(TAG, "get_res_update_info succ")
      self._data.res_update_info = res_update_info
      cb(true, res_update_info)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "get_res_update_info failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M:prepare_res_list_for_download(_res_name, cb)
  E.LOG.debug(TAG, "prepare_res_list_for_download begin:" .. tostring(_res_name))
  ICOS:check_update_file_list(function(succ, ...)
    if succ then
      local res_tag_list, res_update_info = ...
      E.LOG.debug(TAG, "check_res_update succ")
      self._data.res_update_info = res_update_info
      self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = odr_downloader.get_downloaded_size()
      cb(true, res_tag_list, res_update_info, self._data.local_res_state_info)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "check_res_update failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M:check_local_res_state(_res_name, cb)
  download_utils.check_assets_down_state_odr(function(assets_down_state_info)
    E.LOG.debug(TAG, "check_game_res_state >>")
    self._data.local_res_state_info = {}
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = assets_down_state_info[download_utils.STATE_KEY.STATE]
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.VERSION_NAME] = assets_down_state_info[download_utils.STATE_KEY.VERSION_NAME]
    local downloading_size = odr_downloader.get_downloaded_size()
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = downloading_size
    E.LOG.debug(TAG, self._data.local_res_state_info)
    E.LOG.debug(TAG, assets_down_state_info)
    cb(assets_down_state_info)
  end)
end

function M:get_res_state()
  local res_state = {
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO] = self._data.local_res_state_info,
    [RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] = self._data.res_update_info,
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = self._data.current_down_progress_info
  }
  return res_state
end

function M:get_res_location()
end

function M:register_res_state_listener()
end

function M:remove_res()
end

function M:_on_download_progress_changed()
  if self._data.download_progress_listener ~= nil then
    self._data.download_progress_listener(self._data.current_down_progress_info)
  end
  if self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] ~= self._data.current_down_progress_info.total_size then
    self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = self._data.current_down_progress_info.total_size
  end
  if self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] ~= self._data.current_down_progress_info.downloading_size then
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = self._data.current_down_progress_info.downloading_size
  end
  if self._data.current_down_progress_info.state == RTM.DOWNLOAD_STATE.COMPLETE then
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.COMPLETE
  end
end

function M:_check_storage_and_down_assets(need_down_files, total_size, downloading_size, fail_cb)
  E.LOG.debug(TAG, "[cloud game] begin down asset retrycnt = " .. self._data.retry_down_cnt)
  
  local function down_assets_ok()
    self._data.current_down_progress_info.state = M.DOWNLOAD_STATE.COMPLETE
    self._data.current_down_progress_info.speed = 0
    self._data.current_down_progress_info.progress = 100
    self._data.current_down_progress_info.total_size = total_size
    self._data.current_down_progress_info.downloading_size = total_size
    self:_on_download_progress_changed()
  end
  
  local is_retry = false
  local try_download
  
  function try_download()
    if next(need_down_files) == nil then
      E.LOG.debug(TAG, "no more files need download, just callback succ")
      down_assets_ok()
      return
    end
    RMB.get_disk_capcity(function(available_size)
      E.LOG.debug(TAG, "[cloud game] get_disk_capacity available_size = " .. tostring(available_size / 1024 / 1024))
      local more_mb_size = total_size * 0.1
      if available_size > total_size - downloading_size + more_mb_size then
        cloud_ui.set_state(cloud_ui.State.BeginDownload)
        CSTAT.stat_action("cloud_download_before_disk_check_succ")
        odr_downloader.download_assets(need_down_files, total_size, downloading_size, down_assets_ok, fail_cb)
        if is_retry then
          CSTAT.stat_action("storage_not_enough_page_click_replay_return", nil, true)
        end
      else
        if is_retry then
          CSTAT.stat_action("storage_not_enough_page_click_replay_return", nil, false)
        end
        is_retry = true
        cloud_ui.show_storage_error(try_download)
      end
    end)
  end
  
  if nil == downloading_size then
    downloading_size = odr_downloader.get_downloaded_size()
    E.LOG.debug(TAG, "[cloud game] get_downloading_size finish, begin download, downloading_size:" .. tostring(downloading_size))
  end
  try_download()
end

function M:_mark_current_download_list_invalid()
  self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
  ICOS:mark_update_res_invalid()
end

function M:_begin_down_asset()
  E.LOG.debug(TAG, "begin_down_asset >>")
  
  local function down_error_fun(code, error_str)
    E.LOG.debug(TAG, "[cloud game] down asset error " .. tostring(error_str))
    self._data.retry_down_cnt = self._data.retry_down_cnt + 1
    if (not (code >= -1001) or not (code <= -1006)) and not (code >= 7000000) and not (code < 8000000) then
      CSTAT.stat_action("download_fail_redownload_file_list", code)
      self:_mark_current_download_list_invalid()
    end
    E.Timer.once(RETRY_INTERVAL, function()
      self:_begin_down_asset()
    end)
    CSTAT.stat_action("cloud_start_download_state_error", tostring(error_str))
  end
  
  self:prepare_res_list_for_download(RTM.RES_NAMES.CLOUD_GAME_FULL_SRC, function(succ, ...)
    if succ then
      local total_size = self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE]
      local downloading_size = self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE]
      E.LOG.debug(TAG, "begin_down_asset prepare_res_list_for_download succ, total_size:" .. tostring(total_size) .. ", downloading_size:" .. tostring(downloading_size))
      self:_check_storage_and_down_assets(self._data.res_file_list, total_size, downloading_size, down_error_fun)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "begin_down_asset prepare_res_list_for_download failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      down_error_fun(code, msg or "")
    end
  end)
end

function M:_start_download()
  if self._data.current_down_progress_info.state == RTM.DOWNLOAD_STATE.DOWNLOADING then
    E.LOG.debug(TAG, "start_download already downloading, now return")
    CSTAT.stat_action("cloud_start_download_state", "downloading", false)
    return
  end
  self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.DOWNLOADING
  E.LOG.debug(TAG, "begin_down_asset, current state downloading")
  CSTAT.stat_action("cloud_start_download_state", "begin", true)
  self:_begin_down_asset()
  odr_speed.register_download_speed_listener(function(speed)
    self:_download_speed_listener(speed)
  end)
  odr_downloader.register_download_progress_changed(function(downloading_size, total_size)
    self:_download_progress_changed_listener(downloading_size, total_size)
  end)
end

function M:start_download(_cb)
  self:_start_download()
  return true
end

function M:set_download_speed(_speed)
end

return M
