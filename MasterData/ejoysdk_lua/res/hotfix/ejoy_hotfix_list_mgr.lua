local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local ERF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local DM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local TAG = "QZ_RES_HOTFIX_FILE_MGR"
local M = Class:Inherit("EjoyQZHotfixResFileList")
local _instance = {}
M.QZ_HOTFIX_ORIGIN_RES_MAPPING = "qz_res_hotfix_res_mapping"
M.QZ_HOTFIX_RES_INDEX_MAPPING = "qz_res_hotfix_res_index_mapping.json"

function M.static_get_qz_hotfix_list(path)
  path = path or ""
  local instance = _instance[path]
  if not instance then
    instance = M:New(path)
    _instance[path] = instance
  end
  return instance
end

function M:_init(path)
  self.dest_path = path
  self.index_mapping = E.Path.join(path, M.QZ_HOTFIX_RES_INDEX_MAPPING)
  self.res_mapping = E.Path.join(path, M.QZ_HOTFIX_ORIGIN_RES_MAPPING)
  self.callbacks = {}
  self.fst_map = nil
end

local function _callback(self, succ, ...)
  for _, _cb in ipairs(self.callbacks) do
    _cb(succ, ...)
  end
  self.callbacks = {}
  self.down_task = nil
end

local function _check_support_fst()
  return _ejoysdk.fst ~= nil
end

local function _create_fst_index_mapping(res_mapping, index_mapping)
  do return setmetatable, {} end
  return setmetatable, {}, {
    __index = function(_t, key)
      E.LOG.d(TAG, "query " .. key)
      if UTILS.is_text_empty(key) then
        return nil
      end
      local _mapping = res_mapping[key]
      if _mapping then
        _mapping = E.Utils.split_string(_mapping, ",")
        local _res_list = {}
        for _, _index in ipairs(_mapping) do
          local _res_file = index_mapping[tonumber(_index)]
          if _res_file then
            table.insert(_res_list, _res_file)
          end
        end
        E.LOG.d(TAG, {res_list = _res_list})
        return _res_list
      end
      return nil
    end
  }, function(_t, key)
    E.LOG.d(TAG, "query " .. key)
    if UTILS.is_text_empty(key) then
      return nil
    end
    local _mapping = res_mapping[key]
    if _mapping then
      _mapping = E.Utils.split_string(_mapping, ",")
      local _res_list = {}
      for _, _index in ipairs(_mapping) do
        local _res_file = index_mapping[tonumber(_index)]
        if _res_file then
          table.insert(_res_list, _res_file)
        end
      end
      E.LOG.d(TAG, {res_list = _res_list})
      return _res_list
    end
    return nil
  end
end

local function _create_fst_from_file(self, res_file, index_file)
  local _fst_data = E.File.readfile_fullpath(res_file)
  local _succ, _fst_table = pcall(_ejoysdk.fst.load, _fst_data)
  local _res_table
  if true == _succ and _fst_table then
    E.LOG.d(TAG, "load fst table succ")
    if E.File.exists_fullpath(index_file) then
      _res_table = CJSON.safe_decode(E.File.readfile_fullpath(index_file))
      if _res_table then
        E.LOG.d(TAG, "load index json succ")
      end
    end
  else
    E.LOG.d(TAG, "load fst table fail")
  end
  if _fst_table and _res_table then
    self.fst_map = _create_fst_index_mapping(_fst_table, _res_table)
  end
  return self.fst_map
end

function M:get_file_list_if_exists()
  if self.fst_map then
    return self.fst_map
  elseif E.File.exists_fullpath(self.index_mapping) and E.File.exists_fullpath(self.res_mapping) then
    E.LOG.d(TAG, "file all ready")
    do return _create_fst_from_file, self, self.res_mapping end
    return _create_fst_from_file, self, self.res_mapping, self.index_mapping
  end
  return nil
end

function M:get_file_list(down_info, cb)
  E.LOG.d(TAG, {download_info = down_info})
  if false == _check_support_fst() then
    E.LOG.d(TAG, "not support fst")
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_NOT_SUPPORT, "not support fst")
    return
  end
  local _fst_map = self:get_file_list_if_exists()
  if _fst_map then
    cb(true, _fst_map)
  elseif type(down_info) ~= "table" or not down_info.base_url then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_FILE_ERROR, "no download info")
  elseif not self.down_task then
    table.insert(self.callbacks, cb)
    local http_res_model = ERF.get_http_res_multi_model()
    local file_ext = {
      base_url = down_info.base_url
    }
    local file_list = {}
    for _, _file in ipairs({
      M.QZ_HOTFIX_ORIGIN_RES_MAPPING,
      M.QZ_HOTFIX_RES_INDEX_MAPPING
    }) do
      local _file_info = down_info.file_list[_file]
      if _file_info then
        table.insert(file_list, {
          path = _file_info.name,
          name = _file,
          md5 = _file_info.md5,
          dest_path = self.dest_path
        })
      else
        cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_FILE_ERROR, "download_info error")
        return
      end
    end
    local opts = {
      storage_type = DM.STORAGE_TYPE.EXTERNAL_OTHER,
      enable_download_range = true
    }
    E.LOG.d(TAG, {download_list = file_list})
    local task, err_code, err_msg = http_res_model:create_task(file_list, file_ext, opts, function(_state, state_obj)
      if state_obj[DM.STATE_KEY.STATE_CHANGED] then
        if _state == DM.DOWNLOAD_STATE.COMPLETE then
          E.LOG.d(TAG, "download succ")
          self.fst_map = _create_fst_from_file(self, self.res_mapping, self.index_mapping)
          if self.fst_map then
            _callback(self, true, self.fst_map)
          else
            _callback(self, false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_EJOY_HOTFIX_FILE_ERROR, "load fst failed")
          end
        elseif _state == DM.DOWNLOAD_STATE.FAILED then
          E.LOG.d(TAG, "download fail")
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
      E.LOG.warn(TAG, "create task failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
      cb(false, err_code, err_msg)
    end
  else
    table.insert(self.callbacks, cb)
  end
end

return M
