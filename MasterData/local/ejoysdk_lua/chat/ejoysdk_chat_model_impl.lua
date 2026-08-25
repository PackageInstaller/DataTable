local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("chat_model_impl")
local EC = require("ejoysdk_lua.chat.ejoysdk_chat_base")
local ECS = require("ejoysdk_lua.chat.ejoysdk_chat_server")
local SOCKET = require("ejoysdk_lua.chat.ejoysdk_chat_socket")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local msg_util = require("ejoysdk_lua.chat.export.ejoysdk_chat_msg_util")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local chat_cache = require("ejoysdk_lua.chat.ejoysdk_chat_cache")
local player_info = require("ejoysdk_lua.player.player_info")
local player_scene = require("ejoysdk_lua.player.player_info_scene")
local player_cache = require("ejoysdk_lua.player.player_info_cache")
local chat_session_msg_class = require("ejoysdk_lua.chat.export.ejoysdk_chat_session_msg")
local chat_api = require("ejoysdk_lua.server_api.ejoysdk_chat_api")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local old_chat = require("ejoysdk_lua.chat.ejoysdk_chat")
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local Chain = require("ejoysdk_lua.ejoysdk_chain")
local voice = require("ejoysdk_lua.chat.ejoysdk_voice")
local voice_topic = require("ejoysdk_lua.chat.ejoysdk_voice_topic")
local TAG = EM.MODULE.CHAT .. "chat_model_impl"
local get_destination
local chat_model_status = {
  offline = "offline",
  online0 = "online0",
  online1 = "online1"
}
local rpc_process_type = {
  get_chat_token = "get_chat_token",
  do_login = "do_login",
  get_latest_session = "get_latest_session",
  init_connect = "init_connect"
}
local MAX_ID = 10000000
local last_time_reply_msg = 0
local REPLY_MSG_LIMIT = 600
local reported_shown_msgs = {}
local reported_shown_msgs_map = {}
local MAX_CACHE_SHOWN_MSGS = 10000

function M:_init(handler, init_param)
  init_param = init_param or {}
  self.user_type = init_param.user_type or "player"
  self.sync_blank_group_sessions = init_param.sync_blank_group_sessions or false
  self.sync_blank_system_session = init_param.sync_blank_system_session or false
  self.need_replace_reply_res_user_info = init_param.need_replace_reply_res_user_info or false
  self.filter_sys_msg_group_types = init_param.filter_sys_msg_group_types
  self.enable_voice = init_param.enable_voice or false
  if self.enable_voice and self.user_type == "player" then
    chat_cache.set_chat_model(self)
  end
  if self.filter_sys_msg_group_types then
    self.filter_sys_msg_group_types_map = {}
    for _, fsv in pairs(self.filter_sys_msg_group_types) do
      self.filter_sys_msg_group_types_map[fsv] = true
    end
  end
  self.enable_connect = true
  if self.user_type == "account" then
    self.enable_connect = init_param.enable_connect or false
  end
  assert(self.user_type == "player" or self.user_type == "account", "user_type_error")
  STATES.init()
  self.handler = handler
  self.sessions = {}
  self.session_msgs = {}
  self.msg_send_cache = {}
  self.callback = {}
  self.last_task_id = nil
  self.task_id_counter = 0
  self.status = chat_model_status.offline
  self.groups = {}
  self.get_common_scene_state = 0
  self.rpc_process_time = {}
  self.destroy_flag = false
  self.old_chat_handler = init_param.old_chat_handler or {}
  self.set_msg_received_cache = {}
  self:_init_user_info()
  self:_register_handler()
  self:_try_to_login()
  self:_try_get_scene_info()
  self.get_chat_token_code_503_first_time = 0
  self.retry_connect_index = 0
  self.last_time_for_first_retry_connect = 0
  self.retry_connect_max_time_gap = 30
  self.last_error_msg = nil
  self.retry_connect_times = 0
  self.last_offline_reason = nil
  self.sync_group_flag = false
  self.sync_system_flag = false
  if init_param.heartbeat_options then
    self.heartbeat_options = init_param.heartbeat_options
    ECS.set_heartbeat_options(self.heartbeat_options)
  end
end

function M:_register_handler()
  DISPATCHER.register_server_handlers(self:_get_conn_handler())
  local destination = get_destination(self.user_type)
  
  local function chat_v2_handlers(header, msg)
    if self.destroy_flag then
      return
    end
    self:HANDLERS(header, msg)
  end
  
  self.chat_v2_handlers = chat_v2_handlers
  DISPATCHER.register_chat_v2_handlers(destination, chat_v2_handlers)
  if self.old_chat_handler and self.old_chat_handler.on_handlers_error == nil then
    function self.old_chat_handler.on_handlers_error(_traceback, _error_msg)
      self:_on_handlers_error(_error_msg)
    end
  end
  CALLBACK.register_callback(destination, self.old_chat_handler)
  
  local function gangplank_logout_handler()
    if self.destroy_flag then
      return
    end
    self:_gangplank_logout_handler()
  end
  
  self.gangplank_logout_handler = gangplank_logout_handler
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  
  local function gangplank_exit_handler()
    if self.destroy_flag then
      return
    end
    self:_gangplank_exit_handler()
  end
  
  self.gangplank_exit_handler = gangplank_exit_handler
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  
  local function player_offline_handler()
    if self.destroy_flag then
      return
    end
    self:_player_offline_handler()
  end
  
  self.player_offline_handler = player_offline_handler
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  
  local function player_token_handler()
    if self.destroy_flag then
      return
    end
    self:_player_token_handler()
  end
  
  self.player_token_handler = player_token_handler
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_token_handler)
  
  local function on_network_change(state_info)
    if nil ~= state_info and type(state_info) == "table" and nil ~= state_info.state and tostring(state_info.state) ~= "0" then
      self:reset_retry_connect_index()
    end
  end
  
  ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change)
  if self.enable_voice then
    local function set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info)
      if self.destroy_flag then
        return
      end
      self:_set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info)
    end
    
    self.set_voice_channel_status = set_voice_channel_status
    ET.subscribe(voice_topic.VOICE_CHANNEL_STATUS_UPDATE, set_voice_channel_status)
  end
end

function M:is_login_succ()
  if E.Utils.start_with(self.status, "online") then
    return true
  end
  return false
end

function M:_unregister_handler()
  local destination = get_destination(self.user_type)
  DISPATCHER.unregister_server_handlers(self:_get_conn_handler())
  DISPATCHER.unregister_chat_v2_handlers(destination)
  CALLBACK.unregister_callback(destination)
  ET.unsubscribe(ET.gangplank.LOGOUT, self.gangplank_logout_handler)
  ET.unsubscribe(ET.gangplank.EXIT, self.gangplank_exit_handler)
  ET.unsubscribe(ET.gangplank.PLAYER_OFFLINE, self.player_offline_handler)
  ET.unsubscribe(ET.gangplank.PLAYER_ONLINE, self.player_token_handler)
  if self.enable_voice then
    ET.unsubscribe(voice_topic.VOICE_CHANNEL_STATUS_UPDATE, self.set_voice_channel_status)
  end
end

function M:destroy()
  E.LOG.d(TAG, "聊天准备-destroy, destroy_flag=" .. tostring(self.destroy_flag))
  ECS.reset_global_data()
  ECS.close()
  if not self.destroy_flag then
    self.destroy_flag = true
    self.callback = {}
    self.groups = {}
    self.sessions = {}
    self.session_msgs = {}
    self:_unregister_handler()
    self.sync_group_flag = false
    self.sync_system_flag = false
  end
end

function M:_gangplank_logout_handler()
  E.LOG.d(TAG, "聊天准备-gangplank_logout")
  chat_token.reset_token_data()
  self:destroy()
end

function M:_gangplank_exit_handler()
  E.LOG.d(TAG, "聊天准备-gangplank_exit")
  chat_token.reset_token_data()
  self:destroy()
end

function M:_player_token_handler()
  E.LOG.d(TAG, "聊天准备-player_online")
  self:_try_to_login()
  self:_try_get_scene_info()
end

function M:_player_offline_handler()
  E.LOG.d(TAG, "聊天准备-player_offline")
  chat_token.reset_token_data()
  self:destroy()
end

function M:_set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info)
  if not self.enable_voice then
    return
  end
  E.LOG.d(TAG, "set_voice_channel_status")
  E.LOG.d(TAG, {
    group_id = group_id,
    status = status,
    mute_local_value = mute_local_value,
    voice_user_id = voice_user_id,
    channel_info = channel_info
  })
  EC.set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info, function(...)
  end)
end

function M:_get_conn_handler()
  return {
    on_connect_error = function(_error_msg)
      self:_on_connect_error(_error_msg)
    end,
    on_connected = function()
      self:_on_connected()
    end,
    on_disconnect = function()
      self:_on_disconnect()
    end,
    on_error = function(_error_msg, _error_code)
      self:_on_error(_error_msg, _error_code)
    end,
    on_connect_start = function()
      self:_on_connect_start()
    end,
    on_connecting = function()
      self:_on_connecting()
    end,
    on_connect_lost = function()
      self:_on_connect_lost()
    end
  }
end

function M:_try_to_login()
  if not EG.user_info().uid or 0 == #EG.user_info().uid then
    E.LOG.d(TAG, "account not login try login")
    return
  end
  if not EH.get_player_token() or 0 == #EH.get_player_token() then
    E.LOG.d(TAG, "player_token not exist and ignore")
    return
  end
  if not self.user_id then
    self:_init_user_info()
    self:_sync_my_user_info()
  else
    self:_sync_my_user_info()
  end
  if self.enable_connect then
    if chat_token.is_chat_token_valid() then
      self:_do_connect_when_needed()
    else
      self:_get_chat_token()
    end
  else
    self:_do_login()
  end
end

function M:_try_get_scene_info()
  if self.user_type == "account" then
    return
  end
  if not EH.get_player_token() or 0 == #EH.get_player_token() then
    E.LOG.i(TAG, "player_token not exist and ignore")
    return
  end
  if 2 == self.get_common_scene_state or 1 == self.get_common_scene_state then
    return
  end
  self.get_common_scene_state = 1
  E.Timer.once(10, function()
    if 1 == self.get_common_scene_state then
      self.get_common_scene_state = -1
    end
  end)
  local scene_ids = {
    player_scene.OFFICIAL_SCENE.CHAT,
    player_scene.OFFICIAL_SCENE.CHAT_MSG_RES,
    player_scene.OFFICIAL_SCENE.DEFAULT
  }
  player_scene.get_scene_infos(scene_ids, function(succ, ...)
    if succ then
      self.get_common_scene_state = 2
    else
      self.get_common_scene_state = -1
    end
  end)
end

function M:_on_connect_state_change(_state_event, _msg)
  if self.destroy_flag then
    return
  end
  E.LOG.debug(TAG, "on_connect_state_change:" .. tostring(_state_event) .. ", msg:" .. tostring(_msg) .. ", status:" .. tostring(self.status))
  if self.handler.on_connect_state_change then
    self.handler:on_connect_state_change(_state_event, _msg or "")
  end
end

function M:_on_connect_start()
  self:_on_connect_state_change("on_connect_start")
end

function M:_on_connecting()
  self:_on_connect_state_change("on_connecting")
end

function M:_on_connect_lost()
  self:_on_connect_state_change("on_connect_lost")
end

function M:_on_connect_error(_error_msg)
  if self.destroy_flag then
    return
  end
  self.rpc_process_time[rpc_process_type.init_connect] = nil
  E.LOG.d(TAG, "聊天准备-连接错误")
  self:_on_offline()
  self:retry_connect(-1)
  self:_on_connect_state_change("on_connect_error", _error_msg)
end

function M:_on_disconnect()
  if self.destroy_flag then
    return
  end
  self.rpc_process_time[rpc_process_type.init_connect] = nil
  E.LOG.d(TAG, "聊天准备-连接断开")
  if self.enable_voice then
    voice.uninit()
  end
  self:_on_offline()
  self:_on_connect_state_change("on_disconnect")
end

function M:_on_error(_error_msg, _error_code)
  if self.destroy_flag then
    return
  end
  self.rpc_process_time[rpc_process_type.init_connect] = nil
  E.LOG.d(TAG, "聊天准备-遇到错误:" .. tostring(_error_msg) .. ", code:" .. tostring(_error_code))
  if self.enable_voice then
    voice.uninit()
  end
  self:_on_offline()
  self:retry_connect(_error_code)
  self:_on_connect_state_change("on_error", _error_msg)
end

function M:_on_offline()
  self:_update_status(chat_model_status.offline)
end

function M:reset_retry_connect_index()
  self.retry_connect_index = 0
end

function M:retry_connect(_code)
  if E.time() - self.last_time_for_first_retry_connect >= 1800 then
    self.retry_connect_index = 0
    self.last_time_for_first_retry_connect = E.time()
  end
  self.retry_connect_index = math.min(self.retry_connect_index + 1, 1000000)
  local delay_time = self:retry_connect_delay_time(self.retry_connect_index)
  ET.publish(ET.chat.UPDATE_STATE, STATES.RETRY_CONNECT, {
    retry_connect_index = self.retry_connect_index,
    delay_time = delay_time,
    code = _code or 0
  })
  E.LOG.d(TAG, "chat_connect: start retry connect, delay_time=" .. tostring(delay_time) .. ", retry_connect_index=" .. tostring(self.retry_connect_index))
  self.retry_connect_times = self.retry_connect_times + 1
  local holo = require("ejoysdk_lua.ejoysdk_holo")
  local token = holo.get_player_token()
  local expire_time = (holo.get_player_token_body() or {}).expire_time or 0
  if not token or 0 == #token or expire_time < E.time() then
    local connect_lost_code
    if not token or 0 == #token then
      connect_lost_code = CONSTANTS.CHAT_ERROR_CODES.CODE_CONNECT_LOST_FROM_TOKEN_MISS
    else
      connect_lost_code = CONSTANTS.CHAT_ERROR_CODES.CODE_CONNECT_LOST_FROM_TOKEN_EXPIRE
    end
    E.LOG.d(TAG, "chat_connect: retry connect fail, token expire:" .. tostring(connect_lost_code))
    ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
    return
  end
  E.Timer.once(delay_time, function()
    local gp_player_info_cache = EG.player_info()
    if gp_player_info_cache then
      self:_try_to_login()
    else
      E.LOG.d(TAG, "chat_connect: retry connect fail, PLAYER_INFO miss")
      ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
    end
  end)
end

function M:_on_connected()
  if self.destroy_flag then
    return
  end
  self.rpc_process_time[rpc_process_type.init_connect] = nil
  E.LOG.d(TAG, "聊天准备-连接成功")
  self:_do_login()
end

function M:_update_status(status_value)
  if status_value == chat_model_status.online0 then
    E.LOG.d(TAG, "聊天准备-聊天已登录")
  elseif status_value == chat_model_status.online1 then
    E.LOG.d(TAG, "聊天准备-聊天已同步")
  else
    E.LOG.d(TAG, "聊天准备-已下线")
  end
  if self.status == "offline" and E.Utils.start_with(status_value, "online") then
    self.handler:info_chat_state("online")
  elseif "offline" == status_value then
    self.handler:info_chat_state("offline", self.last_offline_reason)
    self.last_offline_reason = nil
  end
  self.status = status_value
end

function M:_do_connect_when_needed()
  if next(self.rpc_process_time) then
    E.LOG.d(TAG, "rpc_process_time >>")
    E.LOG.d(TAG, self.rpc_process_time)
    return
  end
  if not EG.player_info() or 0 == #EG.player_info().player_id then
    E.LOG.d(TAG, "player_id is nil")
    return
  end
  if ECS.get_conn_status() then
    E.LOG.d(TAG, "ECS.get_conn_status() not nil")
    return
  end
  self.rpc_process_time[rpc_process_type.init_connect] = os.time()
  E.LOG.d(TAG, "聊天准备-新建连接...")
  ECS.init(EG.player_info(), false, {enable_cjson = true})
end

function M:retry_connect_delay_time(retry_connect_index_param)
  local random = 0
  if retry_connect_index_param > 1 then
    random = 2 * math.random()
  end
  local temp = 2 * (retry_connect_index_param - 1) + random
  temp = temp - temp % 0.01
  local delay_time = math.min(temp, self.retry_connect_max_time_gap or 30)
  delay_time = math.max(delay_time, 1)
  return delay_time
end

function M:_get_chat_token(retry_time)
  if next(self.rpc_process_time) then
    E.LOG.d(TAG, "rpc_process_time >>")
    E.LOG.d(TAG, self.rpc_process_time)
    return
  end
  retry_time = retry_time or 0
  E.LOG.d(TAG, "聊天准备-获取token...")
  self.rpc_process_time[rpc_process_type.get_chat_token] = os.time()
  chat_api.get_chat_token(function(succ, ...)
    self:_get_chat_token_cb(succ, retry_time, ...)
  end)
end

function M:_get_chat_token_cb(succ, retry_time, ...)
  E.LOG.d(TAG, "聊天准备-获取token结束, succ=" .. tostring(succ))
  self.rpc_process_time[rpc_process_type.get_chat_token] = nil
  if succ then
    if self.destroy_flag then
      return
    end
    local data = (...)
    chat_token.update_token_data(data)
    self:_do_connect_when_needed()
  else
    local code, msg = ...
    if 503 == code then
      if 0 == self.get_chat_token_code_503_first_time then
        self.get_chat_token_code_503_first_time = E.time()
      end
      if E.time() - self.get_chat_token_code_503_first_time >= 3600 then
        E.LOG.d(TAG, "chat_connect: fetch chat_token fail, server error")
        self.last_error_msg = "server error, detail:" .. tostring(msg)
        ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
        return
      end
    else
      self.get_chat_token_code_503_first_time = 0
    end
    if 401 == code then
      E.LOG.d(TAG, "chat_connect: fetch chat_token fail, player token expire")
      self.last_error_msg = "player token expire, detail:" .. tostring(msg)
      ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
      return
    end
    E.LOG.d(TAG, "chat_connect: fetch chat_token fail, then retry fetch, retry_time=" .. tostring(retry_time + 1))
    local delay_time = self:retry_connect_delay_time(retry_time)
    E.Timer.once(delay_time, function()
      self:_get_chat_token(retry_time + 1)
    end)
  end
end

function M:clear_rpc_process_time()
  self.rpc_process_time = {}
end

function M:_do_login()
  if self.rpc_process_time[rpc_process_type.do_login] then
    E.LOG.d(TAG, "do_login is running >>")
    return
  end
  if chat_token.is_chat_token_valid() and ECS.get_conn_status() == SOCKET.CHAT_CONNECTED or self.enable_connect == false and ECS.get_conn_status() == SOCKET.CHAT_CONNECTED then
    E.LOG.d(TAG, "聊天准备-登录中...:" .. tostring(self.user_type))
    self.rpc_process_time[rpc_process_type.do_login] = os.time()
    local destination = get_destination(self.user_type)
    ECS.login(destination, function(ret)
      self:_do_login_cb(ret)
    end)
  end
end

function M:_do_login_cb(ret)
  E.LOG.d(TAG, "聊天准备-登录结束, succ=" .. tostring(ret and 0 == ret.code))
  self.rpc_process_time[rpc_process_type.do_login] = nil
  if 0 == ret.code then
    self:_update_status(chat_model_status.online0)
    self:get_latest_session()
    self:_process_group_on_login(ret)
    local destination = get_destination(self.user_type)
    local login_result_params = {destination = destination, chat_version = 2}
    ET.publish(ET.chat.UPDATE_STATE, STATES.LOGIN_SUCC, login_result_params)
    if self.user_type == "player" then
      CALLBACK.callback(destination, CALLBACK.HANDLER_NAME.ON_LOGIN, true, {
        groups = ret.groups,
        ignore_data = ret.ignore_data
      })
    elseif self.user_type == "account" then
      CALLBACK.callback(destination, CALLBACK.HANDLER_NAME.ON_LOGIN, true, {})
    end
  end
end

function M:_merge_group(groups)
  local adds = {}
  local updates = {}
  for _, v in ipairs(groups) do
    if v and v.create_ts and not v.create_time then
      v.create_time = v.create_ts
    end
    local group_id = v.group_id
    if self.groups[group_id] == nil then
      adds[group_id] = v
    else
      updates[group_id] = v
    end
    self.groups[group_id] = v
  end
  return {
    adds = adds,
    updates = updates,
    removes = {}
  }
end

function M:_init_user_info()
  if "player" ~= self.user_type and self.user_type ~= "account" then
    ESTAT.stat_error_with_limit(TAG, "chat_err_init_user_info_error", "init_user_info_error", "chat_err", {
      msg = "user_type invalid"
    })
    return
  end
  if "player" == self.user_type then
    if EG.player_info() and EG.player_info().player_id then
      self.user_id = EG.player_info().player_id
    else
      E.LOG.i(TAG, "player_id not exist")
    end
  elseif self.user_type == "account" then
    if EG.user_info() and EG.user_info().uid then
      local account_id = EG.user_info().uid
      self.user_id = "acc_" .. account_id
    else
      E.LOG.i(TAG, "uid not exist")
    end
  end
  if self.user_id and #self.user_id > 0 then
    local key = _ejoysdk_crypt.hashkey(tostring(self.user_id))
    self.USER_ID_HASH = _ejoysdk_crypt.hexencode(key)
  end
end

function M:_sync_my_user_info()
  local ids = {}
  player_info.classify_ids(ids, self.user_id)
  player_info.batch_get_infos(ids, {scene = "chat"}, function(succ, ...)
    if not succ then
      chat_log.warn(chat_log_util.header(), TAG, "get_my_user_info_fail", {}, {})
    end
  end)
end

function M:add_callback(task_id, func)
  if nil == task_id then
    return false
  end
  self.callback[task_id] = func
  return true
end

function M:get_latest_session()
  if next(self.rpc_process_time) then
    E.LOG.d(TAG, "rpc_process_time >>")
    E.LOG.d(TAG, self.rpc_process_time)
    return
  end
  E.LOG.d(TAG, "聊天准备-同步会话...")
  local destination = get_destination(self.user_type)
  self.rpc_process_time[rpc_process_type.get_latest_session] = os.time()
  local params = {}
  params.cmd = "get_latest_session"
  if self.filter_sys_msg_group_types and #self.filter_sys_msg_group_types > 0 then
    params.filter_sys_msg_group_types = self.filter_sys_msg_group_types
  end
  ECS.rpc_call(destination, params, function(ret)
    if 0 == ret.code and ret.sessions then
      EC.replace_latest_sessions_user_info_before_cb(ret.sessions, function(replaced_sessions)
        local filter_sessions = {}
        for _, session in pairs(replaced_sessions) do
          local session_info = session.session_info
          local session_type = EC.get_session_type(session_info.id)
          for _, msg in pairs(session.last_msgs or {}) do
            self:_fill_arrival_msg_url(msg)
          end
          if session_type.type == EC.TYPE_PERSONAL or session_type.type == EC.TYPE_GROUP then
            session_info.is_ignore = self:is_ignore_session(session_info.id)
            local last_msgs = session.last_msgs
            for _, msg in pairs(last_msgs) do
              msg.is_ignore = session_info.is_ignore
            end
            if session_info.info and session_info.info.create_ts and not session_info.info.create_time then
              session_info.info.create_time = session_info.info.create_ts
            end
            if session_type.type == EC.TYPE_PERSONAL and session.session_info and not session.session_info.info and session.session_info._info then
              session.session_info.info = session.session_info._info
            end
            if session.earliest_at_msg_id and session.session_info then
              session.session_info.had_at_me_msg = true
            else
              session.session_info.had_at_me_msg = false
            end
            if session.session_info.info then
              table.insert(filter_sessions, session)
            end
          else
            table.insert(filter_sessions, session)
          end
        end
        ret.sessions = filter_sessions
        self:_get_latest_session_cb(ret)
      end, function()
        self:_get_latest_session_cb({
          code = CONSTANTS.CHAT_ERROR_CODES.CODE_FILL_PLAYER_INFO_FAIL,
          message = "get_player_info_failed"
        })
      end)
    else
      self:_get_latest_session_cb(ret)
    end
  end)
end

function M:_get_latest_session_cb(ret)
  E.LOG.d(TAG, "聊天准备-同步会话结束, succ=" .. tostring(0 == ret.code))
  self.rpc_process_time[rpc_process_type.get_latest_session] = nil
  if 0 == ret.code and ret.sessions then
    self:_update_status(chat_model_status.online1)
    local merge_session_ret = self:_merge_session(ret.sessions)
    local adds = merge_session_ret.adds
    local updates = merge_session_ret.updates
    if self.sync_blank_group_sessions and self.sync_group_flag == false then
      for group_id, group in pairs(self.groups or {}) do
        if not adds[group_id] then
          local session = self:_create_session_by_group(group)
          adds[group_id] = session
        end
      end
      self.sync_group_flag = true
    end
    if self.sync_blank_system_session and false == self.sync_system_flag then
      local system_session_id = self:get_system_session_id()
      if not adds[system_session_id] and system_session_id then
        local session = self:_create_system_session()
        local merge_session_system = self:_merge_session({session})
        if merge_session_system and merge_session_system.adds then
          adds[system_session_id] = session
        end
      end
      self.sync_system_flag = true
    end
    self:_info_chat_session_change(adds, updates, {})
  end
end

function M:get_sessions()
  return self.sessions or {}
end

function M:get_player_latest_at_msgs(cb)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.get_player_latest_at_msgs(destination, function(ret)
    self:_get_player_latest_at_msgs_cb(task_id, ret, cb)
  end)
  return task_id
end

function M:_get_player_latest_at_msgs_cb(task_id, ret, cb)
  if 0 == ret.code and ret.msgs then
    self:_update_msg_reader_status(ret.msgs)
  end
  self:_info_chat_rpc_result(task_id, "get_player_latest_at_msgs", ret)
  if cb then
    cb(ret)
  end
end

function M:tick()
  if self.destroy_flag then
    return
  end
  ECS.tick()
end

function M:rpc_call(_params, cb)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.rpc_call(destination, _params, function(ret)
    local cmd = _params.cmd or ""
    self:_rpc_call_cb(task_id, cmd, ret, cb)
  end)
  return task_id
end

function M:_rpc_call_cb(task_id, cmd, ret, cb)
  self:_info_chat_rpc_result(task_id, cmd, ret)
  if cb then
    cb(ret)
  end
end

function M:get_session_msg(iter_data, search_direction, max_msg_count, options)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.session_id = iter_data.session_id
  params.search_direction = search_direction
  params.max_msg_count = max_msg_count
  params.ts = iter_data.ts
  params.msg_id = iter_data.msg_id
  if iter_data.msg_ids then
    params.msg_ids = iter_data.msg_ids
  end
  params.cmd = "get_session_msg"
  ECS.rpc_call(destination, params, function(ret)
    self:_get_session_msg_cb(task_id, params.session_id, ret, options)
  end)
  return task_id
end

function M:_get_session_msg_cb(task_id, session_id, ret, options)
  if 0 == ret.code and ret.msgs and next(ret.msgs) ~= nil then
    local msgs = ret.msgs
    local is_ignore = self:is_ignore_session(session_id)
    for _, msg in pairs(msgs) do
      msg.is_ignore = is_ignore
      if not msg._msg_sdk_src then
        msg._msg_sdk_src = options and options._msg_sdk_src or "get_session_msg"
      end
      for _, res in pairs(msg.reply_res or {}) do
        if nil == res.has_me then
          res.has_me = false
          for __, user_id in pairs(res.user_ids) do
            if user_id == self.user_id then
              res.has_me = true
              break
            end
          end
        end
      end
      self:_fill_arrival_msg_url(msg)
    end
    self:_update_msg_reader_status(msgs)
    EC.replace_msgs_user_info_before_cb(msgs, function(replace_msg)
      table.sort(replace_msg, msg_util.smaller)
      self:update_session_msgs(session_id, replace_msg)
      E_UTILS.reset_deepcopy_only_once_record()
      self:_info_chat_rpc_result(task_id, "get_session_msg", ret)
    end, function()
      table.sort(msgs, msg_util.smaller)
      self:update_session_msgs(session_id, msgs)
      E_UTILS.reset_deepcopy_only_once_record()
      self:_info_chat_rpc_result(task_id, "get_session_msg", ret)
    end, self.need_replace_reply_res_user_info)
  else
    self:_info_chat_rpc_result(task_id, "get_session_msg", ret)
  end
end

function M:_update_msg_reader_status(msgs)
  if not msgs or not next(msgs) then
    return
  end
  local msg_status_constant = msg_util.msg_status()
  local msg_received_cache = self.set_msg_received_cache
  if not msg_received_cache then
    return
  end
  for _, msg in pairs(msgs) do
    local cached_max_received_ts = msg_received_cache[msg.session_id] and msg_received_cache[msg.session_id].last_max_received_ts
    if cached_max_received_ts and cached_max_received_ts >= msg.ts and msg.reader_status == msg_status_constant.server_received and msg.src_id ~= self.user_id then
      msg.reader_status = msg_status_constant.user_received
    end
  end
end

function M:get_to_user_session_id(user_id)
  local user_id1, user_id2 = self.user_id, user_id
  if user_id1 > user_id2 then
    user_id1, user_id2 = user_id2, user_id1
  end
  do return string.format, "%s:%s", user_id1 end
  return string.format, "%s:%s", user_id1, user_id2
end

function M:get_system_session_id()
  if not self.user_id then
    return nil
  end
  do return string.format, "system:%s" end
  return string.format, "system:%s", self.user_id
end

function M:send_rich_text(session_id, data, at_list, quote_msg_ids)
  local content = {
    type = "rich_text",
    plain_text = data.plain_text,
    data = {
      text = data.text,
      extend_data = data.extend_data
    }
  }
  do return self.send, self, "send_rich_text", session_id, content, at_list end
  return self.send, self, "send_rich_text", session_id, content, at_list, quote_msg_ids
end

function M:send(task_name, session_id, content, at_list, quote_msg_ids, last_send_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.session_id = session_id
  params.send_id = last_send_id or ECS.send_id()
  if quote_msg_ids and next(quote_msg_ids) then
    params.quote_msg_ids = quote_msg_ids
  end
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  local mock_msg = self:_create_mock_msg(params)
  self.msg_send_cache[params.send_id] = params
  E_UTILS.reset_deepcopy_only_once_record()
  self:update_session_msgs(session_id, {mock_msg})
  ECS.rpc_call(destination, params, function(ret)
    if ret and ret.send_id == nil then
      ret.send_id = params.send_id
    end
    self:_send_cb(task_id, task_name, mock_msg, ret)
  end)
  return task_id
end

function M:_send_cb(task_id, task_name, mock_msg, ret)
  self:_info_chat_rpc_result(task_id, task_name, ret)
  if 0 == ret.code then
    self.msg_send_cache[mock_msg.send_id] = nil
  elseif mock_msg then
    mock_msg.reader_status = msg_util.msg_status().failed
    mock_msg.send_failed_code = ret.code or -1
    mock_msg.is_local_msg = true
    E_UTILS.reset_deepcopy_only_once_record()
    self:update_session_msgs(mock_msg.session_id, {mock_msg})
  end
end

function M:resend(_send_id)
  local params = self.msg_send_cache[_send_id] or {}
  do return self.send, self, "resend", params.session_id, params.content, params.at_list, params.quote_msg_ids end
  return self.send, self, "resend", params.session_id, params.content, params.at_list, params.quote_msg_ids, _send_id
end

function M:send_rich_text_mock(session_id, data, at_list, quote_msg_ids)
  local content = {
    type = "rich_text",
    plain_text = data.plain_text,
    data = {
      text = data.text,
      extend_data = data.extend_data
    }
  }
  do return self.send_mock, self, session_id, content, at_list end
  return self.send_mock, self, session_id, content, at_list, quote_msg_ids
end

function M:send_mock(session_id, content, at_list, quote_msg_ids)
  local params = {}
  params.session_id = session_id
  params.send_id = ECS.send_id()
  if quote_msg_ids and next(quote_msg_ids) then
    params.quote_msg_ids = quote_msg_ids
  end
  params.content = content
  params.cmd = "send"
  if at_list and type(at_list) == "table" and next(at_list) ~= nil then
    params.at_list = at_list or {}
  end
  local mock_msg = self:_create_mock_msg(params)
  E_UTILS.reset_deepcopy_only_once_record()
  self:update_session_msgs(session_id, {mock_msg})
  return mock_msg
end

function M:reply_msg(session_id, msg_id, reply_data)
  local current_time = E.system_clock()
  if current_time - last_time_reply_msg < REPLY_MSG_LIMIT then
    return nil
  end
  last_time_reply_msg = current_time
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.session_id = session_id
  params.msg_id = msg_id
  params.reply_data = reply_data
  params.cmd = "reply_msg"
  local msg_with_mock_reply_res, op_info = self:_create_mock_reply_res(params)
  if msg_with_mock_reply_res then
    self:update_session_msgs(session_id, {msg_with_mock_reply_res})
  end
  local mock_params = {}
  mock_params.data = params
  mock_params.op_info = op_info
  ECS.rpc_call(destination, params, function(ret)
    self:_reply_msg_cb(task_id, "reply_msg", mock_params, ret)
  end)
  return task_id
end

function M:_reply_msg_cb(task_id, task_name, mock_params, ret)
  self:_info_chat_rpc_result(task_id, task_name, ret)
  if 0 ~= ret.code then
    local data = mock_params.data
    local session_msgs = self.session_msgs[data.session_id]
    if not session_msgs then
      return nil
    end
    local msg_infos = session_msgs:get_mapped_msg() or {}
    local msg = msg_infos[data.msg_id]
    if not msg then
      return nil
    end
    if not msg.reply_res then
      msg.reply_res = {}
    end
    local op_type = data.reply_data.op_type
    local op_info = mock_params.op_info
    local self_user_id = op_info.self_user_id
    if "put" == op_type then
      local res_type = data.reply_data.res_type
      local res_id = data.reply_data.res_id
      for i, res in pairs(msg.reply_res) do
        if res.res_type == res_type and res.res_id == res_id and res.user_ids[1] == self_user_id then
          table.remove(res.user_ids, 1)
          res.user_num = res.user_num - 1
          res.has_me = false
          if 0 == #res.user_ids then
            table.remove(msg.reply_res, i)
          end
          break
        end
      end
    elseif "delete" == op_type and op_info.delete_user_id_index then
      local del_res = op_info.delete_res
      local del_res_idx = op_info.delete_res_index
      local del_usr_idx = op_info.delete_user_id_index
      del_res.user_num = del_res.user_num + 1
      del_res.has_me = true
      if 1 == #del_res.user_ids then
        table.insert(msg.reply_res, del_res_idx, del_res)
      elseif del_usr_idx then
        table.insert(del_res.user_ids, del_usr_idx, self_user_id)
      end
    end
    self:update_session_msgs(data.session_id, {msg})
  end
end

function M:get_msg_res(session_id, query, limit, skip)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.query = query
  params.limit = limit
  params.skip = skip
  params.cmd = "get_msg_res"
  ECS.rpc_call(destination, params, function(ret)
    self:_get_msg_res_cb(task_id, "get_msg_res", session_id, params, ret)
  end)
  return task_id
end

function M:_get_msg_res_cb(task_id, task_name, session_id, params, ret)
  local query = params.query
  local skip = params.skip
  self:_info_chat_rpc_result(task_id, task_name, ret)
  if 0 ~= ret.code then
    return
  end
  local session_msgs = self.session_msgs[session_id]
  if not session_msgs then
    return
  end
  local msg_infos = session_msgs:get_mapped_msg() or {}
  local msg = msg_infos[query.msg_id]
  if not msg then
    return
  end
  for _, res in pairs(msg.reply_res or {}) do
    if res.res_id == query.res_id and res.res_type == query.res_type then
      local res_user_ids = res.user_ids
      local returned_user_ids = ret.user_ids
      for i = 1, ret.user_num do
        res_user_ids[i + skip] = returned_user_ids[i]
      end
      break
    end
  end
  EC.replace_reply_res_user_info_before_cb(msg, function(new_msgs)
    self:update_session_msgs(session_id, new_msgs, "get_msg_res")
  end, self.need_replace_reply_res_user_info)
end

function M:recall_msg(_params)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  for k, v in pairs(_params) do
    params[k] = v
  end
  params.cmd = "recall_msg"
  ECS.rpc_call(destination, params, function(ret)
    self:_recall_msg_cb(task_id, "recall_msg", ret)
  end)
  return task_id
end

function M:_recall_msg_cb(task_id, task_name, ret)
  self:_info_chat_rpc_result(task_id, task_name, ret)
end

function M:create_to_user_session(to_id)
  if not to_id then
    E.LOG.debug(TAG, "create_to_user_session fail, to_id is nil")
    return nil
  end
  if not self.user_id then
    E.LOG.debug(TAG, "create_to_user_session fail, chat not login")
    return nil
  end
  local task_id = self:get_task_id()
  local session_id = self:get_to_user_session_id(to_id)
  self:_create_mock_session_by_session_id(session_id, function(succ, ...)
    if succ then
      local session = (...)
      self:_create_to_user_session_cb(true, task_id, session)
      local merge_session_ret = self:_merge_session({session})
      local adds = merge_session_ret.adds
      local updates = merge_session_ret.updates
      self:_info_chat_session_change(adds, updates, {})
    else
      local ret = (...)
      local code = ret and ret.code or -1
      local msg = ret and ret.msg or "create to user session fail"
      self:_create_to_user_session_cb(false, task_id, {code = code, msg = msg})
    end
  end)
  return task_id
end

function M:refresh_session_new_info(_session_id)
  if not _session_id then
    return
  end
  local old_session_data = self.sessions[_session_id]
  local session_type = EC.get_session_type(_session_id)
  if old_session_data and session_type.type == EC.TYPE_PERSONAL then
    EC.replace_latest_sessions_user_info_before_cb({old_session_data}, function(sessions)
      if nil == sessions[1] or sessions[1] and nil == sessions[1].session_info then
        return
      end
      if sessions[1] and session_type.type == EC.TYPE_PERSONAL and sessions[1].session_info and sessions[1].session_info._info then
        sessions[1].session_info.info = sessions[1].session_info._info
      end
      if nil == sessions[1].session_info.info then
        return
      end
      local merge_session_ret = self:_merge_session(sessions)
      local adds = merge_session_ret.adds
      local updates = merge_session_ret.updates
      E_UTILS.reset_deepcopy_only_once_record()
      self:_info_chat_session_change(adds, updates, {})
    end, function()
    end)
  end
end

function M:_create_to_user_session_cb(_succ, task_id, ret)
  E.Timer.once(0.1, function()
    self:_info_chat_rpc_result(task_id, "create_to_user_session", ret)
  end)
end

function M:init_set_msg_received_timer()
  if not self.timer_initialized then
    self.set_msg_received_cache = {}
    self.timer_initialized = true
    self:start_periodic_flush()
  end
end

function M:start_periodic_flush()
  local function flush()
    for session_id, _session_info in pairs(self.set_msg_received_cache) do
      local destination = get_destination(self.user_type)
      
      if _session_info.max_received_ts > 0 then
        local max_req = {
          session_id = session_id,
          received_ts = _session_info.max_received_ts,
          cmd = "set_msg_received"
        }
        ECS.rpc_call(destination, max_req, function(ret)
          if 0 ~= ret.code then
            E.LOG.debug(TAG, "set_msg_received fail, code: " .. tostring(ret and ret.code))
            return
          end
        end)
      end
      self.set_msg_received_cache[session_id].max_received_ts = 0
    end
    if self.timer_initialized and not self.destroy_flag then
      E.Timer.once(10, flush)
    end
  end
  
  E.Timer.once(1, flush)
end

function M:set_msg_received(session_id, received_ts)
  self:init_set_msg_received_timer()
  local task_id = self:get_task_id()
  local received_ts_is_nil = false
  if not received_ts then
    received_ts = math.floor(E.time()) + 1
    received_ts_is_nil = true
  end
  local req = {
    session_id = session_id,
    received_ts = received_ts,
    cmd = "set_msg_received",
    received_ts_is_nil = received_ts_is_nil
  }
  local _sdk_local_received = false
  if not self.set_msg_received_cache[session_id] then
    self.set_msg_received_cache[session_id] = {max_received_ts = received_ts, last_max_received_ts = received_ts}
    _sdk_local_received = true
  elseif received_ts > self.set_msg_received_cache[session_id].last_max_received_ts then
    self.set_msg_received_cache[session_id].max_received_ts = received_ts
    self.set_msg_received_cache[session_id].last_max_received_ts = received_ts
    _sdk_local_received = true
  end
  E.Timer.once(0.1, function()
    self:_set_msg_received_cb(task_id, {
      code = 0,
      message = "ok",
      _sdk_local_received = _sdk_local_received,
      cmd = "set_msg_received",
      rpc_id = ""
    }, req)
  end)
  return task_id
end

function M:_set_msg_received_cb(task_id, ret, req)
  local session_id = req.session_id
  local received_ts = req.received_ts
  local received_ts_is_nil = req.received_ts_is_nil
  self:_info_chat_rpc_result(task_id, "set_msg_received", ret)
  if 0 ~= ret.code or ret._sdk_local_received == false then
    return
  end
  local msg_status_constant = msg_util.msg_status()
  local session_msg = self.session_msgs[session_id]
  E_UTILS.reset_deepcopy_only_once_record()
  if nil ~= session_msg then
    local idx = session_msg:_find_idx_from_back(function(msg)
      return msg.reader_status == msg_status_constant.user_received
    end)
    local msgs = session_msg:get_msg_by_range(idx + 1, nil)
    local change_msgs = {}
    local recall_msgs = {}
    for _, msg in ipairs(msgs) do
      if msg.reader_status == msg_status_constant.server_received and msg.src_id ~= self.user_id and (nil == received_ts or received_ts >= msg.ts) then
        msg.reader_status = msg_status_constant.user_received
        table.insert(change_msgs, msg)
      end
      if msg.reader_status == msg_status_constant.recall and msg.src_id ~= self.user_id and (nil == received_ts or received_ts >= msg.ts) then
        table.insert(recall_msgs, msg)
      end
    end
    local unread_after = self:_get_session_unread_count(msgs, nil)
    local old_session_data = self.sessions[session_id]
    if nil ~= next(change_msgs) then
      if nil ~= old_session_data and old_session_data.session_info.unread > 0 then
        if nil == received_ts then
          self:_set_session_unread(session_id, 0, false)
        else
          self:_set_session_unread(session_id, unread_after, false)
        end
        local updates = {
          [session_id] = old_session_data
        }
        self:_info_chat_session_change({}, updates, {})
      end
    elseif nil ~= next(recall_msgs) then
      if nil ~= old_session_data and old_session_data.session_info.unread > 0 then
        self:_set_session_unread(session_id, received_ts and unread_after or 0, false)
        local updates = {
          [session_id] = old_session_data
        }
        self:_info_chat_session_change({}, updates, {})
      end
    elseif nil ~= old_session_data and old_session_data.session_info.unread > 0 and received_ts_is_nil then
      self:_set_session_unread(session_id, 0, false)
      local updates = {
        [session_id] = old_session_data
      }
      self:_info_chat_session_change({}, updates, {})
    elseif nil ~= old_session_data and 0 == old_session_data.session_info.unread and old_session_data.session_info.had_at_me_msg then
      self:_set_session_unread(session_id, 0, false)
      local updates = {
        [session_id] = old_session_data
      }
      self:_info_chat_session_change({}, updates, {})
    end
  else
    local old_session_data = self.sessions[session_id]
    if nil ~= old_session_data and old_session_data.session_info.unread > 0 then
      self:_set_session_unread(session_id, 0, false)
      local updates = {
        [session_id] = old_session_data
      }
      self:_info_chat_session_change({}, updates, {})
    end
  end
end

function M:create_group(members, invite_msg, info, attr)
  assert(nil ~= info, "info is nil")
  assert(nil ~= info.name, "info.name is nil")
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  members = members or {}
  if 0 == #members then
    table.insert(members, self.user_id)
  end
  local params = {}
  params.members = members
  params.invite_msg = invite_msg
  params.info = info
  if attr and "table" == type(attr) then
    params.attr = attr
  end
  params.cmd = "create_group"
  ECS.rpc_call(destination, params, function(ret)
    self:_create_group_cb(task_id, ret)
  end)
  return task_id
end

function M:_create_group_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "create_group", ret)
end

function M:add_group_member(adds, invite_msg, group_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.adds = adds
  params.invite_msg = invite_msg
  params.group_id = group_id
  params.cmd = "add_group_member"
  ECS.rpc_call(destination, params, function(ret)
    self:_add_group_member_cb(task_id, ret)
  end)
  return task_id
end

function M:_add_group_member_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "add_group_member", ret)
end

function M:reply_add_group_member(reply_msg, is_agree, group_id, inviter_user_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.reply_msg = reply_msg
  params.is_agree = is_agree
  params.group_id = group_id
  params.cmd = "reply_add_group_member"
  if inviter_user_id then
    params.inviter_user_id = inviter_user_id
  end
  ECS.rpc_call(destination, params, function(ret)
    self:_reply_add_group_member_cb(task_id, ret)
  end)
  return task_id
end

function M:_reply_add_group_member_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "reply_add_group_member", ret)
end

function M:remove_group_member(removes, remove_msg, group_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.removes = removes
  params.message = remove_msg
  params.group_id = group_id
  params.cmd = "remove_group_member"
  ECS.rpc_call(destination, params, function(ret)
    self:_remove_group_member_cb(task_id, ret)
  end)
  return task_id
end

function M:_remove_group_member_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "remove_group_member", ret)
end

function M:update_group(info, group_id, attr)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.info = info
  params.group_id = group_id
  if attr then
    params.attr = attr
  end
  params.cmd = "update_group"
  ECS.rpc_call(destination, params, function(ret)
    self:_update_group_cb(task_id, ret)
  end)
  return task_id
end

function M:_update_group_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "update_group", ret)
end

function M:audit_group_reserve_member(_params, cb)
  _params = _params or {}
  _params.cmd = "audit_group_reserve_member"
  do return self.rpc_call, self, _params end
  return self.rpc_call, self, _params, cb
end

function M:get_group_reserve_member(_params, cb)
  _params = _params or {}
  _params.cmd = "get_group_reserve_member"
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.rpc_call(destination, _params, function(ret)
    self:_get_group_reserve_member_cb(task_id, _params.cmd, ret, cb)
  end)
  return task_id
end

function M:_get_group_reserve_member_cb(task_id, cmd, ret, cb)
  if 0 == ret.code and ret.data and next(ret.data) ~= nil then
    local reserve_member_data = ret.data
    EC.replace_groups_reserve_member_data(reserve_member_data, function(replace_reserve_member_data)
      ret.data = replace_reserve_member_data
      self:_info_chat_rpc_result(task_id, cmd, ret)
      if cb then
        cb(ret)
      end
    end, function()
      self:_info_chat_rpc_result(task_id, cmd, ret)
      if cb then
        cb(ret)
      end
    end)
  else
    self:_info_chat_rpc_result(task_id, cmd, ret)
    if cb then
      cb(ret)
    end
  end
end

function M:delete_group(group_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.group_id = group_id
  params.cmd = "delete_group"
  ECS.rpc_call(destination, params, function(ret)
    self:_delete_group_cb(task_id, ret)
  end)
  return task_id
end

function M:_delete_group_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "delete_group", ret)
end

function M:exit_group(group_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.group_id = group_id
  params.cmd = "exit_group"
  ECS.rpc_call(destination, params, function(ret)
    self:_exit_group_cb(task_id, ret)
  end)
  return task_id
end

function M:_exit_group_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "exit_group", ret)
end

function M:get_group_be_invited_history()
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.cmd = "get_group_be_invited_history"
  ECS.rpc_call(destination, params, function(ret)
    self:_get_group_be_invited_history_cb(task_id, ret)
  end)
  return task_id
end

function M:_get_group_be_invited_history_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "get_group_be_invited_history", ret)
end

function M:report_msg(report_type_id, report_desc, session_id, msg_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.cmd = "report_msg"
  params.report_type_id = report_type_id
  params.report_desc = report_desc
  params.session_id = session_id
  params.msg_id = msg_id
  ECS.rpc_call(destination, params, function(ret)
    self:_report_msg_cb(task_id, ret)
  end)
  return task_id
end

function M:_report_msg_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "report_msg", ret)
end

function M:get_chat_config()
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  params.cmd = "get_chat_config"
  ECS.rpc_call(destination, params, function(ret)
    self:_get_chat_config_cb(task_id, ret)
  end)
  return task_id
end

function M:_get_chat_config_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "get_chat_config", ret)
end

function M:set_chat_config(chat_config)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  local params = {}
  local safe_chat_config = chat_config
  local safe_push_config = chat_config.push
  if nil ~= safe_push_config then
    local group_types = safe_push_config.push_on_group_types
    if group_types and nil == next(group_types) then
      local JSON = require("ejoysdk_lua.ejoysdk_json")
      group_types = JSON.newArray()
      safe_push_config.push_on_group_types = group_types
      safe_chat_config.push = safe_push_config
      params.ejoysdk_pack_data_options = {encode_empty_array = true}
    end
  end
  params.config = safe_chat_config
  params.cmd = "set_chat_config"
  ECS.rpc_call(destination, params, function(ret)
    self:_set_chat_config_cb(task_id, ret)
  end)
  return task_id
end

function M:_set_chat_config_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "set_chat_config", ret)
end

function M:fill_chat_group_invite_msgs(msgs, cb)
  local inviter_ids = {}
  for _, msg in pairs(msgs) do
    if msg.content.type == "chat_group_invite" then
      local invite_msg = msg.content.data
      local user_id = invite_msg.inviter.user_id
      table.insert(inviter_ids, user_id)
    end
  end
  if #inviter_ids > 0 then
    player_info.get_player_infos(inviter_ids, {
      playerid_to_info = true,
      scene = player_scene.OFFICIAL_SCENE.CHAT
    }, function(succ, ...)
      if succ then
        local players = (...)
        for _, msg in pairs(msgs) do
          if msg.content.type == "chat_group_invite" then
            local invite_msg = msg.content.data
            local user_id = invite_msg.inviter.user_id
            if players[user_id] then
              invite_msg.inviter = players[user_id]
              invite_msg.inviter.user_id = user_id
            end
          end
        end
        cb(true)
        return
      else
        cb(false)
      end
    end)
  end
  cb(false)
end

function M:_fill_arrival_msg_url(msg)
  if not msg.content or msg.content.type ~= "arrival" then
    return
  end
  local res = msg.content.data and msg.content.data.res
  for _, res_item in pairs(res or {}) do
    if res_item.mimeType and E.Utils.start_with(res_item.mimeType, "image/") then
      local res_key = res_item.key or "nil"
      res_item.image_url = (E_UTILS.get_media_base_url() or "") .. "/" .. res_key
      E.LOG.debug(TAG, "fill_arrival_msg_url, key: " .. res_key .. ", image_url: " .. res_item.image_url .. ", size: " .. (res_item.size or "nil"))
    end
  end
end

function M:update_recalled_msgs_quoted_state(session_id, recalled_msg_id, cb)
  local session_msgs = self.session_msgs[session_id]
  if not session_msgs then
    return
  end
  local updated_msgs = {}
  local msg_infos = session_msgs:get_mapped_msg() or {}
  for _, search_quote_msg in pairs(msg_infos) do
    for __, quote_msg in pairs(search_quote_msg.quote_msgs or {}) do
      if quote_msg.msg_id == recalled_msg_id and quote_msg.reader_status ~= msg_util.msg_status().recall then
        quote_msg.reader_status = msg_util.msg_status().recall
        table.insert(updated_msgs, search_quote_msg)
        break
      elseif quote_msg.msg_id == recalled_msg_id then
        break
      end
    end
  end
  cb(updated_msgs)
end

function M:update_session_msgs(session_id, msgs, _in_src)
  if next(msgs) == nil then
    self:_info_chat_msgs(session_id, msgs)
    return
  end
  for idx = 2, #msgs do
    local v = msgs[idx]
    assert(session_id == v.session_id, "update_session_msgs but session_id not the same")
  end
  local session_adds = {}
  local session_updates = {}
  
  local function exe_handler()
    if next(session_adds) ~= nil or next(session_updates) ~= nil then
      self:_info_chat_session_change(session_adds, session_updates, {})
    end
    self:_info_chat_msgs(session_id, msgs)
    self.session_msgs[session_id] = self.session_msgs[session_id] or chat_session_msg_class:New()
    local session_msg = self.session_msgs[session_id]
    session_msg:merge_msgs(msgs)
    local session_msg_count = session_msg:count()
    local max_msg_count = 1000
    if session_msg_count > max_msg_count then
      session_msg:delete_msg_by_range(1, session_msg_count - max_msg_count)
    end
  end
  
  if nil == self.sessions[session_id] then
    self:_create_mock_session_by_msgs(msgs, function(_succ, mock_session)
      local session_type = EC.get_session_type(session_id)
      if "info_msg" == _in_src and (session_type.type == EC.TYPE_GROUP or session_type.type == EC.TYPE_PERSONAL) and mock_session.session_info and not mock_session.session_info.info then
        E.LOG.debug(TAG, "session_info info is nil and return")
        return
      end
      self.sessions[session_id] = mock_session
      session_adds[session_id] = mock_session
      exe_handler()
    end)
  else
    local last_visible_msgs, last_invisible_msgs = self:_filter_visible_msgs(self.sessions[session_id].last_msgs)
    local orig_last_msg = last_visible_msgs[1]
    local orig_last_inv_msg
    if next(last_invisible_msgs) then
      orig_last_inv_msg = last_invisible_msgs[1]
    end
    local new_visible_msgs = self:_filter_visible_msgs(msgs)
    local new_last_msg
    if next(new_visible_msgs) then
      new_last_msg = self:_found_last_msg(new_visible_msgs, session_id)
    end
    local real_new_last_msg = self:_found_last_msg(msgs, session_id)
    local has_new_invisible_last_msg = false
    if real_new_last_msg and self.is_msg_visible(real_new_last_msg) == false and (msg_util.smaller(orig_last_inv_msg, real_new_last_msg) or orig_last_inv_msg.send_id and real_new_last_msg.send_id and orig_last_inv_msg.send_id == real_new_last_msg.send_id) then
      self.sessions[session_id].last_msgs = {real_new_last_msg}
      session_updates[session_id] = self.sessions[session_id]
      has_new_invisible_last_msg = true
    end
    if new_last_msg and (not orig_last_msg or msg_util.smaller(orig_last_msg, new_last_msg) or orig_last_msg.send_id and new_last_msg.send_id and orig_last_msg.send_id == new_last_msg.send_id) then
      if not has_new_invisible_last_msg then
        self.sessions[session_id].last_msgs = {new_last_msg}
      else
        table.insert(self.sessions[session_id].last_msgs, new_last_msg)
      end
      session_updates[session_id] = self.sessions[session_id]
      if new_last_msg.at_list and nil ~= next(new_last_msg.at_list) and session_updates[session_id].session_info then
        for _, av in pairs(new_last_msg.at_list) do
          if av == (EG.player_info() and EG.player_info().player_id) and new_last_msg.src_id ~= av then
            if session_updates[session_id].session_info.unread > 0 then
              session_updates[session_id].session_info.had_at_me_msg = true
            else
              session_updates[session_id].session_info.had_at_me_msg = false
            end
          end
        end
      end
    elseif has_new_invisible_last_msg and orig_last_msg then
      table.insert(self.sessions[session_id].last_msgs, orig_last_msg)
    end
    exe_handler()
  end
end

function M:is_msg_visible(msg)
  if not msg then
    return nil
  end
  for _, c_flag in pairs(msg.c_flags or {}) do
    if "invisible_to_user" == c_flag then
      return false
    end
  end
  return true
end

function M:_filter_visible_msgs(msgs)
  if not msgs then
    return nil
  end
  local visible_msgs = {}
  local invisible_msgs = {}
  for _, msg in pairs(msgs) do
    local visible_to_user = self:is_msg_visible(msg)
    if visible_to_user then
      table.insert(visible_msgs, msg)
    else
      table.insert(invisible_msgs, msg)
    end
  end
  return visible_msgs, invisible_msgs
end

function M:_create_mock_session_by_msgs(msgs, cb)
  local ret = {}
  table.sort(msgs, msg_util.smaller)
  local session_info = {}
  session_info.id = msgs[1].session_id
  session_info.is_ignore = EC.is_ignore_session(msgs[1].session_id) or false
  ret.session_info = session_info
  local session_type = EC.get_session_type(session_info.id)
  if session_type.type == EC.TYPE_GROUP then
    ret.session_info.info = self.groups[session_info.id]
  end
  session_info.unread = self:_get_session_unread_count(msgs, session_type.type)
  local last_msg = self:_found_last_msg(msgs, session_info.id, session_type.type)
  if last_msg then
    ret.last_msgs = {last_msg}
  else
    ret.last_msgs = {}
  end
  EC.replace_latest_sessions_user_info_before_cb({ret}, function(sessions)
    if sessions[1] and session_type.type == EC.TYPE_PERSONAL and sessions[1].session_info and not sessions[1].session_info.info and sessions[1].session_info._info then
      sessions[1].session_info.info = sessions[1].session_info._info
    end
    if sessions[1] and sessions[1].session_info and sessions[1].session_info.info == nil then
      ret.code = CONSTANTS.CHAT_ERROR_CODES.CODE_USER_INFO_NOT_FOUND
      ret.msg = "not found user_info to create session"
      cb(false, ret)
      return
    end
    cb(true, sessions[1])
  end, function()
    ret.code = CONSTANTS.CHAT_ERROR_CODES.CODE_USER_INFO_REQUEST_FAIL
    ret.msg = "request user_info failed to create session"
    cb(false, ret)
  end)
end

function M:_create_system_session()
  local ret = {}
  local session_info = {}
  session_info.unread = 0
  session_info.id = self:get_system_session_id()
  session_info.is_ignore = chat_cache.is_ignore_session() or false
  ret.session_info = session_info
  ret.last_msgs = {}
  return ret
end

function M:_create_mock_session_by_session_id(session_id, cb)
  local ret = {}
  ret.last_msgs = {}
  local session_info = {}
  session_info.id = session_id
  session_info.unread = 0
  session_info.is_ignore = EC.is_ignore_session(session_id) or false
  ret.session_info = session_info
  local session_type = EC.get_session_type(session_info.id)
  if session_type.type == EC.TYPE_GROUP then
    ret.session_info.info = self.groups[session_info.id]
  end
  EC.replace_latest_sessions_user_info_before_cb({ret}, function(sessions)
    if sessions[1] and session_type.type == EC.TYPE_PERSONAL and sessions[1].session_info and not sessions[1].session_info.info and sessions[1].session_info._info then
      sessions[1].session_info.info = sessions[1].session_info._info
    end
    if sessions[1] and sessions[1].session_info and sessions[1].session_info.info == nil then
      ret.code = CONSTANTS.CHAT_ERROR_CODES.CODE_USER_INFO_NOT_FOUND
      ret.msg = "not found user_info to create session"
      cb(false, ret)
      return
    end
    cb(true, sessions[1])
  end, function()
    ret.code = CONSTANTS.CHAT_ERROR_CODES.CODE_USER_INFO_REQUEST_FAIL
    ret.msg = "request user_info failed to create session"
    cb(false, ret)
  end)
end

function M:_create_session_by_group(group)
  local ret = {}
  local session_info = {}
  session_info.unread = 0
  session_info.id = group.group_id
  session_info.info = group
  session_info.is_ignore = chat_cache.is_ignore_session(group.group_id) or false
  ret.session_info = session_info
  ret.last_msgs = {}
  local session_type = EC.get_session_type(session_info.id)
  if session_type.type == EC.TYPE_GROUP then
    ret.session_info.info = self.groups[session_info.id] or {}
  else
    ESTAT.stat_error_with_limit(TAG, "chat_err_create_session_by_group_fail", "chat_err_create_session_by_group_fail", "chat_err", {
      msg = "session_type info type data invalid"
    })
  end
  return ret
end

function M:_create_mock_reply_res(data)
  if not (data and data.session_id and data.msg_id) or not data.reply_data then
    return nil
  end
  local session_msgs = self.session_msgs[data.session_id]
  if not session_msgs then
    return nil
  end
  local msg_infos = session_msgs:get_mapped_msg() or {}
  local msg = msg_infos[data.msg_id]
  if not msg then
    return nil
  end
  if not msg.reply_res then
    msg.reply_res = {}
  end
  local self_user_id = self.user_id
  local op_info = {self_user_id = self_user_id}
  local op_type = data.reply_data.op_type
  local res_type = data.reply_data.res_type
  local res_id = data.reply_data.res_id
  if "put" == op_type then
    local has_res = false
    for _, res in pairs(msg.reply_res) do
      if res.res_type == res_type and res.res_id == res_id then
        has_res = true
        table.insert(res.user_ids, 1, self_user_id)
        res.user_num = res.user_num + 1
        res.has_me = true
        break
      end
    end
    if not has_res then
      local msg_res = {}
      msg_res.res_id = res_id
      msg_res.res_type = res_type
      msg_res.user_num = 1
      msg_res.user_ids = {}
      msg_res.has_me = true
      table.insert(msg_res.user_ids, self_user_id)
      table.insert(msg.reply_res, msg_res)
    end
    if not msg.reply_res_src_infos then
      msg.reply_res_src_infos = {}
    end
    local need_replace = self.need_replace_reply_res_user_info
    if need_replace and self.user_type == "player" then
      msg.reply_res_src_infos[self_user_id] = player_cache.get_player_info_with_ignore_expire_time(EG.player_info().player_id, "chat")
    elseif need_replace and self.user_type == "account" then
      msg.reply_res_src_infos[self_user_id] = player_cache.get_account_info_with_ignore_expire_time(EG.user_info().uid)
    end
  elseif "delete" == op_type then
    local delete_res, delete_res_index, delete_user_id_index
    for i, res in pairs(msg.reply_res) do
      if res.res_type == res_type and res.res_id == res_id then
        delete_res_index = i
        res.user_num = res.user_num - 1
        res.has_me = false
        delete_res = E_UTILS.deepcopy(res)
        for j, user_id in pairs(res.user_ids) do
          if user_id == self_user_id then
            table.remove(res.user_ids, j)
            delete_user_id_index = j
            break
          end
        end
        if 0 == #res.user_ids then
          table.remove(msg.reply_res, i)
        end
        break
      end
    end
    op_info.delete_res = delete_res
    op_info.delete_res_index = delete_res_index
    op_info.delete_user_id_index = delete_user_id_index
  end
  return msg, op_info
end

function M:_create_mock_msg(data)
  assert(data.session_id, "create_mock_msg fail, session_id is nil")
  assert(data.content, "create_mock_msg fail, content is nil")
  assert(data.send_id, "create_mock_msg fail, send_id is nil")
  local ret = {}
  ret.is_ignore = EC.is_ignore_session(data.session_id) or false
  local session_type_info = EC.get_session_type(data.session_id) or {}
  if session_type_info.type == EC.TYPE_PERSONAL then
    ret.to_id = session_type_info.from
    ret.src_id = session_type_info.my_chat_user_id
  elseif session_type_info.type == EC.TYPE_GROUP then
    ret.to_id = data.session_id
    ret.src_id = self.user_id
  else
    assert(false, "其他场景，还没测试，待补充")
  end
  ret.content_id = nil
  ret.msg_id = nil
  ret.send_id = data.send_id
  ret.ts = os.time()
  ret.src_type = "user"
  ret.src_info = {}
  ret.session_id = data.session_id
  ret.reader_status = msg_util.msg_status().sending
  ret.content = data.content
  ret.delete_msg_members = {}
  ret.at_list = {}
  if data.at_list then
    ret.at_list = data.at_list
  end
  ret.quote_msgs = {}
  for _, quoted_msg_id in pairs(data.quote_msg_ids or {}) do
    local quote_msg = {}
    local session_msgs = self.session_msgs[ret.session_id]
    if session_msgs then
      local msg_infos = session_msgs:get_mapped_msg() or {}
      local msg = msg_infos[quoted_msg_id]
      if msg and msg.src_info then
        quote_msg.src_info = msg.src_info
        quote_msg.src_type = msg.src_type
        quote_msg.reader_status = msg.reader_status
        quote_msg.msg_id = quoted_msg_id
        quote_msg.content = msg.content
        table.insert(ret.quote_msgs, quote_msg)
      end
    end
  end
  if not next(ret.quote_msgs) then
    ret.quote_msgs = nil
  end
  ret._msg_sdk_src = "mock"
  if self.user_type == "player" then
    ret.src_info = player_cache.get_player_info_with_ignore_expire_time(EG.player_info().player_id, "chat")
  elseif self.user_type == "account" then
    ret.src_info = player_cache.get_account_info_with_ignore_expire_time(EG.user_info().uid)
  end
  return ret
end

function M:add_mock_system_group_msg(data)
  data.send_id = ECS.send_id()
  local mock_msg = self:_create_mock_system_group_msg(data)
  E_UTILS.reset_deepcopy_only_once_record()
  self:update_session_msgs(data.session_id, {mock_msg})
end

function M:_create_mock_system_group_msg(data)
  local msg = M:_create_mock_msg(data)
  msg.src_type = "system"
  msg.reader_status = msg_util.msg_status().user_received
  msg.is_local_msg = true
  return msg
end

function M:_merge_msgs(msgs1, msgs2)
  for _, msg_in2 in pairs(msgs2) do
    table.insert(msgs1, msg_in2)
  end
  table.sort(msgs1, msg_util.smaller)
  return msgs1
end

function M:_merge_session(sessions2)
  local adds = {}
  local updates = {}
  for _, v in ipairs(sessions2) do
    local session_id = v.session_info.id
    if self.sessions[session_id] == nil then
      adds[session_id] = v
    else
      updates[session_id] = v
    end
    self.sessions[session_id] = v
  end
  return {adds = adds, updates = updates}
end

function M:HANDLERS(header, body)
  E_UTILS.reset_deepcopy_only_once_record()
  local cmd = "_" .. (body.cmd or "")
  if body.cmd then
    chat_log.debug(chat_log_util.header(), TAG, "HANDLERS", "HANDLERS", {
      cmd = body.cmd
    }, {})
    local func = M[cmd]
    if nil ~= func and type(func) == "function" then
      func(self, header, body)
    else
      self:_default_handler(header, body, cmd)
    end
  elseif header.method then
    old_chat.HANDLERS(header, body)
  else
    chat_log.warn(chat_log_util.header(), TAG, "HANDLERS_unknown_type", {}, {})
  end
end

function M:_default_handler(_header, _body, cmd)
  chat_log.warn(chat_log_util.header(), TAG, "exec_default_handler", {cmd = cmd}, {})
end

function M:_on_handlers_error(_error_msg)
  if self.handler and _error_msg then
    self.handler:on_handlers_error(_error_msg)
  end
end

function M:_info_msg(_header, body)
  if not body then
    return
  end
  if not body.msgs then
    return
  end
  if next(body.msgs) == nil then
    return
  end
  local session_id = body.msgs[1].session_id
  local session_info = EC.get_session_type(session_id)
  local session_type = session_info and session_info.type or ""
  local session_from = session_info and session_info.from or ""
  Chain.new():add(function(next_cb)
    EC._msgs_player_to_cache(body.msgs)
    next_cb(true)
  end):add(function(next_cb)
    if session_type == EC.TYPE_SYSTEM then
      if session_from == EC.SYSTEM_CHAT_GROUP then
        self:fill_chat_group_invite_msgs(body.msgs, next_cb)
      elseif "chat_rule_msg" == session_from then
        local destination = get_destination(self.user_type)
        CALLBACK.callback(destination, CALLBACK.HANDLER_NAME.INFO_SYSTEM_MSG, body.msgs)
      elseif session_from == EC.SYSTEM_GANGPLANK then
        local destination = get_destination(self.user_type)
        CALLBACK.callback(destination, CALLBACK.HANDLER_NAME.INFO_GANGPLANK_MSG, body.msgs)
      end
    elseif session_type == EC.TYPE_GROUP then
      for _, msg in pairs(body.msgs) do
        msg.is_ignore = self:is_ignore_session(msg.session_id)
        if msg.sticky_data then
          local sticky_data_copy = E_UTILS.deepcopy(msg.sticky_data)
          sticky_data_copy.msg_id = msg.msg_id
          local group_id = session_from
          local cache_group = self.groups[group_id]
          if cache_group then
            if cache_group.sticky_data == nil then
              cache_group.sticky_data = {}
            end
            local group_sticky_data = cache_group.sticky_data
            local idx
            for index, sticky_data in pairs(group_sticky_data) do
              if sticky_data.msg_id == sticky_data_copy.msg_id then
                idx = index
              end
            end
            if idx then
              cache_group.sticky_data[idx] = sticky_data_copy
            else
              table.insert(cache_group.sticky_data, sticky_data_copy)
            end
          end
        end
      end
    elseif session_type == EC.TYPE_PERSONAL then
      for _, msg in pairs(body.msgs) do
        msg.is_ignore = self:is_ignore_session(msg.session_id)
      end
    end
    for _, msg in pairs(body.msgs) do
      self:_fill_arrival_msg_url(msg)
      if msg.reader_status == msg_util.msg_status().recall then
        self:update_recalled_msgs_quoted_state(session_id, msg.msg_id, function(updated_msgs)
          self:update_session_msgs(session_id, updated_msgs, "info_msg")
        end)
      end
    end
    next_cb(true)
  end):add(function(next_cb)
    for _, msg in pairs(body.msgs) do
      if not msg._msg_sdk_src then
        msg._msg_sdk_src = "info_msg"
      end
    end
    EC.replace_msgs_user_info_before_cb(body.msgs, function(replace_msg)
      local unread = self:_get_session_unread_count(replace_msg, session_type)
      self:_add_session_unread(session_id, unread)
      self:update_session_msgs(session_id, replace_msg, "info_msg")
      next_cb(true)
    end, function()
      local unread = self:_get_session_unread_count(body.msgs, session_type)
      self:_add_session_unread(session_id, unread)
      self:update_session_msgs(session_id, body.msgs, "info_msg")
      next_cb(true)
    end, self.need_replace_reply_res_user_info)
  end):execute(function(_succ, _index)
    E.LOG.debug(TAG, "_info_msg_processs:" .. tostring(_succ) .. ", index:" .. tostring(_index))
  end)
end

function M:_info_msg_res(_header, body)
  local session_id = body.session_id
  local session_msgs = self.session_msgs[session_id]
  if not session_msgs then
    return
  end
  local msg_infos = session_msgs:get_mapped_msg() or {}
  local msg = msg_infos[body.msg_id]
  if not msg then
    return
  end
  if not msg.reply_res then
    msg.reply_res = {}
  end
  local self_user_id = self.user_id
  local op_data_list_map = {}
  for _, op_data in pairs(body.op_data) do
    local index = op_data.res_id .. "/" .. op_data.res_type
    if not op_data_list_map[index] then
      op_data_list_map[index] = {}
    end
    op_data.res_id = nil
    op_data.res_type = nil
    table.insert(op_data_list_map[index], op_data)
  end
  local msg_res, msg_res_index, msg_res_user_ids
  local has_res = false
  for index, op_data_list in pairs(op_data_list_map) do
    for res_index, res in pairs(msg.reply_res) do
      if res.res_id .. "/" .. res.res_type == index then
        msg_res = res
        msg_res_index = res_index
        msg_res_user_ids = res.user_ids
        has_res = true
        break
      end
    end
    if not has_res then
      msg_res = {}
      local splitIndex = string.find(index, "/")
      msg_res.res_id = index:sub(1, splitIndex - 1)
      msg_res.res_type = index:sub(splitIndex + 1, #index)
      msg_res.user_ids = {}
      msg_res.user_num = 0
      msg_res_user_ids = msg_res.user_ids
      table.insert(msg.reply_res, msg_res)
      msg_res_index = #msg.reply_res
    end
    for _, op_data in pairs(op_data_list) do
      if op_data.op_type == "put" then
        local user = op_data.user
        local user_id_to_put = user.user_id
        if user_id_to_put == self_user_id then
          for i, del_mock_user_id in pairs(msg_res_user_ids) do
            if del_mock_user_id == self_user_id then
              table.remove(msg_res_user_ids, i)
              break
            end
          end
        else
          msg_res.user_num = msg_res.user_num + 1
        end
        if user.player_info then
          player_cache.add_player_info(user_id_to_put, user, "chat_info_msg", player_scene.OFFICIAL_SCENE.CHAT_MSG_RES)
        end
        table.insert(msg_res_user_ids, 1, user_id_to_put)
      elseif op_data.op_type == "delete" then
        local user_id_to_delete = op_data.user.user_id
        if user_id_to_delete ~= self_user_id then
          msg_res.user_num = msg_res.user_num - 1
        end
        for i, user_id in pairs(msg_res_user_ids) do
          if user_id == user_id_to_delete then
            table.remove(msg_res_user_ids, i)
            break
          end
        end
      end
    end
    if msg_res.user_num <= 0 then
      table.remove(msg.reply_res, msg_res_index)
    end
  end
  EC.replace_reply_res_user_info_before_cb(msg, function(new_msgs)
    self:update_session_msgs(session_id, new_msgs, "info_msg_res")
  end, self.need_replace_reply_res_user_info)
end

function M:_info_update_session2(_header, body)
  local session_id = body.session_id
  local session = self.sessions[session_id]
  if not session then
    return
  end
  local update_last_msgs, unread
  for _, put_value in pairs(body.put or {}) do
    if put_value.k and put_value.k == "session_info" then
      unread = put_value.v and put_value.v.unread
    elseif put_value.k and put_value.k == "last_msgs" then
      update_last_msgs = put_value.v
    end
  end
  
  local function update_last_msgs_and_unread(final_last_msgs, unread_count)
    local need_update_session = false
    if final_last_msgs then
      self.sessions[session_id].last_msgs = final_last_msgs
      need_update_session = true
    end
    if unread_count then
      self:_set_session_unread(session_id, math.min(unread_count, session.session_info.unread), false)
      need_update_session = true
    end
    if need_update_session then
      self:_info_chat_session_change({}, {
        [session_id] = self.sessions[session_id]
      }, {})
    end
  end
  
  if update_last_msgs then
    EC.replace_msgs_user_info_before_cb(update_last_msgs, function(replace_msg)
      update_last_msgs_and_unread(replace_msg, unread)
    end, function()
      update_last_msgs_and_unread(update_last_msgs, unread)
    end, self.need_replace_reply_res_user_info)
  else
    update_last_msgs_and_unread(nil, unread)
  end
end

function M:_info_offline(_header, body)
  local _type = body and body.type
  local _message = body and body.message
  E.LOG.debug(TAG, "kickout type:" .. tostring(_type) .. ", msg" .. tostring(_message))
  self.last_offline_reason = body
  self:destroy()
end

function M:_info_create_group(_header, body)
  self:_process_groups_on_change({
    body.group
  }, "info_create_group", function(...)
    if self.handler.info_group_system_msg then
      self.handler:info_group_system_msg(body)
    end
  end)
end

function M:_info_update_group(_header, body)
  self:_process_groups_on_change({
    body.group
  }, "info_update_group", function(...)
    if self.handler.info_group_system_msg then
      self.handler:info_group_system_msg(body)
    end
  end)
end

function M:_info_delete_group(_header, body)
  local group_id = body.group_id
  local orig_group = self.groups[group_id]
  self.groups[group_id] = nil
  if self.enable_voice and voice.is_voice_channel(group_id) then
    voice.remove_channel_param(group_id)
    if voice.auto_leave_channel then
      voice.leave_channel(group_id)
    end
  end
  local removes = {
    [group_id] = orig_group
  }
  self:_info_group_changes({}, {}, {
    [group_id] = orig_group
  })
  self:_sync_session_for_group({}, {}, removes)
  if self.handler.info_group_system_msg then
    if not body.group then
      body.group = orig_group
    end
    self.handler:info_group_system_msg(body)
  end
end

function M:_info_add_group_member(_header, body)
  self:_process_group_on_add_member_infos(body.group_id, body.add_member_infos)
  if self.handler.info_group_system_msg then
    self.handler:info_group_system_msg(body)
  end
end

function M:_info_remove_group_member(_header, body)
  self:_process_group_on_remove_member_infos(body.group_id, body.removes)
  if self.handler.info_group_system_msg then
    self.handler:info_group_system_msg(body)
  end
end

function M:_info_add_invited_member(_header, _body)
  self:_process_group_on_invited_member_infos(_body and _body.group_id, _body and _body.add_invited_member_infos)
end

function M:_info_voice_channel_user_change(_header, body)
  if not self.enable_voice then
    return
  end
  local updates_map = {}
  if body.updates then
    for _, new_user in pairs(body.updates) do
      if new_user.user_id then
        updates_map[new_user.user_id] = new_user
      end
    end
  end
  local remove_map = {}
  if body.removes then
    for _, need_remove_user_id in pairs(body.removes) do
      if type(need_remove_user_id) == "string" and #need_remove_user_id > 0 then
        remove_map[need_remove_user_id] = true
      end
    end
  end
  if body.group_id then
    if body.voice_channel then
      voice.voice_channel_info_update(body.group_id, body.voice_channel)
    end
    self:_voice_channel_user_change_update_group(body.group_id, remove_map, updates_map, {
      voice_channel = body.voice_channel
    })
    voice.voice_channel_user_change(body.group_id, remove_map, updates_map)
  end
end

function M:_info_chat_session_change(adds, updates, removes)
  local adds_session_id = {}
  for k, _ in pairs(adds) do
    table.insert(adds_session_id, k)
  end
  local updates_session_id = {}
  for k, _ in pairs(updates) do
    table.insert(updates_session_id, k)
  end
  local removes_session_id = {}
  for k, _ in pairs(removes) do
    table.insert(removes_session_id, k)
  end
  chat_log.debug(chat_log_util.header(), TAG, "_info_chat_session_change", "_info_chat_session_change", {
    adds = adds_session_id,
    updates = updates_session_id,
    removes = removes_session_id
  }, {})
  self.handler:info_chat_session_change(E_UTILS.deepcopy_only_once(adds), E_UTILS.deepcopy_only_once(updates), E_UTILS.deepcopy_only_once(removes))
end

function M:_info_chat_msgs(session_id, msgs)
  local log_msgs = {}
  for _, v in pairs(msgs) do
    table.insert(log_msgs, {
      msg_id = v.msg_id,
      send_id = v.send_id,
      session_id = v.session_id
    })
  end
  local session_info = EC.get_session_type(session_id)
  local session_type = session_info and session_info.type or ""
  local session_from = session_info and session_info.from or ""
  chat_log.debug(chat_log_util.header(), TAG, "_info_chat_msgs", "_info_chat_msgs", {
    session_type = session_type,
    session_id = session_id,
    msgs = log_msgs
  }, {})
  self.handler:info_chat_msgs(session_type, session_id, E_UTILS.deepcopy_only_once(msgs), session_from)
end

function M:_info_group_changes(adds, updates, removes)
  local adds_group_id = {}
  for k, _ in pairs(adds) do
    table.insert(adds_group_id, k)
  end
  local updates_group_id = {}
  for k, _ in pairs(updates) do
    table.insert(updates_group_id, k)
  end
  local removes_group_id = {}
  for k, _ in pairs(removes) do
    table.insert(removes_group_id, k)
  end
  chat_log.debug(chat_log_util.header(), TAG, "_info_group_changes", "_info_group_changes", {
    adds = adds_group_id,
    updates = updates_group_id,
    removes = removes_group_id
  }, {})
  self.handler:info_group_changes(E_UTILS.deepcopy_only_once(adds), E_UTILS.deepcopy_only_once(updates), E_UTILS.deepcopy_only_once(removes))
end

function M:_info_chat_rpc_result(task_id, task_name, rpc_result)
  chat_log.debug(chat_log_util.header(), TAG, "_info_chat_rpc_result", "_info_chat_rpc_result", {
    task_id = task_id,
    task_name = task_name,
    code = rpc_result and rpc_result.code,
    msg = rpc_result and rpc_result.msg
  }, {})
  local to_user_rpc_result = E_UTILS.deepcopy_only_once(rpc_result)
  local callback = self.callback[task_id]
  if type(callback) == "function" or type(callback) == "userdata" then
    callback(task_id, task_name, to_user_rpc_result)
  end
  self.callback[task_id] = nil
  self.handler:info_chat_rpc_result(task_id, task_name, to_user_rpc_result)
end

function M:get_task_id()
  self.task_id_counter = (self.task_id_counter + 1) % MAX_ID
  local counter = string.format("%.8d", self.task_id_counter)
  local task_id = tostring(os.time()) .. tostring(self.USER_ID_HASH) .. counter
  self.last_task_id = task_id
  return task_id
end

function get_destination(user_type)
  if "account" == user_type then
    return "acc_chat"
  else
    return "chat"
  end
end

function M:_fill_owner_member_before_replace_groups_user_info(groups)
  for _, group in pairs(groups) do
    local member_infos = group.member_infos
    if member_infos and group.owner and EG.player_info() and EG.player_info().player_id and tostring(group.owner) == tostring(EG.player_info().player_id) then
      local found_owner_info = false
      for _, user_info in pairs(member_infos) do
        if tostring(group.owner) == tostring(user_info.user_id) then
          found_owner_info = true
          break
        end
      end
      if not found_owner_info then
        E.log("not found_owner_info")
        E.log(group.owner)
        table.insert(member_infos, 1, {
          user_id = group.owner,
          user_type = "player",
          player_id = group.owner
        })
        E.log(group)
      end
    end
  end
end

function M:_process_group_on_login(ret)
  if not ret.groups or next(ret.groups) == nil then
    return
  end
  if ret.ignore_data then
    chat_cache.set_ignore_data(ret.ignore_data)
  end
  M:_fill_owner_member_before_replace_groups_user_info(ret.groups)
  local all_groups = ret.groups or {}
  if ret.receiving_groups then
    for _, rgv in pairs(ret.receiving_groups) do
      table.insert(all_groups, rgv)
    end
  end
  EC.replace_groups_user_info(all_groups, function(replace_groups)
    local merge_res = self:_merge_group(replace_groups)
    if self.enable_voice then
      self:_process_voice_status_on_login(replace_groups)
    end
    local has_change = next(merge_res.adds) ~= nil or nil ~= next(merge_res.updates) or nil ~= next(merge_res.removes)
    if has_change then
      self:_info_group_changes(merge_res.adds, merge_res.updates, merge_res.removes)
    end
  end)
end

function M:_check_voice_group_join(group)
  if self.enable_voice and group.attr and group.attr.enable_voice then
    local group_id = group.group_id
    voice.add_channel_param(group_id, {
      token = group.personal_info.agora_channel_token
    })
  end
end

function M:_process_voice_status_on_login(replace_groups)
  if not self.enable_voice then
    return
  end
  for _, replace_group in ipairs(replace_groups) do
    self:_update_group_voice_mute_info(replace_group.group_id)
  end
  voice.init()
  for _, group in pairs(replace_groups) do
    self:_check_voice_group_join(group)
  end
  if voice.get_curr_channel_id() then
    E.LOG.debug(TAG, "聊天登录后, 将实时语音状态同步给聊天服务, channel_id=" .. voice.get_curr_channel_id() .. ", voice_status=" .. voice.get_voice_status() .. ", mute_local_value=" .. tostring(voice.get_mute_local_value()))
    self:_set_voice_channel_status(voice.get_curr_channel_id(), voice.get_voice_status(), voice.get_mute_local_value(), voice.get_curr_voice_user_id())
  else
    E.LOG.debug(TAG, "聊天登录后, 尚未进入语音频道")
  end
end

function M:_process_groups_on_change(groups, _msg_from, cb)
  if "info_create_group" == _msg_from then
    M:_fill_owner_member_before_replace_groups_user_info(groups)
  end
  EC.replace_groups_user_info(groups, function(replace_groups)
    local merge_res = self:_merge_group(replace_groups)
    if self.enable_voice and ("info_create_group" == _msg_from or "info_update_group" == _msg_from) then
      local replace_group = replace_groups[1]
      if "info_create_group" == _msg_from then
        self:_check_voice_group_join(replace_group)
      end
      self:_update_group_voice_mute_info(replace_group.group_id)
      voice.update_voice_mute(voice.get_curr_channel_id())
      local personal_info = replace_group.personal_info
      if "info_update_group" == _msg_from and personal_info and replace_group.group_id and personal_info.agora_channel_token then
        voice.add_channel_param(replace_group.group_id, {
          token = personal_info.agora_channel_token
        })
      end
    end
    local has_change = next(merge_res.adds) ~= nil or nil ~= next(merge_res.updates) or nil ~= next(merge_res.removes)
    if has_change then
      self:_info_group_changes(merge_res.adds, merge_res.updates, merge_res.removes)
      self:_sync_session_for_group(merge_res.adds, merge_res.updates, merge_res.removes)
      if next(merge_res.adds) ~= nil and cb then
        cb()
      end
    end
  end)
end

function M:_process_group_on_add_member_infos(group_id, add_member_infos)
  EC.replace_array_player_before_cb(add_member_infos, function(replace_array)
    local orig_group = self.groups[group_id]
    if not orig_group then
      return
    end
    orig_group.member_infos = orig_group.member_infos or {}
    local member_infos_map = {}
    for _, v in pairs(orig_group.member_infos) do
      member_infos_map[v.user_id] = true
    end
    for _, v in pairs(replace_array) do
      if not member_infos_map[v.user_id] then
        table.insert(orig_group.member_infos, v)
      end
    end
    local updates = {
      [group_id] = orig_group
    }
    self:_info_group_changes({}, updates, {})
    self:_sync_session_for_group({}, updates, {})
  end)
end

function M:_process_group_on_remove_member_infos(group_id, remove_member_infos)
  if not group_id or 0 == #group_id then
    return
  end
  if not remove_member_infos or 0 == #remove_member_infos then
    return
  end
  local removes_map = {}
  for _, v in pairs(remove_member_infos) do
    removes_map[v] = true
  end
  local orig_group = self.groups[group_id]
  if not orig_group then
    return
  end
  orig_group.member_infos = orig_group.member_infos or {}
  local remove_member_info_idx = {}
  for k, v in pairs(orig_group.member_infos) do
    if removes_map[v.user_id] then
      table.insert(remove_member_info_idx, k)
    end
  end
  table.sort(remove_member_info_idx, function(a, b)
    return b < a
  end)
  for _, idx in pairs(remove_member_info_idx) do
    table.remove(orig_group.member_infos, idx)
  end
  local curr_voice_channel = voice.get_curr_channel_id()
  if self.enable_voice and curr_voice_channel then
    self:_voice_channel_user_change_update_group(curr_voice_channel, removes_map)
    voice.voice_channel_user_change(curr_voice_channel, removes_map)
  end
  local updates = {
    [group_id] = orig_group
  }
  self:_info_group_changes({}, updates, {})
  self:_sync_session_for_group({}, updates, {})
end

function M:_process_group_on_invited_member_infos(group_id, add_invited_member_infos)
  EC.replace_array_player_before_cb(add_invited_member_infos, function(replace_array)
    local orig_group = self.groups[group_id]
    if not orig_group then
      return
    end
    orig_group.invited_member_infos = orig_group.invited_member_infos or {}
    local member_infos_map = {}
    for _, v in pairs(orig_group.invited_member_infos) do
      member_infos_map[v.user_id] = true
    end
    for _, v in pairs(replace_array) do
      if not member_infos_map[v.user_id] then
        table.insert(orig_group.invited_member_infos, v)
      end
    end
    local updates = {
      [group_id] = orig_group
    }
    self:_info_group_changes({}, updates, {})
    self:_sync_session_for_group({}, updates, {})
  end)
end

function M:_sync_session_for_group(adds_g, updates_g, removes_g)
  local adds, updates, removes = {}, {}, {}
  for group_id, group in pairs(adds_g) do
    if not self.sessions[group_id] then
      local session = self:_create_session_by_group(group)
      self.sessions[group_id] = session
      adds[group_id] = session
    else
      local session = self.sessions[group_id]
      session.session_info.info = group
      updates[group_id] = session
    end
  end
  for group_id, group in pairs(updates_g) do
    if not self.sessions[group_id] then
      local session = self:_create_session_by_group(group)
      self.sessions[group_id] = session
      adds[group_id] = session
    else
      local session = self.sessions[group_id]
      session.session_info.info = group
      updates[group_id] = session
    end
  end
  for group_id, _ in pairs(removes_g) do
    if self.sessions[group_id] then
      local session = self.sessions[group_id]
      self.sessions[group_id] = nil
      removes[group_id] = session
    end
  end
  self:_info_chat_session_change(adds, updates, removes)
end

function M:_found_last_msg(msgs, _session_id, _session_type)
  if not self.filter_sys_msg_group_types then
    return msgs[#msgs]
  end
  if not _session_type and _session_id then
    local session_info = EC.get_session_type(_session_id)
    _session_type = session_info and session_info.type or ""
  end
  if _session_type == EC.TYPE_GROUP then
    local f_session = self.sessions[_session_id]
    local group_type = f_session and f_session.session_info and f_session.session_info.info and f_session.session_info.info.info and f_session.session_info.info.info.type
    if group_type and self.filter_sys_msg_group_types_map[group_type] then
      for fi = #msgs, 1, -1 do
        if msgs[fi].src_type ~= "system" then
          return msgs[fi]
        end
      end
      return nil
    end
  end
  return msgs[#msgs]
end

function M:_is_filter_sys_msg_group_types_session(_msg, _session_id, _session_type)
  if not self.filter_sys_msg_group_types then
    return false
  end
  if _msg.src_type ~= "system" then
    return false
  end
  local _temp_is = false
  if not _session_type and _session_id then
    local session_info = EC.get_session_type(_session_id)
    _session_type = session_info and session_info.type or ""
  end
  if _session_type == EC.TYPE_GROUP then
    local f_session = self.sessions[_session_id]
    local group_type = f_session and f_session.session_info and f_session.session_info.info and f_session.session_info.info.info and f_session.session_info.info.info.type
    if group_type and self.filter_sys_msg_group_types_map[group_type] then
      _temp_is = true
    end
  end
  return _temp_is
end

function M:_get_session_unread_count(msgs, _session_type)
  if nil == msgs or msgs and 0 == #msgs then
    return 0
  end
  local msg_status_constant = msg_util.msg_status()
  local unread = 0
  local session_id = msgs[1].session_id
  for _, msg in pairs(msgs) do
    local need_skip = self:_is_filter_sys_msg_group_types_session(msg, session_id, _session_type)
    if not need_skip and msg.reader_status == msg_status_constant.server_received and msg.src_id ~= self.user_id then
      if self.set_msg_received_cache and self.set_msg_received_cache[msg.session_id] then
        local max_received_ts = self.set_msg_received_cache[msg.session_id].last_max_received_ts or 0
        if max_received_ts < msg.ts then
          unread = unread + 1
        end
      else
        unread = unread + 1
      end
    end
  end
  return unread
end

function M:_add_session_unread(session_id, unread)
  local session = self.sessions[session_id]
  if nil ~= session then
    local new_unread = math.max(session.session_info.unread + unread, 0)
    self:_set_session_unread(session_id, new_unread, nil)
  end
end

function M:_set_session_unread(session_id, unread, _had_at_me_msg)
  local session = self.sessions[session_id]
  if nil ~= session then
    session.session_info.unread = unread
    if nil ~= _had_at_me_msg then
      session.session_info.had_at_me_msg = _had_at_me_msg
    end
  end
end

function M:get_user_group_broker_info(query)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.get_user_group_broker_info(destination, query, function(ret)
    self:_get_user_group_broker_info_cb(task_id, ret)
  end)
  return task_id
end

function M:_get_user_group_broker_info_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "get_user_group_broker_info", ret)
end

function M:switch_group_id(group_broker_id, group_id)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.switch_group_id(destination, group_broker_id, group_id, function(ret)
    self:_switch_group_id_cb(task_id, ret)
  end)
  return task_id
end

function M:_switch_group_id_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "switch_group_id", ret)
end

function M:set_receiving_groups(groups)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.set_receiving_groups(destination, groups, function(ret)
    self:_set_receiving_groups_cb(task_id, ret)
  end)
  return task_id
end

function M:_set_receiving_groups_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "set_receiving_groups", ret)
  if 0 ~= ret.code then
    return
  end
  if ret.groups then
    self:_process_groups_on_change(ret.groups)
  end
end

function M:delete_msg(session_id, msg_ids)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.delete_msg(destination, session_id, msg_ids, function(ret)
    self:_delete_msg_cb(task_id, session_id, msg_ids, ret)
  end)
  return task_id
end

function M:_delete_msg_cb(task_id, session_id, msg_ids, ret)
  self:_info_chat_rpc_result(task_id, "delete_msg", ret)
  if not session_id or not msg_ids then
    return
  end
  local old_session_data = self.sessions[session_id]
  if old_session_data then
    local del_msgs = {}
    for _, del_msg_id in pairs(msg_ids) do
      local session_msgs = self.session_msgs[session_id] or {}
      local msg_infos = session_msgs:get_mapped_msg() or {}
      if msg_infos[del_msg_id] then
        msg_infos[del_msg_id].reader_status = msg_util.msg_status().delete
        table.insert(del_msgs, msg_infos[del_msg_id])
      end
    end
    if #del_msgs > 0 then
      if old_session_data.last_msgs and #old_session_data.last_msgs > 0 then
        local in_last_msgs = false
        for _, msg_info in ipairs(del_msgs) do
          for _, last_msg_info in pairs(old_session_data.last_msgs) do
            if last_msg_info.msg_id == msg_info.msg_id then
              last_msg_info.reader_status = msg_util.msg_status().delete
              in_last_msgs = true
            end
          end
        end
        if in_last_msgs then
          local updates = {
            [session_id] = old_session_data
          }
          self:_info_chat_session_change({}, updates, {})
        end
      end
      self:_info_chat_msgs(session_id, del_msgs)
    end
  end
end

function M:clean_session_msg(session_id, ts)
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.clean_session_msg(destination, session_id, ts, function(ret)
    self:_clean_session_msg_cb(task_id, ret)
  end)
  return task_id
end

function M:_clean_session_msg_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "clean_session_msg", ret)
end

function M:ignore(ignore_data)
  local task_id = self:get_task_id()
  ECS.ignore(ignore_data, function(ret)
    self:_ignore_cb(task_id, ret)
  end)
  return task_id
end

function M:_ignore_cb(task_id, ret)
  if ret and ret.ignore_data then
    chat_cache.set_ignore_data(ret.ignore_data)
  end
  self:_info_chat_rpc_result(task_id, "ignore", ret)
  self:_refresh_ignore()
end

function M:get_user_face(_params)
  _params = _params or {}
  local task_id = self:get_task_id()
  local destination = get_destination(self.user_type)
  ECS.get_user_face(destination, _params, function(ret)
    self:_get_user_face_cb(task_id, ret)
  end)
  return task_id
end

function M:_get_user_face_cb(task_id, ret)
  self:_info_chat_rpc_result(task_id, "get_user_face", ret)
end

function M:unignore(unignore_data)
  local task_id = self:get_task_id()
  ECS.unignore(unignore_data, function(ret)
    self:_unignore_cb(task_id, ret)
  end)
  return task_id
end

function M:_unignore_cb(task_id, ret)
  if ret and ret.ignore_data then
    chat_cache.set_ignore_data(ret.ignore_data)
  end
  self:_info_chat_rpc_result(task_id, "unignore", ret)
  self:_refresh_ignore()
end

function M:_refresh_ignore()
  local update_sessions = {}
  for _, v_session in pairs(self.sessions or {}) do
    local session_info = v_session.session_info
    local session_type = EC.get_session_type(session_info.id)
    if session_info and (session_type.type == EC.TYPE_PERSONAL or session_type.type == EC.TYPE_GROUP) then
      local is_ignore = self:is_ignore_session(session_info.id)
      if session_info.is_ignore ~= is_ignore then
        session_info.is_ignore = is_ignore
        update_sessions[session_info.id] = v_session
      end
    end
  end
  if next(update_sessions) ~= nil then
    self:_info_chat_session_change({}, update_sessions, {})
  end
end

function M:is_ignore_session(session_id)
  local ignore_data = chat_cache.get_ignore_data()
  local ignore_sessions = ignore_data.sessions or {}
  local ignore_group_types = ignore_data.group_types or {}
  if ignore_sessions[session_id] then
    return true
  end
  local group = self.groups[session_id]
  if group then
    local group_info = group.info
    local group_type = group_info.type or ""
    if ignore_group_types[group_type] then
      return true
    end
  end
  return false
end

function M:get_ignore_data()
  do return end
  return chat_cache.get_ignore_data
end

function M:async_get_my_groups(cb)
  local destination = get_destination(self.user_type)
  if destination == ECS.DESTINATION.PLAYER then
    if cb then
      cb(true, self.groups or {})
    end
  elseif cb then
    cb(false, CONSTANTS.CHAT_ERROR_CODES.CODE_GROUPS_ONLY_SUPPOT_PLATER_CHAT, "groups only support player chat")
  end
end

function M:report_msg_show(param)
  local msg_id = param.msg_id or ""
  if reported_shown_msgs_map[msg_id] then
    return
  end
  table.insert(reported_shown_msgs, msg_id)
  reported_shown_msgs_map[msg_id] = true
  if #reported_shown_msgs >= MAX_CACHE_SHOWN_MSGS then
    local new_reported_shown_msgs = {}
    local clear_cache_num = math.floor(MAX_CACHE_SHOWN_MSGS / 10)
    for i = 1, 1 + clear_cache_num do
      reported_shown_msgs_map[reported_shown_msgs[i]] = nil
    end
    for i = 2 + clear_cache_num, MAX_CACHE_SHOWN_MSGS do
      table.insert(new_reported_shown_msgs, reported_shown_msgs[i])
    end
    reported_shown_msgs = new_reported_shown_msgs
  end
  local chat_type = ""
  local group_id
  local session_id = param.session_id
  local session_users = E.Utils.split_string(session_id, ":")
  if 2 == #session_users then
    local user_1 = session_users[1]
    local user_2 = session_users[2]
    local self_user_id = self.user_id
    local self_acc_id = "acc_" .. EG.user_info().uid
    if self_user_id == user_1 or self_user_id == user_2 then
      chat_type = "private"
    elseif E.Utils.start_with(user_1, "cs_") and self_acc_id == user_2 or E.Utils.start_with(user_2, "cs_") and self_acc_id == user_1 then
      chat_type = "custom"
    end
  else
    local group = self.groups[session_id] or {}
    chat_type = group.info and group.info.type or ""
    group_id = group.group_id
  end
  local msg_src_info = {}
  local session_msgs = self.session_msgs[session_id]
  if session_msgs then
    local msg_infos = session_msgs:get_mapped_msg() or {}
    msg_src_info = msg_infos[msg_id] and msg_infos[msg_id].src_info or {}
  end
  ESTAT.sdk_msg_visit_report({
    biz_act = "show",
    biz_id = msg_id,
    chat_type = chat_type,
    shown_time = param.shown_time,
    session_id = session_id,
    group_id = group_id,
    msg_account_id = msg_src_info.account,
    msg_player_id = msg_src_info.player_id,
    msg_player_name = msg_src_info.player_info and msg_src_info.player_info.name
  })
end

function M:_voice_channel_user_change_update_group(group_id, removes_map, updates_map, ext)
  local old = self.groups[group_id]
  if not self.enable_voice or not old then
    return
  end
  if removes_map and old.voice_channel_users and #old.voice_channel_users > 0 then
    for i = #old.voice_channel_users, 1, -1 do
      if removes_map[old.voice_channel_users[i].user_id] then
        table.remove(old.voice_channel_users, i)
      end
    end
  end
  if not updates_map then
    return
  end
  local admin_map = {}
  if old.attr and old.attr.voice_channel_administrator then
    for _, admin_id in pairs(old.attr.voice_channel_administrator) do
      admin_map[admin_id] = true
    end
  end
  local voice_channel_users_map = {}
  if old.voice_channel_users then
    for _, old_user in pairs(old.voice_channel_users) do
      voice_channel_users_map[old_user.user_id] = old_user
    end
  end
  local new_user_map = {}
  for uid, update_user in pairs(updates_map) do
    if voice_channel_users_map[uid] then
      local voice_channel_user = voice_channel_users_map[uid]
      for k, v in pairs(update_user) do
        voice_channel_user[k] = v
      end
      if admin_map[uid] then
        voice_channel_user.management_mute = false
      end
    else
      new_user_map[uid] = update_user
    end
  end
  for uid, new_user in pairs(new_user_map) do
    if admin_map[uid] then
      new_user.management_mute = false
    end
    if not old.voice_channel_users then
      old.voice_channel_users = {}
    end
    table.insert(old.voice_channel_users, new_user)
  end
  local new_voice_channel = ext and ext.voice_channel
  if new_voice_channel and next(new_voice_channel) then
    old.voice_channel = new_voice_channel
  end
end

function M:_update_group_voice_mute_info(group_id)
  if not self.enable_voice then
    return
  end
  local group_copyed = E_UTILS.deepcopy(self.groups[group_id])
  if not group_copyed.voice_channel_users then
    return
  end
  local admin_map = {}
  if group_copyed.attr and group_copyed.attr.voice_channel_administrator then
    for _, admin_id in pairs(group_copyed.attr.voice_channel_administrator) do
      admin_map[admin_id] = true
    end
  end
  for _, voice_channel_user in pairs(group_copyed.voice_channel_users) do
    if voice_channel_user.user_id and admin_map[voice_channel_user.user_id] then
      voice_channel_user.management_mute = false
    end
  end
  self.groups[group_id] = group_copyed
end

function M:get_group_cache(group_id)
  do return E_UTILS.deepcopy end
  return E_UTILS.deepcopy, self.groups[group_id] or {}
end

return M
