local E = require("ejoysdk_lua.ejoysdk")
local cache = E.SPKeyStore:New("ejoy_chat_stat_cache", "chat_stat")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local M = {}
local TAG = "chat_stat"
local DEFAULT_STAT_INFO = {
  start_count = 0,
  success_count = 0,
  succ_avg_duration = 0,
  failed_count = 0,
  last_err_code = 0,
  last_err_msg = nil,
  disconnect_count = 0,
  last_discconnect_code = 0,
  last_disconnect_msg = nil
}
local DEFAULT_STAT_CACHE = {
  connection = DEFAULT_STAT_INFO,
  rpc = {}
}
local FLUSH_CACHE_DELAY_SEC = 120
local static_duration_cache = {}
local static_stat_cache
local static_last_send_time_sec = 0
local static_last_flush_time_sec = 0
local static_flush_timer_task

local function get_stat_cache()
  if not static_stat_cache then
    local stat_cache_str = cache:get()
    if stat_cache_str then
      local disk_cache_data = CJSON.decode(stat_cache_str)
      if disk_cache_data then
        static_stat_cache = disk_cache_data
      end
    end
  end
  if not static_stat_cache then
    static_stat_cache = UTILS.deepcopy(DEFAULT_STAT_CACHE)
  end
  return static_stat_cache
end

local function get_stat_rpc_cache(cmd)
  local stat_cache = get_stat_cache()
  if not stat_cache.rpc[cmd] then
    stat_cache.rpc[cmd] = UTILS.deepcopy(DEFAULT_STAT_INFO)
  end
  return stat_cache.rpc[cmd]
end

local function reset_connect_stat_cache()
  local stat_cache = get_stat_cache()
  stat_cache.connection = UTILS.deepcopy(DEFAULT_STAT_CACHE.connection)
end

local function reset_rpc_stat_cache()
  local stat_cache = get_stat_cache()
  stat_cache.rpc = {}
end

local function schedule_flush_cache()
  if not static_flush_timer_task then
    function static_flush_timer_task()
      static_last_flush_time_sec = 0 == static_last_flush_time_sec and os.time() or static_last_flush_time_sec
      
      local last_flush_time_diff = os.time() - static_last_flush_time_sec
      if last_flush_time_diff >= FLUSH_CACHE_DELAY_SEC then
        E.LOG.debug(TAG, "last_flush_time_diff bigger than 120, than flush immediately")
        M.flush_cache_event()
      else
        local next_interval = FLUSH_CACHE_DELAY_SEC - last_flush_time_diff
        E.Timer.once(next_interval, static_flush_timer_task)
      end
    end
    
    E.Timer.once(FLUSH_CACHE_DELAY_SEC, static_flush_timer_task)
  end
end

local function trigger_persist_cache()
  local cache_str = CJSON.encode(static_stat_cache)
  cache:set(cache_str, true)
end

local function on_chat_stat_result(trigger_upload)
  local curr_time_sec = os.time()
  if not trigger_upload and curr_time_sec - static_last_send_time_sec < FLUSH_CACHE_DELAY_SEC then
    schedule_flush_cache()
    trigger_persist_cache()
    return
  end
  static_last_send_time_sec = curr_time_sec
  M.flush_cache_event()
end

local function on_duration_cache_begin(duration_key)
  static_duration_cache[duration_key] = static_duration_cache[duration_key] or {}
  static_duration_cache[duration_key].start_time_ms = E.system_clock()
end

local function on_duration_cache_end(duration_key)
  local begin_time = static_duration_cache[duration_key] and static_duration_cache[duration_key].start_time_ms or 0
  static_duration_cache[duration_key] = nil
  local duration = 0
  if begin_time > 0 then
    duration = E.system_clock() - begin_time
  end
  return duration
end

local function get_connect_duration_key(socket_id)
  return "connect_" .. tostring(socket_id)
end

local function get_rpc_duration_key(cmd, session)
  return nil == session and tostring(cmd) or tostring(cmd) .. "-" .. tostring(session)
end

local function on_connect_check_duration_begin(socket_id)
  local duration_key = get_connect_duration_key(socket_id)
  on_duration_cache_begin(duration_key)
end

local function on_connect_check_duration_end(socket_id)
  local duration_key = get_connect_duration_key(socket_id)
  do return on_duration_cache_end end
  return on_duration_cache_end, duration_key
end

local function on_rpc_check_duration_begin(cmd, session)
  local duration_key = get_rpc_duration_key(cmd, session)
  on_duration_cache_begin(duration_key)
end

local function on_rpc_check_duration_end(cmd, session)
  local duration_key = get_rpc_duration_key(cmd, session)
  do return on_duration_cache_end end
  return on_duration_cache_end, duration_key
end

function M.stat_connect_start(socket_id)
  on_connect_check_duration_begin(socket_id)
  E.LOG.debug(TAG, "stat_connect_start socket_id:" .. tostring(socket_id))
  local stat_cache = get_stat_cache()
  stat_cache.connection.start_count = stat_cache.connection.start_count + 1
  trigger_persist_cache()
end

function M.stat_connect_result(socket_id, succ, code, msg)
  local duration = on_connect_check_duration_end(socket_id)
  E.LOG.debug(TAG, "stat_connect_result socket_id:" .. tostring(socket_id) .. ", succ:" .. tostring(succ) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", duration:" .. tostring(duration))
  local stat_cache = get_stat_cache()
  if succ then
    stat_cache.connection.success_count = stat_cache.connection.success_count + 1
    if 0 == stat_cache.connection.succ_avg_duration then
      stat_cache.connection.succ_avg_duration = duration
    else
      stat_cache.connection.succ_avg_duration = math.floor(stat_cache.connection.succ_avg_duration + (duration - stat_cache.connection.succ_avg_duration) / stat_cache.connection.success_count)
    end
  else
    stat_cache.connection.failed_count = stat_cache.connection.failed_count + 1
    stat_cache.connection.last_err_code = code
    stat_cache.connection.last_err_msg = msg
  end
  on_chat_stat_result()
end

function M.stat_rpc_start(cmd, header)
  if not cmd then
    E.LOG.error(TAG, "stat_rpc_start cmd is nil")
    return
  end
  local rpc_trace_id = header and header.session
  E.LOG.debug(TAG, "stat_rpc_start cmd:" .. tostring(cmd) .. ", rpc_trace_id:" .. tostring(rpc_trace_id))
  on_rpc_check_duration_begin(cmd, rpc_trace_id)
  local stat_rpc_cache = get_stat_rpc_cache(cmd)
  stat_rpc_cache.start_count = stat_rpc_cache.start_count + 1
  trigger_persist_cache()
end

function M.stat_rpc_result(cmd, header, succ, code, msg)
  local rpc_trace_id = header and header.session
  local duration = on_rpc_check_duration_end(cmd, rpc_trace_id)
  E.LOG.debug(TAG, "stat_rpc_result cmd:" .. tostring(cmd) .. " succ:" .. tostring(succ) .. " code:" .. tostring(code) .. " msg:" .. tostring(msg) .. ", rpc_trace_id:" .. tostring(rpc_trace_id) .. ", duration:" .. tostring(duration))
  local rpc_stat_cache = get_stat_rpc_cache(cmd)
  if succ then
    rpc_stat_cache.success_count = rpc_stat_cache.success_count + 1
    if 0 == rpc_stat_cache.succ_avg_duration then
      rpc_stat_cache.succ_avg_duration = duration
    else
      rpc_stat_cache.succ_avg_duration = math.floor(rpc_stat_cache.succ_avg_duration + (duration - rpc_stat_cache.succ_avg_duration) / rpc_stat_cache.success_count)
    end
  else
    rpc_stat_cache.failed_count = rpc_stat_cache.failed_count + 1
    rpc_stat_cache.last_err_code = code
    rpc_stat_cache.last_err_msg = msg
  end
  local trigger_upload = "login" == cmd or "get_session_msg" == cmd
  on_chat_stat_result(trigger_upload)
end

function M.stat_socket_disconnect(code, msg)
  E.LOG.warn(TAG, "stat_socket_disconnect code:" .. tostring(code))
  local stat_cache = get_stat_cache()
  stat_cache.connection.disconnect_count = stat_cache.connection.disconnect_count + 1
  stat_cache.connection.last_discconnect_code = code
  stat_cache.connection.last_disconnect_msg = msg
  on_chat_stat_result()
end

function M.stat_stop_conn_begin()
  local cmd = "stop_conn"
  local duration_key = get_rpc_duration_key(cmd)
  on_duration_cache_begin(duration_key)
  local stat_rpc_cache = get_stat_rpc_cache(cmd)
  stat_rpc_cache.start_count = stat_rpc_cache.start_count + 1
  trigger_persist_cache()
end

function M.stat_stop_conn_result(succ, code, msg)
  local cmd = "stop_conn"
  local duration_key = get_rpc_duration_key(cmd)
  local duration = on_duration_cache_end(duration_key)
  local rpc_stat_cache = get_stat_rpc_cache(cmd)
  if succ then
    rpc_stat_cache.success_count = rpc_stat_cache.success_count + 1
    if 0 == rpc_stat_cache.succ_avg_duration then
      rpc_stat_cache.succ_avg_duration = duration
    else
      rpc_stat_cache.succ_avg_duration = math.floor(rpc_stat_cache.succ_avg_duration + (duration - rpc_stat_cache.succ_avg_duration) / rpc_stat_cache.success_count)
    end
  else
    rpc_stat_cache.failed_count = rpc_stat_cache.failed_count + 1
    rpc_stat_cache.last_err_code = code
    rpc_stat_cache.last_err_msg = msg
  end
  on_chat_stat_result()
end

function M.flush_cache_event()
  local stat_cache = get_stat_cache()
  E.LOG.debug(TAG, "flush_cache_event begin>>")
  E.log(stat_cache)
  if stat_cache.connection.start_count > 0 then
    STAT.stat_action("chat_connection_start", stat_cache.connection.start_count, true, {
      [STAT.STAT_KEY.IS_PRIORITY_HIGH] = true
    })
  end
  if stat_cache.connection.success_count > 0 or stat_cache.connection.failed_count > 0 then
    local connect_result_params = {
      [STAT.STAT_KEY.IS_PRIORITY_HIGH] = true,
      code = stat_cache.connection.last_err_code,
      msg = stat_cache.connection.last_err_msg,
      duration = stat_cache.connection.succ_avg_duration,
      p1 = stat_cache.connection.disconnect_count,
      p2 = stat_cache.connection.last_discconnect_code,
      p3 = stat_cache.connection.last_disconnect_msg
    }
    STAT.stat_action("chat_connection_result", stat_cache.connection.success_count, stat_cache.connection.failed_count, connect_result_params)
  end
  reset_connect_stat_cache()
  for cmd, stat_info in pairs(stat_cache.rpc) do
    STAT.stat_action("chat_rpc_start_" .. tostring(cmd), stat_info.start_count, true, {
      [STAT.STAT_KEY.IS_PRIORITY_HIGH] = true
    })
    local rpc_result_params = {
      [STAT.STAT_KEY.IS_PRIORITY_HIGH] = true,
      code = stat_info.last_err_code,
      msg = stat_info.last_err_msg,
      duration = stat_info.succ_avg_duration
    }
    STAT.stat_action("chat_rpc_result_" .. tostring(cmd), stat_info.success_count, stat_info.failed_count, rpc_result_params)
  end
  reset_rpc_stat_cache()
  trigger_persist_cache()
  static_last_flush_time_sec = os.time()
end

function M.stat_action_succ(action, type, params)
  params = params or {}
  params[STAT.STAT_KEY.IS_PRIORITY_HIGH] = true
  STAT.stat_action(action, type, true, params)
end

function M.stat_action_failed(action, type, code, msg, params)
  params = params or {}
  params.code = code
  params.msg = msg
  params[STAT.STAT_KEY.IS_PRIORITY_HIGH] = true
  STAT.stat_action(action, type, true, params)
end

return M
