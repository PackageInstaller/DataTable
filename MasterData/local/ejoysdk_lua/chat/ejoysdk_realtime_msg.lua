local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CONSTANS = require("ejoysdk_lua.ejoysdk_constants")
local ERROR_CODES = CONSTANS.REALTIME_MSG_ERROR_CODES
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local EM = require("ejoysdk_lua.ejoysdk_module")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local xpcall = compat.xpcall
local TAG = EM.MODULE.CHAT .. "realtime_msg"
local M = {}
M.MSG_TYPE_NORMAL = 0
M.MSG_TYPE_WITHDRAW = 5
local init_tick = false
local TICK_INTERVAL = 1
local inited = false
local msg_callbacks = {}
local msg_id_to_cache = {}
local skip_info_system_msg_callback_msg_type_map = {}

local function get_session_id()
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local player_id = EG.player_info() and EG.player_info().player_id
  if not player_id then
    return nil
  end
  local session_id = "system_chat_rule_msg" .. ":" .. tostring(player_id)
  return session_id
end

local function get_callbacks(msg_type)
  msg_callbacks[msg_type] = msg_callbacks[msg_type] or {}
  return msg_callbacks[msg_type]
end

local function do_callback(msg_type, realtime_msg)
  local callbacks = get_callbacks(msg_type)
  for _, callback in ipairs(callbacks) do
    xpcall(callback, function(x)
      chat_log.warn(chat_log_util.header(), TAG, "do_callback_error", {
        msg_type = msg_type,
        lua_error_msg = tostring(x)
      }, {})
      local notify_succ, notify_error = pcall(CALLBACK.callback, "chat", CALLBACK.HANDLER_NAME.ON_HANDLERS_ERROR, "", x)
      if not notify_succ then
        chat_log.warn(chat_log_util.header(), TAG, "chat_notify_cp_error", {notify_error = notify_error}, {})
      end
    end, realtime_msg)
  end
end

local function is_need_set_received(timeliness)
  if timeliness.type == "time_range" or timeliness.type == "duration" and timeliness.resend_on_login ~= true then
    return true
  else
    return false
  end
end

local function transform_to_realtime_msg(msg)
  local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  local session_id = msg.session_id
  local session_type = CHAT.get_session_type(session_id)
  if session_type.type ~= CHAT.TYPE_SYSTEM or session_type.from ~= "chat_rule_msg" then
    return nil
  end
  local realtime_msg = {}
  realtime_msg.msg_id = msg.msg_id
  realtime_msg.reader_status = msg.reader_status or M.MSG_TYPE_NORMAL
  realtime_msg.raw_msg = msg
  if realtime_msg.reader_status ~= M.MSG_TYPE_WITHDRAW then
    realtime_msg.data = msg.content.data
    realtime_msg.msg_type = msg.content.data._type
    local timeliness = msg.content.timeliness
    realtime_msg.timeliness = timeliness
    msg_id_to_cache[realtime_msg.msg_id] = {
      msg_type = realtime_msg.msg_type,
      timeliness = realtime_msg.timeliness
    }
  else
    local msg_cache = msg_id_to_cache[realtime_msg.msg_id]
    if not msg_cache then
      return nil
    end
    realtime_msg.msg_type = msg_cache.msg_type
    msg_id_to_cache[realtime_msg.msg_id] = nil
  end
  return realtime_msg
end

local function chat_system_msg_handler(msgs)
  for _, msg in ipairs(msgs) do
    local realtime_msg = transform_to_realtime_msg(msg)
    if realtime_msg then
      do_callback(realtime_msg.msg_type, realtime_msg)
    end
  end
end

local function register_info_system_msg()
  ET.subscribe("chat_info_system_msg", chat_system_msg_handler)
end

local function unregister_info_system_msg()
  ET.unsubscribe("chat_info_system_msg", chat_system_msg_handler)
end

local function player_online_handler(_player_token)
  if not init_tick then
    init_tick = true
    local CHAT_SERVER = require("ejoysdk_lua.chat.ejoysdk_chat_server")
    local ticker
    
    function ticker()
      local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
      if CHAT.has_tick() then
        return
      end
      CHAT_SERVER.tick()
      E.Timer.once(TICK_INTERVAL, ticker)
    end
    
    E.Timer.once(TICK_INTERVAL, ticker)
  end
end

function M.uninit()
  chat_log.call_api(chat_log_util.header(), TAG, "uninit", chat_log.LOG_LEVEL.HIGH, {})
  unregister_info_system_msg()
  inited = false
end

function M.init()
  chat_log.call_api(chat_log_util.header(), TAG, "init", chat_log.LOG_LEVEL.HIGH, {})
  if inited then
    return
  end
  inited = true
  register_info_system_msg()
  local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  CHAT.real_init()
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_online_handler)
end

function M.is_skip_info_system_msg(msg_type)
  if skip_info_system_msg_callback_msg_type_map[msg_type] then
    return true
  end
  return false
end

function M.add_callback(msg_type, cb, opt)
  chat_log.call_api(chat_log_util.header(), TAG, "add_callback", chat_log.LOG_LEVEL.LOW, {}, msg_type, cb)
  local callbacks = get_callbacks(msg_type)
  for _, cur_cb in ipairs(callbacks) do
    if cur_cb == cb then
      return
    end
  end
  table.insert(callbacks, cb)
  if opt and opt.is_skip_info_system_msg_callback then
    skip_info_system_msg_callback_msg_type_map[msg_type] = true
  end
end

function M.remove_callback(msg_type, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "remove_callback", chat_log.LOG_LEVEL.LOW, {}, msg_type, cb)
  local callbacks = get_callbacks(msg_type)
  for idx, cur_cb in ipairs(callbacks) do
    if cur_cb == cb then
      table.remove(callbacks, idx)
      break
    end
  end
  if next(callbacks) == nil and skip_info_system_msg_callback_msg_type_map[msg_type] then
    E.LOG.d(TAG, "callback is empty for msg_type=" .. tostring(msg_type) .. ", now reset skip_info_system_msg_callback_msg_type_map")
    skip_info_system_msg_callback_msg_type_map[msg_type] = nil
  end
end

function M.set_received(msg_id, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "set_received", chat_log.LOG_LEVEL.LOW, {}, msg_id, cb)
  local session_id = get_session_id()
  if nil == session_id then
    if cb then
      cb(false, ERROR_CODES.CODE_PLAYER_ID_NIL, "player id is nil")
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_received", chat_log.LOG_LEVEL.LOW, {}, cb, false, ERROR_CODES.CODE_PLAYER_ID_NIL, "player id is nil")
    return
  end
  local msg_cache = msg_id_to_cache[msg_id]
  if not msg_cache then
    if cb then
      cb(false, ERROR_CODES.CODE_INAVLID_MSG, "not valid msg")
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_received", chat_log.LOG_LEVEL.LOW, {}, cb, false, ERROR_CODES.CODE_INAVLID_MSG, "not valid msg")
    return
  end
  if not is_need_set_received(msg_cache.timeliness) then
    if cb then
      cb(true)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_received", chat_log.LOG_LEVEL.LOW, {}, cb, true)
    return
  end
  local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  CHAT.set_msg_received(session_id, msg_id, function(...)
    if cb then
      cb(...)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "set_received", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_realtime_msgs(opt, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "get_realtime_msgs", chat_log.LOG_LEVEL.LOW, {}, opt, cb)
  local session_id = get_session_id()
  if nil == session_id then
    if cb then
      cb(false, ERROR_CODES.CODE_PLAYER_ID_NIL, "player id is nil")
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_realtime_msgs", chat_log.LOG_LEVEL.LOW, {}, cb, false, ERROR_CODES.CODE_PLAYER_ID_NIL, "player id is nil")
    return
  end
  local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  CHAT.get_msg(session_id, opt, function(succ, ...)
    if succ then
      local msgs = (...)
      local realtime_msgs = {}
      for _, msg in ipairs(msgs) do
        local realtime_msg = transform_to_realtime_msg(msg)
        if realtime_msg then
          table.insert(realtime_msgs, realtime_msg)
        end
      end
      if cb then
        cb(true, realtime_msgs)
      end
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_realtime_msgs", chat_log.LOG_LEVEL.LOW, {}, cb, true, realtime_msgs)
    else
      if cb then
        cb(false, ...)
      end
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_realtime_msgs", chat_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end)
end

return M
