local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_cjson")
local EM = require("ejoysdk_lua.ejoysdk_module")
local STAT = require("ejoysdk_lua.res.res_stat")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ER_FILE_INFO_CACHE = require("ejoysdk_lua.res.ejoysdk_res_file_list_cache")
local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
local END = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local DEFAULT_GROUP_ENGINE_HANDLER = require("ejoysdk_lua.res.ejoysdk_default_group_engine_handler")
local M = {}
local TAG = "STARTUP#" .. EM.MODULE.RES .. "ejoysdk_default_engine_handler"
local is_group_mode = false
local file_list_type
local file_list = {}
local APPLY_STATE = RTM.APPLY_STATE

local function update_using_file_list_cache(res_key, apply_dest_path, cb)
  E.LOG.debug(TAG, "update_using_file_list_cache")
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local ER = require("ejoysdk_lua.res.ejoysdk_res")
  local res_state = ER.get_res_state(EF.NAMESPACES.QZ_PATCH, res_key)
  local res_update_info = res_state and res_state.res_update_info or {}
  local update_body = res_update_info.update_body or {}
  local update_version = update_body.version or ""
  ER_FILE_INFO_CACHE.update_using_file_list_cache(EF.NAMESPACES.QZ_PATCH, res_key, nil, update_version, apply_dest_path, {}, cb)
end

local function batch_delete_files(delete_file_array, cb)
  if next(delete_file_array) ~= nil then
    E.File.batch_remove(delete_file_array, function(batch_remove_succ, ...)
      cb(batch_remove_succ, ...)
    end, {is_fullpath = true})
  else
    cb(true)
  end
end

function M.on_res_apply(engine_context, res_location, apply_dest_path, cb, ori_progress_cb)
  if is_group_mode then
    E.LOG.debug(TAG, "it's group mode, now enter DEFAULT_GROUP_ENGINE_HANDLER on_res_apply")
    DEFAULT_GROUP_ENGINE_HANDLER.on_res_apply(engine_context, res_location, apply_dest_path, cb, ori_progress_cb)
    return
  end
  E.LOG.debug(TAG, string.format("on_res_apply res_location is >> %s, apply_dest_path is >> %s", tostring(res_location), tostring(apply_dest_path)))
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
  
  local function download_origin_files(file_lists, download_copy_map, download_cb)
    local storage_type
    if res_info.res_save_storage_type == nil or res_info.res_save_storage_type == RTM.STORAGE_TYPE.EXTERNAL_OTHER then
      storage_type = ER_UTILS.try_get_storage_type(res_info.res_save_storage_type, res_info.res_save_base_path)
    else
      storage_type = res_info.res_save_storage_type
    end
    engine_context.download_res_files(file_lists, {storage_type = storage_type}, function(download_succ, ...)
      if download_succ then
        local _, ext_obj = ...
        local ejoy_temp_dest_abs_dir = ext_obj.ejoy_temp_dest_abs_dir
        E.LOG.debug(TAG, "ejoy_temp_dest_abs_dir is " .. tostring(ejoy_temp_dest_abs_dir))
        for _, file_to in ipairs(file_lists) do
          local source_path = E.Path.join(ejoy_temp_dest_abs_dir, file_to)
          local target_path = E.Path.join(apply_dest_path, file_to)
          download_copy_map[source_path] = target_path
        end
        download_cb(true)
      else
        download_cb(false, ...)
      end
    end, function(_state, _state_obj)
    end, function(download_progress_info)
      curPercent = download_progress_info.percent
      progress_cb(APPLY_STATE.RE_DOWNLOAD, {percent = curPercent})
    end)
  end
  
  local function md5_check(md5_check_files, md5_check_target_info_map, md5_copy_map, md5_check_cb)
    local md5_error_msg
    local md5_error_files = {}
    local md5_check_total_count = utils.tablelength(md5_check_files)
    local md5_index = 1
    local get_md5_fun
    local batch_count = 10
    local md5_batch_check_count = math.floor(md5_check_total_count / batch_count)
    if md5_batch_check_count < 1 then
      md5_batch_check_count = 1
    end
    
    function get_md5_fun()
      local md5_check_file_paths = {}
      local md5_check_last_index = md5_index + md5_batch_check_count
      if md5_check_last_index > md5_check_total_count then
        md5_check_last_index = md5_check_total_count
      end
      for i = md5_index, md5_check_last_index do
        table.insert(md5_check_file_paths, md5_check_files[i])
      end
      E.File.batch_md5(md5_check_file_paths, function(get_md5_succ, ...)
        if get_md5_succ then
          local md5_data = (...)
          for key, value in pairs(md5_data) do
            local file_info = md5_check_target_info_map[key]
            if value ~= file_info.md5 then
              if not md5_error_msg then
                md5_error_msg = "file name is " .. tostring(file_info.to) .. ", md5 is " .. tostring(value) .. ", expect md5 is " .. tostring(file_info.md5)
              end
              E.LOG.debug(TAG, string.format("check patch file fail, file is %s, md5 is %s, expect md5 is %s", tostring(file_info.to), tostring(value), tostring(file_info.md5)))
              table.insert(md5_error_files, file_info.to)
            else
              local target_path = E.Path.join(apply_dest_path, file_info.to)
              md5_copy_map[key] = target_path
            end
          end
        else
          local md5_err_code, md5_err_msg, md5_succ_data, md5_err_data = ...
          E.LOG.debug(TAG, string.format("batch_md5 fail, code is %s, msg is %s", tostring(md5_err_code), tostring(md5_err_msg)))
          for key, value in pairs(md5_succ_data) do
            local file_info = md5_check_target_info_map[key]
            if value ~= file_info.md5 then
              if not md5_error_msg then
                md5_error_msg = "file name is " .. tostring(file_info.to) .. ", md5 is " .. tostring(value) .. ", expect md5 is " .. tostring(file_info.md5)
              end
              E.LOG.debug(TAG, string.format("check patch file fail, file is %s, md5 is %s, expect md5 is %s", tostring(file_info.to), tostring(value), tostring(file_info.md5)))
              table.insert(md5_error_files, file_info.to)
            else
              local target_path = E.Path.join(apply_dest_path, file_info.to)
              md5_copy_map[key] = target_path
            end
          end
          for key, get_md5_err_msg in pairs(md5_err_data) do
            local file_info = md5_check_target_info_map[key]
            E.LOG.debug(TAG, "key is " .. tostring(key))
            table.insert(md5_error_files, file_info.to)
            E.LOG.debug(string.format("check patch file fail, file is %s, get md5 fail,msg is %s", tostring(file_info.to), tostring(get_md5_err_msg)))
            if not md5_error_msg then
              md5_error_msg = "file name is " .. tostring(file_info.to) .. ", get md5 fail, msg is " .. tostring(get_md5_err_msg)
            end
          end
        end
        curPercent = 50 + math.floor(md5_check_last_index / md5_check_total_count * 49)
        E.LOG.debug(TAG, string.format("md5 check last index is %s, total count is %s", tostring(md5_check_last_index), tostring(md5_check_total_count)))
        progress_cb(APPLY_STATE.CHECK, {percent = curPercent})
        md5_index = md5_check_last_index + 1
        if md5_index <= md5_check_total_count then
          get_md5_fun()
        else
          md5_check_cb(md5_error_files, md5_error_msg)
        end
      end, true)
    end
    
    get_md5_fun()
  end
  
  local function patch(diff_file_name, diff_file_path, diff_info_file_path, copy_map, delete_files_array, patch_cb)
    E.LOG.debug(TAG, "start patch files, diff_file_name is " .. tostring(diff_file_name))
    local diff_info_obj
    if diff_info_file_path then
      local diff_info_file_content = E.File.readfile_fullpath(diff_info_file_path)
      diff_info_obj = JSON.safe_decode(diff_info_file_content) or {}
      local delete_files_json_array = diff_info_obj.delete_files or {}
      for _, file_info in ipairs(delete_files_json_array) do
        local target_path = E.Path.join(apply_dest_path, file_info.to)
        table.insert(delete_files_array, target_path)
      end
    end
    if diff_file_path then
      local patch_params = {
        oldDirPath = apply_dest_path,
        resPkgDirPath = res_info.pkg_res_path or "",
        patchFilePath = diff_file_path,
        newDirPath = temp_dir_path
      }
      local diff_files_array = diff_info_obj.diff_files or {}
      local diff_file_array = {}
      local diff_file_abs_path_array = {}
      local diff_files_info_map = {}
      for _, file_info in ipairs(diff_files_array) do
        table.insert(diff_file_array, file_info.to)
        local source_path = E.Path.join(temp_dir_path, file_info.to)
        table.insert(diff_file_abs_path_array, source_path)
        diff_files_info_map[source_path] = file_info
      end
      STAT.stat_on_patch_dir_begin(namespace, res_key, diff_file_name)
      local begin_time = os.time()
      E.patch_dir(patch_params, function(succ, ...)
        local cost_time = os.time() - begin_time
        if succ then
          STAT.stat_on_patch_dir_end(namespace, res_key, diff_file_name, true, cost_time, 0)
          E.LOG.debug(TAG, "patch_dir run succ, now start check md5")
          begin_time = os.time()
          md5_check(diff_file_abs_path_array, diff_files_info_map, copy_map, function(md5_error_files, md5_error_msg)
            cost_time = os.time() - begin_time
            if next(md5_error_files) then
              md5_error_msg = md5_error_msg .. ", error files count is " .. tostring(#md5_error_files)
              STAT.stat_on_patch_dir_md5_end(namespace, res_key, diff_file_name, false, cost_time, -1, md5_error_msg)
              download_origin_files(md5_error_files, copy_map, function(download_md5_err_files_succ, ...)
                if download_md5_err_files_succ then
                  E.LOG.debug(TAG, "download_md5_err_files succ")
                  patch_cb(true)
                else
                  E.LOG.debug(TAG, "download_md5_err_files fail")
                  patch_cb(false, ...)
                end
              end)
            else
              STAT.stat_on_patch_dir_md5_end(namespace, res_key, diff_file_name, true, cost_time, 0, "")
              E.LOG.debug(TAG, "check all patch file md5 succ")
              patch_cb(true)
            end
          end)
        else
          local patch_err_code = (...)
          patch_err_code = EC.PATCH_ERROR.CODE_PATCH_ERROR_BASE + tonumber(patch_err_code)
          STAT.stat_on_patch_dir_end(namespace, res_key, diff_file_name, false, cost_time, patch_err_code)
          E.LOG.debug(TAG, string.format("patch fail, error code is %s, try download origin file", tostring(patch_err_code)))
          download_origin_files(diff_file_array, copy_map, function(download_all_origin_files_succ, ...)
            if download_all_origin_files_succ then
              E.LOG.debug(TAG, "download all diff files succ")
              patch_cb(true)
            else
              E.LOG.debug(TAG, "download all diff files fail")
              patch_cb(false, ...)
            end
          end)
        end
      end, function(patch_complete_count, patch_total_count)
        curPercent = math.floor(patch_complete_count / patch_total_count * 50)
        progress_cb(APPLY_STATE.PATCH, {percent = curPercent})
      end)
    else
      E.LOG.debug(TAG, "do not have patch, callback patch_cb true")
      patch_cb(true, {})
    end
  end
  
  local copy_map = {}
  local delete_files_array = {}
  E.File.list_directory(res_location, true, true, function(result)
    local diff_file_path, diff_file_name, diff_info_file_path
    for _, item in ipairs(result) do
      local path = item.path
      if E.Utils.end_with(path, ".dirdiff") then
        diff_file_name = path
        diff_file_path = E.Path.join(res_location, path)
      elseif E.Utils.end_with(path, "ejoy_patch_info.json") then
        diff_info_file_path = E.Path.join(res_location, path)
      elseif string.find(path, "_dl_finish_md5@") then
        E.LOG.debug(TAG, "filter file, path is " .. tostring(path))
      elseif not item.is_dir then
        local source_path = E.Path.join(res_location, path)
        local target_path = E.Path.join(apply_dest_path, path)
        copy_map[source_path] = target_path
      end
    end
    patch(diff_file_name, diff_file_path, diff_info_file_path, copy_map, delete_files_array, function(patch_succ, ...)
      if patch_succ then
        local function batch_move_files()
          ER_UTILS.batch_move_file(copy_map, function(move_succ, ...)
            if move_succ then
              batch_delete_files(delete_files_array, function(batch_delete_succ, ...)
                if not batch_delete_succ then
                  local batch_delete_err_code, batch_delete_err_msg = ...
                  
                  E.LOG.debug(TAG, string.format("batch delete file fail, code is %s, msg is %s", tostring(batch_delete_err_code), tostring(batch_delete_err_msg)))
                end
                update_using_file_list_cache(res_key, apply_dest_path, function()
                  progress_cb(APPLY_STATE.COMPLETE, {percent = 100})
                  local remove_temp_dir_succ, remove_temp_err_code, remove_temp_err_msg = E.File.remove_fullpath(temp_dir_path)
                  if remove_temp_dir_succ then
                    E.LOG.debug(TAG, "remove temp dir succ, temp dir is " .. tostring(temp_dir_path))
                  else
                    E.LOG.debug(TAG, string.format("remove temp dir fail, code is %s, msg is %s", tostring(remove_temp_err_code), tostring(remove_temp_err_msg)))
                  end
                  cb(true, true)
                end)
              end)
            else
              cb(false, ...)
            end
          end)
        end
        
        E.LOG.debug(TAG, "patch and check md5 succ, now start move file to game dir")
        END.dispatch_confirm_res_apply(namespace, res_key, function()
          batch_move_files()
        end)
      else
        progress_cb(APPLY_STATE.FAIL, {percent = curPercent})
        cb(false, ...)
      end
    end)
  end)
end

function M.on_origin_res_apply(engine_context, res_location, apply_dest_path, cb)
  if is_group_mode then
    DEFAULT_GROUP_ENGINE_HANDLER.on_origin_res_apply(engine_context, res_location, apply_dest_path, cb)
  else
    E.LOG.debug(TAG, "call on_origin_res_apply >>>>>")
    if file_list_type == RTM.FILE_LIST_TYPE.ORIGIN then
      local move_map = {}
      local move_info_map = {}
      for _, file_info in ipairs(file_list) do
        local source_path = E.Path.join(res_location, file_info.to)
        local target_path = E.Path.join(apply_dest_path, file_info.to)
        move_map[source_path] = target_path
        move_info_map[file_info.to] = file_info.md5
      end
      local namespace, res_key, _res_info = engine_context.get_res_info()
      END.dispatch_confirm_res_apply(namespace, res_key, function()
        ER_UTILS.batch_move_res_file(apply_dest_path, move_map, move_info_map, function(succ, ...)
          cb(succ, ...)
        end)
      end)
    end
  end
end

function M.on_process_file_list(ext_info, file_list_cb)
  local FP = require("ejoysdk_lua.res.qz_file_list_parser")
  is_group_mode = ext_info.qz_file_list_type == FP.QZ_FILE_LIST_TYPE.GROUP
  file_list_type = ext_info.file_list_type
  E.LOG.debug(TAG, "startup res is_group_mode: " .. tostring(is_group_mode))
  E.LOG.debug(TAG, "startup res type: " .. tostring(file_list_type))
  if is_group_mode then
    DEFAULT_GROUP_ENGINE_HANDLER.on_process_file_list(ext_info, file_list_cb)
  else
    file_list = ext_info.file_list or {}
    file_list_cb(true, nil, file_list)
  end
end

return M
