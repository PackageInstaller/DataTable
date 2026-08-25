local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local OSS_API = require("ejoysdk_lua.ejoysdk_oss")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local log_collector_api = BASE_API:New("log-collector")
local TAG = "server_api#log_collector_ex"
local M = {}
M.MAX_SIZE = 52428800
M.INPUT_TYPE = OSS_API.INPUT_TYPE

function M.apply_oss_policy(cb)
  local headers = {}
  local opt = {}
  local req_body = {
    support_sign_version = OSS_API.SUPPORT_SIGN_VERSION
  }
  log_collector_api:post("/client_api/apply_oss_policy", headers, req_body, opt, function(succ, ...)
    if succ then
      local resp = (...)
      cb(true, resp.data)
    else
      E.LOG.debug(TAG, "apply_oss_policy request fail")
      cb(false, ...)
    end
  end)
end

function M.upload_file_to_oss(input_file, input_type, media_type, oss_params, cb)
  OSS_API.upload_file(input_file, input_type, media_type, oss_params, cb)
end

function M.commit(params, cb)
  local body = params or {}
  local opt = {}
  log_collector_api:post("/client_api/commit", {}, body, opt, function(succ, ...)
    if succ then
      if cb then
        cb(true, ...)
      end
    elseif cb then
      cb(false, ...)
    end
  end)
end

function M.upload_and_commit(ext_params, input_file, input_type, media_type, cb)
  M.apply_oss_policy(function(succ, ...)
    if not succ then
      cb(false, ...)
      return
    end
    local oss_params = (...)
    local ticket_id = oss_params and oss_params.ticket_id
    if not ticket_id then
      cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, "upload fail, oss_policy return nil or ticket_id is nil")
      return
    end
    M.upload_file_to_oss(input_file, input_type, media_type, oss_params, function(oss_succ, ...)
      if not oss_succ then
        cb(false, ...)
        return
      end
      local GDP = require("ejoysdk_lua.gangplank_data_provider")
      local player_id = GDP.PLAYER_INFO.get("player_id")
      local device_id = E.Sysinfo.utdid()
      local commit_params = {
        device_id = device_id,
        ext = ext_params or {},
        player_id = player_id,
        ticket_id = oss_params.ticket_id
      }
      M.commit(commit_params, function(commit_suc, ...)
        if commit_suc then
          local commit_result = (...)
          E.LOG.debug(TAG, commit_result)
          cb(true, commit_result)
        else
          cb(false, ...)
        end
      end)
    end)
  end)
end

function M.upload_client_log(file_path_name, params, cb)
  local err_tips
  if not E.Utils.end_with(file_path_name, ".zip") then
    err_tips = string.format("file_path_name is not a zip file, file_path_name = '%s'", file_path_name)
    E.LOG.error(TAG, err_tips)
    cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, err_tips)
    return
  end
  local data
  if E.Sysinfo.os() == "ios" then
    data = E.sync_call("read_file", file_path_name)
  else
    data = _ejoysdk.lread(file_path_name)
  end
  if not data then
    err_tips = string.format("file no found. file_path_name = '%s'", file_path_name)
    E.LOG.error(TAG, err_tips)
    cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, err_tips)
    return
  end
  E.LOG.debug(TAG, "file length:" .. tostring(#data) .. ", max length:" .. tostring(M.MAX_SIZE))
  if #data > M.MAX_SIZE then
    err_tips = "file too large. must less than " .. tostring(M.MAX_SIZE / 1048576) .. "M"
    E.LOG.error(TAG, err_tips)
    cb(false, CONSTANTS.OSS_ERROR.CODE_UPLOAD_FAIL, err_tips)
    return
  end
  M.upload_and_commit(params, data, M.INPUT_TYPE.DATA, "application/octet-stream", cb)
end

return M
