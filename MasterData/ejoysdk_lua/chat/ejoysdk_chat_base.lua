local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local server = require("ejoysdk_lua.chat.ejoysdk_chat_server")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local cache = require("ejoysdk_lua.chat.ejoysdk_chat_cache")
local ejoysdk_player_info = require("ejoysdk_lua.player.player_info")
local ejoysdk_player_cache = require("ejoysdk_lua.player.player_info_cache")
local friend_cache = require("ejoysdk_lua.friend.ejoysdk_friend_cache")
local util = require("ejoysdk_lua.ejoysdk_utils")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local quality = require("ejoysdk_lua.ejoysdk_qualitylog")
local voice = require("ejoysdk_lua.chat.ejoysdk_voice")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local player_scene = require("ejoysdk_lua.player.player_info_scene")
local voice_topic = require("ejoysdk_lua.chat.ejoysdk_voice_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local chat_api = require("ejoysdk_lua.server_api.ejoysdk_chat_api")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local TAG = EM.MODULE.CHAT .. "chat_base"
local M = {}
local TYPE_PERSONAL = "personal"
local TYPE_GROUP = "group"
local TYPE_SYSTEM = "system"
local SYSTEM_CHAT_GROUP = "chat_group"
local SYSTEM_CHAT = "chat"
local SYSTEM_FRIEND = "friend"
local SYSTEM_GAME = "game"
local SYSTEM_GANGPLANK = "gangplank"
M.TYPE_PERSONAL = TYPE_PERSONAL
M.TYPE_GROUP = TYPE_GROUP
M.TYPE_SYSTEM = TYPE_SYSTEM
M.SYSTEM_CHAT_GROUP = SYSTEM_CHAT_GROUP
M.SYSTEM_CHAT = SYSTEM_CHAT
M.SYSTEM_FRIEND = SYSTEM_FRIEND
M.SYSTEM_GAME = SYSTEM_GAME
M.SYSTEM_GANGPLANK = SYSTEM_GANGPLANK
local PLAYER_INFO, AUTO_LOGIN
local DEFAULT_RETRY_CONNECT_TIMES = 10
local max_retry_times = DEFAULT_RETRY_CONNECT_TIMES
local no_limit_retry_connect = true
local retry_connect_times = 0
local last_error_msg = ""
local GET_PLAYER_INFO_FAIL_CODE = -400001
local GET_PLAYER_INFO_FAIL_MESSAGE = "get player info fail"
local curr_voice_channel
local retry_connect_index = 0
local last_time_for_first_retry_connect = 0
local retry_connect_max_time_gap = 30
local delay_time_action_obj_array = {}

function M.get_last_error_msg()
  return last_error_msg
end

local get_chat_token_code_503_first_time = 0

local function init_server_v2()
  E.LOG.d(TAG, "chat_connect: init_server_v2 start")
  
  local function init_socket_connect(server_init_start_cb)
    local param = M.common_params_for_connect()
    param.invoke_src = "player_token_handler"
    quality.socket_connect_statistics(STATES.CONNECT_INVOKE, param)
    ET.publish(ET.chat.UPDATE_STATE, STATES.CONNECT_INVOKE)
    M.call_on_server_init_start()
    if server_init_start_cb then
      server_init_start_cb()
    end
    server.init(PLAYER_INFO, true)
  end
  
  ET.publish(ET.chat.UPDATE_STATE, STATES.GET_CHAT_TOKEN)
  local max_retry_get_times = 3
  local retry_time = 0
  local real_http_chat_token
  local last_player_id = PLAYER_INFO and PLAYER_INFO.player_id
  
  function real_http_chat_token()
    M.call_get_chat_token_start()
    chat_api.get_chat_token(function(succ, ...)
      E.LOG.debug(TAG, "chat_connect: fetch chat_token result=" .. tostring(succ))
      if succ then
        local current_player_id = EG.player_info() and EG.player_info().player_id
        if last_player_id and last_player_id ~= current_player_id then
          E.LOG.debug(TAG, "fetch chat_token not match, last_player_id=" .. tostring(last_player_id) .. ", current_player_id=" .. tostring(current_player_id))
          retry_time = 0
          M.call_get_chat_token_end()
          return
        end
        retry_time = 0
        local data = (...)
        chat_token.update_token_data(data)
        E.LOG.debug(TAG, "chat_connect: fetch chat_token succ, use chat login v2")
        init_socket_connect(function()
          M.call_get_chat_token_end()
        end)
      else
        local code, msg = ...
        if 503 == code then
          if 0 == get_chat_token_code_503_first_time then
            get_chat_token_code_503_first_time = E.time()
          end
          if E.time() - get_chat_token_code_503_first_time >= 3600 then
            E.LOG.d(TAG, "chat_connect: fetch chat_token fail, server error")
            last_error_msg = "server error, detail:" .. tostring(msg)
            PLAYER_INFO = nil
            ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
            M.call_get_chat_token_end()
            M.callback_global(CALLBACK.HANDLER_NAME.ON_CONNECT_LOST, CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_ERROR_ON_GET_CHAT_TOKEN)
            local param = M.common_params_for_connect()
            param.last_error_msg = M.get_last_error_msg()
            quality.socket_connect_statistics(STATES.CONNECT_LOST, param)
            return
          end
        else
          get_chat_token_code_503_first_time = 0
        end
        if 401 == code then
          E.LOG.d(TAG, "chat_connect: fetch chat_token fail, player token expire")
          last_error_msg = "player token expire, detail:" .. tostring(msg)
          PLAYER_INFO = nil
          ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
          M.call_get_chat_token_end()
          M.callback_global(CALLBACK.HANDLER_NAME.ON_CONNECT_LOST, CONSTANTS.CHAT_ERROR_CODES.CODE_CONNECT_LOST_FROM_TOKEN_EXPIRE)
          local param = M.common_params_for_connect()
          param.last_error_msg = M.get_last_error_msg()
          quality.socket_connect_statistics(STATES.CONNECT_LOST, param)
          return
        end
        if retry_time >= max_retry_get_times then
          retry_time = 0
          chat_token.reset_token_data()
          E.LOG.debug(TAG, "chat_connect: fetch chat_token fail reach max count, use chat login v1")
          M.call_get_chat_token_end()
          init_socket_connect(function()
            M.call_get_chat_token_end()
          end)
          return
        end
        retry_time = retry_time + 1
        E.LOG.debug(TAG, "chat_connect: fetch chat_token fail, then retry fetch, retry_time=" .. tostring(retry_time))
        E.Timer.once(1, function()
          real_http_chat_token()
        end)
      end
    end)
  end
  
  if chat_token.is_chat_token_valid() then
    E.LOG.debug(TAG, "chat_connect: chat_token is valid, keep use")
    init_socket_connect()
  else
    E.LOG.debug(TAG, "chat_connect: chat_token is not valid, fetch new chat_token")
    real_http_chat_token()
  end
end

local function player_token_handler()
  E.LOG.d(TAG, "chat_connect: player_token_handler start, AUTO_LOGIN=" .. tostring(AUTO_LOGIN))
  if PLAYER_INFO then
    local new_player_info = EG.player_info()
    if new_player_info and new_player_info.player_id and new_player_info.player_id ~= PLAYER_INFO.player_id then
      E.LOG.d(TAG, "fetch chat_token not match and clear, last_player_id=" .. tostring(PLAYER_INFO.player_id))
      chat_token.reset_token_data()
    end
  end
  server.reset_global_data()
  PLAYER_INFO = EG.player_info()
  ET.publish(ET.chat.INITED, true)
  if AUTO_LOGIN then
    ET.publish(ET.chat.UPDATE_STATE, STATES.GET_PLAYER_TOKEN_AUTO_LOGIN)
    M.init_server()
  else
    ET.publish(ET.chat.UPDATE_STATE, STATES.GET_PLAYER_TOKEN)
  end
end

local function clear_data(code)
  PLAYER_INFO = nil
  for _, item in pairs(delay_time_action_obj_array) do
    item.enable = false
  end
  delay_time_action_obj_array = {}
  M.reset_retry_connect_index()
  STATES.reset_current_state()
  chat_token.reset_token_data()
  server.reset_global_data()
  server.close(code)
end

local function player_offline_handler()
  clear_data(CONSTANTS.CHAT_ERROR_CODES.CODE_GP_PLAYER_OFFLINE)
end

local function gangplank_logout_handler()
  clear_data(CONSTANTS.CHAT_ERROR_CODES.CODE_GP_ACCOUNT_LOGOUT)
end

local function gangplank_exit_handler()
  clear_data(CONSTANTS.CHAT_ERROR_CODES.CODE_GP_APP_EXIT)
end

local function on_network_change(state_info)
  if nil ~= state_info and type(state_info) == "table" and nil ~= state_info.state and tostring(state_info.state) ~= "0" then
    M.reset_retry_connect_index()
  end
end

local function channel_join_succ_handler(channel_id, uid)
  curr_voice_channel = channel_id
end

local function channel_leave_succ_handler()
  curr_voice_channel = nil
end

function M.init(auto_login, retry_times)
  if nil == auto_login then
    auto_login = true
  end
  AUTO_LOGIN = auto_login
  if retry_times and type(retry_times) == "number" then
    max_retry_times = retry_times
    no_limit_retry_connect = false
  end
  STATES.init()
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_token_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.EXIT, gangplank_exit_handler)
  ET.subscribe(voice_topic.VOICE_ON_JOIN_CHANNEL_SUCC, channel_join_succ_handler)
  ET.subscribe(voice_topic.VOICE_ON_LEAVE_CHANNEL_SUCC, channel_leave_succ_handler)
  ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change)
  DISPATCHER.register_server_handlers(M.SERVER_HANDLERS)
end

function M.init_server()
  if PLAYER_INFO then
    init_server_v2()
  else
    E.LOG.d(TAG, "chat_connect: PLAYER_INFO miss on init_server func")
    ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
  end
end

function M.tick()
  server.tick()
end

function M.close(code)
  server.close(code)
end

local destination_server_init_handlers_cache = {}

function M.unregister_server_init_handlers(destination)
  destination_server_init_handlers_cache[destination] = nil
end

function M.register_server_init_handlers(destination, server_init_handlers)
  M.unregister_server_init_handlers(destination)
  destination_server_init_handlers_cache[destination] = server_init_handlers
end

function M.call_on_server_init_start()
  local player = destination_server_init_handlers_cache[server.DESTINATION.PLAYER]
  if player and player.on_server_init_start then
    player.on_server_init_start()
  end
  local account = destination_server_init_handlers_cache[server.DESTINATION.ACCOUNT]
  if account and account.on_server_init_start then
    account.on_server_init_start()
  end
end

function M.call_get_chat_token_start()
  local player = destination_server_init_handlers_cache[server.DESTINATION.PLAYER]
  if player and player.get_chat_token_start then
    player.get_chat_token_start()
  end
  local account = destination_server_init_handlers_cache[server.DESTINATION.ACCOUNT]
  if account and account.get_chat_token_start then
    account.get_chat_token_start()
  end
end

function M.call_get_chat_token_end()
  local player = destination_server_init_handlers_cache[server.DESTINATION.PLAYER]
  if player and player.get_chat_token_end then
    player.get_chat_token_end()
  end
  local account = destination_server_init_handlers_cache[server.DESTINATION.ACCOUNT]
  if account and account.get_chat_token_end then
    account.get_chat_token_end()
  end
end

local start_with = E.Utils.start_with
local split_string = E.Utils.split_string

function M.get_session_type(session_id)
  assert(session_id, "session_id is nil!")
  local result = {}
  if start_with(session_id, TYPE_GROUP) then
    result.type = TYPE_GROUP
    result.from = split_string(session_id, ":")[1]
  elseif start_with(session_id, TYPE_SYSTEM) then
    result.type = TYPE_SYSTEM
    local system_name = split_string(session_id, ":")[1]
    result.from = system_name == TYPE_SYSTEM and "" or system_name:gsub(TYPE_SYSTEM .. "_", "")
    local user_id = split_string(session_id, ":")[2] or ""
    if start_with(user_id, "acc_") then
      result.system_user_type = ejoysdk_player_info.SYSTEM_USER_TYPE.ACCOUNT
    else
      result.system_user_type = ejoysdk_player_info.SYSTEM_USER_TYPE.PLAYER
    end
  else
    result.type = TYPE_PERSONAL
    local user_ids = split_string(session_id, ":")
    local def_user_id = ""
    for _, id in ipairs(user_ids) do
      local user_type_info = ejoysdk_player_info.get_user_type_info(id)
      if user_type_info.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.ACCOUNT then
        local my_user_id = EG.user_info().uid
        def_user_id = my_user_id
        if result.personal_user_type ~= ejoysdk_player_info.PERSONAL_USER_TYPE.CUSTOMER then
          result.personal_user_type = ejoysdk_player_info.PERSONAL_USER_TYPE.ACCOUNT
        end
        if user_type_info.user_id ~= my_user_id then
          result.from = user_type_info.user_id
          result.from_chat_user_id = id
        else
          result.my = user_type_info.user_id
          result.my_chat_user_id = id
        end
      elseif user_type_info.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.CUSTOMER then
        result.from = user_type_info.user_id
        result.from_chat_user_id = user_type_info.user_id
        result.personal_user_type = ejoysdk_player_info.PERSONAL_USER_TYPE.CUSTOMER
      elseif user_type_info.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.PLAYER then
        local my_player_id
        if EG.player_info() and EG.player_info().player_id then
          my_player_id = EG.player_info().player_id
          def_user_id = my_player_id
        end
        result.personal_user_type = ejoysdk_player_info.PERSONAL_USER_TYPE.PLAYER
        if id ~= my_player_id then
          result.from = id
          result.from_chat_user_id = id
        else
          result.my = my_player_id
          result.my_chat_user_id = my_player_id
        end
      end
    end
    if not result.from then
      result.from = def_user_id
      if result.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.PLAYER then
        result.from_chat_user_id = def_user_id
      elseif result.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.ACCOUNT then
        result.from_chat_user_id = ejoysdk_player_info.USER_ID_PREFIX_ACCOUNT .. def_user_id
      end
      local err_info = "session:" .. tostring(session_id) .. ",def:" .. tostring(result.from)
      ESTAT.stat_fatal_error("ejoy_chat_from_nil_check", "chat_err_session_id_nil_from_check", false, {err_info = err_info})
    end
  end
  return result
end

function M.get_session_destination(session_id)
  local session_type_info = M.get_session_type(session_id)
  if session_type_info and (session_type_info.personal_user_type or session_type_info.system_user_type) and (session_type_info.personal_user_type == "cs" or session_type_info.personal_user_type == "account" or session_type_info.system_user_type == "account") then
    return server.DESTINATION.ACCOUNT
  end
  return server.DESTINATION.PLAYER
end

function M.personal_session_id(with_player_id)
  assert(with_player_id, "with_player_id is nil!")
  if not PLAYER_INFO then
    return ""
  end
  local player_id = PLAYER_INFO.player_id
  local session_id
  if with_player_id < player_id then
    session_id = with_player_id .. ":" .. player_id
  else
    session_id = player_id .. ":" .. with_player_id
  end
  return session_id
end

local function stat_ret_fail(ret, pre_stat_key, send_id, ext)
  if ret and 0 ~= ret.code then
    local stat_key = tostring(pre_stat_key) .. "_" .. tostring(ret.code)
    local param = {}
    param.code = ret.code or ""
    param.message = ret.message or ""
    param.cmd = pre_stat_key or ""
    param.send_id = send_id or ""
    if ext and ext.session_id then
      param.session_id = ext.session_id
    end
    if tostring(param.code) == "-1" or tostring(param.code) == "-10" or tostring(param.code) == "7010100" then
      E.LOG.d(TAG, "stat_ret_fail, code=" .. tostring(param.code))
      return
    end
    ESTAT.stat_error_with_limit("ejoysdk_chat_base", stat_key, "ejoy_chat_ret_fail", "chat_err_rpc_resp_err_" .. tostring(ret.code) or "", param)
  end
end

function M.check_ret_fail(cb, ret, stat_type, ext)
  if not cb or not ret then
    return true
  end
  if 0 ~= ret.code then
    if stat_type then
      stat_ret_fail(ret, stat_type, nil, ext)
    end
    cb(false, ret.code, ret.message or "")
    return true
  else
    return false
  end
end

function M.check_send_ret_fail(cb, ret, send_id)
  if not cb or not ret then
    return true
  end
  if 0 ~= ret.code then
    stat_ret_fail(ret, "send", send_id)
    cb(false, ret.code, ret.message or "", send_id, ret.error_detail or {})
    return true
  else
    return false
  end
end

local function pick_uid_from_system_chat_msg(msg, target_ids)
  if not msg.content then
    return
  end
  if not msg.content.type then
    return
  end
  if msg.content.type ~= "chat_event" then
    return
  end
  if not msg.content.data then
    return
  end
  if msg.content.data.cmd == "info_create_group" then
    if msg.content.data.group and msg.content.data.group.invited_member_infos and next(msg.content.data.group.invited_member_infos) ~= nil then
      for _, invited_member_info in pairs(msg.content.data.group.invited_member_infos) do
        ejoysdk_player_info.classify_ids(target_ids, invited_member_info.user_id)
      end
    end
    if msg.content.data.group and msg.content.data.group.member_infos and nil ~= next(msg.content.data.group.member_infos) then
      for _, member_info in pairs(msg.content.data.group.member_infos) do
        ejoysdk_player_info.classify_ids(target_ids, member_info.user_id)
      end
    end
  elseif msg.content.data.cmd == "info_delete_group" then
    E.LOG.d(TAG, "info_delete_group")
  elseif msg.content.data.cmd == "info_add_group_member" then
    local inviter_id
    if msg.content.data.inviter_info and msg.content.data.inviter_info.user_id then
      inviter_id = msg.content.data.inviter_info.user_id
    end
    if inviter_id then
      ejoysdk_player_info.classify_ids(target_ids, inviter_id)
    end
    if msg.content.data.add_member_infos then
      for _, add_member_info in pairs(msg.content.data.add_member_infos) do
        ejoysdk_player_info.classify_ids(target_ids, add_member_info.user_id)
      end
    end
  elseif msg.content.data.cmd == "info_group_reserve_member" then
    local reserve_member_data = msg.content.data.reserve_member_data
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.invite_user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.invite_user_id)
      end
      if member_data.reserve_user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.reserve_user_id)
      end
      if member_data.audit_user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.audit_user_id)
      end
    end
  elseif msg.content.data.cmd == "info_group_abnormal_reserve_member" then
    local reserve_member_data = msg.content.data.abnormal_users
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.user_id)
      end
    end
  end
end

local function fill_player_info_for_system_chat_msg(msg, combined_user_infos)
  if not msg.content then
    return
  end
  if not msg.content.type then
    return
  end
  if msg.content.type ~= "chat_event" then
    return
  end
  if not msg.content.data then
    return
  end
  if msg.content.data.cmd == "info_create_group" then
    if msg.content.data.group and msg.content.data.group.invited_member_infos and next(msg.content.data.group.invited_member_infos) ~= nil then
      for _, invited_member_info in pairs(msg.content.data.group.invited_member_infos) do
        local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, invited_member_info.user_id)
        if user_info then
          util.merge_table(invited_member_info, user_info)
        end
      end
    end
    if msg.content.data.group and msg.content.data.group.member_infos and nil ~= next(msg.content.data.group.member_infos) then
      for _, member_info in pairs(msg.content.data.group.member_infos) do
        local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_info.user_id)
        if user_info then
          util.merge_table(member_info, user_info)
        end
      end
    end
  elseif msg.content.data.cmd == "info_delete_group" then
    E.LOG.d(TAG, "info_delete_group")
  elseif msg.content.data.cmd == "info_add_group_member" then
    local inviter_id
    if msg.content.data.inviter_info and msg.content.data.inviter_info.user_id then
      inviter_id = msg.content.data.inviter_info.user_id
    end
    if inviter_id then
      local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, inviter_id)
      if user_info then
        util.merge_table(msg.content.data.inviter_info, user_info)
      end
    end
    if msg.content.data.add_member_infos then
      for _, add_member_info in pairs(msg.content.data.add_member_infos) do
        local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, add_member_info.user_id)
        if user_info then
          util.merge_table(add_member_info, user_info)
        end
      end
    end
  elseif msg.content.data.cmd == "info_group_reserve_member" then
    local reserve_member_data = msg.content.data.reserve_member_data
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.invite_user_id then
        local invite_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.invite_user_id)
        if invite_user_info then
          member_data.invite_user_info = invite_user_info
        end
      end
      if member_data.reserve_user_id then
        local reserve_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.reserve_user_id)
        if reserve_user_info then
          member_data.reserve_user_info = reserve_user_info
        end
      end
      if member_data.audit_user_id then
        local audit_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.audit_user_id)
        if audit_user_info then
          member_data.audit_user_info = audit_user_info
        end
      end
    end
  elseif msg.content.data.cmd == "info_group_abnormal_reserve_member" then
    local reserve_member_data = msg.content.data.abnormal_users
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.user_id then
        local abnormal_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.user_id)
        if not member_data.abnormal_user_info then
          member_data.abnormal_user_info = abnormal_user_info
        end
      end
    end
  end
end

function M.is_group_session_system_msg(msg)
  if msg and msg.content and msg.content.type and msg.content.type == "chat_event" then
    return true
  end
  return false
end

function M.chat_event_pick_uid_from_msg(msg, target_ids)
  if not M.is_group_session_system_msg(msg) then
    return
  end
  if not msg.content.data then
    return
  end
  if msg.content.data.cmd == "info_create_group" then
    if msg.content.data.group and msg.content.data.group.invited_member_infos and next(msg.content.data.group.invited_member_infos) ~= nil then
      for _, invited_member_info in pairs(msg.content.data.group.invited_member_infos) do
        ejoysdk_player_info.classify_ids(target_ids, invited_member_info.user_id)
      end
    end
    if msg.content.data.group and msg.content.data.group.member_infos and nil ~= next(msg.content.data.group.member_infos) then
      for _, member_info in pairs(msg.content.data.group.member_infos) do
        ejoysdk_player_info.classify_ids(target_ids, member_info.user_id)
      end
    end
    if msg.content.data.group.owner then
      ejoysdk_player_info.classify_ids(target_ids, msg.content.data.group.owner)
    end
  elseif msg.content.data.cmd == "info_update_group" then
    if msg.content.data.op_user then
      ejoysdk_player_info.classify_ids(target_ids, msg.content.data.op_user)
    end
  elseif msg.content.data.cmd == "info_delete_group" then
    E.LOG.d(TAG, "info_delete_group")
  elseif msg.content.data.cmd == "info_add_group_member" then
    local inviter_id
    if msg.content.data.inviter_info and msg.content.data.inviter_info.user_id then
      inviter_id = msg.content.data.inviter_info.user_id
    end
    if inviter_id then
      ejoysdk_player_info.classify_ids(target_ids, inviter_id)
    end
    if msg.content.data.add_member_infos then
      for _, add_member_info in pairs(msg.content.data.add_member_infos) do
        ejoysdk_player_info.classify_ids(target_ids, add_member_info.user_id)
      end
    end
  elseif msg.content.data.cmd == "info_remove_group_member" then
    local remove_info = msg.content.data.remove_info
    if remove_info and remove_info.remover and remove_info.remove_type == "by_owner" then
      ejoysdk_player_info.classify_ids(target_ids, remove_info.remover)
    end
    for _, remove_id in ipairs(msg.content.data.removes or {}) do
      ejoysdk_player_info.classify_ids(target_ids, remove_id)
    end
  elseif msg.content.data.cmd == "info_group_reserve_member" then
    local reserve_member_data = msg.content.data.reserve_member_data
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.invite_user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.invite_user_id)
      end
      if member_data.reserve_user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.reserve_user_id)
      end
      if member_data.audit_user_id then
        ejoysdk_player_info.classify_ids(target_ids, member_data.audit_user_id)
      end
    end
  end
end

function M.chat_event_fill_player_info_system_msg(msg, combined_user_infos)
  if not M.is_group_session_system_msg(msg) then
    return
  end
  if not msg.content.data then
    return
  end
  if msg.content.data.cmd == "info_create_group" then
    if msg.content.data.group and msg.content.data.group.invited_member_infos and next(msg.content.data.group.invited_member_infos) ~= nil then
      for _, invited_member_info in pairs(msg.content.data.group.invited_member_infos) do
        local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, invited_member_info.user_id)
        if user_info then
          util.merge_table(invited_member_info, user_info)
        end
      end
    end
    if msg.content.data.group and msg.content.data.group.member_infos and nil ~= next(msg.content.data.group.member_infos) then
      for _, member_info in pairs(msg.content.data.group.member_infos) do
        local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_info.user_id)
        if user_info then
          util.merge_table(member_info, user_info)
        end
      end
    end
    if msg.content.data.group.owner then
      local owner_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, msg.content.data.group.owner)
      if owner_info then
        msg.content.data.group.owner_info = owner_info
      end
    end
  elseif msg.content.data.cmd == "info_update_group" then
    if msg.content.data.op_user then
      local op_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, msg.content.data.op_user)
      if op_user_info then
        msg.content.data.op_user_info = op_user_info
      end
    end
  elseif msg.content.data.cmd == "info_delete_group" then
    E.LOG.d(TAG, "info_delete_group")
  elseif msg.content.data.cmd == "info_add_group_member" then
    local inviter_id
    if msg.content.data.inviter_info and msg.content.data.inviter_info.user_id then
      inviter_id = msg.content.data.inviter_info.user_id
    end
    if inviter_id then
      local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, inviter_id)
      if user_info then
        util.merge_table(msg.content.data.inviter_info, user_info)
      end
    end
    if msg.content.data.add_member_infos then
      for _, add_member_info in pairs(msg.content.data.add_member_infos) do
        local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, add_member_info.user_id)
        if user_info then
          util.merge_table(add_member_info, user_info)
        end
      end
    end
  elseif msg.content.data.cmd == "info_remove_group_member" then
    local remove_info = msg.content.data.remove_info
    if remove_info and remove_info.remover and remove_info.remove_type == "by_owner" then
      local remover_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, remove_info.remover)
      if remover_info then
        remove_info.remover_info = remover_info
      end
    end
    local remove_member_infos = {}
    for _, remove_id in ipairs(msg.content.data.removes or {}) do
      local remove_member_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, remove_id)
      if remove_member_info then
        table.insert(remove_member_infos, remove_member_info)
      end
    end
    msg.content.data.remove_member_infos = remove_member_infos
  elseif msg.content.data.cmd == "info_group_reserve_member" then
    local reserve_member_data = msg.content.data.reserve_member_data
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.invite_user_id then
        local invite_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.invite_user_id)
        if invite_user_info then
          member_data.invite_user_info = invite_user_info
        end
      end
      if member_data.reserve_user_id then
        local reserve_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.reserve_user_id)
        if reserve_user_info then
          member_data.reserve_user_info = reserve_user_info
        end
      end
      if member_data.audit_user_id then
        local audit_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.audit_user_id)
        if audit_user_info then
          member_data.audit_user_info = audit_user_info
        end
      end
    end
  end
end

function M.replace_latest_sessions_user_info_before_cb(sessions, cb, fail_cb)
  cb = cb or function()
  end
  fail_cb = fail_cb or function()
  end
  local ids = {}
  for _, session in pairs(sessions) do
    local session_info = session.session_info
    local session_type = M.get_session_type(session_info.id)
    if session_type and session_type.from_chat_user_id then
      ejoysdk_player_info.classify_ids(ids, session_type.from_chat_user_id)
    end
    if session_type and session_type.my_chat_user_id then
      ejoysdk_player_info.classify_ids(ids, session_type.my_chat_user_id)
    end
    if session_type.type == M.TYPE_PERSONAL or session_type.type == M.TYPE_GROUP then
      local last_msgs = session.last_msgs
      for _, msg in ipairs(last_msgs) do
        ejoysdk_player_info.classify_ids(ids, msg.src_info.user_id)
      end
    end
    if session_type.type == M.TYPE_GROUP then
      local group = session.session_info.info
      if group then
        local member_infos = group.member_infos
        if member_infos then
          for _, user_info in pairs(member_infos) do
            ejoysdk_player_info.classify_ids(ids, user_info.user_id)
          end
        end
        local invited_member_infos = group.invited_member_infos
        if invited_member_infos then
          for _, user_info in pairs(invited_member_infos) do
            ejoysdk_player_info.classify_ids(ids, user_info.user_id)
          end
        end
      end
    end
    if start_with(session_info.id, "system_chat") and session.last_msgs and next(session.last_msgs) then
      pick_uid_from_system_chat_msg(session.last_msgs[1], ids)
    elseif session_type.type == M.TYPE_GROUP and session.last_msgs and next(session.last_msgs) and M.is_group_session_system_msg(session.last_msgs[1]) then
      M.chat_event_pick_uid_from_msg(session.last_msgs[1], ids)
    end
  end
  
  local function replace_with_new_user_infos(new_users)
    for _, session in pairs(sessions) do
      local session_info = session.session_info
      local session_type = M.get_session_type(session_info.id)
      if session_type.type == M.TYPE_PERSONAL or session_type.type == M.TYPE_GROUP then
        local last_msgs = session.last_msgs
        for _, msg in ipairs(last_msgs) do
          local find_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(new_users, msg.src_info.user_id)
          if find_user_info then
            msg.src_info = util.merge_table(msg.src_info, find_user_info)
          end
        end
      end
      if session_type.type == M.TYPE_PERSONAL then
        if session_type.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.PLAYER then
          local find_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(new_users, session_type.from_chat_user_id)
          session_info._info = find_user_info
        elseif session_type.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.CUSTOMER then
          local find_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(new_users, session_type.from_chat_user_id)
          session_info._info = find_user_info
        end
      end
      if session_type.type == M.TYPE_GROUP then
        local group = session.session_info.info
        if group then
          local member_infos = group.member_infos
          if member_infos then
            for i, user_info in pairs(member_infos) do
              local find_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(new_users, user_info.user_id)
              user_info = find_user_info or user_info
              member_infos[i] = user_info
            end
          end
          local invited_member_infos = group.invited_member_infos
          if invited_member_infos then
            for i, user_info in pairs(invited_member_infos) do
              local find_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(new_users, user_info.user_id)
              user_info = find_user_info or user_info
              invited_member_infos[i] = user_info
            end
          end
        end
      end
      if start_with(session_info.id, "system_chat") and session.last_msgs and next(session.last_msgs) then
        fill_player_info_for_system_chat_msg(session.last_msgs[1], new_users)
      elseif session_type.type == M.TYPE_GROUP and session.last_msgs and next(session.last_msgs) then
        for _, last_msg in pairs(session.last_msgs) do
          if M.is_group_session_system_msg(last_msg) then
            M.chat_event_fill_player_info_system_msg(last_msg, new_users)
          end
        end
      end
    end
  end
  
  ejoysdk_player_info.batch_get_infos(ids, {
    scene = player_scene.OFFICIAL_SCENE.CHAT
  }, function(succ, ...)
    if succ then
      local user_infos = (...)
      replace_with_new_user_infos(user_infos)
      cb(sessions)
    else
      fail_cb()
    end
  end)
end

function M._msgs_player_to_cache(msgs)
  for _, msg in pairs(msgs) do
    if msg.src_type == "user" then
      local player = msg.src_info
      local player_id = msg.src_info.user_id
      local has_player_info = msg.src_info.player_info ~= nil
      local is_new_msg = 0 == msg.reader_status
      local user_type_info = ejoysdk_player_info.get_user_type_info(player_id)
      if user_type_info.personal_user_type and user_type_info.personal_user_type == ejoysdk_player_info.PERSONAL_USER_TYPE.PLAYER and has_player_info and is_new_msg then
        local scene = msg.src_info.scene or player_scene.OFFICIAL_SCENE.CHAT
        ejoysdk_player_cache.add_player_info(player_id, player, "chat_info_msg", scene)
      end
    end
  end
end

function M.replace_reply_res_user_info_before_cb(msg, cb, need_replace)
  if nil == msg or nil == msg.reply_res then
    return
  end
  cb = cb or function()
  end
  if not need_replace then
    cb({msg})
    return
  end
  local ids_group_by_scene = {}
  local res_scene_id = player_scene.OFFICIAL_SCENE.CHAT_MSG_RES
  ids_group_by_scene[res_scene_id] = {}
  for _, res in pairs(msg.reply_res or {}) do
    for _, user_id in pairs(res.user_ids or {}) do
      ejoysdk_player_info.classify_ids(ids_group_by_scene[res_scene_id], user_id)
    end
  end
  ejoysdk_player_info.batch_get_infos(ids_group_by_scene[res_scene_id], {scene = res_scene_id}, function(succ, ...)
    if succ then
      local combined_user_infos = (...)
      M.replace_reply_res_user_info(msg, combined_user_infos)
    end
    cb({msg})
  end)
end

function M.replace_msgs_user_info_before_cb(msgs, cb, fail_cb, need_replace_res_user_info)
  cb = cb or function()
  end
  fail_cb = fail_cb or function()
  end
  msgs = msgs or {}
  if next(msgs) == nil then
    cb(msgs)
    return
  end
  local ids_group_by_scene = {}
  local scene_count = 0
  if not ids_group_by_scene[player_scene.OFFICIAL_SCENE.CHAT] then
    ids_group_by_scene[player_scene.OFFICIAL_SCENE.CHAT] = {}
  end
  local res_scene_id = player_scene.OFFICIAL_SCENE.CHAT_MSG_RES
  local ids_group_by_res_scene = {}
  for _, msg in pairs(msgs) do
    if start_with(msg.session_id, "system_chat") then
      pick_uid_from_system_chat_msg(msg, ids_group_by_scene[player_scene.OFFICIAL_SCENE.CHAT])
    elseif M.is_group_session_system_msg(msg) then
      M.chat_event_pick_uid_from_msg(msg, ids_group_by_scene[player_scene.OFFICIAL_SCENE.CHAT])
    else
      local scene_id = msg.src_info.scene or player_scene.OFFICIAL_SCENE.CHAT
      if not ids_group_by_scene[scene_id] then
        ids_group_by_scene[scene_id] = {}
        scene_count = scene_count + 1
      end
      ejoysdk_player_info.classify_ids(ids_group_by_scene[scene_id], msg.src_info.user_id)
      for _, quote_msg in pairs(msg.quote_msgs or {}) do
        ejoysdk_player_info.classify_ids(ids_group_by_scene[scene_id], quote_msg.src_info.user_id)
      end
    end
    local reply_res = need_replace_res_user_info and msg.reply_res or {}
    for i = #reply_res, 1, -1 do
      local res = reply_res[i]
      for _, user_id in pairs(res.user_ids or {}) do
        ejoysdk_player_info.classify_ids(ids_group_by_res_scene, user_id)
      end
      if res.user_num <= 0 then
        table.remove(reply_res, i)
      end
    end
  end
  if not ids_group_by_res_scene or not next(ids_group_by_res_scene) then
    ids_group_by_res_scene = nil
  end
  local batch_get_infos_finish_count = 0
  local has_fail = false
  for scene_id, ids in pairs(ids_group_by_scene) do
    ejoysdk_player_info.batch_get_infos(ids, {scene = scene_id}, function(succ, ...)
      batch_get_infos_finish_count = batch_get_infos_finish_count + 1
      if succ then
        local combined_user_infos = (...)
        for _, msg in pairs(msgs) do
          if start_with(msg.session_id, "system_chat") then
            fill_player_info_for_system_chat_msg(msg, combined_user_infos)
          elseif M.is_group_session_system_msg(msg) then
            M.chat_event_fill_player_info_system_msg(msg, combined_user_infos)
          else
            local user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, msg.src_info.user_id)
            if user_info then
              msg.src_info = util.merge_table(msg.src_info, user_info)
            end
            for _, quote_msg in pairs(msg.quote_msgs or {}) do
              local quoted_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, quote_msg.src_info.user_id)
              if quoted_user_info then
                quote_msg.src_info = util.merge_table(quote_msg.src_info, quoted_user_info)
              end
            end
          end
        end
      else
        has_fail = true
      end
      if batch_get_infos_finish_count < scene_count then
        return
      end
      if has_fail then
        fail_cb()
      elseif ids_group_by_res_scene then
        ejoysdk_player_info.batch_get_infos(ids_group_by_res_scene, {scene = res_scene_id}, function(get_res_succ, combined_res_user_infos)
          if get_res_succ then
            for _, msg in pairs(msgs) do
              M.replace_reply_res_user_info(msg, combined_res_user_infos)
            end
          end
          cb(msgs)
        end)
      else
        cb(msgs)
      end
    end)
  end
end

function M.replace_reply_res_user_info(msg, combined_user_infos)
  local reply_res = msg.reply_res
  if not reply_res then
    return
  end
  if not msg.reply_res_src_infos then
    msg.reply_res_src_infos = {}
  end
  local res_src_infos = msg.reply_res_src_infos
  for _, res in pairs(reply_res) do
    for _, user_id in pairs(res.user_ids) do
      local res_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, user_id)
      if res_user_info then
        res_src_infos[user_id] = util.merge_table(res_src_infos[user_id] or {}, res_user_info)
      end
    end
  end
end

function M.replace_array_player_before_cb(array, cb, fail_cb)
  cb = cb or function()
  end
  fail_cb = fail_cb or function()
  end
  local ids = {}
  for _, object in pairs(array) do
    local player_id = object.user_id
    table.insert(ids, player_id)
  end
  if #ids > 0 then
    ejoysdk_player_info.get_player_infos(ids, {
      playerid_to_info = true,
      scene = player_scene.OFFICIAL_SCENE.CHAT
    }, function(succ, ...)
      if succ then
        local players = (...)
        for i, object in pairs(array) do
          local player_id = object.user_id
          local player = players[player_id]
          if player then
            array[i] = player
            array[i].user_id = player_id
          end
        end
        cb(array)
      else
        fail_cb()
      end
    end)
  else
    cb(array)
  end
end

function M.replace_groups_user_info(groups, cb, fail_cb)
  cb = cb or function()
  end
  fail_cb = fail_cb or function()
  end
  local ids = {}
  for _, group in pairs(groups) do
    local member_infos = group.member_infos
    if member_infos then
      for _, user_info in pairs(member_infos) do
        ejoysdk_player_info.classify_ids(ids, user_info.user_id)
      end
    end
    local invited_member_infos = group.invited_member_infos
    if invited_member_infos then
      for _, user_info in pairs(invited_member_infos) do
        ejoysdk_player_info.classify_ids(ids, user_info.user_id)
      end
    end
  end
  
  local function replace_with_new_user_infos(user_infos)
    for _, group in pairs(groups) do
      local member_infos = group.member_infos
      if member_infos then
        for i, user_info in pairs(member_infos) do
          local user_id = user_info.user_id
          local user_infos_key = ejoysdk_player_info.PERSONAL_USER_TYPE_TO_INFO_TYPE[user_info.user_type] or ""
          local user_infos_one_type = user_infos[user_infos_key] or {}
          user_info = user_infos_one_type[user_id] or user_info
          user_info.user_id = user_id
          member_infos[i] = user_info
        end
      end
      local invited_member_infos = group.invited_member_infos
      if invited_member_infos then
        for i, user_info in pairs(invited_member_infos) do
          local user_id = user_info.user_id
          user_info = user_infos[user_id] or user_info
          user_info.user_id = user_id
          invited_member_infos[i] = user_info
        end
      end
    end
  end
  
  ejoysdk_player_info.batch_get_infos(ids, {
    scene = player_scene.OFFICIAL_SCENE.CHAT
  }, function(succ, ...)
    if succ then
      local user_infos = (...)
      replace_with_new_user_infos(user_infos)
      cb(groups)
    else
      fail_cb()
    end
  end)
end

function M.replace_groups_reserve_member_data(reserve_member_data, cb, fail_cb)
  cb = cb or function()
  end
  fail_cb = fail_cb or function()
  end
  local ids = {}
  for _, member_data in ipairs(reserve_member_data or {}) do
    if member_data.invite_user_id then
      ejoysdk_player_info.classify_ids(ids, member_data.invite_user_id)
    end
    if member_data.reserve_user_id then
      ejoysdk_player_info.classify_ids(ids, member_data.reserve_user_id)
    end
    if member_data.audit_user_id then
      ejoysdk_player_info.classify_ids(ids, member_data.audit_user_id)
    end
  end
  
  local function replace_with_new_user_infos(combined_user_infos)
    for _, member_data in ipairs(reserve_member_data or {}) do
      if member_data.invite_user_id then
        local invite_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.invite_user_id)
        if invite_user_info then
          member_data.invite_user_info = invite_user_info
        end
      end
      if member_data.reserve_user_id then
        local reserve_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.reserve_user_id)
        if reserve_user_info then
          member_data.reserve_user_info = reserve_user_info
        end
      end
      if member_data.audit_user_id then
        local audit_user_info = ejoysdk_player_info.find_and_copy_in_combined_infos(combined_user_infos, member_data.audit_user_id)
        if audit_user_info then
          member_data.audit_user_info = audit_user_info
        end
      end
    end
  end
  
  ejoysdk_player_info.batch_get_infos(ids, {
    scene = player_scene.OFFICIAL_SCENE.CHAT
  }, function(succ, ...)
    if succ then
      local user_infos = (...)
      replace_with_new_user_infos(user_infos)
      cb(reserve_member_data)
    else
      fail_cb()
    end
  end)
end

function M.replace_groups_player_info(groups, cb, fail_cb)
  M.replace_groups_user_info(groups, cb, fail_cb)
end

function M.send_text_msg(destination, send_id, text, session_id, cb, at_list)
  assert(text and "" ~= text, "text format wrong")
  assert(session_id, "session_id is nil!")
  server.send_msg(destination, text, session_id, send_id, function(ret)
    if M.check_send_ret_fail(cb, ret, send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end, at_list)
end

function M.resend_text_msg(destination, data, send_id, cb)
  if not data then
    cb(false, -1, "resend_text_msg error! send data not found, send_id = " .. tostring(send_id))
    return
  end
  local text = data.text
  local session_id = data.session_id
  local at_list = data.at_list
  assert(text and "" ~= text, "text format wrong")
  assert(session_id, "session_id is nil!")
  server.send_msg(destination, text, session_id, send_id, function(ret)
    if M.check_send_ret_fail(cb, ret, send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end, at_list)
end

function M.send_custom(destination, custom, session_id, cb, at_list)
  assert(table and "table" == type(custom), "custom should be table")
  server.send_custom(destination, custom, session_id, function(ret)
    if M.check_ret_fail(cb, ret, "send_custom") then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end, at_list)
end

function M.send_rich_text_msg(destination, send_id, text, extend_data, session_id, cb, at_list)
  server.send_rich_text_msg(destination, text, extend_data, session_id, send_id, function(ret)
    if M.check_send_ret_fail(cb, ret, send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end, at_list)
end

function M.resend_rich_text_msg(destination, data, send_id, cb)
  if not data then
    cb(false, -1, "resend_rich_text_msg error! send data not found, send_id = " .. tostring(send_id))
    return
  end
  local text = data.text
  local extend_data = data.extend_data
  local session_id = data.session_id
  local at_list = data.at_list
  assert(text and "" ~= text, "text format wrong")
  assert(session_id, "session_id is nil!")
  server.send_rich_text_msg(destination, text, extend_data, session_id, send_id, function(ret)
    if M.check_send_ret_fail(cb, ret, send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end, at_list)
end

function M.send_resource_msg(destination, text, res_type, res_id, extend_data, session_id, at_list, send_id, cb)
  server.send_resource_msg(destination, text, res_type, res_id, extend_data, session_id, at_list, send_id, function(ret)
    if M.check_send_ret_fail(cb, ret, send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end)
end

function M.resend_resource_msg(destination, data, send_id, cb)
  if not data then
    cb(false, -1, "resend_resource_msg error! send data not found, send_id = " .. tostring(send_id))
    return
  end
  local text = data.text
  local res_type = data.res_type
  local res_id = data.res_id
  local extend_data = data.extend_data
  local session_id = data.session_id
  local at_list = data.at_list
  assert(text and "" ~= text, "text format wrong")
  assert(session_id, "session_id is nil!")
  assert(res_type, "res_type is nil!")
  assert(res_id, "res_id is nil!")
  server.send_resource_msg(destination, text, res_type, res_id, extend_data, session_id, at_list, send_id, function(ret)
    if M.check_send_ret_fail(cb, ret, send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id)
  end)
end

function M.send(destination, session_id, content, at_list, cb)
  do return server.send, destination, session_id, content, at_list, function(ret)
    if M.check_send_ret_fail(cb, ret, ret.send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id, ret.send_id)
  end end
  return server.send, destination, session_id, content, at_list, function(ret)
    if M.check_send_ret_fail(cb, ret, ret.send_id) then
      return
    end
    cb(true, ret.session_id, ret.msg_id, ret.send_id)
  end, at_list
end

function M.get_player_latest_at_msgs(destination, cb)
  server.get_player_latest_at_msgs(destination, function(ret)
    if M.check_ret_fail(cb, ret) then
      return
    end
    cb(true, ret.msgs)
  end)
end

function M.get_user_group_broker_info(destination, query, cb)
  server.get_user_group_broker_info(destination, query, function(ret)
    if M.check_ret_fail(cb, ret) then
      return
    end
    cb(true, ret.group_brokers)
  end)
end

function M.switch_group_id(destination, group_broker_id, group_id, cb)
  server.switch_group_id(destination, group_broker_id, group_id, function(ret)
    if M.check_ret_fail(cb, ret) then
      return
    end
    cb(true)
  end)
end

function M.set_receiving_groups(destination, groups, cb)
  server.set_receiving_groups(destination, groups, function(ret)
    if M.check_ret_fail(cb, ret) then
      return
    end
    cb(true, ret)
  end)
end

function M.set_msg_received(destination, session_id, msg_id, cb)
  assert(session_id, "session_id is nil!")
  assert(msg_id, "msg_id is nil!")
  server.set_msg_received(destination, session_id, msg_id, function(ret)
    if M.check_ret_fail(cb, ret, "set_msg_received") then
      return
    end
    cb(true)
  end)
end

function M.delete_msg(destination, session_id, msg_ids, cb)
  server.delete_msg(destination, session_id, msg_ids, function(ret)
    if M.check_ret_fail(cb, ret, "delete_msg") then
      return
    end
    cb(true)
  end)
end

function M.clean_session_msg(destination, session_id, ts, cb)
  server.clean_session_msg(destination, session_id, ts, function(ret)
    if M.check_ret_fail(cb, ret, "clean_session_msg") then
      return
    end
    cb(true)
  end)
end

function M.get_chat_config(destination, cb)
  server.get_chat_config(destination, function(ret)
    if M.check_ret_fail(cb, ret, "get_chat_config") then
      return
    end
    cb(true, ret.config)
  end)
end

function M.set_chat_config(destination, chat_config, cb)
  server.set_chat_config(destination, chat_config, function(ret)
    if M.check_ret_fail(cb, ret, "set_chat_config") then
      return
    end
    cb(true, ret.config)
  end)
end

function M.set_msg_received_with_ts(destination, session_id, ts, cb)
  assert(session_id, "session_id is nil!")
  server.set_msg_received_with_ts(destination, session_id, ts, function(ret)
    if M.check_ret_fail(cb, ret, "set_msg_received") then
      return
    end
    cb(true)
  end)
end

function M._fill_session_info_top(destination, session_info)
  session_info.top = session_info.top or 0
  local session_attrs = cache.get_session_attrs_pending_cache_with_id(destination, session_info.id)
  local local_cache_top = session_attrs and session_attrs.top
  if local_cache_top and 0 == local_cache_top and 0 == session_info.top or local_cache_top and local_cache_top > 0 and session_info.top > 0 then
    session_info.top = math.max(local_cache_top, session_info.top)
    cache.remove_session_attrs_pending_cache_by_id(destination, session_info.id)
    E.LOG.debug(TAG, "_fill_session_info_top equals with server, remove local top cache, sid:" .. tostring(session_info.id))
  elseif local_cache_top then
    E.LOG.debug(TAG, "_fill_session_info_top not equals with server, use local top state:" .. tostring(local_cache_top) .. ", server session top:" .. tostring(session_info.top))
    session_info.top = local_cache_top
  end
end

function M.get_latest_session(destination, cb)
  server.get_latest_session(destination, function(ret)
    if M.check_ret_fail(cb, ret, "get_latest_session") then
      return
    end
    M.replace_latest_sessions_user_info_before_cb(ret.sessions, function(replaced_sessions)
      for _, session in pairs(replaced_sessions) do
        local session_info = session.session_info
        local session_type = M.get_session_type(session_info.id)
        if session_type.type == M.TYPE_PERSONAL or session_type.type == M.TYPE_GROUP then
          session_info.is_ignore = cache.is_ignore_session(session_info.id)
          local last_msgs = session.last_msgs
          for _, msg in pairs(last_msgs) do
            msg.is_ignore = cache.is_ignore_session(session_info.id)
          end
        end
        M._fill_session_info_top(destination, session_info)
      end
      cb(true, ret.sessions)
    end, function()
      cb(false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
    end)
  end)
end

function M.get_latest_session_v2(destination, cb)
  server.get_latest_session(destination, function(ret)
    if M.check_ret_fail(cb, ret, "get_latest_session") then
      return
    end
    M.replace_latest_sessions_user_info_before_cb(ret.sessions, function(replaced_sessions)
      local personal_sessions = {}
      local group_sessions = {}
      local system_sessions = {}
      local other_sessions = {}
      for _, session in pairs(replaced_sessions) do
        local session_info = session.session_info
        local session_type_info = M.get_session_type(session_info.id)
        session._session_type_info = session_type_info
        if session_type_info.type == M.TYPE_PERSONAL or session_type_info.type == M.TYPE_GROUP then
          session_info.is_ignore = cache.is_ignore_session(session_info.id)
          local last_msgs = session.last_msgs
          for _, msg in pairs(last_msgs) do
            msg.is_ignore = cache.is_ignore_session(session_info.id)
          end
        end
        M._fill_session_info_top(destination, session_info)
        if session_type_info.type == M.TYPE_PERSONAL then
          table.insert(personal_sessions, session)
        elseif session_type_info.type == M.TYPE_GROUP then
          table.insert(group_sessions, session)
        elseif session_type_info.type == M.TYPE_SYSTEM then
          table.insert(system_sessions, session)
        else
          table.insert(other_sessions, session)
        end
      end
      local result_sessions = {}
      result_sessions.personal = personal_sessions
      result_sessions.group = group_sessions
      result_sessions.system = system_sessions
      result_sessions.other = other_sessions
      cb(true, result_sessions)
    end, function()
      cb(false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
    end)
  end)
end

local function do_set_session_attrs_pending_cache(destination)
  local all_pending_attrs = cache.get_session_attrs_pending_cache_with_destination(destination)
  if next(all_pending_attrs) == nil then
    E.LOG.warn(TAG, "do_set_session_attrs_pending_cache skip, no pending cache, destination:" .. tostring(destination))
    return
  end
  E.LOG.debug(TAG, "do_set_session_attrs_pending_cache begin, all_pending_attrs, destination:" .. tostring(destination))
  E.log(all_pending_attrs)
  server.set_session_attrs(destination, all_pending_attrs, function(ret)
    if 0 == ret.code then
      E.LOG.debug(TAG, "set_session_attrs succ, update_sessions:")
    else
      local code = ret.code
      local msg = ret.message
      E.LOG.warn(TAG, "set_session_attrs failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
    end
  end)
end

function M.set_session_attrs(destination, session_attrs)
  E.LOG.debug(TAG, "set_session_attrs received destination:" .. tostring(destination))
  E.log(session_attrs)
  cache.save_session_attrs_pending_cache_with_destination(destination, session_attrs)
  do_set_session_attrs_pending_cache(destination)
  return true
end

function M.sync_local_pending_session_attrs_to_server()
  local destinations = {
    server.DESTINATION.ACCOUNT,
    server.DESTINATION.PLAYER
  }
  for _, destination in ipairs(destinations) do
    do_set_session_attrs_pending_cache(destination)
  end
end

function M.get_my_groups(destination, cb)
  if destination == server.DESTINATION.PLAYER then
    local groups = cache.get_all_groups()
    if cb then
      cb(true, groups)
    end
  elseif cb then
    cb(false, CONSTANTS.CHAT_ERROR_CODES.CODE_GROUPS_ONLY_SUPPOT_PLATER_CHAT, "groups only support player chat")
  end
end

function M.get_group(destination, group_id, cb)
  if destination == server.DESTINATION.PLAYER then
    local group = cache.get_group(group_id)
    if cb then
      cb(true, group)
    end
  elseif cb then
    cb(false, CONSTANTS.CHAT_ERROR_CODES.CODE_GROUPS_ONLY_SUPPOT_PLATER_CHAT, "groups only support player chat")
  end
end

function M.get_msg(destination, session_id, opt, cb)
  assert(session_id, "session_id is nil!")
  opt = opt or {}
  local direction = opt.direction or -1
  local max_msg_count = opt.max_msg_count or 50
  local ts = opt.ts
  local msg_id = opt.msg_id
  server.get_msg(destination, session_id, direction, max_msg_count, ts, function(ret)
    if M.check_ret_fail(cb, ret, "get_session_msg", {session_id = session_id}) then
      return
    end
    local msgs = ret.msgs
    for _, msg in pairs(msgs) do
      msg.is_ignore = cache.is_ignore_session(msg.session_id)
    end
    M.replace_msgs_user_info_before_cb(msgs, function(replaced_msgs)
      cb(true, replaced_msgs)
    end, function()
      cb(false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
    end)
  end, msg_id)
end

function M.get_msg_by_id(destination, session_id, msg_ids, cb)
  assert(session_id, "session_id is nil!")
  server.get_msg_by_id(destination, session_id, msg_ids, function(ret)
    if M.check_ret_fail(cb, ret, "get_session_msg") then
      return
    end
    local msgs = ret.msgs
    for _, msg in pairs(msgs) do
      msg.is_ignore = cache.is_ignore_session(msg.session_id)
    end
    M.replace_msgs_user_info_before_cb(msgs, function(replaced_msgs)
      cb(true, replaced_msgs)
    end, function()
      cb(false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
    end)
  end)
end

function M.create_group(members, invite_msg, group_name, cb)
  server.create_group(members, invite_msg, group_name, function(ret)
    if M.check_ret_fail(cb, ret, "create_group") then
      return
    end
    cb(true, ret.group_id)
  end)
end

function M.add_group_member(adds, invite_msg, group_id, cb)
  server.add_group_member(adds, invite_msg, group_id, function(ret)
    if M.check_ret_fail(cb, ret, "add_group_member") then
      return
    end
    cb(true, ret.group_id)
  end)
end

function M.reply_add_group_member(reply_msg, is_agree, group_id, cb, inviter_user_id)
  server.reply_add_group_member(reply_msg, is_agree, group_id, function(ret)
    if M.check_ret_fail(cb, ret, "reply_add_group_member") then
      return
    end
    cb(true, ret.group_id)
  end, inviter_user_id)
end

function M.remove_group_member(removes, remove_msg, group_id, cb)
  server.remove_group_member(removes, remove_msg, group_id, function(ret)
    if M.check_ret_fail(cb, ret, "remove_group_member") then
      return
    end
    cb(true, ret.group_id)
  end)
end

function M.update_group(info, group_id, cb)
  assert(info, "info is nil!")
  assert(group_id, "group_id is nil!")
  server.update_group(info, group_id, function(ret)
    if M.check_ret_fail(cb, ret, "update_group") then
      return
    end
    cb(true, ret.group_id)
  end)
end

function M.delete_group(group_id, cb)
  assert(group_id, "group_id is nil!")
  server.delete_group(group_id, function(ret)
    if M.check_ret_fail(cb, ret, "delete_group") then
      return
    end
    cb(true, ret.group_id)
  end)
end

function M.exit_group(group_id, cb)
  assert(group_id, "group_id is nil!")
  server.exit_group(group_id, function(ret)
    if M.check_ret_fail(cb, ret, "exit_group") then
      return
    end
    cb(true, ret.group_id)
  end)
end

function M.get_group_be_invited_history(cb)
  server.get_group_be_invited_history(function(ret)
    if M.check_ret_fail(cb, ret, "get_group_be_invited_history") then
      return
    end
    local inviter_ids = {}
    for _, item in pairs(ret.be_invited_history) do
      local player_id = item.inviter.user_id
      if player_id then
        table.insert(inviter_ids, player_id)
      end
    end
    if #inviter_ids > 0 then
      ejoysdk_player_info.get_player_infos(inviter_ids, {
        playerid_to_info = true,
        scene = player_scene.OFFICIAL_SCENE.CHAT
      }, function(succ, ...)
        if succ then
          local players = (...)
          for _, item in pairs(ret.be_invited_history) do
            local user_id = item.inviter.user_id
            if players[user_id] then
              item.inviter = players[user_id]
              item.inviter.user_id = user_id
            end
          end
          cb(true, ret.be_invited_history)
        else
          cb(false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
        end
      end)
    else
      cb(true, ret.be_invited_history)
    end
  end)
end

function M.set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info, cb)
  server.set_voice_channel_status(group_id, status, mute_local_value, voice_user_id, channel_info, function(ret)
    if M.check_ret_fail(cb, ret, "set_voice_channel_status") then
      return
    end
    if cb then
      cb(true)
    end
  end)
end

function M.set_voice_channel_mode(group_id, mode, cb)
  server.set_voice_channel_mode(group_id, mode, function(ret)
    if M.check_ret_fail(cb, ret, "set_voice_channel_mode") then
      return
    end
    if cb then
      cb(true)
    end
  end)
end

function M.manage_voice_channel_status(group_id, operations, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "manage_voice_channel_status", chat_log.LOG_LEVEL.LOW, group_id, operations, cb)
  server.manage_voice_channel_status(group_id, operations, function(ret)
    if M.check_ret_fail(function(...)
      if cb then
        cb(...)
      end
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "manage_voice_channel_status", chat_log.LOG_LEVEL.LOW, {}, cb, ...)
    end, ret, "manage_voice_channel_status") then
      return
    end
    local succ = true
    if cb then
      cb(succ)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "manage_voice_channel_status", chat_log.LOG_LEVEL.LOW, {}, cb, succ)
  end)
end

function M.get_player_infos(player_ids, cb)
  assert(player_ids and type(player_ids) == "table", "player_id is wrong!")
  ejoysdk_player_info.get_player_infos(player_ids, cb)
end

function M.get_player_info(player_id, cb)
  assert(player_id and "" ~= player_id, "player_id is empty!")
  ejoysdk_player_info.get_player_info(player_id, cb)
end

function M.get_player_infos_default_scene(player_ids, cb)
  assert(player_ids and type(player_ids) == "table", "player_id is wrong!")
  ejoysdk_player_info.get_player_infos_default_scene(player_ids, {}, cb)
end

function M.get_player_info_default_scene(player_id, cb)
  assert(player_id and "" ~= player_id, "player_id is empty!")
  ejoysdk_player_info.get_player_info_default_scene(player_id, {}, cb)
end

function M.get_player_infos_chat_scene(player_ids, cb)
  assert(player_ids and type(player_ids) == "table", "player_id is wrong!")
  ejoysdk_player_info.get_player_infos_chat_scene(player_ids, {}, cb)
end

function M.get_player_info_chat_scene(player_id, cb)
  assert(player_id and "" ~= player_id, "player_id is empty!")
  ejoysdk_player_info.get_player_info_chat_scene(player_id, {}, cb)
end

function M.get_player_infos_bbs_scene(player_ids, cb)
  assert(player_ids and type(player_ids) == "table", "player_id is wrong!")
  ejoysdk_player_info.get_player_infos_bbs_scene(player_ids, {}, cb)
end

function M.get_player_info_bbs_scene(player_id, cb)
  assert(player_id and "" ~= player_id, "player_id is empty!")
  ejoysdk_player_info.get_player_info_bbs_scene(player_id, {}, cb)
end

function M.get_player_infos_friend_scene(player_ids, cb)
  assert(player_ids and type(player_ids) == "table", "player_id is wrong!")
  ejoysdk_player_info.get_player_infos_friend_scene(player_ids, {}, cb)
end

function M.get_player_info_friend_scene(player_id, cb)
  assert(player_id and "" ~= player_id, "player_id is empty!")
  ejoysdk_player_info.get_player_info_friend_scene(player_id, {}, cb)
end

function M.ignore(ignore_data, cb)
  assert(ignore_data, "ignore_data is nil!")
  server.ignore(ignore_data, function(ret)
    if M.check_ret_fail(cb, ret, "ignore") then
      return
    end
    cache.set_ignore_data(ret.ignore_data)
    cb(true, cache.get_ignore_data())
  end)
end

function M.ignore_session(session_id, cb)
  assert(session_id, "session_id is nil!")
  local type = type(session_id)
  local ignore_data = {}
  if "string" == type then
    ignore_data.sessions = {}
    table.insert(ignore_data.sessions, session_id)
  elseif "table" == type then
    ignore_data.sessions = session_id
  end
  M.ignore(ignore_data, cb)
end

function M.ignore_group_types(group_type, cb)
  assert(group_type, "group_type is nil!")
  local type = type(group_type)
  local ignore_data = {}
  if "string" == type then
    ignore_data.group_types = {}
    table.insert(ignore_data.group_types, group_type)
  elseif "table" == type then
    ignore_data.group_types = group_type
  end
  M.ignore(ignore_data, cb)
end

function M.unignore(unignore_data, cb)
  assert(unignore_data, "unignore_data is nil!")
  server.unignore(unignore_data, function(ret)
    if M.check_ret_fail(cb, ret, "unignore") then
      return
    end
    cache.set_ignore_data(ret.ignore_data)
    cb(true, cache.get_ignore_data())
  end)
end

function M.unignore_session(session_id, cb)
  assert(session_id, "session_id is nil!")
  local type = type(session_id)
  local unignore_data = {}
  if "string" == type then
    unignore_data.sessions = {}
    table.insert(unignore_data.sessions, session_id)
  elseif "table" == type then
    unignore_data.sessions = session_id
  end
  M.unignore(unignore_data, cb)
end

function M.unignore_group_types(group_type, cb)
  assert(group_type, "group_type is nil!")
  local type = type(group_type)
  local unignore_data = {}
  if "string" == type then
    unignore_data.group_types = {}
    table.insert(unignore_data.group_types, group_type)
  elseif "table" == type then
    unignore_data.group_types = group_type
  end
  M.unignore(unignore_data, cb)
end

function M.report_msg(report_type_id, report_desc, session_id, msg_id, cb)
  assert(report_type_id, "report_type_id is nil!")
  assert(report_desc, "report_desc is nil!")
  assert(session_id, "session_id is nil!")
  assert(msg_id, "msg_id is nil!")
  server.report_msg(report_type_id, report_desc, session_id, msg_id, function(ret)
    if M.check_ret_fail(cb, ret, "report_msg") then
      return
    end
    cb(true, ret)
  end)
end

function M.get_ignore_data()
  do return end
  return cache.get_ignore_data, nil
end

function M.is_ignore_session(session_id)
  do return cache.is_ignore_session end
  return cache.is_ignore_session, session_id
end

function M.recall_msg(destination, params, cb)
  server.recall_msg(destination, params, function(ret)
    if M.check_ret_fail(cb, ret, "recall_msg") then
      return
    end
    cb(true, ret)
  end)
end

function M.batch_send(destination, sessions, content, cb)
  server.batch_send(destination, sessions, content, function(ret)
    if M.check_ret_fail(cb, ret, "batch_send") then
      return
    end
    cb(true, ret)
  end)
end

local search_ids = {}
local global_search_cb

function M.set_global_search_cb(cb)
  global_search_cb = cb
end

function M.global_player_search(search_data, opt, cb)
  local player_info = require("ejoysdk_lua.player.player_info")
  player_info.global_player_search(search_data, opt, function(succ, ...)
    if succ then
      local search_id, region_count = ...
      search_ids[search_id] = {region_count = region_count, unreach_count = region_count}
      util.safe_call_cb(cb, true, search_id, region_count)
    else
      local code, msg = ...
      util.safe_call_cb(cb, false, code, msg)
    end
  end)
end

function M.player_search(search_data, opt, cb)
  local player_info = require("ejoysdk_lua.player.player_info")
  player_info.player_search(search_data, opt, cb)
end

function M.get_friend_with_latest_session_v2(destination, rtype, ext, cb)
  local friend = require("ejoysdk_lua.friend.ejoysdk_friend")
  friend.get_friend_id_list_v2(rtype, ext, function(succ, ...)
    if succ then
      local player_ids = (...)
      friend.get_friend_info_list_v2(player_ids, function(_succ, ...)
        local players = (...)
        local id_to_players = {}
        for _, player in pairs(players) do
          player.latest_session = {unread = 0, ts = 0}
          id_to_players[player.player_id] = player
        end
        if _succ then
          M.get_latest_session(destination, function(__succ, ...)
            if __succ then
              local latest_sessions = (...)
              for _, latest_session in pairs(latest_sessions) do
                local session_info = latest_session.session_info
                local session_id = session_info.id
                local unread = session_info.unread
                local last_msgs = latest_session.last_msgs or {}
                local last_msg = last_msgs[1] or {}
                local ts = last_msg.ts or os.time()
                local session_type = M.get_session_type(session_id)
                if session_type.type == M.TYPE_PERSONAL then
                  local from_player_id = session_type.from
                  if id_to_players[from_player_id] then
                    id_to_players[from_player_id].latest_session = latest_session
                    id_to_players[from_player_id].latest_session.unread = unread
                    id_to_players[from_player_id].latest_session.ts = ts
                  end
                end
              end
              cb(true, id_to_players)
            else
              cb(false, ...)
            end
          end)
        else
          cb(false, ...)
        end
      end)
    else
      cb(false, ...)
    end
  end)
end

function M.get_friend_with_latest_session(cb, destination)
  M.get_friend_with_latest_session_v2(destination, nil, nil, cb)
end

function M.get_agora_channel_token(group_id, version, cb)
  server.get_agora_channel_token(group_id, version, function(ret)
    local is_fail = M.check_ret_fail(function(...)
      if cb then
        cb(...)
      end
      chat_log.call_api_async_callback(chat_log_util.header(), TAG, "get_agora_channel_token", chat_log.LOG_LEVEL.HIGH, {}, cb, ...)
    end, ret, "get_agora_channel_token")
    if is_fail then
      return
    end
    cb(true, ret)
  end)
end

function M.callback_global(handler_name, ...)
  CALLBACK.global_callback(handler_name, ...)
end

function M.callback_destination(destination, handler_name, ...)
  CALLBACK.callback(destination, handler_name, ...)
end

function M.callback_channel(destination, channel, handler_name, ...)
  local ch_handler_name = CALLBACK.get_channel_handler_name(channel, handler_name)
  if ch_handler_name then
    M.callback_destination(destination, ch_handler_name, ...)
  end
end

local function check_voice_group_join(destination, group)
  if group.attr and group.attr.enable_voice then
    local group_id = group.group_id
    voice.add_channel_param(group_id, {
      token = group.personal_info.agora_channel_token
    })
    if voice.auto_join_channel then
      voice.join_channel(group_id)
    end
    M.callback_destination(destination, CALLBACK.HANDLER_NAME.INFO_CREATE_VOICE_GROUP, group)
  end
end

local function check_voice_group_leave(destination, msg)
  if voice and voice.is_voice_channel(msg.group_id) then
    voice.remove_channel_param(msg.group_id)
    if voice.auto_leave_channel then
      voice.leave_channel(msg.group_id)
    end
    M.callback_destination(destination, CALLBACK.HANDLER_NAME.INFO_DELETE_VOICE_GROUP, msg.group_id, {
      reason = msg.reason,
      message = msg.message or ""
    })
  end
end

function M.check_groups_with_login_result(destination, ret, cb)
  chat_log.call_api(chat_log_util.header(), TAG, "check_groups_with_login_result", chat_log.LOG_LEVEL.HIGH, {}, destination, ret, cb)
  local groups = ret.groups
  M.replace_groups_player_info(groups, function(replace_groups)
    cache.login_group(replace_groups)
    cache.set_ignore_data(ret.ignore_data)
    voice.init()
    for _, group in pairs(replace_groups) do
      check_voice_group_join(destination, group)
    end
    if cb then
      cb(true)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "check_groups_with_login_result", chat_log.LOG_LEVEL.HIGH, {}, cb, true)
  end, function()
    if cb then
      cb(false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
    end
    chat_log.call_api_async_callback(chat_log_util.header(), TAG, "check_groups_with_login_result", chat_log.LOG_LEVEL.HIGH, {}, cb, false, GET_PLAYER_INFO_FAIL_CODE, GET_PLAYER_INFO_FAIL_MESSAGE)
  end)
end

function M.get_user_face(destination, params, cb)
  server.get_user_face(destination, params, function(ret)
    if M.check_ret_fail(cb, ret, "get_user_face") then
      return
    end
    cb(true, ret.data)
  end)
end

local get_common_scene_state = 0

function M.get_common_scene()
  if 2 ~= get_common_scene_state then
    if 1 == get_common_scene_state then
      return
    end
    get_common_scene_state = 1
    E.Timer.once(10, function()
      if 1 == get_common_scene_state then
        get_common_scene_state = -1
      end
    end)
    local scene_ids = {
      player_scene.OFFICIAL_SCENE.CHAT,
      player_scene.OFFICIAL_SCENE.FRIEND,
      player_scene.OFFICIAL_SCENE.DEFAULT,
      player_scene.OFFICIAL_SCENE.BBS,
      player_scene.OFFICIAL_SCENE.LIVE
    }
    player_scene.get_scene_infos(scene_ids, function(succ, ...)
      if succ then
        get_common_scene_state = 2
      else
        get_common_scene_state = -1
      end
    end)
  end
end

function M.fill_chat_group_invite_msgs(msgs, cb)
  local inviter_ids = {}
  for _, msg in pairs(msgs) do
    if msg.content.type == "chat_group_invite" then
      local invite_msg = msg.content.data
      local user_id = invite_msg.inviter.user_id
      table.insert(inviter_ids, user_id)
    end
  end
  if #inviter_ids > 0 then
    ejoysdk_player_info.get_player_infos(inviter_ids, {
      playerid_to_info = true,
      scene = player_scene.OFFICIAL_SCENE.CHAT
    }, function(succ, ...)
      if succ then
        local players = (...)
        local invite_msgs = {}
        for _, msg in pairs(msgs) do
          if msg.content.type == "chat_group_invite" then
            local invite_msg = msg.content.data
            local user_id = invite_msg.inviter.user_id
            if players[user_id] then
              invite_msg.inviter = players[user_id]
              invite_msg.inviter.user_id = user_id
              table.insert(invite_msgs, invite_msg)
            end
          end
        end
        if #invite_msgs > 0 then
          cb(true, invite_msgs)
        end
      end
    end)
  end
end

function M.process_friend_msgs(msgs)
  local friend_del_msgs = {}
  local friend_add_msgs = {}
  local friend_apply_msgs = {}
  local friend_info_change_msgs = {}
  for _, msg in pairs(msgs) do
    local cmd = msg.content.data.cmd
    if "friend_del" == cmd then
      local friend_del_msg = {}
      friend_del_msg.player = msg.content.data.data.player
      friend_del_msg.ts = msg.ts
      table.insert(friend_del_msgs, friend_del_msg)
    elseif "friend_add" == cmd then
      local friend_add_msg = {}
      friend_add_msg.create_time = msg.content.data.data.friend.create_time
      friend_add_msg.player = msg.content.data.data.friend.player
      friend_add_msg.ts = msg.ts
      table.insert(friend_add_msgs, friend_add_msg)
    elseif "friend_apply" == cmd then
      local friend_apply_msg = {}
      friend_apply_msg.state = msg.content.data.data.friend_apply.state
      friend_apply_msg.create_time = msg.content.data.data.friend_apply.create_time
      friend_apply_msg.player = msg.content.data.data.friend_apply.player
      friend_apply_msg.content = msg.content.data.data.friend_apply.content
      friend_apply_msg.apply_id = msg.content.data.data.friend_apply.apply_id
      friend_apply_msg.ts = msg.ts
      table.insert(friend_apply_msgs, friend_apply_msg)
    elseif "friend_info_change" == cmd then
      local friend_info_change_msg = {}
      local new_api = false
      local player_list = msg.content.data.data.player_info_list
      if #player_list > 0 and player_list[1].player_info then
        new_api = true
      end
      local changed_players = {}
      if new_api then
        for _, info in pairs(player_list) do
          local player = ejoysdk_player_cache.update_player_info(info.player_id, info.player_info)
          if player then
            player.player_info.player_id = info.player_id
            table.insert(changed_players, player)
          end
        end
      else
        changed_players = player_list
      end
      friend_info_change_msg.player_info_list = changed_players
      table.insert(friend_info_change_msgs, friend_info_change_msg)
    end
  end
  local result = {}
  result.friend_del_msgs = friend_del_msgs
  result.friend_add_msgs = friend_add_msgs
  result.friend_apply_msgs = friend_apply_msgs
  result.friend_info_change_msgs = friend_info_change_msgs
  return result
end

function M.process_info_msg(msgs, cb)
  local chat_msg = {}
  local personal_msg = {}
  local group_msg = {}
  local chat_group = {}
  local friend = {}
  local system = {}
  local system_chat = {}
  local gangplank = {}
  local group = {}
  for _, msg in pairs(msgs) do
    local session_id = msg.session_id
    local session_type = M.get_session_type(session_id)
    if session_type.type == M.TYPE_PERSONAL then
      msg.is_ignore = cache.is_ignore_session(session_id)
      table.insert(chat_msg, msg)
      table.insert(personal_msg, msg)
    elseif session_type.type == M.TYPE_GROUP then
      msg.is_ignore = cache.is_ignore_session(session_id)
      table.insert(chat_msg, msg)
      table.insert(group_msg, msg)
      if msg.sticky_data then
        local sticky_data_copy = util.deepcopy(msg.sticky_data)
        sticky_data_copy.msg_id = msg.msg_id
        local group_id = session_type.from
        local cache_group = cache.get_group(group_id)
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
          cache.update_group(cache_group)
          table.insert(group, cache_group)
        end
      end
    elseif session_type.type == M.TYPE_SYSTEM then
      if session_type.from == M.SYSTEM_CHAT_GROUP then
        table.insert(chat_group, msg)
      elseif session_type.from == M.SYSTEM_FRIEND then
        table.insert(friend, msg)
      elseif session_type.from == SYSTEM_GANGPLANK then
        table.insert(gangplank, msg)
      elseif session_type.from == SYSTEM_CHAT then
        table.insert(system_chat, msg)
      else
        table.insert(system, msg)
      end
    end
  end
  M._msgs_player_to_cache(chat_msg)
  local result = {}
  result.chat_group = chat_group
  result.friend = friend
  result.system = system
  result.gangplank = gangplank
  result.group = group
  if #system_chat > 0 and #chat_msg > 0 then
    M.replace_msgs_user_info_before_cb(system_chat, function(system_chat_replace_msg)
      result.system_chat = system_chat_replace_msg
      result.personal_msg = personal_msg
      result.group_msg = group_msg
      M.replace_msgs_user_info_before_cb(chat_msg, function(chat_msg_replace_msg)
        result.chat_msg = chat_msg_replace_msg
        cb(result)
      end, function()
        cb(result)
      end)
    end, function()
      M.replace_msgs_user_info_before_cb(chat_msg, function(replace_msg)
        result.chat_msg = replace_msg
        result.personal_msg = personal_msg
        result.group_msg = group_msg
        cb(result)
      end, function()
        cb(result)
      end)
    end)
  elseif #system_chat > 0 then
    M.replace_msgs_user_info_before_cb(system_chat, function(replace_msg)
      result.system_chat = replace_msg
      result.personal_msg = personal_msg
      result.group_msg = group_msg
      cb(result)
    end, function()
      cb(result)
    end)
  elseif #chat_msg > 0 then
    M.replace_msgs_user_info_before_cb(chat_msg, function(replace_msg)
      result.chat_msg = replace_msg
      result.personal_msg = personal_msg
      result.group_msg = group_msg
      cb(result)
    end, function()
      cb(result)
    end)
  else
    cb(result)
  end
end

function M.process_create_group_msg(destination, msg, cb)
  local group = msg.group
  M.replace_groups_player_info({group}, function(replace_groups)
    local replace_group = replace_groups[1]
    cache.create_group(replace_group)
    check_voice_group_join(destination, replace_group)
    voice.update_voice_mute(curr_voice_channel)
    cb(replace_group)
  end)
end

function M.process_delete_group(destination, msg)
  cache.delete_group(msg.group_id)
  check_voice_group_leave(destination, msg)
end

function M.process_update_group(msg, cb)
  local group = msg.group
  if msg.group == nil then
    local group_id = msg.group_id
    local cache_group = cache.get_group(group_id) or {}
    if msg.put then
      for _, entry in pairs(msg.put) do
        cache_group[entry.k] = entry.v
      end
    end
    if msg.delete then
      for _, entry in pairs(msg.delete) do
        cache_group[entry.k] = nil
      end
    end
    group = cache_group
  end
  M.replace_groups_player_info({group}, function(replace_groups)
    local replace_group = replace_groups[1]
    cache.update_group(replace_group)
    voice.update_voice_mute(curr_voice_channel)
    cb(replace_group)
  end)
  if msg.group and msg.group.personal_info and msg.group_id then
    local personal_info = msg.group.personal_info
    if personal_info.agora_channel_token then
      voice.add_channel_param(msg.group_id, {
        token = personal_info.agora_channel_token
      })
    end
  end
end

function M.process_remove_group_member(msg, cb)
  local need_remove_map = {}
  for _, need_remove_user_id in pairs(msg.removes) do
    if #need_remove_user_id > 0 then
      need_remove_map[need_remove_user_id] = true
    end
  end
  if curr_voice_channel then
    cache.voice_channel_user_change_update_group(curr_voice_channel, need_remove_map, nil)
    voice.voice_channel_user_change(curr_voice_channel, need_remove_map, nil)
  end
  if cb then
    cb(msg)
  end
end

function M.process_voice_channel_user_change(msg, cb)
  local updates_map = {}
  if msg.updates then
    for _, new_user in pairs(msg.updates) do
      if new_user.user_id then
        updates_map[new_user.user_id] = new_user
      end
    end
  end
  local need_remove_map = {}
  if msg.removes then
    for _, need_remove_user_id in pairs(msg.removes) do
      if type(need_remove_user_id) == "string" and #need_remove_user_id > 0 then
        need_remove_map[need_remove_user_id] = true
      end
    end
  end
  if msg.group_id then
    if msg.voice_channel then
      voice.voice_channel_info_update(msg.group_id, msg.voice_channel)
    end
    cache.voice_channel_user_change_update_group(msg.group_id, need_remove_map, updates_map, {
      voice_channel = msg.voice_channel
    })
    voice.voice_channel_user_change(msg.group_id, need_remove_map, updates_map)
  end
  if cb then
    cb(msg)
  end
end

function M.process_channel_friend_add(channel, data, cb)
  for _, channel_friend in ipairs(data.user_list) do
    friend_cache.add_channel_friend(channel, channel_friend)
  end
  ejoysdk_player_info.get_user_list_account_info(data.user_list, {
    scene = player_scene.OFFICIAL_SCENE.CHAT
  }, function(succ, ...)
    if succ then
      local mix_user_list = (...)
      cb(true, mix_user_list)
    else
      local err_msg = "friend add, get account infos fail"
      E.LOG.warn(TAG, err_msg)
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_INFO_GET_FAILED, err_msg)
    end
  end)
end

function M.process_player_friend_add(data, cb)
  local player_ids = {}
  local player_maps = {}
  local rtype_player_ids = {}
  for _, player in ipairs(data.user_list) do
    local player_id = player.user_id
    player.player_id = player_id
    table.insert(player_ids, player_id)
    player_maps[player_id] = player
    ejoysdk_player_cache.remove_player_info(player_id)
    local rtype = "friend"
    if player.rtype and #player.rtype > 0 then
      rtype = player.rtype
    end
    local curr_player_ids = rtype_player_ids[rtype] or {}
    table.insert(curr_player_ids, player_id)
    rtype_player_ids[rtype] = curr_player_ids
  end
  local friend = require("ejoysdk_lua.friend.ejoysdk_friend")
  for rtype_key, player_ids_value in pairs(rtype_player_ids) do
    if friend.is_process_get_friend_id_list(rtype_key) then
      friend_cache.add_wait_operation("add", player_ids_value, rtype_key)
    else
      friend_cache.add_friend_ids(player_ids_value, rtype_key)
    end
  end
  ejoysdk_player_info.get_player_infos_chat_scene(player_ids, {}, function(succ, ...)
    if succ then
      local player_infos = (...)
      for _, player_info in ipairs(player_infos) do
        player_maps[player_info.player_id].player = player_info
      end
      local add_msgs = {}
      for _, player in pairs(player_maps) do
        table.insert(add_msgs, player)
      end
      cb(true, add_msgs)
    else
      local err_msg = "friend add, get player infos fail"
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_INFO_GET_FAILED, err_msg)
    end
  end)
end

function M.process_channel_friend_del(channel, data, cb)
  for _, channel_friend in ipairs(data.user_list) do
    friend_cache.remove_channel_friend(channel, channel_friend)
  end
  ejoysdk_player_info.get_user_list_account_info(data.user_list, {
    scene = player_scene.OFFICIAL_SCENE.CHAT
  }, function(succ, ...)
    if succ then
      local mix_user_list = (...)
      cb(true, mix_user_list)
    else
      local err_msg = "friend delete, get account info fail"
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_INFO_GET_FAILED, err_msg)
    end
  end)
end

function M.process_player_friend_del(data, cb)
  local delete_msgs = {}
  local player_ids = data.user_list
  local rtype = data.rtype or "friend"
  local friend = require("ejoysdk_lua.friend.ejoysdk_friend")
  if friend.is_process_get_friend_id_list(rtype) then
    friend_cache.add_wait_operation("del", player_ids, rtype)
  else
    friend_cache.remove_friend_ids(player_ids, rtype)
  end
  ejoysdk_player_info.get_player_infos_chat_scene(player_ids, {}, function(succ, ...)
    if succ then
      local player_infos = (...)
      for _, player_info in ipairs(player_infos) do
        local delete_msg = {}
        delete_msg.player = player_info
        delete_msg.rtype = data.rtype
        table.insert(delete_msgs, delete_msg)
      end
      cb(true, delete_msgs)
    else
      local err_msg = "friend delete, get player info fail"
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_INFO_GET_FAILED, err_msg)
    end
  end)
end

function M.process_friend_channel_info_change(channel, data, cb)
  for _, channel_friend in ipairs(data.user_list) do
    friend_cache.update_channel_friend(channel, channel_friend)
  end
  ejoysdk_player_info.get_user_list_account_info(data.user_list, {
    scene = player_scene.OFFICIAL_SCENE.CHAT
  }, function(succ, ...)
    if succ then
      local mix_user_list = (...)
      cb(true, mix_user_list)
    else
      local err_msg = "channel friend info change, get account info fail"
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_INFO_GET_FAILED, err_msg)
    end
  end)
end

function M.process_friend_player_info_change(data, cb)
  local info_change_msgs = {}
  local player_info_list = {}
  for _, item in ipairs(data.user_list) do
    local player_info = item
    local update_player_info = ejoysdk_player_cache.update_player_info(player_info.player_id, player_info)
    if nil ~= update_player_info then
      table.insert(player_info_list, update_player_info)
    end
  end
  if #player_info_list > 0 then
    local info_change_msg = {}
    info_change_msg.player_info_list = player_info_list
    table.insert(info_change_msgs, info_change_msg)
  end
  cb(true, info_change_msgs)
end

function M.process_friend_player_apply(data, cb)
  local player_ids = {}
  local apply_maps = {}
  for _, apply_msg in ipairs(data.friend_apply_list) do
    local player_id = apply_msg.user_id
    apply_msg.player_id = apply_msg.user_id
    table.insert(player_ids, player_id)
    apply_maps[player_id] = apply_msg
  end
  ejoysdk_player_info.get_player_infos_chat_scene(player_ids, {}, function(succ, ...)
    if succ then
      local player_infos = (...)
      for _, player_info in ipairs(player_infos) do
        apply_maps[player_info.player_id].player = player_info
        if not apply_maps[player_info.player_id].player_info then
          apply_maps[player_info.player_id].player_info = player_info and player_info.player_info
        end
      end
      local apply_msgs = {}
      for _, mix_apply_msg in pairs(apply_maps) do
        table.insert(apply_msgs, mix_apply_msg)
      end
      cb(true, apply_msgs)
    else
      local err_msg = "friend apply get player info fail!"
      cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_INFO_GET_FAILED, err_msg)
    end
  end)
end

function M.process_player_follow_add(data, cb)
  cb(true, data)
end

function M.process_player_follow_be_add(data, cb)
  cb(true, data)
end

function M.process_player_follow_del(data, cb)
  cb(true, data)
end

function M.process_player_follow_be_del(data, cb)
  cb(true, data)
end

function M.process_player_follow_info_change(data, cb)
  local info_change_msgs = {}
  local player_info_list = {}
  for _, item in ipairs(data.user_list) do
    local player_info = item
    local update_player_info = ejoysdk_player_cache.update_player_info(player_info.player_id, player_info)
    if nil ~= update_player_info then
      table.insert(player_info_list, update_player_info)
    end
  end
  if #player_info_list > 0 then
    local info_change_msg = {}
    info_change_msg.player_info_list = player_info_list
    table.insert(info_change_msgs, info_change_msg)
  end
  cb(true, info_change_msgs)
end

function M.process_favor_change(data, cb)
  cb(true, data)
end

function M.handle_global_search_resp(data)
  local search_id = data.search_id
  local player_info_list = data.player_info_list
  local region = data.region
  local search_id_value = search_ids[search_id]
  if not search_id_value then
    return
  end
  local unreach_count = search_id_value.unreach_count - 1
  if 0 == unreach_count then
    search_ids[search_id] = 0
  else
    search_id_value.unreach_count = unreach_count
  end
  if global_search_cb then
    global_search_cb(region, player_info_list, unreach_count)
  end
end

function M.login(destination, on_login_cb)
  E.LOG.debug(TAG, "chat_connect: chat_base login start")
  server.login(destination, function(ret)
    if 0 == ret.code then
      retry_connect_times = 0
    end
    if on_login_cb then
      on_login_cb(ret)
    end
  end)
end

function M.logout()
  server.close(CONSTANTS.CHAT_ERROR_CODES.CODE_CHAT_LOGOUT)
end

local SERVER_HANDLERS = {}
M.SERVER_HANDLERS = SERVER_HANDLERS

function M.common_params_for_connect()
  local playerInfo = EG.player_info()
  local roleId = ""
  if playerInfo then
    roleId = playerInfo.player_id
  end
  local params = {role_id = roleId}
  params.server_port = server.get_server_port()
  params.login_session_id = GDP.SESSION_INFO.get("player")
  return params
end

function SERVER_HANDLERS.on_connect_start()
  local param = M.common_params_for_connect()
  quality.socket_connect_statistics(STATES.CONNECT_START, param)
end

local function remove_item_action(del_target)
  if not del_target then
    return
  end
  local found_index = 0
  for index, item_in_array in pairs(delay_time_action_obj_array) do
    if item_in_array == del_target then
      found_index = index
    end
  end
  if 0 ~= found_index then
    table.remove(delay_time_action_obj_array, found_index)
  end
end

function M.retry_connect_delay_time(retry_connect_index_param)
  local random = 0
  if retry_connect_index_param > 1 then
    random = 2 * math.random()
  end
  local temp = 2 * (retry_connect_index_param - 1) + random
  temp = temp - temp % 0.01
  local delay_time = math.min(temp, retry_connect_max_time_gap)
  delay_time = math.max(delay_time, 1)
  return delay_time
end

local function retry_connect(_code)
  if not STATES.can_retry_connect() then
    E.LOG.d(TAG, "chat_connect: not allow retry connect, because current_state=" .. tostring(STATES.get_current_state()))
    return
  end
  if E.time() - last_time_for_first_retry_connect >= 1800 then
    retry_connect_index = 0
    last_time_for_first_retry_connect = E.time()
  end
  retry_connect_index = math.min(retry_connect_index + 1, 1000000)
  local delay_time = M.retry_connect_delay_time(retry_connect_index)
  ET.publish(ET.chat.UPDATE_STATE, STATES.RETRY_CONNECT, {
    retry_connect_index = retry_connect_index,
    delay_time = delay_time,
    code = _code or 0
  })
  E.LOG.d(TAG, "chat_connect: start retry connect, delay_time=" .. tostring(delay_time) .. ", retry_connect_index=" .. tostring(retry_connect_index))
  if retry_connect_times >= max_retry_times then
    retry_connect_times = 0
    local connect_lost_code = 0
    if no_limit_retry_connect then
      local holo = require("ejoysdk_lua.ejoysdk_holo")
      local token = holo.get_player_token()
      local expire_time = (holo.get_player_token_body() or {}).expire_time or 0
      if not token or 0 == #token or expire_time < E.time() then
        if not token or 0 == #token then
          connect_lost_code = CONSTANTS.CHAT_ERROR_CODES.CODE_CONNECT_LOST_FROM_TOKEN_MISS
        else
          connect_lost_code = CONSTANTS.CHAT_ERROR_CODES.CODE_CONNECT_LOST_FROM_TOKEN_EXPIRE
          local stat_key = "ejoy_chat_retry_connect" .. "_" .. "token_is_expired"
          ESTAT.stat_error_with_limit("ejoysdk_chat_base", stat_key, "ejoy_chat_retry_connect", "chat_err_token_is_expired", nil)
        end
        E.LOG.d(TAG, "chat_connect: retry connect fail, token expire")
        PLAYER_INFO = nil
        ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
      else
        retry_connect_times = retry_connect_times + 1
        if PLAYER_INFO then
          local param = M.common_params_for_connect()
          quality.socket_connect_statistics(STATES.NO_LIMIT_RECONNECT_AT_NEXT_LOOP, param)
          local delay_time_action_obj
          
          local function delay_time_action()
            if not delay_time_action_obj.enable then
              remove_item_action(delay_time_action_obj)
              return
            end
            if PLAYER_INFO then
              init_server_v2()
            else
              E.LOG.d(TAG, "chat_connect: retry connect fail, PLAYER_INFO miss, delay_time=" .. tostring(delay_time))
              ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
            end
            remove_item_action(delay_time_action_obj)
          end
          
          delay_time_action_obj = {enable = true, action = delay_time_action}
          table.insert(delay_time_action_obj_array, delay_time_action_obj)
          E.Timer.once(delay_time, delay_time_action_obj.action)
        else
          E.LOG.d(TAG, "chat_connect: retry connect fail, PLAYER_INFO miss")
          ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
        end
      end
    end
    M.callback_global(CALLBACK.HANDLER_NAME.ON_CONNECT_LOST, connect_lost_code)
    local param = M.common_params_for_connect()
    param.last_error_msg = M.get_last_error_msg()
    quality.socket_connect_statistics(STATES.CONNECT_LOST, param)
  else
    retry_connect_times = retry_connect_times + 1
    local delay_time_action_obj
    
    local function delay_time_action()
      if not delay_time_action_obj.enable then
        remove_item_action(delay_time_action_obj)
        return
      end
      if PLAYER_INFO then
        for _, item in pairs(delay_time_action_obj_array) do
          item.enable = false
        end
        E.LOG.d(TAG, "will connect, reconnect_id:" .. tostring(delay_time_action_obj.reconnect_id))
        init_server_v2()
      else
        E.LOG.d(TAG, "chat_connect: retry connect fail, PLAYER_INFO miss, retry_connect_times=" .. tostring(retry_connect_times))
        ET.publish(ET.chat.UPDATE_STATE, STATES.NO_PLAYER_TOKEN)
      end
      remove_item_action(delay_time_action_obj)
    end
    
    delay_time_action_obj = {
      enable = true,
      action = delay_time_action,
      reconnect_id = E.time_ms()
    }
    table.insert(delay_time_action_obj_array, delay_time_action_obj)
    E.Timer.once(delay_time, delay_time_action_obj.action)
  end
end

function SERVER_HANDLERS.on_connect_error(error_msg)
  last_error_msg = error_msg or ""
  local param = M.common_params_for_connect()
  quality.socket_connect_statistics(STATES.CONNECT_ERROR, param, error_msg)
  retry_connect(-1)
end

function SERVER_HANDLERS.on_connecting()
  M.callback_global(CALLBACK.HANDLER_NAME.ON_CONNECTING)
end

function SERVER_HANDLERS.on_connected()
  M.callback_global(CALLBACK.HANDLER_NAME.ON_CONNECTED)
  local param = M.common_params_for_connect()
  param.retry_connect_times = retry_connect_times
  quality.socket_connect_statistics(STATES.CONNECTED, param)
end

function SERVER_HANDLERS.on_disconnect()
  cache.clear()
  voice.uninit()
  M.callback_global(CALLBACK.HANDLER_NAME.ON_DISCONNECT)
  M.callback_global(CALLBACK.HANDLER_NAME.ON_LOGOUT)
end

function SERVER_HANDLERS.on_error(error_msg, err_code)
  last_error_msg = error_msg or ""
  cache.clear()
  voice.uninit()
  M.callback_global(CALLBACK.HANDLER_NAME.ON_ERROR, error_msg or "", err_code)
  local param = M.common_params_for_connect()
  quality.socket_connect_statistics(STATES.ERROR, param, error_msg)
  retry_connect(err_code)
end

M.retry_connect = retry_connect

function M.reset_retry_connect_index()
  retry_connect_index = 0
end

function M.auto_login()
  if AUTO_LOGIN then
    return true
  end
  return false
end

return M
