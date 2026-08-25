local DT = require("ejoysdk_lua.res.model.http_download_task")
local M = DT:Inherit("EjoyHttpDownloadTaskFacade")
M.DOWNLOAD_STATE = DT.DOWNLOAD_STATE
M.DOWNLOAD_CHECK_STATE = DT.DOWNLOAD_CHECK_STATE
M.INNER_LOG_LEVEL = DT.INNER_LOG_LEVEL
M.STATE_KEY = DT.STATE_KEY
M.PROGRESS_INFO_KEY = DT.PROGRESS_INFO_KEY
M.RANGE_INFO_KEY = DT.RANGE_INFO_KEY
M.TASK_INIT_PARAMS = DT.TASK_INIT_PARAMS
M.FILE_DEST_INFO_KEY = DT.FILE_DEST_INFO_KEY
M.DOWNLOADING_FILE_SUFFIX = DT.DOWNLOADING_FILE_SUFFIX
M.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS = DT.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS
M.CHCKED_FILE_STATE_KEY = DT.CHCKED_FILE_STATE_KEY

function M.static_get_download_temp_file_path(model_instance, dest_file_dir, name)
  do return DT.static_get_download_temp_file_path, model_instance, dest_file_dir end
  return DT.static_get_download_temp_file_path, model_instance, dest_file_dir, name
end

function M:start_download()
  self:start_download_impl()
end

function M:reset_download()
  self:reset_download_impl()
end

function M:stop_download(cb)
  self:stop_download_impl(cb)
end

function M:remove_download(cb)
  self:remove_download_impl(cb)
end

function M:get_download_state(no_copy)
  do return self.get_download_state_impl, self end
  return self.get_download_state_impl, self, no_copy
end

function M:task_id()
  do return self.task_id_impl end
  return self.task_id_impl, self
end

function M:task_tag_name()
  do return self.task_tag_name_impl end
  return self.task_tag_name_impl, self
end

function M:task_info()
  do return self.task_info_impl end
  return self.task_info_impl, self
end

function M:is_downloading()
  do return self.is_downloading_impl end
  return self.is_downloading_impl, self
end

function M:get_download_properties()
  do return self.get_download_properties_impl end
  return self.get_download_properties_impl, self
end

function M:update_download_properties(properties)
  self:update_download_properties_impl(properties)
end

return M
