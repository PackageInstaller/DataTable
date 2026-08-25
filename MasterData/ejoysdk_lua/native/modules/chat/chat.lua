local E = require("ejoysdk_lua.ejoysdk")
local sdk_chat_model_cls = require("ejoysdk_lua.chat.export.ejoysdk_chat_model")
local chat_handler_cls = require("ejoysdk_lua.native.modules.chat.chat_handler")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local TAG = "native.chat"
local M = {}
local SIGNGLE_INSTANCE = {
  sdk_chat_model = nil,
  sdk_acc_chat_model = nil,
  chat_handler = nil,
  acc_chat_handler = nil
}
local chat_v2_handlers, _add_options

function M.regenerate_chat_model(_force)
  if _force then
    M.destroy()
  end
  E.LOG.d(TAG, "native chat v2 regenerate_chat_model")
  if not SIGNGLE_INSTANCE.sdk_chat_model then
    SIGNGLE_INSTANCE.chat_handler = chat_handler_cls:New(chat_v2_handlers)
    SIGNGLE_INSTANCE.sdk_chat_model = sdk_chat_model_cls:New(SIGNGLE_INSTANCE.chat_handler, {
      sync_blank_group_sessions = true,
      sync_blank_system_session = true,
      filter_sys_msg_group_types = {
        "client_group"
      },
      old_chat_handler = chat_v2_handlers,
      enable_voice = _add_options and _add_options.enable_voice
    })
    M.sdk_tick()
  end
  if not SIGNGLE_INSTANCE.sdk_acc_chat_model then
    local acc_chat_handler_instance = require("ejoysdk_lua.native.modules.chat.acc_chat_handler")
    acc_chat_handler_instance:set_delegate_vm(chat_v2_handlers)
    SIGNGLE_INSTANCE.acc_chat_handler = acc_chat_handler_instance
    SIGNGLE_INSTANCE.sdk_acc_chat_model = sdk_chat_model_cls:New(SIGNGLE_INSTANCE.acc_chat_handler, {user_type = "account", old_chat_handler = chat_v2_handlers})
  end
end

function M.sdk_tick()
  local function tick_func()
    if SIGNGLE_INSTANCE.sdk_chat_model then
      SIGNGLE_INSTANCE.sdk_chat_model:tick()
    end
  end
  
  xpcall(tick_func, function(_x)
  end)
  E.Timer.once(0.5, function()
    M.sdk_tick()
  end)
end

local function player_online_handler(_player_token)
  if SIGNGLE_INSTANCE.sdk_chat_model == nil or nil == SIGNGLE_INSTANCE.sdk_acc_chat_model then
    M.regenerate_chat_model()
  end
end

local function player_offline_handler()
  chat_token.reset_token_data()
  M.destroy()
end

local function logout_handler()
  chat_token.reset_token_data()
  M.destroy()
end

function M.init(_options, _chat_v2_handlers)
  E.LOG.d(TAG, "native chat v2 init")
  chat_v2_handlers = _chat_v2_handlers
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_online_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  _add_options = _options or {}
  M.regenerate_chat_model()
end

function M.destroy()
  if SIGNGLE_INSTANCE.sdk_chat_model ~= nil then
    E.LOG.d(TAG, "native chat v2 chat_model destroy")
    SIGNGLE_INSTANCE.sdk_chat_model:destroy()
    SIGNGLE_INSTANCE.sdk_chat_model = nil
    SIGNGLE_INSTANCE.chat_handler = nil
  end
  if nil ~= SIGNGLE_INSTANCE.sdk_acc_chat_model then
    E.LOG.d(TAG, "native chat v2 acc_chat_model destroy")
    SIGNGLE_INSTANCE.sdk_acc_chat_model:destroy()
    SIGNGLE_INSTANCE.sdk_acc_chat_model = nil
    SIGNGLE_INSTANCE.acc_chat_handler:set_delegate_vm(nil)
    SIGNGLE_INSTANCE.acc_chat_handler = nil
  end
end

function M.add_callback(user_type, task_id, func)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.add_callback, SIGNGLE_INSTANCE.sdk_chat_model, task_id end
    return SIGNGLE_INSTANCE.sdk_chat_model.add_callback, SIGNGLE_INSTANCE.sdk_chat_model, task_id, func
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.add_callback, SIGNGLE_INSTANCE.sdk_acc_chat_model, task_id end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.add_callback, SIGNGLE_INSTANCE.sdk_acc_chat_model, task_id, func
  end
end

function M.rpc_call(user_type, _params, cb)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.rpc_call, SIGNGLE_INSTANCE.sdk_chat_model, _params end
    return SIGNGLE_INSTANCE.sdk_chat_model.rpc_call, SIGNGLE_INSTANCE.sdk_chat_model, _params, cb
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.rpc_call, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.rpc_call, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params, cb
  end
end

function M.get_session_msg(user_type, iter_data, search_direction, max_msg_count, options, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:get_session_msg(iter_data, search_direction, max_msg_count, options)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:get_session_msg(iter_data, search_direction, max_msg_count, options)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.get_to_user_session_id(user_type, user_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:get_to_user_session_id(user_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:get_to_user_session_id(user_id)
  end
  if cb then
    cb(ret)
  end
  return ret
end

function M.get_system_session_id(user_type, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:get_system_session_id()
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:get_system_session_id()
  end
  if cb then
    cb(ret)
  end
  return ret
end

function M.send_rich_text(user_type, session_id, data, at_list, quote_msg_ids, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:send_rich_text(session_id, data, at_list, quote_msg_ids)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:send_rich_text(session_id, data, at_list, quote_msg_ids)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.send(user_type, session_id, content, at_list, quote_msg_ids, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:send(session_id, content, at_list, quote_msg_ids)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:send(session_id, content, at_list, quote_msg_ids)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.resend(user_type, send_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:resend(send_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:resend(send_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.recall_msg(user_type, _params, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:recall_msg(_params)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:recall_msg(_params)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.create_to_user_session(user_type, to_id)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.create_to_user_session, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.create_to_user_session, SIGNGLE_INSTANCE.sdk_chat_model, to_id
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.create_to_user_session, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.create_to_user_session, SIGNGLE_INSTANCE.sdk_acc_chat_model, to_id
  end
end

function M.set_msg_received(user_type, session_id, received_ts)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.set_msg_received, SIGNGLE_INSTANCE.sdk_chat_model, session_id end
    return SIGNGLE_INSTANCE.sdk_chat_model.set_msg_received, SIGNGLE_INSTANCE.sdk_chat_model, session_id, received_ts
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.set_msg_received, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.set_msg_received, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, received_ts
  end
end

function M.create_group(user_type, members, invite_msg, info, attr, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:create_group(members, invite_msg, info, attr)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:create_group(members, invite_msg, info, attr)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.add_group_member(user_type, adds, invite_msg, group_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:add_group_member(adds, invite_msg, group_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:add_group_member(adds, invite_msg, group_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.reply_add_group_member(user_type, reply_msg, is_agree, group_id, inviter_user_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:reply_add_group_member(reply_msg, is_agree, group_id, inviter_user_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:reply_add_group_member(reply_msg, is_agree, group_id, inviter_user_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.remove_group_member(user_type, removes, remove_msg, group_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:remove_group_member(removes, remove_msg, group_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:remove_group_member(removes, remove_msg, group_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.update_group(user_type, info, group_id, attr, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:update_group(info, group_id, attr)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:update_group(info, group_id, attr)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.audit_group_reserve_member(user_type, _params, cb)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.audit_group_reserve_member, SIGNGLE_INSTANCE.sdk_chat_model, _params end
    return SIGNGLE_INSTANCE.sdk_chat_model.audit_group_reserve_member, SIGNGLE_INSTANCE.sdk_chat_model, _params, cb
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.audit_group_reserve_member, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.audit_group_reserve_member, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params, cb
  end
end

function M.get_group_reserve_member(user_type, _params, cb)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_group_reserve_member, SIGNGLE_INSTANCE.sdk_chat_model, _params end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_group_reserve_member, SIGNGLE_INSTANCE.sdk_chat_model, _params, cb
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_group_reserve_member, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_group_reserve_member, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params, cb
  end
end

function M.delete_group(user_type, group_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:delete_group(group_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:delete_group(group_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.exit_group(user_type, group_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:exit_group(group_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:exit_group(group_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.get_group_be_invited_history(user_type, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:get_group_be_invited_history()
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:get_group_be_invited_history()
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.report_msg(user_type, report_type_id, report_desc, session_id, msg_id, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:report_msg(report_type_id, report_desc, session_id, msg_id)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:report_msg(report_type_id, report_desc, session_id, msg_id)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.get_user_group_broker_info(user_type, query)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_user_group_broker_info, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_user_group_broker_info, SIGNGLE_INSTANCE.sdk_chat_model, query
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_user_group_broker_info, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_user_group_broker_info, SIGNGLE_INSTANCE.sdk_acc_chat_model, query
  end
end

function M.switch_group_id(user_type, group_broker_id, group_id)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.switch_group_id, SIGNGLE_INSTANCE.sdk_chat_model, group_broker_id end
    return SIGNGLE_INSTANCE.sdk_chat_model.switch_group_id, SIGNGLE_INSTANCE.sdk_chat_model, group_broker_id, group_id
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.switch_group_id, SIGNGLE_INSTANCE.sdk_acc_chat_model, group_broker_id end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.switch_group_id, SIGNGLE_INSTANCE.sdk_acc_chat_model, group_broker_id, group_id
  end
end

function M.set_receiving_groups(user_type, groups)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.set_receiving_groups, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.set_receiving_groups, SIGNGLE_INSTANCE.sdk_chat_model, groups
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.set_receiving_groups, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.set_receiving_groups, SIGNGLE_INSTANCE.sdk_acc_chat_model, groups
  end
end

function M.delete_msg(user_type, session_id, msg_ids, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:delete_msg(session_id, msg_ids)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:delete_msg(session_id, msg_ids)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.clean_session_msg(user_type, session_id, ts, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:clean_session_msg(session_id, ts)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:clean_session_msg(session_id, ts)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.get_player_latest_at_msgs(user_type, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:get_player_latest_at_msgs()
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:get_player_latest_at_msgs()
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.ignore(user_type, ignore_data)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.ignore, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.ignore, SIGNGLE_INSTANCE.sdk_chat_model, ignore_data
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.ignore, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.ignore, SIGNGLE_INSTANCE.sdk_acc_chat_model, ignore_data
  end
end

function M.unignore(user_type, unignore_data)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.unignore, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.unignore, SIGNGLE_INSTANCE.sdk_chat_model, unignore_data
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.unignore, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.unignore, SIGNGLE_INSTANCE.sdk_acc_chat_model, unignore_data
  end
end

function M.is_ignore_session(user_type, session_id)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.is_ignore_session, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.is_ignore_session, SIGNGLE_INSTANCE.sdk_chat_model, session_id
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.is_ignore_session, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.is_ignore_session, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id
  end
end

function M.get_ignore_data(user_type)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_ignore_data end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_ignore_data, SIGNGLE_INSTANCE.sdk_chat_model
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_ignore_data end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_ignore_data, SIGNGLE_INSTANCE.sdk_acc_chat_model
  end
end

function M.async_get_my_groups(user_type, cb)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    SIGNGLE_INSTANCE.sdk_chat_model:async_get_my_groups(cb)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    SIGNGLE_INSTANCE.sdk_acc_chat_model:async_get_my_groups(cb)
  end
end

function M.report_msg_show(user_type, param)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.report_msg_show, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.report_msg_show, SIGNGLE_INSTANCE.sdk_chat_model, param
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.report_msg_show, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.report_msg_show, SIGNGLE_INSTANCE.sdk_acc_chat_model, param
  end
end

function M.send_mock(user_type, session_id, content, at_list, quote_msg_ids)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.send_mock, SIGNGLE_INSTANCE.sdk_chat_model, session_id, content, at_list end
    return SIGNGLE_INSTANCE.sdk_chat_model.send_mock, SIGNGLE_INSTANCE.sdk_chat_model, session_id, content, at_list, quote_msg_ids
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.send_mock, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, content, at_list end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.send_mock, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, content, at_list, quote_msg_ids
  end
end

function M.send_rich_text_mock(user_type, session_id, data, at_list, quote_msg_ids)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.send_rich_text_mock, SIGNGLE_INSTANCE.sdk_chat_model, session_id, data, at_list end
    return SIGNGLE_INSTANCE.sdk_chat_model.send_rich_text_mock, SIGNGLE_INSTANCE.sdk_chat_model, session_id, data, at_list, quote_msg_ids
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.send_rich_text_mock, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, data, at_list end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.send_rich_text_mock, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, data, at_list, quote_msg_ids
  end
end

function M.reply_msg(user_type, session_id, msg_id, reply_data)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.reply_msg, SIGNGLE_INSTANCE.sdk_chat_model, session_id, msg_id end
    return SIGNGLE_INSTANCE.sdk_chat_model.reply_msg, SIGNGLE_INSTANCE.sdk_chat_model, session_id, msg_id, reply_data
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.reply_msg, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, msg_id end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.reply_msg, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, msg_id, reply_data
  end
end

function M.get_msg_res(user_type, session_id, query, limit, skip)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_msg_res, SIGNGLE_INSTANCE.sdk_chat_model, session_id, query, limit end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_msg_res, SIGNGLE_INSTANCE.sdk_chat_model, session_id, query, limit, skip
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_msg_res, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, query, limit end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_msg_res, SIGNGLE_INSTANCE.sdk_acc_chat_model, session_id, query, limit, skip
  end
end

function M.refresh_session_new_info(user_type, _session_id)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.refresh_session_new_info, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.refresh_session_new_info, SIGNGLE_INSTANCE.sdk_chat_model, _session_id
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.refresh_session_new_info, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.refresh_session_new_info, SIGNGLE_INSTANCE.sdk_acc_chat_model, _session_id
  end
end

function M.get_chat_config(user_type, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:get_chat_config()
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:get_chat_config()
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.set_chat_config(user_type, chat_config, cb)
  local ret
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_chat_model:set_chat_config(chat_config)
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    ret = SIGNGLE_INSTANCE.sdk_acc_chat_model:set_chat_config(chat_config)
  end
  if cb and ret then
    M.add_callback(user_type, ret, cb)
  end
  return ret
end

function M.get_sessions(user_type)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_sessions end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_sessions, SIGNGLE_INSTANCE.sdk_chat_model
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_sessions end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_sessions, SIGNGLE_INSTANCE.sdk_acc_chat_model
  end
end

function M.add_mock_system_group_msg(user_type, data)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.add_mock_system_group_msg, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.add_mock_system_group_msg, SIGNGLE_INSTANCE.sdk_chat_model, data
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.add_mock_system_group_msg, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.add_mock_system_group_msg, SIGNGLE_INSTANCE.sdk_acc_chat_model, data
  end
end

function M.is_msg_visible(user_type, msg)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.is_msg_visible, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.is_msg_visible, SIGNGLE_INSTANCE.sdk_chat_model, msg
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.is_msg_visible, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.is_msg_visible, SIGNGLE_INSTANCE.sdk_acc_chat_model, msg
  end
end

function M.get_user_face(user_type, _params)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_user_face, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_user_face, SIGNGLE_INSTANCE.sdk_chat_model, _params
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_user_face, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_user_face, SIGNGLE_INSTANCE.sdk_acc_chat_model, _params
  end
end

function M.get_group_cache(user_type, group_id)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.get_group_cache, SIGNGLE_INSTANCE.sdk_chat_model end
    return SIGNGLE_INSTANCE.sdk_chat_model.get_group_cache, SIGNGLE_INSTANCE.sdk_chat_model, group_id
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_group_cache, SIGNGLE_INSTANCE.sdk_acc_chat_model end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.get_group_cache, SIGNGLE_INSTANCE.sdk_acc_chat_model, group_id
  end
end

function M.tick(user_type)
  if "player" == user_type and SIGNGLE_INSTANCE.sdk_chat_model then
    do return SIGNGLE_INSTANCE.sdk_chat_model.tick end
    return SIGNGLE_INSTANCE.sdk_chat_model.tick, SIGNGLE_INSTANCE.sdk_chat_model
  elseif "account" == user_type and SIGNGLE_INSTANCE.sdk_acc_chat_model then
    do return SIGNGLE_INSTANCE.sdk_acc_chat_model.tick end
    return SIGNGLE_INSTANCE.sdk_acc_chat_model.tick, SIGNGLE_INSTANCE.sdk_acc_chat_model
  end
end

return M
