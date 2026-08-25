local Class = require("ejoysdk_lua.ejoysdk_class")
local DMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
local M = Class:Inherit("ResStateListener")
M.DOWNLOAD_STATE = DMM.DOWNLOAD_STATE
M.CONTROLLER_PARAMS = {
  MODEL_TYPE = "model_type",
  MODEL_NAME = "model_name",
  TASK_TAG_NAME = "task_tag"
}
M.CONTROLLER_LISTENER_NAMES = {
  LISTENER_SET_DOWNLOAD_SPEED = "set_download_speed_listener",
  LISTENER_GET_CUR_DOWNLOAD_SPEED = "get_cur_download_speed_listener",
  LISTENER_GET_CUR_DOWNLOAD_PROGRESS = "get_cur_download_progress_listener"
}
M.PROGRESS_INFO_KEY = {
  PERCENT = "download_progress",
  RECV_BYTES = "recv_bytes",
  TOTAL_BYTES = "total_bytes",
  DOWNLOAD_STATE = "state",
  SPEED = "speed"
}

function M.set_download_speed_limit(_speed)
end

function M.get_current_download_speed(_cb)
end

function M.get_current_download_progress(_cb)
end

function M.get_current_download_state(_cb)
end

function M.set_impl()
end

function M.get_ctrl_type()
end

function M.close()
end

return M
