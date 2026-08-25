local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local M = Class:Inherit("EjoyQZResFileList")
local _instance = {}
local EHU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local ERF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local DM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = "QZ_RES_FILE_LIST_MGR"

function M.static_get_qz_file_list(path, file_name)
  path = path or ""
  file_name = file_name or ""
  local key_name = path .. "/" .. file_name
  local instance = _instance[key_name]
  if not instance then
    instance = M:New(path, file_name)
    _instance[key_name] = instance
  end
  return instance
end

function M:_init(path, file_name)
  self.dest_path = path
  self.file_name = file_name
  self.file_path = path .. "/" .. file_name
  self.callbacks = {}
end

local function _callback(self, succ, ...)
  for _, _cb in ipairs(self.callbacks) do
    _cb(succ, ...)
  end
  self.callbacks = {}
  self.down_task = nil
end

function M:get_file_list_if_exists()
  if type(self._file_content) == "table" and next(self._file_content) then
    return self.file_path, self._file_content
  elseif EHU.is_file_exists(self.file_path) then
    self._file_content = CJSON.safe_decode(E.File.readfile_fullpath(self.file_path))
    return self.file_path, self._file_content
  end
  return nil, nil
end

function M:get_file_list(down_info, cb)
  local _file_path, _file_content = self:get_file_list_if_exists()
  if type(_file_content) == "table" and next(_file_content) then
    cb(true, false, _file_path, _file_content)
  elseif type(down_info) ~= "table" or not down_info.url then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_FILE_LIST_EMPTY, "no download info")
  elseif not self.down_task then
    table.insert(self.callbacks, cb)
    local http_res_model = ERF.get_http_res_model()
    local url = down_info.url
    local md5 = down_info.md5
    local file_ext = {
      dest_path = self.dest_path,
      name = self.file_name,
      md5 = md5
    }
    local opts = {
      storage_type = DM.STORAGE_TYPE.EXTERNAL_OTHER,
      enable_download_range = true
    }
    local task, err_code, err_msg = http_res_model:create_task(url, file_ext, opts, function(_state, state_obj)
      if state_obj[DM.STATE_KEY.STATE_CHANGED] then
        if _state == DM.DOWNLOAD_STATE.COMPLETE then
          local file_path = state_obj[DM.STATE_KEY.FILE_PATH]
          self._file_content = CJSON.safe_decode(E.File.readfile_fullpath(self.file_path))
          E.LOG.d(TAG, "download succ:" .. file_path)
          _callback(self, true, true, self.file_path, self._file_content)
        elseif _state == DM.DOWNLOAD_STATE.FAILED then
          local err_code = state_obj[DM.STATE_KEY.ERR_CODE] or EC.RESOURCE_UPDATE_ERROR_CODES.RES_DOWNLOAD_FAILED_UNKNOWN
          local err_msg = state_obj[DM.STATE_KEY.ERR_MSG] or "download err"
          _callback(self, false, err_code, err_msg)
        end
      end
    end)
    if task then
      self.down_task = task
      task:start_download()
    else
      cb(false, err_code, err_msg)
    end
  else
    table.insert(self.callbacks, cb)
  end
end

return M
