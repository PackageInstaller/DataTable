local HDMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local DMT = require("ejoysdk_lua.res.model.http_download_multi_task")
local MODEL_NAME = "EjoyHttpDownloadMultiModelFacade"
local M = HDMM:Inherit(MODEL_NAME)
M.DOWNLOAD_STATE = DMT.DOWNLOAD_STATE
M.DOWNLOAD_ERROR_CODES = EC.DOWNLOAD_ERROR_CODES
M.STATE_KEY = DMT.STATE_KEY
M.PROGRESS_INFO_KEY = DMT.PROGRESS_INFO_KEY
M.LOG_LEVEL = ERB.INNER_LOG_LEVEL
M.DOWNLOAD_PRIORITY = DMT.DOWNLOAD_PRIORITY

function M:create_task(file_list, file_ext, opts, download_state_listener, download_progress_listener)
  do return self.create_task_impl, self, file_list, file_ext, opts, download_state_listener end
  return self.create_task_impl, self, file_list, file_ext, opts, download_state_listener, download_progress_listener
end

function M:update_download_config(config)
  self:update_download_config_impl(config)
end

function M:stop_download(tag_name, cb)
  self:stop_download_impl(tag_name, cb)
end

function M:remove_download_by_tag(tag_name, cb)
  self:remove_download_by_tag_impl(tag_name, cb)
end

function M:get_download_state_by_tag(tag_name)
  do return self.get_download_state_by_tag_impl, self end
  return self.get_download_state_by_tag_impl, self, tag_name
end

function M:pause_download(tag_name, cb)
  self:pause_download(tag_name, cb)
end

return M
