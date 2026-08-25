local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local md5 = require("ejoysdk_lua.libs.md5")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local DOWNLOAD = require("ejoysdk_lua.res.ejoysdk_res_download")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local ENUM = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
local EL = require("ejoysdk_lua.res.ejoy_res_log")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local TAG = EM.MODULE.RES .. "ejoysdk_res"
local RES_BUILTIN_PATH = "ejoysdk_res"
local RES_CONFIG = "config"
local M = {}
local inited = false
M.RES_CONFIG_KEY = {
  KEY_VERSION = "version",
  KEY_RES_TYPE = "key",
  KEY_PATH = "path",
  KEY_RESOURCE_UPDATED = "res_updated",
  KEY_NEED_RELEASE_FROM_BUNDLE = "need_release_from_bundle"
}
M.RES_TYPE = {
  EJOYSDK_LUA = "ejoysdk_lua",
  QOOKKA_USER_CENTER = "qookka_usercenter"
}
local res_collection = {}
local res_update_list = {}
local res_bundle_release_list = {}
local bundle_res_infos = {}
local removed_res_cache_collection = {}
local res_state_changed_list = {}
local res_from_ecc = {}

local function ObserverNew()
  local observers = {}
  local T = {}
  local mt = {
    __index = function(self, key)
      return observers[key]
    end,
    __newindex = function(self, _key, _value)
      return
    end
  }
  
  function T.subscribe(cb)
    if #observers <= 0 then
      observers[#observers + 1] = cb
    end
  end
  
  function T.notify(ret, new_res)
    if #observers > 0 then
      for i = 1, #observers do
        if type(observers[i]) == "function" then
          observers[i](ret, new_res)
          observers[i] = nil
        end
      end
    end
  end
  
  do return setmetatable, T end
  return setmetatable, T, mt
end

local function stat(action, key, succ, params)
  local ejoysdk_stat = require("ejoysdk_lua.ejoysdk_stat")
  E.LOG.debug(TAG, "action=" .. tostring(action) .. ", key=" .. tostring(key) .. ", succ=" .. tostring(succ or "nil"))
  ejoysdk_stat.stat_action(action, key, succ, params)
end

local function use_local_res(key, namespace)
  local pkg_info = E.get_pkg_info()
  local has_cache = res_from_ecc and key and nil ~= res_from_ecc[key] and next(res_from_ecc[key]) or key and nil == namespace
  local is_device_support = has_cache and E.File.is_support_handling_file_cache() and pkg_info.os ~= "windows" and (pkg_info.os ~= "android" or pkg_info.os == "android" and VER_CHECK.compare_versions(pkg_info.versions.os_version, 23) >= 0) and (pkg_info.os ~= "ios" or pkg_info.os == "ios" and VER_CHECK.compare_versions(pkg_info.versions.os_version, "10.0") >= 0)
  return is_device_support
end

function M.get_bundle_res_info(res_key)
  if not res_key or "" == res_key then
    E.LOG.warn(TAG, "get_bundle_res_info failed, res_key is nil")
    return nil
  end
  local res_info = bundle_res_infos[res_key]
  if res_info and next(res_info) ~= nil then
    E.LOG.debug(TAG, "get_bundle_res_info from cache >>")
    E.LOG.debug(TAG, res_info)
    return res_info
  end
  local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
  local res_config_path = base_path .. RES_CONFIG
  E.LOG.debug(TAG, "read path: " .. tostring(res_config_path))
  local assets_config_content = _ejoysdk.lread(res_config_path)
  E.LOG.debug(TAG, "content: " .. (assets_config_content or "nil"))
  if assets_config_content and "" ~= assets_config_content then
    res_info = JSON.safe_decode(assets_config_content)
  end
  if nil ~= res_info then
    local need_release_bundle = res_info[M.RES_CONFIG_KEY.KEY_NEED_RELEASE_FROM_BUNDLE]
    if nil == need_release_bundle then
      res_info[M.RES_CONFIG_KEY.KEY_NEED_RELEASE_FROM_BUNDLE] = true
      E.LOG.debug(TAG, "config doesnt have need release bundle flag, now set it with true as default")
    end
  end
  bundle_res_infos[res_key] = res_info
  return res_info
end

local function save_config()
  local reslist = ""
  for k, _ in pairs(res_collection) do
    reslist = reslist .. k .. "\n"
  end
  E.LOG.debug(TAG, "reslist=" .. tostring(reslist))
  E.File.writefile(RES_BUILTIN_PATH .. "/" .. RES_CONFIG, reslist, false)
end

local function release_bundle(res_key, upper_cb)
  local function cb(succ, config)
    if succ and config and config.release_observer then
      E.LOG.info(TAG, "res_key: " .. tostring(res_key) .. " 释放资源释放完成，返回中")
      
      config.release_observer.notify(succ, config)
      config.release_observer = nil
    end
    if upper_cb then
      upper_cb(succ, config)
    end
    E.LOG.info(TAG, "res_key: " .. tostring(res_key) .. " succ:" .. tostring(succ) .. " 释放资源释放完成，清理")
    res_bundle_release_list[res_key] = nil
  end
  
  local stat_action = "res_release"
  E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 准备释放")
  local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
  local res_config = M.get_bundle_res_info(res_key)
  stat(stat_action, res_key)
  if not res_config then
    E.LOG.error(TAG, "res_key: " .. tostring(res_key) .. " 内置配置读取失败")
    cb(false)
    stat(stat_action, res_key, false)
    return
  end
  local release_res = res_bundle_release_list[res_key]
  if release_res then
    E.LOG.warn(TAG, "res_key: " .. tostring(res_key) .. " 存在同时释放资源，等待返回")
    release_res.release_observer.subscribe(upper_cb)
    return
  else
    res_bundle_release_list[res_key] = res_config
    res_config.release_observer = ObserverNew()
  end
  local res_ver = res_config.version
  local bundle_path = base_path .. res_ver
  local bundle_zip_path = bundle_path .. ".zip"
  
  local function unzip_block(ret)
    if ret.succ then
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 解压成功")
      local dup_config = UTILS.deepcopy(res_config)
      dup_config.release_observer = nil
      E.File.writefile(base_path .. RES_CONFIG, JSON.encode(dup_config), false)
      res_collection[res_key] = res_config
      cb(true, res_config)
      save_config()
      stat(stat_action .. "_unzip", res_key, true)
      stat(stat_action, res_key, true)
    else
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 解压失败")
      cb(false)
      stat(stat_action .. "_unzip", res_key, false)
    end
    E.File.remove(bundle_zip_path)
    E.LOG.debug(TAG, "delete file: " .. tostring(bundle_zip_path))
  end
  
  E.File.release_bundle_res(bundle_zip_path, bundle_zip_path, function(ret)
    if ret.succ then
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 释放成功")
      E.File.unzip(bundle_zip_path, bundle_path, unzip_block)
      stat(stat_action .. "_unzip", res_key)
    else
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 释放失败")
      cb(false)
      stat(stat_action, res_key, false)
    end
  end)
end

local function get_cached_path()
  if _ejoysdk.os() == "ios" then
    local paths = _ejoysdk.sysinfo_paths()
    return paths.document_path
  elseif _ejoysdk.os() == "android" then
    do return end
    return E.File.get_ext_file_dir, paths.document_path
  else
    do return end
    return E.File.get_ext_file_dir, paths.document_path
  end
end

local function update(res_info, cb)
  local stat_action = "res_update"
  local res_key = res_info.key
  local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
  local save_path = base_path .. md5.sumhexa(res_info.url) .. ".zip"
  local params = {
    key = res_key,
    url = res_info.url,
    checksum = res_info.md5,
    force_update = res_info.force_update,
    dest = get_cached_path() .. "/" .. save_path
  }
  E.LOG.debug(TAG, "save path=" .. tostring(save_path))
  
  local function notify(succ, ...)
    if res_info.update_observer then
      res_info.update_observer.notify(succ, ...)
      res_info.update_observer = nil
    end
    res_update_list[res_key] = nil
    if cb then
      cb(succ, ...)
      cb = nil
    end
  end
  
  local function unzip_block(ret)
    if ret.succ then
      E.LOG.debug(TAG, tostring(res_key) .. " 解压成功")
      local res_config = base_path .. RES_CONFIG
      local dup_config = UTILS.deepcopy(res_info.config_info)
      dup_config.update_observer = nil
      E.File.writefile(res_config, JSON.encode(dup_config), false)
      local previous_res = res_collection[res_key]
      res_collection[res_key] = res_info.config_info
      save_config()
      if previous_res and previous_res.version then
        M._remove_previous_version_resource(res_key, previous_res.version)
      end
      stat(stat_action .. "_unzip", res_key, true)
      notify(true, res_info.config_info)
    else
      E.LOG.debug(TAG, tostring(res_key) .. " 解压失败")
      stat(stat_action .. "_unzip", res_key, false)
      notify(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_UNZIP_FAILED, ret.msg, res_info.config_info)
    end
    E.File.remove(save_path)
  end
  
  local function download_block(_params)
    E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 开始下载, url: " .. tostring(_params.url))
    stat(stat_action, res_key)
    DOWNLOAD.download(_params, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " url: " .. tostring(_params.url) .. " 下载成功")
        local unzip_path = base_path .. res_info.version
        E.File.unzip(save_path, unzip_path, unzip_block)
        stat(stat_action .. "_unzip", res_key)
      else
        E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " url: " .. tostring(_params.url) .. " 下载失败")
        local code, msg = ...
        notify(false, code, msg, res_info.config_info)
        stat(stat_action, res_key, false)
      end
    end)
  end
  
  if res_info.zip_release then
    E.LOG.debug(TAG, "unzip bundle res: " .. tostring(res_key))
    release_bundle(res_key, function(available, config)
      res_info.zip_release = false
      if available then
        notify(available, config)
      end
      if not config or VER_CHECK.compare_versions(res_info.version, config.version) > 0 then
        download_block(params)
      elseif not available then
        notify(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RELEASE_BUNDLE_FAILED, "release bundle failed", config)
      end
    end)
  else
    download_block(params)
  end
end

local function get_local_available_res_version(res_key)
  local local_cached_res = res_collection[res_key]
  E.LOG.debug(TAG, "local cached version: " .. (local_cached_res and local_cached_res.version or "nil"))
  local local_res_version
  if local_cached_res and local_cached_res[M.RES_CONFIG_KEY.KEY_VERSION] then
    local_res_version = local_cached_res[M.RES_CONFIG_KEY.KEY_VERSION]
  else
    local bundle_res_info = M.get_bundle_res_info(res_key)
    if bundle_res_info then
      local need_release = bundle_res_info[M.RES_CONFIG_KEY.KEY_NEED_RELEASE_FROM_BUNDLE]
      if not need_release then
        local_res_version = bundle_res_info[M.RES_CONFIG_KEY.KEY_VERSION]
      end
    end
  end
  return local_res_version
end

local function get_usercenter_config()
  local usercenter_config
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    usercenter_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_OVERSEA)
  else
    usercenter_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_CN)
  end
  return usercenter_config
end

local function is_wv_use_local_res()
  local usercenter_config = get_usercenter_config()
  return usercenter_config and usercenter_config.config and usercenter_config.config.wv_use_local_res == true
end

local function res_config_update(key, namespace, remote_res, cb)
  cb = cb or function()
  end
  if not use_local_res(key, namespace) then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_CACHE_NOT_SUPPORT, "not support")
    return
  end
  if next(remote_res) == nil then
    E.LOG.debug(TAG, "res_update_by_key response nil, skip")
    local config_info = {
      [M.RES_CONFIG_KEY.KEY_RESOURCE_UPDATED] = false
    }
    cb(true, config_info)
    return
  end
  if namespace == ECC.NAMESPACE.H5_RESOURCE and not is_wv_use_local_res() then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_UPDATE_SWITCH_OFF, "switch off")
    return
  end
  local res_key = remote_res.key
  remote_res.force_update = remote_res.restrict and remote_res.restrict == true or false
  local updating_res = res_update_list[res_key]
  if updating_res and remote_res.update_observer then
    E.LOG.warn(TAG, "res_key: " .. tostring(res_key) .. " 存在同时更新资源，等待返回")
    updating_res.update_observer.subscribe(cb)
    return
  end
  remote_res.config_info = {
    key = remote_res.key,
    version = remote_res.version,
    path = remote_res.path
  }
  E.LOG.debug(TAG, "remote_res is >>> ")
  E.LOG.debug(TAG, remote_res)
  local local_res_version = get_local_available_res_version(res_key)
  E.LOG.debug(TAG, "local version: " .. tostring(local_res_version) .. ", remote version: " .. tostring(remote_res.version))
  if VER_CHECK.compare_versions(local_res_version, remote_res.version) < 0 then
    res_update_list[res_key] = remote_res
    remote_res.update_observer = ObserverNew()
    local local_cached_res = res_collection[res_key]
    if not local_cached_res and not remote_res.force_update then
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " allow release from zip")
      local bundle_res_info = M.get_bundle_res_info(res_key)
      if bundle_res_info and next(bundle_res_info) ~= nil then
        remote_res.use_bundle_res_first = true
        remote_res.zip_release = bundle_res_info[M.RES_CONFIG_KEY.KEY_NEED_RELEASE_FROM_BUNDLE]
      end
    end
    update(remote_res, function(update_succ, ...)
      if update_succ then
        local res_config_data = (...)
        res_config_data[M.RES_CONFIG_KEY.KEY_RESOURCE_UPDATED] = true
        res_state_changed_list[res_key] = true
        cb(true, res_config_data)
      else
        cb(false, ...)
      end
    end)
  else
    local has_res_changed = res_state_changed_list[res_key] or false
    remote_res.config_info[M.RES_CONFIG_KEY.KEY_RESOURCE_UPDATED] = has_res_changed
    E.LOG.debug(TAG, "res_update_by_key resource is newest, skip update:" .. tostring(key) .. ", state changed:" .. tostring(has_res_changed))
    cb(true, remote_res.config_info)
  end
end

local function ecc_update(config, cb)
  config = config or {}
  E.LOG.debug(TAG, "config is >>> ")
  E.LOG.debug(TAG, config)
  if config.config then
    local namespace = config.namespace
    for key, res_config in pairs(config.config) do
      res_from_ecc[key] = res_config
      res_config_update(key, namespace, res_config, cb)
    end
  end
end

function M.res_update(namespace, res_key, cb)
  cb = cb or function()
  end
  local target_namespace = namespace
  local request_namespaces = {target_namespace}
  if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
    table.insert(request_namespaces, ECC.NAMESPACE.USERCENTER_OVERSEA)
  else
    table.insert(request_namespaces, ECC.NAMESPACE.USERCENTER_CN)
  end
  table.insert(request_namespaces, ECC.NAMESPACE.EJOYSDK_BIZ)
  ECC.get_configs_in_whitelist(request_namespaces, function(succ, ...)
    if not succ then
      cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_UPDATE_FAILED, "update failed")
      return
    end
    local configs = (...)
    if not configs or not next(configs) then
      cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_UPDATE_FAILED, "update config empty")
      return
    end
    for _, config in pairs(configs) do
      if config and next(config) and config.namespace == target_namespace then
        ecc_update(config, function(update_succ, ...)
          if update_succ then
            local res_config = (...)
            if res_config.key == res_key then
              cb(true, res_config)
            end
          else
            cb(update_succ, ...)
          end
        end)
        return
      end
    end
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_UPDATE_FAILED, "update config not match")
  end)
end

local function parse_update_infos(configs)
  local update_infos = {}
  local update_namespace_exts = {}
  for _, config in pairs(configs) do
    local namespace = config.namespace or ""
    update_infos[namespace] = update_infos[namespace] or {}
    update_namespace_exts[namespace] = update_namespace_exts[namespace] or {}
    local update_address_list
    if config and next(config) then
      for key, res_config in pairs(config.config) do
        if key == RTM.RES_CONFIG_KEY.KEY_INIT_CONFIG then
          update_address_list = res_config[RTM.RES_CONFIG_KEY.KEY_ADDRESS_LIST] or {}
          update_namespace_exts[namespace][RTM.RES_CONFIG_KEY.KEY_ADDRESS_LIST] = update_address_list
        else
          update_infos[config.namespace][key] = res_config
        end
      end
    end
  end
  return update_infos, update_namespace_exts
end

function M.request_namespace_res_update(namespace_arr, ns_params, cb, options, ext)
  ns_params = ns_params or {}
  local ns_arr_size = namespace_arr and #namespace_arr or 0
  local stat_params = {}
  if 1 == ns_arr_size then
    stat_params.p1 = namespace_arr[1]
  elseif ns_arr_size > 1 then
    stat_params.p1 = namespace_arr[1]
    for _, ns in ipairs(namespace_arr) do
      if ns == ECC.NAMESPACE.QZ_PATCH then
        stat_params.p1 = ns
        break
      end
    end
  end
  if stat_params.p1 then
    local _rk_map = ns_params and ns_params[stat_params.p1] or {}
    stat_params.p2 = next(_rk_map)
  end
  QL.commit_action_succ_main("check_namespace_res_update_req_begin", stat_params.p1, stat_params)
  for ns, params in pairs(ns_params) do
    ECC.set_ex_info(ns, params)
  end
  if not options or next(options) == nil then
    options = options or {}
    options.disable_update_cache = false
    options.update_type = ECC.CONFIG_CENTER_UPDATE_TYPE.INC
  end
  E.LOG.debug(TAG, "request_namespace_res_update options >>")
  E.log(options)
  ECC.get_configs_with_options(options, namespace_arr, function(succ, ...)
    if not succ then
      local code, msg = ...
      QL.commit_action_fail_main("check_namespace_res_update_req_end", nil, code, msg, stat_params)
      cb(false, code, msg)
      return
    end
    local configs = (...)
    if not configs or next(configs) == nil then
      QL.commit_action_succ_main("check_namespace_res_update_req_end", "empty", stat_params)
      cb(true, {}, {})
      return
    end
    local update_infos, update_namespace_exts = parse_update_infos(configs)
    QL.commit_action_succ_main("check_namespace_res_update_req_end", "no_empty", stat_params)
    cb(true, update_infos, update_namespace_exts)
  end, ext)
end

function M.check_namespace_res_update_with_update_info(namespace, res_key, update_info, using_res_info, namespace_ext, _opts, cb)
  _opts = _opts or {}
  local res_src_model = EMF.get_ejoy_res_source_model(namespace, res_key)
  EL.LOG.debug(TAG, "check_namespace_res_update begin namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  local _config = {
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_BASE_PATH],
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE],
    [RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED],
    [RTM.RES_UPDATES_OPTIONS.FORCE_CHECK_UPDATE] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.FORCE_CHECK_UPDATE],
    [RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_CUSTOM_CONFIG]
  }
  res_src_model:update_config(_config)
  res_src_model:check_res_update(function(succ, ...)
    if succ then
      local _update_info = (...)
      if _update_info[RTM.UPDATE_INFO_KEY.HAS_NEW_UPDATE] then
        cb(true, true, _update_info)
      else
        E.LOG.debug(TAG, "no update for namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
        cb(true, false, _update_info)
      end
    else
      local code, msg = ...
      E.LOG.warn(TAG, "check_namespace_res_update failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end, update_info, using_res_info, namespace_ext)
end

function M.check_namespace_res_update(namespace, res_key, params, opts, update_cb)
  opts = opts or {}
  local ext = {
    custom_infos = opts.ext and opts.ext.filter_infos or {}
  }
  opts.ext = nil
  E.LOG.debug(TAG, "check_namespace_res_update begin, ns:" .. tostring(namespace) .. ", rk:" .. tostring(res_key))
  local stat_params = {p1 = namespace, p2 = res_key}
  QL.commit_action_succ_main("check_namespace_res_update_begin", namespace, stat_params)
  
  local function check_complete_cb(succ, ...)
    E.LOG.debug(TAG, "check_complete_cb, result:" .. tostring(succ))
    if succ then
      local has_update, has_new_update = ...
      stat_params.p3 = has_update
      QL.commit_action_succ_main("check_namespace_res_update_info", nil ~= has_new_update and has_new_update or false, stat_params)
    else
      local code, msg = ...
      QL.commit_action_fail_main("check_namespace_res_update_failed", namespace, code, msg, stat_params)
    end
    if update_cb then
      update_cb(succ, ...)
    end
  end
  
  if not (namespace and "" ~= namespace and res_key) or "" == res_key then
    check_complete_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_KEY_INVALID, "res_key or namespace not valid")
    return
  end
  if namespace == ECC.NAMESPACE.QZ_PATCH then
    local sc = require("ejoysdk_lua.res.startup.startup_res_config")
    opts.disable_update_cache = true
    opts.update_type = ECC.CONFIG_CENTER_UPDATE_TYPE.ALL
    opts.product_code = opts.product_code or sc.get_qz_product_code()
  else
    local opt_product_code = opts.product_code and opts.product_code:lower()
    local cur_product_code = E.CONFIG.get_config("product"):lower()
    if opt_product_code and "" ~= opt_product_code and opt_product_code ~= cur_product_code then
      opts.disable_update_cache = true
      opts.update_type = ECC.CONFIG_CENTER_UPDATE_TYPE.ALL
    end
  end
  params = params or {}
  local using_res_info = params.using_res_info
  local local_res_params = {
    [namespace] = {
      [res_key] = UTILS.deepcopy(using_res_info)
    }
  }
  local res_params = local_res_params[namespace][res_key]
  local group_rk_arr = RTM.static_get_res_group_rk_arr(namespace, res_key)
  if group_rk_arr and next(group_rk_arr) then
    local versions = {}
    if using_res_info and using_res_info.version then
      res_params.version = nil
      table.insert(versions, using_res_info.version)
    end
    local all_ns_resources = M.get_all_cached_namespace_resources() or {}
    local ns_res_map = all_ns_resources[namespace] or {}
    for _, group_rk in ipairs(group_rk_arr) do
      local group_res_info = ns_res_map[group_rk] or {}
      local group_res_using_res_info = group_res_info[RTM.NAMESPACE_RES_CONFIG_KEY.TYPE_USING_RES_INFO] or {}
      local group_cur_res_ver = group_res_using_res_info[M.RES_CONFIG_KEY.KEY_VERSION]
      if group_cur_res_ver then
        table.insert(versions, group_cur_res_ver)
      end
    end
    if versions and next(versions) then
      res_params.versions = versions
    end
  end
  
  local function handle_namespace_res_update(update_infos, update_namespace_exts)
    if not update_infos or next(update_infos) == nil then
      EL.LOG.debug(TAG, "no update info for namespaces")
      check_complete_cb(true, false)
      QL.commit_action_succ_main("check_namespace_res_update_complete", "info_empty", stat_params)
      return
    end
    local _update_info
    E.LOG.debug(TAG, "request_namespace_res_update succ >>")
    E.log(update_infos)
    for _ns, res_map in pairs(update_infos) do
      for _rk, _info in pairs(res_map) do
        if _rk == res_key then
          EL.LOG.debug(TAG, "add download res:" .. tostring(_rk))
          _update_info = _info
          break
        end
      end
    end
    E.LOG.debug(TAG, "request_namespace_res_update _update_info >>")
    E.log(_update_info)
    local UIM = require("ejoysdk_lua.res.update_info_manager")
    UIM.add_update_info(namespace, res_key, _update_info)
    local local_using_version = (using_res_info or {}).version
    _update_info = UIM.get_res_update_info(namespace, res_key, nil, local_using_version)
    if nil == _update_info or next(_update_info) == nil then
      EL.LOG.debug(TAG, "no startup res update, skip update")
      check_complete_cb(true, false)
      QL.commit_action_succ_main("check_namespace_res_update_complete", "no_update", stat_params)
      return
    end
    update_namespace_exts = update_namespace_exts or {}
    local namespace_ext = update_namespace_exts[namespace] or {}
    M.check_namespace_res_update_with_update_info(namespace, res_key, _update_info, using_res_info, namespace_ext, opts, function(_succ, ...)
      if _succ then
        local has_new_update, _update_info2 = ...
        local cur_res_state = M.get_res_state(namespace, res_key)
        if has_new_update then
          _update_info2 = _update_info2 or {}
          local update_ver = _update_info2[RTM.UPDATE_INFO_KEY.VERSION_NAME]
          stat_params.p3 = update_ver
          QL.commit_action_succ_main("check_namespace_res_update_wait_cf", update_ver, stat_params)
        else
          E.LOG.debug(TAG, "skip for no update with namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
        end
        check_complete_cb(true, true, has_new_update, cur_res_state, namespace_ext)
      else
        E.LOG.warn(TAG, "check_namespace_res_update failed, ns:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
        local code, msg = ...
        check_complete_cb(false, code, msg)
        return
      end
    end)
  end
  
  local using_cc_cache_info = opts.using_cc_cache_data or false
  if using_cc_cache_info then
    local config = ECC.get_config(namespace)
    local update_infos, update_namespace_exts = parse_update_infos({config})
    handle_namespace_res_update(update_infos, update_namespace_exts)
  else
    M.request_namespace_res_update({namespace}, local_res_params, function(succ, ...)
      if succ then
        local update_infos, update_namespace_exts = ...
        handle_namespace_res_update(update_infos, update_namespace_exts)
      else
        local err_code, err_msg = ...
        E.LOG.warn(TAG, "check_namespace_res_update failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
        check_complete_cb(false, err_code, err_msg)
      end
    end, opts, ext)
  end
end

function M.confirm_update_namespace_res(namespace, res_key, target_update_ver, _params, opts, complete_cb, on_res_state_change_listener, on_res_progress_change_listener)
  E.LOG.debug(TAG, "check_namespace_res_update begin, ns:" .. tostring(namespace) .. ", rk:" .. tostring(res_key))
  local nsdp = require("ejoysdk_lua.res.ejoy_namespace_dispatcher")
  opts = opts or {}
  nsdp.register_res_update_namespace(namespace, res_key, opts.listeners, opts, opts.engine_handler)
  local stat_params = {p1 = namespace, p2 = res_key}
  local current_res_state = M.get_res_state(namespace, res_key)
  current_res_state = current_res_state or {}
  local update_info = current_res_state[RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] or {}
  local current_update_ver = update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  if current_update_ver ~= target_update_ver then
    E.LOG.warn(TAG, "confirm_update_namespace_res skip, target ver not exists:" .. tostring(target_update_ver))
    if complete_cb then
      complete_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_VERSION_NOT_EXISTS, "target veresion not exists:" .. tostring(target_update_ver))
    end
    return
  end
  local state_listener, progress_listener
  
  function state_listener(_ns, _rk, state, state_obj)
    if on_res_state_change_listener then
      on_res_state_change_listener(_ns, _rk, state, state_obj)
    end
    if state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
      EL.LOG.debug(TAG, "res update complete, ns:" .. tostring(_ns) .. ", res_key:" .. tostring(_rk))
      M.unregister_res_state_change_listener(_ns, _rk, state_listener)
      M.unregister_res_progress_listener(_ns, _rk, progress_listener)
      QL.commit_action_succ_main("check_namespace_res_update_complete", "complete", stat_params)
      local info_flags = {pending_file_list = true}
      local cur_res_state = M.get_res_state(namespace, res_key, info_flags)
      if complete_cb then
        complete_cb(true, cur_res_state)
      end
    elseif state == RTM.PUBLIC_DOWNLOAD_STATE.FAILED then
      local code = state_obj[RTM.RES_STATE_INFO_KEY.ERR_CODE] or 0
      local msg = state_obj[RTM.RES_STATE_INFO_KEY.ERR_MSG]
      EL.LOG.warn(TAG, "res update failed, ns:" .. tostring(_ns) .. ", res_key:" .. tostring(_rk) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      M.unregister_res_state_change_listener(_ns, _rk, state_listener)
      M.unregister_res_progress_listener(_ns, _rk, progress_listener)
      if complete_cb then
        complete_cb(false, code, msg)
      end
      QL.commit_action_fail_main("check_namespace_res_update_failed", "download_fail", code, msg, stat_params)
    end
  end
  
  function progress_listener(_ns, _rk, progress_info)
    if on_res_progress_change_listener then
      on_res_progress_change_listener(_ns, _rk, progress_info)
    end
  end
  
  M.register_res_progress_listener(namespace, res_key, progress_listener)
  local reg_result, code, msg = M.register_res_state_change_listener(namespace, res_key, state_listener)
  if reg_result then
    local start_result, _code, _msg = M.start_download_res_update(namespace, res_key, opts)
    EL.LOG.debug(TAG, "start_download_res_update result:" .. tostring(start_result) .. ", code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    if not start_result then
      if complete_cb then
        complete_cb(false, _code, _msg)
      end
      return
    end
  else
    EL.LOG.warn(TAG, "register_res_state_change_listener failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    if complete_cb then
      complete_cb(false, code, msg)
    end
    return
  end
end

local function init_all_local_namespace_res()
  E.LOG.debug(TAG, "init_all_local_namespace_res begin")
  RTM.static_get_all_local_namespace_res()
end

function M.init(cb)
  if inited then
    E.LOG.debug(TAG, "already init and return")
    if cb then
      cb(true)
    end
    return
  end
  cb = cb or function()
  end
  init_all_local_namespace_res()
  save_config()
  inited = true
  cb(true)
end

local function check_local_cache(res_key, process)
  E.LOG.debug(TAG, "check local cache " .. tostring(res_key))
  local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
  local res = res_collection[res_key]
  if not res then
    E.LOG.debug(TAG, "no cache " .. tostring(res_key))
    release_bundle(res_key, process)
  else
    E.LOG.debug(TAG, "has cache " .. tostring(res_key))
    local res_config = JSON.decode(E.File.readfile(base_path .. RES_CONFIG) or "{}")
    process(nil ~= res_config, res_config)
  end
end

function M.get_res(namespace, res_key, cb)
  local stat_action = "res_get"
  E.LOG.debug(TAG, "res check " .. tostring(res_key))
  if not (res_key and "" ~= res_key and use_local_res(res_key, namespace)) or namespace == ECC.NAMESPACE.H5_RESOURCE and not is_wv_use_local_res() then
    E.LOG.debug(TAG, "res check false")
    cb(false)
    return
  end
  local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
  stat(stat_action, res_key)
  
  local function process(available, res_config)
    local succ = available and res_config and res_config.version and res_config.path
    if succ then
      res_config.local_url = get_cached_path() .. "/" .. base_path .. res_config.version
      if E.Utils.start_with(res_config.path, "./") then
        res_config.path = string.sub(res_config.path, 2, -1)
      end
      if not E.Utils.start_with(res_config.path, "/") then
        res_config.local_url = res_config.local_url .. "/"
      end
      res_config.local_url = res_config.local_url .. res_config.path
      stat(stat_action, res_key, true)
    else
      E.LOG.debug(TAG, "unavailable")
      stat(stat_action, res_key, false)
    end
    cb(succ, res_config)
  end
  
  local update_res = res_update_list[res_key]
  if update_res and (update_res.force_update or update_res.zip_release) then
    E.LOG.debug(TAG, "waiting for updating " .. tostring(res_key))
    process(false, update_res.config_info)
    stat(stat_action .. "_wait", res_key)
    return
  end
  check_local_cache(res_key, process)
end

function M.get_all_cached_resources()
  return res_collection
end

function M.get_all_cached_namespace_resources()
  do return end
  return RTM.static_get_all_local_namespace_res, nil
end

function M._check_cache_res_state()
  local cached_res_config = M.get_all_cached_resources()
  if cached_res_config and next(cached_res_config) ~= nil then
    for res_key, cached_res_conf in pairs(cached_res_config) do
      local bundle_res_info = M.get_bundle_res_info(res_key)
      bundle_res_info = bundle_res_info or {}
      cached_res_conf = cached_res_conf or {}
      local bundle_res_version = bundle_res_info[M.RES_CONFIG_KEY.KEY_VERSION]
      local cached_res_conf_version = cached_res_conf[M.RES_CONFIG_KEY.KEY_VERSION]
      E.LOG.debug(TAG, "_check_cache_res_state, cached_res_conf_version:" .. tostring(cached_res_conf_version) .. ", bundle_res_version:" .. tostring(bundle_res_version))
      if VER_CHECK.compare_versions(cached_res_conf_version, bundle_res_version) < 0 then
        E.LOG.debug(TAG, "compare_versions old than bundle res, now do remove")
        M.remove_resouce(res_key)
        res_state_changed_list[res_key] = true
      end
    end
  end
end

local function is_res_type_in_using(res_key)
  if "" == res_key or nil == res_key then
    return false
  end
  return res_key == M.RES_TYPE.EJOYSDK_LUA
end

function M.remove_resouce(res_key)
  if not res_key or "" == res_key then
    E.LOG.warn(TAG, "remove_resouce failed res_key is invalid:" .. tostring(res_key))
    return
  end
  E.LOG.debug(TAG, "begin remove_resouce:" .. tostring(res_key))
  if is_res_type_in_using(res_key) then
    local config_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/" .. RES_CONFIG
    E.File.remove(config_path)
  else
    local res_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
    E.File.remove(res_path)
  end
  res_collection[res_key] = nil
  M._mark_res_version_removed(res_key, "all")
end

function M._mark_res_version_removed(res_key, res_version)
  local removed_list = removed_res_cache_collection[res_key] or {}
  table.insert(removed_list, res_version)
  removed_res_cache_collection[res_key] = removed_list
end

function M._remove_previous_version_resource(res_key, res_version)
  if not (res_key and "" ~= res_key and res_version) or "" == res_version then
    E.LOG.warn(TAG, "_remove_previous_version_resource invalid res_key or res_version:" .. tostring(res_key) .. ", " .. tostring(res_version))
    return
  end
  M._mark_res_version_removed(res_key, res_version)
  if is_res_type_in_using(res_key) then
    E.LOG.debug(TAG, "remove_previous_version_resource skip for current using type:" .. tostring(res_key))
    return false
  end
  local previous_res_dir = RES_BUILTIN_PATH .. "/" .. res_key .. "/" .. tostring(res_version)
  E.File.remove(previous_res_dir)
  E.LOG.debug(TAG, "remove_previous_version_resource removed dir:" .. tostring(previous_res_dir))
  return true
end

local function fix_url_path(path)
  if nil == path or "" == path or "/" == path or "./" == path or "." == path then
    E.LOG.debug(TAG, "fix_url_path is empty, now return empty:" .. tostring(path))
    return ""
  end
  if not E.Utils.start_with(path, "/") then
    path = "/" .. path
  end
  return path
end

function M.get_res_location(res_key)
  local res_config = res_collection[res_key]
  local res_location
  if res_config then
    E.LOG.debug(TAG, "get_res_location has cache config, now read from config")
    local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
    local res_entrance_path = fix_url_path(res_config.path)
    res_location = base_path .. res_config.version .. res_entrance_path
    if _ejoysdk.os() ~= "ios" then
      res_location = get_cached_path() .. "/" .. res_location
    end
  else
    res_location = nil
  end
  return res_location
end

function M.get_all_res_locations()
  local result = {}
  for res_key, res_config in pairs(res_collection) do
    local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
    local res_entrance_path = fix_url_path(res_config.path)
    local res_location = get_cached_path() .. "/" .. base_path .. res_config.version .. res_entrance_path
    result[res_key] = res_location
  end
  E.LOG.debug(TAG, "get_all_res_locations result >>")
  E.LOG.debug(TAG, result)
  return result
end

function M.get_res_location_with_namespace(namespace, res_key)
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return nil, err_code, err_msg
  end
  do return res_src_model.get_res_location end
  return res_src_model.get_res_location, res_src_model, err_msg
end

function M.get_res_locations_with_namespace(_namespace)
end

function M.get_res_states(namespace)
  if not namespace or "" == namespace then
    E.LOG.warn(TAG, "get_res_states failed, namespace is nil")
    return nil
  end
  local res_states = {}
  local all_local_namespace_res = RTM.static_get_all_local_namespace_res()
  local res_infos = all_local_namespace_res[namespace] or {}
  for res_key, _ in pairs(res_infos) do
    local model = EMF.get_ejoy_res_source_model(namespace, res_key)
    local state = model:get_res_state()
    res_states[res_key] = state
  end
  return res_states
end

function M.get_res_state(namespace, res_key, info_flags)
  if EU.is_text_empty(namespace) or EU.is_text_empty(res_key) then
    E.LOG.warn(TAG, "get_res_state failed, namespace or res_key is nil")
    return nil
  end
  local model = EMF.get_ejoy_res_source_model(namespace, res_key)
  local state = model:get_res_state(info_flags)
  return state
end

function M.update_res_download_strategy(namespace, res_key, strategy)
  if EU.is_text_empty(namespace) or EU.is_text_empty(res_key) then
    E.LOG.warn(TAG, "get_res_state failed, namespace or res_key is nil")
    return nil
  end
  local model = EMF.get_ejoy_res_source_model(namespace, res_key)
  _ejoysdk.log("update_res_download_strategy namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", strategy:" .. tostring(strategy))
  model:update_res_download_strategy(strategy)
end

function M.get_simple_res_state(res_state_info)
  res_state_info = res_state_info or {}
  local res_progress_info = res_state_info.res_progress_info or {}
  local server_update_info = res_state_info.res_update_info or {}
  local new_version = server_update_info.version or 0
  local has_new_update = server_update_info.has_new_update or false
  local total_size = server_update_info.total_size or 0
  local total_count = server_update_info.total_count or 0
  if 0 == total_size and 0 == total_count then
    has_new_update = false
  end
  local file_list_type = server_update_info.file_list_type
  local using_res_info = res_state_info.using_res_info or {}
  local using_version = using_res_info.version
  local simple_res_state_info = {
    new_version = new_version,
    has_new_update = has_new_update,
    total_size = total_size,
    total_count = total_count,
    file_list_type = file_list_type,
    using_version = using_version,
    remain_size = total_size - (res_progress_info.downloading_size or 0),
    remain_count = total_count - (res_progress_info.finish_count or 0)
  }
  return simple_res_state_info
end

function M.start_download_res_update(namespace, res_key, _opts, confirm_cb)
  EL.LOG.debug(TAG, "start_download_res_update begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return false, err_code, err_msg
  end
  _opts = _opts or {}
  local _config = {
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_BASE_PATH] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_BASE_PATH],
    [RTM.RES_UPDATES_OPTIONS.RES_SAVE_STORAGE_TYPE] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.RES_SAVE_STORAGE_TYPE],
    [RTM.RES_UPDATES_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED] = _opts[ENUM.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED]
  }
  res_src_model:update_config(_config)
  do return res_src_model.start_download, res_src_model end
  return res_src_model.start_download, res_src_model, confirm_cb
end

function M.get_res_origin_file_list(namespace, res_key, groups, cb)
  EL.LOG.debug(TAG, "get_res_origin_file_list begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    E.LOG.warn(TAG, "get_res_origin_file_list failed, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", err_code:" .. tostring(err_code) .. ", err_msg:" .. tostring(err_msg))
    cb(nil, err_code, err_msg)
  end
  res_src_model:get_res_origin_file_list(groups, function(list, ...)
    cb(list, ...)
  end)
end

function M.get_download_strategy(namespace, res_key)
  EL.LOG.debug(TAG, "get_res_origin_file_list begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    E.LOG.warn(TAG, "get_res_origin_file_list failed, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", err_code:" .. tostring(err_code) .. ", err_msg:" .. tostring(err_msg))
    return nil
  end
  do return res_src_model.get_download_strategy end
  return res_src_model.get_download_strategy, res_src_model, "get_res_origin_file_list failed, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", err_code:" .. tostring(err_code) .. ", err_msg:" .. tostring(err_msg), tostring(namespace), ", res_key:", tostring(res_key), ", err_code:", tostring(err_code), ", err_msg:", tostring(err_msg), err_msg
end

function M.stop_download_res_update(namespace, res_key, _cb)
  EL.LOG.debug(TAG, "stop_download_res_update begin, namespace:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key))
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    if _cb then
      _cb(false, err_code, err_msg)
    end
    return
  end
  do return res_src_model.pause_download, res_src_model end
  return res_src_model.pause_download, res_src_model, function(pause_result)
    EL.LOG.debug(TAG, "stop_download_res_update pause result:" .. tostring(pause_result))
    if _cb then
      _cb(pause_result)
    end
  end, err_msg
end

function M.register_res_update_namespace(namespace, listeners, opts)
  ENUM.register_res_update_namespace(namespace, nil, listeners, opts)
end

function M.unregister_res_update_namespace(namespace)
  ENUM.unregister_res_update_namespace(namespace)
end

function M.register_res_state_change_listener(namespace, res_key, state_listener)
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return false, err_code, err_msg
  end
  res_src_model:register_res_state_listener(state_listener)
  return true
end

function M.unregister_res_state_change_listener(namespace, res_key, state_listener)
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return false, err_code, err_msg
  end
  res_src_model:unregister_res_state_listener(state_listener)
  return true
end

function M.register_res_progress_listener(namespace, res_key, progress_listener)
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return false, err_code, err_msg
  end
  res_src_model:register_progress_listener(progress_listener)
  return true
end

function M.unregister_res_progress_listener(namespace, res_key, progress_listener)
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return false, err_code, err_msg
  end
  res_src_model:unregister_progress_listener(progress_listener)
  return true
end

function M.publish_using_res_version(namespace, res_key, res_version, res_project_name, res_type)
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    return false, err_code, err_msg
  end
  res_src_model:update_using_res_version(res_version, res_project_name, res_type)
end

function M.repair(namespace, res_key, group_name)
  if group_name then
    local GRM = require("ejoysdk_lua.res.group_res_manager")
    local group_rk = GRM.get_task_key(res_key, group_name)
    M.publish_using_res_version(namespace, group_rk, nil, nil, nil)
  else
    M.publish_using_res_version(namespace, res_key, nil, nil, nil)
    local group_rk_arr = RTM.static_get_res_group_rk_arr(namespace, res_key)
    for _, group_rk in ipairs(group_rk_arr) do
      M.publish_using_res_version(namespace, group_rk, nil, nil, nil)
    end
  end
end

function M.remove_res_version(namespace, res_key, res_version, opts)
  EL.LOG.debug(TAG, "remove_res_version begin, ns:" .. tostring(namespace) .. ", res_key:" .. tostring(res_key) .. ", res_version:" .. tostring(res_version))
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key, opts)
  if not res_src_model then
    return false, err_code, err_msg
  end
  res_src_model:remove_res(res_version)
end

function M.download_res_files(namespace, res_key, res_version, file_path_list, opts, complete_cb, state_listener, progress_listener)
  local rstat = require("ejoysdk_lua.res.res_stat")
  local beign_time = os.time()
  local list_size = file_path_list and #file_path_list or 0
  
  local function _complete_cb(succ, ...)
    local cost_time = os.time() - beign_time
    if succ then
      E.LOG.debug(TAG, "download_res_files _complete_cb result:" .. tostring(succ))
      rstat.stat_down_files_end(namespace, res_key, res_version, list_size, true, cost_time)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "download_res_files _complete_cb result:" .. tostring(succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      rstat.stat_down_files_end(namespace, res_key, res_version, list_size, false, cost_time, code, msg)
    end
    if complete_cb then
      complete_cb(succ, ...)
    end
  end
  
  rstat.stat_down_files_begin(namespace, res_key, res_version, list_size)
  if 0 == list_size then
    _complete_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_FILE_LIST_EMPTY, "file list empty")
    return
  end
  local file_list
  local file_item_type = type(file_path_list[1])
  if "table" == file_item_type then
    file_list = {}
    for _, file_item in ipairs(file_path_list) do
      table.insert(file_list, file_item.path)
    end
  end
  file_path_list = file_list or file_path_list
  local current_res_state = M.get_res_state(namespace, res_key)
  current_res_state = current_res_state or {}
  local update_info = current_res_state[RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] or {}
  local current_update_ver = update_info[RTM.UPDATE_INFO_KEY.VERSION_NAME]
  E.LOG.debug(TAG, "download_res_files current_res_state>>")
  E.log(current_res_state)
  if current_update_ver ~= res_version then
    E.LOG.warn(TAG, "download_res_files skip, target ver not exists:" .. tostring(res_version))
    if _complete_cb then
      _complete_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_VERSION_NOT_EXISTS, "target veresion not exists:" .. tostring(res_version))
    end
    return
  end
  local res_src_model, err_code, err_msg = EMF.get_ejoy_res_source_model(namespace, res_key)
  if not res_src_model then
    _complete_cb(false, err_code, err_msg)
    return
  end
  res_src_model:download_res_files(file_path_list, opts, function(_state, _state_obj, _ext_obj)
    if state_listener then
      state_listener(_state, _state_obj)
    end
    if _state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
      EL.LOG.debug(TAG, "download_res_files complete")
      _complete_cb(true, _state_obj, _ext_obj)
    elseif _state == RTM.PUBLIC_DOWNLOAD_STATE.FAILED then
      EL.LOG.debug(TAG, "download_res_files failed")
      local code = _state_obj[RTM.RES_STATE_INFO_KEY.ERR_CODE]
      local msg = _state_obj[RTM.RES_STATE_INFO_KEY.ERR_MSG]
      _complete_cb(false, code, msg)
    end
  end, progress_listener)
end

return M
