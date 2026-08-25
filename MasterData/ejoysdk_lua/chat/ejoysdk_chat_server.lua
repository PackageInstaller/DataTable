local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local _string_pack, _string_unpack, xpcall = compat.string.pack, compat.string.unpack, compat.xpcall
local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local chat_jf = require("ejoysdk_lua.chat.ejoysdk_chat_jf")
local SESSION_MGR = require("ejoysdk_lua.chat.ejoysdk_chat_session_manager")
local CS = require("ejoysdk_lua.chat.ejoysdk_chat_socket")
local TAG = EM.MODULE.CHAT .. "server"
local LAST_SERVER_PORT_STORE = E.LazyKeyStore:New("CHAT_SERVER_LAST_PORT_NUM", false, false, false)
local M = {}
local DEFAULT_SERVER_PORTS = {
  12345,
  443,
  80
}
local current_chat_server_port = 0
local current_chat_server_port_arr = DEFAULT_SERVER_PORTS
local current_server_port_idx = 1
local need_add_port_idx = false

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
  do return end
  return SESSION_MGR.get_status, nil
end

function M.get_curr_socket_server()
  return SESSION_MGR.get_curr_socket_server() or {}
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

M.DESTINATION = DISPATCHER.DESTINATION
local PLAYER_INFO
local MAX_ID = 10000000
local SEND_ID = 0
local PLAYER_ID_HASH = ""

local function on_connect_start()
  DISPATCHER.on_connect_start()
end

local function on_connect_error(error_msg, error_code)
  chat_jf.connect_fail({
    err_msg = error_msg or "nil",
    err_code = error_code or -1
  })
  M.destroy_heart_beat()
  M.destroy_socket(error_code)
  on_server_port_fail()
  DISPATCHER.on_connect_error(error_msg)
end

local function on_connecting()
  DISPATCHER.on_connecting()
end

local function on_connected()
  current_chat_server_port = current_chat_server_port_arr[current_server_port_idx]
  local port_str = tostring(current_chat_server_port)
  LAST_SERVER_PORT_STORE:set(port_str)
  DISPATCHER.on_connected()
end

local function on_disconnect(code)
  M.destroy_heart_beat()
  M.destroy_socket(code)
  DISPATCHER.on_disconnect()
end

local function on_error(error_msg, error_code)
  chat_log.info(chat_log_util.header(), TAG, "on_error", "socket_connect", {error_msg = error_msg, error_code = error_code}, {})
  M.destroy_heart_beat()
  M.destroy_socket(error_code)
  on_server_port_fail()
  DISPATCHER.on_error(error_msg, error_code)
end

local function on_message(header, msg)
  DISPATCHER.handle_message(header, msg)
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
  SEND_ID = math.random(MAX_ID)
  PLAYER_INFO = player_info
  local key = _ejoysdk_crypt.hashkey(tostring(player_info.player_id))
  PLAYER_ID_HASH = _ejoysdk_crypt.hexencode(key)
  SESSION_MGR.set_listeners({
    on_connect_start = on_connect_start,
    on_connect_error = on_connect_error,
    on_connected = on_connected,
    on_disconnect = on_disconnect,
    on_error = on_error,
    on_message = on_message,
    on_connecting = on_connecting
  })
  init_server_port()
  M.run_socket(options)
  if safe_token_changed then
    SESSION_MGR.reset_400_count()
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

function M.close(code)
  M.destroy_socket(code)
end

function M.run_socket(options)
  M.destroy_socket(CONSTANTS.CHAT_ERROR_CODES.CODE_RERUN_SOCKET)
  local server
  if options.type == "websocket" then
    server = M.get_websocket_server()
  else
    server = M.get_server()
  end
  SESSION_MGR.run(options.type, server, options)
end

function M.tick()
  SESSION_MGR.tick()
end

local function send_id()
  SEND_ID = (SEND_ID + 1) % MAX_ID
  local counter = string.format("%.8d", SEND_ID)
  return tostring(os.time()) .. PLAYER_ID_HASH .. counter
end

M.send_id = send_id

function M.set_heartbeat_options(_options)
  SESSION_MGR.set_heartbeat_options(_options)
end

function M.get_heartbeat_options()
  do return end
  return SESSION_MGR.get_heartbeat_options, nil
end

function M.reset_global_data()
  SESSION_MGR.reset_global_data()
end

local RPC_ERROR_MSG = {
  SOCKET_NOT_INIT = "socket not init",
  TOKEN_MISS = "token miss",
  SOCKET_NOT_CONNECTED = "socket not connected",
  CALL_RPC_ON_NOT_LOGIN = "call rpc on not login",
  TIME_OUT = "time out"
}

function M.rpc_call(destination, params, cb)
  if not SESSION_MGR.has_running_session() then
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
  if SESSION_MGR.get_status() ~= CS.CHAT_CONNECTED then
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
  SESSION_MGR.rpc_call(destination, params, cb)
end

function M.rpc_chat(params, cb)
  M.rpc_call(M.DESTINATION.PLAYER, params, cb)
end

function M.rpc_account_chat(params, cb)
  M.rpc_call(M.DESTINATION.ACCOUNT, params, cb)
end

function M.destroy_heart_beat()
  SESSION_MGR.destroy_heart_beat()
end

function M.destroy_socket(code)
  SESSION_MGR.close(code)
end

function M.login(destination, cb)
  SESSION_MGR.login(destination, cb)
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

function M.set_session_attrs(destination, session_attrs, cb)
  E.LOG.debug(TAG, "set_session_attrs received")
  E.log(session_attrs)
  local params = {}
  params.cmd = "set_session_attrs"
  params.session_attrs = session_attrs
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

function M.voice_channel_heartbeat(channel_id, mic_volume, channel_info, cb)
  local params = {}
  params.cmd = "voice_channel_heartbeat"
  params.group_id = channel_id
  params.mic_volume = mic_volume
  params.channel_info = channel_info
  M.rpc_chat(params, cb)
end

return M
