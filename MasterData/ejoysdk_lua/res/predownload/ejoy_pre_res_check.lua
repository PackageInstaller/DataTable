local E = require("ejoysdk_lua.ejoysdk")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local RES_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
local RES_CHECK = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_check")
local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = "EjoyPreDownloadResChecker"
local M = {}
M.LOCATION = {
  DEFAULT = "default",
  PREDOWNLOAD = "preDownload"
}

local function _check_file_exists(local_file_helper, dest_file_info, c_file_name)
  local _file_exists = false
  local _obj = local_file_helper:get_info(c_file_name)
  local _dst_obj
  if _obj then
    if dest_file_info and next(dest_file_info) then
      _dst_obj = dest_file_info[c_file_name]
      if _dst_obj then
        _file_exists = _dst_obj.exists == true
      end
    else
      _file_exists = true
    end
    if true == _file_exists then
      _obj = UTIL.deepcopy(_obj)
      _obj.file_name = c_file_name
    end
  end
  return _file_exists, _obj, _dst_obj
end

local function _check_result(local_file_helper, target_file_info, dest_file_info, opts)
  local _check_result = {}
  _check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] = false
  _check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_MATCH] = false
  
  local function __check_file_match(src_obj, dst_obj, target_md5, _target_size)
    if src_obj and src_obj.md5 and src_obj.md5 == target_md5 then
      local match = true
      if opts.check_md5 == true then
        local real_md5 = (dst_obj or {}).md5 or ""
        match = real_md5 == target_md5
      end
      if true == opts.check_size then
        local real_size = (dst_obj or {}).size or -1
        match = match and real_size == _target_size
      end
      return match
    end
    return false
  end
  
  local file_md5 = target_file_info.md5 or ""
  local file_name = target_file_info.to or ""
  local file_size = target_file_info.size or -1
  local _file_exists, _file_obj, _dest_file_obj = _check_file_exists(local_file_helper, dest_file_info, file_name)
  if _file_exists then
    _check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] = true
    _check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_MATCH] = __check_file_match(_file_obj, _dest_file_obj, file_md5, file_size)
  end
  return _check_result
end

function M.hotfix_res_download_check(res_info, origin_file_info, patch_file_info, origin_download_list, patch_download_list, opts, cb)
  opts = opts or {}
  origin_file_info = origin_file_info and UTIL.deepcopy(origin_file_info) or {}
  patch_file_info = patch_file_info and UTIL.deepcopy(patch_file_info) or {}
  origin_download_list = origin_download_list and UTIL.deepcopy(origin_download_list) or {}
  patch_download_list = patch_download_list and UTIL.deepcopy(patch_download_list) or {}
  origin_file_info.file_list = RES_CHECK.Utils.translate_patch_file_list(origin_file_info.file_list)
  patch_file_info.file_list = RES_CHECK.Utils.translate_patch_file_list(patch_file_info.file_list)
  origin_download_list.file_list = RES_CHECK.Utils.translate_patch_file_list(origin_download_list.file_list)
  patch_download_list.file_list = RES_CHECK.Utils.translate_patch_file_list(patch_download_list.file_list)
  local namespace = res_info.namespace
  local using_res_key = res_info.res_key
  local GMR = require("ejoysdk_lua.res.group_res_manager")
  local res_key = GMR.get_real_res_key(using_res_key)
  local startup_local_res_info = SC.get_startup_local_res_infos_cache()
  local startup_res_info = startup_local_res_info[namespace] and startup_local_res_info[namespace][res_key]
  if nil == startup_res_info or nil == next(startup_res_info) then
    cb(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_KEY_INVALID, "res_info not found, please check namespace and res_key")
    return
  end
  local res_save_base_path = startup_res_info.res_save_base_path
  local res_save_storage_type = startup_res_info.res_save_storage_type
  local apply_dest_path = E.Path.join(ER_UTILS.get_apply_dest_path(res_save_storage_type, res_save_base_path), CONSTANTS.RES_PREDOWNLOAD.FOLDER_NAME)
  E.LOG.d(TAG, "apply_dest_path:" .. apply_dest_path)
  local pre_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(apply_dest_path, false)
  local filter_match_list = {
    file_list = {}
  }
  
  local function __use_predownload(file_name, p_file_info, dest_file_info)
    local o_file_info = origin_file_info.file_list[file_name]
    if not o_file_info then
      return nil
    end
    local check_result = _check_result(pre_res_qz_local_file_list, o_file_info, dest_file_info, opts)
    if check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] == true and true ~= check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_MATCH] then
      if patch_file_info and patch_file_info.file_list then
        local _patch_file_info = patch_file_info.file_list[file_name]
        if _patch_file_info and _patch_file_info.size < p_file_info.size then
          _patch_file_info.location = M.LOCATION.PREDOWNLOAD
          return _patch_file_info
        end
      end
    elseif true == check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_MATCH] then
      o_file_info.location = M.LOCATION.PREDOWNLOAD
      table.insert(filter_match_list.file_list, o_file_info)
      return nil
    end
    p_file_info.location = M.LOCATION.DEFAULT
    return p_file_info
  end
  
  local filter_origin_list = {
    folder = origin_download_list.folder,
    file_list = {}
  }
  local filter_patch_list = {
    folder = patch_download_list.folder or patch_file_info.folder,
    file_list = {}
  }
  local _predown_res_file_list = pre_res_qz_local_file_list:get_file_name_list()
  E.File.process_batch_info(_predown_res_file_list, function(ret)
    local function get_md5(batch_info, md5_cb)
      if opts.check_md5 == true then
        E.File.process_batch_md5(_predown_res_file_list, function(succ3, ...)
          local succ_data, _fail_data
          
          if succ3 then
            succ_data = (...)
          else
            local _code, _msg, s_data, f_data = ...
            succ_data = s_data
            _fail_data = f_data
          end
          for file_name, info in pairs(batch_info) do
            info.md5 = succ_data[file_name] or nil
          end
          md5_cb()
        end, apply_dest_path)
        return
      end
      md5_cb()
    end
    
    get_md5(ret, function()
      for _, file_list in ipairs({
        patch_download_list.file_list,
        origin_download_list.file_list
      }) do
        for file_origin_name, file_info in pairs(file_list) do
          local t_file_info = __use_predownload(file_origin_name, file_info, ret)
          if t_file_info then
            local __list = filter_origin_list
            if E.Utils.end_with(t_file_info.to, ".diff") then
              __list = filter_patch_list
            end
            table.insert(__list.file_list, t_file_info)
          end
        end
      end
      cb(true, filter_match_list, filter_origin_list, filter_patch_list)
    end)
  end, {
    is_full_path = true,
    base_path = apply_dest_path,
    check_size = opts.check_size
  })
end

function M.hotfix_pre_res_download_check(res_info, origin_file_info, patch_file_info, origin_download_list, patch_download_list, opts, cb)
  opts = opts or {}
  origin_file_info = origin_file_info and UTIL.deepcopy(origin_file_info) or {}
  patch_file_info = patch_file_info and UTIL.deepcopy(patch_file_info) or {}
  origin_download_list = origin_download_list and UTIL.deepcopy(origin_download_list) or {}
  patch_download_list = patch_download_list and UTIL.deepcopy(patch_download_list) or {}
  origin_file_info.file_list = RES_CHECK.Utils.translate_patch_file_list(origin_file_info.file_list)
  patch_file_info.file_list = RES_CHECK.Utils.translate_patch_file_list(patch_file_info.file_list)
  origin_download_list.file_list = RES_CHECK.Utils.translate_patch_file_list(origin_download_list.file_list)
  patch_download_list.file_list = RES_CHECK.Utils.translate_patch_file_list(patch_download_list.file_list)
  local namespace = res_info.namespace
  local using_res_key = res_info.res_key
  local pkg_res_list_dir = res_info.pkg_res_list_dir
  local res_key = PREDOWNLOAD_MGR.UTILS.get_real_res_key(using_res_key)
  local GMR = require("ejoysdk_lua.res.group_res_manager")
  res_key = GMR.get_real_res_key(res_key)
  local startup_local_res_info = SC.get_startup_local_res_infos_cache()
  local startup_res_info = startup_local_res_info[namespace] and startup_local_res_info[namespace][res_key]
  pkg_res_list_dir = pkg_res_list_dir or startup_res_info.pkg_res_path
  if nil == startup_res_info or nil == next(startup_res_info) then
    cb(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_KEY_INVALID, "res_info not found, please check namespace and res_key")
    return
  end
  local res_save_base_path = startup_res_info.res_save_base_path
  local res_save_storage_type = startup_res_info.res_save_storage_type
  local default_apply_dest_path = ER_UTILS.get_apply_dest_path(res_save_storage_type, res_save_base_path)
  local default_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(default_apply_dest_path, false)
  local pre_apply_dest_path = E.Path.join(default_apply_dest_path, CONSTANTS.RES_PREDOWNLOAD.FOLDER_NAME)
  local pre_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(pre_apply_dest_path, false)
  local pkg_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(pkg_res_list_dir, true)
  
  local function __use_default(file_name, p_file_info, _dest_file_info)
    local o_file_info = origin_file_info.file_list[file_name]
    if not o_file_info then
      E.LOG.e(TAG, "file " .. file_name .. " not exist")
      return nil
    end
    local check_result = _check_result(default_res_qz_local_file_list, o_file_info, _dest_file_info, opts)
    local check_pkg_result = _check_result(pkg_res_qz_local_file_list, o_file_info, _dest_file_info, opts)
    local _match = false
    if check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] == true then
      if true == check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_MATCH] then
        _match = true
      end
    elseif check_pkg_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] == true and true == check_pkg_result[RES_CHECK.CHECK_RESULT.KEY_FILE_MATCH] then
      _match = true
    end
    if true == _match then
      pre_res_qz_local_file_list:remove_file(file_name)
      return nil
    else
      local _patch_file_info = UTIL.deepcopy(patch_file_info.file_list[file_name])
      if _patch_file_info and _patch_file_info.size < p_file_info.size then
        _patch_file_info.location = M.LOCATION.DEFAULT
        return _patch_file_info
      end
      local exist = _check_file_exists(pre_res_qz_local_file_list, _dest_file_info, o_file_info.to or "")
      if exist then
        p_file_info.location = M.LOCATION.PREDOWNLOAD
        return p_file_info
      elseif _patch_file_info then
        E.LOG.d(TAG, {_patch_file_info = _patch_file_info})
        if E.Utils.end_with(_patch_file_info.to, ".diff") and (check_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] == true or check_pkg_result[RES_CHECK.CHECK_RESULT.KEY_FILE_EXIST] == true) then
          _patch_file_info.location = M.LOCATION.DEFAULT
          return _patch_file_info
        end
      end
    end
    o_file_info.location = M.LOCATION.PREDOWNLOAD
    return o_file_info
  end
  
  local filter_origin_list = {
    folder = origin_download_list.folder,
    file_list = {}
  }
  local filter_patch_list = {
    folder = patch_download_list.folder or patch_file_info.folder,
    file_list = {}
  }
  for _, file_list in ipairs({
    patch_download_list.file_list,
    origin_download_list.file_list
  }) do
    for file_origin_name, file_info in pairs(file_list) do
      local t_file_info = __use_default(file_origin_name, file_info)
      if t_file_info then
        E.LOG.d(TAG, {
          t_file_info = t_file_info or "nil"
        })
        local __list = filter_origin_list
        if E.Utils.end_with(t_file_info.to, ".diff") then
          __list = filter_patch_list
        end
        table.insert(__list.file_list, t_file_info)
      end
    end
  end
  cb(true, {}, filter_origin_list, filter_patch_list)
end

return M
