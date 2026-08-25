local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
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
  local patch_target_file_list = {}
  local patch_down_file_list = ext_info.file_list
  local origin_down_file_list = ext_info.down_origin_file_list
  local namespace = ext_info.namespace
  local res_key = ext_info.res_key
  M.group_cache_info[namespace] = M.group_cache_info[namespace] or {}
  M.group_cache_info[namespace][res_key] = M.group_cache_info[namespace][res_key] or {}
  M.group_cache_info[namespace][res_key].diff_file_info = {}
  M.group_cache_info[namespace][res_key].move_map = {}
  M.group_cache_info[namespace][res_key].target_move_info_map = {}
  local group_target_move_info_map = M.group_cache_info[namespace][res_key].target_move_info_map
  local patch_file_info = M.group_cache_info[namespace][res_key].diff_file_info
  patch_file_info.target_origin_file_list = {}
  patch_file_info.diff_file_list = {}
  patch_file_info.target_md5_list = {}
  M.group_cache_info[namespace][res_key].download_origin_file_list = {}
  local download_origin_file_list = M.group_cache_info[namespace][res_key].download_origin_file_list
  for _, file_info in pairs(patch_down_file_list) do
    local file_path = file_info.to
    if E.Utils.end_with(file_path, ".diff") then
      local origin_file_path = E.Utils.trim_end(file_path, ".diff")
      local target_file_info = target_file_list_map[origin_file_path]
      local current_file_info = current_file_list_info[origin_file_path] or {}
      if target_file_info.md5 ~= current_file_info.md5 then
        table.insert(patch_target_file_list, file_info)
        table.insert(patch_file_info.target_origin_file_list, origin_file_path)
        table.insert(patch_file_info.diff_file_list, file_info.to)
        table.insert(patch_file_info.target_md5_list, target_file_info.md5)
        group_target_move_info_map[target_file_info.to] = target_file_info.md5
      end
    else
      local target_file_info = target_file_list_map[file_path]
      local current_file_info = current_file_list_info[file_path] or {}
      if target_file_info.md5 ~= current_file_info.md5 then
        table.insert(patch_target_file_list, file_info)
        table.insert(download_origin_file_list, file_info.to)
        group_target_move_info_map[file_info.to] = file_info.md5
      end
    end
  end
  local origin_target_file_list = origin_down_file_list and next(origin_down_file_list) ~= nil and {} or nil
  if origin_down_file_list and next(origin_down_file_list) then
    for _, file_info in pairs(origin_down_file_list) do
      table.insert(origin_target_file_list, file_info)
      table.insert(download_origin_file_list, file_info.to)
      group_target_move_info_map[file_info.to] = file_info.md5
    end
  end
  E.LOG.debug(TAG, "patch_target_file_list size is " .. tostring(#patch_target_file_list))
  file_list_cb(true, origin_target_file_list, patch_target_file_list)
end

function M.on_res_apply(engine_context, res_location, apply_dest_path, cb, ori_progress_cb)
  E.log("res_location is >> " .. tostring(res_location))
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
  local group_cache_info = M.group_cache_info[namespace][res_key] or {}
  local temp_dir_path, _relative_temp_dir_path = ER_UTILS.get_temp_dir_path(namespace, res_key, apply_dest_path)
  local temp_dir_exist = E.File.exists(temp_dir_path, true)
  if temp_dir_exist then
    E.File.remove_fullpath(temp_dir_path)
  end
  local mkdir_succ = E.File.make_dirs(temp_dir_path)
  if not mkdir_succ then
    cb(false, EC.PATCH_ERROR.CODE_MAKE_TEMP_DIR_ERROR, "make temp dir error, temp dir path is " .. tostring(temp_dir_path))
    return
  end
  local download_origin_file_list = group_cache_info.download_origin_file_list or {}
  for _, origin_file_to in ipairs(download_origin_file_list) do
    local source_path = E.Path.join(res_location, origin_file_to)
    local target_path = E.Path.join(apply_dest_path, origin_file_to)
    group_cache_info.move_map[source_path] = target_path
  end
  local pkg_res_path = res_info.pkg_res_path or ""
  local options = {
    resPkgDirPath = pkg_res_path,
    oldDirPath = apply_dest_path,
    patchDirPath = res_location,
    newDirPath = temp_dir_path
  }
  local res_diff_info = group_cache_info.diff_file_info or {}
  local patch_files_params = {
    options = options,
    oldFilePaths = res_diff_info.target_origin_file_list or {},
    patchFilePaths = res_diff_info.diff_file_list or {},
    newFilePaths = res_diff_info.target_origin_file_list or {},
    newFileMd5Array = res_diff_info.target_md5_list or {}
  }
  E.LOG.debug(TAG, "patch files params is >>>>")
  E.LOG.debug(TAG, "patch file count = " .. #patch_files_params.patchFilePaths .. ", patch_files_params.options >>")
  E.LOG.debug(TAG, patch_files_params.options)
  local storage_type = ER_UTILS.try_get_storage_type(RTM.STORAGE_TYPE.EXTERNAL_OTHER, apply_dest_path)
  E.patch_files(patch_files_params, function(succ, code, ...)
    if not succ then
      if 1 == code then
        local patch_succ_files, patch_fail_files = ...
        if not patch_fail_files then
          E.log("patch files error.")
          cb(false, EC.PATCH_ERROR.CODE_PATCH_PART_ERROR, "patch files error, patch_fail_files invalid")
          return
        end
        E.LOG.debug(TAG, "patch files fail, now start move files, patch files is >>>>")
        E.LOG.debug(TAG, patch_fail_files)
        if patch_succ_files and next(patch_succ_files) then
          for _, file_path in ipairs(patch_succ_files) do
            local source_path = E.Path.join(temp_dir_path, file_path)
            local target_path = E.Path.join(apply_dest_path, file_path)
            group_cache_info.move_map[source_path] = target_path
          end
        end
        engine_context.download_res_files(patch_fail_files, {res_save_storage_type = storage_type}, function(download_succ, ...)
          if download_succ then
            E.log("patch fail files, re download succ, now start move file")
            local _, ext_obj = ...
            local ejoy_temp_dest_abs_dir = ext_obj.ejoy_temp_dest_abs_dir
            for _, file_path in ipairs(patch_fail_files) do
              local source_path = E.Path.join(ejoy_temp_dest_abs_dir, file_path)
              local target_path = E.Path.join(apply_dest_path, file_path)
              group_cache_info.move_map[source_path] = target_path
            end
            END.dispatch_confirm_res_apply(namespace, res_key, function()
              ER_UTILS.batch_move_res_file(apply_dest_path, group_cache_info.move_map, group_cache_info.target_move_info_map, function(batch_move_succ, ...)
                if batch_move_succ then
                  M.clear_cache_info(namespace, res_key)
                  progress_cb(APPLY_STATE.COMPLETE, {percent = 100})
                  cb(true, true)
                else
                  progress_cb(APPLY_STATE.FAIL, {percent = curPercent})
                  cb(false, ...)
                end
              end)
            end)
          else
            local err_code, err_msg = ...
            cb(false, err_code, err_msg)
            E.log("patch fail files, re download fail, code is " .. tostring(err_code) .. ", msg is " .. tostring(err_msg))
          end
        end, function(_state, _state_obj)
        end, function(re_download_progress_info)
          curPercent = re_download_progress_info.percent
          progress_cb(APPLY_STATE.RE_DOWNLOAD, {percent = curPercent})
        end)
      else
        cb(false, code, "patch files error")
      end
    else
      E.LOG.debug(TAG, "patch files all succ, now start move files")
      for _, file_path in ipairs(res_diff_info.target_origin_file_list) do
        local source_path = E.Path.join(temp_dir_path, file_path)
        local target_path = E.Path.join(apply_dest_path, file_path)
        group_cache_info.move_map[source_path] = target_path
      end
      
      local function batch_move_files()
        ER_UTILS.batch_move_res_file(apply_dest_path, group_cache_info.move_map, group_cache_info.target_move_info_map, function(batch_move_succ, ...)
          if batch_move_succ then
            M.clear_cache_info(namespace, res_key)
            progress_cb(APPLY_STATE.COMPLETE, {percent = 100})
            cb(true, true)
          else
            progress_cb(APPLY_STATE.FAIL, {percent = curPercent})
            cb(false, ...)
          end
        end)
      end
      
      END.dispatch_confirm_res_apply(namespace, res_key, function()
        batch_move_files()
      end)
    end
  end, function(patch_complete_count, patch_total_count)
    curPercent = math.floor(patch_complete_count / patch_total_count * 100)
    progress_cb(APPLY_STATE.PATCH, {percent = curPercent})
  end)
end

function M.on_origin_res_apply(engine_context, res_location, apply_dest_path, cb)
  E.LOG.debug(TAG, "call on_origin_res_apply >>>>>")
  local namespace, res_key, _res_info = engine_context.get_res_info()
  local group_cache_info = M.group_cache_info[namespace][res_key] or {}
  local download_origin_file_list = group_cache_info.download_origin_file_list or {}
  for _, origin_file_to in ipairs(download_origin_file_list) do
    local source_path = E.Path.join(res_location, origin_file_to)
    local target_path = E.Path.join(apply_dest_path, origin_file_to)
    group_cache_info.move_map[source_path] = target_path
  end
  END.dispatch_confirm_res_apply(namespace, res_key, function()
    ER_UTILS.batch_move_res_file(apply_dest_path, group_cache_info.move_map, group_cache_info.target_move_info_map, function(succ, ...)
      if succ then
        M.clear_cache_info(namespace, res_key)
      end
      cb(succ, ...)
    end)
  end)
end

return M
