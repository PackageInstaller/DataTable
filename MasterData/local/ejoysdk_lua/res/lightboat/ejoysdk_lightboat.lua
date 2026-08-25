local E = require("ejoysdk_lua.ejoysdk")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ERF = require("ejoysdk_lua.res.base_ejoysdk_res")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local TAG = "ejoysdk_lightboat"
local RES_BUILTIN_PATH = "ejoysdk_lightboat_res"
local RES_CONFIG = "config"
local pkg_webview_data_size = 0
local M = {}
M.has_inited = false
local ecc_config_data_cache = {}
local webview_url_to_file_path_cache = {}
local webview_url_path_table_cache = {}
local pkg_webview_data_cache = {}
local _is_support_win, cache_file_path
local is_cache_file_full_path = false

local function stat(action, key, succ, params)
  local ejoysdk_stat = require("ejoysdk_lua.ejoysdk_stat")
  E.LOG.debug(TAG, "action=" .. tostring(action) .. ", key=" .. tostring(key) .. ", succ=" .. tostring(succ or "nil"))
  ejoysdk_stat.stat_action(action, key, succ, params)
end

local OFFLINE_PKG_DOWNLOAD = "offline_pkg_download"
local STAT_TIME_MAP = {}

local function stat_bizid(bizid, biztype, params)
  local ejoysdk_stat = require("ejoysdk_lua.ejoysdk_stat")
  E.LOG.debug(TAG, "bizid=" .. tostring(bizid) .. ", params=" .. tostring(params))
  local time_key = bizid .. "start"
  if "0" == biztype then
    STAT_TIME_MAP[time_key] = E.system_ms()
  elseif "1" == biztype then
    params.duration = STAT_TIME_MAP[time_key] and E.system_ms() - STAT_TIME_MAP[time_key] or 0
    STAT_TIME_MAP[time_key] = nil
  end
  ejoysdk_stat.stat_bizid(bizid, biztype, "0", params)
end

local function is_support_win()
  if nil ~= _is_support_win then
    return _is_support_win
  end
  _is_support_win = _ejoysdk.get_resources_path and true or false
  return _is_support_win
end

local function get_webview_cache_file_path()
  if nil ~= cache_file_path then
    return cache_file_path, is_cache_file_full_path
  end
  E.LOG.debug(TAG, " webview_cache_file_path1 =  " .. tostring(cache_file_path))
  local cache_path = RES_BUILTIN_PATH .. "/" .. RES_CONFIG
  local is_full_path = false
  if _ejoysdk.os() == "windows" and is_support_win() then
    local private_cache_path = E.Path.join(E.File.get_ext_file_dir(), cache_path)
    if E.File.process_exists(private_cache_path) then
      cache_path = private_cache_path
      is_full_path = true
    end
    cache_file_path = cache_path
    E.LOG.debug(TAG, " webview_cache_file_path3 =  " .. tostring(cache_file_path))
  else
    cache_file_path = cache_path
  end
  E.LOG.debug(TAG, " webview_cache_file_path =  " .. tostring(cache_file_path))
  is_cache_file_full_path = is_full_path
  return cache_file_path
end

local function load_webview_cache_config()
  local json_str = E.File.readfile(get_webview_cache_file_path())
  E.LOG.debug(TAG, ", json_str = " .. tostring(json_str))
  if json_str and string.len(json_str) > 0 then
    webview_url_to_file_path_cache = JSON.decode(json_str) or {}
  else
    webview_url_to_file_path_cache = {}
  end
end

local function load_pkg_webview_cache_config()
  local base_path = RES_BUILTIN_PATH
  local os = _ejoysdk.os()
  if "windows" == os and _ejoysdk.get_resources_path then
    local win_res_path = _ejoysdk.get_resources_path()
    base_path = E.Path.join(win_res_path, RES_BUILTIN_PATH)
  end
  local qz_h5_config = base_path .. "/" .. RES_CONFIG
  E.LOG.debug(TAG, "assets qz_h5_config_content path: " .. tostring(qz_h5_config))
  local assets_qz_h5_config_content = _ejoysdk.lread(qz_h5_config)
  E.LOG.debug(TAG, "assets qz_h5_config_content is " .. tostring(assets_qz_h5_config_content))
  if assets_qz_h5_config_content and "" ~= assets_qz_h5_config_content then
    local sep = "\n"
    if "windows" == os then
      sep = "\r\n"
    end
    local qz_h5_list = E.Utils.split_string(assets_qz_h5_config_content, sep)
    local index = 0
    for _, qz_h5_rk in pairs(qz_h5_list) do
      qz_h5_rk = E.Utils.trim(qz_h5_rk)
      local qz_h5_res_config_path = base_path .. "/" .. qz_h5_rk .. "/" .. RES_CONFIG
      E.LOG.debug(TAG, " h5 res config path " .. qz_h5_res_config_path)
      local assets_qz_res_config_content = _ejoysdk.lread(qz_h5_res_config_path)
      local assets_qz_res_config = JSON.decode(assets_qz_res_config_content) or {}
      E.LOG.debug(TAG, qz_h5_rk .. " h5 res config is >>>")
      E.LOG.debug(TAG, assets_qz_res_config)
      local urls = assets_qz_res_config.urls
      if urls and next(urls) then
        for _, url in ipairs(urls) do
          local code = E.Utils.url_clipping(url)
          pkg_webview_data_cache[code] = assets_qz_res_config
          index = index + 1
        end
      else
        E.LOG.debug(TAG, "qz res config is invalid, skip cache, key is " .. tostring(qz_h5_rk))
      end
    end
    pkg_webview_data_size = index
  end
end

local function set_local_path_to_url_code(code, local_path)
  if not code or not local_path then
    return
  end
  if not webview_url_path_table_cache[code] then
    E.LOG.debug(TAG, "set path for code, code = " .. code .. ", path = " .. local_path)
  else
    E.LOG.debug(TAG, "code already has local_path cache, code = " .. code .. ", old path = " .. webview_url_path_table_cache[code] .. " new path = " .. local_path)
  end
  webview_url_path_table_cache[code] = local_path
end

local function remove_local_path_with_url_code(code)
  if code then
    webview_url_path_table_cache[code] = nil
    E.LOG.debug(TAG, "remove code cache, code is " .. tostring(code))
  end
end

function M.remove_local_path_with_url_code(code)
  do return remove_local_path_with_url_code end
  return remove_local_path_with_url_code, code
end

local function save_webview_cache_config_to_disk()
  local str = JSON.encode(webview_url_to_file_path_cache)
  E.LOG.debug(TAG, "str=" .. tostring(str))
  local wv_cache_file_path, is_full_path = get_webview_cache_file_path()
  if true == is_full_path then
    E.File.writefile_fullpath(wv_cache_file_path, str, false)
  else
    E.File.writefile(wv_cache_file_path, str, false)
  end
end

local function get_latest_version(path_table)
  local max_version
  if path_table and type(path_table) == "table" then
    for version, _temp_path in pairs(path_table) do
      if not max_version then
        max_version = version
      elseif VER_CHECK.compare_versions(max_version, version) < 0 then
        max_version = version
      end
    end
  end
  return max_version
end

local function get_latest_version_with_code(code)
  if not code then
    return nil
  end
  local code_table = webview_url_to_file_path_cache[code]
  if not code_table then
    return nil
  end
  local paths = code_table.paths
  do return get_latest_version end
  return get_latest_version, paths
end

local function update_resource_with_config(res_info, local_res_latest_version, invalid_res_key_table, cb)
  local stat_action = "webview_preload_download"
  local config_info = res_info.config_info
  E.LOG.debug(TAG, " update_resource_with_config-------called")
  local res_key = config_info.key
  if not res_key then
    E.LOG.debug(TAG, "res_info.key is nil, can not to download file, return now, res_info.url")
    return
  end
  local base_path = RES_BUILTIN_PATH .. "/" .. res_key .. "/"
  local ext_file_dir = E.File.get_ext_file_dir()
  local unzip_path = base_path .. config_info.version
  unzip_path = string.format("%s/%s", ext_file_dir, unzip_path)
  
  local function notify(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end
  
  stat(stat_action .. "_start", res_key)
  local qz_h5_engine_handler = {
    on_res_apply = function(_engine_context, _res_location, apply_cb, _progress_cb)
      local info_flags = {pending_file_list = true}
      local _res_state_infos = ERF.get_res_state(ECC.NAMESPACE.MARKET_H5_RESOURCE, res_key, info_flags)
      local file_list_info = _res_state_infos[RTM.INFO_TYPE_KEY.TYPE_PENDING_FILE_LIST_INFO] or {}
      if nil == file_list_info[1] or nil == file_list_info[1].name then
        apply_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_GET_FILE_NAME_FAILED, "资源文件名获取失败")
        return
      end
      local file_name = file_list_info[1].name
      local zip_save_path = E.Utils.trim_end(_res_location, "/") .. "/" .. file_name
      E.LOG.debug(TAG, "下载路径为: " .. tostring(zip_save_path))
      stat(stat_action .. "_unzip", res_key)
      E.File.unzip_full_path(zip_save_path, unzip_path, function(ret)
        if ret.succ then
          E.LOG.debug(TAG, tostring(res_key) .. " 解压成功")
          local server_path = config_info.path
          if E.Utils.start_with(server_path, "./") then
            server_path = string.sub(server_path, 2, -1)
          end
          if not E.Utils.start_with(server_path, "/") then
            server_path = "/" .. server_path
          end
          local local_file_path = unzip_path .. server_path
          E.LOG.debug(TAG, " 本地文件路径为 = " .. local_file_path)
          local_file_path = E.Utils.trim_start(local_file_path, ext_file_dir)
          local_file_path = E.Utils.trim_start(local_file_path, "/")
          E.LOG.debug(TAG, " 本地文件相对路径为 = " .. local_file_path)
          for _, code in ipairs(res_info.codes) do
            local latest_version = get_latest_version_with_code(code)
            if VER_CHECK.compare_versions(config_info.version, latest_version) > 0 and VER_CHECK.compare_versions(config_info.version, invalid_res_key_table[code]) > 0 then
              E.LOG.debug(TAG, "download_version is valid, now refresh local data")
              local temp_table = config_info
              local path_table
              if webview_url_to_file_path_cache[code] then
                local temp = utils.deepcopy(webview_url_to_file_path_cache[code])
                path_table = temp.paths or {}
              else
                path_table = {}
              end
              path_table[config_info.version] = local_file_path
              temp_table.paths = path_table
              webview_url_to_file_path_cache[code] = temp_table
              set_local_path_to_url_code(code, local_file_path)
            end
          end
          save_webview_cache_config_to_disk()
          apply_cb(true)
          stat_bizid(OFFLINE_PKG_DOWNLOAD, "1", {
            biz_key = res_key,
            version = config_info.version
          })
        else
          E.LOG.debug(TAG, tostring(res_key) .. " 解压失败")
          stat(stat_action .. "_unzip", res_key, false)
          apply_cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_UNZIP_FAILED, ret.msg)
        end
        E.File.remove_fullpath(zip_save_path)
      end)
    end
  }
  local current_res_info = {
    res_key = res_key,
    engine_handler = qz_h5_engine_handler,
    version = local_res_latest_version
  }
  local new_version
  
  local function _on_confirm_res_update_handler(res_state_info, confirm_update_cb)
    local update_ver = res_state_info.new_version
    local has_new_update = res_state_info.has_new_update
    E.LOG.debug(TAG, "on_receive_res_update_confirm, res_key:" .. tostring(res_key) .. ", ver:" .. tostring(update_ver))
    if has_new_update then
      confirm_update_cb(true)
      new_version = update_ver
      E.LOG.debug(TAG, "on_receive_res_update_confirm has update, confirm true")
    else
      confirm_update_cb(false)
      E.LOG.debug(TAG, "on_receive_res_update_confirm has not update, confirm false")
    end
  end
  
  local function on_res_update_complete_handler(update_result, ...)
    if update_result then
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 下载成功")
      notify(true, config_info)
      stat(stat_action .. "_unzip", res_key, true)
      local request_namespace = ECC.NAMESPACE.MARKET_H5_RESOURCE
      local version_table = ECC.get_ex_info(request_namespace) or {}
      version_table[res_key] = {version = new_version}
      ECC.set_ex_info(request_namespace, version_table)
    else
      E.LOG.debug(TAG, "res_key: " .. tostring(res_key) .. " 下载失败")
      local code, msg = ...
      notify(false, code, msg, config_info)
      stat(stat_action, res_key, false, {code = code, msg = msg})
    end
  end
  
  local listeners = {on_confirm_res_update = _on_confirm_res_update_handler, on_res_update_complete = on_res_update_complete_handler}
  local opts = {
    [ERF.NAMESPACE_UPDATE_OPTIONS.FOREGROUND_NOTIFICATION_ENABLED] = false,
    [ERF.NAMESPACE_UPDATE_OPTIONS.USING_CC_CACHE_DATA] = true
  }
  stat_bizid(OFFLINE_PKG_DOWNLOAD, "0", {
    biz_key = res_key,
    version = config_info.version
  })
  ERF.check_and_update(ECC.NAMESPACE.MARKET_H5_RESOURCE, current_res_info, opts, listeners)
end

local function find_parent_folder(path)
  if not path or 0 == string.len(path) then
    return path
  end
  if E.Utils.end_with(path, "/") then
    path = string.sub(path, 1, string.len(path) - 1)
  end
  local full_url = path
  local temp = string.reverse(full_url)
  local i = string.find(temp, "/")
  if nil ~= i and i > 0 then
    local offset = string.len(full_url) - i + 1
    do return string.sub, full_url, 1 end
    return string.sub, full_url, 1, offset
  end
  return path
end

local function is_support_use_local_res(key)
  local pkg_info = E.get_pkg_info()
  local has_cache = ecc_config_data_cache and key and nil ~= ecc_config_data_cache[key] and next(ecc_config_data_cache[key])
  local is_device_support = has_cache and E.File.is_support_handling_file_cache() and (pkg_info.os ~= "android" or pkg_info.os == "android" and VER_CHECK.compare_versions(pkg_info.versions.os_version, 23) >= 0) and (pkg_info.os ~= "ios" or pkg_info.os == "ios" and VER_CHECK.compare_versions(pkg_info.versions.os_version, "10.0") >= 0)
  return is_device_support
end

local function check_webview_cache(cb)
  local index = 0
  local total_size = pkg_webview_data_size
  E.LOG.debug(TAG, "total size is " .. tostring(total_size))
  if 0 == total_size then
    cb()
    return
  end
  
  local function cb_wrapper()
    index = index + 1
    if index == total_size then
      save_webview_cache_config_to_disk()
      cb()
    end
  end
  
  local cache_release_res = {}
  for code, _ in pairs(pkg_webview_data_cache) do
    local cache_config_info = webview_url_to_file_path_cache[code] or {}
    local latest_version = cache_config_info.version
    local code_pkg_webview_data = pkg_webview_data_cache[code] or {}
    local code_version = code_pkg_webview_data.version
    E.LOG.debug(TAG, code .. ", latest version is " .. tostring(latest_version) .. ", pkg version is " .. tostring(code_version))
    local code_pkg_res_key = code_pkg_webview_data.res_key
    if VER_CHECK.compare_versions(code_version, latest_version) > 0 then
      local base_path = RES_BUILTIN_PATH .. "/" .. code_pkg_res_key .. "/"
      local unzip_path = base_path .. code_version
      local bundle_zip_path = RES_BUILTIN_PATH .. "/" .. code_pkg_res_key .. "/" .. code_version .. ".zip"
      
      local function handler_release_bundle_res(_unzip_path)
        if not webview_url_to_file_path_cache[code] then
          webview_url_to_file_path_cache[code] = {}
        end
        local activeStatus = code_pkg_webview_data.activeStatus
        if nil == activeStatus then
          activeStatus = 1
        end
        webview_url_to_file_path_cache[code] = webview_url_to_file_path_cache[code] or {}
        webview_url_to_file_path_cache[code].activeStatus = activeStatus
        webview_url_to_file_path_cache[code].paths = webview_url_to_file_path_cache[code].paths or {}
        webview_url_to_file_path_cache[code].key = code_pkg_res_key
        webview_url_to_file_path_cache[code].version = code_version
        local path = code_pkg_webview_data.path
        webview_url_to_file_path_cache[code].path = path
        local real_path = _unzip_path .. tostring(path)
        E.LOG.debug(TAG, "local file path:" .. tostring(real_path))
        webview_url_to_file_path_cache[code].paths[code_version] = real_path
        E.LOG.debug(TAG, "set code " .. tostring(code) .. ", version is " .. tostring(code_version) .. ", path is " .. tostring(real_path))
        E.LOG.debug(TAG, webview_url_to_file_path_cache[code].paths)
      end
      
      if cache_release_res[code_pkg_res_key] then
        E.LOG.debug(TAG, "this res_key has release, do not release again, now set new code config")
        handler_release_bundle_res(cache_release_res[code_pkg_res_key])
        cb_wrapper()
      else
        cache_release_res[code_pkg_res_key] = unzip_path
        E.File.release_bundle_res(bundle_zip_path, bundle_zip_path, function(release_ret)
          if release_ret.succ then
            E.LOG.debug(TAG, "res_key: " .. tostring(code_pkg_res_key) .. " 释放成功")
            E.File.unzip(bundle_zip_path, unzip_path, function(ret)
              if ret.succ then
                handler_release_bundle_res(unzip_path)
                if _ejoysdk.os() == "windows" then
                  E.File.remove(bundle_zip_path)
                end
              else
                E.LOG.debug(TAG, "res_key: " .. tostring(code_pkg_res_key) .. " 解压失败")
              end
              cb_wrapper()
            end)
          else
            E.LOG.debug(TAG, "res_key: " .. tostring(code_pkg_res_key) .. " 释放失败")
            cb_wrapper()
          end
        end)
      end
    else
      cb_wrapper()
    end
  end
end

local function get_latest_version_path(path_table)
  local max_version = get_latest_version(path_table)
  local result_path = path_table[max_version]
  return result_path
end

local function check_config_to_update_resource(key, remote_res, invalid_res_key_table, cb, only_update_config)
  cb = cb or function()
  end
  local stat_action = "webview_preload_request"
  E.LOG.debug(TAG, ", check_config_to_update_resource-------called, key = " .. key)
  E.LOG.debug(TAG, remote_res)
  if not is_support_use_local_res(key) then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_CACHE_NOT_SUPPORT, "not support")
    return
  end
  if next(remote_res) == nil then
    E.LOG.debug(TAG, "res_update_by_key response nil, skip")
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RESPONSE_INVALID, "config is nil, skip update")
    return
  end
  if not remote_res.handler then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_TYPE_UNKOWN, "type is nil, can not to download it")
    E.LOG.debug(TAG, ", type is nil, return now---")
    stat(stat_action .. "_no_type", key)
    return
  end
  local ext = remote_res.ext or {}
  if remote_res.handler == "qzH5Handler" and (not (remote_res.key and ext._qz_urls) or not next(ext._qz_urls)) then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_CACHE_NOT_SUPPORT, "data is wrong, has no [key] or no [ext._qz_urls] value， can not to download")
    E.LOG.debug(TAG, ", data is wrong ,no key or noe code. return now---")
    stat(stat_action .. "_no_key_code", key)
    return
  end
  local expireOn
  if ext._qz_expireOn and tonumber(ext._qz_expireOn) then
    expireOn = tonumber(ext._qz_expireOn)
    local file_expired_time = expireOn / 1000
    if file_expired_time > 0 and file_expired_time < E.time() then
      cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_RES_EXPIRED, "file has already expired, do not download anymore")
      E.LOG.debug(TAG, ", file has already expired, return now---, E.time() = " .. tostring(E.time()) .. ", file_expired_time = " .. tostring(file_expired_time))
      stat(stat_action .. "_expired", key)
      return
    end
  end
  local storage_data = E.Sysinfo.get_storage_info()
  local free_size = storage_data.internal_available_storage_size
  local size_left = 524288000
  if nil ~= free_size and free_size > 0 and remote_res.origin and remote_res.origin.size and free_size <= remote_res.origin.size + size_left then
    cb(false, CONSTANTS.RESOURCE_UPDATE_ERROR_CODES.RES_DEVICE_NOT_HAS_ENOUGH_SPACE, "device not has enough space to download this file.")
    E.LOG.debug(TAG, ", device has no space to download file, return now---")
    stat(stat_action .. "_no_device_memory_left", key)
    return
  end
  local urls = ext._qz_urls
  local local_res_latest_version
  local codes = {}
  for _, url in pairs(urls) do
    local code = E.Utils.url_clipping(url)
    table.insert(codes, code)
    local code_local_latest_version = get_latest_version_with_code(code)
    if invalid_res_key_table[code] and VER_CHECK.compare_versions(invalid_res_key_table[code], code_local_latest_version) > 0 then
      code_local_latest_version = invalid_res_key_table[code]
    end
    if code_local_latest_version then
      if not local_res_latest_version then
        local_res_latest_version = code_local_latest_version
      elseif VER_CHECK.compare_versions(local_res_latest_version, code_local_latest_version) > 0 then
        local_res_latest_version = code_local_latest_version
      end
    end
  end
  remote_res.config_info = {
    key = remote_res.key,
    version = remote_res.version,
    path = ext._qz_path,
    urls = urls,
    expireOn = expireOn,
    restrict = ext._qz_restrict,
    activeStatus = ext._qz_activeStatus
  }
  remote_res.codes = codes
  E.LOG.debug(TAG, "local min version: " .. tostring(local_res_latest_version) .. ", remote version: " .. tostring(remote_res.version))
  if not local_res_latest_version or VER_CHECK.compare_versions(local_res_latest_version, remote_res.version) < 0 then
    local config_info = remote_res.config_info
    if config_info.restrict then
      for _, code in ipairs(remote_res.codes) do
        local code_local_latest_version = get_latest_version_with_code(code)
        if VER_CHECK.compare_versions(config_info.version, code_local_latest_version) > 0 then
          remove_local_path_with_url_code(code)
        end
      end
    end
    if not only_update_config then
      update_resource_with_config(remote_res, local_res_latest_version, invalid_res_key_table, function(update_succ, ...)
        if update_succ then
          local res_config_data = (...)
          cb(true, res_config_data)
          local url_codes = res_config_data and res_config_data.urls
          if url_codes and type(url_codes) == "table" then
            for _, v_url in pairs(url_codes) do
              ET.publish(ET.lightboat.RES_UPDATE_FINISH_PREFIX .. tostring(v_url), v_url, res_config_data)
            end
          end
        else
          cb(false, ...)
        end
        stat(stat_action, key, update_succ)
      end)
    else
      E.LOG.debug(TAG, "only update config, no need to download file.")
      cb(true, remote_res.config_info)
    end
  else
    E.LOG.debug(TAG, ", version is new, no need to download file.")
    cb(true, remote_res.config_info)
  end
end

local function update_data_with_config(config, cb, only_update_config)
  E.LOG.debug(TAG, ", update_data_with_config-----called, only_update_config is " .. tostring(only_update_config))
  E.LOG.debug(TAG, config)
  config = config or {}
  local util = require("ejoysdk_lua.ejoysdk_utils")
  local invalid_res_key_table = {}
  local pending_res_key_table = {}
  if config.config then
    local temp_ecc_table = {}
    local update_total_count = 0
    for key, res_config in pairs(config.config) do
      if "initConf" == key then
        E.LOG.debug(TAG, "ignore initConf key")
      elseif type(res_config) == "table" and util.tablelength(res_config) > 0 then
        ecc_config_data_cache[key] = res_config
        temp_ecc_table[key] = res_config
        local ext = res_config.ext or {}
        local expireOn = ext._qz_expireOn and tonumber(ext._qz_expireOn)
        local is_expired = false
        if expireOn then
          local file_expired_time = expireOn / 1000
          if file_expired_time < E.time() then
            is_expired = true
          end
        end
        local activeStatus = ext._qz_activeStatus
        if activeStatus and 1 == tonumber(activeStatus) and false == is_expired then
          E.LOG.debug(TAG, "key: " .. tostring(key) .. ", res is valid, version is " .. tostring(res_config.version))
          pending_res_key_table[key] = res_config
          update_total_count = update_total_count + 1
        else
          E.LOG.debug(TAG, "key: " .. tostring(key) .. ", res is invalid, version is " .. tostring(res_config.version))
          local urls = ext._qz_urls or {}
          for _, url in ipairs(urls) do
            local code = E.Utils.url_clipping(url)
            local code_latest_version = get_latest_version_with_code(code)
            if VER_CHECK.compare_versions(res_config.version, code_latest_version) >= 0 then
              remove_local_path_with_url_code(code)
              if VER_CHECK.compare_versions(res_config.version, invalid_res_key_table[code]) > 0 then
                E.LOG.debug(TAG, "code is " .. tostring(code) .. ", local real version is " .. tostring(res_config.version) .. ", remote version is " .. tostring(res_config.version) .. ", code cache invalid max version is " .. tostring(invalid_res_key_table[code]))
                E.LOG.debug(TAG, ", a bigger version exist, use it's expireOn and activeStatus, expireOn is " .. tostring(expireOn) .. ", activeStatus is " .. tostring(activeStatus))
                invalid_res_key_table[code] = res_config.version
                if webview_url_to_file_path_cache[code] then
                  local config_info = {
                    key = key,
                    version = res_config.version,
                    path = ext._qz_path,
                    urls = urls,
                    expireOn = expireOn,
                    restrict = ext._qz_restrict,
                    activeStatus = ext._qz_activeStatus
                  }
                  config_info.paths = webview_url_to_file_path_cache[code].paths
                  webview_url_to_file_path_cache[code] = config_info
                  if urls and type(urls) == "table" then
                    for _, v_url in pairs(urls) do
                      ET.publish(ET.lightboat.RES_UPDATE_FINISH_PREFIX .. tostring(v_url), v_url, res_config)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    save_webview_cache_config_to_disk()
    E.LOG.debug(TAG, "invalid_res_key_table is ")
    E.LOG.debug(TAG, invalid_res_key_table)
    local index = 0
    local all_check_update_succ = true
    local last_err_code, last_err_msg
    
    local function update_config_cb(_succ, ...)
      index = index + 1
      if not _succ then
        all_check_update_succ = false
        last_err_code, last_err_msg = ...
      end
      if cb and index == update_total_count then
        cb(all_check_update_succ, last_err_code, last_err_msg)
      end
    end
    
    for pending_key, pending_config in pairs(pending_res_key_table) do
      check_config_to_update_resource(pending_key, pending_config, invalid_res_key_table, update_config_cb, only_update_config)
    end
    ecc_config_data_cache = temp_ecc_table
  end
end

M.get_config_center_data_with_namespace = ECC.get_config
M.get_configs_in_whitelist = ECC.get_configs_in_whitelist

local function request_cc_config(request_namespace, cb)
  local options = {
    disable_update_cache = true,
    update_type = ECC.CONFIG_CENTER_UPDATE_TYPE.ALL
  }
  E.LOG.debug(TAG, "request_cc_config ----called")
  ECC.get_configs_with_options(options, {request_namespace}, function(succ, ...)
    E.LOG.debug(TAG, "get_configs_with_options, succ=" .. tostring(succ))
    if succ then
      local configs = (...)
      configs = configs or {}
      for _, config in ipairs(configs) do
        local namespace = config.namespace or ""
        if namespace == ECC.NAMESPACE.MARKET_H5_RESOURCE then
          cb(true, config)
          return
        end
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "request h5 config fail, code is " .. tostring(code) .. ", msg is " .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.init(cb)
  cb = cb or function()
  end
  local os_value = E.Sysinfo.os()
  if "windows" == os_value and not is_support_win() then
    M.has_inited = true
    ET.publish(ET.lightboat.INITED)
    cb(true)
    return
  end
  local stat_action = "local_path_set_to_webview"
  load_webview_cache_config()
  load_pkg_webview_cache_config()
  
  local function check_remote_res_update()
    local namespace = ECC.NAMESPACE.MARKET_H5_RESOURCE
    local check_before_time = E.system_clock()
    
    local function remote_check_cb(_succ, ...)
      E.LOG.debug(TAG, "lightboat remote res check cost:" .. tostring(E.system_clock() - check_before_time))
      if _succ then
        E.LOG.debug(TAG, "remote_check_cb succ")
      else
        local _code, _msg = ...
        E.LOG.warn(TAG, "remote_check_cb failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      end
      ET.publish(ET.lightboat.QZ_H5_RES_UPDATE_CHECK_ALL_COMPLETE, _succ, ...)
    end
    
    local request_namespace = ECC.NAMESPACE.MARKET_H5_RESOURCE
    if not ECC.get_ex_info(request_namespace) then
      E.LOG.debug(TAG, "init_check_webview_cache ----called")
      E.LOG.debug(TAG, {pkg_webview_data_cache = pkg_webview_data_cache})
      E.LOG.debug(TAG, {webview_url_to_file_path_cache = webview_url_to_file_path_cache})
      local version_table = {}
      if next(webview_url_to_file_path_cache) then
        for _code, temp_table in pairs(webview_url_to_file_path_cache) do
          local res_key = temp_table.key
          local res_version = temp_table.version
          if res_key and res_version then
            version_table[res_key] = {version = res_version}
          end
        end
      end
      if next(pkg_webview_data_cache) then
        for _key, version_config in pairs(pkg_webview_data_cache) do
          local res_key = version_config.res_key
          local res_version = version_config.version
          local old_version = version_table[res_key] and version_table[res_key].version or nil
          if res_key and res_version and (not old_version or VER_CHECK.compare_versions(res_version, old_version) > 0) then
            version_table[res_key] = {version = res_version}
          end
        end
      end
      if next(version_table) then
        E.LOG.debug(TAG, "set_ex_info ---called")
        E.LOG.debug(TAG, {request_namespace = request_namespace, version_table = version_table})
        ECC.set_ex_info(request_namespace, version_table)
      end
    end
    local new_config
    E.LOG.debug(TAG, "init_check_remote_res_update  ----called")
    request_cc_config(request_namespace, function(succ, ...)
      E.LOG.debug(TAG, "lightboat request_cc_config, ret:" .. tostring(succ) .. ", cost:" .. tostring(E.system_clock() - check_before_time))
      if succ then
        new_config = (...)
        update_data_with_config(new_config, remote_check_cb, true)
      end
    end)
    update_data_with_config(ECC.get_config(namespace), function()
      if new_config then
        E.LOG.debug(TAG, "has new config, refresh config >>>>>")
        update_data_with_config(new_config, nil, true)
      end
    end)
    ECC.subscribe(namespace, update_data_with_config)
  end
  
  check_webview_cache(function()
    local need_save = false
    for code, temp_table in pairs(webview_url_to_file_path_cache) do
      local path_table = temp_table.paths or {}
      local real_path = get_latest_version_path(path_table)
      E.LOG.debug(TAG, "code is " .. tostring(code))
      E.LOG.debug(TAG, path_table)
      E.LOG.debug(TAG, "， real_path = " .. tostring(real_path))
      local activeStatus = temp_table.activeStatus
      local res_valid = true
      if temp_table.expireOn then
        local file_expired_time = tonumber(temp_table.expireOn) / 1000
        if file_expired_time > 0 and file_expired_time < E.time() then
          res_valid = false
        end
      end
      if activeStatus and 1 == tonumber(activeStatus) and res_valid and real_path then
        set_local_path_to_url_code(code, real_path)
        stat(stat_action, code, true, {webview_url_path_table_cache = webview_url_path_table_cache})
      else
        remove_local_path_with_url_code(code)
        stat(stat_action, code, false, {webview_url_path_table_cache = webview_url_path_table_cache})
      end
      local new_path_table = {}
      for version, temp_path in pairs(path_table) do
        if not res_valid or temp_path ~= real_path then
          if not HRU.is_file_exists(temp_path) then
            E.LOG.debug(TAG, "temp_path is not exist, maybe v1, now try append base path")
            local temp_path_v2 = E.File.get_ext_file_dir() .. "/" .. temp_path
            if HRU.is_file_exists(temp_path_v2) then
              temp_path = temp_path_v2
              E.LOG.debug(TAG, "temp_path_v2 is " .. tostring(temp_path_v2))
            else
              E.LOG.debug(TAG, "temp_path_v2 is not exist, temp_path_v2 is " .. tostring(temp_path_v2))
            end
          end
          local inner_path = find_parent_folder(temp_path)
          E.LOG.debug(TAG, "， delete local file, inner_path = " .. tostring(inner_path))
          E.File.remove_fullpath(inner_path)
          need_save = true
        else
          new_path_table[version] = real_path
        end
      end
      temp_table.paths = new_path_table
    end
    if need_save then
      E.LOG.debug(TAG, "，has delete local file, so need save cache to file again")
      save_webview_cache_config_to_disk()
    end
    check_remote_res_update()
    M.has_inited = true
    ET.publish(ET.lightboat.INITED)
    cb(true)
  end)
end

local function suit_query_to_local_path_with_url(code, url, local_path)
  if not url or not local_path then
    return local_path
  end
  if nil == code then
    code = E.Utils.url_clipping(url)
  end
  local code_index = string.find(url, code, 1, true)
  local full_path = local_path
  if code_index then
    local last_url = string.sub(url, code_index + string.len(code))
    if last_url then
      E.LOG.debug(TAG, "last_url = " .. last_url)
      full_path = local_path .. last_url
    end
  end
  return full_path
end

function M.get_url_from_cache(url)
  if _ejoysdk.os() == "windows" and not is_support_win() then
    return url
  end
  E.LOG.debug(TAG, "-----get_local_path_with_url----")
  local code = E.Utils.url_clipping(url)
  E.LOG.debug(TAG, webview_url_path_table_cache)
  if code then
    local path = webview_url_path_table_cache[code]
    E.LOG.debug(TAG, " get_local_path_with_url, path = " .. tostring(path))
    local action = "webview_open_path_url"
    if path then
      E.LOG.debug(TAG, ",  path = " .. path)
      if not HRU.is_file_exists(path) then
        E.LOG.debug(TAG, "path: " .. tostring(path) .. " not exist, try a new path: ")
        path = E.File.get_ext_file_dir() .. "/" .. path
        E.LOG.debug(TAG, path)
      end
      if HRU.is_file_exists(path) then
        if not E.Utils.start_with(path, "file://") then
          path = "file://" .. path
        end
        path = suit_query_to_local_path_with_url(code, url, path)
        E.LOG.debug(TAG, ", local path = " .. path)
        stat(action, code, true, {webview_url_path_table_cache = webview_url_path_table_cache})
        return path
      end
    else
      stat(action, code, false, {webview_url_path_table_cache = webview_url_path_table_cache})
    end
  end
  return url
end

function M.get_url_infos_from_cache(url, _namespace)
  local prefer_namespace = _namespace or ECC.NAMESPACE.MARKET_H5_RESOURCE
  local r_url = M.get_url_from_cache(url)
  E.LOG.debug(TAG, "url is " .. tostring(url) .. ", r_url is " .. tostring(r_url))
  local use_remote_res = false
  local code = E.Utils.url_clipping(url)
  local config = ECC.get_config(prefer_namespace) or {}
  local util = require("ejoysdk_lua.ejoysdk_utils")
  if config.config then
    local code_max_version_config = {}
    for _, res_config in pairs(config.config) do
      if type(res_config) == "table" and util.tablelength(res_config) > 0 and res_config.ext and res_config.ext._qz_urls then
        for _, config_url in ipairs(res_config.ext._qz_urls) do
          local config_url_code = E.Utils.url_clipping(config_url)
          if config_url_code == code and VER_CHECK.compare_versions(res_config.version, code_max_version_config.version) > 0 then
            code_max_version_config = res_config
          end
        end
      end
    end
    if code_max_version_config then
      code_max_version_config.ext = code_max_version_config.ext or {}
      local activeStatus = code_max_version_config.ext._qz_activeStatus
      local res_valid = true
      if code_max_version_config.ext._qz_expireOn and tonumber(code_max_version_config.ext._qz_expireOn) then
        local file_expired_time = tonumber(code_max_version_config.ext._qz_expireOn) / 1000
        if file_expired_time > 0 and file_expired_time < E.time() then
          res_valid = false
        end
      end
      if not ((not code_max_version_config.ext._qz_restrict or code_max_version_config.ext._qz_restrict ~= true) and activeStatus) or 1 ~= tonumber(activeStatus) or not res_valid then
        E.LOG.debug(TAG, "use_remote_res = true")
        use_remote_res = true
      end
    end
  end
  return {url = r_url, use_remote_res = use_remote_res}
end

M.test_update_data_with_config = update_data_with_config
M.test_suit_query_to_local_path_with_url = suit_query_to_local_path_with_url
M.test_update_resource_with_config = update_resource_with_config
M.test_check_config_to_update_resource = check_config_to_update_resource
M.test_ecc_config_data_cache = ecc_config_data_cache

function M.test_get_ecc_config_data_cache()
  return ecc_config_data_cache
end

return M
