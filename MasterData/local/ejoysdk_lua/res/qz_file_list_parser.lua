local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local M = {}
local TAG = "QZ_FILE_LIST_PARSER#" .. EM.MODULE.RES .. "qz_file_list_parser"
local FILE_NAME_INFO_LIST_JSON = "ejoy_qz_resource_file_info_list.json"
local file_list_cache = {}
local group_all_file_list_cache = {}
local QZ_FILE_LIST_TYPE = {COMMON = "common", GROUP = "group"}
M.QZ_FILE_LIST_TYPE = QZ_FILE_LIST_TYPE

local function get_res_cache_key(namespace, res_key, local_version, version)
  if nil == local_version then
    local_version = ""
  end
  local cache_key = string.format("%s_%s_%s_%s", namespace, res_key, tostring(local_version), version)
  return cache_key
end

local function get_group_res_cache_key(cache_key, group)
  local group_cache_key = string.format("%s-%s", cache_key, group)
  return group_cache_key
end

local function parse_res_key(res_key)
  local group_res_key_prefix = RTM.RES_GROUP_INFO_KEY.PREFIX
  local is_group_key = false
  if E.Utils.start_with(res_key, group_res_key_prefix) then
    is_group_key = true
    local items = E.Utils.split_string(res_key, "-")
    local real_res_key = items[2]
    local res_prefix = group_res_key_prefix .. items[2] .. "-"
    local group_name = string.sub(res_key, #res_prefix + 1)
    return is_group_key, real_res_key, group_name
  else
    return is_group_key, res_key
  end
end

local function reset_cache_key_file_list(cache_key)
  if file_list_cache[cache_key] then
    local group_cache_key_prefix = cache_key .. "-"
    for key, _ in pairs(file_list_cache) do
      if key == cache_key or E.Utils.start_with(key, group_cache_key_prefix) then
        E.LOG.debug(TAG, "remove cache data, key is " .. tostring(key))
        file_list_cache[key] = nil
      end
    end
  end
end

function M.remove_cache(namespace, res_key, local_version, version)
  E.LOG.debug(TAG, "remove_file_list_cache, res_key is " .. tostring(res_key) .. ", local_version is " .. tostring(local_version) .. ", version is " .. tostring(version))
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local real_res_key = GRM.get_real_res_key(res_key)
  local cache_key = get_res_cache_key(namespace, real_res_key, local_version, version)
  reset_cache_key_file_list(cache_key)
end

function M.parse_file_list(namespace, res_key, local_version, version, qz_file_list_content)
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local real_res_key = GRM.get_real_res_key(res_key)
  E.LOG.debug(TAG, "parse file list, ns is " .. tostring(namespace) .. ", rk is " .. tostring(real_res_key) .. ", targetVersion is " .. tostring(local_version) .. ", version is " .. tostring(version))
  local cache_key = get_res_cache_key(namespace, real_res_key, local_version, version)
  local qz_file_list = CJSON.safe_decode(qz_file_list_content)
  local _type = QZ_FILE_LIST_TYPE.COMMON
  if qz_file_list and qz_file_list[1] and qz_file_list[1].g then
    _type = QZ_FILE_LIST_TYPE.GROUP
  end
  local qz_file_list_info = {type = _type, file_list = qz_file_list}
  reset_cache_key_file_list(cache_key)
  file_list_cache[cache_key] = qz_file_list_info
  E.LOG.debug(TAG, "cache rk is " .. tostring(cache_key))
  E.LOG.debug(TAG, "parse file list, type is " .. tostring(_type))
  return qz_file_list_info
end

local function get_group_file_list(cache_key, group)
  local group_cache_key = get_group_res_cache_key(cache_key, group)
  if file_list_cache[group_cache_key] then
    return file_list_cache[group_cache_key].file_list
  end
  local qz_file_list_info = file_list_cache[cache_key]
  if nil == qz_file_list_info or qz_file_list_info.type ~= QZ_FILE_LIST_TYPE.GROUP or qz_file_list_info.file_list == nil then
    return
  end
  for _, group_info in ipairs(qz_file_list_info.file_list) do
    local group_name = group_info.g
    E.LOG.debug(TAG, "group_name is " .. tostring(group_name))
    local current_group_cache_key = get_group_res_cache_key(cache_key, group_name)
    file_list_cache[current_group_cache_key] = {
      type = QZ_FILE_LIST_TYPE.GROUP,
      file_list = group_info.items or {}
    }
    E.LOG.debug(TAG, "cache group rk is " .. tostring(current_group_cache_key))
  end
  local result_file_list_info = file_list_cache[group_cache_key] or {}
  return result_file_list_info.file_list
end

local function get_default_file_list(cache_key)
  local qz_file_list_info = file_list_cache[cache_key]
  if nil == qz_file_list_info then
    return
  end
  if qz_file_list_info.type == QZ_FILE_LIST_TYPE.COMMON then
    return qz_file_list_info.file_list
  end
  if qz_file_list_info.type == QZ_FILE_LIST_TYPE.GROUP then
    do return get_group_file_list, cache_key end
    return get_group_file_list, cache_key, "default"
  end
end

function M.get_group_file_list(namespace, res_key, local_version, version, groups)
  local cache_key = get_res_cache_key(namespace, res_key, local_version, version)
  local qz_file_list_info = file_list_cache[cache_key]
  if nil == qz_file_list_info then
    E.LOG.warn(TAG, "get_group_file_list failed, file_list_cache is nil for namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", local_version:" .. tostring(local_version) .. ", version:" .. tostring(version))
    return
  end
  if not groups or 0 == #groups or 1 == #groups and "default" == groups[1] then
    do return get_default_file_list end
    return get_default_file_list, cache_key, "get_group_file_list failed, file_list_cache is nil for namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", local_version:" .. tostring(local_version) .. ", version:" .. tostring(version), tostring(namespace), ", res_key:", tostring(res_key), ", local_version:", tostring(local_version), ", version:", tostring(version), version, nil, nil, nil, nil
  else
    local list_map = {}
    for _, group_name in ipairs(groups) do
      local _list = get_group_file_list(cache_key, group_name)
      _list = _list or {}
      _ejoysdk.log("get_group_file_list group_name: " .. tostring(group_name) .. ", list count: " .. tostring(#_list))
      for _, item in ipairs(_list) do
        list_map[item.to] = item
      end
    end
    local merged_list = {}
    for _, item in pairs(list_map) do
      table.insert(merged_list, item)
    end
    _ejoysdk.log("get_group_file_list group_name: " .. tostring(table.concat(groups, ",")) .. ", list count: " .. tostring(#merged_list))
    return merged_list
  end
end

local function get_total_file_list(cache_key)
  local qz_file_list_info = file_list_cache[cache_key] or {}
  local qz_file_list = qz_file_list_info.file_list
  E.LOG.debug(TAG, "get_total_file_list, cache key is " .. tostring(cache_key))
  if nil == qz_file_list_info then
    E.LOG.debug(TAG, "get_total_file_list, qz_file_list_info is nil")
    return
  end
  if qz_file_list_info.type == QZ_FILE_LIST_TYPE.COMMON then
    return qz_file_list_info.file_list
  end
  if qz_file_list_info.type == QZ_FILE_LIST_TYPE.GROUP then
    if group_all_file_list_cache[cache_key] then
      E.LOG.debug(TAG, "get_total_file_list, qz_file_list_info is group， has cache")
      return group_all_file_list_cache[cache_key]
    else
      local group_all_file_list = {}
      for _, group_info in ipairs(qz_file_list) do
        local group_items = group_info.items or {}
        for _, item in ipairs(group_items) do
          table.insert(group_all_file_list, item)
        end
      end
      group_all_file_list_cache[cache_key] = group_all_file_list
      return group_all_file_list_cache[cache_key]
    end
  end
end

function M.get_file_list(namespace, res_key, local_version, version, is_total)
  local is_group_key, real_res_key, group_name = parse_res_key(res_key)
  local cache_key = get_res_cache_key(namespace, real_res_key, local_version, version)
  E.LOG.debug(TAG, "get file list, cache key is " .. tostring(cache_key) .. ", local_version:" .. tostring(local_version) .. ", version: " .. tostring(version) .. ", is_total: " .. tostring(is_total))
  if is_total then
    E.LOG.debug(TAG, "res_key is " .. tostring(real_res_key) .. ", get total file list")
    do return get_total_file_list end
    return get_total_file_list, cache_key, "res_key is " .. tostring(real_res_key) .. ", get total file list", tostring(real_res_key), ", get total file list", tostring(local_version), ", version: ", tostring(version), ", is_total: ", tostring(is_total), is_total
  end
  if is_group_key then
    E.LOG.debug(TAG, "is group_key, res_key is " .. tostring(real_res_key) .. ", group_name is " .. tostring(group_name))
    do return get_group_file_list, cache_key end
    return get_group_file_list, cache_key, group_name, tostring(real_res_key), ", group_name is ", tostring(group_name), group_name, tostring(version), ", is_total: ", tostring(is_total), is_total
  else
    E.LOG.debug(TAG, "not group_key, res_key is " .. tostring(real_res_key) .. ", cache_key is " .. tostring(cache_key))
    do return get_default_file_list end
    return get_default_file_list, cache_key, "not group_key, res_key is " .. tostring(real_res_key) .. ", cache_key is " .. tostring(cache_key), tostring(real_res_key), ", cache_key is ", tostring(cache_key), cache_key, tostring(version), ", is_total: ", tostring(is_total), is_total
  end
end

function M.get_file_list_cache(namespace, res_key, local_version, target_version, is_total, storage_type)
  local GRM = require("ejoysdk_lua.res.group_res_manager")
  local real_res_key = GRM.get_real_res_key(res_key)
  local cache_key = get_res_cache_key(namespace, real_res_key, local_version, target_version)
  local qz_file_list_info = file_list_cache[cache_key]
  if not qz_file_list_info then
    local ext = {
      [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = storage_type
    }
    local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
    local index_info_file_cache_path = ERS.static_get_index_file_cache_path(namespace, real_res_key, target_version, local_version, ext) .. "/" .. FILE_NAME_INFO_LIST_JSON
    if E.File.exists_fullpath(index_info_file_cache_path) then
      local list_content = E.File.readfile_fullpath(index_info_file_cache_path)
      M.parse_file_list(namespace, real_res_key, local_version, target_version, list_content)
    else
      E.LOG.warn(TAG, "get_file_list_cache failed, file not exists, path is " .. tostring(index_info_file_cache_path))
      return nil
    end
  end
  do return M.get_file_list, namespace, res_key, local_version, target_version end
  return M.get_file_list, namespace, res_key, local_version, target_version, is_total, tostring(index_info_file_cache_path), index_info_file_cache_path, target_version, list_content
end

function M.get_file_list_type(namespace, res_key, version)
  local is_group_key, real_res_key, _group_name = parse_res_key(res_key)
  local cache_key = get_res_cache_key(namespace, real_res_key, nil, version)
  E.LOG.debug(TAG, "get file list type, cache key is " .. tostring(cache_key))
  if is_group_key then
    return QZ_FILE_LIST_TYPE.GROUP
  else
    local qz_file_list_info = file_list_cache[cache_key]
    if qz_file_list_info then
      return qz_file_list_info.type
    else
      return QZ_FILE_LIST_TYPE.COMMON
    end
  end
end

function M.inner_get_file_list_type(namespace, res_key, version)
  local cache_key = get_res_cache_key(namespace, res_key, nil, version)
  local qz_file_list_info = file_list_cache[cache_key]
  if qz_file_list_info then
    return qz_file_list_info.type
  else
    return QZ_FILE_LIST_TYPE.COMMON
  end
end

return M
