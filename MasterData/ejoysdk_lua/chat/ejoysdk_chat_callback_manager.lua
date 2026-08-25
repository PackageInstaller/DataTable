local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local M = {}
M.HANDLER_NAME = {
  ON_CONNECTED = "on_connected",
  ON_DISCONNECT = "on_disconnect",
  ON_CONNECTING = "on_connecting",
  ON_ERROR = "on_error",
  ON_CONNECT_LOST = "on_connect_lost",
  ON_HANDLERS_ERROR = "on_handlers_error",
  ON_LOGIN = "on_login",
  ON_LOGOUT = "on_logout",
  INFO_CHAT_MSG = "info_chat_msg",
  INFO_PERSONAL_MSG = "info_personal_msg",
  INFO_SYSTEM_MSG = "info_system_msg",
  INFO_GANGPLANK_MSG = "info_gangplank_msg",
  INFO_GROUP_MSG = "info_group_msg",
  INFO_SYSTEM_CHAT = "info_system_chat",
  INFO_GROUP_INVITED = "info_group_invited",
  INFO_CHAT_GAME = "info_chat_game",
  INFO_OFFLINE = "info_offline",
  INFO_CREATE_GROUP = "info_create_group",
  INFO_UPDATE_GROUP = "info_update_group",
  INFO_ADD_INVITED_MEMBER = "info_add_invited_member",
  INFO_ADD_GROUP_MEMBER = "info_add_group_member",
  INFO_DELETE_GROUP = "info_delete_group",
  INFO_REMOVE_GROUP_MEMBER = "info_remove_group_member",
  INFO_UPDATE_SESSION = "info_update_session",
  INFO_VOICE_CHANNEL_USER_CHANGE = "info_voice_channel_user_change",
  INFO_DELETE_VOICE_GROUP = "info_delete_voice_group",
  INFO_CREATE_VOICE_GROUP = "info_create_voice_group",
  INFO_FRIEND_ADD = "info_friend_add",
  INFO_FRIEND_DEL = "info_friend_del",
  INFO_FRIEND_APPLY = "info_friend_apply",
  INFO_FRIEND_APPLY_REFUSE = "info_friend_apply_refuse",
  INFO_FRIEND_APPLY_DELETE = "info_friend_apply_delete",
  INFO_FRIEND_INFO_CHANGE = "info_friend_info_change",
  CHANNEL_FRIEND_ADD = "friend_add",
  CHANNEL_FRIEND_DEL = "friend_del",
  CHANNEL_FRIEND_INFO_CHANGE = "friend_info_change",
  INFO_FB_FRIEND_ADD = "info_fb_friend_add",
  INFO_FB_FRIEND_DEL = "info_fb_friend_del",
  INFO_FB_FRIEND_INFO_CHANGE = "info_fb_friend_info_change",
  INFO_FOLLOW_ADD = "info_follow_add",
  INFO_FOLLOW_BE_ADD = "info_follow_be_add",
  INFO_FOLLOW_DEL = "info_follow_del",
  INFO_FOLLOW_BE_DEL = "info_follow_be_del",
  INFO_FOLLOW_INFO_CHANGE = "info_follow_info_change",
  INFO_FAVOR_CHANGE = "info_favor_change",
  INFO_MAIL_UPDATE_PUSH = "info_mail_update_push",
  INFO_BADGE_CHANGE = "info_badge_change"
}
M.FRIEND_MODULE_HANDLER_NAME = {
  INFO_FRIEND_ADD = M.HANDLER_NAME.INFO_FRIEND_ADD,
  INFO_FRIEND_DEL = M.HANDLER_NAME.INFO_FRIEND_DEL,
  INFO_FRIEND_INFO_CHANGE = M.HANDLER_NAME.INFO_FRIEND_INFO_CHANGE,
  INFO_FRIEND_APPLY = M.HANDLER_NAME.INFO_FRIEND_APPLY,
  INFO_FRIEND_APPLY_REFUSE = M.HANDLER_NAME.INFO_FRIEND_APPLY_REFUSE,
  INFO_FRIEND_APPLY_DELETE = M.HANDLER_NAME.INFO_FRIEND_APPLY_DELETE,
  CHANNEL_FRIEND_ADD = M.HANDLER_NAME.CHANNEL_FRIEND_ADD,
  CHANNEL_FRIEND_DEL = M.HANDLER_NAME.CHANNEL_FRIEND_DEL,
  CHANNEL_FRIEND_INFO_CHANGE = M.HANDLER_NAME.CHANNEL_FRIEND_INFO_CHANGE,
  INFO_FOLLOW_ADD = M.HANDLER_NAME.INFO_FOLLOW_ADD,
  INFO_FOLLOW_BE_ADD = M.HANDLER_NAME.INFO_FOLLOW_BE_ADD,
  INFO_FOLLOW_DEL = M.HANDLER_NAME.INFO_FOLLOW_DEL,
  INFO_FOLLOW_BE_DEL = M.HANDLER_NAME.INFO_FOLLOW_BE_DEL,
  INFO_FOLLOW_INFO_CHANGE = M.HANDLER_NAME.INFO_FOLLOW_INFO_CHANGE,
  INFO_FAVOR_CHANGE = M.HANDLER_NAME.INFO_FAVOR_CHANGE
}
local TAG = EM.MODULE.CHAT .. "cb_mgr"
local BASE_PREFIX = "chat"
local game_callback_cache = {}

function M.friend_handlers_pick_from_chat_handlers(chat_handler)
  local friend_handlers = {}
  for function_name, function_method in pairs(chat_handler or {}) do
    if M.FRIEND_MODULE_HANDLER_NAME[string.upper(function_name)] then
      friend_handlers[function_name] = function_method
    end
  end
  return friend_handlers
end

function M.unregister_callback(destination)
  game_callback_cache[destination] = nil
end

function M.register_callback(destination, game_callback)
  M.unregister_callback(destination)
  game_callback_cache[destination] = game_callback
end

function M.get_channel_handler_name(channel, handler_name)
  if not channel or not handler_name then
    chat_log.warn(chat_log_util.header(), TAG, "get_channel_handler_name_fail", {channel = channel, handler_name = handler_name}, {})
    return nil
  end
  return "info_" .. channel:lower() .. "_" .. handler_name
end

local function callback_handler(destination, handler_name, ...)
  local game_handler = game_callback_cache[destination]
  local other_destination
  if "client_friend" == destination then
    other_destination = "client_friend_chat"
  elseif "client_friend_chat" == destination then
    other_destination = "client_friend"
  end
  local other_game_handler = other_destination and game_callback_cache[other_destination]
  if not game_handler then
    if not other_game_handler then
      chat_log.warn(chat_log_util.header(), TAG, "get_game_handler_fail", {destination = destination, handler_name = handler_name}, {})
    end
    return false
  end
  local handler = game_handler[handler_name]
  if handler then
    handler(...)
    return true
  end
  return false
end

local function publish_handler_msg(prefix, handler_name, ...)
  local topic_name = prefix .. "_" .. handler_name
  ET.publish(topic_name, ...)
end

function M.callback(destination, handler_name, ...)
  publish_handler_msg(destination, handler_name, ...)
  if "chat" == destination and "info_system_msg" == handler_name then
    local msgs = (...)
    local is_skip_info_system_msg = false
    if type(msgs) == "table" and #msgs > 0 then
      local first_msg = msgs[1]
      local is_system_msg = first_msg.src_type and first_msg.src_type == "system"
      local is_chat_rule_msg = first_msg.content and first_msg.content.type and first_msg.content.type == "chat_rule_msg"
      if is_system_msg and is_chat_rule_msg then
        local realtime_msg_type = first_msg.content and first_msg.content.data and first_msg.content.data._type
        local REALTIME_MSG = require("ejoysdk_lua.chat.ejoysdk_realtime_msg")
        if REALTIME_MSG.is_skip_info_system_msg(realtime_msg_type) then
          is_skip_info_system_msg = true
        end
      end
    end
    if not is_skip_info_system_msg then
      callback_handler(destination, handler_name, ...)
    end
  else
    callback_handler(destination, handler_name, ...)
  end
end

function M.global_callback(handler_name, ...)
  for destination, _game_handler in pairs(game_callback_cache) do
    callback_handler(destination, handler_name, ...)
  end
  publish_handler_msg(BASE_PREFIX, handler_name, ...)
end

return M
