local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local EHU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local M = {}
local TAG = "ejoysdk_res_utils"

function M.to_model_download_list_format(qz_file_list, folder, base_path, _dest_parent_path)
  if not qz_file_list or next(qz_file_list) == nil then
    E.LOG.warn(TAG, "parse_model_download_list_format skip, pending_file_list is empty")
    return {file_list = nil}
  end
  if folder and "" ~= folder then
    folder = E.Utils.trim_chars(folder, "/")
  end
  if base_path and "" ~= base_path then
    base_path = E.Utils.trim_chars(base_path, "/")
  end
  local pending_download_list = {}
  for _, item in ipairs(qz_file_list) do
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
        [RTM.MULTI_TASK_INFO_KEY.KEY_NAME] = file_name,
        [RTM.FILE_LIST_ITEM_KEY.KEY_TO] = item_to or item_from
      }
      table.insert(pending_download_list, down_item)
    end
  end
  return pending_download_list
end

function M.batch_move_file(move_map, cb)
  E.LOG.debug(TAG, "start batch_move")
  local target_file_list = {}
  for _, target_file_path in pairs(move_map) do
    E.LOG.debug(TAG, "target file path is " .. tostring(target_file_path))
    table.insert(target_file_list, target_file_path)
  end
  E.File.batch_remove(target_file_list, function(remove_succ, ...)
    if not remove_succ then
      local remove_err_code, remove_err_msg = ...
      E.LOG.debug(TAG, "batch_remove file fail, code is " .. tostring(remove_err_code) .. ", msg is " .. tostring(remove_err_msg))
    end
    E.LOG.debug(TAG, "batch_remove succ, now start batch rename")
    E.File.batch_rename(move_map, function(rename_succ, ...)
      if rename_succ then
        E.LOG.debug(TAG, "batch_rename succ")
        cb(true)
      else
        local rename_err_code, rename_err_msg, rename_fail_file_map = ...
        E.LOG.debug(TAG, "batch_rename file fail, code is " .. tostring(rename_err_code) .. ", msg is " .. tostring(rename_err_msg))
        local rename_fail_file_list = {}
        for rename_fail_file, _ in pairs(rename_fail_file_map) do
          local rename_fail_file_target_path = move_map[rename_fail_file]
          rename_fail_file_list[rename_fail_file] = rename_fail_file_target_path
          E.LOG.debug(TAG, "rename_fail_file is " .. tostring(rename_fail_file) .. ", target path is " .. tostring(rename_fail_file_target_path))
        end
        E.File.batch_copy(rename_fail_file_list, function(copy_succ, ...)
          if copy_succ then
            E.LOG.debug(TAG, "batch_copy succ")
            cb(true)
          else
            local copy_err_code, copy_err_msg = ...
            E.LOG.debug(TAG, "batch_copy fail, code is " .. tostring(copy_err_code) .. ", msg is " .. tostring(copy_err_msg))
            cb(false, copy_err_code, copy_err_msg)
          end
        end, {override = true, is_fullpath = true})
      end
    end, {is_fullpath = true})
  end, {is_fullpath = true})
end

function M.batch_move_res_file(_dest_parent_path, move_map, move_info_map, cb)
  local current_file_list_info = RTM.static_get_using_res_file_list(_dest_parent_path) or {}
  M.batch_move_file(move_map, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "batch_move_res_file succ, now update file list, dest:" .. tostring(_dest_parent_path))
      for to, md5 in pairs(move_info_map) do
        current_file_list_info[to] = {md5 = md5}
      end
      RTM.static_update_using_res_file_list(_dest_parent_path, current_file_list_info)
      cb(true)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "batch_move_res_file fail, code is " .. tostring(code) .. ", msg is " .. tostring(msg))
      cb(false, ...)
    end
  end)
end

function M.get_apply_dest_path(save_storage_type, save_base_path)
  local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
  local full_path
  if save_base_path and "" ~= save_base_path then
    local root_path
    if save_storage_type == RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE then
      root_path = ERB.static_get_storage_path_by_type(RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE)
    elseif save_storage_type == RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE then
      root_path = ERB.static_get_storage_path_by_type(RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE)
    else
      root_path = nil
    end
    if not root_path then
      full_path = save_base_path
    else
      root_path = E.Utils.trim_end(root_path, "/")
      save_base_path = E.Utils.trim_start(save_base_path, "/")
      full_path = root_path .. "/" .. save_base_path
    end
  end
  return full_path
end

function M.try_get_storage_type(storage_type, path)
  if storage_type ~= RTM.STORAGE_TYPE.EXTERNAL_OTHER then
    return storage_type
  end
  if E.Sysinfo.os() == "android" and E.Utils.start_with(path, "/data") then
    return RTM.STORAGE_TYPE.INTERNAL_APP_PRIVATE
  else
    return RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE
  end
end

function M.get_temp_dir_path(namespace, res_key, game_apply_dest_path, dirname)
  local ns_res_key_path_base = RTM.static_get_res_path(namespace, res_key)
  dirname = dirname or "patch"
  local relative_temp_dir_path = E.Path.join(E.Path.join(ns_res_key_path_base, dirname), "temp")
  local game_dest_parent_path = E.Path.parent_dir(game_apply_dest_path)
  local temp_abs_dir_path = E.Path.join(game_dest_parent_path, relative_temp_dir_path)
  return temp_abs_dir_path, relative_temp_dir_path
end

function M.try_get_storage_other_type_path(storage_type, path)
  if storage_type ~= RTM.STORAGE_TYPE.EXTERNAL_OTHER then
    local ERB = require("ejoysdk_lua.res.model.ejoy_res_model_base")
    local storage_type_path_base = ERB.static_get_storage_path_by_type(storage_type)
    local storage_dir = E.Utils.trim_end(storage_type_path_base, "/")
    if E.Sysinfo.os() == "windows" and E.Utils.end_with(storage_dir, "ejoy") then
      storage_dir = E.Path.parent_dir(storage_dir)
    end
    local full_path = E.Path.join(storage_dir, path)
    return RTM.STORAGE_TYPE.EXTERNAL_OTHER, full_path
  else
    return storage_type, path
  end
end

return M
