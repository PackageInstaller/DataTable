local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local server = require("ejoysdk_lua.chat.ejoysdk_chat_server")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local chat_base = require("ejoysdk_lua.chat.ejoysdk_chat_base")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local CALLBACK_MGR = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local ejoysdk_player_info = require("ejoysdk_lua.player.player_info")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local chat_jf = require("ejoysdk_lua.chat.ejoysdk_chat_jf")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local TAG = EM.MODULE.CHAT .. "chat_account"
local M = {}
M.re_send_id = {}
local last_error_msg = ""
local state = STATES.NO_PLAYER_TOKEN
local is_login_succ = false
local get_chat_token_process = false
local login_process_start_time = 0
ET.subscribe(ET.chat.UPDATE_STATE, function(new_state, login_result_params)
  if new_state == STATES.LOGIN_SUCC or new_state == STATES.LOGIN_FAIL then
    if login_result_params and login_result_params.destination == server.DESTINATION.ACCOUNT then
      state = new_state
    end
  else
    state = new_state
  end
end)

function M.get_status()
  chat_log.call_api(chat_log_util.header(), TAG, "get_status", chat_log.LOG_LEVEL.LOW, {})
  local res = state
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "get_status", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.is_login_succ()
  chat_log.call_api(chat_log_util.header(), TAG, "is_login_succ", chat_log.LOG_LEVEL.LOW, {})
  local res = is_login_succ
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "is_login_succ", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_last_error_msg()
  local res = last_error_msg
  return res
end

local TYPE_PERSONAL = "personal"
local TYPE_GROUP = "group"
local TYPE_SYSTEM = "system"
local SYSTEM_CHAT_GROUP = "chat_group"
local SYSTEM_FRIEND = "friend"
local SYSTEM_GAME = "game"
M.TYPE_PERSONAL = TYPE_PERSONAL
M.TYPE_GROUP = TYPE_GROUP
M.TYPE_SYSTEM = TYPE_SYSTEM
M.SYSTEM_CHAT_GROUP = SYSTEM_CHAT_GROUP
M.SYSTEM_FRIEND = SYSTEM_FRIEND
M.SYSTEM_GAME = SYSTEM_GAME

function M.get_session_type(session_id)
  local res = chat_base.get_session_type(session_id)
  return res
end

function M.personal_session_id(with_user_id)
  chat_log.call_api(chat_log_util.header(), TAG, "personal_session_id", chat_log.LOG_LEVEL.LOW, {}, with_user_id)
  assert(with_user_id, "with_user_id is nil!")
  local user_info = EG.user_info()
  if not user_info or user_info.uid == "" or user_info.uid == nil then
    return ""
  end
  local my_chat_user_id = ejoysdk_player_info.USER_ID_PREFIX_ACCOUNT .. user_info.uid
  local session_id
  if with_user_id < my_chat_user_id then
    session_id = with_user_id .. ":" .. my_chat_user_id
  else
    session_id = my_chat_user_id .. ":" .. with_user_id
  end
  local res = session_id
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "personal_session_id", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.async_personal_session_id(with_user_id, cb)
  local session_id = M.personal_session_id(with_user_id)
  cb(session_id)
end

function M.send_text_msg(text, session_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "send_text_msg", chat_log.LOG_LEVEL.HIGH, {}, text, session_id, cb)
  local send_id = server.send_id()
  M.re_send_id[send_id] = {text = text, session_id = session_id}
  chat_base.send_text_msg(server.DESTINATION.ACCOUNT, send_id, text, session_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "send_text_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_text_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end, nil)
end

function M.resend_text_msg(send_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "resend_text_msg", chat_log.LOG_LEVEL.HIGH, {}, send_id, cb)
  local data = M.re_send_id[send_id]
  chat_base.resend_text_msg(server.DESTINATION.ACCOUNT, data, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "resend_text_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "resend_text_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.send_custom(custom, session_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "send_custom", chat_log.LOG_LEVEL.HIGH, {}, custom, session_id, cb)
  chat_base.send_custom(server.DESTINATION.ACCOUNT, custom, session_id, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "send_custom",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_custom", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end, nil)
end

function M.send_rich_text_msg(text, extend_data, session_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "send_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, text, extend_data, session_id, cb)
  local send_id = server.send_id()
  M.re_send_id[send_id] = {
    text = text,
    extend_data = extend_data,
    session_id = session_id
  }
  chat_base.send_rich_text_msg(server.DESTINATION.ACCOUNT, send_id, text, extend_data, session_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "send_rich_text_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end, nil)
end

function M.resend_rich_text_msg(send_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "resend_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, send_id, cb)
  local data = M.re_send_id[send_id]
  chat_base.resend_rich_text_msg(server.DESTINATION.ACCOUNT, data, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "resend_rich_text_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "resend_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.send_resource_msg(text, res_type, res_id, extend_data, session_id, at_list, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "send_resource_msg", chat_log.LOG_LEVEL.HIGH, {}, text, res_type, res_id, extend_data, session_id, at_list, cb)
  local send_id = server.send_id()
  M.re_send_id[send_id] = {
    text = text,
    res_type = res_type,
    res_id = res_id,
    extend_data = extend_data,
    session_id = session_id,
    at_list = at_list
  }
  chat_base.send_resource_msg(server.DESTINATION.ACCOUNT, text, res_type, res_id, extend_data, session_id, at_list, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "send_resource_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_resource_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.resend_resource_msg(send_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "resend_resource_msg", chat_log.LOG_LEVEL.HIGH, {}, send_id, cb)
  local data = M.re_send_id[send_id]
  chat_base.resend_resource_msg(server.DESTINATION.ACCOUNT, data, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.ACCOUNT, {
        method = "resend_resource_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "resend_resource_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.set_msg_received(session_id, msg_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_msg_received", chat_log.LOG_LEVEL.LOW, {}, session_id, msg_id, cb)
  chat_base.set_msg_received(server.DESTINATION.ACCOUNT, session_id, msg_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_msg_received", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.set_msg_received_with_ts(session_id, ts, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_msg_received_with_ts", chat_log.LOG_LEVEL.LOW, {}, session_id, ts, cb)
  chat_base.set_msg_received_with_ts(server.DESTINATION.ACCOUNT, session_id, ts, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_msg_received_with_ts", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.set_msg_received_with_opts(opts, cb)
  opts = opts or {}
  M.set_msg_received_with_ts(opts.session_id, opts.ts, cb)
end

function M.get_latest_session(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_latest_session", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_latest_session(server.DESTINATION.ACCOUNT, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_latest_session_fail(server.DESTINATION.ACCOUNT, {
        api_version = 2,
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_latest_session", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.set_session_attrs(session_attrs)
  do return chat_base.set_session_attrs, server.DESTINATION.ACCOUNT end
  return chat_base.set_session_attrs, server.DESTINATION.ACCOUNT, session_attrs
end

function M.get_latest_session_v2(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_latest_session_v2(server.DESTINATION.ACCOUNT, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_latest_session_fail(server.DESTINATION.ACCOUNT, {
        api_version = 2,
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.get_msg(session_id, opt, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_msg", chat_log.LOG_LEVEL.LOW, {}, session_id, opt, cb)
  chat_base.get_msg(server.DESTINATION.ACCOUNT, session_id, opt, function(...)
    local succ, code, msg = ...
    if not succ then
      chat_jf.get_msg_fail(server.DESTINATION.ACCOUNT, {
        code = code,
        msg = msg,
        session_id = tostring(session_id)
      })
    end
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_msg", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_msg_by_id(session_id, msg_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_msg_by_id", chat_log.LOG_LEVEL.HIGH, {}, session_id, msg_ids, cb)
  chat_base.get_msg_by_id(server.DESTINATION.ACCOUNT, session_id, msg_ids, function(...)
    local succ, code, msg = ...
    if not succ then
      chat_jf.get_msg_fail(server.DESTINATION.ACCOUNT, {
        code = code,
        msg = msg,
        type = "get_msg_by_id",
        session_id = tostring(session_id)
      })
    end
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_msg_by_id", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_chat_config(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_chat_config", chat_log.LOG_LEVEL.LOW, {}, cb)
  chat_base.get_chat_config(server.DESTINATION.ACCOUNT, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_chat_config", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.set_chat_config(chat_config, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_chat_config", chat_log.LOG_LEVEL.HIGH, {}, chat_config, cb)
  chat_base.set_chat_config(server.DESTINATION.ACCOUNT, chat_config, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_chat_config", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

local function invoke_callback(handler_name, ...)
  chat_base.callback_destination(server.DESTINATION.ACCOUNT, handler_name, ...)
end

local function _invoke_callback_channel(channel, channel_handler_name, ...)
  chat_base.callback_channel(server.DESTINATION.ACCOUNT, channel, channel_handler_name, ...)
end

local function on_login(ret)
  local login_result_params = {
    destination = server.DESTINATION.ACCOUNT
  }
  if 0 == ret.code then
    is_login_succ = true
    login_process_start_time = 0
    ET.publish(ET.chat.UPDATE_STATE, STATES.LOGIN_SUCC, login_result_params)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, true, {})
    chat_log.info(chat_log_util.header(), TAG, "chat_login_succ_account", "on_login_callback", {})
  else
    is_login_succ = false
    login_process_start_time = 0
    ET.publish(ET.chat.UPDATE_STATE, STATES.LOGIN_FAIL, login_result_params)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, ret.code, ret.message or "")
    chat_log.warn(chat_log_util.header(), TAG, "chat_login_fail_account", "on_login_callback", {})
  end
end

local function call_chat_base_login()
  if get_chat_token_process then
    local stat_key = "ejoy_chat_server_rpc_call" .. "_" .. "repeat_login_on_get_chat_token"
    ESTAT.stat_error_with_limit("ejoysdk_chat_account", stat_key, "ejoy_chat_server_rpc_call", "repeat_login_on_get_chat_token", {})
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, CONSTANTS.CHAT_ERROR_CODES.CODE_REPEAT_LOGIN_ON_GET_CHAT_TOKEN, "repeat login when get chat token")
    return
  end
  if is_login_succ then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, CONSTANTS.CHAT_ERROR_CODES.CODE_REPEAT_LOGIN_ON_LOGIN_SUCC, "repeat login when login succ")
    return
  end
  if os.time() - login_process_start_time < 3 then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, CONSTANTS.CHAT_ERROR_CODES.CODE_REPEAT_LOGIN_ON_LOGIN_PROCESS, "repeat login when login process")
    return
  end
  login_process_start_time = os.time()
  chat_base.login(server.DESTINATION.ACCOUNT, on_login)
end

function M.login()
  chat_log.call_api(chat_log_util.header(), TAG, "login", chat_log.LOG_LEVEL.HIGH, {})
  call_chat_base_login()
end

function M.logout()
end

local INFO_MSG = {}
M.INFO_MSG = INFO_MSG

function INFO_MSG.chat_msg(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_CHAT_MSG, msgs)
end

function INFO_MSG.personal_msg(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_PERSONAL_MSG, msgs)
end

function INFO_MSG.friend(msgs)
  local result = chat_base.process_friend_msgs(msgs)
  if #result.friend_del_msgs > 0 then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_DEL, result.friend_del_msgs)
  end
  if #result.friend_add_msgs > 0 then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_ADD, result.friend_add_msgs)
  end
  if #result.friend_apply_msgs > 0 then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_APPLY, result.friend_apply_msgs)
  end
  if #result.friend_info_change_msgs > 0 then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_INFO_CHANGE, result.friend_info_change_msgs)
  end
end

function INFO_MSG.system(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_SYSTEM_MSG, msgs)
end

local CHAT_HANDLERS = {}

function M.HANDLERS(header, msg)
  local method = header.method
  if not method then
    DISPATCHER.dispatch_chat_msg(msg, CHAT_HANDLERS)
  end
end

function CHAT_HANDLERS.on_unhandle(msg)
end

function CHAT_HANDLERS.info_msg(ret)
  chat_log.debug(chat_log_util.header(), TAG, "receive_info_msg", "receive_info_msg", {ret = ret}, {})
  local msgs = ret.msgs
  chat_base.process_info_msg(msgs, function(result)
    if result.chat_group and #result.chat_group > 0 then
      INFO_MSG.chat_group(result.chat_group)
    end
    if result.friend and #result.friend > 0 then
      INFO_MSG.friend(result.friend)
    end
    if result.system and #result.system > 0 then
      INFO_MSG.system(result.system)
    end
    if result.chat_msg and #result.chat_msg > 0 then
      INFO_MSG.chat_msg(result.chat_msg)
    end
    if result.personal_msg and #result.personal_msg > 0 then
      INFO_MSG.personal_msg(result.personal_msg)
    end
    if result.group_msg and #result.group_msg > 0 then
      INFO_MSG.group_msg(result.group_msg)
    end
  end)
end

function CHAT_HANDLERS.info_offline(msg)
  is_login_succ = false
  login_process_start_time = 0
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_OFFLINE, msg.type, msg.msg or "")
end

function CHAT_HANDLERS.info_update_session(msg)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_UPDATE_SESSION, msg)
end

local SERVER_HANDLERS = {}
M.SERVER_HANDLERS = SERVER_HANDLERS
local should_open = false

local function on_open_chat_account()
  chat_log.info(chat_log_util.header(), TAG, "listen_account_chat_open", "account_chat_login", {should_open = should_open}, {})
  if not should_open then
    should_open = true
    call_chat_base_login()
  end
end

local function on_customer_changed()
  local CHAT_TOKEN = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
  CHAT_TOKEN.refresh_chat_token(function(succ)
    if succ then
      on_open_chat_account()
    end
  end)
end

local function on_account_logout()
  should_open = false
  is_login_succ = false
  login_process_start_time = 0
end

function M.open(_open)
  chat_log.call_api(chat_log_util.header(), TAG, "open", chat_log.LOG_LEVEL.HIGH, {}, _open)
  if not should_open then
    should_open = true
    call_chat_base_login()
  end
end

function SERVER_HANDLERS.on_connect_error(_error_msg)
  is_login_succ = false
end

function SERVER_HANDLERS.on_connected()
  if should_open then
    call_chat_base_login()
  end
  ET.subscribe(ET.gangplank.LOGOUT, on_account_logout)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, on_account_logout)
end

function SERVER_HANDLERS.on_disconnect()
  is_login_succ = false
end

function SERVER_HANDLERS.on_connect_lost()
  is_login_succ = false
end

function SERVER_HANDLERS.on_error(_error_msg)
  is_login_succ = false
end

local SERVER_INIT_HANDLERS = {}
M.SERVER_INIT_HANDLERS = SERVER_INIT_HANDLERS

function SERVER_INIT_HANDLERS.on_server_init_start()
  is_login_succ = false
end

function SERVER_INIT_HANDLERS.get_chat_token_start()
  E.LOG.debug(TAG, "exec get_chat_token_start")
  get_chat_token_process = true
end

function SERVER_INIT_HANDLERS.get_chat_token_end()
  E.LOG.debug(TAG, "exec get_chat_token_end")
  get_chat_token_process = false
end

local RPC_CALL_HANDLERS = {}
M.RPC_CALL_HANDLERS = RPC_CALL_HANDLERS

function RPC_CALL_HANDLERS.on_check_rpc_call_start()
  if is_login_succ then
    E.LOG.debug(TAG, "exec on_check_rpc_call_start succ")
    return true
  end
  return false
end

function M.init(game_handlers)
  chat_log.call_api(chat_log_util.header(), TAG, "init", chat_log.LOG_LEVEL.HIGH, {}, game_handlers)
  CALLBACK_MGR.register_callback(server.DESTINATION.ACCOUNT, game_handlers)
  local friend_handlers = CALLBACK_MGR.friend_handlers_pick_from_chat_handlers(game_handlers)
  if friend_handlers and next(friend_handlers) then
    local EF = require("ejoysdk_lua.friend.ejoysdk_friend")
    EF.register_handlers()
    CALLBACK_MGR.register_callback(server.DESTINATION.CLIENT_FRIEND_CHAT_ACCOUNT, friend_handlers)
  end
  DISPATCHER.register_chat_handlers(server.DESTINATION.ACCOUNT, M.HANDLERS)
  DISPATCHER.register_server_handlers(M.SERVER_HANDLERS)
  ET.subscribe(ET.account_chat.OPEN, on_open_chat_account)
  ET.subscribe(ET.account_chat.CUSTOMER_CHANGED, on_customer_changed)
  chat_base.register_server_init_handlers(server.DESTINATION.ACCOUNT, SERVER_INIT_HANDLERS)
  server.register_rpc_call_handlers(server.DESTINATION.ACCOUNT, RPC_CALL_HANDLERS)
end

return M
