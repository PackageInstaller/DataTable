local Class = require("ejoysdk_lua.ejoysdk_class")
local ImplClass = require("ejoysdk_lua.chat.ejoysdk_chat_model_impl")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local M = Class:Inherit("chat_model")

function M:_init(handler, init_param)
  self.impl = ImplClass:New(handler, init_param)
end

function M:tick()
  self.impl:tick()
end

function M:add_callback(task_id, func)
  do return self.impl.add_callback, self.impl, task_id end
  return self.impl.add_callback, self.impl, task_id, func
end

function M:rpc_call(_params, cb)
  do return self.impl.rpc_call, self.impl, _params end
  return self.impl.rpc_call, self.impl, _params, cb
end

function M:get_session_msg(iter_data, search_direction, max_msg_count, options)
  do return self.impl.get_session_msg, self.impl, iter_data, search_direction, max_msg_count end
  return self.impl.get_session_msg, self.impl, iter_data, search_direction, max_msg_count, options
end

function M:get_to_user_session_id(user_id)
  do return self.impl.get_to_user_session_id, self.impl end
  return self.impl.get_to_user_session_id, self.impl, user_id
end

function M:get_system_session_id()
  do return self.impl.get_system_session_id end
  return self.impl.get_system_session_id, self.impl
end

function M:send_rich_text(session_id, data, at_list, quote_msg_ids)
  do return self.impl.send_rich_text, self.impl, session_id, data, at_list end
  return self.impl.send_rich_text, self.impl, session_id, data, at_list, quote_msg_ids
end

function M:send(session_id, content, at_list, quote_msg_ids)
  do return self.impl.send, self.impl, "send", session_id, content, at_list end
  return self.impl.send, self.impl, "send", session_id, content, at_list, quote_msg_ids
end

function M:resend(send_id)
  do return self.impl.resend, self.impl end
  return self.impl.resend, self.impl, send_id
end

function M:send_mock(session_id, content, at_list, quote_msg_ids)
  do return self.impl.send_mock, self.impl, session_id, content, at_list end
  return self.impl.send_mock, self.impl, session_id, content, at_list, quote_msg_ids
end

function M:send_rich_text_mock(session_id, data, at_list, quote_msg_ids)
  do return self.impl.send_rich_text_mock, self.impl, session_id, data, at_list end
  return self.impl.send_rich_text_mock, self.impl, session_id, data, at_list, quote_msg_ids
end

function M:reply_msg(session_id, msg_id, reply_data)
  do return self.impl.reply_msg, self.impl, session_id, msg_id end
  return self.impl.reply_msg, self.impl, session_id, msg_id, reply_data
end

function M:get_msg_res(session_id, query, limit, skip)
  do return self.impl.get_msg_res, self.impl, session_id, query, limit end
  return self.impl.get_msg_res, self.impl, session_id, query, limit, skip
end

function M:recall_msg(_params)
  do return self.impl.recall_msg, self.impl end
  return self.impl.recall_msg, self.impl, _params
end

function M:create_to_user_session(to_id)
  do return self.impl.create_to_user_session, self.impl end
  return self.impl.create_to_user_session, self.impl, to_id
end

function M:refresh_session_new_info(_session_id)
  do return self.impl.refresh_session_new_info, self.impl end
  return self.impl.refresh_session_new_info, self.impl, _session_id
end

function M:set_msg_received(session_id, received_ts)
  do return self.impl.set_msg_received, self.impl, session_id end
  return self.impl.set_msg_received, self.impl, session_id, received_ts
end

function M:create_group(members, invite_msg, info, attr)
  do return self.impl.create_group, self.impl, members, invite_msg, info end
  return self.impl.create_group, self.impl, members, invite_msg, info, attr
end

function M:add_group_member(adds, invite_msg, group_id)
  do return self.impl.add_group_member, self.impl, adds, invite_msg end
  return self.impl.add_group_member, self.impl, adds, invite_msg, group_id
end

function M:reply_add_group_member(reply_msg, is_agree, group_id, inviter_user_id)
  do return self.impl.reply_add_group_member, self.impl, reply_msg, is_agree, group_id end
  return self.impl.reply_add_group_member, self.impl, reply_msg, is_agree, group_id, inviter_user_id
end

function M:remove_group_member(removes, remove_msg, group_id)
  do return self.impl.remove_group_member, self.impl, removes, remove_msg end
  return self.impl.remove_group_member, self.impl, removes, remove_msg, group_id
end

function M:update_group(info, group_id, attr)
  do return self.impl.update_group, self.impl, info, group_id end
  return self.impl.update_group, self.impl, info, group_id, attr
end

function M:audit_group_reserve_member(_params, cb)
  do return self.impl.audit_group_reserve_member, self.impl, _params end
  return self.impl.audit_group_reserve_member, self.impl, _params, cb
end

function M:get_group_reserve_member(_params, cb)
  do return self.impl.get_group_reserve_member, self.impl, _params end
  return self.impl.get_group_reserve_member, self.impl, _params, cb
end

function M:delete_group(group_id)
  do return self.impl.delete_group, self.impl end
  return self.impl.delete_group, self.impl, group_id
end

function M:exit_group(group_id)
  do return self.impl.exit_group, self.impl end
  return self.impl.exit_group, self.impl, group_id
end

function M:get_group_be_invited_history()
  do return self.impl.get_group_be_invited_history end
  return self.impl.get_group_be_invited_history, self.impl
end

function M:report_msg(report_type_id, report_desc, session_id, msg_id)
  do return self.impl.report_msg, self.impl, report_type_id, report_desc, session_id end
  return self.impl.report_msg, self.impl, report_type_id, report_desc, session_id, msg_id
end

function M:get_chat_config()
  do return self.impl.get_chat_config end
  return self.impl.get_chat_config, self.impl
end

function M:set_chat_config(chat_config)
  do return self.impl.set_chat_config, self.impl end
  return self.impl.set_chat_config, self.impl, chat_config
end

function M:get_user_group_broker_info(query)
  do return self.impl.get_user_group_broker_info, self.impl end
  return self.impl.get_user_group_broker_info, self.impl, query
end

function M:switch_group_id(group_broker_id, group_id)
  do return self.impl.switch_group_id, self.impl, group_broker_id end
  return self.impl.switch_group_id, self.impl, group_broker_id, group_id
end

function M:set_receiving_groups(groups)
  do return self.impl.set_receiving_groups, self.impl end
  return self.impl.set_receiving_groups, self.impl, groups
end

function M:delete_msg(session_id, msg_ids)
  do return self.impl.delete_msg, self.impl, session_id end
  return self.impl.delete_msg, self.impl, session_id, msg_ids
end

function M:clean_session_msg(session_id, ts)
  do return self.impl.clean_session_msg, self.impl, session_id end
  return self.impl.clean_session_msg, self.impl, session_id, ts
end

function M:get_player_latest_at_msgs(cb)
  do return self.impl.get_player_latest_at_msgs, self.impl end
  return self.impl.get_player_latest_at_msgs, self.impl, cb
end

function M:ignore(ignore_data)
  do return self.impl.ignore, self.impl end
  return self.impl.ignore, self.impl, ignore_data
end

function M:unignore(unignore_data)
  do return self.impl.unignore, self.impl end
  return self.impl.unignore, self.impl, unignore_data
end

function M:is_ignore_session(session_id)
  do return self.impl.is_ignore_session, self.impl end
  return self.impl.is_ignore_session, self.impl, session_id
end

function M:get_ignore_data()
  do return self.impl.get_ignore_data end
  return self.impl.get_ignore_data, self.impl
end

function M:async_get_my_groups(cb)
  self.impl:async_get_my_groups(cb)
end

function M:get_sessions()
  do return self.impl.get_sessions end
  return self.impl.get_sessions, self.impl
end

function M:destroy()
  self.impl:destroy()
end

function M:add_mock_system_group_msg(data)
  self.impl:add_mock_system_group_msg(data)
end

function M:_get_impl()
  return self.impl
end

function M:report_msg_show(param)
  self.impl:report_msg_show(param)
end

function M:is_msg_visible(msg)
  do return self.impl.is_msg_visible, self.impl end
  return self.impl.is_msg_visible, self.impl, msg
end

function M:get_user_face(_params)
  do return self.impl.get_user_face, self.impl end
  return self.impl.get_user_face, self.impl, _params
end

function M:get_group_cache(group_id)
  do return self.impl.get_group_cache, self.impl end
  return self.impl.get_group_cache, self.impl, group_id
end

E_UTILS.do_export_wrapping(M, "chat")
return M
