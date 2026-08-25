local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local server = require("ejoysdk_lua.chat.ejoysdk_chat_server")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local chat_base = require("ejoysdk_lua.chat.ejoysdk_chat_base")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local CALLBACK_MGR = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local voice = require("ejoysdk_lua.chat.ejoysdk_voice")
local voice_topic = require("ejoysdk_lua.chat.ejoysdk_voice_topic")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_jf = require("ejoysdk_lua.chat.ejoysdk_chat_jf")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local player_log_util = require("ejoysdk_lua.player.player_log_util")
local TAG = EM.MODULE.CHAT .. "chat"
local M = {}
M.re_send_id = {}
local state = STATES.NO_PLAYER_TOKEN
local is_logining = false
local is_login_succ = false
local get_chat_token_process = false
local GET_PLAYER_INFO_FAIL_CODE = -400001
local GET_PLAYER_INFO_FAIL_MESSAGE = "get player info fail"
local AGORA_JF_UPLOAD_NOW = false
ET.subscribe(ET.chat.UPDATE_STATE, function(new_state, login_result_params)
  if new_state == STATES.LOGIN_SUCC or new_state == STATES.LOGIN_FAIL then
    if login_result_params and login_result_params.destination == server.DESTINATION.PLAYER then
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
  chat_log.call_api(chat_log_util.header(), TAG, "get_last_error_msg", chat_log.LOG_LEVEL.LOW, {})
  local res = chat_base.get_last_error_msg()
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "get_last_error_msg", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
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
    return true
  end
  return false
end

function M.init(game_handlers, _auto_login, _retry_times)
  CALLBACK_MGR.register_callback(server.DESTINATION.PLAYER, game_handlers)
  local friend_handlers = CALLBACK_MGR.friend_handlers_pick_from_chat_handlers(game_handlers)
  if friend_handlers and next(friend_handlers) then
    local EF = require("ejoysdk_lua.friend.ejoysdk_friend")
    EF.register_handlers()
    CALLBACK_MGR.register_callback(server.DESTINATION.CLIENT_FRIEND_CHAT, friend_handlers)
  end
  M.real_init()
end

function M.set_heartbeat_options(_options)
  server.set_heartbeat_options(_options)
end

function M.get_heartbeat_options()
  do return end
  return server.get_heartbeat_options, nil
end

local real_init_func_has_invoked = false

function M.real_init()
  if real_init_func_has_invoked then
    return
  end
  real_init_func_has_invoked = true
  DISPATCHER.register_chat_handlers(server.DESTINATION.PLAYER, M.HANDLERS)
  DISPATCHER.register_server_handlers(M.SERVER_HANDLERS)
  local REALTIME_MSG = require("ejoysdk_lua.chat.ejoysdk_realtime_msg")
  REALTIME_MSG.init()
  chat_base.init()
  chat_base.register_server_init_handlers(server.DESTINATION.PLAYER, SERVER_INIT_HANDLERS)
  server.register_rpc_call_handlers(server.DESTINATION.PLAYER, RPC_CALL_HANDLERS)
  ET.subscribe(voice_topic.VOICE_CHANNEL_STATUS_UPDATE, M.set_voice_channel_status)
end

function M.prefer_chat_version(_chat_version)
  if _chat_version > 1 then
    real_init_func_has_invoked = true
  else
    real_init_func_has_invoked = false
  end
end

local has_tick = false

function M.tick()
  has_tick = true
  chat_base.tick()
end

function M.has_tick()
  return has_tick
end

function M.close()
  chat_log.call_api(chat_log_util.header(), TAG, "close", chat_log.LOG_LEVEL.LOW, {})
  chat_base.reset_retry_connect_index()
  ET.publish(ET.chat.UPDATE_STATE, STATES.USER_CLOSE)
  is_login_succ = false
  M.re_send_id = {}
  chat_base.close()
end

M.TYPE_PERSONAL = chat_base.TYPE_PERSONAL
M.TYPE_GROUP = chat_base.TYPE_GROUP
M.TYPE_SYSTEM = chat_base.TYPE_SYSTEM
M.SYSTEM_CHAT_GROUP = chat_base.SYSTEM_CHAT_GROUP
M.SYSTEM_FRIEND = chat_base.SYSTEM_FRIEND
M.SYSTEM_GAME = chat_base.SYSTEM_GAME
local start_with = E.Utils.start_with

function M.get_session_type(session_id)
  do return chat_base.get_session_type end
  return chat_base.get_session_type, session_id
end

function M.personal_session_id(with_player_id)
  chat_log.call_api(chat_log_util.header(), TAG, "personal_session_id", chat_log.LOG_LEVEL.LOW, {}, with_player_id)
  local res = chat_base.personal_session_id(with_player_id)
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "personal_session_id", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.send_text_msg(text, session_id, cb, at_list)
  chat_log.call_api(chat_log_util.header(), TAG, "send_text_msg", chat_log.LOG_LEVEL.HIGH, {}, text, session_id, cb, at_list)
  local send_id = server.send_id()
  M.re_send_id[send_id] = {
    text = text,
    session_id = session_id,
    at_list = at_list
  }
  chat_base.send_text_msg(server.DESTINATION.PLAYER, send_id, text, session_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
        method = "send_text_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_text_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end, at_list)
end

function M.resend_text_msg(send_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "resend_text_msg", chat_log.LOG_LEVEL.HIGH, {}, send_id, cb)
  local data = M.re_send_id[send_id]
  chat_base.resend_text_msg(server.DESTINATION.PLAYER, data, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
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

function M.send_custom(custom, session_id, cb, at_list)
  chat_log.call_api(chat_log_util.header(), TAG, "send_custom", chat_log.LOG_LEVEL.HIGH, {}, custom, session_id, cb, at_list)
  chat_base.send_custom(server.DESTINATION.PLAYER, custom, session_id, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
        method = "send_custom",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_custom", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end, at_list)
end

function M.send_rich_text_msg(text, extend_data, session_id, cb, at_list)
  chat_log.call_api(chat_log_util.header(), TAG, "send_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, text, extend_data, session_id, cb, at_list)
  local send_id = server.send_id()
  M.re_send_id[send_id] = {
    text = text,
    extend_data = extend_data,
    session_id = session_id,
    at_list = at_list
  }
  chat_base.send_rich_text_msg(server.DESTINATION.PLAYER, send_id, text, extend_data, session_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
        method = "send_rich_text_msg",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "send_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end, at_list)
end

function M.resend_rich_text_msg(send_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "resend_rich_text_msg", chat_log.LOG_LEVEL.HIGH, {}, send_id, cb)
  local data = M.re_send_id[send_id]
  chat_base.resend_rich_text_msg(server.DESTINATION.PLAYER, data, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
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
  chat_base.send_resource_msg(server.DESTINATION.PLAYER, text, res_type, res_id, extend_data, session_id, at_list, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
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
  chat_base.resend_resource_msg(server.DESTINATION.PLAYER, data, send_id, function(succ, ...)
    if succ then
      M.re_send_id[send_id] = nil
    else
      local code, msg = ...
      chat_jf.send_msg_fail(server.DESTINATION.PLAYER, {
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

function M.get_player_latest_at_msgs(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_latest_at_msgs", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_player_latest_at_msgs(server.DESTINATION.PLAYER, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_latest_at_msgs", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.get_user_group_broker_info(query, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_user_group_broker_info", chat_log.LOG_LEVEL.HIGH, {}, query, cb)
  chat_base.get_user_group_broker_info(server.DESTINATION.PLAYER, query, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_user_group_broker_info", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.switch_group_id(group_broker_id, group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "switch_group_id", chat_log.LOG_LEVEL.HIGH, {}, group_broker_id, group_id, cb)
  chat_base.switch_group_id(server.DESTINATION.PLAYER, group_broker_id, group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "switch_group_id", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.set_receiving_groups(groups, cb)
  chat_base.set_receiving_groups(server.DESTINATION.PLAYER, groups, function(...)
    if cb then
      cb(...)
    end
  end)
end

function M.set_msg_received(session_id, msg_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_msg_received", chat_log.LOG_LEVEL.LOW, {}, session_id, msg_id, cb)
  chat_base.set_msg_received(server.DESTINATION.PLAYER, session_id, msg_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_msg_received", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.set_msg_received_with_ts(session_id, ts, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_msg_received_with_ts", chat_log.LOG_LEVEL.LOW, {}, session_id, ts, cb)
  chat_base.set_msg_received_with_ts(server.DESTINATION.PLAYER, session_id, ts, function(...)
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

function M.delete_msg(session_id, msg_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "delete_msg", chat_log.LOG_LEVEL.HIGH, {}, session_id, msg_ids, cb)
  chat_base.delete_msg(server.DESTINATION.PLAYER, session_id, msg_ids, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "delete_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.clean_session_msg(session_id, ts, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "clean_session_msg", chat_log.LOG_LEVEL.LOW, {}, session_id, ts, cb)
  chat_base.clean_session_msg(server.DESTINATION.PLAYER, session_id, ts, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "clean_session_msg", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_latest_session(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_latest_session", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_latest_session(server.DESTINATION.PLAYER, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_latest_session_fail(server.DESTINATION.PLAYER, {
        api_version = 1,
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    if succ then
      local sessions = (...)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_latest_session", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, chat_log_util.session_ids(sessions))
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_latest_session", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
    end
  end)
end

function M.get_latest_session_v2(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_latest_session_v2(server.DESTINATION.PLAYER, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_latest_session_fail(server.DESTINATION.PLAYER, {
        api_version = 2,
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    if succ then
      local log_ret = {}
      local result_sessions = (...)
      if result_sessions then
        if result_sessions.personal then
          log_ret.personal = chat_log_util.session_ids(result_sessions.personal)
        end
        if result_sessions.group then
          log_ret.group = chat_log_util.session_ids(result_sessions.group)
        end
        if result_sessions.system then
          log_ret.system = chat_log_util.session_ids(result_sessions.system)
        end
        if result_sessions.other then
          log_ret.other = chat_log_util.session_ids(result_sessions.other)
        end
      end
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, log_ret)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
    end
  end)
end

function M.get_my_groups(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_my_groups", chat_log.LOG_LEVEL.HIGH, {}, cb)
  if not M.is_login_succ() then
    if cb then
      cb(false, CONSTANTS.CHAT_ERROR_CODES.CODE_NOT_LOGIN, "not login chat")
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_my_groups", chat_log.LOG_LEVEL.HIGH, {}, cb, false, CONSTANTS.CHAT_ERROR_CODES.CODE_NOT_LOGIN, "not login chat")
    return
  end
  chat_base.get_my_groups(server.DESTINATION.PLAYER, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_group_fail(server.DESTINATION.PLAYER, {code = code, msg = msg})
    end
    if cb then
      cb(succ, ...)
    end
    if succ then
      local log_groups = {}
      local groups_by_type = (...)
      for _, groups in pairs(groups_by_type) do
        for _, group in pairs(groups) do
          table.insert(log_groups, chat_log_util.simple_group_info(group))
        end
      end
      local log_group_sections = chat_log.list_by_section(log_groups, 3)
      for _, v in pairs(log_group_sections) do
        chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_my_groups", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, v)
      end
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_my_groups", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
    end
  end)
end

function M.get_group(group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_group", chat_log.LOG_LEVEL.LOW, {}, group_id, cb)
  chat_base.get_group(server.DESTINATION.PLAYER, group_id, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local group = (...)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_group", chat_log.LOG_LEVEL.LOW, {}, cb, succ, chat_log_util.simple_group_info(group))
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_group", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_msg(session_id, opt, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_msg", chat_log.LOG_LEVEL.HIGH, {}, session_id, opt, cb)
  chat_base.get_msg(server.DESTINATION.PLAYER, session_id, opt, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_msg_fail(server.DESTINATION.PLAYER, {
        code = code,
        msg = msg,
        session_id = tostring(session_id)
      })
    end
    if cb then
      cb(succ, ...)
    end
    if succ then
      local msgs = (...)
      local log_msgs = chat_log_util.simple_msg_infos(msgs)
      local log_msg_sections = chat_log.list_by_section(log_msgs, 5)
      for _, v in pairs(log_msg_sections) do
        chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, v)
      end
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_msg", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
    end
  end)
end

function M.get_msg_by_id(session_id, msg_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_msg_by_id", chat_log.LOG_LEVEL.HIGH, {}, session_id, msg_ids, cb)
  chat_base.get_msg_by_id(server.DESTINATION.PLAYER, session_id, msg_ids, function(succ, ...)
    if not succ then
      local code, msg = ...
      chat_jf.get_msg_fail(server.DESTINATION.PLAYER, {
        code = code,
        msg = msg,
        type = "get_msg_by_id",
        session_id = tostring(session_id)
      })
    end
    if cb then
      cb(succ, ...)
    end
    if succ then
      local msgs = (...)
      local log_msgs = chat_log_util.simple_msg_infos(msgs)
      local log_msg_sections = chat_log.list_by_section(log_msgs, 5)
      for _, v in pairs(log_msg_sections) do
        chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_msg_by_id", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, v)
      end
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_msg_by_id", chat_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
    end
  end)
end

function M.create_group(members, invite_msg, group_name, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "create_group", chat_log.LOG_LEVEL.HIGH, {}, members, invite_msg, group_name, cb)
  chat_base.create_group(members, invite_msg, group_name, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "create_group", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.add_group_member(adds, invite_msg, group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "add_group_member", chat_log.LOG_LEVEL.HIGH, {}, adds, invite_msg, group_id, cb)
  chat_base.add_group_member(adds, invite_msg, group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "add_group_member", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.reply_add_group_member(reply_msg, is_agree, group_id, inviter_user_id, ext, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "reply_add_group_member", chat_log.LOG_LEVEL.HIGH, {}, reply_msg, is_agree, group_id, cb)
  if type(inviter_user_id) == "function" then
    cb = inviter_user_id
    inviter_user_id = nil
  end
  local _ext = ext or {}
  chat_base.reply_add_group_member(reply_msg, is_agree, group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "reply_add_group_member", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end, inviter_user_id)
end

function M.remove_group_member(removes, remove_msg, group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "remove_group_member", chat_log.LOG_LEVEL.HIGH, {}, removes, remove_msg, group_id, cb)
  chat_base.remove_group_member(removes, remove_msg, group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "remove_group_member", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.update_group(info, group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "update_group", chat_log.LOG_LEVEL.HIGH, {}, info, group_id, cb)
  chat_base.update_group(info, group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "update_group", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.delete_group(group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "delete_group", chat_log.LOG_LEVEL.HIGH, {}, group_id, cb)
  chat_base.delete_group(group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "delete_group", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.exit_group(group_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "exit_group", chat_log.LOG_LEVEL.HIGH, {}, group_id, cb)
  chat_base.exit_group(group_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "exit_group", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.get_group_be_invited_history(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_group_be_invited_history", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_group_be_invited_history(function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_group_be_invited_history", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_voice_channel_status", chat_log.LOG_LEVEL.LOW, {}, group_id, status, mute_local_value, cb)
  chat_base.set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_voice_channel_status", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.set_voice_channel_mode(group_id, mode, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_voice_channel_mode", chat_log.LOG_LEVEL.LOW, {}, group_id, mode, cb)
  chat_base.set_voice_channel_mode(group_id, mode, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_voice_channel_mode", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
    local succ = (...)
    if succ then
      local EG = require("ejoysdk_lua.ejoysdk_gangplank")
      local chat_cache = require("ejoysdk_lua.chat.ejoysdk_chat_cache")
      local agora_vendor = require("ejoysdk_lua.vendors.agora")
      local self_player_id = EG.player_info() and EG.player_info().player_id
      local self_player_name = EG.player_info() and EG.player_info().player_name
      local cached_group = chat_cache.get_group(voice.get_curr_channel_id()) or {}
      local group_type = cached_group.info and cached_group.info.type
      local jf_params = {changetype = mode}
      if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
        jf_params.roleId = self_player_id
      end
      if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
        jf_params.roleName = self_player_name
      end
      jf_params.type = group_type or ""
      jf_params.result = mode
      jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
      jf_params.voice_channel_id = group_id
      ESTAT.stat_bizid("change.mic.online", "0", "0", jf_params)
    end
  end)
end

M.manage_voice_channel_status = chat_base.manage_voice_channel_status

function M.get_player_infos(player_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_infos", chat_log.LOG_LEVEL.LOW, {}, player_ids, cb)
  chat_base.get_player_infos(player_ids, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_infos = (...)
      local log_players = player_log_util.simple_player_infos(player_infos)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_players)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_info(player_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_info", chat_log.LOG_LEVEL.LOW, {}, player_id, cb)
  chat_base.get_player_info(player_id, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_info = (...)
      local log_player = player_log_util.simple_player_info(player_info)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_player)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_infos_default_scene(player_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_infos_default_scene", chat_log.LOG_LEVEL.LOW, {}, player_ids, cb)
  chat_base.get_player_infos_default_scene(player_ids, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_infos = (...)
      local log_players = player_log_util.simple_player_infos(player_infos)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_default_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_players)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_default_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_info_default_scene(player_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_info_default_scene", chat_log.LOG_LEVEL.LOW, {}, player_id, cb)
  chat_base.get_player_info_default_scene(player_id, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_info = (...)
      local log_player = player_log_util.simple_player_info(player_info)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_default_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_player)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_default_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_infos_chat_scene(player_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_infos_chat_scene", chat_log.LOG_LEVEL.LOW, {}, player_ids, cb)
  chat_base.get_player_infos_chat_scene(player_ids, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_infos = (...)
      local log_players = player_log_util.simple_player_infos(player_infos)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_chat_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_players)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_chat_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_info_chat_scene(player_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_info_chat_scene", chat_log.LOG_LEVEL.LOW, {}, player_id, cb)
  chat_base.get_player_info_chat_scene(player_id, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_info = (...)
      local log_player = player_log_util.simple_player_info(player_info)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_chat_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_player)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_chat_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_infos_bbs_scene(player_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_infos_bbs_scene", chat_log.LOG_LEVEL.LOW, {}, player_ids, cb)
  chat_base.get_player_infos_bbs_scene(player_ids, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_infos = (...)
      local log_players = player_log_util.simple_player_infos(player_infos)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_bbs_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_players)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_bbs_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_info_bbs_scene(player_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_info_bbs_scene", chat_log.LOG_LEVEL.LOW, {}, player_id, cb)
  chat_base.get_player_info_bbs_scene(player_id, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_info = (...)
      local log_player = player_log_util.simple_player_info(player_info)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_bbs_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_player)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_bbs_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_infos_friend_scene(player_ids, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_infos_friend_scene", chat_log.LOG_LEVEL.LOW, {}, player_ids, cb)
  chat_base.get_player_infos_friend_scene(player_ids, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_infos = (...)
      local log_players = player_log_util.simple_player_infos(player_infos)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_friend_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_players)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_infos_friend_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.get_player_info_friend_scene(player_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_player_info_friend_scene", chat_log.LOG_LEVEL.LOW, {}, player_id, cb)
  chat_base.get_player_info_friend_scene(player_id, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      local player_info = (...)
      local log_player = player_log_util.simple_player_info(player_info)
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_friend_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, log_player)
    else
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_player_info_friend_scene", chat_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
    end
  end)
end

function M.ignore(ignore_data, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "ignore", chat_log.LOG_LEVEL.HIGH, {}, ignore_data, cb)
  chat_base.ignore(ignore_data, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "ignore", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.ignore_session(session_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "ignore_session", chat_log.LOG_LEVEL.HIGH, {}, session_id, cb)
  chat_base.ignore_session(session_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "ignore_session", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.ignore_group_types(group_type, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "ignore_group_types", chat_log.LOG_LEVEL.HIGH, {}, group_type, cb)
  chat_base.ignore_group_types(group_type, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "ignore_group_types", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.unignore(unignore_data, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "unignore", chat_log.LOG_LEVEL.HIGH, {}, unignore_data, cb)
  chat_base.unignore(unignore_data, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "unignore", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.unignore_session(session_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "unignore_session", chat_log.LOG_LEVEL.HIGH, {}, session_id, cb)
  chat_base.unignore_session(session_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "unignore_session", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.unignore_group_types(group_type, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "unignore_group_types", chat_log.LOG_LEVEL.HIGH, {}, group_type, cb)
  chat_base.unignore_group_types(group_type, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "unignore_group_types", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.report_msg(report_type_id, report_desc, session_id, msg_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "report_msg", chat_log.LOG_LEVEL.LOW, {}, report_type_id, report_desc, session_id, msg_id, cb)
  chat_base.report_msg(report_type_id, report_desc, session_id, msg_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "report_msg", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_ignore_data()
  chat_log.call_api(chat_log_util.header(), TAG, "get_ignore_data", chat_log.LOG_LEVEL.LOW, {})
  local res = chat_base.get_ignore_data()
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "get_ignore_data", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.is_ignore_session(session_id)
  chat_log.call_api(chat_log_util.header(), TAG, "is_ignore_session", chat_log.LOG_LEVEL.LOW, {}, session_id)
  local res = chat_base.is_ignore_session(session_id)
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "is_ignore_session", chat_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.set_global_search_cb(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_global_search_cb", chat_log.LOG_LEVEL.LOW, {}, cb)
  chat_base.set_global_search_cb(cb)
end

function M.global_player_search(search_data, opt, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "global_player_search", chat_log.LOG_LEVEL.LOW, {}, search_data, opt, cb)
  chat_base.global_player_search(search_data, opt, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "global_player_search", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.player_search(search_data, opt, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "player_search", chat_log.LOG_LEVEL.LOW, {}, search_data, opt, cb)
  chat_base.player_search(search_data, opt, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "player_search", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_user_face(_params, cb)
  chat_base.get_user_face(server.DESTINATION.PLAYER, _params, function(...)
    if cb then
      cb(...)
    end
  end)
end

function M.get_friend_with_latest_session(cb)
  M.get_friend_with_latest_session_v2("friend", {}, cb)
end

function M.get_friend_with_latest_session_v2(rtype, ext, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_friend_with_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb)
  chat_base.get_friend_with_latest_session_v2(server.DESTINATION.PLAYER, rtype, ext, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_friend_with_latest_session_v2", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

function M.get_agora_channel_token(group_id, versions, cb)
  chat_base.get_agora_channel_token(group_id, versions, cb)
end

function M.get_chat_config(cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_chat_config", chat_log.LOG_LEVEL.LOW, {}, cb)
  chat_base.get_chat_config(server.DESTINATION.PLAYER, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_chat_config", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.set_chat_config(chat_config, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_chat_config", chat_log.LOG_LEVEL.HIGH, {}, chat_config, cb)
  chat_base.set_chat_config(server.DESTINATION.PLAYER, chat_config, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_chat_config", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
  end)
end

local function invoke_callback(handler_name, ...)
  chat_base.callback_destination(server.DESTINATION.PLAYER, handler_name, ...)
end

local function _invoke_callback_channel(channel, channel_handler_name, ...)
  chat_base.callback_channel(server.DESTINATION.PLAYER, channel, channel_handler_name, ...)
end

local function real_login()
  chat_log.call_api(chat_log_util.header(), TAG, "login", chat_log.LOG_LEVEL.HIGH, {})
  if get_chat_token_process then
    local stat_key = "ejoy_chat_server_rpc_call" .. "_" .. "repeat_login_on_get_chat_token"
    ESTAT.stat_error_with_limit("ejoysdk_chat", stat_key, "ejoy_chat_server_rpc_call", "chat_err_repeat_login_on_get_chat_token", {})
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, CONSTANTS.CHAT_ERROR_CODES.CODE_REPEAT_LOGIN_ON_GET_CHAT_TOKEN, "repeat login when get chat token")
    return
  end
  if is_login_succ then
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, CONSTANTS.CHAT_ERROR_CODES.CODE_REPEAT_LOGIN_ON_LOGIN_SUCC, "repeat login when login succ")
    chat_log.info(chat_log_util.header(), TAG, "repeat_login_on_login_succ", "chat_login", {})
    return
  end
  chat_base.retry_connect()
end

local function re_login_on_fail()
  E.LOG.debug(TAG, "chat_connect: re_login_on_fail start")
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local ejoy_token = EG.user_info().token
  local holo = require("ejoysdk_lua.ejoysdk_holo")
  local token = holo.get_player_token()
  local expire_time = (holo.get_player_token_body() or {}).expire_time or 0
  if not (ejoy_token and 0 ~= #ejoy_token and token) or 0 == #token or expire_time < E.time() then
    ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
    return
  end
  chat_base.retry_connect()
end

local function on_login(ret)
  local log_ret_code
  if ret and ret.code then
    log_ret_code = ret.code
  end
  local login_result_params = {
    destination = server.DESTINATION.PLAYER
  }
  local _orig_ret = utils.deepcopy(ret)
  if 0 == ret.code then
    E.LOG.debug(TAG, "chat_connect: check_groups_with_login_result start")
    chat_base.check_groups_with_login_result(server.DESTINATION.PLAYER, ret, function(succ, ...)
      if succ then
        E.LOG.debug(TAG, "chat_connect: check_groups_with_login_result succ")
        is_login_succ = true
        ET.publish(ET.chat.UPDATE_STATE, STATES.LOGIN_SUCC, login_result_params)
        if ret and (not ret.groups or ret.groups and 0 == #ret.groups) then
          chat_jf.login_result_group_empty({ret_code = log_ret_code})
        end
        chat_base.reset_retry_connect_index()
        E.LOG.debug(TAG, "chat_connect: callback on_login succ =====================end")
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, true, {
          groups = ret.groups,
          ignore_data = ret.ignore_data,
          receiving_groups = ret.receiving_groups,
          privilege = ret.privilege
        })
        if voice.get_curr_channel_id() then
          M.set_voice_channel_status(voice.get_curr_channel_id(), voice.get_voice_status(), voice.get_mute_local_value(), voice.get_curr_voice_user_id())
        end
        chat_jf.login_succ({})
      else
        E.LOG.debug(TAG, "chat_connect: check_groups_with_login_result fail")
        is_login_succ = false
        ET.publish(ET.chat.UPDATE_STATE, STATES.LOGIN_FAIL, login_result_params)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
        chat_jf.login_fail(chat_jf.ACTION.LOGIN_FAIL_CAUSE_BY_CHECK_GROUPS, {ret_code = log_ret_code})
        re_login_on_fail()
      end
    end)
    chat_base.get_common_scene()
  else
    is_login_succ = false
    ET.publish(ET.chat.UPDATE_STATE, STATES.LOGIN_FAIL, login_result_params)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.ON_LOGIN, false, ret.code, ret.message or "")
    chat_jf.login_fail(chat_jf.ACTION.LOGIN_FAIL_CAUSE_BY_RPC, {ret_code = log_ret_code})
    re_login_on_fail()
  end
end

function M.login()
  if chat_base.auto_login() then
    return
  end
  real_login()
end

function M.logout()
  chat_log.call_api(chat_log_util.header(), TAG, "logout", chat_log.LOG_LEVEL.HIGH, {})
  is_login_succ = false
  chat_base.logout()
end

local SERVER_HANDLERS = {}
M.SERVER_HANDLERS = SERVER_HANDLERS

function SERVER_HANDLERS.on_connect_start()
end

function SERVER_HANDLERS.on_connect_error(_error_msg)
  is_login_succ = false
end

function SERVER_HANDLERS.on_connecting()
end

function SERVER_HANDLERS.on_connected()
  if is_logining then
    E.LOG.debug(TAG, "is_logining and return")
    return
  end
  is_logining = true
  chat_base.login(server.DESTINATION.PLAYER, function(...)
    is_logining = false
    on_login(...)
  end)
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

local INFO_MSG = {}
M.INFO_MSG = INFO_MSG

function INFO_MSG.chat_msg(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_CHAT_MSG, msgs)
end

function INFO_MSG.personal_msg(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_PERSONAL_MSG, msgs)
end

function INFO_MSG.group_msg(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_GROUP_MSG, msgs)
end

function INFO_MSG.chat_group(msgs)
  chat_base.fill_chat_group_invite_msgs(msgs, function(succ, ...)
    if succ then
      local invite_msgs = (...)
      invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_GROUP_INVITED, invite_msgs)
    end
  end)
end

function INFO_MSG.system_chat(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_SYSTEM_CHAT, msgs)
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

function INFO_MSG.gangplank(msgs)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_GANGPLANK_MSG, msgs)
end

function INFO_MSG.group(groups)
  for _, group in pairs(groups) do
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_UPDATE_GROUP, group)
  end
end

local CHAT_HANDLERS = {}
local SEARCH_HANDLERS = {}

function M.HANDLERS(header, msg)
  local method = header.method
  if not method then
    DISPATCHER.dispatch_chat_msg(msg, CHAT_HANDLERS)
    return
  end
  if start_with(method, "search") then
    DISPATCHER.dispatch_search_msg(msg, SEARCH_HANDLERS, method)
  end
end

function CHAT_HANDLERS.on_unhandle(msg)
end

function CHAT_HANDLERS.info_msg(ret)
  local msgs = ret.msgs
  chat_base.process_info_msg(msgs, function(result)
    if result.chat_group and #result.chat_group > 0 then
      INFO_MSG.chat_group(result.chat_group)
    end
    if result.system_chat and #result.system_chat > 0 then
      INFO_MSG.system_chat(result.system_chat)
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
    if result.gangplank and #result.gangplank > 0 then
      INFO_MSG.gangplank(result.gangplank)
    end
    if result.group and #result.group > 0 then
      INFO_MSG.group(result.group)
    end
  end)
end

function CHAT_HANDLERS.info_offline(msg)
  chat_base.reset_retry_connect_index()
  ET.publish(ET.chat.UPDATE_STATE, STATES.SERVER_OFFLINE)
  is_login_succ = false
  chat_base.close()
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_OFFLINE, msg.type, msg.msg or "")
end

function CHAT_HANDLERS.info_create_group(msg)
  chat_base.process_create_group_msg(server.DESTINATION.PLAYER, msg, function(replace_group)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_CREATE_GROUP, replace_group)
  end)
end

function CHAT_HANDLERS.info_add_invited_member(msg)
  chat_base.replace_array_player_before_cb(msg.add_invited_member_infos, function(replace_array)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_ADD_INVITED_MEMBER, msg.group_id, {add_invited_member_infos = replace_array})
  end)
end

function CHAT_HANDLERS.info_add_group_member(msg)
  chat_base.replace_array_player_before_cb(msg.add_member_infos, function(replace_array)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_ADD_GROUP_MEMBER, msg.group_id, {add_member_infos = replace_array})
  end)
end

function CHAT_HANDLERS.info_delete_group(msg)
  chat_base.process_delete_group(server.DESTINATION.PLAYER, msg)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_DELETE_GROUP, msg.group_id, {
    reason = msg.reason,
    message = msg.message or ""
  })
end

function CHAT_HANDLERS.info_update_group(msg)
  chat_base.process_update_group(msg, function(replace_group)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_UPDATE_GROUP, replace_group)
  end)
end

function CHAT_HANDLERS.info_voice_channel_user_change(msg)
  chat_base.process_voice_channel_user_change(msg, function(...)
    local change_info = msg or {}
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_VOICE_CHANNEL_USER_CHANGE, change_info)
  end)
end

function CHAT_HANDLERS.info_remove_group_member(msg)
  local _remove_type = msg.remove_type
  chat_base.process_remove_group_member(msg, function(...)
    invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_REMOVE_GROUP_MEMBER, msg.group_id, {
      removes = msg.removes,
      remove_type = msg.remove_type,
      message = msg.message or ""
    })
  end)
end

function CHAT_HANDLERS.info_update_session(msg)
  invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_UPDATE_SESSION, msg)
end

function SEARCH_HANDLERS.global_search_resp(data)
  chat_base.handle_global_search_resp(data)
end

function M.retry_connect()
  chat_base.retry_connect()
end

return M
