local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local M = Class:Inherit("EjoyLocalFileList")
local _instance = {}
local TAG = "ejoy_local_file_list"
M.UPDATE_FILE_TYPE = {REMOVE = "remove", UPDATE = "update"}

local function _get_key(path, is_in_pkg, file_name)
  return (true == is_in_pkg and "pkg_" or "data_") .. path .. (file_name or "")
end

function M.static_get_file_list(path, is_in_pkg, file_name)
  path = path or ""
  local key_name = _get_key(path, is_in_pkg, file_name)
  local instance = _instance[key_name]
  if not instance then
    instance = M:New(path, is_in_pkg, file_name)
    _instance[key_name] = instance
  end
  return instance
end

function M.reset_file_list_cache()
  E.LOG.debug(TAG, "reset_file_list_cache received")
  _instance = {}
end

function M:_init(path, is_in_pkg, file_name)
  local file_list_full_path = file_name or RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST
  if not UTIL.is_text_empty(path) then
    file_list_full_path = E.Path.join(path, file_name or RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST)
  end
  E.LOG.d("QZ_RES_HOTFIX", "local_file_list = " .. tostring(file_list_full_path))
  local file_content
  if is_in_pkg and E.Sysinfo.os() == "ios" then
    file_content = JSON.decode(E.File.readfile(file_list_full_path, true))
  else
    file_content = JSON.decode(E.File.readfile_fullpath(file_list_full_path))
  end
  self._data = {
    _is_in_pkg = is_in_pkg,
    _path = path,
    _file_name = file_name,
    _full_path = file_list_full_path,
    _exists = nil ~= file_content and type(file_content) == "table",
    _content = file_content or {}
  }
end

function M:get_path()
  return self._data._path
end

function M:exists()
  return self._data._exists == true
end

function M:remove_record(file_name, save)
  local full_path = E.Path.join(self._data._path, file_name)
  if self._data._is_in_pkg == false then
    self._data._content[file_name] = nil
    if true == save then
      self:save()
    end
    return true, full_path
  end
  return false
end

function M:remove_file(file_name, save)
  local _moved, _path = self:remove_record(file_name, save)
  if _moved then
    E.File.remove_fullpath(_path)
  end
end

function M:update_file(file_name, md5, size, save)
  if self._data._is_in_pkg == false then
    local metadata = self._data._content[file_name] or {}
    metadata.md5 = md5
    if size then
      metadata.size = size
    end
    if not self._data._content[file_name] then
      self._data._content[file_name] = metadata
    end
    if true == save then
      self:save()
    end
  end
end

function M:add_file(file_name, md5, size, save)
  self:update_file(file_name, md5, size, save)
end

function M:get_info(file_name)
  return self._data._content[file_name]
end

function M:get_file_list()
  do return UTIL.deepcopy end
  return UTIL.deepcopy, self._data._content
end

function M:get_size()
  do return UTIL.tablelength end
  return UTIL.tablelength, self._data._content
end

function M:get_file_name_list()
  local _file_name_list = {}
  for _name, _ in pairs(self._data._content) do
    table.insert(_file_name_list, _name)
  end
  return _file_name_list
end

function M:update_file_list(list)
  if not list then
    return
  end
  local res_file_list_str = list
  if type(list) == "string" then
    res_file_list_str = JSON.decode(list) or {}
  end
  self._data._content = res_file_list_str
  self:save()
end

function M:update_file_items(item_list, update_type, cb)
  if not item_list or not next(item_list) then
    cb(false, EC.EJOYSDK_ERROR_CODES.PARAMS_INVALID, "file_list is empty")
    return
  end
  if update_type == M.UPDATE_FILE_TYPE.REMOVE then
    for _index, file_name in pairs(item_list) do
      self._data._content[file_name] = nil
    end
    self:save()
    cb(true)
    return
  end
  E.File.process_batch_info(item_list, function(ret)
    local _update_file_info_list = {}
    local _exists_file_list = {}
    for file_name, file_info in pairs(ret) do
      if file_info.exists ~= true then
        self:remove_file(file_name)
      else
        table.insert(_exists_file_list, file_name)
        _update_file_info_list[file_name] = file_info
      end
    end
    if next(_update_file_info_list) then
      E.File.process_batch_md5(_exists_file_list, function(succ3, ...)
        local succ_data, _fail_data
        if succ3 then
          succ_data = (...)
        else
          local _code, _msg, s_data, f_data = ...
          succ_data = s_data
          _fail_data = f_data
        end
        for file_name, file_info in pairs(_update_file_info_list) do
          self:update_file(file_name, succ_data[file_name], file_info.size, false)
        end
        self:save()
        cb(true)
      end, self._data._path)
    else
      self:save()
      cb(true)
    end
  end, {
    is_full_path = false,
    base_path = self._data._path,
    check_size = true
  })
end

function M:save()
  if self._data._is_in_pkg == false then
    local res_file_list_str = JSON.encode(self._data._content or {}) or ""
    E.File.writefile_fullpath(self._data._full_path, res_file_list_str, false)
  end
end

function M:delete()
  self._data._content = {}
  local key = _get_key(self._data._path, self._data._is_in_pkg, self._data._file_name)
  if _instance[key] then
    _instance[key] = nil
  end
  E.File.remove_fullpath(self._data._full_path)
end

return M
