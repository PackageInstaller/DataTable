local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.ODR .. "cloud_stat"
local M = {}
M.EVENT = {
  ODR_START_REQUEST_TAG = "odr_start_request_tag",
  ODR_CANCEL_REQUEST_TAG = "odr_cancel_request_tag",
  ODR_RESUME_REQUEST_TAG = "odr_resume_request_tag",
  ODR_PAUSE_REQUEST_TAG = "odr_pause_request_tag",
  ODR_REQUEST_TAG_SUCCESS = "odr_request_tag_success",
  ODR_NOTIFY_REQUEST_PROGRESS = "odr_notify_request_progress",
  ODR_REQUEST_TAG_ERROR = "odr_request_tag_error",
  ODR_SET_DOWNLOAD_PRIORITY = "odr_set_download_priority",
  ODR_ACCESS_TAG_RES = "odr_access_tag_res",
  ODR_END_ACCESS_TAG_RES = "odr_end_access_tag_res",
  ODR_ACCESS_TAG_ERROR = "odr_access_tag_error"
}
local reported_percent = {}

function M.stat_download_progress(tag, progress)
  local current_percent = math.floor(progress * 10) * 10
  local last_reported_percent = reported_percent[tag] or 0
  E.LOG.debug(TAG, "download progress >> " .. tostring(progress) .. ", current percent >> " .. tostring(current_percent) .. ", last_reported_percent >> " .. tostring(last_reported_percent))
  if current_percent > last_reported_percent then
    E.LOG.debug(TAG, "report ODR_REQUEST_TAG_SUCCESS")
    reported_percent[tag] = current_percent
    local stat_params = {is_priority_high = true, duration = current_percent}
    M.stat_action(M.EVENT.ODR_NOTIFY_REQUEST_PROGRESS, tag, true, stat_params)
  end
end

function M.stat_error(error_type, tag, code, message)
  E.LOG.debug(TAG, "stat demand error >> tag:" .. tostring(tag) .. ", code:" .. tostring(code) .. ", message:" .. tostring(message))
  local stat_params = {
    is_priority_high = true,
    sub_params_code = code,
    sub_params_message = message
  }
  ESTAT.stat_action(error_type, tag, false, stat_params)
end

function M.stat_action(action, action_type, result, params)
  local stat_params = params or {}
  stat_params.is_priority_high = true
  ESTAT.stat_action(action, action_type, result, stat_params)
end

return M
