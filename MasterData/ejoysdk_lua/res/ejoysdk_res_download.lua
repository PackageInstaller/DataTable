local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.RES .. "ejoysdk_res_download"
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local DOWNLOAD_STATES = {
  DOWNLOADED = "downloaded",
  DOWNLOADING = "downloading",
  UNKNOWN = "unknown"
}
local downloading_files = {}
local temp_suffix = "_dl_bak_"

local function stat(action, key, action_type)
  local ejoysdk_stat = require("ejoysdk_lua.ejoysdk_stat")
  E.LOG.debug(TAG, "action=" .. tostring(action) .. ", key=" .. tostring(key))
  ejoysdk_stat.stat_action(action, action_type, nil, {url = key})
end

local function check_file_state(file_path)
  if HRU.is_file_exists(file_path) then
    E.LOG.debug(TAG, "check_file_state file exists, now return downloaded")
    return DOWNLOAD_STATES.DOWNLOADED
  end
  local download_listeners = downloading_files[file_path]
  if download_listeners and next(download_listeners) ~= nil then
    return DOWNLOAD_STATES.DOWNLOADING
  else
    return DOWNLOAD_STATES.UNKNOWN
  end
end

function M.download(params, cb)
  local dest_file = params.dest
  local temp_file = params.dest .. temp_suffix
  local state = check_file_state(dest_file)
  
  local function add_download_listener(_dest_file, listener)
    downloading_files[_dest_file] = downloading_files[_dest_file] or {}
    local download_listeners = downloading_files[_dest_file]
    table.insert(download_listeners, listener)
  end
  
  if state == DOWNLOAD_STATES.DOWNLOADED then
    E.LOG.debug(TAG, "download check_file_state downloaded, return true directly")
    cb(true)
    return
  elseif state == DOWNLOAD_STATES.DOWNLOADING then
    E.LOG.debug(TAG, "download check_file_state downloading, add callback and return")
    add_download_listener(dest_file, cb)
    return
  else
    add_download_listener(dest_file, cb)
  end
  local stat_action = "res_download"
  local key = params.key or ""
  stat(stat_action, key)
  local down_params = {
    file = temp_file,
    checksum = params.checksum,
    timeout = params.timeout
  }
  if params.force_update then
    down_params.connectionTimeout = 5000
    down_params.dataRetrievalTimeout = 5000
  end
  
  local function download_result_callback(succ, ...)
    local listeners = downloading_files[dest_file] or {}
    for _, lis in ipairs(listeners) do
      lis(succ, ...)
    end
    downloading_files[dest_file] = nil
  end
  
  E.LOG.debug(TAG, "begin download:" .. tostring(params.url))
  E.HTTP.get(params.url, down_params, function(resp)
    local status = nil ~= resp and resp.status or CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RESPONSE_INVALID
    local succ = 200 == status
    local msg
    if succ then
      HRU.os_rename(temp_file, dest_file)
      msg = nil
    else
      if status == CONSTANTS.EJOYSDK_ERROR_CODES.RES_DOWNLOAD_MD5_MISMATCH then
        E.LOG.warn(TAG, "download failed, for download md5 mismatch, remove temp file:" .. tostring(temp_file))
        HRU.os_remove(temp_file)
      end
      msg = "download failed"
    end
    download_result_callback(succ, status, msg)
    if succ then
      stat(stat_action, key, true)
      E.LOG.debug(TAG, "download succ:" .. tostring(params.url))
    else
      stat(stat_action, key, false)
      E.LOG.debug(TAG, "download failed, msg:" .. tostring(msg) .. ", url:" .. tostring(params.url))
    end
  end)
end

function M.register_download_state_listener()
end

return M
