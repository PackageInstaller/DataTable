local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local M = Class:Inherit("EjoyLocalFileList")
local _instance = {}
local TAG = "ejoy_local_file_list"

function M.static_get_file_list(path, is_in_pkg)
  path = path or ""
  local key_name = (true == is_in_pkg and "pkg_" or "data_") .. path
  local instance = _instance[key_name]
  if not instance then
    instance = M:New(path, is_in_pkg)
    _instance[key_name] = instance
  end
  return instance
end

function M.reset_file_list_cache()
  E.LOG.debug(TAG, "reset_file_list_cache received")
  _instance = {}
end

function M:_init(path, is_in_pkg)
  local file_list_full_path = RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST
  if not UTIL.is_text_empty(path) then
    file_list_full_path = E.Path.join(path, RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST)
  end
  local file_content
  if is_in_pkg and E.Sysinfo.os() == "ios" then
    file_content = JSON.decode(E.File.readfile(file_list_full_path, true))
  else
    file_content = JSON.decode(E.File.readfile_fullpath(file_list_full_path))
  end
  self._data = {
    _is_in_pkg = is_in_pkg,
    _path = path,
    _full_path = file_list_full_path,
    _exists = nil ~= file_content and type(file_content) == "table",
    _content = file_content or {}
  }
end

function M:exists()
  return self._data._exists == true
end

function M:remove_file(file_name, save)
  local full_path = E.Path.join(self._data._path, file_name)
  if self._data._is_in_pkg == false then
    E.File.remove_fullpath(full_path)
    self._data._content[file_name] = nil
    if true == save then
      self:save()
    end
  end
end

function M:update_file(file_name, md5, save)
  if self._data._is_in_pkg == false then
    local metadata = self._data._content[file_name] or {}
    metadata.md5 = md5
    if not self._data._content[file_name] then
      self._data._content[file_name] = metadata
    end
    if true == save then
      self:save()
    end
  end
end

function M:add_file(file_name, md5, save)
  self:update_file(file_name, md5, save)
end

function M:get_info(file_name)
  return self._data._content[file_name]
end

function M:get_file_list()
  do return UTIL.deepcopy end
  return UTIL.deepcopy, self._data._content
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

function M:save()
  if self._data._is_in_pkg == false then
    local res_file_list_str = JSON.encode(self._data._content or {}) or ""
    E.File.writefile_fullpath(self._data._full_path, res_file_list_str, false)
  end
end

return M
