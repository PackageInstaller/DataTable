local RSA = require("ejoysdk_lua.res.model.src_adapters.res_source_adapter")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
local NUM = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local EHU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local ERF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local E = require("ejoysdk_lua.ejoysdk")
local DM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local HDT = require("ejoysdk_lua.res.model.http_download_task")
local FP = require("ejoysdk_lua.res.qz_file_list_parser")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local SU = require("ejoysdk_lua.res.startup.startup_utils")
local unpack = unpack or table.unpack
local ADAPTER_NAME = "ejoy_res_source"
local M = RSA:Inherit(ADAPTER_NAME)
local TAG = ADAPTER_NAME
M.UPDATE_INFO_FILE_LIST_TYPE = RTM.FILE_LIST_TYPE
local FILE_NAME_LIST_JSON = "ejoy_qz_resource_file_list.json"
local FILE_LIST_DESC_JSON = "ejoy_qz_resource_file_list_desc.json"
local FILE_NAME_INFO_LIST_JSON = "ejoy_qz_resource_file_info_list.json"
M.RES_FILE_LIST_CACHE_KEY = {
  FILE_NAME_LIST_JSON = FILE_NAME_LIST_JSON,
  FILE_LIST_DESC_JSON = FILE_LIST_DESC_JSON,
  FILE_NAME_INFO_LIST_JSON = FILE_NAME_INFO_LIST_JSON
}
local FILE_LIST_MAX_RETRY_TIME = 3
local app_ext_file_dir

function M:_init(_model_name, _namespace, _res_key, _opts)
  _opts = _opts or {}
  self._data = {
    model_name = _model_name,
    namespace = _namespace,
    res_key = _res_key,
    res_save_storage_type = RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE,
    opts = _opts,
    qz_origin_list_cache_info = {
      version = nil,
      list_info = nil,
      ext_info = nil
    }
  }
  if type(_opts[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]) == "string" then
    self._data.res_save_storage_type = _opts[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]
    E.LOG.debug(TAG, "update_config storage type:" .. tostring(self._data.res_save_storage_type))
  end
end

local function get_app_ext_file_dir()
  if not app_ext_file_dir then
    app_ext_file_dir = E.File.get_ext_file_dir()
  end
  return app_ext_file_dir
end

local function get_res_dest_full_path(namespace, res_key, ext)
  local ns_res_key_path_base = RTM.static_get_res_path(namespace, res_key)
  local download_dir
  local storage_type = ext and ext[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] or nil
  if storage_type and storage_type == RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE and E.Sysinfo.os() == "android" then
    local storage_type_path_base = ERB.static_get_storage_path_by_type(storage_type)
    download_dir = E.Utils.trim_end(storage_type_path_base, "/")
    download_dir = download_dir .. "/files"
  end
  if not download_dir or "" == download_dir then
    download_dir = get_app_ext_file_dir()
  end
  local _dest_path = download_dir .. "/" .. ns_res_key_path_base
  return _dest_path
end

local function get_res_version_dest_full_path(namespace, res_key, version, ext)
  local res_full_path = get_res_dest_full_path(namespace, res_key, ext)
  return res_full_path .. tostring(version)
end

function M.static_get_res_version_path(namespace, res_key, version, ext)
  do return get_res_version_dest_full_path, namespace, res_key, version end
  return get_res_version_dest_full_path, namespace, res_key, version, ext
end

function M.static_get_res_path(namespace, res_key, ext)
  do return get_res_dest_full_path, namespace, res_key end
  return get_res_dest_full_path, namespace, res_key, ext
end

function M.static_get_res_cache_version_path(namespace, res_key, version, ext)
  local res_full_path = get_res_dest_full_path(namespace, res_key, ext)
  return res_full_path .. tostring("cache") .. "/" .. tostring(version)
end

function M.static_get_res_cache_path(namespace, res_key, ext)
  local res_full_path = get_res_dest_full_path(namespace, res_key, ext)
  return res_full_path .. tostring("cache")
end

function M.static_remove_res_cache_files(namespace, res_key, version, ext)
  local res_full_path
  if version then
    res_full_path = M.static_get_res_cache_version_path(namespace, res_key, version, ext)
  else
    res_full_path = M.static_get_res_cache_path(namespace, res_key, ext)
  end
  if E.Sysinfo.os() ~= "windows" or E.is_support_function(EC.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION) then
    local rm_result = E.File.remove_fullpath(res_full_path)
    E.LOG.debug(TAG, "remove res cache files, result is " .. tostring(rm_result) .. ", path is " .. tostring(res_full_path))
  else
    E.LOG.debug(TAG, "remove res cache files fail, because windows not support delete dir, should update pc native sdk")
  end
end

function M.static_get_index_file_cache_path(namespace, res_key, version, local_version, ext)
  local res_version_cache_path = M.static_get_res_cache_version_path(namespace, res_key, version, ext)
  local index_file_cache_path
  if local_version then
    index_file_cache_path = res_version_cache_path .. "/" .. tostring(local_version) .. "/" .. "index_file"
  else
    index_file_cache_path = res_version_cache_path .. "/" .. "index_file"
  end
  return index_file_cache_path
end

function M.static_get_file_info_list_cache(namespace, res_key, version, local_version, ext)
  local file_path = M.static_get_index_file_cache_path(namespace, res_key, version, local_version, ext) .. "/" .. FILE_NAME_INFO_LIST_JSON
  local list_content = E.File.readfile_fullpath(file_path)
  local file_list_obj = CJSON.decode(list_content) or {}
  return file_list_obj
end

local function get_file_list_json_path(namespace, res_key, version, ext)
  local _dest_path = get_res_version_dest_full_path(namespace, res_key, version, ext)
  local file_list_path = _dest_path .. "/" .. FILE_NAME_LIST_JSON
  local file_list_desc_path = _dest_path .. "/" .. FILE_LIST_DESC_JSON
  return file_list_path, file_list_desc_path
end

function M:_get_file_list_json_path(version)
  local _dest_path = self:get_res_version_path(version)
  local file_list_path = _dest_path .. "/" .. FILE_NAME_LIST_JSON
  local file_list_desc_path = _dest_path .. "/" .. FILE_LIST_DESC_JSON
  return file_list_path, file_list_desc_path
end

function M.is_res_exists(res_location)
  if not res_location then
    return false
  end
  res_location = E.Utils.trim_end(res_location, "/")
  local exists = EHU.is_file_exists(res_location .. "/" .. FILE_LIST_DESC_JSON)
  E.LOG.debug(TAG, "is_res_exists: " .. tostring(exists) .. ", res_location:" .. tostring(res_location))
  return exists
end

local function load_local_file_list_content(namespace, res_key, version, local_version, ext)
  local file_list_json_path, list_desc_json = get_file_list_json_path(namespace, res_key, version, ext)
  if EHU.is_file_exists(file_list_json_path) then
    EL.LOG.debug(TAG, "load_local_file_list_content:" .. tostring(file_list_json_path))
    local file_list_content = EHU.read_file(file_list_json_path)
    file_list_content = file_list_content or ""
    FP.parse_file_list(namespace, res_key, local_version, version, file_list_content)
    local file_list_obj = FP.get_file_list(namespace, res_key, local_version, version)
    local file_list_desc_obj
    if EHU.is_file_exists(list_desc_json) then
      EL.LOG.debug(TAG, "list_desc_json exists:" .. tostring(list_desc_json))
      local file_list_desc_content = EHU.read_file(list_desc_json)
      file_list_desc_content = file_list_desc_content or ""
      file_list_desc_obj = CJSON.decode(file_list_desc_content)
      return file_list_obj, file_list_desc_obj
    else
      EL.LOG.warn(TAG, "load_local_file_list_content not has list desc, so return nil and redownload")
      return nil
    end
  else
    EL.LOG.warn(TAG, "load_local_file_list_content, not exists:" .. tostring(file_list_json_path))
    return nil
  end
end

function M._load_local_file_list_content(namespace, res_key, version, local_version, ext)
  do return load_local_file_list_content, namespace, res_key, version, local_version end
  return load_local_file_list_content, namespace, res_key, version, local_version, ext
end

local function _load_group_res_file_list_content(namespace, res_key, version, local_version, ext)
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local real_res_key = GRM.get_real_res_key(res_key)
  local index_info_file_cache_path = E.Path.join(M.static_get_index_file_cache_path(namespace, real_res_key, version, local_version, ext), FILE_NAME_LIST_JSON)
  if E.File.exists_fullpath(index_info_file_cache_path) then
    EL.LOG.debug(TAG, "_load_group_res_file_list_content, path: " .. tostring(index_info_file_cache_path))
    local file_list_content = E.File.readfile_fullpath(index_info_file_cache_path)
    FP.parse_file_list(namespace, res_key, local_version, version, file_list_content)
    local file_list_obj = FP.get_file_list(namespace, res_key, local_version, version)
    return file_list_obj
  end
  EL.LOG.warn(TAG, "_load_group_res_file_list_content, not exists: " .. tostring(index_info_file_cache_path))
  return nil
end

local function load_index_info_file_content(namespace, res_key, index_info_file_url, index_info_file_md5, target_version, local_version, file_info_list_cb, ext)
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local real_res_key = GRM.get_real_res_key(res_key)
  
  local function index_info_file_handler(index_info_file_path)
    local list_content = E.File.readfile_fullpath(index_info_file_path)
    EL.LOG.debug(TAG, "load_index_info_file_content succ:" .. tostring(index_info_file_path) .. ", exists:" .. tostring(E.File.exists_fullpath(index_info_file_path)))
    local file_list_obj = CJSON.decode(list_content)
    file_info_list_cb(true, file_list_obj)
  end
  
  local index_info_file_cache_path = E.Path.join(M.static_get_index_file_cache_path(namespace, real_res_key, target_version, local_version, ext), FILE_NAME_INFO_LIST_JSON)
  if E.File.exists_fullpath(index_info_file_cache_path) then
    EL.LOG.debug(TAG, "reuse index info file, path is " .. tostring(index_info_file_cache_path))
    index_info_file_handler(index_info_file_cache_path)
  else
    local cache_index_file_dest_dir = E.Path.parent_dir(index_info_file_cache_path)
    local file_ext = {
      dest_path = cache_index_file_dest_dir,
      name = FILE_NAME_INFO_LIST_JSON,
      md5 = index_info_file_md5
    }
    local opts = {
      storage_type = DM.STORAGE_TYPE.EXTERNAL_OTHER,
      enable_download_range = true
    }
    local http_res_model = ERF.get_http_res_model()
    local task, err_code, err_msg = http_res_model:create_task(index_info_file_url, file_ext, opts, function(_state, state_obj)
      if state_obj[DM.STATE_KEY.STATE_CHANGED] then
        if _state == DM.DOWNLOAD_STATE.COMPLETE then
          local file_path = state_obj[DM.STATE_KEY.FILE_PATH]
          if E.Sysinfo.os() == "android" and not E.Utils.start_with(file_path, "/") then
            file_path = "/" .. file_path
          end
          if file_path ~= index_info_file_cache_path then
            E.File.copy_fullpath(file_path, index_info_file_cache_path)
          end
          EL.LOG.debug(TAG, "cache index info file: " .. tostring(index_info_file_cache_path) .. ", succ:" .. tostring(E.File.exists_fullpath(index_info_file_cache_path)))
          index_info_file_handler(file_path)
        elseif _state == DM.DOWNLOAD_STATE.FAILED then
          local err_code = state_obj[DM.STATE_KEY.ERR_CODE] or EC.RESOURCE_UPDATE_ERROR_CODES.RES_DOWNLOAD_FAILED_UNKNOWN
          local err_msg = state_obj[DM.STATE_KEY.ERR_MSG] or "download err"
          EL.LOG.warn(TAG, "load_index_info_file_content failed， url:" .. tostring(index_info_file_url))
          file_info_list_cb(false, err_code, err_msg)
        end
      end
    end)
    if task then
      task:start_download()
    else
      EL.LOG.warn(TAG, "create task failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
      file_info_list_cb(false, err_code, err_msg)
    end
  end
end

function M:_load_index_file_content(index_file_url, index_file_md5, target_version, local_version, file_list_cb, is_total_file_list)
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local ext = self._data.opts
  local local_file_list_content, list_desc_json = M._load_local_file_list_content(namespace, res_key, target_version, local_version, ext)
  if local_file_list_content then
    if type(list_desc_json) == "table" and list_desc_json.md5 then
      local md5_equals = index_file_md5 == list_desc_json.md5
      EL.LOG.debug(TAG, "_load_local_file_list_content check md5, local:" .. tostring(list_desc_json.md5) .. ", new:" .. tostring(index_file_md5) .. ", ver:" .. tostring(target_version) .. ", equals:" .. tostring(md5_equals))
      if md5_equals then
        file_list_cb(true, local_file_list_content)
        return
      else
        local list_path = self:_get_file_list_json_path(target_version)
        local list_path_bak = list_path .. "_bak"
        EHU.os_remove(list_path_bak)
        EHU.os_rename(list_path, list_path_bak)
        FP.remove_cache(namespace, res_key, local_version, target_version)
      end
    else
      EL.LOG.debug(TAG, "_load_local_file_list_content check not has md5, now directly return list content")
      file_list_cb(true, local_file_list_content)
      return
    end
  end
  local _dest_path = get_res_version_dest_full_path(namespace, res_key, target_version, ext)
  local file_ext = {
    dest_path = _dest_path,
    name = FILE_NAME_LIST_JSON,
    md5 = index_file_md5
  }
  local opts = {
    storage_type = DM.STORAGE_TYPE.EXTERNAL_OTHER,
    enable_download_range = true
  }
  
  local function index_file_handler(index_file_path)
    local list_content = EHU.read_file(index_file_path)
    EL.LOG.debug(TAG, "load_index_file_content succ:" .. tostring(index_file_path) .. ", exists:" .. tostring(EHU.is_file_exists(index_file_path)))
    FP.parse_file_list(namespace, res_key, local_version, target_version, list_content)
    local file_list_obj = FP.get_file_list(namespace, res_key, local_version, target_version, is_total_file_list) or {}
    file_list_cb(true, file_list_obj, local_file_list_content)
  end
  
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local real_res_key = GRM.get_real_res_key(res_key)
  local index_file_cache_path = M.static_get_index_file_cache_path(namespace, real_res_key, target_version, local_version, ext) .. "/" .. FILE_NAME_LIST_JSON
  if EHU.is_file_exists(index_file_cache_path) then
    EL.LOG.debug(TAG, "reuse index file, path is " .. tostring(index_file_cache_path))
    index_file_handler(index_file_cache_path)
  else
    local http_res_model = ERF.get_http_res_model()
    local task, err_code, err_msg = http_res_model:create_task(index_file_url, file_ext, opts, function(_state, state_obj)
      if state_obj[DM.STATE_KEY.STATE_CHANGED] then
        if _state == DM.DOWNLOAD_STATE.COMPLETE then
          local file_list_desc_info = {md5 = index_file_md5, type = "sdk"}
          local desc_info_str = CJSON.encode(file_list_desc_info)
          self:write_to_res_version_file(target_version, desc_info_str, FILE_LIST_DESC_JSON)
          local file_path = state_obj[DM.STATE_KEY.FILE_PATH]
          if E.Sysinfo.os() == "android" and not E.Utils.start_with(file_path, "/") then
            file_path = "/" .. file_path
          end
          E.File.copy_fullpath(file_path, index_file_cache_path)
          EL.LOG.debug(TAG, "cache index file: " .. tostring(index_file_cache_path) .. ", succ:" .. tostring(EHU.is_file_exists(index_file_cache_path)))
          index_file_handler(file_path)
        elseif _state == DM.DOWNLOAD_STATE.FAILED then
          local err_code = state_obj[DM.STATE_KEY.ERR_CODE] or EC.RESOURCE_UPDATE_ERROR_CODES.RES_DOWNLOAD_FAILED_UNKNOWN
          local err_msg = state_obj[DM.STATE_KEY.ERR_MSG] or "download err"
          EL.LOG.warn(TAG, "load_index_file_content failed， url:" .. tostring(index_file_url))
          file_list_cb(false, err_code, err_msg)
        end
      end
    end)
    if task then
      task:start_download()
    else
      EL.LOG.warn(TAG, "create task failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
      file_list_cb(false, err_code, err_msg)
    end
  end
end

local function get_file_item_to_path(item)
  return item[RTM.FILE_LIST_ITEM_KEY.KEY_TO] or item[RTM.FILE_LIST_ITEM_KEY.KEY_FROM]
end

function M:_process_pending_download_file_list(index_file_list, _bak_old_file_list, update_info, last_downloading_info, is_custom_file_list, custom_file_desc, cb)
  local update_res_version = update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  last_downloading_info = last_downloading_info or {}
  local last_downloading_version = last_downloading_info[RTM.RES_STATE_INFO_KEY.VERSION_NAME]
  local last_downloading_state = last_downloading_info[RTM.RES_STATE_INFO_KEY.STATE]
  local last_downloading_save_location = last_downloading_info[RTM.RES_STATE_INFO_KEY.RES_LOCATION]
  last_downloading_save_location = E.Utils.trim_end(last_downloading_save_location, "/")
  E.LOG.debug(TAG, "process_pending_download_file_list last_downloading_info >>")
  E.LOG.debug(TAG, "process_pending_download_file_list file_list >>")
  local downloading_size = 0
  local finish_count = 0
  local total_count = #index_file_list
  local total_size
  if 0 == total_count then
    EL.LOG.warn(TAG, "index file list total count is 0")
    cb({}, 0, 0, 0, 0)
    return
  end
  if is_custom_file_list then
    custom_file_desc = custom_file_desc or {}
    total_size = custom_file_desc[RTM.RES_CONFIG_KEY.KEY_TOTAL_SIZE] or 0
    if 0 == total_size then
      for _, item in ipairs(index_file_list) do
        total_size = total_size + (item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] or 0)
      end
    end
    EL.LOG.debug(TAG, "_process_pending_download_file_list, its custom list, total_size:" .. tostring(total_size) .. ", total_count:" .. tostring(total_count))
  else
    total_size = update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] or 0
  end
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local ext = self._data.opts
  local item_has_size = index_file_list[1][RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] ~= nil
  local need_check_size = not item_has_size
  if 0 ~= EU.version_compare(last_downloading_version, update_res_version) then
    local function process_cb(_pending_download_list, _downloading_size, _total_size, _finish_count, _total_count)
      if last_downloading_version and last_downloading_state ~= RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
        EL.LOG.debug(TAG, "last download state is not complete, should delete here")
        
        M.static_remove_downloading_version(namespace, res_key, last_downloading_version, ext)
      else
        EL.LOG.debug(TAG, "last download state is complete or last_downloading_version is nil, should not delete here")
      end
      cb(_pending_download_list, _downloading_size, _total_size, _finish_count, _total_count)
    end
    
    EL.LOG.debug(TAG, "process_pending_download_file_list downloading_version smaller than update version, downloading ver:" .. tostring(last_downloading_version) .. ", update ver:" .. tostring(update_res_version))
    local update_file_list_type = update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE] or RTM.FILE_LIST_TYPE.UNKNOWN
    local last_downloading_file_list_type = last_downloading_info and last_downloading_info[RTM.RES_STATE_INFO_KEY.FILE_LIST_TYPE] or RTM.FILE_LIST_TYPE.UNKNOWN
    local file_list_type_valid_map = {
      [RTM.FILE_LIST_TYPE.UNKNOWN] = false,
      [RTM.FILE_LIST_TYPE.PATCH] = true,
      [RTM.FILE_LIST_TYPE.ORIGIN] = true
    }
    local is_last_file_list_type_valid = file_list_type_valid_map[last_downloading_file_list_type]
    local is_new_file_list_type_valid = file_list_type_valid_map[update_file_list_type]
    if last_downloading_version and is_last_file_list_type_valid and is_new_file_list_type_valid then
      EL.LOG.debug(TAG, "has last origin/patch type file list, and now has new update")
      EL.LOG.debug(TAG, "process_pending_download_file_list last_downloading_file_list_type: " .. tostring(last_downloading_file_list_type) .. ", update_file_list_type: " .. tostring(update_file_list_type))
      local last_downloading_inner_dir = self:get_res_version_path(last_downloading_version)
      local update_res_version_dir = self:get_res_version_path(update_res_version)
      local pending_download_list = {}
      local GRM = require("ejoysdk_lua.res.group_res_manager")
      local is_group_key = GRM.is_group(res_key)
      EL.LOG.debug(TAG, "is_group_key:" .. tostring(is_group_key) .. ", res_key:" .. tostring(res_key))
      local last_downloading_local_version = last_downloading_file_list_type == RTM.FILE_LIST_TYPE.PATCH and last_downloading_info[RTM.RES_STATE_INFO_KEY.LOCAL_VERSION] or ""
      EL.LOG.debug(TAG, "last_downloading_local_version is: " .. tostring(last_downloading_local_version))
      local last_downloading_list_content = is_group_key and _load_group_res_file_list_content(namespace, res_key, last_downloading_version, last_downloading_local_version or "", ext) or M._load_local_file_list_content(namespace, res_key, last_downloading_version, last_downloading_local_version or "", ext)
      EL.LOG.debug(TAG, "last_downloading_list_content num: " .. tostring(last_downloading_list_content and #last_downloading_list_content or 0))
      local reuse_item_name_list = {}
      local reuse_name_new_item_map = {}
      local target_reuse_res_dir
      if last_downloading_list_content then
        EL.LOG.debug(TAG, "last downloading file list exists, now move the same files")
        local last_downloading_md5_map = {}
        for old_idx, old_item in ipairs(last_downloading_list_content) do
          local old_item_to_name = get_file_item_to_path(old_item)
          local old_item_md5 = old_item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5]
          if old_item_to_name then
            last_downloading_md5_map[old_item_to_name] = old_item_md5
            if 1 == old_idx then
              local last_file_path = last_downloading_inner_dir .. "/" .. old_item_to_name
              local last_item_exists = E.File.exists_fullpath(last_file_path)
              if last_item_exists then
                target_reuse_res_dir = last_downloading_inner_dir
              elseif last_downloading_save_location and "" ~= last_downloading_save_location then
                last_file_path = last_downloading_save_location .. "/" .. old_item_to_name
                last_item_exists = E.File.exists_fullpath(last_file_path)
                if last_item_exists then
                  target_reuse_res_dir = last_downloading_save_location
                end
              end
            end
          end
        end
        EL.LOG.debug(TAG, "target_reuse_res_dir is: " .. tostring(target_reuse_res_dir))
        for _, new_item in ipairs(index_file_list) do
          local new_item_to_name = get_file_item_to_path(new_item)
          local last_item_md5 = last_downloading_md5_map[new_item_to_name]
          if last_item_md5 and new_item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5] == last_item_md5 then
            table.insert(reuse_item_name_list, new_item_to_name)
            reuse_name_new_item_map[new_item_to_name] = new_item
          else
            table.insert(pending_download_list, new_item)
          end
        end
      end
      local reuse_size = #reuse_item_name_list
      if 0 == reuse_size or not target_reuse_res_dir then
        EL.LOG.debug(TAG, "last downloading file list not exists, remove last downloading version directory, and return new version list")
        if last_downloading_version then
          M.static_remove_downloading_version(namespace, res_key, last_downloading_version, ext)
        end
        process_cb(index_file_list, 0, total_size, 0, total_count)
        return
      end
      local reuse_res_path_list = {}
      local reuse_res_path_map = {}
      local reuse_path_new_item_map = {}
      local all_src_file_infos
      for _, reuse_item_name in ipairs(reuse_item_name_list) do
        local src_res_file_path = target_reuse_res_dir .. "/" .. reuse_item_name
        local dest_new_ver_file_path = update_res_version_dir .. "/" .. reuse_item_name
        local new_item = reuse_name_new_item_map[reuse_item_name]
        reuse_path_new_item_map[src_res_file_path] = new_item
        reuse_res_path_map[src_res_file_path] = dest_new_ver_file_path
        table.insert(reuse_res_path_list, src_res_file_path)
      end
      
      local function reuse_callback(_succ, ...)
        local fail_result
        if not _succ then
          local _code, _msg
          _code, _msg, fail_result = ...
          EL.LOG.warn(TAG, "reuse failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
        end
        for _src_path, _dst_path in pairs(reuse_res_path_map) do
          local _new_item = reuse_path_new_item_map[_src_path]
          local item_fail_ret = fail_result and fail_result[_src_path]
          if item_fail_ret then
            if EL.is_log_open() then
              EL.LOG.warn(TAG, "reuse file failed, last_file_path:" .. tostring(_src_path) .. ", dest_new_ver_file_path:" .. tostring(_dst_path) .. ", code:" .. tostring(item_fail_ret.code) .. ", msg:" .. tostring(item_fail_ret.msg))
            end
            local is_downloading_file_exit = _src_path and E.File.exists_fullpath(_src_path .. HDT.DOWNLOADING_FILE_SUFFIX) or false
            if item_fail_ret.code == EC.EJOY_LIB_ERROR.FILE_NOT_EXISTS and is_downloading_file_exit then
              local ret, code = E.File.rename_fullpath(_src_path .. HDT.DOWNLOADING_FILE_SUFFIX, _dst_path .. HDT.DOWNLOADING_FILE_SUFFIX)
              EL.LOG.debug(TAG, "rename dl_bak dst_path: " .. tostring(_dst_path .. HDT.DOWNLOADING_FILE_SUFFIX) .. ", ret" .. tostring(ret) .. ", code:" .. tostring(code))
            end
            table.insert(pending_download_list, _new_item)
          else
            if EL.is_log_open() then
              EL.LOG.debug(TAG, "same file list item:" .. tostring(_src_path) .. ", reuse succ")
            end
            local file_size = _new_item and _new_item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] and tonumber(_new_item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE]) or nil
            if not file_size and all_src_file_infos then
              local _src_info = all_src_file_infos[_src_path] or {}
              file_size = _src_info.size ~= nil and _src_info.size or 0
            end
            downloading_size = downloading_size + file_size
            finish_count = finish_count + 1
          end
        end
        process_cb(pending_download_list, downloading_size, total_size, finish_count, total_count)
      end
      
      local function reuse_fun()
        E.LOG.debug(TAG, "reuse begin")
        local reuse_opts = {is_fullpath = true, override = true}
        if last_downloading_state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
          E.File.batch_copy(reuse_res_path_map, reuse_callback, reuse_opts)
        else
          E.File.batch_rename(reuse_res_path_map, reuse_callback, reuse_opts)
        end
      end
      
      if need_check_size then
        E.LOG.debug(TAG, "file list item not has size, now batch_info get size")
        local _opts = {is_full_path = true, check_size = true}
        E.File.batch_info(reuse_res_path_list, function(succ_data)
          all_src_file_infos = succ_data or {}
          reuse_fun()
        end, _opts)
      else
        E.LOG.debug(TAG, "file list item has size, now directly call reuse")
        reuse_fun()
      end
    else
      EL.LOG.debug(TAG, "process_pending_download_file_list not origin/patch type, no need filter, directly use the index file list content")
      process_cb(index_file_list, 0, total_size, 0, total_count)
    end
  else
    EL.LOG.debug(TAG, "process_pending_download_file_list, current downloading ver is newest:" .. tostring(last_downloading_version))
    local downloading_res_version_path = self:get_res_version_path(update_res_version)
    local bak_item_map = {}
    local has_bak_file = _bak_old_file_list and next(_bak_old_file_list) ~= nil
    if has_bak_file then
      for _, old_item in ipairs(_bak_old_file_list) do
        local last_item_to_path = get_file_item_to_path(old_item)
        if last_item_to_path then
          bak_item_map[last_item_to_path] = old_item
        end
      end
    end
    local new_pending_download_item_list = {}
    local new_to_check_info_rela_path_list = {}
    local new_to_check_item_map = {}
    local old_to_rm_file_list = {}
    for _, new_item in ipairs(index_file_list) do
      local new_item_to_name = get_file_item_to_path(new_item)
      if new_item_to_name then
        local old_item = has_bak_file and bak_item_map[new_item_to_name] or nil
        if old_item then
          local new_item_md5 = new_item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5]
          local old_item_md5 = old_item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5]
          if old_item_md5 ~= new_item_md5 then
            local dest_new_ver_file_path = downloading_res_version_path .. "/" .. new_item_to_name
            table.insert(old_to_rm_file_list, dest_new_ver_file_path)
            table.insert(new_pending_download_item_list, new_item)
          else
            table.insert(new_to_check_info_rela_path_list, new_item_to_name)
            new_to_check_item_map[new_item_to_name] = new_item
          end
        else
          table.insert(new_to_check_info_rela_path_list, new_item_to_name)
          new_to_check_item_map[new_item_to_name] = new_item
        end
      else
        EL.LOG.warn(TAG, "check file item failed, item_name nil")
        E.log(new_item)
      end
    end
    local pending_download_list = new_pending_download_item_list
    
    local function _batch_info_callback(succ_data)
      for path, info in pairs(succ_data) do
        local new_item = new_to_check_item_map[path]
        if new_item then
          if not info.exists then
            table.insert(pending_download_list, new_item)
          else
            local item_size = need_check_size and info.size ~= nil and info.size or tonumber(new_item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE]) or 0
            downloading_size = downloading_size + item_size
            finish_count = finish_count + 1
          end
        else
          EL.LOG.warn(TAG, "check file item failed, item_name nil:" .. tostring(path))
        end
      end
      cb(pending_download_list, downloading_size, total_size, finish_count, total_count)
    end
    
    local function _batch_rm_callback(_succ2, ...)
      local list_path = self:_get_file_list_json_path(last_downloading_version)
      local list_path_bak = list_path .. "_bak"
      local rm_result, msg = E.File.remove_fullpath(list_path_bak)
      EL.LOG.warn(TAG, "remove bak file result:" .. tostring(rm_result) .. ", msg:" .. tostring(msg) .. ", path:" .. tostring(list_path_bak))
      local unknown_list_size = #new_to_check_info_rela_path_list
      if unknown_list_size > 0 then
        local _batch_info_opts = {
          is_full_path = false,
          check_size = need_check_size,
          base_path = downloading_res_version_path
        }
        local _before = E.system_clock()
        E.File.batch_info(new_to_check_info_rela_path_list, function(succ_data)
          local _after = E.system_clock()
          EL.LOG.debug(TAG, "batch_info cost:" .. tostring(_after - _before) .. ", check_size:" .. tostring(need_check_size) .. ", total:" .. tostring(unknown_list_size))
          _batch_info_callback(succ_data)
        end, _batch_info_opts)
      else
        _batch_info_callback({})
      end
    end
    
    local to_rm_size = #old_to_rm_file_list
    if to_rm_size > 0 then
      local _batch_opts = {is_fullpath = true}
      E.File.batch_remove(old_to_rm_file_list, function(_succ, ...)
        _batch_rm_callback(_succ, ...)
      end, _batch_opts)
    else
      _batch_rm_callback(true)
    end
  end
end

function M:_to_model_download_list_format(version, pending_file_list, folder, base_path)
  if not pending_file_list or next(pending_file_list) == nil then
    EL.LOG.warn(TAG, "parse_model_download_list_format skip, pending_file_list is empty")
    return {file_list = nil}
  end
  if folder and "" ~= folder then
    folder = E.Utils.trim_chars(folder, "/")
  end
  if base_path and "" ~= base_path then
    base_path = E.Utils.trim_chars(base_path, "/")
  end
  local _dest_parent_path = self:get_res_version_path(version)
  local pending_download_list = {}
  for _, item in ipairs(pending_file_list) do
    local item_from = item[RTM.FILE_LIST_ITEM_KEY.KEY_FROM]
    item_from = E.Utils.trim_chars(item_from, "/")
    local item_to = item[RTM.FILE_LIST_ITEM_KEY.KEY_TO]
    item_to = E.Utils.trim_chars(item_to, "/")
    local _md5 = item[RTM.FILE_LIST_ITEM_KEY.KEY_MD5]
    local _size = item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] or 0
    local _from_folder = item[RTM.FILE_LIST_ITEM_KEY.KEY_FROM_FOLDER]
    if _from_folder and "" ~= _from_folder then
      _from_folder = E.Utils.trim_chars(_from_folder, "/")
    end
    local _dest_path
    if nil == item_to then
      _dest_path = _dest_parent_path .. "/" .. item_from
      _dest_path = EHU.get_parent_folder(_dest_path)
    elseif "" == item_to then
      _dest_path = _dest_parent_path
    else
      _dest_path = _dest_parent_path .. "/" .. item_to
      _dest_path = EHU.get_parent_folder(_dest_path)
    end
    if not EU.is_text_empty(item_from) then
      local remote_path
      if not EU.is_text_empty(_from_folder) then
        remote_path = _from_folder .. "/" .. item_from
      elseif not EU.is_text_empty(folder) then
        remote_path = folder .. "/" .. item_from
      else
        remote_path = item_from
      end
      if not EU.is_text_empty(base_path) then
        remote_path = base_path .. "/" .. remote_path
      end
      local file_name
      if item_to and "" ~= item_to then
        file_name = EHU.guess_url_filename(item_to)
      else
        file_name = EHU.guess_url_filename(remote_path)
      end
      local down_item = {
        [RTM.MULTI_TASK_INFO_KEY.KEY_PATH] = remote_path,
        [RTM.MULTI_TASK_INFO_KEY.KEY_DEST_PATH] = _dest_path,
        [RTM.MULTI_TASK_INFO_KEY.KEY_MD5] = _md5,
        [RTM.MULTI_TASK_INFO_KEY.KEY_SIZE] = _size,
        [RTM.MULTI_TASK_INFO_KEY.KEY_NAME] = file_name
      }
      table.insert(pending_download_list, down_item)
    end
  end
  local target_download_list_info = {file_list = pending_download_list, dest_parent_path = _dest_parent_path}
  return target_download_list_info
end

function M:update_config(config)
  config = config or {}
  if type(config[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]) == "string" then
    self._data.res_save_storage_type = config[RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE]
    E.LOG.debug(TAG, "update_config storage type:" .. tostring(self._data.res_save_storage_type))
  end
  self._data.opts = config
end

function M:_update_version_origin_list_cache(update_version, list_info, _ext_info)
  self._data.qz_origin_list_cache_info.version = update_version
  self._data.qz_origin_list_cache_info.list_info = list_info
  self._data.qz_origin_list_cache_info.ext_info = _ext_info or {}
  _ejoysdk.log("_update_version_origin_list_cache origin list size:" .. tostring(list_info and #list_info or 0) .. ", ext_info:" .. tostring(_ext_info))
end

function M:get_origin_file_list_info(update_version, update_info, address_list, cb, is_total_file_list)
  if self._data.qz_origin_list_cache_info.version == update_version and self._data.qz_origin_list_cache_info.list_info and is_total_file_list then
    cb(true, self._data.qz_origin_list_cache_info.list_info, self._data.qz_origin_list_cache_info.ext_info)
    return
  end
  self:_load_qz_file_list_with_type(update_info, RTM.FILE_LIST_TYPE.ORIGIN, address_list, function(succ, ...)
    if succ then
      cb(true, self._data.qz_origin_list_cache_info.list_info, self._data.qz_origin_list_cache_info.ext_info)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end, is_total_file_list)
end

function M:get_origin_file_list_for_groups(update_version, update_info, address_list, groups, cb)
  local function get_fun()
    local _list = FP.get_group_file_list(self._data.namespace, self._data.res_key, nil, update_version, groups) or {}
    
    local ext_info = self._data.qz_origin_list_cache_info.ext_info or {}
    E.LOG.debug(TAG, "get_origin_file_list_for_groups, get group file list, version:" .. tostring(update_version) .. ", groups:" .. tostring(table.concat(groups, ", ")) .. ", list size:" .. tostring(#_list) .. ", ext_info:" .. tostring(ext_info))
    return _list, ext_info
  end
  
  if self._data.qz_origin_list_cache_info.version == update_version and self._data.qz_origin_list_cache_info.list_info then
    E.LOG.debug(TAG, "get_origin_file_list_for_groups, version match, now return")
    local list, ext_info = get_fun()
    cb(list, ext_info)
  else
    E.LOG.debug(TAG, "get_origin_file_list_for_groups, version not match, now reload")
    self:_load_qz_file_list_with_type(update_info, RTM.FILE_LIST_TYPE.ORIGIN, address_list, function(succ, ...)
      if succ then
        local list, ext_info = get_fun()
        cb(list, ext_info)
      else
        local code, msg = ...
        cb(nil, code, msg)
      end
    end, true)
  end
end

function M:_load_qz_file_list_with_type(update_info, specified_file_list_type, address_list, cb, is_total_file_list)
  EL.LOG.debug(TAG, "_load_qz_file_list_with_type:" .. tostring(specified_file_list_type))
  E.LOG.debug(TAG, update_info)
  local update_version = update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME] or 0
  local local_version
  local update_body = update_info[RTM.UPDATE_INFO_KEY.UPDATE_BODY] or {}
  local base_url = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_URL]
  local base_path = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_PATH]
  base_url = E.Utils.trim_chars(base_url, "/")
  base_path = E.Utils.trim_chars(base_path, "/")
  local index_file_url, index_file_remote_path
  local _folder = ""
  local index_file, index_file_md5, single_file_path, single_file_size, single_file_md5
  local file_list_type = specified_file_list_type
  file_list_type = file_list_type or update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE]
  local _is_single_file_mode = false
  if file_list_type == RTM.FILE_LIST_TYPE.ORIGIN then
    local origin_obj = update_body[RTM.RES_CONFIG_KEY.KEY_ORIGIN] or {}
    _folder = origin_obj[RTM.RES_CONFIG_KEY.KEY_FOLDER] or ""
    single_file_path = origin_obj[RTM.RES_CONFIG_KEY.KEY_FILE]
    if single_file_path and "" ~= single_file_path then
      _is_single_file_mode = true
      single_file_path = E.Utils.trim_chars(single_file_path, "/")
      single_file_size = origin_obj[RTM.RES_CONFIG_KEY.KEY_TOTAL_SIZE] or 0
      single_file_md5 = origin_obj[RTM.RES_CONFIG_KEY.KEY_FILE_MD5]
    else
      index_file = origin_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_FILE]
      index_file_md5 = origin_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_MD5]
    end
  elseif file_list_type == RTM.FILE_LIST_TYPE.PATCH then
    local patch_obj = update_body[RTM.RES_CONFIG_KEY.KEY_PATCH] or {}
    _folder = patch_obj[RTM.RES_CONFIG_KEY.KEY_FOLDER] or ""
    index_file = patch_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_FILE]
    index_file_md5 = patch_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_MD5]
    local_version = patch_obj[RTM.RES_CONFIG_KEY.KEY_TARGET_VERSION]
  end
  local ext_info = {
    base_path = base_path,
    folder = _folder,
    index_file_md5 = index_file_md5,
    is_single_file_mode = _is_single_file_mode
  }
  
  local function cb_wrapper(succ, ...)
    if succ then
      local _file_list, _bak_old_file_list, _ext_info = ...
      if file_list_type == RTM.FILE_LIST_TYPE.ORIGIN and is_total_file_list then
        self:_update_version_origin_list_cache(update_version, _file_list, _ext_info)
      end
    end
    cb(succ, ...)
  end
  
  if not _is_single_file_mode then
    EL.LOG.debug(TAG, "not is is_single_file_mode, try load with index_file:" .. tostring(index_file))
    if EU.is_text_empty(index_file) then
      EL.LOG.warn(TAG, "_load_qz_file_list_with_type failed, index_file is empty for file_list_type: " .. tostring(file_list_type) .. ", ns:" .. tostring(self._data.namespace) .. ", res_key:" .. tostring(self._data.res_key))
      cb_wrapper(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_INDEX_FILE_EMPTY, "index file is empty")
      return
    end
    index_file_url = base_url
    index_file_remote_path = base_path
    if not EU.is_text_empty(_folder) then
      _folder = E.Utils.trim_chars(_folder, "/")
      index_file_url = index_file_url .. "/" .. _folder
      index_file_remote_path = index_file_remote_path .. "/" .. _folder
    end
    index_file = E.Utils.trim_chars(index_file, "/")
    index_file_url = index_file_url .. "/" .. index_file
    index_file_remote_path = index_file_remote_path .. "/" .. index_file
    local retry_cnt = 0
    local address_list_index = 0
    local address_size = address_list and #address_list or 0
    EL.LOG.debug(TAG, "has index file, begin load index file:" .. tostring(index_file_url) .. ", index_file_md5 is " .. tostring(index_file_md5))
    local load_index_content_cb
    
    function load_index_content_cb(succ, ...)
      if succ then
        local index_file_list, _bak_old_file_list = ...
        EL.LOG.debug(TAG, "fetch_index_file_content succ, list size:" .. tostring(#index_file_list))
        cb_wrapper(true, index_file_list, _bak_old_file_list, ext_info)
      else
        local code, msg = ...
        EL.LOG.warn(TAG, "fetch_index_file_content failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        retry_cnt = retry_cnt + 1
        address_list_index = address_list_index + 1
        if address_list_index <= address_size and retry_cnt <= FILE_LIST_MAX_RETRY_TIME then
          EL.LOG.warn(TAG, "download file list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", retry_cnt:" .. tostring(retry_cnt))
          local address_domain_prefix = address_list[address_list_index]
          address_domain_prefix = E.Utils.trim_chars(address_domain_prefix, "/")
          local _index_file_url = address_domain_prefix .. "/" .. index_file_remote_path
          EL.LOG.debug(TAG, "download file list retry with url:" .. tostring(_index_file_url))
          self:_load_index_file_content(_index_file_url, index_file_md5, update_version, local_version, load_index_content_cb, is_total_file_list)
        else
          EL.LOG.warn(TAG, "download file list failed and return, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
          cb_wrapper(false, code, msg)
        end
      end
    end
    
    self:_load_index_file_content(index_file_url, index_file_md5, update_version, local_version, load_index_content_cb, is_total_file_list)
  else
    EL.LOG.debug(TAG, "is is_single_file_mode, try load with index_file:" .. tostring(index_file))
    local single_to_path = EHU.guess_url_filename(single_file_path)
    local origin_file_list = {
      {
        [RTM.FILE_LIST_ITEM_KEY.KEY_FROM] = single_file_path,
        [RTM.FILE_LIST_ITEM_KEY.KEY_TO] = single_to_path,
        [RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] = single_file_size,
        [RTM.FILE_LIST_ITEM_KEY.KEY_MD5] = single_file_md5
      }
    }
    cb_wrapper(true, origin_file_list, nil, ext_info)
  end
end

function M:load_origin_qz_file_list(update_info, address_list, cb)
  EL.LOG.debug(TAG, "load_origin_qz_file_list begin")
  self:_load_qz_file_list_with_type(update_info, RTM.FILE_LIST_TYPE.ORIGIN, address_list, cb)
end

function M:check_update_file_list(last_downloading_info, address_list, update_info, file_list_cb)
  local update_version = update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME] or 0
  local update_body = update_info[RTM.UPDATE_INFO_KEY.UPDATE_BODY] or {}
  EL.LOG.warn(TAG, "check_update_file_list >>>>")
  E.LOG.debug(TAG, update_info)
  local base_url = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_URL]
  local base_path = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_PATH]
  address_list = address_list or {}
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local opts = self._data.opts
  if EU.is_text_empty(base_url) then
    EL.LOG.warn(TAG, "check_update_file_list failed, baseUrl or basePath is empty:" .. tostring(base_path))
    file_list_cb(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_BASE_URL_EMPTY, "base url or path is empty")
    return
  end
  base_path = E.Utils.trim_chars(base_path, "/")
  base_url = E.Utils.trim_chars(base_url, "/")
  local res_ext_info = opts
  E.LOG.debug(TAG, "check_update_file_list ext>")
  E.log(res_ext_info)
  
  local function process_pending_download_list_fun(file_list, remote_folder, is_custom_file_list, custom_file_desc, _bak_old_file_list)
    self:_process_pending_download_file_list(file_list, _bak_old_file_list, update_info, last_downloading_info, is_custom_file_list, custom_file_desc, function(pending_file_list, downloading_size, total_size, finish_count, total_count)
      EL.LOG.debug(TAG, "process_pending_download_file_list result, pending_file_list:" .. tostring(#pending_file_list) .. ", downloading_size:" .. tostring(downloading_size) .. ", total_size:" .. tostring(total_size))
      local pending_download_list_info = self:_to_model_download_list_format(update_version, pending_file_list, remote_folder, base_path)
      pending_download_list_info.file_ext = {}
      local pending_size = total_size - downloading_size
      E.LOG.d(TAG, "pending download size=" .. tostring(pending_size) .. ",total_size=" .. tostring(total_size))
      pending_size = pending_size >= 0 and pending_size or 0
      pending_download_list_info.file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_TOTAL_SIZE] = pending_size
      local url_info = E.HTTP.parse(base_url)
      local url_prefix = url_info.scheme .. "://" .. url_info.host
      pending_download_list_info.file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_BASE_URL] = url_prefix
      pending_download_list_info.file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_DEST_PARENT_PATH] = pending_download_list_info.dest_parent_path
      EL.LOG.debug(TAG, "process_pending_download_file_list url_prefix:" .. tostring(url_prefix))
      file_list_cb(true, pending_download_list_info, downloading_size, total_size, finish_count, total_count)
    end)
  end
  
  local need_custom_file_list = NUM.check_has_request_file_list_handler(namespace, res_key) or NUM.check_has_process_file_list_handler(namespace, res_key)
  EL.LOG.debug(TAG, "check_has_request_file_list_handler:" .. tostring(need_custom_file_list) .. ", ns:" .. tostring(namespace) .. ", rk:" .. tostring(res_key))
  if need_custom_file_list then
    local function req_custom_list_handler(origin_file_info, down_origin_file_info, down_patch_file_info)
      local qz_file_list_type = FP.get_file_list_type(namespace, res_key, update_version)
      
      local file_list_type = update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE]
      local ext_info = {
        origin_file_list = origin_file_info.file_list,
        file_list = down_patch_file_info.file_list,
        down_origin_file_list = (down_origin_file_info or {}).file_list,
        namespace = namespace,
        res_key = res_key,
        qz_file_list_type = qz_file_list_type,
        file_list_type = file_list_type
      }
      EL.LOG.debug(TAG, "_load_qz_file_list_with_type before request_file_list, origin list size:" .. tostring(origin_file_info and #origin_file_info))
      if NUM.check_has_process_file_list_handler(namespace, res_key) then
        NUM.process_file_list(namespace, res_key, function(process_succ, ...)
          if process_succ then
            E.LOG.debug(TAG, "process_file_list succ, res_key is " .. tostring(res_key))
            local origin_file_list, patch_file_list = ...
            local file_list = origin_file_list or {}
            local temp_folder = origin_file_info.folder
            if patch_file_list and next(patch_file_list) ~= nil then
              temp_folder = down_patch_file_info.folder
              file_list = patch_file_list
              if down_patch_file_info.folder ~= origin_file_info.folder then
                if origin_file_list and next(origin_file_list) ~= nil then
                  for _, file_item in ipairs(origin_file_list) do
                    file_item.from_folder = origin_file_info.folder
                    table.insert(file_list, file_item)
                  end
                end
              elseif origin_file_list and next(origin_file_list) ~= nil then
                for _, file_item in ipairs(origin_file_list) do
                  table.insert(file_list, file_item)
                end
              end
            end
            process_pending_download_list_fun(file_list, temp_folder, true, {})
          else
            local code, msg = ...
            EL.LOG.warn(TAG, "request_file_list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            file_list_cb(false, code, msg)
          end
        end, ext_info)
      else
        NUM.request_file_list(namespace, res_key, function(succ, ...)
          if succ then
            E.LOG.debug(TAG, "request_file_list succ, res_key is " .. tostring(res_key))
            local file_list, list_desc, is_origin_file_list = ...
            if nil == is_origin_file_list then
              is_origin_file_list = true
            end
            file_list = file_list or {}
            list_desc = list_desc or {}
            local temp_folder = origin_file_info.folder
            if not is_origin_file_list then
              temp_folder = down_patch_file_info.folder
            end
            local folder = list_desc[RTM.RES_CONFIG_KEY.KEY_FOLDER] or temp_folder
            process_pending_download_list_fun(file_list, folder, true, list_desc)
          else
            local code, msg = ...
            EL.LOG.warn(TAG, "request_file_list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            file_list_cb(false, code, msg)
          end
        end, ext_info)
      end
    end
    
    self:_load_qz_file_list_with_type(update_info, RTM.FILE_LIST_TYPE.ORIGIN, address_list, function(_succ, ...)
      if _succ then
        local _origin_file_list, _bak_list, _ext_info = ...
        _origin_file_list = _origin_file_list or {}
        _ext_info = _ext_info or {}
        local origin_file_info = {
          folder = _ext_info.folder,
          index_file_md5 = _ext_info.index_file_md5,
          file_list = _origin_file_list
        }
        local patches_file_info_list = {}
        local copy_update_info = UTIL.deepcopy(update_info)
        local copy_update_body = copy_update_info[RTM.UPDATE_INFO_KEY.UPDATE_BODY] or {}
        local patches = copy_update_body[RTM.UPDATE_INFO_KEY.PATCHES] or {}
        local traverse_patches
        
        function traverse_patches(index)
          E.LOG.debug("traverse_patches begin, index:" .. tostring(index) .. ", patches size:" .. tostring(#patches))
          if index <= #patches then
            local patch = patches[index]
            copy_update_body[RTM.UPDATE_INFO_KEY.PATCH] = patch
            self:_load_qz_file_list_with_type(copy_update_info, RTM.FILE_LIST_TYPE.PATCH, address_list, function(_load_file_list_succ, ...)
              if _load_file_list_succ then
                local _patch_file_list, _patch_bak_list, _patch_ext_info = ...
                _patch_ext_info = _patch_ext_info or {}
                local p_file_info = {
                  from = patch[RTM.UPDATE_INFO_KEY.TARGET_VERSION],
                  folder = _patch_ext_info.folder,
                  index_file_md5 = _patch_ext_info.index_file_md5,
                  file_list = _patch_file_list
                }
                table.insert(patches_file_info_list, p_file_info)
                traverse_patches(index + 1)
              else
                local err_code, err_msg = ...
                EL.LOG.warn(TAG, "request_file_list with failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
                file_list_cb(false, err_code, err_msg)
              end
            end)
          else
            local res_checker = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_check")
            local spm = require("ejoysdk_lua.res.splitpkg_res_manager")
            local removed_res_list = spm.get_removed_res_list()
            res_checker.hotfix_res_download_check({namespace = namespace, res_key = res_key}, origin_file_info, patches_file_info_list, removed_res_list, nil, function(__succ, ...)
              if __succ then
                local down_origin, down_patch = ...
                req_custom_list_handler(origin_file_info, down_origin, down_patch)
              else
                local err_code, err_msg = ...
                file_list_cb(false, err_code, err_msg)
              end
            end)
          end
        end
        
        if SU.can_reuse_res() then
          traverse_patches(1)
        else
          self:_load_qz_file_list_with_type(update_info, nil, address_list, function(_load_file_list_succ, ...)
            if _load_file_list_succ then
              local _patch_file_list, _patch_bak_list, _patch_ext_info = ...
              _patch_ext_info = _patch_ext_info or {}
              local patch_folder = _patch_ext_info.folder
              local patch_index_file_md5 = _patch_ext_info.index_file_md5
              local patch_file_info = {
                folder = patch_folder,
                index_file_md5 = patch_index_file_md5,
                file_list = _patch_file_list
              }
              req_custom_list_handler(origin_file_info, nil, patch_file_info)
            else
              local err_code, err_msg = ...
              EL.LOG.warn(TAG, "request_file_list with failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
              file_list_cb(false, err_code, err_msg)
            end
          end)
        end
      else
        local code, msg = ...
        EL.LOG.warn(TAG, "request_file_list with origin list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        file_list_cb(false, code, msg)
      end
    end)
  else
    EL.LOG.debug(TAG, "biz side not override file_list request, so we check list ourselves")
    self:_load_qz_file_list_with_type(update_info, nil, address_list, function(_succ, ...)
      if _succ then
        local index_file_list, _bak_old_file_list, _ext_info = ...
        _ext_info = _ext_info or {}
        local folder = _ext_info.folder
        local is_single_file_mode = _ext_info.is_single_file_mode
        if is_single_file_mode then
          if not index_file_list or #index_file_list < 1 then
            local _code = EC.RESOURCE_UPDATE_ERROR_CODES.RES_INDEX_FILE_EMPTY
            local _msg = "single file empty"
            EL.LOG.warn(TAG, "fetch_index_file_content failed, file_list is empty:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
            file_list_cb(false, _code, _msg)
            return
          end
          local single_file_item = index_file_list[1]
          local single_file_size = single_file_item[RTM.FILE_LIST_ITEM_KEY.KEY_SIZE] or 0
          local pending_download_list_info = self:_to_model_download_list_format(update_version, index_file_list, folder, base_path)
          pending_download_list_info.file_ext = {}
          pending_download_list_info.file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_TOTAL_SIZE] = single_file_size
          local url_info = E.HTTP.parse(base_url)
          local url_prefix = url_info.scheme .. "://" .. url_info.host
          pending_download_list_info.file_ext[RTM.MULTI_TASK_INFO_KEY.KEY_BASE_URL] = url_prefix
          EL.LOG.debug(TAG, "process single file url_prefix:" .. tostring(url_prefix))
          file_list_cb(true, pending_download_list_info, 0, single_file_size, 0, 1)
        else
          EL.LOG.debug(TAG, "fetch_index_file_content succ with index_file list size:" .. tostring(#index_file_list))
          process_pending_download_list_fun(index_file_list, folder, false, nil, _bak_old_file_list)
        end
      else
        local code, msg = ...
        EL.LOG.warn(TAG, "download file list failed and return, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        file_list_cb(false, code, msg)
      end
    end)
  end
end

local function _load_qz_file_info_list(namespace, res_key, update_info, address_list, cb, ext)
  local update_version = update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME] or 0
  local local_version
  local update_body = update_info[RTM.UPDATE_INFO_KEY.UPDATE_BODY] or {}
  local base_url = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_URL]
  local base_path = update_body[RTM.RES_CONFIG_KEY.KEY_BASE_PATH]
  base_url = E.Utils.trim_chars(base_url, "/")
  base_path = E.Utils.trim_chars(base_path, "/")
  local index_info_file_url, index_info_file_remote_path
  local _folder = ""
  local index_info_file, index_info_file_md5
  local file_list_type = update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE]
  if file_list_type == RTM.FILE_LIST_TYPE.ORIGIN then
    local origin_obj = update_body[RTM.RES_CONFIG_KEY.KEY_ORIGIN] or {}
    _folder = origin_obj[RTM.RES_CONFIG_KEY.KEY_FOLDER] or ""
    index_info_file = origin_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_INFO_FILE]
    index_info_file_md5 = origin_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_INFO_MD5]
  elseif file_list_type == RTM.FILE_LIST_TYPE.PATCH then
    local patch_obj = update_body[RTM.RES_CONFIG_KEY.KEY_PATCH] or {}
    _folder = patch_obj[RTM.RES_CONFIG_KEY.KEY_FOLDER] or ""
    index_info_file = patch_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_INFO_FILE]
    index_info_file_md5 = patch_obj[RTM.RES_CONFIG_KEY.KEY_INDEX_INFO_MD5]
    local_version = patch_obj[RTM.RES_CONFIG_KEY.KEY_TARGET_VERSION]
  end
  if EU.is_text_empty(index_info_file) then
    EL.LOG.warn(TAG, "_load_qz_file_info_list failed, index_info_file is empty for file_list_type: " .. tostring(file_list_type) .. ", ns:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
    cb(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_INDEX_INFO_FILE_EMPTY, "index info file is empty")
    return
  end
  index_info_file_url = base_url
  index_info_file_remote_path = base_path
  if not EU.is_text_empty(_folder) then
    _folder = E.Utils.trim_chars(_folder, "/")
    index_info_file_url = index_info_file_url .. "/" .. _folder
    index_info_file_remote_path = index_info_file_remote_path .. "/" .. _folder
  end
  index_info_file = E.Utils.trim_chars(index_info_file, "/")
  index_info_file_url = index_info_file_url .. "/" .. index_info_file
  index_info_file_remote_path = index_info_file_remote_path .. "/" .. index_info_file
  local retry_cnt = 0
  local address_list_index = 0
  local address_size = address_list and #address_list or 0
  EL.LOG.debug(TAG, "has index file, begin load index file:" .. tostring(index_info_file_url))
  local load_index_content_cb
  
  function load_index_content_cb(succ, ...)
    if succ then
      local index_info_file_list = (...)
      EL.LOG.debug(TAG, "fetch_index_info_file_content succ")
      cb(true, index_info_file_list)
    else
      local code, msg = ...
      EL.LOG.warn(TAG, "fetch_index_file_content failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      retry_cnt = retry_cnt + 1
      address_list_index = address_list_index + 1
      if address_list_index <= address_size and retry_cnt <= FILE_LIST_MAX_RETRY_TIME then
        EL.LOG.warn(TAG, "download file list failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", retry_cnt:" .. tostring(retry_cnt))
        local address_domain_prefix = address_list[address_list_index]
        address_domain_prefix = E.Utils.trim_chars(address_domain_prefix, "/")
        local _index_file_url = address_domain_prefix .. "/" .. index_info_file_remote_path
        EL.LOG.debug(TAG, "download file list retry with url:" .. tostring(_index_file_url))
        load_index_info_file_content(namespace, res_key, _index_file_url, index_info_file_md5, update_version, local_version, load_index_content_cb, ext)
      else
        EL.LOG.warn(TAG, "download file list failed and return, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, code, msg)
      end
    end
  end
  
  load_index_info_file_content(namespace, res_key, index_info_file_url, index_info_file_md5, update_version, local_version, load_index_content_cb, ext)
end

function M.check_qz_game_res_update(out_update_info, server_update_info, address_list, cb, namespace, res_key, ext)
  local patch_size = 0
  local origin_size = 0
  local patch_count = 0
  local origin_count = 0
  if server_update_info.patch and server_update_info.patch.size then
    patch_size = tonumber(server_update_info.patch.size) or 0
    patch_count = tonumber(server_update_info.patch.cnt) or 0
  end
  if server_update_info.origin and server_update_info.origin.size then
    origin_size = tonumber(server_update_info.origin.size) or 0
    origin_count = tonumber(server_update_info.origin.cnt) or 0
  end
  
  local function _process_file_info_list(succ, ...)
    if succ then
      local qz_file_info_list = (...)
      if qz_file_info_list and qz_file_info_list.group then
        local GRM = require("ejoysdk_lua.res.group_res_manager")
        local real_res_key = GRM.get_real_res_key(res_key)
        local group_name
        if real_res_key == res_key then
          group_name = "default"
        else
          group_name = GRM.get_group_name_by_task_key(res_key)
        end
        E.LOG.debug(TAG, "check update size, group_name is " .. tostring(group_name))
        for _, group_info in ipairs(qz_file_info_list.group) do
          if group_name == group_info.g then
            E.LOG.debug(TAG, string.format("check update size, group size is %s, count is %s", tostring(group_info.s), tostring(group_info.c or "nil")))
            out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = group_info.s
            if group_info.c then
              out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_COUNT] = group_info.c
            end
            cb(true, out_update_info)
            return
          end
        end
        out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
        out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_COUNT] = 0
        cb(true, out_update_info)
      else
        cb(true, out_update_info)
      end
    else
      local code, msg = ...
      if code == EC.RESOURCE_UPDATE_ERROR_CODES.RES_INDEX_INFO_FILE_EMPTY then
        cb(true, out_update_info)
      else
        cb(false, code, msg)
      end
    end
  end
  
  local function _load_origin_file_info(_out_update_info, origin_cb)
    _out_update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE] = M.UPDATE_INFO_FILE_LIST_TYPE.ORIGIN
    _out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = origin_size
    _out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_COUNT] = origin_count
    _load_qz_file_info_list(namespace, res_key, _out_update_info, address_list, origin_cb, ext)
  end
  
  local function _load_patch_file_info(_out_update_info, patch_cb)
    _out_update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE] = M.UPDATE_INFO_FILE_LIST_TYPE.PATCH
    _out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = patch_size
    _out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_COUNT] = patch_count
    _load_qz_file_info_list(namespace, res_key, _out_update_info, address_list, patch_cb, ext)
  end
  
  if server_update_info.patch then
    _load_patch_file_info(out_update_info, function(succ, ...)
      if succ then
        if server_update_info.origin then
          local patch_params = {
            ...
          }
          local _origin_out_update_info = UTIL.deepcopy(out_update_info)
          _load_origin_file_info(_origin_out_update_info, function(succ2, ...)
            if succ2 then
              _process_file_info_list(succ, unpack(patch_params))
            else
              _process_file_info_list(succ2, ...)
            end
          end)
        else
          _process_file_info_list(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_DOWNLOAD_FAILED_UNKNOWN, "no origin file_info")
        end
      else
        _process_file_info_list(false, ...)
      end
    end)
  elseif server_update_info.origin then
    _load_origin_file_info(out_update_info, _process_file_info_list)
  else
    out_update_info[RTM.UPDATE_INFO_KEY.FILE_LIST_TYPE] = M.UPDATE_INFO_FILE_LIST_TYPE.UNKNOWN
    out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
    out_update_info[RTM.UPDATE_INFO_KEY.TOTAL_COUNT] = 0
    _load_qz_file_info_list(namespace, res_key, out_update_info, address_list, _process_file_info_list, ext)
  end
end

function M:check_res_update(cb, server_update_info, address_list, namespace, res_key, ext)
  local update_info = {}
  update_info[RTM.UPDATE_INFO_KEY.UPDATE_BODY] = server_update_info
  update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME] = server_update_info[RTM.RES_CONFIG_KEY.KEY_VERSION]
  EL.LOG.debug(TAG, "check_res_update, try use qzGameRes parse size")
  M.check_qz_game_res_update(update_info, server_update_info, address_list, function(succ, ...)
    if succ then
      update_info = (...)
      if update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] == nil or 0 == update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] then
        EL.LOG.warn(TAG, "check_res_update, not support type, try use update_info.size")
        update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = server_update_info[RTM.RES_CONFIG_KEY.KEY_TOTAL_SIZE] or 0
      end
      cb(true, update_info)
    else
      cb(false, ...)
    end
  end, namespace, res_key, ext)
end

function M:mark_update_res_invalid(namespace, res_key, version, ext)
  EL.LOG.debug(TAG, "mark_update_res_invalid:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", version:" .. tostring(version))
  local file_list_path = get_file_list_json_path(namespace, res_key, version, ext)
  EL.LOG.debug(TAG, "begin remove file list config:" .. tostring(file_list_path))
  EHU.os_remove(file_list_path)
end

function M.static_remove_downloading_version(namespace, res_key, version, ext)
  local rm_result, res_version_path
  if version then
    res_version_path = get_res_version_dest_full_path(namespace, res_key, version, ext)
  else
    res_version_path = get_res_dest_full_path(namespace, res_key, ext)
    EL.LOG.debug(TAG, "static_remove_downloading_version version is nil, remove res_key dir")
  end
  if E.Sysinfo.os() ~= "windows" or E.is_support_function(EC.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION) then
    if res_version_path then
      EL.LOG.debug(TAG, "static_remove_downloading_version begin remove:" .. tostring(res_version_path))
      rm_result = E.File.remove_fullpath(res_version_path)
    else
      rm_result = false
    end
  else
    if nil == version then
      EL.LOG.debug(TAG, "static_remove_downloading_version, pc not support remove res_key dir")
      return false
    end
    local last_downloading_list_content = M._load_local_file_list_content(namespace, res_key, version, "", ext)
    if not last_downloading_list_content then
      EL.LOG.warn(TAG, "static_remove_downloading_version failed, no local file list for, ns:" .. tostring(namespace) .. ", rk:" .. tostring(res_key) .. ", v:" .. tostring(version))
      return false
    end
    local res_dirs = {}
    local last_downloading_dest_dir = get_res_version_dest_full_path(namespace, res_key, version, ext)
    EL.LOG.debug(TAG, "static_remove_downloading_version begin remove:" .. tostring(last_downloading_dest_dir))
    for _, last_item in ipairs(last_downloading_list_content) do
      local new_item_to_name = last_item[RTM.FILE_LIST_ITEM_KEY.KEY_TO]
      local last_file_path = last_downloading_dest_dir .. "/" .. new_item_to_name
      EHU.os_remove(last_file_path)
      local last_file_path_downloading = last_file_path .. HDT.DOWNLOADING_FILE_SUFFIX
      EHU.os_remove(last_file_path_downloading)
      local res_folder = EHU.get_parent_folder(last_file_path)
      res_dirs[res_folder] = true
    end
    local file_list_path = get_file_list_json_path(namespace, res_key, version, ext)
    local fr = EHU.os_remove(file_list_path)
    EL.LOG.debug(TAG, "begin remove file list config:" .. tostring(file_list_path) .. ", result:" .. tostring(fr))
    for d, _ in pairs(res_dirs) do
      local r = EHU.os_remove(d)
      EL.LOG.debug(TAG, "rm dir:" .. tostring(d) .. ", result:" .. tostring(r))
    end
    local res_ver_path = get_res_version_dest_full_path(namespace, res_key, version, ext)
    EL.LOG.debug(TAG, "begin remove res version:" .. tostring(res_ver_path))
    rm_result = EHU.os_remove(res_ver_path)
  end
  E.LOG.debug(TAG, "static_remove_downloading_version, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", version:" .. tostring(version) .. ", result:" .. tostring(rm_result))
  return rm_result
end

function M:get_res_version_path(version)
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local opts = self._data.opts
  do return M.static_get_res_version_path, namespace, res_key, version end
  return M.static_get_res_version_path, namespace, res_key, version, opts
end

function M:get_res_path()
  local namespace = self._data.namespace
  local res_key = self._data.res_key
  local opts = self._data.opts
  do return M.static_get_res_path, namespace, res_key end
  return M.static_get_res_path, namespace, res_key, opts
end

function M:write_to_res_version_file(version, content_str, file_name)
  local _dest_path = self:get_res_version_path(version)
  local file_list_desc_path = _dest_path .. "/" .. file_name
  E.File.writefile_fullpath(file_list_desc_path, content_str, false)
end

function M.static_write_to_res_version_file(namespace, res_key, version, content_str, file_name, ext)
  local _dest_path = M.static_get_res_version_path(namespace, res_key, version, ext)
  local file_list_desc_path = _dest_path .. "/" .. file_name
  E.File.writefile_fullpath(file_list_desc_path, content_str, false)
end

return M
