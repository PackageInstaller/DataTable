local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local E = require("ejoysdk_lua.ejoysdk")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local M = {}
local update_infos_cache = {}
local KEY_PATCHES = "patches"
local KEY_PATCH = "patch"
local KEY_DEFAULT_GROUP = "default"
local TAG = "update_info_manager"

local function get_res_patch_update_info(res_update_info, local_version)
  local patches = res_update_info[KEY_PATCHES]
  if patches and next(patches) then
    for _, patch_update_info in ipairs(patches) do
      if local_version == patch_update_info.targetVersion then
        return patch_update_info
      end
    end
  end
  local patch = res_update_info[KEY_PATCH]
  if patch and patch.targetVersion == local_version then
    return res_update_info[KEY_PATCH]
  end
  return nil
end

function M.add_update_infos(update_infos)
  if update_infos then
    E.LOG.debug(TAG, update_infos)
    for ns, ns_info in pairs(update_infos) do
      for rk, rk_info in pairs(ns_info) do
        update_infos_cache[ns] = update_infos_cache[ns] or {}
        update_infos_cache[ns][rk] = rk_info
      end
    end
  end
end

function M.add_update_info(namespace, res_key, update_info)
  update_infos_cache[namespace] = update_infos_cache[namespace] or {}
  update_infos_cache[namespace][res_key] = update_info
end

local function get_res_update_info(namespace, res_key)
  local ns_update_info = update_infos_cache[namespace] or {}
  local rk_update_info = ns_update_info[res_key] or {}
  return rk_update_info
end

function M.get_all_res_update_info(namespace, res_key)
  local rk_res_update_info = get_res_update_info(namespace, res_key)
  do return utils.deepcopy end
  return utils.deepcopy, rk_res_update_info
end

local function _get_res_update_info(namespace, res_key, local_res_version)
  local rk_res_update_info = get_res_update_info(namespace, res_key)
  E.LOG.debug(TAG, string.format("get res update info: ns:%s,rk:%s,local_res_version:%s", tostring(namespace), tostring(res_key), tostring(local_res_version)))
  local patch_update_info = get_res_patch_update_info(rk_res_update_info, local_res_version)
  if local_res_version and patch_update_info then
    local copy_rk_res_update_info = utils.deepcopy(rk_res_update_info)
    copy_rk_res_update_info[KEY_PATCH] = patch_update_info
    E.LOG.debug(TAG, "has patch. copy_rk_res_update_info >>")
    E.LOG.debug(TAG, copy_rk_res_update_info)
    return copy_rk_res_update_info
  else
    local copy_rk_res_update_info = utils.deepcopy(rk_res_update_info)
    copy_rk_res_update_info[KEY_PATCH] = nil
    E.LOG.debug(TAG, "NOT has patch. set patch nil, copy_rk_res_update_info >>")
    E.LOG.debug(TAG, copy_rk_res_update_info)
    return copy_rk_res_update_info
  end
end

function M.get_res_update_info(namespace, res_key, group_name, local_res_version)
  local inner_res_key = res_key
  if group_name and group_name ~= KEY_DEFAULT_GROUP then
    local GRM = require("ejoysdk_lua.res.group_res_manager")
    inner_res_key = GRM.get_task_key(res_key, group_name)
  end
  E.LOG.debug(TAG, "get_res_update_info, inner_res_key is " .. inner_res_key)
  if nil == local_res_version then
    local local_res_params = SC.get_startup_local_res_infos_cache()
    local ns_local_res_params = local_res_params[namespace] or {}
    local rk_local_res_params = ns_local_res_params[inner_res_key] or {}
    local_res_version = rk_local_res_params.version
    if nil == local_res_version then
      local local_res_state = RTM.static_get_local_res_state(namespace, inner_res_key) or {}
      local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
      local_res_version = using_res_info.version
      E.LOG.debug(TAG, "startup version is nil, try get from local, local_res_version is " .. tostring(local_res_version))
    end
  end
  do return _get_res_update_info, namespace, res_key end
  return _get_res_update_info, namespace, res_key, local_res_version, {}, E.LOG.debug, TAG, "startup version is nil, try get from local, local_res_version is " .. tostring(local_res_version), tostring(local_res_version), local_res_version
end

function M.get_using_version(namespace, res_key, opts)
  opts = opts or {}
  local local_res_state = RTM.static_get_local_res_state(namespace, res_key) or {}
  local using_res_info = local_res_state[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
  local _using_version = using_res_info.version
  local UTILS = require("ejoysdk_lua.ejoysdk_utils")
  if not UTILS.STR.is_empty(opts.version) then
    _using_version = opts.version
  else
    local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
    local _ver_c = VER_CHECK.compare_versions(_using_version, opts.pkg_res_version)
    if _ver_c < 0 then
      _using_version = opts.pkg_res_version
    end
  end
  return _using_version
end

function M.get_res_update_info_with_opts(namespace, res_key, group_name, opts)
  opts = opts or {}
  local inner_res_key = res_key
  if group_name and group_name ~= KEY_DEFAULT_GROUP then
    local GRM = require("ejoysdk_lua.res.group_res_manager")
    inner_res_key = GRM.get_task_key(res_key, group_name)
  end
  local _using_version = M.get_using_version(namespace, inner_res_key, opts)
  return _get_res_update_info(namespace, res_key, _using_version), _using_version
end

return M
