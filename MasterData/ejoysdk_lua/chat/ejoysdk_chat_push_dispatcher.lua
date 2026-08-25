local _E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local xpcall = compat.xpcall
local TAG = EM.MODULE.CHAT .. "dsp"
local M = {}
M.DESTINATION = {
  PLAYER = "chat",
  ACCOUNT = "acc_chat",
  CLIENT_CHAT_SERVER = "client_chat_server",
  BADGE = "badge",
  CLIENT_FRIEND = "client_friend",
  CLIENT_FRIEND_CHAT = "client_friend_chat",
  CLIENT_FRIEND_CHAT_ACCOUNT = "client_friend_chat_account",
  CLIENT_MAIL = "client_mail"
}
local destination_chat_handlers_cache = {}
local server_handlers_cache = {}
local destination_chat_v2_handlers_cache = {}
local split_string = _E.Utils.split_string

function M.dispatch_chat_msg(msg, chat_handlers, _method)
  local CHAT_HANDLERS = chat_handlers
  if msg.cmd and CHAT_HANDLERS[msg.cmd] then
    CHAT_HANDLERS[msg.cmd](msg)
  else
    CHAT_HANDLERS.on_unhandle(msg)
  end
end

function M.dispatch_friend_msg(msg, friend_handlers, method)
  local FRIEND_HANDLERS = friend_handlers
  local strs = split_string(method, "/")
  local size = #strs
  if 4 ~= size then
    return
  end
  local handle_type = strs[2]
  local api = strs[4]
  if type(FRIEND_HANDLERS[api]) == "function" then
    FRIEND_HANDLERS[api](msg)
  elseif type(FRIEND_HANDLERS[api]) == "table" and FRIEND_HANDLERS[api][handle_type] then
    FRIEND_HANDLERS[api][handle_type](msg)
  end
end

function M.dispatch_search_msg(msg, search_handlers, method)
  local SEARCH_HANDLERS = search_handlers
  local strs = split_string(method, "/")
  local api = strs[2]
  SEARCH_HANDLERS[api](msg)
end

function M.dispatch_favor_msg(msg, favor_handlers, method)
  local FAVOR_HANDLERS = favor_handlers
  local strs = split_string(method, "/")
  local size = #strs
  if 4 ~= size then
    return
  end
  local handle_type = strs[2]
  local api = strs[4]
  if type(FAVOR_HANDLERS[api]) == "function" then
    FAVOR_HANDLERS[api](msg)
  elseif type(FAVOR_HANDLERS[api]) == "table" and FAVOR_HANDLERS[api][handle_type] then
    FAVOR_HANDLERS[api][handle_type](msg)
  end
end

function M.dispatch_follow_msg(msg, follow_handlers, method)
  local FOLLOW_HANDLERS = follow_handlers
  local strs = split_string(method, "/")
  local size = #strs
  if 4 ~= size then
    return
  end
  local handle_type = strs[2]
  local api = strs[4]
  if type(FOLLOW_HANDLERS[api]) == "function" then
    FOLLOW_HANDLERS[api](msg)
  elseif type(FOLLOW_HANDLERS[api]) == "table" and FOLLOW_HANDLERS[api][handle_type] then
    FOLLOW_HANDLERS[api][handle_type](msg)
  end
end

function M.register_chat_handlers(destination, chat_handlers)
  M.unregister_chat_handlers(destination)
  destination_chat_handlers_cache[destination] = chat_handlers
end

function M.unregister_chat_handlers(destination)
  destination_chat_handlers_cache[destination] = nil
end

function M.register_server_handlers(server_handlers)
  for _, handler in ipairs(server_handlers_cache) do
    if handler == server_handlers then
      return
    end
  end
  server_handlers_cache[#server_handlers_cache + 1] = server_handlers
end

function M.unregister_server_handlers(server_handlers)
  local new = {}
  for _, handler in ipairs(server_handlers_cache) do
    if server_handlers ~= handler then
      new[#new + 1] = handler
    end
  end
  server_handlers_cache = new
end

function M.register_chat_v2_handlers(destination, chat_handlers)
  M.unregister_chat_v2_handlers(destination)
  destination_chat_v2_handlers_cache[destination] = chat_handlers
end

function M.unregister_chat_v2_handlers(destination)
  destination_chat_v2_handlers_cache[destination] = nil
end

local function exec_server_handler_method(method_name, params)
  for _, handlers in ipairs(server_handlers_cache) do
    local method = handlers[method_name]
    if method then
      method(params)
    else
      chat_log.warn(chat_log_util.header(), TAG, "exec_server_handler_method_not_found", {method = method_name}, {})
    end
  end
end

local function exec_server_handler_method_on_error(method_name, params, error_code)
  for _, handlers in ipairs(server_handlers_cache) do
    local method = handlers[method_name]
    if method then
      method(params, error_code or CONSTANTS.CHAT_ERROR_CODES.CODE_DISPATCHER_ON_ERROR_NO_CODE)
    else
      chat_log.warn(chat_log_util.header(), TAG, "exec_server_handler_method_on_error_not_found", {method = method_name}, {})
    end
  end
end

function M.on_connect_start()
  ET.publish(ET.chat.UPDATE_STATE, STATES.CONNECT_START)
  exec_server_handler_method("on_connect_start")
end

function M.on_connect_error(error_msg)
  ET.publish(ET.chat.UPDATE_STATE, STATES.CONNECT_ERROR)
  exec_server_handler_method("on_connect_error", error_msg)
end

function M.on_connecting()
  ET.publish(ET.chat.UPDATE_STATE, STATES.CONNECTING)
  exec_server_handler_method("on_connecting")
end

function M.on_connected()
  ET.publish(ET.chat.UPDATE_STATE, STATES.CONNECTED)
  exec_server_handler_method("on_connected")
end

function M.on_disconnect()
  ET.publish(ET.chat.UPDATE_STATE, STATES.DISCONNECT)
  exec_server_handler_method("on_disconnect")
end

function M.on_error(error_msg, error_code)
  ET.publish(ET.chat.UPDATE_STATE, STATES.ERROR)
  exec_server_handler_method_on_error("on_error", error_msg, error_code)
end

local start_with = _E.Utils.start_with

function M.is_message_for_module(module_name, header)
  if not header or not module_name then
    return false
  end
  local method = header.method
  if not method then
    return false
  end
  if "friend" == module_name then
    return start_with(method, "friend") or start_with(method, "favor") or start_with(method, "follow")
  elseif "mail" == module_name then
    do return start_with, method end
    return start_with, method, "mail"
  elseif "client_chat_server" == module_name then
    return "stop_conn" == method or "force_stop_conn" == method
  end
  return false
end

local function exe_chat_server_handlers(header, msg)
  local conn_handlers = destination_chat_handlers_cache[M.DESTINATION.CLIENT_CHAT_SERVER]
  if not conn_handlers then
    return false
  end
  _E.LOG.debug(TAG, "exe_chat_server_handlers >>")
  _E.LOG.debug(TAG, {header = header, msg = msg})
  xpcall(conn_handlers, function(x)
    chat_log.warn(chat_log_util.header(), TAG, "handle_chat_conn_message_has_error", {
      lua_error_msg = tostring(x)
    }, {})
  end, header, msg)
  return true
end

function M.handle_chat_server_message(header, msg)
  local is_chat_server_msg = M.is_message_for_module(M.DESTINATION.CLIENT_CHAT_SERVER, header)
  if is_chat_server_msg then
    do return exe_chat_server_handlers, header end
    return exe_chat_server_handlers, header, msg
  else
    return false
  end
end

function M.handle_message(header, msg)
  local destination = header.destination
  if not destination or "" == destination then
    return
  end
  local is_friend_msg = M.is_message_for_module("friend", header)
  local is_mail_msg = M.is_message_for_module("mail", header)
  
  local function exe_chat_handlers()
    local chat_handlers = destination_chat_handlers_cache[destination]
    if not chat_handlers then
      return
    end
    _E.LOG.debug(TAG, "exe_chat_handlers >>")
    _E.LOG.debug(TAG, {header = header, msg = msg})
    xpcall(chat_handlers, function(x)
      local notify_succ, notify_error = pcall(CALLBACK.callback, "chat", CALLBACK.HANDLER_NAME.ON_HANDLERS_ERROR, "", x)
      if not notify_succ then
        chat_log.warn(chat_log_util.header(), TAG, "chat_notify_cp_error", {notify_error = notify_error}, {})
      end
      chat_log.warn(chat_log_util.header(), TAG, "handle_message_has_error", {
        lua_error_msg = tostring(x)
      }, {})
    end, header, msg)
  end
  
  local function exe_chat_v2_handlers()
    local chat_v2_handlers = destination_chat_v2_handlers_cache[destination]
    if not chat_v2_handlers then
      return
    end
    _E.LOG.debug(TAG, "exe_chat_v2_handlers >>")
    _E.LOG.debug(TAG, {header = header, msg = msg})
    xpcall(chat_v2_handlers, function(x)
      pcall(CALLBACK.callback, "chat", CALLBACK.HANDLER_NAME.ON_HANDLERS_ERROR, "", x)
      chat_log.warn(chat_log_util.header(), TAG, "handle_message_has_error", {
        lua_error_msg = tostring(x)
      }, {})
    end, header, msg)
  end
  
  local function exe_friend_handlers()
    local friend_handlers = destination_chat_handlers_cache.client_friend
    if not friend_handlers then
      return
    end
    _E.LOG.debug(TAG, "exe_friend_handlers >>")
    _E.LOG.debug(TAG, {header = header, msg = msg})
    xpcall(friend_handlers, function(x)
      pcall(CALLBACK.callback, "chat", CALLBACK.HANDLER_NAME.ON_HANDLERS_ERROR, "", x)
      chat_log.warn(chat_log_util.header(), TAG, "handle_friend_message_has_error", {
        lua_error_msg = tostring(x)
      }, {})
    end, header, msg)
  end
  
  local function exe_mail_handlers()
    local mail_handlers = destination_chat_handlers_cache.client_mail
    if not mail_handlers then
      return
    end
    _E.LOG.debug(TAG, "exe_mail_handlers >>")
    _E.LOG.debug(TAG, {header = header, msg = msg})
    xpcall(mail_handlers, function(x)
      chat_log.warn(chat_log_util.header(), TAG, "handle_mail_message_has_error", {
        lua_error_msg = tostring(x)
      }, {})
    end, header, msg)
  end
  
  if is_friend_msg then
    exe_friend_handlers()
  elseif is_mail_msg then
    exe_mail_handlers()
  else
    exe_chat_handlers()
  end
  exe_chat_v2_handlers()
end

return M
