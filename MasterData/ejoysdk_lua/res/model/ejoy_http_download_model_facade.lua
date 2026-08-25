local HDMI = require("ejoysdk_lua.res.model.ejoy_http_download_model")
local MODEL_NAME = "EjoyHttpDownloadModelFacade"
local M = HDMI:Inherit(MODEL_NAME)
M.DOWNLOAD_STATE = HDMI.DOWNLOAD_STATE
M.DOWNLOAD_CHECK_STATE = HDMI.DOWNLOAD_CHECK_STATE
M.DOWNLOAD_ERROR_CODES = HDMI.DOWNLOAD_ERROR_CODES
M.STATE_KEY = HDMI.STATE_KEY
M.PROGRESS_INFO_KEY = HDMI.PROGRESS_INFO_KEY
M.LOG_LEVEL = HDMI.LOG_LEVEL
M.TASK_INIT_PARAMS = HDMI.TASK_INIT_PARAMS
M.INIT_FILE_STATE_KEY = HDMI.INIT_FILE_STATE_KEY
M.FILE_DEST_INFO_KEY = HDMI.FILE_DEST_INFO_KEY

function M:create_task(_url, file_ext, opts, download_state_listener, download_progress_listener)
  do return self.create_task_impl, self, _url, file_ext, opts, download_state_listener end
  return self.create_task_impl, self, _url, file_ext, opts, download_state_listener, download_progress_listener
end

function M:create_task_with_init_params(_url, file_ext, opts, download_state_listener, download_progress_listener, init_check_params)
  do return self.create_task_with_init_params_impl, self, _url, file_ext, opts, download_state_listener, download_progress_listener end
  return self.create_task_with_init_params_impl, self, _url, file_ext, opts, download_state_listener, download_progress_listener, init_check_params
end

function M:update_download_config(config)
  do return self.update_download_config_impl, self end
  return self.update_download_config_impl, self, config
end

function M:stop_download(tag_name, cb)
  self:stop_download_impl(tag_name, cb)
end

function M:remove_download(url, _path, _name, _storage_type, cb)
  self:remove_download_impl(url, _path, _name, _storage_type, cb)
end

function M:remove_download_by_tag(tag_name, cb)
  self:remove_download_by_tag_impl(tag_name, cb)
end

function M:get_download_state(url, _path, _name, _storage_type)
  do return self.get_download_state_impl, self, url, _path, _name end
  return self.get_download_state_impl, self, url, _path, _name, _storage_type
end

function M:get_download_state_by_tag(tag_name)
  do return self.get_download_state_by_tag_impl, self end
  return self.get_download_state_by_tag_impl, self, tag_name
end

return M
