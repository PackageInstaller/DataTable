local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local RMB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local E = require("ejoysdk_lua.ejoysdk")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local ACRS = require("ejoysdk_lua.res.model.src_adapters.android_cloud_cn_oss_source")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local asset_downloader = require("ejoysdk_lua.cloud_game.asset_download_default")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local cloud_ui = require("ejoysdk_lua.cloud_game.cloud_ui")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local FREE_FLOW = require("ejoysdk_lua.cloud_game.cloud_free_data_pkg")
local MODEL_NAME = "EjoyAnCloudCNResSourceModel"
local M = RTM:Inherit(MODEL_NAME)
local TAG = MODEL_NAME
local CACHE_LAST_DOWNLOADING_BYTES = E.LazyKeyStore:New("CLOUD_LAST_DOWNLOADING_BYTES", false, false, false)
local CACHE_LAST_TOTAL_BYTES = E.LazyKeyStore:New("CLOUD_LAST_TOTAL_BYTES", false, false, false)
local RETRY_INTERVAL = 6
local NOTIFY_SPEED_INTERVAL = 1
local SAVE_CACHE_CHANGE_BYTES_INTERVAL = 10485760
M.FILE_LIST_CHECK_STATE = {
  UNDEFINED = "undefined",
  CHECKING = "checking",
  CHECK_FINISHED = "check_finished"
}

function M:_init()
  self._data = {
    local_res_state_info = {
      [RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.UNDEFINED,
      [RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = 0
    },
    res_update_info = {
      [RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
    },
    res_file_list = nil,
    check_file_list_state = M.FILE_LIST_CHECK_STATE.UNDEFINED,
    check_file_list_listeners = {},
    current_down_progress_info = {
      state = RTM.DOWNLOAD_STATE.UNDEFINED,
      speed = 0,
      progress = 0,
      total_size = 0,
      downloading_size = 0
    },
    retry_down_cnt = 0,
    last_callback_download_speed_listener_time = 0,
    last_save_downloading_size = 0,
    last_save_total_size = 0,
    download_progress_listener = nil
  }
  self:log_debug("_init begin:")
  asset_downloader.init()
  
  local function receive_free_data_pkg_cb(is_free)
    E.LOG.debug(TAG, "receive free data pkg cb, is free >> " .. tostring(is_free))
    if is_free then
      local url = asset_downloader.get_current_download_url()
      E.LOG.debug(TAG, "before exchange download url >> " .. tostring(url))
      FREE_FLOW.exchange_download_host(url, function(succ, ...)
        if succ then
          local new_url = (...)
          asset_downloader.update_free_download_url(new_url)
          E.LOG.debug(TAG, "exchange free download succ, new url >> " .. tostring(new_url))
        else
          E.LOG.debug(TAG, "exchange free download failed")
        end
      end)
    end
  end
  
  FREE_FLOW.register_receive_data_pkg_over_cb(receive_free_data_pkg_cb)
end

function M:get_model_name()
  return MODEL_NAME
end

function M:check_res_update(cb)
  ACRS:check_res_update(function(succ, ...)
    if succ then
      local res_update_info = (...)
      self._data.res_update_info = res_update_info
      E.LOG.debug(TAG, "get_res_update_info succ")
      cb(true, res_update_info)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "get_res_update_info failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

local function get_downloading_size(file_list, cb)
  asset_downloader.get_downloading_size(file_list, function(downloading_size)
    E.LOG.debug(TAG, "[cloud game]get_downloading_size finish, downloading_size:" .. tostring(downloading_size))
    cb(downloading_size)
  end)
end

function M:prepare_res_list_for_download(_res_tag_name, cb)
  if self._data.check_file_list_state == M.FILE_LIST_CHECK_STATE.CHECK_FINISHED then
    E.LOG.debug(TAG, "prepare_res_list_for_download, current state CHECK_FINISHED:" .. tostring(self._data.res_update_info.total_size) .. ", downloading_size:" .. tostring(self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE]))
    cb(true, self._data.res_file_list, self._data.res_update_info)
    return
  elseif self._data.check_file_list_state == M.FILE_LIST_CHECK_STATE.CHECKING then
    table.insert(self._data.check_file_list_listeners, cb)
    return
  end
  self._data.check_file_list_state = M.FILE_LIST_CHECK_STATE.CHECKING
  table.insert(self._data.check_file_list_listeners, cb)
  E.LOG.debug(TAG, "prepare_res_list_for_download, current state CHECKING")
  E.LOG.debug(TAG, "check_res_update begin")
  ACRS:check_update_file_list(function(succ, ...)
    if succ then
      local res_file_list, res_update_info = ...
      self._data.res_update_info = res_update_info
      get_downloading_size(res_file_list, function(downloading_size)
        E.LOG.debug(TAG, "prepare_res_list_for_download succ, update downloading size:" .. tostring(downloading_size))
        self._data.check_file_list_state = M.FILE_LIST_CHECK_STATE.CHECK_FINISHED
        self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = downloading_size
        self._data.res_file_list = res_file_list
        self:_on_update_download_progress(downloading_size, res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE])
        for _, callback in ipairs(self._data.check_file_list_listeners) do
          callback(true, self._data.res_file_list, self._data.res_update_info, self._data.local_res_state_info)
        end
        self._data.check_file_list_listeners = {}
      end)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "check_res_update failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      CSTAT.stat_action_fail("cloud_mini_check_update_file_list_fail", nil, code, msg)
      self._data.check_file_list_state = M.FILE_LIST_CHECK_STATE.UNDEFINED
      for _, callback in ipairs(self._data.check_file_list_listeners) do
        callback(false, code, msg)
      end
      self._data.check_file_list_listeners = {}
    end
  end)
end

function M.get_init_res_downloading_size()
  local last_total_size = CACHE_LAST_TOTAL_BYTES:get() or 0
  local downloading_bytes = CACHE_LAST_DOWNLOADING_BYTES:get() or 0
  last_total_size = tonumber(last_total_size)
  downloading_bytes = tonumber(downloading_bytes)
  E.LOG.debug(TAG, "get_init_res_downloading_size, last_total_size:" .. tostring(last_total_size) .. ", downloading_size:" .. tostring(downloading_bytes))
  return last_total_size, downloading_bytes
end

function M:check_local_res_state(_res_name, cb)
  download_utils.check_assets_down_state(function(assets_down_state_info)
    E.LOG.debug(TAG, "check_game_res_state >>")
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = assets_down_state_info[download_utils.STATE_KEY.STATE]
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.VERSION_NAME] = assets_down_state_info[download_utils.STATE_KEY.VERSION_NAME]
    local total_size, downloading_size = M.get_init_res_downloading_size()
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = downloading_size
    self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = total_size
    E.LOG.debug(TAG, self._data.local_res_state_info)
    cb(self._data.local_res_state_info)
  end)
end

function M:get_res_state()
  local total_size = self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] or 0
  if 0 == total_size then
    local cfg_game_res_info = cloud_adapter.get_config_game_res_info()
    self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = cfg_game_res_info.size_bytes or 0
  end
  local res_state = {
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO] = self._data.local_res_state_info,
    [RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] = self._data.res_update_info,
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = self._data.current_down_progress_info
  }
  return res_state
end

function M:get_res_location()
end

function M:register_res_state_listener(listener)
  self._data.download_progress_listener = listener
end

function M:remove_res()
end

function M:_mark_current_download_list_invalid()
  download_utils.backup_clear_game_res_config_files()
  self._data.check_file_list_state = M.FILE_LIST_CHECK_STATE.UNDEFINED
  self._data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
  ACRS:mark_update_res_invalid()
end

function M:_check_storage_and_down_assets(need_down_files, total_size, downloading_size, fail_cb)
  E.LOG.debug(TAG, "[cloud game] begin down asset retrycnt = " .. self._data.retry_down_cnt)
  
  local function down_assets_ok()
    self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.COMPLETE
    self._data.current_down_progress_info.speed = 0
    self._data.current_down_progress_info.progress = 100
    self._data.current_down_progress_info.total_size = total_size
    self._data.current_down_progress_info.downloading_size = total_size
    E.LOG.debug(TAG, "download complete, notify progress changed")
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
        asset_downloader.download_assets(need_down_files, total_size, downloading_size, down_assets_ok, fail_cb)
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
    asset_downloader.get_downloading_size(need_down_files, function(_downloading_size)
      E.LOG.debug(TAG, "[cloud game] get_downloading_size finish, begin download, downloading_size:" .. tostring(_downloading_size))
      downloading_size = _downloading_size
      try_download()
    end)
  else
    try_download()
  end
end

function M:_begin_down_asset()
  E.LOG.debug(TAG, "begin_down_asset >>")
  
  local function down_error_fun(code, error_str)
    E.LOG.debug(TAG, "[cloud game] down asset error " .. tostring(error_str) .. ", code:" .. tostring(code))
    self._data.retry_down_cnt = self._data.retry_down_cnt + 1
    if (not (code >= -1006) or not (code <= -1001)) and (not (code >= 7000000) or not (code < 8000000)) then
      E.LOG.debug(TAG, "_mark_current_download_list_invalid begin:" .. tostring(code))
      CSTAT.stat_action("download_fail_redownload_file_list", code)
      self:_mark_current_download_list_invalid()
    else
      E.LOG.debug(TAG, "_mark_current_download_list_invalid skip:" .. tostring(code))
    end
    E.Timer.once(RETRY_INTERVAL, function()
      self:_begin_down_asset()
    end)
    CSTAT.stat_action("cloud_start_download_state_error", tostring(error_str), tostring(code))
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

function M:_download_speed_listener(speed)
  self._data.current_down_progress_info.speed = speed / 1000
  E.LOG.debug(TAG, "download_speed_listener, speed:" .. tostring(self._data.current_down_progress_info.speed) .. "KB/S" .. ", speed:" .. tostring(speed))
  local cur_time = E.time()
  if cur_time - self._data.last_callback_download_speed_listener_time >= NOTIFY_SPEED_INTERVAL then
    self._data.last_callback_download_speed_listener_time = cur_time
    ET.publish(cloud_config.CLOUD_TOPIC.TOPIC_DOWNLOAD_STATE_CHANGED, self._data.current_down_progress_info)
  end
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
    E.LOG.debug(TAG, "on_download_progress_changed reset last_save_downloading_size:" .. tostring(0))
    CACHE_LAST_DOWNLOADING_BYTES:set(self._data.current_down_progress_info.total_size)
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.COMPLETE
  elseif 0 == self._data.last_save_downloading_size or self._data.current_down_progress_info.downloading_size - self._data.last_save_downloading_size > SAVE_CACHE_CHANGE_BYTES_INTERVAL then
    self._data.last_save_downloading_size = self._data.current_down_progress_info.downloading_size
    E.LOG.debug(TAG, "on_download_progress_changed save last_save_downloading_size:" .. tostring(self._data.last_save_downloading_size))
    CACHE_LAST_DOWNLOADING_BYTES:set(self._data.last_save_downloading_size)
  end
  if self._data.last_save_total_size ~= self._data.current_down_progress_info.total_size then
    self._data.last_save_total_size = self._data.current_down_progress_info.total_size
    CACHE_LAST_TOTAL_BYTES:set(self._data.last_save_total_size)
  end
end

function M:_on_update_download_progress(downloading_size, total_size)
  local percent
  if total_size > 0 then
    percent = math.floor(downloading_size / total_size * 100)
  else
    percent = 0
  end
  self._data.current_down_progress_info.progress = percent
  self._data.current_down_progress_info.total_size = total_size
  self._data.current_down_progress_info.downloading_size = downloading_size
  E.LOG.debug(TAG, "request_file: download_progress_changed_listener changed, percent:" .. tostring(percent) .. ", total_size:" .. tostring(total_size) .. ", downloading_size:" .. tostring(downloading_size) .. ", downloadig M:" .. tostring(downloading_size / 1024 / 1024))
  self:_on_download_progress_changed()
end

function M:_download_progress_changed_listener(downloading_size, total_size)
  self:_on_update_download_progress(downloading_size, total_size)
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
  download_utils.register_download_speed_changed(function(speed)
    self:_download_speed_listener(speed)
  end)
  asset_downloader.register_download_progress_changed(function(downloading_size, total_size)
    self:_download_progress_changed_listener(downloading_size, total_size)
  end)
end

function M:start_download()
  self:_start_download()
  return true
end

function M:pause_download()
  download_utils.set_donwload_pause(true)
  self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.STOPPED
  CSTAT.stat_action("cloud_pause_download", tostring(self._data.current_down_progress_info.state), true)
end

function M:resume_download()
  download_utils.set_donwload_pause(false)
  self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.DOWNLOADING
  CSTAT.stat_action("cloud_pause_download", tostring(self._data.current_down_progress_info.state), false)
end

function M:is_download_paused()
  local is_download_paused = download_utils.is_download_paused()
  return is_download_paused
end

function M:set_download_speed(speed)
  cloud_config.update_default_http_kps_limit(speed)
  local current_speed = self._data.current_down_progress_info.speed
  if -1 == cloud_config.force_http_kps then
    E.LOG.debug(TAG, "set_dowload_limit speed is -1, not update native speed, current_speed:" .. tostring(current_speed))
    CSTAT.stat_action_interval("cloud_speed_no_limit", speed, current_speed, nil, 30)
    return
  end
  E.LOG.debug(TAG, "set_dowload_limit speed is:" .. speed .. ", current_speed:" .. tostring(current_speed))
  CSTAT.stat_action_interval("cloud_notify_speed_update", speed, current_speed, nil, 30)
  local conf_params = {
    limit_speed = speed,
    limit_interval = cloud_config.HttpIntervalLimit,
    read_buffer_size_bytes = cloud_config.READ_BUFFER_SIZE_BYTES
  }
  E.LOG.debug(TAG, "set_dowload_limit >>")
  E.LOG.debug(TAG, conf_params)
  RMB.update_http_config(conf_params)
end

return M
