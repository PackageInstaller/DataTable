local RSA = require("ejoysdk_lua.res.model.src_adapters.res_source_adapter")
local E = require("ejoysdk_lua.ejoysdk")
local cloud_adapter = require("ejoysdk_lua.cloud_game.cloud_adapter")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local asset_downloader = require("ejoysdk_lua.cloud_game.asset_download_default")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ADAPTER_NAME = "AndroidCloudResSource"
local M = RSA:Inherit(ADAPTER_NAME)
local TAG = ADAPTER_NAME
M.FILE_LIST_CHECK_STATE = {
  UNDEFINED = "undefined",
  CHECKING = "checking",
  CHECK_FINISHED = "check_finished"
}
local _data = {
  res_update_info = {check_update_result = false, total_size = 0},
  res_file_list = nil,
  check_file_list_state = false,
  check_file_list_listeners = {}
}

local function request_cloud_server_config(cb)
  cloud_adapter.request_cloud_server_config(function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
    cb(succ, ...)
  end)
end

function M:check_res_update(cb)
  if _data.res_update_info.check_update_result == true then
    E.LOG.debug(TAG, "get_update_info already check succ, now directly return")
    cb(true, _data.res_update_info)
    return
  end
  request_cloud_server_config(function(_succ, ...)
    if _succ then
      _data.res_update_info.check_update_result = true
      E.LOG.debug(TAG, "prepare_game_newest_resource, request config succ, now begin prepare")
      local cfg_game_res_info = cloud_adapter.get_config_game_res_info()
      _data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = cfg_game_res_info.size_bytes or 0
      cb(true, _data.res_update_info)
    else
      _data.res_update_info.check_update_result = false
      local code, msg = ...
      E.LOG.warn(TAG, "get_update_info failed, request_cloud_config failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M:_request_remote_file_list(cb)
  if _data.check_file_list_state == M.FILE_LIST_CHECK_STATE.CHECK_FINISHED then
    E.LOG.debug(TAG, "_request_remote_file_list, current state CHECK_FINISHED:" .. tostring(_data.res_update_info.total_size))
    cb(true, _data.res_file_list, _data.res_update_info)
    return
  elseif _data.check_file_list_state == M.FILE_LIST_CHECK_STATE.CHECKING then
    table.insert(_data.check_file_list_listeners, cb)
    return
  end
  _data.check_file_list_state = M.FILE_LIST_CHECK_STATE.CHECKING
  table.insert(_data.check_file_list_listeners, cb)
  E.LOG.debug(TAG, "_request_remote_file_list, current state CHECKING")
  local length = #cloud_config.REMOTE_URLS
  if 0 == length then
    _data.check_file_list_state = M.FILE_LIST_CHECK_STATE.UNDEFINED
    E.LOG.warn(TAG, "prepare config failed, not find remote urls, current_config_state set undefined")
    for _, callback in ipairs(_data.check_file_list_listeners) do
      callback(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.CLOUD_CONFIG_DOWNLOAD_URL_INVALID, "_down_file_url_empty error")
    end
    _data.check_file_list_listeners = {}
    return
  end
  E.LOG.debug(TAG, "get_file_list, remote url is " .. tostring(cloud_config.REMOTE_URLS))
  asset_downloader.get_file_list(function(file_list, total_size)
    E.LOG.debug(TAG, "prepare_game_res_config, current state CONFIGED")
    _data.check_file_list_state = M.FILE_LIST_CHECK_STATE.CHECK_FINISHED
    _data.res_file_list = file_list
    _data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = total_size
    for _, callback in ipairs(_data.check_file_list_listeners) do
      callback(true, _data.res_file_list, _data.res_update_info)
    end
    _data.check_file_list_listeners = {}
    CSTAT.stat_action("cloud_get_file_list", tostring(total_size), true)
  end, function(_code, error_str)
    E.LOG.debug(TAG, "prepare_game_res_config, current state UNDEFINED")
    _data.check_file_list_state = M.FILE_LIST_CHECK_STATE.UNDEFINED
    local err_msg = tostring(_code) .. "-" .. tostring(error_str)
    for _, callback in ipairs(_data.check_file_list_listeners) do
      callback(false, CONSTANTS.CLOUD_GAME_ERROR_CODES.PREPARE_CONFIG_FAILED, err_msg)
    end
    _data.check_file_list_listeners = {}
    CSTAT.stat_action("cloud_get_file_list", err_msg, false)
  end)
end

function M:check_update_file_list(cb)
  E.LOG.debug(TAG, "check_update_file_list begin")
  self:check_res_update(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "check_update_file_list get_update_info succ, now begin get file list")
      self:_request_remote_file_list(cb)
    else
      cb(false, ...)
    end
  end)
end

function M:mark_update_res_invalid()
  E.LOG.debug(TAG, "mark_update_res_invalid begin")
  _data.res_file_list = {}
  _data.check_file_list_state = M.FILE_LIST_CHECK_STATE.UNDEFINED
  _data.res_update_info.check_update_result = false
  _data.res_update_info.total_size = 0
end

return M
