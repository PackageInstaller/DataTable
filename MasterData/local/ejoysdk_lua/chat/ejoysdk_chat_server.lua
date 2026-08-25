local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local ECSH = require("ejoysdk_lua.chat.ejoysdk_chat_socket_heartbeat")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local PACK = require("ejoysdk_lua.chat.ejoysdk_chat_data_pack")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local string_pack, _string_unpack, xpcall = compat.string.pack, compat.string.unpack, compat.xpcall
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local rpc_opentracing = require("ejoysdk_lua.chat.ejoysdk_chat_rpc_opentracing")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local chat_jf = require("ejoysdk_lua.chat.ejoysdk_chat_jf")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local TAG = EM.MODULE.CHAT .. "server"
local LAST_SERVER_PORT_STORE = E.LazyKeyStore:New("CHAT_SERVER_LAST_PORT_NUM", false, false, false)
local M = {}
local CHAT_SOCKET, CHAT_SOCKET_HEARTBEAT, _heartbeat_options
local _is_first_time_login = true
local DEFAULT_SERVER_PORTS = {
  12345,
  443,
  80
}
local current_chat_server_port = 0
local current_chat_server_port_arr = DEFAULT_SERVER_PORTS
local current_server_port_idx = 1
local need_add_port_idx = false
local server_options

local function init_with_server_ports_config()
  local chat_config = EGC.get_current_chat_config()
  local ports = DEFAULT_SERVER_PORTS
  if chat_config and chat_config[EGC.CONFIG_KEY.KEY_CHAT_PORTS] and next(chat_config[EGC.CONFIG_KEY.KEY_CHAT_PORTS]) ~= nil then
    ports = chat_config[EGC.CONFIG_KEY.KEY_CHAT_PORTS]
  end
  return ports
end

local function init_server_port()
  current_chat_server_port_arr = init_with_server_ports_config()
  local last_server_port_str = LAST_SERVER_PORT_STORE:get()
  local last_server_port = 0
  if last_server_port_str and type(last_server_port_str) == "string" and #last_server_port_str > 0 then
    last_server_port = tonumber(last_server_port_str)
  end
  local is_port_valid = false
  if last_server_port and last_server_port > 0 then
    for _, port in ipairs(current_chat_server_port_arr) do
      if port == last_server_port then
        is_port_valid = true
      end
    end
  end
  if is_port_valid then
    current_chat_server_port = last_server_port
  else
    current_chat_server_port = current_chat_server_port_arr[current_server_port_idx]
  end
end

local function next_server_port()
  if need_add_port_idx then
    current_server_port_idx = current_server_port_idx + 1
    need_add_port_idx = false
  end
  if current_server_port_idx > #current_chat_server_port_arr then
    current_server_port_idx = 1
  end
  return current_chat_server_port_arr[current_server_port_idx]
end

function M.get_server_port()
  return current_chat_server_port_arr[current_server_port_idx]
end

local function on_server_port_fail()
  need_add_port_idx = true
  LAST_SERVER_PORT_STORE:set("")
end

function M.get_server()
  local server = {
    addr = M.get_server_addr(),
    port = next_server_port(),
    socket_type = "TCP"
  }
  E.LOG.debug(TAG, "chat server url:" .. server.addr)
  return server
end

function M.get_conn_status()
  if nil == CHAT_SOCKET then
    return nil
  else
    do return CHAT_SOCKET.get_status end
    return CHAT_SOCKET.get_status, CHAT_SOCKET
  end
end

function M.get_curr_socket_server()
  if CHAT_SOCKET then
    return CHAT_SOCKET:get_server() or {}
  end
  return {}
end

function M.get_server_addr()
  local product = E.CONFIG.get_config("product"):lower()
  local server_name
  local chat_config = EGC.get_current_chat_config()
  if chat_config and chat_config[EGC.CONFIG_KEY.KEY_HOST] then
    server_name = chat_config[EGC.CONFIG_KEY.KEY_HOST]
  else
    local region = E.CONFIG.get_config("region")
    local splice_rules = E.CONFIG.get_splice_rules()
    local region_rule = splice_rules[E.CONFIG.RULE_KEY.RULE_REGION]
    if region and region_rule == E.CONFIG.URL_REGION_SPLICE_RULE.RULE_DEFAULT then
      region = "-" .. region:lower()
    else
      region = ""
    end
    server_name = product .. region .. "-chat-tcpclient" .. EGC.server_domain_suffix()
  end
  return server_name
end

function M.get_websocket_server()
  local product = E.CONFIG.get_config("product"):lower()
  local server_name
  local chat_config = EGC.get_current_chat_config()
  if chat_config and chat_config[EGC.CONFIG_KEY.KEY_WSS_HOST] then
    server_name = chat_config[EGC.CONFIG_KEY.KEY_WSS_HOST]
  else
    local region = E.CONFIG.get_config("region")
    local splice_rules = E.CONFIG.get_splice_rules()
    local region_rule = splice_rules[E.CONFIG.RULE_KEY.RULE_REGION]
    if region and region_rule == E.CONFIG.URL_REGION_SPLICE_RULE.RULE_DEFAULT then
      region = "-" .. region:lower()
    else
      region = ""
    end
    server_name = "wss://" .. product .. region .. "-chat-wsclient" .. EGC.server_domain_suffix() .. "/ws"
  end
  return server_name
end

M.DESTINATION = {
  PLAYER = "chat",
  ACCOUNT = "acc_chat",
  BADGE = "badge",
  CLIENT_FRIEND = "client_friend",
  CLIENT_FRIEND_CHAT = "client_friend_chat",
  CLIENT_FRIEND_CHAT_ACCOUNT = "client_friend_chat_account",
  CLIENT_MAIL = "client_mail"
}
local PLAYER_INFO
local MAX_ID = 10000000
local TRACE_ID = 0
local SEND_ID = 0
local PLAYER_ID_HASH = ""
local RPC_CBS = {}

local function on_connect_start()
  DISPATCHER.on_connect_start()
end

local function on_connect_error(error_msg, error_code)
  chat_jf.connect_fail({
    err_msg = error_msg or "nil",
    err_code = error_code or -1
  })
  M.destroy_heart_beat()
  M.destroy_socket()
  on_server_port_fail()
  DISPATCHER.on_connect_error(error_msg)
end

local function on_connecting()
  DISPATCHER.on_connecting()
end

local function on_connected()
  PACK.reset()
  current_chat_server_port = current_chat_server_port_arr[current_server_port_idx]
  local port_str = tostring(current_chat_server_port)
  LAST_SERVER_PORT_STORE:set(port_str)
  DISPATCHER.on_connected()
end

local function on_disconnect()
  M.destroy_heart_beat()
  M.destroy_socket()
  DISPATCHER.on_disconnect()
end

local function on_error(error_msg, error_code)
  chat_log.info(chat_log_util.header(), TAG, "on_error", "socket_connect", {error_msg = error_msg, error_code = error_code}, {})
  M.destroy_heart_beat()
  M.destroy_socket()
  on_server_port_fail()
  DISPATCHER.on_error(error_msg, error_code)
end

local function cmd_rpc_receive(content_data)
  if content_data and content_data.msg then
    return content_data.msg.cmd or ""
  end
  return ""
end

local function log_level_rpc_receive(_content_data)
  return chat_log.LOG_LEVEL.LOW
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

local function rpc_timeout_config(cmd)
  if cmd and "login" == cmd then
    return 10
  else
    return 5
  end
end

local function on_message(pack)
  local ok, header, msg
  ok, header, msg = PACK.unpack_data(pack)
  local content_data = {header = header, msg = msg}
  if should_custom_log_rpc_receive(content_data) then
    custom_log_rpc_receive(content_data)
  else
    local log_level = log_level_rpc_receive(content_data)
    chat_log.rpc_receive(chat_log_util.header(), TAG, log_level, content_data, {})
  end
  if not ok then
    M.destroy_socket()
    local _error_msg = header
    on_error("pack decrypt fail")
    return false
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
    DISPATCHER.handle_message(header, msg)
  end
  return true
end

local destination_rpc_call_handlers_cache = {}

function M.unregister_rpc_call_handlers(destination)
  destination_rpc_call_handlers_cache[destination] = nil
end

function M.register_rpc_call_handlers(destination, rpc_call_handlers)
  M.unregister_rpc_call_handlers(destination)
  destination_rpc_call_handlers_cache[destination] = rpc_call_handlers
end

local function init_server(player_info, token_changed, options)
  local safe_token_changed = token_changed or false
  TRACE_ID = math.random(MAX_ID)
  SEND_ID = math.random(MAX_ID)
  PLAYER_INFO = player_info
  local key = _ejoysdk_crypt.hashkey(tostring(player_info.player_id))
  PLAYER_ID_HASH = _ejoysdk_crypt.hexencode(key)
  server_options = options
  PACK.init(options)
  init_server_port()
  M.run_socket(options)
  if CHAT_SOCKET and safe_token_changed then
    CHAT_SOCKET:reset_400_count()
  end
end

function M.init(player_info, token_changed, options)
  E.LOG.debug(TAG, "chat_connect: chat_server init start")
  options = options or {}
  options.type = "tcp"
  options.encrypt = true
  options.deflate = true
  if _ejoysdk.os() == "weixin" or _ejoysdk.os() == "douyin" then
    options.type = "websocket"
    options.encrypt = false
    options.deflate = false
  end
  xpcall(init_server, function(x)
    E.LOG.debug(TAG, "chat_connect: chat_server init has lua_error")
    local msg = "init_server_error"
    on_connect_error(msg)
    chat_log.warn(chat_log_util.header(), TAG, "init_server_fail", {
      err_code = CONSTANTS.CHAT_ERROR_CODES.CODE_INIT_SERVER_FAIL,
      err_msg = msg,
      lua_error_msg = tostring(x)
    }, {})
  end, player_info, token_changed, options)
end

function M.close()
  M.destroy_socket()
end

function M.run_socket(options)
  M.destroy_socket()
  local ECS, server
  if options.type == "websocket" then
    ECS = require("ejoysdk_lua.chat.ejoysdk_chat_websocket")
    server = M.get_websocket_server()
  else
    ECS = require("ejoysdk_lua.chat.ejoysdk_chat_socket")
    server = M.get_server()
  end
  CHAT_SOCKET = ECS:New(server, {
    on_connect_start = on_connect_start,
    on_connect_error = on_connect_error,
    on_connected = on_connected,
    on_disconnect = on_disconnect,
    on_error = on_error,
    on_message = on_message,
    on_connecting = on_connecting
  })
  CHAT_SOCKET:run()
end

function M.tick()
  if CHAT_SOCKET then
    CHAT_SOCKET:tick()
  end
end

local function trace_id()
  TRACE_ID = (TRACE_ID + 1) % MAX_ID
  return TRACE_ID
end

local function send_id()
  SEND_ID = (SEND_ID + 1) % MAX_ID
  local counter = string.format("%.8d", SEND_ID)
  return tostring(os.time()) .. PLAYER_ID_HASH .. counter
end

M.send_id = send_id

local function get_extra_header()
  local extra_header_list = {}
  if chat_token.curr_login_version == chat_token.LOGIN_V2 then
    local server_version = 1
    table.insert(extra_header_list, string_pack("B", server_version))
    table.insert(extra_header_list, string_pack("B", #PLAYER_INFO.player_id))
    table.insert(extra_header_list, PLAYER_INFO.player_id)
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
    table.insert(extra_header_list, string_pack("B", #PLAYER_INFO.player_id))
    table.insert(extra_header_list, PLAYER_INFO.player_id)
    table.concat(extra_header_list)
  end
  local rpc_header = table.concat(extra_header_list)
  return rpc_header
end

function M.set_heartbeat_options(_options)
  _heartbeat_options = _options
end

function M.get_heartbeat_options()
  return _heartbeat_options
end

function M.reset_global_data()
  _is_first_time_login = true
end

local RPC_ERROR_MSG = {
  SOCKET_NOT_INIT = "socket not init",
  TOKEN_MISS = "token miss",
  SOCKET_NOT_CONNECTED = "socket not connected",
  CALL_RPC_ON_NOT_LOGIN = "call rpc on not login",
  TIME_OUT = "time out"
}

function M.rpc_call(destination, params, cb)
  if not CHAT_SOCKET then
    if cb then
      cb({
        code = -1,
        message = RPC_ERROR_MSG.SOCKET_NOT_INIT
      })
    end
    return
  end
  if not EH.get_player_token_body() then
    chat_log.warn(chat_log_util.header(), TAG, "chat_rpc_call_fail_token_is_nil", {
      code = -1,
      msg = "token_is_nil"
    }, {})
    if cb then
      cb({
        code = -1,
        message = RPC_ERROR_MSG.TOKEN_MISS
      })
    end
    return
  end
  if CHAT_SOCKET:get_status() ~= CHAT_SOCKET.CHAT_CONNECTED then
    chat_log.warn(chat_log_util.header(), TAG, "chat_rpc_call_fail_socket_not_connected", {
      code = -1,
      msg = "socket_not_connected"
    }, {})
    if cb then
      cb({
        code = -1,
        message = RPC_ERROR_MSG.SOCKET_NOT_CONNECTED
      })
    end
    return
  end
  if params.cmd ~= "login" then
    local handlers = destination_rpc_call_handlers_cache[destination]
    if handlers and handlers.on_check_rpc_call_start and not handlers.on_check_rpc_call_start() then
      chat_log.warn(chat_log_util.header(), TAG, "chat_rpc_call_fail_check_rpc_call_start", {
        code = CONSTANTS.CHAT_ERROR_CODES.CODE_NOT_LOGIN,
        msg = "check_rpc_call_start"
      }, {})
      if cb then
        cb({
          code = CONSTANTS.CHAT_ERROR_CODES.CODE_NOT_LOGIN,
          message = RPC_ERROR_MSG.CALL_RPC_ON_NOT_LOGIN
        })
      end
      return
    end
  end
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
  if cb then
    local function cb_wraper(...)
      if opentracing and net_span then
        local info = (...)
        
        rpc_opentracing.RPC.stop_rpc_span(opentracing, net_span, info)
      end
      if CHAT_SOCKET_HEARTBEAT then
        local ret = (...)
        local is_timeout = ret and ret.code == CONSTANTS.RPC_ERROR_CODES.CODE_TIMEOUT
        local rpc_cost = net_span and net_span.get_duration and net_span:get_duration() or -1
        CHAT_SOCKET_HEARTBEAT:on_rpc_result(params.cmd, is_timeout, tostring(session), ret and ret.code, rpc_cost)
      elseif params and params.cmd == "login" then
        local ret = (...)
        local rpc_cost = net_span and net_span.get_duration and net_span:get_duration() or -1
        local ok, m_api_stats = pcall(require, "ejoysdk_lua.apm-sdk-lua.apus")
        if ok and ret and ret.code and m_api_stats and m_api_stats.count_game_rpc_call then
          m_api_stats.count_game_rpc_call("sdk.login", 0 == (ret and ret.code), ret and ret.code, rpc_cost, "ejoysdk.chat")
        end
      end
      cb(...)
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
  local header = {
    codec = "json",
    destination = destination,
    trace = next_trace_id,
    session = session
  }
  if params.cmd == "heartbeat" then
    header.method = "heartbeat"
  end
  if opentracing and net_span then
    rpc_opentracing.RPC.inject_tracing_header(net_span, header)
  end
  local rpc_header = get_extra_header()
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
  local pack = PACK.pack_data(content_data, ejoysdk_pack_data_options)
  CHAT_SOCKET:write(pack)
end

function M.rpc_chat(params, cb)
  M.rpc_call(M.DESTINATION.PLAYER, params, cb)
end

function M.rpc_account_chat(params, cb)
  M.rpc_call(M.DESTINATION.ACCOUNT, params, cb)
end

function M.destroy_heart_beat()
  if CHAT_SOCKET_HEARTBEAT then
    CHAT_SOCKET_HEARTBEAT:destroy()
    CHAT_SOCKET_HEARTBEAT = nil
  end
end

function M.destroy_socket()
  if CHAT_SOCKET then
    CHAT_SOCKET:close()
    CHAT_SOCKET = nil
  end
end

local function on_heartbeat_timeout_reach_max_count_callback(_fail_body)
  M.destroy_heart_beat()
  M.destroy_socket()
  ESTAT.stat_action_apus("chat_reconnect", "heartbeat", 0, {
    _sdk_apus_stats = {
      fail_times = _fail_body and _fail_body.fail_times or 0,
      first_timeout = _fail_body and _fail_body.first_timeout or -1,
      cost = _fail_body and _fail_body.cost or -1
    },
    fail_history = _fail_body and _fail_body.fail_history or {}
  })
  on_error("heartbeat_timeout", CONSTANTS.RPC_ERROR_CODES.CODE_TIMEOUT)
end

function M.login(destination, cb)
  local token
  if chat_token.curr_login_version == chat_token.LOGIN_V2 then
    token = chat_token.get_chat_token()
    E.LOG.debug(TAG, "chat_connect: login use v2")
  else
    token = EH.get_player_token()
    E.LOG.debug(TAG, "chat_connect: login use v1")
  end
  local params = {}
  params.cmd = "login"
  params.token = token
  if PACK.is_support_deflate() and server_options.encrypt then
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
  if destination == M.DESTINATION.ACCOUNT then
    session_key = "account"
  end
  params.login_data.login_session_id = GDP.SESSION_INFO.get(session_key)
  if _is_first_time_login then
    params.login_data.login_type = "first"
  else
    params.login_data.login_type = "reconnect"
  end
  M.destroy_heart_beat()
  M.rpc_call(destination, params, function(ret)
    if 0 == ret.code then
      E.LOG.debug(TAG, "chat_connect: rpc login succ")
      _is_first_time_login = false
      M.destroy_heart_beat()
      if server_options and server_options.type == "websocket" then
        _heartbeat_options = _heartbeat_options or {}
        _heartbeat_options.heartbeat_interval = 25
      end
      CHAT_SOCKET_HEARTBEAT = ECSH:New(CHAT_SOCKET, {on_heartbeat_timeout_reach_max_count = on_heartbeat_timeout_reach_max_count_callback}, _heartbeat_options)
      CHAT_SOCKET_HEARTBEAT:start_heartbeat()
    else
      E.LOG.debug(TAG, "chat_connect: rpc login fail, code=" .. tostring(ret.code))
    end
    if cb then
      cb(ret)
    end
  end)
end

function M.send_msg(destination, msg, session_id, msg_send_id, cb, at_list)
  local params = {}
  params.session_id = session_id
  params.send_id = msg_send_id
  local content = {}
  content.type = "text"
  content.data = msg
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  M.rpc_call(destination, params, cb)
end

function M.send_custom(destination, custom, session_id, cb, at_list)
  local params = {}
  params.session_id = session_id
  params.send_id = send_id()
  local content = {}
  content.type = "client_custom"
  content.data = custom
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  M.rpc_call(destination, params, cb)
end

function M.send_rich_text_msg(destination, text, extend_data, session_id, msg_send_id, cb, at_list)
  local params = {}
  params.session_id = session_id
  params.send_id = msg_send_id
  local content = {}
  content.type = "rich_text"
  content.data = {
    text = text,
    extend_data = extend_data or {}
  }
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  M.rpc_call(destination, params, cb)
end

function M.send_resource_msg(destination, text, res_type, res_id, extend_data, session_id, at_list, msg_send_id, cb)
  local params = {}
  params.session_id = session_id
  params.send_id = msg_send_id
  local content = {}
  content.type = "res"
  content.data = {
    text = text,
    res_type = res_type,
    res_id = res_id,
    extend_data = extend_data or {}
  }
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  M.rpc_call(destination, params, cb)
end

function M.send(destination, session_id, content, at_list, cb)
  local params = {}
  params.session_id = session_id
  params.send_id = send_id()
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  M.rpc_call(destination, params, function(ret)
    ret.send_id = params.send_id
    if cb then
      cb(ret)
    end
  end)
  return params.send_id
end

function M.get_player_latest_at_msgs(destination, cb)
  local params = {}
  params.cmd = "get_player_latest_at_msgs"
  M.rpc_call(destination, params, cb)
end

function M.get_user_group_broker_info(destination, query, cb)
  local params = {}
  params.cmd = "get_user_group_broker_info"
  params.query = query or {}
  M.rpc_call(destination, params, cb)
end

function M.switch_group_id(destination, group_broker_id, group_id, cb)
  local params = {}
  params.cmd = "switch_group_id"
  params.group_broker_id = group_broker_id
  params.group_id = group_id
  M.rpc_call(destination, params, cb)
end

function M.set_receiving_groups(destination, groups, cb)
  local params = {}
  params.cmd = "set_receiving_groups"
  if groups then
    params.groups = groups
  else
    params.groups = JSON.newArray()
  end
  M.rpc_call(destination, params, cb)
end

function M.get_msg(destination, session_id, direction, max_msg_count, ts, cb, msg_id)
  local params = {}
  params.session_id = session_id
  params.search_direction = direction or -1
  params.max_msg_count = max_msg_count or 50
  params.ts = ts
  if msg_id then
    params.msg_id = msg_id
  end
  params.cmd = "get_session_msg"
  M.rpc_call(destination, params, cb)
end

function M.get_msg_by_id(destination, session_id, msg_ids, cb)
  local params = {}
  params.session_id = session_id
  params.msg_ids = msg_ids or {}
  params.cmd = "get_session_msg"
  M.rpc_call(destination, params, cb)
end

function M.set_msg_received(destination, session_id, msg_id, cb)
  local params = {}
  params.session_id = session_id
  params.msg_id = msg_id
  params.cmd = "set_msg_received"
  M.rpc_call(destination, params, cb)
end

function M.delete_msg(destination, session_id, msg_ids, cb)
  local params = {}
  params.session_id = session_id
  params.msg_ids = msg_ids or {}
  params.cmd = "delete_msg"
  M.rpc_call(destination, params, cb)
end

function M.clean_session_msg(destination, session_id, ts, cb)
  local params = {}
  params.session_id = session_id
  if ts then
    params.ts = ts
  end
  params.cmd = "clean_session_msg"
  M.rpc_call(destination, params, cb)
end

function M.get_chat_config(destination, cb)
  local params = {}
  params.cmd = "get_chat_config"
  M.rpc_call(destination, params, cb)
end

function M.set_chat_config(destination, chat_config, cb)
  local params = {}
  local safe_chat_config = chat_config
  local safe_push_config = chat_config.push
  if nil ~= safe_push_config then
    local group_types = safe_push_config.push_on_group_types
    if group_types and nil == next(group_types) then
      group_types = JSON.newArray()
      safe_push_config.push_on_group_types = group_types
      safe_chat_config.push = safe_push_config
      params.ejoysdk_pack_data_options = {encode_empty_array = true}
    end
  end
  params.config = safe_chat_config
  params.cmd = "set_chat_config"
  M.rpc_call(destination, params, cb)
end

function M.set_msg_received_with_ts(destination, session_id, ts, cb)
  local params = {}
  params.session_id = session_id
  if ts then
    params.received_ts = ts
  end
  params.cmd = "set_msg_received"
  M.rpc_call(destination, params, cb)
end

function M.get_latest_session(destination, cb)
  local params = {}
  params.cmd = "get_latest_session"
  M.rpc_call(destination, params, cb)
end

function M.create_group(members, invite_msg, group_name, cb)
  local params = {}
  if 0 == #members then
    table.insert(members, PLAYER_INFO.player_id)
  end
  params.members = members
  params.invite_msg = invite_msg
  local info = {}
  info.name = group_name
  params.info = info
  params.cmd = "create_group"
  M.rpc_chat(params, cb)
end

function M.add_group_member(adds, invite_msg, group_id, cb)
  local params = {}
  params.adds = adds
  params.invite_msg = invite_msg
  params.group_id = group_id
  params.cmd = "add_group_member"
  M.rpc_chat(params, cb)
end

function M.reply_add_group_member(reply_msg, is_agree, group_id, cb, inviter_user_id)
  local params = {}
  params.reply_msg = reply_msg
  params.is_agree = is_agree
  params.group_id = group_id
  if inviter_user_id then
    params.inviter_user_id = inviter_user_id
  end
  params.cmd = "reply_add_group_member"
  M.rpc_chat(params, cb)
end

function M.remove_group_member(removes, remove_msg, group_id, cb)
  local params = {}
  params.removes = removes
  params.message = remove_msg
  params.group_id = group_id
  params.cmd = "remove_group_member"
  M.rpc_chat(params, cb)
end

function M.update_group(info, group_id, cb)
  local params = {}
  params.info = info
  params.group_id = group_id
  params.cmd = "update_group"
  M.rpc_chat(params, cb)
end

function M.delete_group(group_id, cb)
  local params = {}
  params.group_id = group_id
  params.cmd = "delete_group"
  M.rpc_chat(params, cb)
end

function M.exit_group(group_id, cb)
  local params = {}
  params.group_id = group_id
  params.cmd = "exit_group"
  M.rpc_chat(params, cb)
end

function M.get_group_be_invited_history(cb)
  local params = {}
  params.cmd = "get_group_be_invited_history"
  M.rpc_chat(params, cb)
end

function M.set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info, cb)
  local params = {}
  params.cmd = "set_voice_channel_status"
  params.group_id = group_id
  params.channel_status = status
  params.mute = mute_local_value
  if channel_info then
    params.channel_info = channel_info
  end
  if voice_user_id then
    params.voice_user_id = tostring(voice_user_id)
  end
  M.rpc_chat(params, cb)
end

function M.set_voice_channel_mode(group_id, mode, cb)
  local params = {}
  params.cmd = "set_voice_channel_mode"
  params.group_id = group_id
  params.mode = mode
  M.rpc_chat(params, cb)
end

function M.manage_voice_channel_status(group_id, operations, cb)
  local params = {}
  params.cmd = "manage_voice_channel_status"
  params.group_id = group_id
  params.operations = operations or {}
  M.rpc_chat(params, cb)
end

function M.get_agora_channel_token(group_id, versions, cb)
  local params = {}
  if versions then
    params.agora_version = versions
  end
  params.cmd = "get_agora_channel_token"
  params.group_id = group_id
  M.rpc_chat(params, cb)
end

function M.get_player_info(player_id, cb)
  local params = {}
  params.cmd = "get_player_info"
  params.player_id = player_id
  M.rpc_chat(params, cb)
end

function M.get_player_infos(player_ids, cb)
  local params = {}
  params.cmd = "get_player_infos"
  params.player_ids = player_ids
  M.rpc_chat(params, cb)
end

function M.ignore(ignore_data, cb)
  local params = {}
  params.cmd = "ignore"
  if not ignore_data.sessions or 0 == #ignore_data.sessions then
    ignore_data.sessions = JSON.newArray()
    params.ejoysdk_pack_data_options = {encode_empty_array = true}
  end
  if not ignore_data.group_types or 0 == #ignore_data.group_types then
    ignore_data.group_types = JSON.newArray()
    params.ejoysdk_pack_data_options = {encode_empty_array = true}
  end
  params.data = ignore_data
  M.rpc_chat(params, cb)
end

function M.unignore(unignore_data, cb)
  local params = {}
  params.cmd = "unignore"
  if not unignore_data.sessions then
    unignore_data.sessions = JSON.newArray()
    params.ejoysdk_pack_data_options = {encode_empty_array = true}
  end
  if not unignore_data.group_types then
    unignore_data.group_types = JSON.newArray()
    params.ejoysdk_pack_data_options = {encode_empty_array = true}
  end
  params.data = unignore_data
  M.rpc_chat(params, cb)
end

function M.report_msg(report_type_id, report_desc, session_id, msg_id, cb)
  local params = {}
  params.cmd = "report_msg"
  params.report_type_id = report_type_id
  params.report_desc = report_desc
  params.session_id = session_id
  params.msg_id = msg_id
  M.rpc_chat(params, cb)
end

function M.recall_msg(destination, _params, cb)
  local params = _params or {}
  params.cmd = "recall_msg"
  M.rpc_call(destination, params, cb)
end

function M.batch_send(destination, sessions, content, cb)
  local params = {}
  params.sessions = {}
  local send_ids = {}
  for k, v in sessions, nil, nil, nil do
    if type(k) == "string" then
      local new_send_id = send_id()
      params.sessions[k] = v
      v.send_id = new_send_id
      table.insert(send_ids, new_send_id)
    elseif type(k) == "number" and type(v) == "string" then
      local new_send_id = send_id()
      params.sessions[v] = {send_id = new_send_id}
      table.insert(send_ids, new_send_id)
    end
  end
  params.content = content
  params.cmd = "v2/send"
  M.rpc_call(destination, params, function(ret)
    if cb then
      cb(ret)
    end
  end)
  return send_ids
end

function M.get_user_face(destination, params, cb)
  params = params or {}
  params.cmd = "get_user_face"
  M.rpc_call(destination, params, cb)
end

function M.test_chat_server_port()
  init_server_port()
  on_server_port_fail()
  next_server_port()
  on_connected()
  local _last_port_cache = LAST_SERVER_PORT_STORE:get()
end

function M.test_set_need_add_port_idx(_is_need)
  need_add_port_idx = _is_need
end

return M
