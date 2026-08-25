local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local PACK = require("ejoysdk_lua.chat.ejoysdk_chat_data_pack")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local rpc_opentracing = require("ejoysdk_lua.chat.ejoysdk_chat_rpc_opentracing")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local string_pack, _string_unpack, xpcall = compat.string.pack, compat.string.unpack, compat.xpcall
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local CHAT_STAT = require("ejoysdk_lua.chat.chat_stat")
local M = Class:Inherit("ejoy.class.chat.socket_session")
local TAG = "socket_session"
M.CONNECT_STATE = {
  DISCONNECT = "disconnect",
  CONNECTING = "connecting",
  CONNECTED = "connected"
}
M.LOGIN_STATE = {
  NOT_LOGIN = "not_login",
  LOGINING = "logining",
  LOGGED_IN = "logged_in"
}
M.ALIVE_STATUS = {
  RUNNING = "running",
  TERMINATING = "terminating",
  TERMINATED = "terminated"
}
local RPC_ERROR_MSG = {
  SOCKET_NOT_INIT = "socket not init",
  TOKEN_MISS = "token miss",
  SOCKET_NOT_CONNECTED = "socket not connected",
  CALL_RPC_ON_NOT_LOGIN = "call rpc on not login",
  TIME_OUT = "time out"
}
local RPC_CBS = {}
local MAX_ID = 10000000
local TRACE_ID = math.random(MAX_ID)
local static_socket_id_counter = 0
local static_is_first_time_login = true

local function generate_socket_id()
  local socket_id = static_socket_id_counter
  static_socket_id_counter = (static_socket_id_counter + 1) % MAX_ID
  return socket_id
end

function M:log_debug(msg)
  E.LOG.debug(self._data.log_tag, msg)
end

function M:log_warn(msg)
  E.LOG.warn(self._data.log_tag, msg)
end

local function cmd_rpc_receive(content_data)
  if content_data and content_data.msg then
    return content_data.msg.cmd or ""
  end
  return ""
end

local function should_custom_log_rpc_receive(content_data)
  local cmd = cmd_rpc_receive(content_data)
  local should = false
  if "get_latest_session" == cmd then
    should = true
  elseif "get_session_msg" == cmd then
    should = true
  elseif "info_msg" == cmd then
    should = true
  elseif "login" == cmd then
    should = true
  end
  return should
end

local function custom_log_rpc_receive(content_data)
  local cmd = cmd_rpc_receive(content_data)
  if "get_latest_session" == cmd then
    local copy_content_data = utils.deepcopy(content_data)
    copy_content_data.msg.sessions = nil
    local log_session_ids
    if content_data.msg and content_data.msg.sessions then
      log_session_ids = chat_log_util.session_ids(content_data.msg.sessions) or {}
    end
    copy_content_data.msg.log_session_ids = log_session_ids
    chat_log.rpc_receive(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.HIGH, copy_content_data, {})
  elseif "get_session_msg" == cmd then
    local copy_content_data = utils.deepcopy(content_data)
    copy_content_data.msg.msgs = nil
    local log_msg_infos = {}
    if content_data.msg and content_data.msg.msgs then
      log_msg_infos = chat_log_util.simple_msg_infos(content_data.msg.msgs)
    end
    local log_msg_infos_by_section = chat_log.list_by_section(log_msg_infos, 4)
    for _, section in pairs(log_msg_infos_by_section) do
      copy_content_data.msg.log_msg_section = section
      chat_log.rpc_receive(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.HIGH, copy_content_data, {})
    end
  elseif "info_msg" == cmd then
    local copy_content_data = utils.deepcopy(content_data)
    copy_content_data.msg.msgs = nil
    local log_msg_infos = {}
    if content_data.msg and content_data.msg.msgs then
      log_msg_infos = chat_log_util.simple_msg_infos(content_data.msg.msgs)
    end
    local log_msg_infos_by_section = chat_log.list_by_section(log_msg_infos, 4)
    for _, section in pairs(log_msg_infos_by_section) do
      copy_content_data.msg.log_msg_section = section
      chat_log.rpc_receive(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.HIGH, copy_content_data, {})
    end
  elseif "login" == cmd then
    local copy_content_data = utils.deepcopy(content_data)
    copy_content_data.msg.groups = nil
    local log_groups = {}
    if content_data.msg and content_data.msg.groups then
      log_groups = chat_log_util.simple_group_infos(content_data.msg.groups)
    end
    local log_groups_by_section = chat_log.list_by_section(log_groups, 3)
    for _, section in pairs(log_groups_by_section) do
      copy_content_data.msg.log_group_section = section
      chat_log.rpc_receive(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.HIGH, copy_content_data, {})
    end
  end
end

local function log_level_rpc_receive(_content_data)
  return chat_log.LOG_LEVEL.LOW
end

function M:_on_message(pack)
  local ok, header, msg = self._data.pack_ins:unpack_data(pack)
  local content_data = {header = header, msg = msg}
  if should_custom_log_rpc_receive(content_data) then
    custom_log_rpc_receive(content_data)
  else
    local log_level = log_level_rpc_receive(content_data)
    chat_log.rpc_receive(chat_log_util.header(), TAG, log_level, content_data, {})
  end
  if not ok then
    local _error_msg = header
    self:close(CONSTANTS.CHAT_ERROR_CODES.CODE_UNPACK_FAILED, _error_msg)
    self:log_warn("pack decrypt fail msg: " .. tostring(_error_msg))
    self._data.listeners.on_error(self, "pack decrypt fail:" .. tostring(_error_msg), CONSTANTS.RPC_ERROR_CODES.CODE_MESSAGE_DECRYPT_FAILED)
    return false, CONSTANTS.CHAT_ERROR_CODES.CODE_UNPACK_FAILED, _error_msg
  end
  local session = header.session
  local cb = RPC_CBS[session]
  utils.reset_deepcopy_only_once_record()
  if cb then
    RPC_CBS[session] = nil
    xpcall(cb, function(x)
      chat_log.warn(chat_log_util.header(), TAG, "rpc_callback_exe_error", {
        err_code = CONSTANTS.RPC_ERROR_CODES.CODE_CALLBACK_EXE_ERROR,
        lua_error_msg = tostring(x)
      }, {})
      local notify_succ, notify_error = pcall(CALLBACK.callback, "chat", CALLBACK.HANDLER_NAME.ON_HANDLERS_ERROR, "", x)
      if not notify_succ then
        chat_log.warn(chat_log_util.header(), TAG, "chat_notify_cp_error", {notify_error = notify_error}, {})
      end
    end, msg)
  else
    do return self._data.listeners.on_message, self, header end
    return self._data.listeners.on_message, self, header, msg, {}
  end
  return true
end

function M:create(socket_type, server, listeners)
  local ECS
  if "websocket" == socket_type then
    ECS = require("ejoysdk_lua.chat.ejoysdk_chat_websocket")
  else
    ECS = require("ejoysdk_lua.chat.ejoysdk_chat_socket")
  end
  local socket_id = generate_socket_id()
  local last_error_code, last_error_msg
  local socket = ECS:New(server, {
    on_connect_start = function(...)
      self._data.connect_state = M.CONNECT_STATE.CONNECTING
      listeners.on_connect_start(self, ...)
      CHAT_STAT.stat_connect_start(self._data.socket_id)
    end,
    on_connect_error = function(msg, code)
      last_error_code = code
      last_error_msg = msg
      listeners.on_connect_error(self, msg, code)
      CHAT_STAT.stat_connect_result(self._data.socket_id, false, code, msg)
    end,
    on_connected = function()
      self._data.connect_state = M.CONNECT_STATE.CONNECTED
      self._data.pack_ins:reset()
      last_error_code = 0
      last_error_msg = nil
      local conn_cb = table.remove(self._data.connect_callbacks, 1)
      while conn_cb do
        conn_cb(true)
        conn_cb = table.remove(self._data.connect_callbacks, 1)
      end
      listeners.on_connected(self)
      CHAT_STAT.stat_connect_result(self._data.socket_id, true)
    end,
    on_disconnect = function(code, msg)
      E.log("on_disconnect, socket_id:" .. tostring(self._data.socket_id))
      self._data.connect_state = M.CONNECT_STATE.DISCONNECT
      self._data.login_state = M.LOGIN_STATE.NOT_LOGIN
      local conn_cb = table.remove(self._data.connect_callbacks, 1)
      while conn_cb do
        conn_cb(false, last_error_code, last_error_msg)
        conn_cb = table.remove(self._data.connect_callbacks, 1)
      end
      listeners.on_disconnect(self, code)
      CHAT_STAT.stat_socket_disconnect(code, msg)
    end,
    on_error = function(msg, code)
      last_error_code = code
      last_error_msg = msg
      listeners.on_error(self, msg, code)
      CHAT_STAT.stat_connect_result(self._data.socket_id, false, code, msg)
    end,
    on_message = function(pack)
      do return self._on_message, self end
      return self._on_message, self, pack
    end,
    on_connecting = function(...)
      self._data.connect_state = M.CONNECT_STATE.CONNECTING
      listeners.on_connecting(self, ...)
    end
  })
  E.LOG.debug(TAG, "create socket, socket_id:" .. tostring(socket_id))
  return socket, socket_id
end

function M:_init(socket_type, server, options, listeners)
  options = options or {}
  self._data = {
    connect_state = M.CONNECT_STATE.DISCONNECT,
    login_state = M.LOGIN_STATE.NOT_LOGIN,
    listeners = listeners,
    socket_id = nil,
    socket = nil,
    server_options = options,
    alive_status = M.ALIVE_STATUS.RUNNING,
    socket_type = socket_type,
    server = server,
    connect_callbacks = {},
    pack_ins = PACK:New(options)
  }
  local socket, socket_id = self:create(socket_type, server, listeners)
  self._data.socket = socket
  self._data.socket_id = socket_id
  self._data.log_tag = TAG .. "#" .. tostring(socket_id)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  self._data.player_info = EG.player_info() or {}
  self:log_debug("init begin, socket_id:" .. tostring(self._data.socket_id) .. ", player_id:" .. tostring(self._data.player_info.player_id))
end

function M:close(code, msg)
  self._data.socket:close(code, msg)
end

function M:run(cb)
  self._data.socket:run()
  if cb then
    table.insert(self._data.connect_callbacks, cb)
  end
end

local function trace_id()
  TRACE_ID = (TRACE_ID + 1) % MAX_ID
  return TRACE_ID
end

local function rpc_timeout_config(cmd)
  if cmd and "login" == cmd then
    return 10
  else
    return 5
  end
end

function M:_get_extra_header()
  local extra_header_list = {}
  if self._data.pack_ins:get_curr_login_version() == chat_token.LOGIN_V2 then
    local server_version = 1
    table.insert(extra_header_list, string_pack("B", server_version))
    table.insert(extra_header_list, string_pack("B", #self._data.player_info.player_id))
    table.insert(extra_header_list, self._data.player_info.player_id)
    table.insert(extra_header_list, string_pack("B", #(chat_token.get_chat_token() or "")))
    table.insert(extra_header_list, chat_token.get_chat_token() or "")
  else
    local server_version = 0
    table.insert(extra_header_list, string_pack("B", server_version))
    local expire_time = 0
    if EH.get_player_token_body() then
      expire_time = EH.get_player_token_body().expire_time
    else
      E.LOG.debug(TAG, "ejoy_chat_server_get_extra_header, " .. "token_is_nil")
    end
    table.insert(extra_header_list, string_pack(">I4", expire_time))
    table.insert(extra_header_list, string_pack("B", #self._data.player_info.player_id))
    table.insert(extra_header_list, self._data.player_info.player_id)
  end
  local rpc_header = table.concat(extra_header_list)
  return rpc_header
end

local function should_custom_log_rpc_send(content_data)
  local cmd = ""
  if content_data.content_body and content_data.content_body.cmd then
    cmd = content_data.content_body.cmd
  end
  local should = false
  if "send" == cmd then
    should = true
  elseif "login" == cmd then
    should = true
  end
  return should
end

local function custom_log_rpc_send(content_data)
  local cmd = ""
  if content_data.content_body and content_data.content_body.cmd then
    cmd = content_data.content_body.cmd
  end
  if "send" == cmd then
    local copy_content_data = utils.deepcopy(content_data)
    if copy_content_data.content_body and copy_content_data.content_body.content then
      copy_content_data.content_body.content = nil
    end
    chat_log.rpc_send(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.HIGH, copy_content_data, {})
  elseif "login" == cmd then
    chat_log.rpc_send(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.HIGH, content_data, {})
  end
end

function M:rpc_call(destination, params, cb)
  _ejoysdk.log("rpc_call params:" .. tostring(type(params)))
  local ejoysdk_pack_data_options = params.ejoysdk_pack_data_options
  params.ejoysdk_pack_data_options = nil
  local next_trace_id = trace_id()
  local session = next_trace_id
  if not params._opentracing then
    params._opentracing = {
      span_buz = params.cmd
    }
  end
  local opentracing = params._opentracing
  local net_span
  if opentracing then
    net_span = rpc_opentracing.RPC.start_rpc_span("RPC", params.cmd, params, next_trace_id)
  end
  local header = {
    codec = "json",
    destination = destination,
    trace = next_trace_id,
    session = session
  }
  if cb then
    local function cb_wraper(...)
      if opentracing and net_span then
        local info = (...)
        
        rpc_opentracing.RPC.stop_rpc_span(opentracing, net_span, info)
      end
      cb((...), net_span, session)
      local _info = (...)
      local _code, _msg = 0
      if _info then
        _code, _msg = _info.code, _info.msg
      end
      CHAT_STAT.stat_rpc_result(params.cmd, header, 0 == _code, _code, _msg)
    end
    
    RPC_CBS[tostring(session)] = cb_wraper
    local timeout_second = rpc_timeout_config(params.cmd)
    if params._sdk_rpc_timeout_second then
      timeout_second = params._sdk_rpc_timeout_second
      params._sdk_rpc_timeout_second = nil
    end
    E.Timer.once(timeout_second, function()
      if RPC_CBS[tostring(session)] then
        utils.reset_deepcopy_only_once_record()
        local cached_cb_wraper = RPC_CBS[tostring(session)]
        RPC_CBS[tostring(session)] = nil
        cached_cb_wraper({
          code = CONSTANTS.RPC_ERROR_CODES.CODE_TIMEOUT,
          msg = RPC_ERROR_MSG.TIME_OUT
        })
      end
    end)
  end
  if params.cmd == "heartbeat" then
    header.method = "heartbeat"
  end
  if opentracing and net_span then
    rpc_opentracing.RPC.inject_tracing_header(net_span, header)
  end
  local rpc_header = self:_get_extra_header()
  local content_data = {
    [PACK.DATA_PARTS.RPC_HEADER] = rpc_header,
    [PACK.DATA_PARTS.CONTENT_HEADER] = header,
    [PACK.DATA_PARTS.CONTENT_BODY] = params
  }
  local log_content_data = {
    [PACK.DATA_PARTS.CONTENT_HEADER] = header,
    [PACK.DATA_PARTS.CONTENT_BODY] = params
  }
  if should_custom_log_rpc_send(log_content_data) then
    custom_log_rpc_send(log_content_data)
  else
    chat_log.rpc_send(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.LOW, log_content_data, {})
  end
  local pack = self._data.pack_ins:pack_data(content_data, ejoysdk_pack_data_options)
  self:write(pack)
  CHAT_STAT.stat_rpc_start(params.cmd, header)
end

function M:rpc_ack(session, trace)
  local header = {
    codec = "json",
    code = 0,
    trace = trace,
    session = session
  }
  local rpc_header = self:_get_extra_header()
  local content_data = {
    [PACK.DATA_PARTS.RPC_HEADER] = rpc_header,
    [PACK.DATA_PARTS.CONTENT_HEADER] = header,
    [PACK.DATA_PARTS.CONTENT_BODY] = {}
  }
  local log_content_data = {
    [PACK.DATA_PARTS.CONTENT_HEADER] = header,
    [PACK.DATA_PARTS.CONTENT_BODY] = {}
  }
  chat_log.rpc_send(chat_log_util.header(), TAG, chat_log.LOG_LEVEL.LOW, log_content_data, {})
  local pack = self._data.pack_ins:pack_data(content_data)
  E.LOG.debug(TAG, "rpc_ack for session:" .. tostring(session) .. ", socket_id:" .. tostring(self._data.socket_id))
  self:write(pack)
end

function M:login(destination, cb)
  local token
  if self._data.pack_ins:get_curr_login_version() == chat_token.LOGIN_V2 then
    token = chat_token.get_chat_token()
    E.LOG.debug(TAG, "chat_connect: login use v2")
  else
    token = EH.get_player_token()
    E.LOG.debug(TAG, "chat_connect: login use v1")
  end
  local params = {}
  params.cmd = "login"
  params.token = token
  if PACK.is_support_deflate() and self._data.server_options.encrypt then
    params.accept_encoding = {
      PACK.ENCODING_TYPES.DEFLATE
    }
  end
  local game_id = E.get_game_id()
  if game_id then
    local log_data = {}
    log_data.os = E.Sysinfo.os()
    log_data.appId = game_id
    log_data.utdid = E.Sysinfo.utdid()
    log_data.trace_session_id = E.get_pkg_info().sdk_trace_id
    params.log_data = log_data
  end
  params.login_data = {}
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local session_key = "player"
  if destination == DISPATCHER.DESTINATION.ACCOUNT then
    session_key = "account"
  end
  local login_session_id = GDP.SESSION_INFO.get(session_key)
  params.login_data.login_session_id = login_session_id
  if static_is_first_time_login then
    params.login_data.login_type = "first"
  else
    params.login_data.login_type = "reconnect"
  end
  params.login_data.sdk_compat_version = {lua = 1}
  self:rpc_call(destination, params, function(ret)
    local succ = 0 == ret.code
    if succ then
      E.LOG.debug(TAG, "chat_connect: rpc login succ, destination:" .. tostring(destination) .. ", socket_id:" .. tostring(self._data.socket_id))
      self._data.login_state = M.LOGIN_STATE.LOGGED_IN
      static_is_first_time_login = false
      if cb then
        cb(true, login_session_id, ret)
      end
    else
      E.LOG.debug(TAG, "chat_connect: rpc login fail, code=" .. tostring(ret.code) .. ", destination:" .. tostring(destination))
      _ejoysdk.log("login failed ret >>")
      E.log(ret)
      local msg = ret.msg or ret.message or "login failed"
      if cb then
        cb(false, ret.code, msg, ret)
      end
    end
  end)
end

function M:quick_login(destination, cb)
  local params = {}
  params.cmd = "login"
  if PACK.is_support_deflate() and self._data.server_options.encrypt then
    params.accept_encoding = {
      PACK.ENCODING_TYPES.DEFLATE
    }
  end
  local game_id = E.get_game_id()
  if game_id then
    local log_data = {}
    log_data.os = E.Sysinfo.os()
    log_data.appId = game_id
    log_data.utdid = E.Sysinfo.utdid()
    log_data.trace_session_id = E.get_pkg_info().sdk_trace_id
    params.log_data = log_data
  end
  params.login_data = {}
  params.login_data.login_type = "switch"
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local session_key = "player"
  if destination == DISPATCHER.DESTINATION.ACCOUNT then
    session_key = "account"
  end
  local login_session_id = GDP.SESSION_INFO.get(session_key)
  params.login_data.login_session_id = login_session_id
  params.token = chat_token.get_chat_token()
  E.LOG.debug(TAG, "quick_login: begin, chat_token:" .. tostring(params.token) .. ", expire:" .. tostring(chat_token.get_chat_token_expire_time()) .. ", key:" .. tostring(chat_token.get_chat_token_info_key()) .. ", destination:" .. tostring(destination) .. ", login_session_id:" .. tostring(params.login_data.login_session_id))
  self:rpc_call(destination, params, function(ret)
    if 0 == ret.code then
      E.LOG.debug(TAG, "chat_connect: rpc quick login succ, socket_id:" .. tostring(self._data.socket_id) .. ", destination:" .. tostring(destination))
      E.log(ret)
      self._data.login_state = M.LOGIN_STATE.LOGGED_IN
      static_is_first_time_login = false
      if cb then
        cb(true, login_session_id)
      end
    else
      local code = ret.code
      local msg = ret.msg or ret.message or "quick_login failed"
      E.LOG.debug(TAG, "chat_connect: rpc quick login fail, code=" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", destination:" .. tostring(destination) .. ", socket_id:" .. tostring(self._data.socket_id))
      E.log(ret)
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

function M:write(pack)
  self._data.socket:write(pack)
end

function M:get_socket_id()
  return self._data.socket_id
end

function M:tick()
  if self._data.alive_status == M.ALIVE_STATUS.RUNNING then
    self._data.socket:tick()
  else
    self._data.socket:tick_read()
  end
end

function M:mark_session_alive_status(alive_status)
  self:log_debug("mark_session_terminating:" .. tostring(self:get_socket_id()))
  self._data.alive_status = alive_status
end

function M:get_socket_status()
  do return self._data.socket.get_status end
  return self._data.socket.get_status, self._data.socket
end

function M:get_session_state()
  local session_state
  if self._data.connect_state == M.CONNECT_STATE.CONNECTED then
    session_state = self._data.login_state
  else
    session_state = self._data.connect_state
  end
  self:log_debug("get_session_state:" .. tostring(self:get_socket_id()) .. ", session_state:" .. tostring(session_state))
  return session_state
end

function M:is_terminating()
  return self._data.alive_status == M.ALIVE_STATUS.TERMINATING or self._data.alive_status == M.ALIVE_STATUS.TERMINATED
end

function M:get_server()
  do return self._data.socket.get_server end
  return self._data.socket.get_server, self._data.socket
end

function M:get_server_detail()
  return self._data.socket_type, self._data.server, self._data.server_options
end

function M:get_socket_type()
  return self._data.socket_type
end

function M:get_player_id()
  return self._data.player_info.player_id
end

function M:reset_400_count()
  self._data.socket:reset_400_count()
end

function M.reset_global_data()
  E.LOG.debug(TAG, "reset_global_data received")
  static_is_first_time_login = true
end

return M
