local E = require("ejoysdk_lua.ejoysdk")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local GMR = require("ejoysdk_lua.res.group_res_manager")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local RES_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
local TAG = "EjoyResChecker#"
local HAS_HPATCHZ
local M = {}
local CHECK_RESULT_KEY_FILE_LOC = "LOC"
local CHECK_RESULT_KEY_FILE_EXIST = "EXIST"
local CHECK_RESULT_KEY_FILE_MATCH = "MATCH"
local CHECK_RESULT_KEY_IGNORE = "IGNORE"
local LOCATION = {DATA = "DATA", PACKAGE = "PACKAGE"}

local function translate_patch_file_list(patch_file_list)
  local patch_file_index = {}
  for _, file_info in ipairs(patch_file_list) do
    if not UTIL.is_text_empty(file_info.to) then
      local file_name = file_info.to
      local origin_file_name = E.Utils.trim_end(file_name, ".diff")
      patch_file_index[origin_file_name] = file_info
    end
  end
  return patch_file_index
end

local function has_hpatchz()
  if nil == HAS_HPATCHZ then
    local CM = require("ejoysdk_lua.ejoysdk_channel_manager")
    HAS_HPATCHZ = nil ~= CM.get_vendor("HPATCHZ")
  end
  return HAS_HPATCHZ
end

local function _hotfix_res_download_check(target_file_list, patches_file_info, black_file_list, dest_file_info, checking_info, file_list_helpers, opts)
  local download_origin_file_list = {
    folder = target_file_list.folder,
    file_list = {}
  }
  local download_patch_file_list = {
    file_list = {}
  }
  local res_pkg_version = checking_info.pkg_version
  local res_data_version = checking_info.data_version
  local res_using_version = checking_info.using_version
  local preffer_using_data_res = true
  if UTIL.is_text_empty(res_using_version) then
    preffer_using_data_res = false
  elseif UTIL.is_text_empty(res_data_version) then
    preffer_using_data_res = false
  elseif checking_info.is_default and VER_CHECK.compare_versions(res_pkg_version, res_data_version) > 0 then
    preffer_using_data_res = false
  end
  
  local function _get_file_info_from_list(loc, file_name)
    local local_file_list = file_list_helpers[loc]
    local _obj = local_file_list:get_info(file_name)
    if _obj then
      _obj = UTIL.deepcopy(_obj)
      _obj.file_name = file_name
      _obj.location = loc
    end
    return _obj
  end
  
  local function _check_file_valid(file_info)
    local check_result
    local file_md5 = file_info.md5 or ""
    local file_name = file_info.to or ""
    local file_size = file_info.size or -1
    if black_file_list and next(black_file_list) and not UTIL.is_text_empty(file_md5) and (black_file_list[file_name] or {}).md5 == file_md5 then
      return {
        [CHECK_RESULT_KEY_IGNORE] = true
      }
    end
    
    local function __check_match(src_obj, target_md5, target_size)
      if src_obj and src_obj.md5 and src_obj.md5 == target_md5 then
        local match = true
        if src_obj.location ~= LOCATION.PACKAGE then
          if opts.check_md5 == true then
            local real_md5 = (dest_file_info[src_obj.file_name] or {}).md5 or ""
            match = real_md5 == target_md5
          end
          if true == opts.check_size then
            local real_size = (dest_file_info[src_obj.file_name] or {}).size or -1
            match = match and real_size == target_size
          end
        end
        return match
      end
      return false
    end
    
    local function _get_check_result(prefer_loc, minor_loc)
      local _check_result = {}
      _check_result[CHECK_RESULT_KEY_FILE_EXIST] = false
      _check_result[CHECK_RESULT_KEY_FILE_MATCH] = false
      
      local function __check_file_exists(loc, c_file_name)
        local __obj = _get_file_info_from_list(loc, c_file_name)
        local file_exists
        if nil ~= __obj then
          file_exists = true
          if LOCATION.DATA == loc then
            file_exists = (dest_file_info[c_file_name] or {}).exists == true
          end
          return file_exists, __obj
        end
        return false
      end
      
      local file_exist, _obj = __check_file_exists(prefer_loc, file_name)
      if true == file_exist then
        _check_result[CHECK_RESULT_KEY_FILE_EXIST] = true
        _check_result[CHECK_RESULT_KEY_FILE_LOC] = prefer_loc
        _check_result[CHECK_RESULT_KEY_FILE_MATCH] = __check_match(_obj, file_md5, file_size)
        if true ~= _check_result[CHECK_RESULT_KEY_FILE_MATCH] then
          file_exist, _obj = __check_file_exists(minor_loc, file_name)
          if file_exist and __check_match(_obj, file_md5, file_size) then
            _check_result[CHECK_RESULT_KEY_FILE_LOC] = minor_loc
            _check_result[CHECK_RESULT_KEY_FILE_MATCH] = true
          end
        end
      else
        file_exist, _obj = __check_file_exists(minor_loc, file_name)
        if file_exist then
          _check_result[CHECK_RESULT_KEY_FILE_EXIST] = true
          _check_result[CHECK_RESULT_KEY_FILE_LOC] = minor_loc
          _check_result[CHECK_RESULT_KEY_FILE_MATCH] = __check_match(_obj, file_md5, file_size)
        end
      end
      return _check_result
    end
    
    if true == preffer_using_data_res then
      check_result = _get_check_result(LOCATION.DATA, LOCATION.PACKAGE)
    else
      check_result = _get_check_result(LOCATION.PACKAGE, LOCATION.DATA)
    end
    return check_result
  end
  
  for _, origin_file_info in ipairs(target_file_list.file_list) do
    local file_name = origin_file_info.to or ""
    local check_result = _check_file_valid(origin_file_info)
    if true == check_result[CHECK_RESULT_KEY_IGNORE] then
    elseif true == check_result[CHECK_RESULT_KEY_FILE_EXIST] and true ~= check_result[CHECK_RESULT_KEY_FILE_MATCH] then
      local using_version = res_using_version
      if check_result[CHECK_RESULT_KEY_FILE_LOC] == LOCATION.PACKAGE then
        using_version = res_pkg_version
      end
      local patch_file_info
      for _, info in ipairs(patches_file_info) do
        if info.from == using_version then
          patch_file_info = info
          download_patch_file_list.folder = patch_file_info.folder
          break
        end
      end
      if patch_file_info and next(patch_file_info.file_list) then
        local _file_info = patch_file_info.file_list[file_name]
        if not _file_info or false == has_hpatchz() then
          E.LOG.d(TAG, "file_name not exists=" .. file_name)
          table.insert(download_origin_file_list.file_list, origin_file_info)
        else
          table.insert(download_patch_file_list.file_list, _file_info)
        end
        if check_result[CHECK_RESULT_KEY_FILE_LOC] == LOCATION.PACKAGE then
          E.LOG.d(TAG, "exist! remove file " .. file_name .. " from data")
          file_list_helpers[LOCATION.DATA]:remove_file(file_name)
        end
      else
        table.insert(download_origin_file_list.file_list, origin_file_info)
      end
    elseif true ~= check_result[CHECK_RESULT_KEY_FILE_EXIST] then
      table.insert(download_origin_file_list.file_list, origin_file_info)
    elseif check_result[CHECK_RESULT_KEY_FILE_MATCH] and check_result[CHECK_RESULT_KEY_FILE_LOC] == LOCATION.PACKAGE and true == (dest_file_info[file_name] or {}).exists then
      E.LOG.d(TAG, "match! remove file " .. file_name .. " from data")
      file_list_helpers[LOCATION.DATA]:remove_file(file_name)
    end
  end
  E.LOG.debug(TAG, "download_origin_file_list count:" .. tostring(#download_origin_file_list.file_list))
  file_list_helpers[LOCATION.DATA]:save()
  return download_origin_file_list, download_patch_file_list
end

function M.hotfix_res_download_check(res_info, target_file_list, patches_file_info, black_file_list, opts, cb)
  E.LOG.debug(TAG, "hotfix_res_download_check begin")
  opts = opts or {}
  patches_file_info = patches_file_info and UTIL.deepcopy(patches_file_info) or {}
  for _, file_info in ipairs(patches_file_info) do
    file_info.file_list = translate_patch_file_list(file_info.file_list)
  end
  local namespace = res_info.namespace
  local using_res_key = res_info.res_key
  local pkg_res_list_dir = res_info.pkg_res_list_dir
  local res_key = GMR.get_real_res_key(using_res_key)
  local startup_local_res_info = SC.get_startup_local_res_infos()
  local startup_res_info = startup_local_res_info[namespace] and startup_local_res_info[namespace][res_key]
  if nil == startup_res_info or nil == next(startup_res_info) then
    cb(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_KEY_INVALID, "res_info not found, please check namespace and res_key")
    return
  end
  local res_pkg_version = startup_res_info.pkg_res_version
  local default_res_state = RTM.static_get_local_res_state(namespace, res_key)
  local using_res_state = default_res_state
  local is_default = not E.Utils.start_with(using_res_key, RTM.RES_GROUP_INFO_KEY.PREFIX)
  if not is_default and res_key ~= using_res_key then
    using_res_state = RTM.static_get_local_res_state(namespace, using_res_key)
  end
  local res_save_base_path = startup_res_info.res_save_base_path
  local res_save_storage_type = startup_res_info.res_save_storage_type
  local apply_dest_path = ER_UTILS.get_apply_dest_path(res_save_storage_type, res_save_base_path)
  local data_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(apply_dest_path, false)
  pkg_res_list_dir = pkg_res_list_dir or startup_res_info.pkg_res_path
  local pkg_res_file_path = E.Path.join(pkg_res_list_dir, RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_FILE_LIST)
  E.LOG.d(TAG, "pkg_res_file_path=" .. pkg_res_file_path)
  local pkg_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(pkg_res_list_dir, true)
  local target_file_list_in_apply = {}
  for _, file_info in ipairs(target_file_list.file_list) do
    table.insert(target_file_list_in_apply, file_info.to)
  end
  E.File.process_batch_info(target_file_list_in_apply, function(ret)
    local function get_md5(batch_info, md5_cb)
      if opts.check_md5 == true then
        E.File.process_batch_md5(target_file_list_in_apply, function(succ3, ...)
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
      local file_list_location = {
        [LOCATION.DATA] = data_res_qz_local_file_list,
        [LOCATION.PACKAGE] = pkg_res_qz_local_file_list
      }
      local checking_info = {
        apply_path = apply_dest_path,
        is_default = is_default,
        pkg_version = res_pkg_version,
        data_version = (default_res_state or {}).using_res_info or {}.version,
        using_version = (using_res_state or {}).using_res_info or {}.version
      }
      E.LOG.debug(TAG, "checking_info:")
      E.log(checking_info)
      local process_download_origin_list, process_download_patch_list = _hotfix_res_download_check(target_file_list, patches_file_info, black_file_list, ret, checking_info, file_list_location, opts)
      cb(true, process_download_origin_list, process_download_patch_list)
    end)
  end, {
    is_full_path = true,
    base_path = apply_dest_path,
    check_size = opts.check_size
  })
end

function M.integrity_check(res_info, target_file_list, opts, cb)
  local error_file_list = {}
  opts = opts or {}
  M.hotfix_res_download_check(res_info, target_file_list, {}, {}, {
    check_md5 = opts.check_md5 ~= false,
    check_size = opts.check_size or false
  }, function(succ, ...)
    if succ then
      local origin_list, _patch_list = ...
      local file_list = origin_list.file_list or {}
      if not file_list or not next(file_list) then
        cb(true)
        E.LOG.d(TAG .. "#integrity", "check succ")
      else
        for _, missing_file in ipairs(file_list) do
          error_file_list[missing_file.to] = {
            md5 = missing_file.md5,
            size = missing_file.size
          }
        end
        cb(false, {
          code = EC.RES_CHECK_CODE.PASS_WITH_ERROR,
          msg = "integrity check failed",
          abnormal_list = error_file_list
        })
        E.LOG.d(TAG .. "#integrity", {error_file_list = error_file_list})
      end
    else
      local code, msg = ...
      cb(false, {
        code = code == EC.RESOURCE_UPDATE_ERROR_CODES.RES_KEY_INVALID and EC.RES_CHECK_CODE.ERROR_INVALID_PARAMS or EC.RES_CHECK_CODE.ERROR_KNOWN,
        msg = msg,
        abnormal_list = {}
      })
      E.LOG.d(TAG .. "#integrity", "hotfix check failed,code:" .. code)
    end
  end)
end

return M
