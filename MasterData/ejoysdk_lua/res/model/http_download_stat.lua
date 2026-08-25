local STAT = require("ejoysdk_lua.ejoysdk_stat")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local TAG = "http_download_stat"
local M = {}
M.INNER_LOG_LEVEL = UTILS.INNER_LOG_LEVEL
local DOWNLOAD_ACTION = "ejoy_http_download"
local log_level = UTILS.INNER_LOG_LEVEL.DEBUG
local keystore_cache = {}
local duration_cache = {}

local function duration_cache_key(model_name, size)
  return tostring(model_name) .. tostring(size)
end

local function get_duration_cache_keystore(key)
  local keystore = keystore_cache[key]
  if not keystore then
    keystore = E.LazyKeyStore:New(key, false, true, false)
    keystore_cache[key] = keystore
  end
  return keystore
end

local function keystore_save_last_percent_duration(model_name, size, percent, duration)
  local key = duration_cache_key(model_name, size)
  local keystore = get_duration_cache_keystore(key)
  local cache_data = {
    p = percent,
    d = duration,
    t = os.time()
  }
  duration_cache[key] = cache_data
  keystore:set(cache_data)
end

local function get_last_duration_percent(model_name, size, percent)
  local key = duration_cache_key(model_name, size)
  local cache_data = duration_cache[key]
  if not cache_data then
    local keystore = get_duration_cache_keystore(key)
    cache_data = keystore:get()
  end
  if not cache_data then
    return 0
  end
  if percent < cache_data.p then
    return 0, cache_data.p
  end
  return cache_data.d, cache_data.p, cache_data.t
end

local function keystore_delete_last_percent_duration(model_name, size)
  local key = duration_cache_key(model_name, size)
  duration_cache[key] = nil
  local keystore = get_duration_cache_keystore(key)
  keystore:delete()
end

function M.keystore_delete_last_percent_duration(model_name, size)
  keystore_delete_last_percent_duration(model_name, size)
end

function M.stat_download_state(download_state_obj, _retry_times, limit_speed)
  if not download_state_obj then
    return
  end
  if download_state_obj.state == "downloading" then
    return
  end
  local params = {
    url = download_state_obj.url,
    state = download_state_obj.state,
    tag = download_state_obj.tag,
    code = download_state_obj.err_code,
    msg = download_state_obj.err_msg,
    size = download_state_obj.size,
    downloading_size = download_state_obj.recv_bytes or 0,
    duration = download_state_obj.duration,
    progress = download_state_obj.percent,
    retry_times = _retry_times,
    speed = download_state_obj.speed
  }
  STAT.stat_action(DOWNLOAD_ACTION, "download_state_changed", limit_speed, params)
end

function M.stat_multi_download_state(download_state_obj, model_name, ext)
  if not download_state_obj then
    return
  end
  local _ext = ext or {}
  local _present_progress_info = _ext._present_progress_info or {}
  local duration
  local last_duration, last_percent, last_time_sec = get_last_duration_percent(model_name, _present_progress_info.total_size, _present_progress_info.progress)
  if last_percent and last_percent > _present_progress_info.progress then
    return
  end
  if _present_progress_info.duration then
    duration = math.ceil(_present_progress_info.duration)
  elseif last_duration <= 0 then
    if download_state_obj.state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE then
      _ejoysdk.log("stat_multi_download_state not has last duration and now is complete, just return")
      return
    else
      duration = _present_progress_info.speed > 0 and math.floor(_present_progress_info.downloading_size / 1024 / _present_progress_info.speed) or 0
      _ejoysdk.log("stat_multi_download_state not has last duration:" .. tostring(duration) .. ", speed:" .. tostring(_present_progress_info.speed) .. ", downloading_size:" .. tostring(_present_progress_info.downloading_size))
    end
  elseif last_percent == _present_progress_info.progress then
    _ejoysdk.log("stat_multi_download_state last percent equals, just use last duration:" .. tostring(last_duration))
    duration = last_duration
  else
    local diff_percent = _present_progress_info.progress - last_percent
    local diff_size = diff_percent / 100.0 * _present_progress_info.total_size
    local diff_sec = _present_progress_info.speed > 0 and math.floor(diff_size / 1024 / _present_progress_info.speed) or 0
    local diff_sec_lua = os.time() - last_time_sec
    local diff_sec_real = diff_percent > 5 and diff_sec or math.min(diff_sec, diff_sec_lua)
    duration = last_duration + diff_sec_real
    _ejoysdk.log("stat_multi_download_state diff_sec:" .. tostring(diff_sec_real) .. ", diff_size:" .. tostring(diff_size) .. ", speed:" .. tostring(_present_progress_info.speed) .. ", diff_percent:" .. tostring(diff_percent) .. ", last_p:" .. tostring(last_percent) .. ", cur p:" .. tostring(_present_progress_info.progress) .. ", diff_sec_cal:" .. tostring(diff_sec) .. ", diff_sec_lua:" .. tostring(diff_sec_lua))
  end
  if download_state_obj.state == RTM.PUBLIC_DOWNLOAD_STATE.COMPLETE or download_state_obj.state == RTM.PUBLIC_DOWNLOAD_STATE.IDLE then
    keystore_delete_last_percent_duration(model_name, _present_progress_info.total_size)
  else
    keystore_save_last_percent_duration(model_name, _present_progress_info.total_size, _present_progress_info.progress, duration)
  end
  local params = {
    state = download_state_obj.state,
    tag = download_state_obj.tag,
    code = download_state_obj.err_code,
    msg = download_state_obj.err_msg,
    url = download_state_obj.err_url,
    size = _present_progress_info.total_size,
    downloading_size = _present_progress_info.downloading_size,
    duration = duration,
    progress = _present_progress_info.progress,
    speed = _present_progress_info.speed,
    total_count = _present_progress_info.total_count,
    finish_count = _present_progress_info.finish_count,
    model_name = model_name
  }
  E.LOG.debug(TAG, "stat_multi_download_state state:" .. tostring(params.state) .. ", size:" .. tostring(params.size) .. ", downloading_size:" .. tostring(params.downloading_size) .. ", progress:" .. tostring(params.progress) .. ", total_count:" .. tostring(params.total_count) .. ", finish_count:" .. tostring(params.finish_count) .. ", speed:" .. tostring(params.speed) .. ", duration:" .. tostring(duration) .. ", state_duration:" .. tostring(download_state_obj.duration))
  local utils = require("ejoysdk_lua.ejoysdk_utils")
  params = utils.merge_table(params, _ext)
  params._present_progress_info = nil
  params[STAT.STAT_KEY.IS_PRIORITY_HIGH] = true
  STAT.stat_action(DOWNLOAD_ACTION, "multi_download_state_changed", model_name, params)
end

function M.stat_action(action, action_type, result, params)
  local stat_params = params or {}
  STAT.stat_action(action, action_type, result, stat_params)
end

function M.stat_action_fail(action, action_type, ...)
  local params = {}
  local args = (...)
  local args_type = type(args)
  if "table" == args_type then
    params = args
  else
    local code, msg = ...
    params.code = code
    params.msg = msg
  end
  STAT.stat_action_fail(action, action_type, params)
end

function M.set_log_level(_log_level)
  log_level = _log_level
  if _log_level >= UTILS.INNER_LOG_LEVEL.WARN then
    UTILS.set_global_log_enable(false)
  else
    UTILS.set_global_log_enable(true)
  end
end

function M.is_log_allow_with_level(_log_level)
  return _log_level >= log_level
end

function M.log_debug(tag, msg)
  if log_level > UTILS.INNER_LOG_LEVEL.DEBUG then
    return
  end
  E.LOG.debug(tag, msg)
end

function M.log_warn(tag, msg)
  if log_level > UTILS.INNER_LOG_LEVEL.WARN then
    return
  end
  E.LOG.warn(tag, msg)
end

function M.stat_action_unimportant(action, action_type, result, params)
  STAT.stat_action(action, action_type, result, params)
end

return M
