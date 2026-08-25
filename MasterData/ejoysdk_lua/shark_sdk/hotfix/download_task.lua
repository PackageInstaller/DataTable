local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local ejoysdk_http = require("ejoysdk_lua.ejoysdk_http")
local ejoysdk_json = require("ejoysdk_lua.ejoysdk_json")
local ejoysdk = require("ejoysdk_lua.ejoysdk")
local M = {}
local TASK_STATUS = {
  IDLE = "idle",
  DOWNLOADING = "downloading",
  SUCCESS = "success",
  FAILED = "failed",
  DISPOSED = "disposed"
}

function M.create_task_with_raw_urls(urls, file_name, on_finish, on_error, dst_dir, tmp_dir)
  local task = {
    _urls = urls or {},
    _file_name = file_name,
    _on_finish = on_finish,
    _on_error = on_error,
    _dst_dir = dst_dir,
    _tmp_dir = tmp_dir,
    _status = TASK_STATUS.IDLE,
    _current_url_index = 0,
    _current_url = ""
  }
  
  function task:is_finish()
    return self._status == TASK_STATUS.SUCCESS or self._status == TASK_STATUS.FAILED or self._status == TASK_STATUS.DISPOSED
  end
  
  function task:get_url()
    return self._current_url
  end
  
  function task:cancel()
    if self:is_finish() then
      return
    end
    self._status = TASK_STATUS.DISPOSED
    logger.debug("task cancelled: %s", self._file_name)
    if self._on_error then
      self._on_error(self)
    end
  end
  
  function task:_try_next_url()
    self._current_url_index = self._current_url_index + 1
    if self._current_url_index > #self._urls then
      self._status = TASK_STATUS.FAILED
      logger.warn("all urls failed for %s", self._file_name)
      if self._on_error then
        self:_on_error(self._file_name)
      end
      return
    end
    self._current_url = self._urls[self._current_url_index]
    self._status = TASK_STATUS.DOWNLOADING
    local download_url = self._current_url
    local save_path = self._tmp_dir .. "/" .. self._file_name
    local params = {}
    ejoysdk_http.get(download_url, params, function(resp)
      if self._status == TASK_STATUS.DISPOSED then
        return
      end
      local status = tonumber(resp and resp.status)
      if status and status >= 200 and status < 300 then
        self._status = TASK_STATUS.SUCCESS
        logger.debug("download success: %s", self._file_name)
        local body = resp.body
        if type(body) == "table" then
          body = ejoysdk_json.encode(body)
        end
        local ok, err = xpcall(ejoysdk.File.writefile, function(err)
          logger.error("write file error: %s", tostring(err))
        end, save_path, body, false, false)
        if not ok then
          logger.error("write file failed: %s", tostring(err))
        end
        if self._on_finish then
          self._on_finish(self)
        end
      else
        logger.warn("download failed, status: %s url: %s", tostring(status), download_url)
        self:_try_next_url()
      end
    end)
  end
  
  function task:start()
    if self._status ~= TASK_STATUS.IDLE then
      return false
    end
    self:_try_next_url()
    return true
  end
  
  return task
end

return M
