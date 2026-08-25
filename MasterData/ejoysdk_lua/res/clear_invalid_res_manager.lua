local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local LOCAL_FILE_LIST = require("ejoysdk_lua.res.model.res_src.ejoy_local_file_list")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local QZ_FILE_LIST_MGR = require("ejoysdk_lua.res.model.res_src.ejoy_qz_res_file_list_mgr")
local M = {}
local TAG = "clear_invalid_res_manager"
local JSON = require("ejoysdk_lua.ejoysdk_json")
local PENDING_CACHE_FILE = "_clear_invalid_res_pending.json"

local function _pending_cache_path(apply_dest_path)
  return apply_dest_path .. "/" .. PENDING_CACHE_FILE
end

local function _save_pending_cache(apply_dest_path, invalid_files)
  local path = _pending_cache_path(apply_dest_path)
  E.File.writefile_fullpath(path, JSON.encode(invalid_files), false)
  E.LOG.debug(TAG, "_save_pending_cache: saved " .. tostring(#invalid_files) .. " files to " .. path)
end

local function _load_pending_cache(apply_dest_path)
  local path = _pending_cache_path(apply_dest_path)
  local content = E.File.readfile_fullpath(path)
  if not content or "" == content then
    return nil
  end
  local list = JSON.decode(content)
  if type(list) ~= "table" or 0 == #list then
    return nil
  end
  E.LOG.debug(TAG, "_load_pending_cache: loaded " .. tostring(#list) .. " files from " .. path)
  return list
end

local function _remove_pending_cache(apply_dest_path)
  local path = _pending_cache_path(apply_dest_path)
  E.File.remove_fullpath(path)
  E.LOG.debug(TAG, "_remove_pending_cache: removed " .. path)
end

local function _do_delete(ctx)
  local invalid_files = ctx.invalid_files
  local apply_dest_path = ctx.apply_dest_path
  local local_file_list_obj = ctx.local_file_list_obj
  local listeners = ctx.listeners
  local is_resume = ctx.resume
  
  local function _do_batch_remove(files_to_remove)
    local t_remove_start = os.clock()
    E.LOG.debug(TAG, "_do_delete: removing " .. tostring(#files_to_remove) .. " files")
    E.File.batch_remove(files_to_remove, function(del_succ, _code, msg, result_ext)
      local cost_ms = string.format("%.3f", (os.clock() - t_remove_start) * 1000)
      if del_succ then
        E.LOG.debug(TAG, "_do_delete: all files deleted successfully, cost " .. cost_ms .. " ms")
        _remove_pending_cache(apply_dest_path)
        listeners.on_res_clear_complete(true)
      else
        local failed_files = {}
        if result_ext then
          for file_name, _ in pairs(result_ext) do
            table.insert(failed_files, file_name)
          end
        end
        if 0 == #failed_files then
          failed_files = files_to_remove
        end
        E.LOG.e(TAG, "_do_delete: " .. tostring(#failed_files) .. " files failed to delete, cost " .. cost_ms .. " ms, msg=" .. tostring(msg))
        _save_pending_cache(apply_dest_path, failed_files)
        listeners.on_res_clear_complete(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_CLEAR_DELETE_FAILED, msg or "some files failed to delete")
      end
    end, {base_path = apply_dest_path})
  end
  
  if is_resume then
    E.LOG.debug(TAG, "_do_delete: resume mode, delete " .. tostring(#invalid_files) .. " files")
    _do_batch_remove(invalid_files)
  else
    local_file_list_obj:update_file_items(invalid_files, LOCAL_FILE_LIST.UPDATE_FILE_TYPE.REMOVE, function()
      E.LOG.debug(TAG, "_do_delete: local file list updated")
      _save_pending_cache(apply_dest_path, invalid_files)
      _do_batch_remove(invalid_files)
    end)
  end
end

local function _handle_confirm(clear_info, listeners, on_confirmed)
  if listeners.on_confirm_res_clear then
    listeners.on_confirm_res_clear(clear_info, function(confirmed)
      if not confirmed then
        E.LOG.debug(TAG, "_handle_confirm: user cancelled")
        listeners.on_res_clear_complete(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_CLEAR_USER_CANCELLED, "user cancelled")
        return
      end
      on_confirmed()
    end)
  else
    on_confirmed()
  end
end

function M._filter_pending_files(pending_files, origin_file_list)
  if not origin_file_list or 0 == #origin_file_list then
    return pending_files
  end
  local remote_file_set = M._build_remote_file_set(origin_file_list)
  local filtered_files = {}
  for _, file_name in ipairs(pending_files) do
    if not remote_file_set[file_name] then
      table.insert(filtered_files, file_name)
    else
      E.LOG.debug(TAG, "_filter_pending_files: skip file in new remote list: " .. tostring(file_name))
    end
  end
  E.LOG.debug(TAG, "_filter_pending_files: original=" .. tostring(#pending_files) .. ", filtered=" .. tostring(#filtered_files))
  return filtered_files
end

function M._build_remote_file_set(origin_file_list)
  local remote_file_set = {}
  local remote_count = 0
  if origin_file_list then
    for _, item in ipairs(origin_file_list) do
      if item.to then
        remote_file_set[item.to] = true
        remote_count = remote_count + 1
      elseif item.items and type(item.items) == "table" then
        for _, sub_item in ipairs(item.items) do
          if sub_item.to then
            remote_file_set[sub_item.to] = true
            remote_count = remote_count + 1
          end
        end
      end
    end
  end
  return remote_file_set, remote_count
end

local function _process_clear_flow(files_to_clear, apply_dest_path, local_file_list_obj, listeners, is_resume, need_remove_pending)
  if 0 == #files_to_clear then
    E.LOG.debug(TAG, "_process_clear_flow: no files to clear")
    if need_remove_pending then
      _remove_pending_cache(apply_dest_path)
    end
    local clear_info = {
      total_size = 0,
      total_count = 0,
      need_clear = false
    }
    _handle_confirm(clear_info, listeners, function()
      listeners.on_res_clear_complete(true)
    end)
    return
  end
  local t_batch_info_start = os.clock()
  E.File.batch_info(files_to_clear, function(batch_ret)
    local total_size = 0
    batch_ret = batch_ret or {}
    for _, file_name in ipairs(files_to_clear) do
      total_size = total_size + ((batch_ret[file_name] or {}).size or 0)
    end
    E.LOG.debug(TAG, "_process_clear_flow: batch_info done, cost " .. string.format("%.3f", (os.clock() - t_batch_info_start) * 1000) .. " ms, total_size=" .. tostring(total_size) .. ", file_count=" .. tostring(#files_to_clear) .. ", is_resume=" .. tostring(is_resume))
    local delete_ctx = {
      invalid_files = files_to_clear,
      apply_dest_path = apply_dest_path,
      local_file_list_obj = local_file_list_obj,
      listeners = listeners,
      resume = is_resume
    }
    local clear_info = {
      total_size = total_size,
      total_count = #files_to_clear,
      need_clear = true
    }
    _handle_confirm(clear_info, listeners, function()
      _do_delete(delete_ctx)
    end)
  end, {
    is_full_path = true,
    base_path = apply_dest_path,
    check_size = true
  })
end

local function _on_remote_file_list(origin_file_list, remote_ctx)
  local apply_dest_path = remote_ctx.apply_dest_path
  local listeners = remote_ctx.listeners
  local pending_files = remote_ctx.pending_files
  local remote_file_set, remote_count = M._build_remote_file_set(origin_file_list)
  if 0 == remote_count then
    E.LOG.e(TAG, "do_clear: remote file list is empty, abort to prevent accidental deletion")
    listeners.on_res_clear_complete(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_CLEAR_NOT_READY, "remote file list is empty")
    return
  end
  if pending_files then
    E.LOG.debug(TAG, "do_clear: resume mode, pending_files=" .. tostring(#pending_files))
    local filtered_pending = M._filter_pending_files(pending_files, origin_file_list)
    local local_file_list_obj = LOCAL_FILE_LIST.static_get_file_list(apply_dest_path, false)
    _process_clear_flow(filtered_pending, apply_dest_path, local_file_list_obj, listeners, true, 0 == #filtered_pending)
    return
  end
  local t_local_start = os.clock()
  local local_file_list_obj = LOCAL_FILE_LIST.static_get_file_list(apply_dest_path, false)
  local local_file_map = local_file_list_obj:get_file_list()
  E.LOG.debug(TAG, "do_clear: get local file list cost " .. string.format("%.3f", (os.clock() - t_local_start) * 1000) .. " ms")
  local t_diff_start = os.clock()
  local invalid_files = {}
  for file_name, _ in pairs(local_file_map) do
    if not remote_file_set[file_name] then
      table.insert(invalid_files, file_name)
    end
  end
  E.LOG.debug(TAG, "do_clear: diff cost " .. string.format("%.3f", (os.clock() - t_diff_start) * 1000) .. " ms, found " .. tostring(#invalid_files) .. " invalid files")
  _process_clear_flow(invalid_files, apply_dest_path, local_file_list_obj, listeners, false, false)
end

function M.do_clear(clear_params, listeners)
  local namespace = clear_params.namespace
  local res_key = clear_params.res_key
  local save_storage_type = clear_params.res_save_storage_type
  local apply_dest_path = clear_params.apply_dest_path
  local pending_files = _load_pending_cache(apply_dest_path)
  local local_res_state = RTM.static_get_local_res_state(namespace, res_key) or {}
  local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  local local_using_version = using_res_info.version
  E.LOG.debug(TAG, "do_clear: update_version=" .. tostring(local_using_version))
  local t_remote_start = os.clock()
  local ER_UTILS = require("ejoysdk_lua.res.ejoysdk_res_utils")
  save_storage_type = ER_UTILS.try_get_storage_type(save_storage_type, apply_dest_path)
  local ext = {res_save_storage_type = save_storage_type}
  local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
  local _dest_path = ERS.static_get_index_file_cache_path(namespace, res_key, local_using_version, nil, ext)
  E.LOG.debug(TAG, "do_clear: _dest_path=" .. tostring(_dest_path))
  local remote_ctx = {
    apply_dest_path = apply_dest_path,
    listeners = listeners,
    pending_files = pending_files
  }
  if pending_files then
    E.LOG.w(TAG, "do_clear: detected unfinished cleanup from last run, pending=" .. tostring(#pending_files) .. " files, will check with remote list")
  end
  local _file_list_cache = QZ_FILE_LIST_MGR.static_get_qz_file_list(_dest_path, ERS.RES_FILE_LIST_CACHE_KEY.FILE_NAME_LIST_JSON)
  _file_list_cache:get_file_list(nil, function(succ, ...)
    E.LOG.debug(TAG, "do_clear: get_file_list cost " .. string.format("%.3f", (os.clock() - t_remote_start) * 1000) .. " ms, succ=" .. tostring(succ))
    if succ then
      local _is_from_download, _file_path, origin_file_list = ...
      _on_remote_file_list(origin_file_list, remote_ctx)
    else
      local code, msg = ...
      E.LOG.e(TAG, "do_clear: get_file_list failed, code=" .. tostring(code) .. ", msg=" .. tostring(msg))
      listeners.on_res_clear_complete(false, EC.RESOURCE_UPDATE_ERROR_CODES.RES_FILE_LIST_EMPTY, msg or "get file list failed")
    end
  end)
end

return M
