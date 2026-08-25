local E = require("ejoysdk_lua.ejoysdk")
local JF_LUA_CONFIG = require("ejoysdk_lua.jf.jf_lua_config")
local PARAMS_MANAGER = require("ejoysdk_lua.jf.jf_lua_params_manager")
local UPLOAD_UTILS = require("ejoysdk_lua.jf.base_jf_lua_api")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local JF_FILE_CACHE = require("ejoysdk_lua.jf.jf_file_cache")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local TAG = EM.MODULE.JF .. "JF_LUA"
local WINDOWS_EXE_UPDATE_TIME = E.LazyKeyStore:New("WINDOWS_EXE_UPDATE_TIME", false, false, false)
local cache_event = {}
local cache_event_priority_high = {}
local DEFAULT_CACHE_COUNT = 20
local cache_upload_fail_event = {}
local MAX_UPLOAD_FAIL_LOG_COUNT = 200
local can_jf_file_cache = true
local use_jf_file_cache = false
local has_init_jf_file_cache = false
local MAX_JF_FILE_CACHE_SIZE = 2097152
local JF_CACHE_TYPE_ENUM = {
  high_priority_event = "high_priority_event",
  low_priority_event = "low_priority_event",
  fail_event = "fail_event"
}
local jf_file_cache_high_instance = JF_FILE_CACHE.new("high_priority")
local jf_file_cache_low_instance = JF_FILE_CACHE.new("low_priority")
local jf_file_cache_instance_map = {
  [JF_CACHE_TYPE_ENUM.high_priority_event] = jf_file_cache_high_instance,
  [JF_CACHE_TYPE_ENUM.low_priority_event] = jf_file_cache_low_instance,
  [JF_CACHE_TYPE_ENUM.fail_event] = jf_file_cache_high_instance
}
local is_start_upload_cache_action = false
local disable_media_event = false
local M = {}

local function support_jf()
  if E.Sysinfo.os() == "windows" then
    local version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
    local version_check = require("ejoysdk_lua.ejoysdk_version_check")
    local result = version_check.compare_versions(version, "2.2.1")
    if tonumber(result) >= 0 then
      return true
    end
    return false
  end
  return true
end

local function set_player_info_handler(_player_info)
end

local function init_jf_file_cache()
  E.LOG.debug(TAG, "init_jf_file_cache init start, can_jf_file_cache: " .. tostring(can_jf_file_cache))
  if not can_jf_file_cache then
    return
  end
  if has_init_jf_file_cache then
    return
  end
  UPLOAD_UTILS.check_support_file_upload(function(is_server_support)
    local is_support_jf_file_cache = JF_FILE_CACHE.is_support_jf_file_cache()
    use_jf_file_cache = can_jf_file_cache and is_support_jf_file_cache and is_server_support
    E.LOG.debug(TAG, "check_support_file_upload resp, can_jf_file_cache: " .. tostring(can_jf_file_cache) .. " ,is_support_jf_file_cache: " .. tostring(is_support_jf_file_cache) .. " ,is_server_support: " .. tostring(is_server_support) .. ", use_jf_file_cache: " .. tostring(use_jf_file_cache))
    if use_jf_file_cache then
      JF_FILE_CACHE.init_jf_file_cache()
    end
    has_init_jf_file_cache = true
  end)
end

function M.init(params)
  E.LOG.debug(TAG, "jf_lua init")
  E.LOG.debug(TAG, params)
  JF_LUA_CONFIG.init(params)
  init_jf_file_cache()
  if false == disable_media_event then
    M.heartbeat()
  end
  if not is_start_upload_cache_action then
    E.LOG.debug(TAG, "start upload cache log")
    is_start_upload_cache_action = true
    M.check_upload_cache_log()
    M.check_upload_cache_log_priority_high()
  end
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, set_player_info_handler)
end

function M.heartbeat()
  local event_log = {
    event_name = JF_LUA_CONFIG.EVENT_NAMES.SDK_HEARTBEAT
  }
  PARAMS_MANAGER.fill_role_info_params(event_log)
  M.commit_event(event_log)
  E.Timer.once(120, function()
    M.heartbeat()
  end)
end

local function check_install_event(event_params)
  local event_name = event_params.event_name
  if event_name == JF_LUA_CONFIG.EVENT_NAMES.SDK_START_UP_SUCCESS then
    local cache_update_time = tostring(WINDOWS_EXE_UPDATE_TIME:get())
    local update_time = tostring(E.Sysinfo.update_time())
    if update_time ~= cache_update_time then
      local install_time = tostring(E.Sysinfo.install_time())
      WINDOWS_EXE_UPDATE_TIME:set(update_time)
      local install_event = {}
      install_event.params = {}
      install_event.params.installTime = install_time
      if E.Sysinfo.os() == "windows" then
        install_event.params.updateTime = tostring(math.floor(E.system_clock()))
      else
        install_event.params.updateTime = update_time
      end
      install_event.event_name = JF_LUA_CONFIG.EVENT_NAMES.SDK_INSTALL
      install_event.opts = event_params.opts
      M.commit_event(install_event)
    end
  end
end

local function insert_cache_event_log(event_log, jf_cache_type)
  E.LOG.debug(TAG, "insert_cache_event_log, jf_cache_type: " .. tostring(jf_cache_type) .. ", event_log" .. tostring(event_log.event))
  E.LOG.debug(TAG, "insert_cache_event_log, use_jf_file_cache: " .. tostring(use_jf_file_cache))
  if use_jf_file_cache then
    E.LOG.debug(TAG, "insert_cache_event_log, high_priority_event" .. tostring(event_log.event))
    local jf_file_cache_instance = jf_file_cache_instance_map[jf_cache_type]
    local event_log_str = JSON.encode(event_log)
    jf_file_cache_instance.insert_file_cache_event(event_log_str)
    return
  end
  if jf_cache_type == JF_CACHE_TYPE_ENUM.high_priority_event then
    table.insert(cache_event_priority_high, event_log)
  elseif jf_cache_type == JF_CACHE_TYPE_ENUM.low_priority_event then
    table.insert(cache_event, event_log)
  elseif jf_cache_type == JF_CACHE_TYPE_ENUM.fail_event then
    table.insert(cache_upload_fail_event, event_log)
  end
end

local function upload_callback(succ, ...)
  if succ then
    E.LOG.debug(TAG, "upload event succ, ")
  else
    local code, msg, fail_arr = ...
    E.LOG.debug(TAG, "upload event fail, code is " .. tostring(code) .. ", msg is " .. tostring(msg))
    if fail_arr and cache_upload_fail_event and #fail_arr > 0 then
      for _, cv in ipairs(fail_arr) do
        if #cache_upload_fail_event >= MAX_UPLOAD_FAIL_LOG_COUNT then
          break
        end
        insert_cache_event_log(cv, JF_CACHE_TYPE_ENUM.fail_event)
      end
    end
  end
end

local function upload_file(jf_cache_type)
  E.LOG.debug(TAG, "upload_file, jf_cache_type: " .. tostring(jf_cache_type))
  local jf_file_cache_instance = jf_file_cache_instance_map[jf_cache_type]
  
  local function handle_upload_file(jf_log_files, current_jf_log)
    table.sort(jf_log_files, function(a, b)
      return tonumber(a.file_name) < tonumber(b.file_name)
    end)
    local first_jf_log = jf_log_files[1]
    local file_name = first_jf_log.file_name
    local file_path = first_jf_log.file_path
    E.LOG.debug(TAG, "upload_file, first_jf_log: ")
    E.log(first_jf_log)
    E.LOG.debug(TAG, "upload_file, current_jf_log: ")
    E.log(current_jf_log)
    jf_file_cache_instance.flush_jf_log()
    if first_jf_log.file_path == current_jf_log.file_path and 0 == first_jf_log.sizes and 0 == current_jf_log.sizes then
      E.LOG.debug(TAG, "upload_file current first_jf_log file sizes is 0, ignore , first_jf_log file_path: " .. tostring(first_jf_log.file_path) .. ", current_jf_log file_path: " .. tostring(current_jf_log.file_path))
      return
    elseif first_jf_log.file_path ~= current_jf_log.file_path and 0 == first_jf_log.sizes then
      local ret, code, msg = E.File.remove_fullpath(file_path)
      E.LOG.error(TAG, "upload cache event, find first_log invalid, remove first_jf_log, file path is " .. tostring(file_path) .. ", ret: " .. tostring(ret) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      return
    end
    local is_current_file_max = (tonumber(current_jf_log.sizes) or 0) > MAX_JF_FILE_CACHE_SIZE
    if is_current_file_max or first_jf_log.file_path == current_jf_log.file_path then
      E.LOG.debug(TAG, "upload_file current file scroll, current file size: " .. tostring(current_jf_log.sizes or 0) .. ", current file path: " .. tostring(current_jf_log.file_path))
      jf_file_cache_instance.scroll_jf_log()
    end
    UPLOAD_UTILS.upload_file(file_name, file_path, function(is_success, error_code)
      if is_success then
        local ret, code, msg = E.File.remove_fullpath(file_path)
        if ret then
          E.LOG.debug(TAG, "upload cache event success, remove file success, file path is " .. tostring(file_path))
        else
          E.LOG.error(TAG, "upload cache event success, remove file fail, file path is " .. tostring(file_path) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
      elseif error_code == EC.JF_FILE_CACHE_ERROR_CODES.NOT_OPEN_V2 then
        E.LOG.warn(TAG, "upload cache event fail, disable jf file cache upload, file path is " .. tostring(file_path))
        use_jf_file_cache = false
      else
        E.LOG.error(TAG, "upload cache event fail, file path is " .. tostring(file_path))
      end
    end)
  end
  
  jf_file_cache_instance.get_jf_file_infos(function(jf_log_files)
    E.LOG.debug(TAG, "upload_file, jf_log_files: ")
    E.log(jf_log_files)
    if jf_log_files and type(jf_log_files) == "table" and #jf_log_files > 0 then
      jf_file_cache_instance.get_current_jf_file_info(function(current_jf_log)
        E.LOG.debug(TAG, "upload_file, current_jf_log: ")
        E.log(current_jf_log)
        handle_upload_file(jf_log_files, current_jf_log)
      end)
    end
  end)
end

local function upload_cache_event()
  if use_jf_file_cache then
    upload_file(JF_CACHE_TYPE_ENUM.low_priority_event)
  end
  if cache_event and next(cache_event) then
    E.LOG.debug(TAG, "jf_lua upload cache event")
    if cache_upload_fail_event and next(cache_upload_fail_event) then
      E.LOG.debug(TAG, "jf_lua upload cache event, found last fail event")
      local cache_event_tmp = {}
      for _, cv in ipairs(cache_event) do
        table.insert(cache_event_tmp, cv)
      end
      for _, cv in ipairs(cache_upload_fail_event) do
        table.insert(cache_event_tmp, cv)
      end
      cache_upload_fail_event = {}
      cache_event = cache_event_tmp
    end
    UPLOAD_UTILS.upload(cache_event, upload_callback)
  elseif cache_upload_fail_event and next(cache_upload_fail_event) then
    cache_event = cache_upload_fail_event
  end
  cache_event = {}
end

local function upload_cache_event_priority_high()
  if use_jf_file_cache then
    upload_file(JF_CACHE_TYPE_ENUM.high_priority_event)
  end
  if cache_event_priority_high and next(cache_event_priority_high) then
    E.LOG.debug(TAG, "jf_lua upload cache event priority high")
    UPLOAD_UTILS.upload(cache_event_priority_high, upload_callback)
  end
  cache_event_priority_high = {}
end

local function check_log_count_upload()
  local log_count = #cache_event
  if log_count >= DEFAULT_CACHE_COUNT then
    upload_cache_event()
  end
end

local function check_log_count_upload_priority_high()
  local log_count = #cache_event_priority_high
  if log_count >= DEFAULT_CACHE_COUNT then
    upload_cache_event_priority_high()
  end
end

function M.check_upload_cache_log_priority_high()
  local check_time = use_jf_file_cache and 30 or 5
  E.Timer.once(check_time, function()
    upload_cache_event_priority_high()
    M.check_upload_cache_log_priority_high()
  end)
end

function M.flush_high_level_logs()
  E.LOG.debug(TAG, "flush_high_level_logs begin, cache cnt:" .. tostring(#cache_event_priority_high))
  upload_cache_event_priority_high()
end

function M.check_upload_cache_log()
  E.Timer.once(120, function()
    upload_cache_event()
    M.check_upload_cache_log()
  end)
end

function M.commit_event(event_params)
  if not support_jf() then
    E.LOG.debug(TAG, "jf_lua not support, need to update native sdk version")
    return
  end
  E.LOG.debug(TAG, "jf_lua commit event " .. tostring(event_params.event_name))
  if not M.can_commit(event_params.event_name) then
    return
  end
  if not event_params.params then
    event_params.params = {}
  end
  if not event_params.opts then
    event_params.opts = {}
  end
  check_install_event(event_params)
  
  local function commit_action(event_log)
    E.LOG.debug(TAG, "jf_lua cache event " .. tostring(event_log.event))
    insert_cache_event_log(event_log, JF_CACHE_TYPE_ENUM.low_priority_event)
    check_log_count_upload()
  end
  
  local function commit_action_priority_high(event_log)
    E.LOG.debug(TAG, "jf_lua cache event priority high " .. tostring(event_log.event))
    insert_cache_event_log(event_log, JF_CACHE_TYPE_ENUM.high_priority_event)
    check_log_count_upload_priority_high()
  end
  
  local function upload_action(event_log)
    E.LOG.debug(TAG, "jf_lua upload event " .. tostring(event_log.event))
    UPLOAD_UTILS.upload({event_log}, upload_callback)
  end
  
  PARAMS_MANAGER.fill_params(event_params, function(event_log)
    local is_upload_now = M.is_upload_now(event_log.event, event_params)
    local is_priority_high = M.is_priority_high(event_params)
    if is_upload_now then
      upload_action(event_log)
    elseif is_priority_high then
      commit_action_priority_high(event_log)
    else
      commit_action(event_log)
    end
  end)
end

function M.update_data(params)
  JF_LUA_CONFIG.update_config(params)
  PARAMS_MANAGER.update_role_info(params)
end

function M.can_commit(event_name)
  local is_black_event = M.is_black_event(event_name)
  if is_black_event then
    E.LOG.debug(TAG, tostring(event_name) .. " is black event, should not commit")
    return false
  end
  local is_white_event = M.is_white_event(event_name)
  if not is_white_event then
    E.LOG.debug(TAG, tostring(event_name) .. " is not white event, should not commit")
    return false
  end
  return true
end

function M.is_black_event(event_name)
  local black_event_config = JF_LUA_CONFIG.get_black_event_config()
  if not black_event_config then
    return false
  end
  local black_event_arr = {}
  if black_event_config.type == "event_arr" then
    black_event_arr = black_event_config.data or {}
  end
  for _, black_event in pairs(black_event_arr) do
    if event_name == black_event then
      return true
    end
  end
  if disable_media_event then
    black_event_arr = JF_LUA_CONFIG.get_media_event_arr()
    for _, black_event in pairs(black_event_arr) do
      if event_name == black_event then
        return true
      end
    end
  end
  return false
end

function M.disable_media_event()
  disable_media_event = true
end

function M.is_white_event(event_name)
  local default_white_event_prefix_arr = JF_LUA_CONFIG.get_default_white_event_prefix_arr()
  local ext_white_event_prefix_arr = JF_LUA_CONFIG.get_ext_white_event_prefix_arr()
  for _, event_prefix in pairs(default_white_event_prefix_arr) do
    if E.Utils.start_with(event_name, event_prefix) then
      return true
    end
  end
  for _, event_prefix in pairs(ext_white_event_prefix_arr) do
    if E.Utils.start_with(event_name, event_prefix) then
      return true
    end
  end
  return false
end

function M.is_upload_now(event_name, event_params)
  local jf_event_names = JF_LUA_CONFIG.EVENT_NAMES
  for _, media_event_name in pairs(jf_event_names) do
    if event_name == media_event_name then
      E.LOG.debug(TAG, tostring(event_name) .. " is media event, upload now")
      return true
    end
  end
  if event_params and event_params.opts and event_params.opts.is_upload_now then
    return true
  end
  return false
end

function M.is_priority_high(event_params)
  if event_params and event_params.opts and event_params.opts.is_priority_high then
    return true
  end
  return false
end

return M
