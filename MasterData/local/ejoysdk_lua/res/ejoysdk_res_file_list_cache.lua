local M = {}
local TAG = "ejoysdk_res_file_list_cache"

function M.update_using_res_config(apply_dest_path, version, base_path, folder)
  local E = require("ejoysdk_lua.ejoysdk")
  local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  local JSON = require("ejoysdk_lua.ejoysdk_cjson")
  local res_config_file_path = E.Path.join(apply_dest_path, RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_CONFIG)
  local res_config = {
    version = version,
    base_path = base_path,
    folder = folder
  }
  local res_config_content = JSON.encode(res_config)
  E.LOG.debug(TAG, "write ejoy_qz_resource_config.json, path is " .. tostring(res_config_file_path) .. ", content: ")
  E.LOG.debug(TAG, res_config)
  E.File.writefile_fullpath(res_config_file_path, res_config_content)
end

function M.get_using_res_config(apply_dest_path)
  local E = require("ejoysdk_lua.ejoysdk")
  local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  local JSON = require("ejoysdk_lua.ejoysdk_cjson")
  local res_config_file_path = E.Path.join(apply_dest_path, RTM.RES_CACHE_KEY.EJOY_QZ_LOCAL_RESOURCE_CONFIG)
  if res_config_file_path then
    local file_list = JSON.decode(res_config_file_path)
    return file_list or {}
  end
  return {}
end

function M.get_cache_file_list(namespace, res_key, using_version, storage_type)
  local ERS = require("ejoysdk_lua.res.model.src_adapters.ejoy_res_source")
  local E = require("ejoysdk_lua.ejoysdk")
  local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  local origin_file_list_cache_path = ERS.static_get_index_file_cache_path(namespace, res_key, using_version, nil, {
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = storage_type
  }) .. "/" .. ERS.RES_FILE_LIST_CACHE_KEY.FILE_NAME_LIST_JSON
  if E.File.exists_fullpath(origin_file_list_cache_path) then
    local JSON = require("ejoysdk_lua.ejoysdk_cjson")
    local list_content = E.File.readfile_fullpath(origin_file_list_cache_path)
    local file_list_obj = JSON.decode(list_content)
    return file_list_obj or {}
  end
  return {}
end

function M.update_using_file_list_cache(namespace, res_key, local_version, update_version, apply_dest_path, cache_diff_file_array, cb)
  local E = require("ejoysdk_lua.ejoysdk")
  local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  E.LOG.debug(TAG, "update_using_file_list_cache")
  local FP = require("ejoysdk_lua.res.qz_file_list_parser")
  local file_list_obj = FP.get_file_list(namespace, res_key, local_version, update_version) or {}
  local qz_file_list_map = {}
  for _, qz_file_item in ipairs(file_list_obj) do
    local key = qz_file_item.to
    local info = {
      md5 = qz_file_item.md5
    }
    qz_file_list_map[key] = info
  end
  local diff_file_list_map = {}
  if cache_diff_file_array then
    for _, qz_diff_file_item in ipairs(cache_diff_file_array) do
      local key = qz_diff_file_item.to
      local info = {
        md5 = qz_diff_file_item.md5
      }
      diff_file_list_map[key] = info
    end
  end
  local current_file_list_info = RTM.static_get_using_res_file_list(apply_dest_path)
  E.LOG.debug(TAG, "start list_directory")
  E.File.list_directory(apply_dest_path, true, true, function(result)
    E.LOG.debug(TAG, "update_using_file_list_cache, list_directory end")
    result = result or {}
    local exist_file_list = {}
    for _, file_info in ipairs(result) do
      if not file_info.is_dir then
        local path = file_info.path
        exist_file_list[path] = true
        if qz_file_list_map[path] then
          current_file_list_info[path] = qz_file_list_map[path]
        elseif diff_file_list_map[path] then
          current_file_list_info[path] = diff_file_list_map[path]
        end
      end
    end
    for path, _ in pairs(current_file_list_info) do
      if not exist_file_list[path] then
        current_file_list_info[path] = nil
      end
    end
    RTM.static_update_using_res_file_list(apply_dest_path, current_file_list_info)
    E.LOG.debug(TAG, "update_using_file_list_cache end")
    cb()
  end)
end

function M.sub_pkg_update_using_file_list_cache(apply_dest_path, local_file_list)
  local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  RTM.static_update_using_res_file_list(apply_dest_path, local_file_list)
end

return M
