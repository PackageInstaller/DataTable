local E = require("ejoysdk_lua.ejoysdk")
local cloud_ui = require("ejoysdk_lua.cloud_game.cloud_ui")
local demand_res = require("ejoysdk_lua.odr.demand_res_manager")
local odr_speed = require("ejoysdk_lua.odr.speed_util")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.CLOUD_GAME .. "asset_down_odr"
local is_current_download_paused = true
local is_download_finish = false
local progress_change_listener
local M = {}
M.RES_DOWNLOAD_CACHE = E.LazyKeyStore:New("CLOUD_GAME_RES_DOWNLOAD_INFO", false, true, false)
M.CACHE_KEY = {
  RECORD = "load_record",
  VERSION_NAME = "ver_name"
}
M.DOWNLOAD_STATE = {
  STATE_PAUSE = "pause",
  STATE_RESUME = "resume",
  STATE_DOWNLOADING = "downloading"
}
local download_ok_cb, download_fail_cb
local current_download_size = 0
local download_total_size = 0
local download_progress_size = {}
local finish_download_tags = {}
local need_download_tags, state_info, progress_observer, error_handler
local total_download_tag = 0
local download_state, hold_task

local function get_tag_file_size(tag)
  local odr_config = cloud_config.ODRConfig
  local on_demand_tags = odr_config[cloud_config.ODR_TYPES.ON_DEMAND]
  for _, t in ipairs(on_demand_tags) do
    if t[cloud_config.ODR_TAG_CONFIG_KEYS.NAME] == tag then
      return t[cloud_config.ODR_TAG_CONFIG_KEYS.SIZE]
    end
  end
  local fast_follow_tags = odr_config[cloud_config.ODR_TYPES.FAST_FOLLOW]
  for _, t in ipairs(fast_follow_tags) do
    if t[cloud_config.ODR_TAG_CONFIG_KEYS.NAME] == tag then
      return t[cloud_config.ODR_TAG_CONFIG_KEYS.SIZE]
    end
  end
  return 0
end

function M.init()
  E.LOG.debug(TAG, "asset download odr init, but do nothing")
  demand_res.init()
end

function M.download_assets(need_down_tags, total_size, cur_down_size, ok_cb, fail_cb)
  if download_state == M.DOWNLOAD_STATE.STATE_PAUSE then
    CSTAT.stat_action("cloud_odr_start_download_but_pause")
    hold_task = {
      need_down_tags = need_down_tags,
      total_size = total_size,
      cur_down_size = cur_down_size,
      ok_cb = ok_cb,
      fail_cb = fail_cb
    }
    return
  end
  download_state = M.DOWNLOAD_STATE.STATE_DOWNLOADING
  download_ok_cb = ok_cb
  download_fail_cb = fail_cb
  need_download_tags = utils.deepcopy(need_down_tags)
  download_total_size = total_size
  E.LOG.debug(TAG, "download_assets, total_size >> " .. tostring(total_size) .. ", current down size >> " .. tostring(cur_down_size))
  E.LOG.debug(TAG, need_down_tags)
  current_download_size = cur_down_size
  total_download_tag = #need_down_tags
  finish_download_tags = {}
  M._update_version_to_cache()
  cloud_ui.set_download_progress(cur_down_size, total_size)
  if nil == progress_observer then
    function progress_observer(tag, progress)
      E.LOG.debug(TAG, "on download progress notify, tag >> " .. tag .. ", progress >> " .. tostring(progress))
      
      local tag_size = get_tag_file_size(tag)
      local downloaded_size = tag_size * progress
      download_progress_size[tag] = downloaded_size
      E.LOG.debug(TAG, download_progress_size)
      M._save_download_size(tag, downloaded_size)
      M._cul_total_download_size()
    end
    
    demand_res.register_progress_observer(progress_observer)
  end
  if nil == error_handler then
    function error_handler(...)
      local tag, code, msg = ...
      
      local error_info = "odr download error, tag >> " .. tostring(tag) .. ", code >> " .. tostring(code) .. ", message >> " .. tostring(msg)
      M._stat_error(tag, code, msg)
      if download_fail_cb then
        download_fail_cb(error_info)
      end
    end
    
    demand_res.register_error_handler(error_handler)
  end
  is_current_download_paused = false
  M._register_download_pause_listener()
  is_download_finish = false
  local download_loop
  
  function download_loop()
    if #need_download_tags > 0 then
      local tag = need_download_tags[1]
      E.LOG.debug(TAG, "need download tag >> " .. tag)
      demand_res.request_res(tag, get_tag_file_size(tag), function()
        table.insert(finish_download_tags, tag)
        for index, t in ipairs(need_download_tags) do
          if t == tag then
            table.remove(need_download_tags, index)
            break
          end
        end
        E.LOG.debug(TAG, "download finish, tag >> " .. tag)
        E.LOG.debug(TAG, need_download_tags)
        download_loop()
      end)
    else
      E.LOG.debug(TAG, "there is no tag need download, finish")
      M._check_is_finish_download()
    end
  end
  
  download_loop()
  CSTAT.stat_action("cloud_odr_download_start")
end

function M._stat_error(tag, code, message)
  local stat_params = {
    is_priority_high = true,
    sub_params_code = code,
    sub_params_message = message
  }
  CSTAT.stat_action("cloud_odr_download_error", tag, false, stat_params)
end

function M._register_download_pause_listener()
  download_utils.register_download_pause_listener(function(is_pause)
    if is_download_finish then
      return
    end
    if is_current_download_paused ~= is_pause then
      is_current_download_paused = is_pause
      if is_pause then
        M._pause_download()
      else
        M._resume_download()
      end
    end
  end)
end

function M._pause_download()
  E.LOG.debug(TAG, "pause download")
  CSTAT.stat_action("cloud_odr_download_pause")
  download_state = M.DOWNLOAD_STATE.STATE_PAUSE
end

function M._resume_download()
  E.LOG.debug(TAG, "resume download")
  download_state = M.DOWNLOAD_STATE.STATE_RESUME
  if hold_task then
    CSTAT.stat_action("cloud_odr_download_resume", "has_hold_task")
    local need_down_tags = hold_task.need_down_tags
    local total_size = hold_task.total_size
    local cur_down_size = hold_task.cur_down_size
    local ok_cb = hold_task.ok_cb
    local fail_cb = hold_task.fail_cb
    M.download_assets(need_down_tags, total_size, cur_down_size, ok_cb, fail_cb)
    hold_task = nil
  else
    CSTAT.stat_action("cloud_odr_download_resume", "no_hold_task")
    E.LOG.debug(TAG, "there is no hold task, do nothing!")
  end
end

function M._update_version_to_cache()
  if nil == state_info then
    state_info = M.RES_DOWNLOAD_CACHE:get() or {}
  end
  E.LOG.debug(TAG, "#update_version_to_cache print the cache state info")
  E.LOG.debug(TAG, state_info)
  local cur_app_ver_name = E.get_pkg_info().versions.app_version_name
  E.LOG.debug(TAG, "get current version >> " .. tostring(cur_app_ver_name))
  if nil == next(state_info) then
    state_info[M.CACHE_KEY.VERSION_NAME] = cur_app_ver_name
    state_info[M.CACHE_KEY.RECORD] = {}
    M.RES_DOWNLOAD_CACHE:set(state_info)
  else
    local last_ver_name = state_info[M.CACHE_KEY.VERSION_NAME]
    E.LOG.debug(TAG, "get last version >> " .. tostring(last_ver_name))
    if last_ver_name ~= cur_app_ver_name then
      state_info[M.CACHE_KEY.VERSION_NAME] = cur_app_ver_name
      state_info[M.CACHE_KEY.RECORD] = {}
      M.RES_DOWNLOAD_CACHE:set(state_info)
    end
  end
end

function M._save_download_size(tag, downloaded_size)
  if nil == state_info then
    state_info = M.RES_DOWNLOAD_CACHE:get() or {}
  end
  E.LOG.debug(TAG, "#save_download_size print the cache state info before")
  E.LOG.debug(TAG, state_info)
  local record = state_info[M.CACHE_KEY.RECORD] or {}
  record[tag] = downloaded_size
  state_info[M.CACHE_KEY.RECORD] = record
  M.RES_DOWNLOAD_CACHE:set(state_info)
  E.LOG.debug(TAG, "#save_download_size print the cache state info after")
  E.LOG.debug(TAG, state_info)
end

function M.get_downloaded_size()
  if nil == state_info then
    state_info = M.RES_DOWNLOAD_CACHE:get() or {}
  end
  E.LOG.debug(TAG, "#get_downloaded_size print the cache state info")
  E.LOG.debug(TAG, state_info)
  if nil ~= next(state_info) then
    local last_version_name = state_info[M.CACHE_KEY.VERSION_NAME]
    local cur_app_ver_name = E.get_pkg_info().versions.app_version_name
    if last_version_name ~= cur_app_ver_name then
      E.LOG.debug(TAG, "#get_downloaded_size version name is not same >> return 0")
      return 0
    else
      local record = state_info[M.CACHE_KEY.RECORD]
      local download_size = 0
      for _, size in pairs(record) do
        download_size = download_size + size
      end
      E.LOG.debug(TAG, "#get_downloaded_size version name is same, return download_size >> " .. tostring(download_size))
      return download_size
    end
  end
  return 0
end

function M._cul_total_download_size()
  local loaded_size = 0
  for _, size in pairs(download_progress_size) do
    loaded_size = loaded_size + size
  end
  current_download_size = loaded_size
  E.LOG.debug(TAG, "set download size >> total_size=" .. tostring(download_total_size) .. ", cur_download_size=" .. current_download_size)
  if progress_change_listener then
    progress_change_listener(current_download_size, download_total_size)
  end
end

function M._check_is_finish_download()
  if #finish_download_tags == total_download_tag then
    odr_speed.stop_cal_speed_loop()
    is_download_finish = true
    E.LOG.debug(TAG, "finish download all the tags, call ok_cb")
    if download_ok_cb then
      download_ok_cb()
      CSTAT.stat_action("cloud_odr_download_success")
      download_ok_cb = nil
      download_utils.save_odr_download_finish()
    end
  end
end

function M._update_odr_speed(_params)
end

function M.update_with_config(params)
  M._update_odr_speed(params)
end

function M.register_download_progress_changed(listener)
  progress_change_listener = listener
end

return M
