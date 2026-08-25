local E = require("ejoysdk_lua.ejoysdk")
local SS = require("ejoysdk_lua.chat.ejoysdk_chat_session")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ECSH = require("ejoysdk_lua.chat.ejoysdk_chat_socket_heartbeat")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local CHAT_STAT = require("ejoysdk_lua.chat.chat_stat")
local M = {}
local TAG = "chat_session_mgr"
local RPC_HEADER_KEY_SOCKET_ID = "X-Ejoy-ChatSocketId"
local CHAT_SOCKET_HEARTBEAT
local SOCKET_SESSION_LISTENERS = {}
local static_running_socket_session, static_switching_socket_session
local static_terminated_socket_session_list = {}
local _heartbeat_options
local static_last_login_session_info_cache = {}
local static_outside_listeners
local static_rpc_call_pending_cache = {}

function M.set_listeners(listeners)
  static_outside_listeners = listeners
end

local function remove_array_item(arr, target)
  local find_idx = -1
  for idx, item in ipairs(arr) do
    if item == target then
      find_idx = idx
      break
    end
  end
  if find_idx > 0 then
    return table.remove(arr, find_idx) ~= nil
  else
    return false
  end
end

local function on_handle_chat_server_msg(header, msg)
  local method = header.method
  if not method then
    return
  end
  if M.CHAT_SERVER_MSG_HANDLERS[method] then
    M.CHAT_SERVER_MSG_HANDLERS[method](header, msg)
  end
end

local function on_login_offline()
  E.LOG.debug(TAG, "on_login_offline received")
end

function SOCKET_SESSION_LISTENERS.on_connect_start(socket_session, ...)
  E.LOG.debug(TAG, "on_connect_start, socket_id:" .. tostring(socket_session:get_socket_id()))
  if socket_session:is_terminating() then
    return
  end
  if M.is_current_session_switching() then
    E.LOG.debug(TAG, "on_connect_start switching socket not notify outside:" .. tostring(socket_session:get_socket_id()))
    return
  end
  if static_outside_listeners then
    static_outside_listeners.on_connect_start(...)
  end
end

function SOCKET_SESSION_LISTENERS.on_connect_error(socket_session, ...)
  E.LOG.debug(TAG, "on_connect_error")
  if socket_session:is_terminating() then
    return
  end
  if static_outside_listeners then
    E.LOG.debug(TAG, "on_connect_error running socket on_connect_error, socket_id:" .. tostring(socket_session:get_socket_id()))
    static_outside_listeners.on_connect_error(...)
  end
end

function SOCKET_SESSION_LISTENERS.on_connected(socket_session)
  local socket_id = socket_session:get_socket_id()
  if socket_session:is_terminating() then
    E.LOG.debug(TAG, "on_connected terminating socket connected, skip callback, socket_id:" .. tostring(socket_id))
    return
  end
  if M.is_current_session_switching() then
    E.LOG.debug(TAG, "on_connected switching socket on_connected, switching socket not notify outside:" .. tostring(socket_session:get_socket_id()))
    return
  end
  DISPATCHER.register_chat_handlers(DISPATCHER.DESTINATION.CLIENT_CHAT_SERVER, on_handle_chat_server_msg)
  if static_outside_listeners then
    E.LOG.debug(TAG, "on_connected running socket connected, socket_id:" .. tostring(socket_id))
    static_outside_listeners.on_connected()
  else
    E.LOG.warn(TAG, "on_connected running socket connected, socket_id:" .. tostring(socket_id) .. ", but no listener callback")
  end
end

local function flush_cache_rpc_calls(destination)
  E.LOG.debug(TAG, "flush_cache_rpc_calls received, size:" .. tostring(#static_rpc_call_pending_cache))
  local remain_cache_rpc_calls = {}
  for _, rpc_cache in ipairs(static_rpc_call_pending_cache) do
    if rpc_cache.destination == destination then
      M.rpc_call(rpc_cache.destination, rpc_cache.params, rpc_cache.cb)
    else
      table.insert(remain_cache_rpc_calls, rpc_cache)
    end
  end
  static_rpc_call_pending_cache = remain_cache_rpc_calls
end

function SOCKET_SESSION_LISTENERS.on_disconnect(socket_session, code)
  if socket_session:is_terminating() then
    E.LOG.debug(TAG, "on_disconnect for terminating session, socket_id:" .. tostring(socket_session:get_socket_id()) .. ", remove it from terminating session list cache")
    remove_array_item(static_terminated_socket_session_list, socket_session)
    return
  end
  if static_running_socket_session == socket_session then
    E.LOG.debug(TAG, "on_disconnect running socket disconnect, socket_id:" .. tostring(socket_session:get_socket_id()))
    static_running_socket_session = nil
  end
  if static_switching_socket_session == socket_session then
    E.LOG.debug(TAG, "on_disconnect switching socket disconnect, socket_id:" .. tostring(socket_session:get_socket_id()))
    static_switching_socket_session = nil
  end
  for _, rpc_cache in ipairs(static_rpc_call_pending_cache) do
    if rpc_cache.cb then
      rpc_cache.cb({
        code = code,
        message = "socket not connected"
      })
    end
  end
  static_rpc_call_pending_cache = {}
  DISPATCHER.unregister_chat_handlers(DISPATCHER.DESTINATION.CLIENT_CHAT_SERVER)
  if static_outside_listeners then
    static_outside_listeners.on_disconnect(code)
  end
end

function SOCKET_SESSION_LISTENERS.on_error(socket_session, ...)
  if socket_session:is_terminating() then
    E.LOG.debug(TAG, "on_error received for terminating session, skip notify outside:" .. tostring(socket_session:get_socket_id()))
    return
  end
  if static_outside_listeners then
    E.LOG.debug(TAG, "on_error socket on_error:" .. tostring(socket_session:get_socket_id()))
    static_outside_listeners.on_error(...)
  end
end

local function on_global_error(err_msg, err_code)
  if static_outside_listeners then
    static_outside_listeners.on_error(err_msg, err_code)
  end
end

function SOCKET_SESSION_LISTENERS.on_message(socket_session, header, msg)
  header[RPC_HEADER_KEY_SOCKET_ID] = socket_session:get_socket_id()
  local handled = DISPATCHER.handle_chat_server_message(header, msg)
  if handled then
    return true
  end
  E.LOG.debug(TAG, "on_message socket_id:" .. tostring(socket_session:get_socket_id()) .. ", is_terminating:" .. tostring(socket_session:is_terminating()))
  if socket_session:is_terminating() and msg and msg.cmd == "info_offline" then
    E.LOG.debug(TAG, "on_message info_offline, and this session is terminating, just close it. socket_id:" .. tostring(socket_session:get_socket_id()))
    socket_session:close(CONSTANTS.CHAT_ERROR_CODES.CODE_RPC_INFO_OFFLINE)
    return true
  end
  if static_outside_listeners then
    if M.is_current_session_switching() then
      E.LOG.debug(TAG, "on_message in switching state, from socket_id:" .. tostring(socket_session:get_socket_id()))
    end
    do return static_outside_listeners.on_message, header end
    return static_outside_listeners.on_message, header, msg, tostring(socket_session:get_socket_id()), socket_session:get_socket_id()
  else
    return true
  end
end

function SOCKET_SESSION_LISTENERS.on_connecting(socket_session, ...)
  if socket_session:is_terminating() then
    return
  end
  if M.is_current_session_switching() then
    E.LOG.debug(TAG, "on_connecting switching socket switching session not notify outside:" .. tostring(socket_session:get_socket_id()))
    return
  end
  if static_outside_listeners then
    static_outside_listeners.on_connecting(...)
  end
end

local function on_heartbeat_timeout_reach_max_count_callback(_fail_body)
  on_login_offline()
  M.destroy_heart_beat()
  M.close(CONSTANTS.CHAT_ERROR_CODES.CODE_HEARTBEAT_TIMEOUT)
  ESTAT.stat_action_apus("chat_reconnect", "heartbeat", 0, {
    _sdk_apus_stats = {
      fail_times = _fail_body and _fail_body.fail_times or 0,
      first_timeout = _fail_body and _fail_body.first_timeout or -1,
      cost = _fail_body and _fail_body.cost or -1
    },
    fail_history = _fail_body and _fail_body.fail_history or {}
  })
  on_global_error("heartbeat_timeout", CONSTANTS.RPC_ERROR_CODES.CODE_TIMEOUT)
end

local function create(socket_type, server, options)
  local socket_session = SS:New(socket_type, server, options, SOCKET_SESSION_LISTENERS)
  E.LOG.debug(TAG, "create socket, socket_id:" .. tostring(socket_session:get_socket_id()))
  return socket_session
end

function M.run(socket_type, server, options, cb)
  static_running_socket_session = create(socket_type, server, options)
  E.LOG.debug(TAG, "run socket begin, socket_id:" .. tostring(static_running_socket_session:get_socket_id()))
  static_running_socket_session:run(cb)
end

function M.close(code)
  if static_running_socket_session then
    E.LOG.debug(TAG, "has running socket, begin close")
    static_running_socket_session:close(code)
    static_running_socket_session = nil
  end
  if static_switching_socket_session then
    E.LOG.debug(TAG, "has switching socket, begin close")
    static_switching_socket_session:close(code)
    static_switching_socket_session = nil
  end
  for _, sc in ipairs(static_terminated_socket_session_list) do
    sc:close(code)
  end
  static_terminated_socket_session_list = {}
end

function M.tick()
  if static_running_socket_session then
    static_running_socket_session:tick()
  end
  if static_switching_socket_session then
    static_switching_socket_session:tick()
  end
  if #static_terminated_socket_session_list > 0 then
    for _, sc in ipairs(static_terminated_socket_session_list) do
      sc:tick()
    end
  end
end

function M.write(pack)
  if static_running_socket_session then
    static_running_socket_session:write(pack)
  end
end

function M.get_status()
  if static_running_socket_session then
    do return static_running_socket_session.get_socket_status end
    return static_running_socket_session.get_socket_status, static_running_socket_session
  else
    return nil
  end
end

function M.get_curr_socket_server()
  if static_running_socket_session then
    do return static_running_socket_session.get_server end
    return static_running_socket_session.get_server, static_running_socket_session
  else
    return nil
  end
end

function M.reset_400_count()
  if static_running_socket_session then
    static_running_socket_session:reset_400_count()
  end
end

function M.reset_global_data()
  SS.reset_global_data()
end

local function check_last_login_succ_valid_destinations()
  local valid_login_session_id_destinations = {}
  local invalid_destination_cache_list = {}
  for destination, session_info in pairs(static_last_login_session_info_cache) do
    local GDP = require("ejoysdk_lua.gangplank_data_provider")
    local session_key = "player"
    if destination == DISPATCHER.DESTINATION.ACCOUNT then
      session_key = "account"
    end
    local current_login_session_id = GDP.SESSION_INFO.get(session_key)
    local EG = require("ejoysdk_lua.ejoysdk_gangplank")
    local current_player_info = EG.player_info() or {}
    if current_login_session_id == session_info.login_session_id and current_player_info.player_id == session_info.player_id then
      E.LOG.debug(TAG, "find valid login session in cache, destination:" .. tostring(destination) .. ", login_session_id:" .. tostring(session_info.login_session_id))
      table.insert(valid_login_session_id_destinations, destination)
    else
      table.insert(invalid_destination_cache_list, destination)
    end
  end
  for _, invalid_destination in ipairs(invalid_destination_cache_list) do
    E.LOG.debug(TAG, "remove invalid login session cache for destination:" .. tostring(invalid_destination))
    static_last_login_session_info_cache[invalid_destination] = nil
  end
  return valid_login_session_id_destinations
end

local function mark_login_session_id_invalid(destination)
  E.LOG.debug(TAG, "mark_login_session_id_invalid, destination:" .. tostring(destination))
  static_last_login_session_info_cache[destination] = nil
end

local function on_receive_login_start(destination)
  if destination == DISPATCHER.DESTINATION.PLAYER then
    E.LOG.debug(TAG, "on_receive_login_start, destination:" .. tostring(destination) .. ", begin destroy_heart_beat")
    M.destroy_heart_beat()
  end
end

local function on_recevie_login_result(session, destination, succ, ...)
  if succ then
    local login_session_id = (...)
    local session_info = {
      player_id = session:get_player_id(),
      login_session_id = login_session_id,
      time_sec = os.time()
    }
    static_last_login_session_info_cache[destination] = session_info
    flush_cache_rpc_calls(destination)
    if destination == DISPATCHER.DESTINATION.PLAYER then
      M.destroy_heart_beat()
      if session:get_socket_type() == "websocket" then
        _heartbeat_options = _heartbeat_options or {}
        _heartbeat_options.heartbeat_interval = 25
      end
      CHAT_SOCKET_HEARTBEAT = ECSH:New({on_heartbeat_timeout_reach_max_count = on_heartbeat_timeout_reach_max_count_callback}, _heartbeat_options)
      CHAT_SOCKET_HEARTBEAT:start_heartbeat()
    end
    E.LOG.debug(TAG, "on_recevie_login_result destination:" .. tostring(destination) .. ", login_session_id:" .. tostring(login_session_id))
  else
    local code, msg = ...
    E.LOG.warn(TAG, "on_recevie_login_result destination:" .. tostring(destination) .. ", code:" .. tostring(code) .. ", msg:" .. tostring(msg))
  end
end

local function quick_login_with_destination(session, destination, cb)
  E.LOG.debug(TAG, "quick login, destination:" .. tostring(destination))
  on_receive_login_start(destination)
  session:quick_login(destination, function(succ, ...)
    if succ then
      local login_session_id = (...)
      on_recevie_login_result(session, destination, true, login_session_id)
    else
      mark_login_session_id_invalid(destination)
      local code, msg = ...
      on_recevie_login_result(session, destination, false, code, msg)
    end
    if cb then
      cb(succ, ...)
    end
  end)
end

local function quick_login_last_succ_destination(switch_session, cb)
  if not switch_session then
    cb(false, CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_NO_RUNNING_SOCKET_SESSION, "no running socket client")
    return
  end
  local valid_quick_login_destinations = check_last_login_succ_valid_destinations()
  local login_has_err = false
  local last_err_code = 0
  local last_err_msg
  local login_finish_count = 0
  local all_session_count = E.Utils.table_size(valid_quick_login_destinations)
  local invalid_cache_destinations = {}
  for _, destination in ipairs(valid_quick_login_destinations) do
    quick_login_with_destination(switch_session, destination, function(quick_login_succ, ...)
      login_finish_count = login_finish_count + 1
      if not quick_login_succ then
        table.insert(invalid_cache_destinations, destination)
        last_err_code, last_err_msg = ...
        login_has_err = true
        E.LOG.warn(TAG, "quick_login_all_destination failed, code:" .. tostring(last_err_code) .. ", msg:" .. tostring(last_err_msg) .. ", for destination:" .. tostring(destination))
      else
        E.LOG.debug(TAG, "quick_login_all_destination succ for destination:" .. tostring(destination))
      end
      if login_finish_count == all_session_count and cb then
        if login_has_err then
          cb(false, last_err_code, last_err_msg)
        else
          cb(true)
        end
      end
    end)
  end
end

function M.quick_switch_running_session(cb)
  E.LOG.debug(TAG, "quick_switch_running_session begin")
  
  local function on_switching_failed(_code, _msg)
    E.LOG.warn(TAG, "quick_switch_running_session switching failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    if static_switching_socket_session then
      static_switching_socket_session:close(CONSTANTS.CHAT_ERROR_CODES.CODE_SWITCHING_FAILED)
      static_switching_socket_session = nil
    end
  end
  
  if static_running_socket_session then
    local function on_chat_token_valid()
      local socket_type, server, server_options = static_running_socket_session:get_server_detail()
      
      static_switching_socket_session = create(socket_type, server, server_options)
      static_switching_socket_session:run(function(conn_succ, ...)
        if conn_succ then
          E.LOG.debug(TAG, "quick_switch_running_session new connect succ, and begin quick login")
          quick_login_last_succ_destination(static_switching_socket_session, function(quick_login_succ, ...)
            if quick_login_succ then
              E.LOG.debug(TAG, "quick_switch_running_session quick_login succ, put it to terminating state, and run new connect")
              static_running_socket_session:mark_session_alive_status(SS.ALIVE_STATUS.TERMINATED)
              table.insert(static_terminated_socket_session_list, static_running_socket_session)
              static_running_socket_session = static_switching_socket_session
              static_switching_socket_session = nil
              E.LOG.debug(TAG, "quick_switch_running_session quick login succ, change switching session to running state, socket_id:" .. tostring(static_running_socket_session:get_socket_id()))
              cb(true)
            else
              local _code, _msg = ...
              on_switching_failed(_code, _msg)
              E.LOG.debug(TAG, "quick_switch_running_session quick login failed, close switching session, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg) .. ", current running state:" .. tostring(static_running_socket_session:get_socket_id()))
              cb(false, _code, _msg)
            end
          end)
        else
          local _code, _msg = ...
          on_switching_failed(_code, _msg)
          E.LOG.debug(TAG, "quick_switch_running_session new connect failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg) .. ", current running state:" .. tostring(static_running_socket_session:get_socket_id()))
          cb(false, _code, _msg)
        end
      end)
    end
    
    chat_token.refresh_chat_token(function(succ, ...)
      if succ then
        on_chat_token_valid()
      else
        local code, msg = ...
        msg = "quick switch refresh token failed, " .. tostring(msg)
        E.LOG.warn(TAG, msg)
        cb(false, code, msg)
      end
    end)
  else
    E.LOG.debug(TAG, "quick_switch_running_session not has running session")
    cb(false, CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_NO_RUNNING_SOCKET_SESSION, "switch failed, no running session")
  end
end

function M.quick_login(destination, cb)
  if not static_running_socket_session then
    cb(false, CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_NO_RUNNING_SOCKET_SESSION, "quick login failed, no running session")
    return
  end
  quick_login_with_destination(static_running_socket_session, destination, cb)
end

function M.is_current_session_switching()
  return nil ~= static_switching_socket_session
end

function M.destroy_heart_beat()
  if CHAT_SOCKET_HEARTBEAT then
    CHAT_SOCKET_HEARTBEAT:destroy()
    CHAT_SOCKET_HEARTBEAT = nil
  end
end

function M.login(destination, cb)
  E.LOG.debug(TAG, "login received, destination:" .. tostring(destination))
  on_receive_login_start(destination)
  if static_running_socket_session then
    static_running_socket_session:login(destination, function(succ, ...)
      if succ then
        local login_session_id, ret = ...
        E.LOG.debug(TAG, "login succ, login_session_id:" .. tostring(login_session_id) .. ", ret >>")
        E.log(ret)
        on_recevie_login_result(static_running_socket_session, destination, true, login_session_id)
        if cb then
          cb(ret)
        end
      else
        local code, msg, ret = ...
        E.LOG.debug(TAG, "login failed, login_session_id, code:" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", ret >>")
        E.log(ret)
        on_recevie_login_result(static_running_socket_session, destination, false, code, msg)
        if cb then
          cb(ret)
        end
      end
    end)
  else
    cb({
      code = CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_NO_RUNNING_SOCKET_SESSION,
      msg = "no running socket client"
    })
  end
end

function M.rpc_call(destination, params, cb)
  if static_running_socket_session then
    local running_session_state = static_running_socket_session:get_session_state()
    if running_session_state == SS.LOGIN_STATE.LOGGED_IN then
      static_running_socket_session:rpc_call(destination, params, function(ret, net_span, session)
        if CHAT_SOCKET_HEARTBEAT then
          local is_timeout = ret and ret.code == CONSTANTS.RPC_ERROR_CODES.CODE_TIMEOUT
          local rpc_cost = net_span and net_span.get_duration and net_span:get_duration() or -1
          CHAT_SOCKET_HEARTBEAT:on_rpc_result(params.cmd, is_timeout, tostring(session), ret and ret.code, rpc_cost)
        elseif params and params.cmd == "login" then
          local rpc_cost = net_span and net_span.get_duration and net_span:get_duration() or -1
          local ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
          if ok and ret and ret.code and m_api_stats and m_api_stats.count_game_rpc_call then
            m_api_stats.count_game_rpc_call("sdk.login", 0 == (ret and ret.code), ret and ret.code, rpc_cost, "ejoysdk.chat")
          end
        end
        if cb then
          cb(ret)
        end
      end)
    else
      E.LOG.debug(TAG, "rpc_call runnig session not logged in, cache rpc_call, session_state:" .. tostring(running_session_state))
      table.insert(static_rpc_call_pending_cache, {
        destination = destination,
        params = params,
        cb = cb
      })
    end
  elseif cb then
    cb({
      code = CONSTANTS.RPC_ERROR_CODES.CODE_SOCKET_NO_RUNNING_SOCKET_SESSION,
      msg = "no running socket client, its disconnected"
    })
  end
end

function M.set_heartbeat_options(options)
  _heartbeat_options = options
end

function M.get_heartbeat_options()
  return _heartbeat_options
end

function M.has_running_session()
  return nil ~= static_running_socket_session
end

local function find_session_with_socket_id(socket_id)
  if not socket_id or "" == socket_id then
    E.LOG.warn(TAG, "find_session_with_socket_id failed, socket_id is nil")
    return nil
  end
  if static_running_socket_session and static_running_socket_session:get_socket_id() == socket_id then
    E.LOG.debug(TAG, "find_session_with_socket_id succ, find running session")
    return static_running_socket_session
  end
  if static_switching_socket_session and static_switching_socket_session:get_socket_id() == socket_id then
    E.LOG.debug(TAG, "find_session_with_socket_id succ, find switching session")
    return static_switching_socket_session
  end
  for _, session in ipairs(static_terminated_socket_session_list) do
    if session:get_socket_id() == socket_id then
      E.LOG.debug(TAG, "find_session_with_socket_id succ, find terminating session")
      return session
    end
  end
  E.LOG.warn(TAG, "find_session_with_socket_id failed, neither running nor terminating sessions find it")
  return nil
end

M.CHAT_SERVER_MSG_HANDLERS = {}

function M.CHAT_SERVER_MSG_HANDLERS.stop_conn(header, _msg)
  E.LOG.debug(TAG, "CHAT_CONN_HANDLERS stop_conn received")
  local socket_id = header[RPC_HEADER_KEY_SOCKET_ID]
  local target_stop_session = find_session_with_socket_id(socket_id)
  if target_stop_session then
    target_stop_session:mark_session_alive_status(SS.ALIVE_STATUS.TERMINATING)
  end
  local apus_ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
  if apus_ok and m_api_stats and m_api_stats.count_game_rpc_call then
    m_api_stats.count_game_rpc_call("sdk.stop_conn.begin", true, 0, 0, "ejoysdk.chat")
  end
  local before = E.system_clock()
  M.quick_switch_running_session(function(succ, ...)
    local err_code, err_msg
    if succ then
      if header.session then
        if target_stop_session and target_stop_session:get_session_state() == SS.LOGIN_STATE.LOGGED_IN then
          E.LOG.debug(TAG, "stop_conn quick_switch_running_session succ, now send ack to socket:" .. tostring(socket_id))
          target_stop_session:rpc_ack(header.session, header.trace)
        end
      else
        E.LOG.warn(TAG, "CHAT_CONN_HANDLERS stop_conn send rpc ack failed, no session found for msg header")
        E.log(header)
      end
    else
      err_code, err_msg = ...
      E.LOG.warn(TAG, "CHAT_CONN_HANDLERS stop_conn switch login failed, code:" .. tostring(err_code) .. ", msg:" .. tostring(err_msg))
    end
    if apus_ok and m_api_stats and m_api_stats.count_game_rpc_call then
      m_api_stats.count_game_rpc_call("sdk.stop_conn.end", succ, succ and 0 or err_code, E.system_clock() - before, "ejoysdk.chat")
    end
    CHAT_STAT.stat_stop_conn_result(succ, err_code, err_msg)
  end)
  CHAT_STAT.stat_stop_conn_begin()
end

function M.CHAT_SERVER_MSG_HANDLERS.force_stop_conn(_header, _msg)
  E.LOG.debug(TAG, "CHAT_CONN_HANDLERS force_stop_conn received")
  M.close(CONSTANTS.CHAT_ERROR_CODES.CODE_FORCE_STOP_CONN)
  local apus_ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
  if apus_ok and m_api_stats and m_api_stats.count_game_rpc_call then
    m_api_stats.count_game_rpc_call("sdk.force_stop_conn", true, 0, 0, "ejoysdk.chat")
  end
end

return M
