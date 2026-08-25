local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local PRE_CHECK = require("ejoysdk_lua.res.predownload.ejoy_pre_res_check")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local SLICE_SIZE = 1000
local M = {}
local TAG = "STARTUP#" .. EM.MODULE.RES .. "ejoysdk_default_group_engine_handler"
M.group_cache_info = {}
local APPLY_STATE = {
  IDLE = "idle",
  PATCH = "patch",
  CHECK = "check",
  RE_DOWNLOAD = "re_download",
  COMPLETE = "complete",
  FAIL = "fail"
}

function M.clear_cache_info(namespace, res_key)
  local ns_cache_info = M.group_cache_info[namespace] or {}
  ns_cache_info[res_key] = {}
end

local function _add_caching_file(map, path_map, info_map, file_name, src_path, dst_path)
  local _map_size = #map
  local _curr_map = map[_map_size]
  if _map_size <= 0 or _curr_map.size > SLICE_SIZE then
    _curr_map = {
      size = 0,
      list = {}
    }
    table.insert(map, _curr_map)
  end
  local _map_list = _curr_map.list
  if not _map_list[src_path] then
    _curr_map.size = _curr_map.size + 1
  end
  _map_list[src_path] = dst_path
  path_map[dst_path] = info_map[file_name]
end

local function _is_startup(namespace, res_key)
  local startup_local_res_info = SC.get_startup_game_origin_params() or {}
  return namespace == startup_local_res_info.namespace and res_key == startup_local_res_info.res_key
end

local function _slice_batch_apply(res_info, apply_dest_path, group_cache_info, cb)
  local _slice_batch
  local _batch_funcs = {
    ER_UTILS.batch_move_res_file,
    ER_UTILS.batch_copy_res_file
  }
  local _batch_maps = {
    {
      group_cache_info.move_map,
      group_cache_info.target_path_move_info_map
    },
    {
      group_cache_info.copy_map,
      group_cache_info.target_path_copy_info_map
    }
  }
  
  local function _batch_succ(_slice_succ, ...)
    if true == _slice_succ then
      if _is_startup(res_info.namespace, res_info.res_key) then
        local _update_file_list = {}
        for _, map in ipairs(_batch_maps) do
          for _, _slice in ipairs(map[1]) do
            for _, dst_path in pairs(_slice.list) do
              table.insert(_update_file_list, map[2][dst_path])
            end
          end
        end
        SC.set_startup_update_file_list(_update_file_list)
      end
      M.clear_cache_info(res_info.namespace, res_info.res_key)
    end
    cb(_slice_succ or false, ...)
  end
  
  function _slice_batch(_func_index, _index, _slice_succ, ...)
    if not _slice_succ or _func_index > #_batch_funcs then
      _batch_succ(_slice_succ, ...)
      return
    end
    local _func = _batch_funcs[_func_index]
    local _map = _batch_maps[_func_index][1]
    local _path_map = _batch_maps[_func_index][2]
    if _index <= #_map then
      local _m_map = _map[_index]
      _func(apply_dest_path, _m_map.list, _path_map, function(batch_move_succ, ...)
        _slice_batch(_func_index, _index + 1, batch_move_succ, ...)
      end)
    else
      _slice_batch(_func_index + 1, 1, _slice_succ, ...)
    end
  end
  
  _slice_batch(1, 1, true)
end

function M.on_process_file_list(ext_info, file_list_cb)
  E.LOG.debug(TAG, "ext_info >>>>")
  E.LOG.debug(TAG, "namespace: " .. ext_info.namespace)
  E.LOG.debug(TAG, "res_key: " .. ext_info.res_key)
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local startup_res_info = EF.get_startup_res_info()
  E.LOG.debug(TAG, "startup_res_info is ")
  E.LOG.debug(TAG, startup_res_info)
  local res_save_base_path = startup_res_info.res_save_base_path
  local res_save_storage_type = startup_res_info.res_save_storage_type
  local apply_dest_path = ER_UTILS.get_apply_dest_path(res_save_storage_type, res_save_base_path)
  E.LOG.debug(TAG, "apply_dest_path is " .. tostring(apply_dest_path))
  local current_file_list_info = RTM.static_get_using_res_file_list(apply_dest_path) or {}
  local origin_file_list = ext_info.origin_file_list
  local target_file_list_map = {}
  for _, origin_file_info in pairs(origin_file_list) do
    target_file_list_map[origin_file_info.to] = origin_file_info
  end
  local opts = ext_info.opts or {}
  local patch_target_file_list = {}
  local patch_down_file_list = ext_info.file_list or {}
  local origin_down_file_list = ext_info.down_origin_file_list or {}
  local reuse_file_lists = ext_info.reuse_file_lists or {}
  local namespace = ext_info.namespace
  local res_key = ext_info.res_key
  M.group_cache_info[namespace] = M.group_cache_info[namespace] or {}
  M.group_cache_info[namespace][res_key] = M.group_cache_info[namespace][res_key] or {}
  M.group_cache_info[namespace][res_key].diff_file_info = {}
  M.group_cache_info[namespace][res_key].move_map = {}
  M.group_cache_info[namespace][res_key].copy_map = {}
  M.group_cache_info[namespace][res_key].target_move_info_map = {}
  M.group_cache_info[namespace][res_key].target_copy_info_map = {}
  M.group_cache_info[namespace][res_key].target_path_move_info_map = {}
  M.group_cache_info[namespace][res_key].target_path_copy_info_map = {}
  local group_target_move_info_map = M.group_cache_info[namespace][res_key].target_move_info_map
  local group_target_copy_info_map = M.group_cache_info[namespace][res_key].target_copy_info_map
  local patch_file_info = M.group_cache_info[namespace][res_key].diff_file_info
  local location_list = {
    PRE_CHECK.LOCATION.DEFAULT
  }
  if opts[RTM.RES_UPDATES_OPTIONS.USING_PREDOWNLOAD] == false == false then
    table.insert(location_list, PRE_CHECK.LOCATION.PREDOWNLOAD)
  end
  for _, _location in ipairs(location_list) do
    patch_file_info[_location] = {
      target_origin_file_list = {},
      diff_file_list = {},
      target_md5_list = {},
      target_size_list = {}
    }
  end
  M.group_cache_info[namespace][res_key].download_origin_file_list = {
    can_move = true,
    file_list = {}
  }
  local download_origin_file_list = M.group_cache_info[namespace][res_key].download_origin_file_list
  for _, file_info in pairs(patch_down_file_list) do
    local file_path = file_info.to
    if E.Utils.end_with(file_path, ".diff") then
      local origin_file_path = E.Utils.trim_end(file_path, ".diff")
      local target_file_info = target_file_list_map[origin_file_path]
      local current_file_info = current_file_list_info[origin_file_path] or {}
      if target_file_info.md5 ~= current_file_info.md5 then
        local target_location_list = patch_file_info[file_info.location or PRE_CHECK.LOCATION.DEFAULT]
        table.insert(patch_target_file_list, file_info)
        table.insert(target_location_list.target_origin_file_list, origin_file_path)
        table.insert(target_location_list.diff_file_list, file_info.to)
        table.insert(target_location_list.target_md5_list, target_file_info.md5)
        table.insert(target_location_list.target_size_list, target_file_info.size)
        group_target_move_info_map[target_file_info.to] = {
          to = origin_file_path,
          md5 = target_file_info.md5,
          size = target_file_info.size
        }
      end
    else
      local target_file_info = target_file_list_map[file_path]
      local current_file_info = current_file_list_info[file_path] or {}
      if target_file_info.md5 ~= current_file_info.md5 then
        table.insert(patch_target_file_list, file_info)
        table.insert(download_origin_file_list.file_list, file_info.to)
        group_target_move_info_map[file_info.to] = file_info
      end
    end
  end
  local origin_target_file_list = origin_down_file_list and next(origin_down_file_list) ~= nil and {} or nil
  if origin_down_file_list and next(origin_down_file_list) then
    for _, file_info in pairs(origin_down_file_list) do
      local file_path = file_info.to
      local target_file_info = target_file_list_map[file_path]
      local current_file_info = current_file_list_info[file_path] or {}
      if target_file_info.md5 ~= current_file_info.md5 then
        table.insert(origin_target_file_list, file_info)
        table.insert(download_origin_file_list.file_list, file_info.to)
        group_target_move_info_map[file_info.to] = file_info
      end
    end
  end
  local _reuse_file_lists = {}
  M.group_cache_info[namespace][res_key].reuse_file_lists = _reuse_file_lists
  for _, reuse_file_list in ipairs(reuse_file_lists) do
    local _reuse_f_l = {
      can_move = reuse_file_list.can_move == true,
      src_path = reuse_file_list.src_path,
      file_list = {}
    }
    table.insert(_reuse_file_lists, _reuse_f_l)
    for _, file_info in pairs(reuse_file_list.file_list or {}) do
      if reuse_file_list.can_move == true then
        group_target_move_info_map[file_info.to] = file_info
      else
        group_target_copy_info_map[file_info.to] = file_info
      end
      table.insert(_reuse_f_l.file_list, file_info.to)
    end
  end
  E.LOG.debug(TAG, "patch_target_file_list size is " .. tostring(#patch_target_file_list))
  file_list_cb(true, origin_target_file_list, patch_target_file_list)
end

local function _prepare_origin_file_map(_group_cache_info, _apply_dest_path, _res_location)
  local download_origin_file_list = _group_cache_info.download_origin_file_list or {}
  local origin_file_lists = {download_origin_file_list}
  for _, reuse_file_list in ipairs(_group_cache_info.reuse_file_lists or {}) do
    table.insert(origin_file_lists, reuse_file_list)
  end
  for _index, file_list in ipairs(origin_file_lists) do
    local src_res_location = file_list.src_path or _res_location
    local is_copy = file_list.can_move == false
    E.LOG.d(TAG, "src_res_location:" .. src_res_location)
    E.LOG.d(TAG, "apply_dest_path:" .. _apply_dest_path)
    local src_map = is_copy and _group_cache_info.copy_map or _group_cache_info.move_map
    local path_info_map = is_copy and _group_cache_info.target_path_copy_info_map or _group_cache_info.target_path_move_info_map
    local info_map = is_copy and _group_cache_info.target_copy_info_map or _group_cache_info.target_move_info_map
    for _, file_path in ipairs(file_list.file_list or {}) do
      E.LOG.d(TAG, "file to :" .. file_path)
      local source_path = E.Path.join(src_res_location, file_path)
      local target_path = E.Path.join(_apply_dest_path, file_path)
      _add_caching_file(src_map, path_info_map, info_map, file_path, source_path, target_path)
    end
  end
end

function M.on_res_apply(engine_context, res_location, apply_dest_path, cb, ori_progress_cb)
  local last_percent, last_state
  local last_notify_time = 0
  
  local function progress_cb(state, progress_info)
    local percent = progress_info.percent
    local current_time = os.time()
    local interval_time = current_time - last_notify_time
    local notify_interval_time = 1
    if last_percent ~= percent and interval_time > notify_interval_time or last_state ~= state then
      last_percent = percent
      last_state = state
      last_notify_time = current_time
      ori_progress_cb(state, progress_info)
    end
  end
  
  progress_cb(APPLY_STATE.IDLE, {percent = 0})
  local curPercent = 0
  local namespace, res_key, res_info = engine_context.get_res_info()
  E.LOG.d(TAG, "namespace=" .. (namespace or "nil"))
  E.LOG.d(TAG, "res_key=" .. (res_key or "nil"))
  local group_cache_info = M.group_cache_info[namespace][res_key] or {}
  local temp_dir_path, _relative_temp_dir_path = ER_UTILS.get_temp_dir_path(namespace, res_key, apply_dest_path)
  local temp_dir_exist = E.File.exists(temp_dir_path, true)
  if not temp_dir_exist then
    local mkdir_succ = E.File.make_dirs(temp_dir_path)
    if not mkdir_succ then
      cb(false, EC.PATCH_ERROR.CODE_MAKE_TEMP_DIR_ERROR, "make temp dir error, temp dir path is " .. tostring(temp_dir_path))
      return
    end
  end
  _prepare_origin_file_map(group_cache_info, apply_dest_path, res_location)
  local pkg_res_path = res_info.pkg_res_path or ""
  local res_diff_info = group_cache_info.diff_file_info or {}
  local storage_type = ER_UTILS.try_get_storage_type(RTM.STORAGE_TYPE.EXTERNAL_OTHER, apply_dest_path)
  
  local function _batch_files_finish(_cb)
    local function cb_wrapper(batch_succ, ...)
      if batch_succ then
        E.File.remove_fullpath(temp_dir_path)
        
        progress_cb(APPLY_STATE.COMPLETE, {percent = 100})
        _cb(true, true)
      else
        progress_cb(APPLY_STATE.FAIL, {percent = curPercent})
        _cb(false, ...)
      end
    end
    
    END.dispatch_confirm_res_apply(namespace, res_key, function()
      _slice_batch_apply({namespace = namespace, res_key = res_key}, apply_dest_path, group_cache_info, cb_wrapper)
    end)
  end
  
  local _patch_files, _download_origin_files, _patch_file_next
  local _locations = {
    PRE_CHECK.LOCATION.DEFAULT
  }
  local _total_patch_length = #((res_diff_info[PRE_CHECK.LOCATION.DEFAULT] or {}).diff_file_list or {})
  if res_diff_info[PRE_CHECK.LOCATION.PREDOWNLOAD] and next(res_diff_info[PRE_CHECK.LOCATION.PREDOWNLOAD]) then
    table.insert(_locations, PRE_CHECK.LOCATION.PREDOWNLOAD)
    _total_patch_length = _total_patch_length + #((res_diff_info[PRE_CHECK.LOCATION.PREDOWNLOAD] or {}).diff_file_list or {})
  end
  local _patch_fail_list = {}
  
  function _patch_file_next(index)
    E.LOG.d(TAG, "index=" .. tostring(index) .. ",locations=" .. tostring(#_locations))
    if index <= #_locations then
      local loc = _locations[index]
      E.LOG.d(TAG, "loc=" .. tostring(loc))
      local _res_diff_info = res_diff_info[loc] or {}
      local _patch_file_length = #(_res_diff_info.diff_file_list or {})
      if _patch_file_length > 0 then
        _patch_files(loc, res_diff_info[loc], function(succ, code, ...)
          if not succ then
            if 1 == code then
              local _patch_fail_file_list = (...)
              UTILS.merge_table(_patch_fail_list, _patch_fail_file_list or {})
              _patch_file_next(index + 1)
            else
              cb(succ, code, ...)
            end
          else
            _patch_file_next(index + 1)
          end
        end, function(_state, _percent)
          local correct_percent = math.floor(_percent * _patch_file_length / _total_patch_length)
          E.LOG.d(TAG, string.format("patch file length:%d, total_patch_length:%d, total_percent:%f", _patch_file_length, _total_patch_length, correct_percent))
          progress_cb(_state, {percent = correct_percent})
        end)
      else
        _patch_file_next(index + 1)
      end
    else
      E.LOG.d(TAG, {
        _patch_file_list = _patch_fail_list or "nil"
      })
      if _patch_fail_list and next(_patch_fail_list) then
        _download_origin_files(_patch_fail_list, function(succ, ...)
          if true == succ then
            _batch_files_finish(cb)
          else
            local _code, _msg = ...
            cb(false, _code, _msg)
          end
        end, function(_state, _percent)
          progress_cb(_state, {percent = _percent})
        end)
      else
        E.LOG.d(TAG, "no patch _fail list")
        _batch_files_finish(cb)
      end
    end
  end
  
  function _download_origin_files(patch_fail_files, _down_cb, _down_progress_cb)
    engine_context.download_res_files(patch_fail_files, {res_save_storage_type = storage_type}, function(download_succ, ...)
      if download_succ then
        E.log("patch fail files, re download succ, now start move file")
        local _, ext_obj = ...
        local ejoy_temp_dest_abs_dir = ext_obj.ejoy_temp_dest_abs_dir
        for _, file_path in ipairs(patch_fail_files) do
          local source_path = E.Path.join(ejoy_temp_dest_abs_dir, file_path)
          local target_path = E.Path.join(apply_dest_path, file_path)
          _add_caching_file(group_cache_info.move_map, group_cache_info.target_path_move_info_map, group_cache_info.target_move_info_map, file_path, source_path, target_path)
        end
        _down_cb(true)
      else
        local err_code, err_msg = ...
        _down_cb(false, err_code, err_msg)
        E.log("patch fail files, re download fail, code is " .. tostring(err_code) .. ", msg is " .. tostring(err_msg))
      end
    end, function(_state, _state_obj)
    end, function(re_download_progress_info)
      local _curPercent = re_download_progress_info.percent
      _down_progress_cb(APPLY_STATE.RE_DOWNLOAD, _curPercent)
    end)
  end
  
  function _patch_files(_patch_loc, _patch_res_diff_info, _patch_cb, _patch_progrsss_cb)
    local _apply_dest_path = apply_dest_path
    local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
    if _patch_loc == PRE_CHECK.LOCATION.PREDOWNLOAD and not PREDOWNLOAD_MGR.UTILS.is_predownload(res_key) then
      _apply_dest_path = _apply_dest_path .. "/" .. CONSTANTS.RES_PREDOWNLOAD.FOLDER_NAME
    elseif _patch_loc == PRE_CHECK.LOCATION.DEFAULT and PREDOWNLOAD_MGR.UTILS.is_predownload(res_key) then
      local EHU = require("ejoysdk_lua.res.ejoy_http_res_utils")
      _apply_dest_path = EHU.get_parent_folder(_apply_dest_path)
    end
    local options = {
      resPkgDirPath = pkg_res_path,
      oldDirPath = _apply_dest_path,
      patchDirPath = res_location,
      newDirPath = temp_dir_path
    }
    local patch_files_params = {
      options = options,
      oldFilePaths = _patch_res_diff_info.target_origin_file_list or {},
      patchFilePaths = _patch_res_diff_info.diff_file_list or {},
      newFilePaths = _patch_res_diff_info.target_origin_file_list or {},
      newFileMd5Array = _patch_res_diff_info.target_md5_list or {}
    }
    E.LOG.debug(TAG, {patch_files_params = patch_files_params})
    local RES_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
    local apply_res_qz_local_file_list = RES_FILE_LIST.static_get_file_list(temp_dir_path, false) or {}
    E.patch_files(patch_files_params, function(succ, code, ...)
      local function _process_succ_file_list(patch_succ_files)
        if patch_succ_files and next(patch_succ_files) then
          for _, file_path in ipairs(patch_succ_files) do
            local source_path = E.Path.join(temp_dir_path, file_path)
            
            local target_path = E.Path.join(apply_dest_path, file_path)
            _add_caching_file(group_cache_info.move_map, group_cache_info.target_path_move_info_map, group_cache_info.target_move_info_map, file_path, source_path, target_path)
            local _file_info = group_cache_info.target_move_info_map[file_path] or group_cache_info.target_copy_info_map[file_path]
            if _file_info then
              apply_res_qz_local_file_list:update_file(file_path, _file_info.md5, _file_info.size)
            end
          end
          apply_res_qz_local_file_list:save()
        end
      end
      
      if not succ then
        if 1 == code then
          local patch_succ_files, patch_fail_files = ...
          if not patch_fail_files then
            E.log("patch files error.")
            cb(false, EC.PATCH_ERROR.CODE_PATCH_PART_ERROR, "patch files error, patch_fail_files invalid")
            return
          end
          E.LOG.debug(TAG, "patch files fail, now start move files, patch files is >>>>")
          E.LOG.debug(TAG, {patch_succ = patch_succ_files})
          E.LOG.debug(TAG, {patch_fail = patch_fail_files})
          _process_succ_file_list(patch_succ_files)
          _patch_cb(succ, code, patch_fail_files)
        else
          _patch_cb(false, code, "patch files error")
        end
      else
        E.LOG.debug(TAG, "patch files all succ, now start move files")
        E.LOG.d(TAG, {res_diff_info = _patch_res_diff_info})
        _process_succ_file_list(_patch_res_diff_info.target_origin_file_list)
        _patch_cb(true)
      end
    end, function(patch_complete_count, patch_total_count)
      curPercent = math.floor(patch_complete_count / patch_total_count * 100)
      _patch_progrsss_cb(APPLY_STATE.PATCH, curPercent)
    end)
  end
  
  _patch_file_next(1)
end

function M.on_origin_res_apply(engine_context, res_location, apply_dest_path, cb)
  E.LOG.debug(TAG, "call on_origin_res_apply >>>>>")
  local namespace, res_key, _res_info = engine_context.get_res_info()
  local group_cache_info = M.group_cache_info[namespace][res_key] or {}
  _prepare_origin_file_map(group_cache_info, apply_dest_path, res_location)
  END.dispatch_confirm_res_apply(namespace, res_key, function()
    _slice_batch_apply({namespace = namespace, res_key = res_key}, apply_dest_path, group_cache_info, cb)
  end)
end

return M
