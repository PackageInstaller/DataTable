local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local Class = require("ejoysdk_lua.ejoysdk_class")
local player_cache = require("ejoysdk_lua.player.player_info_cache")
local player_info = require("ejoysdk_lua.player.player_info")
local friend_cache = require("ejoysdk_lua.friend.ejoysdk_friend_cache")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local util = require("ejoysdk_lua.ejoysdk_utils")
local player_scene = require("ejoysdk_lua.player.player_info_scene")
local friend_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local friend_jf = require("ejoysdk_lua.friend.ejoysdk_friend_jf")
local friend_log_util = require("ejoysdk_lua.friend.ejoysdk_friend_log_util")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local chat_base = require("ejoysdk_lua.chat.ejoysdk_chat_base")
local CALLBACK_MGR = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local CHAT_SERVER = require("ejoysdk_lua.chat.ejoysdk_chat_server")
local chat_friend = require("ejoysdk_lua.chat.ejoysdk_chat_friend")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local url_items = {
  accept_friend_apply = "/friend/accept_friend_apply",
  accept_friend_apply_batch = "/friend/accept_friend_apply_batch",
  del_friend = "/friend/del_friend",
  get_friend_id_list = "/friend/get_friend_id_list",
  refuse_friend_apply = "/friend/refuse_friend_apply",
  refuse_friend_apply_batch = "/friend/refuse_friend_apply_batch",
  del_friend_apply = "/friend/del_friend_apply",
  add_friend_black = "/friend/add_friend_black",
  del_friend_black = "/friend/del_friend_black",
  get_channel_friend_list = "/friend/channel/v1.0/get_friend_list",
  refresh_channel_friend_list = "/friend/channel/v1.0/refresh_friend_list",
  add_follow = "/follow/add_follow",
  del_follow = "/follow/del_follow",
  get_follow_ext = "/follow/get_follow_ext",
  get_follow_id_list = "/follow/get_follow_id_list",
  get_follow_list = "/follow/get_follow_list",
  get_followed_list = "/follow/get_followed_list",
  get_new_followed_list = "/follow/get_new_followed_list",
  add_friend_group = "/friend/add_friend_group",
  del_friend_group = "/friend/del_friend_group",
  get_friend_group = "/friend/get_friend_group",
  add_friend_group_member = "/friend/add_friend_group_member",
  del_friend_group_member = "/friend/del_friend_group_member",
  update_friend_group_info = "/friend/update_friend_group_info"
}
local url_items_v2 = {
  add_friend_apply = "/friend/v2.0/add_friend_apply",
  get_friend_apply_list = "/friend/v2.0/get_friend_apply_list",
  get_friend_black_list = "/friend/v2.0/get_friend_black_list",
  get_friend_group_member = "/friend/v2.0/get_friend_group_member",
  get_friend_list = "/friend/v2.0/get_friend_list",
  get_friend_to_apply_list = "/friend/v2.0/get_friend_to_apply_list",
  get_new_friend_apply_list = "/friend/v2.0/get_new_friend_apply_list",
  get_new_friend_list = "/friend/v2.0/get_new_friend_list",
  get_friend_info_list = "/friend/v2.0/get_friend_info_list"
}
local TAG = EM.MODULE.FRIEND .. "friend"
local M = {}
local init_tick = false
local TICK_INTERVAL = 1
local module_inited = false
local player_entered = false
local player_scene_ready_flag = {
  [player_scene.OFFICIAL_SCENE.FRIEND_APPLY] = false,
  [player_scene.OFFICIAL_SCENE.BLACK_LIST] = false,
  [player_scene.OFFICIAL_SCENE.FOLLOW] = false
}
local real_get_channel_friends_on_request_map = {}
local real_get_friend_id_list_on_request_map = {}
local real_refresh_channel_friends_on_request_map = {}
local auto_refresh_time_gap = 3600
local all_friend_channels = {}
local already_get_friend_id_list_data = {}
local refresh_channel_friends_cache = {}
local http_default_timeout = 20

local function require_params()
  local player_token = EH.get_player_token()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    },
    timeout = http_default_timeout
  }
end

local func_call_cache = {}

local function post(url, params, cb)
  if not player_entered then
    local func_call = {
      url = url,
      params = params,
      cb = cb
    }
    table.insert(func_call_cache, func_call)
    return
  end
  E.HTTP.post(url, require_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(200, resp.body)
      else
        cb(resp.body.code, resp.body)
      end
    else
      cb(resp.status, resp.body or {})
    end
  end)
end

local function friend_post(type, params, cb)
  local friend_url_prefix = E.CONFIG.get_config("friend")
  local use_v1 = E.CONFIG.get_config("friend_use_v1")
  local url
  if use_v1 then
    url = friend_url_prefix .. url_items[type]
  elseif url_items_v2[type] then
    url = friend_url_prefix .. url_items_v2[type]
  else
    url = friend_url_prefix .. url_items[type]
  end
  post(url, params, cb)
end

local function invoke_cache_func()
  for _, func_call in pairs(func_call_cache) do
    post(func_call.url, func_call.params, func_call.cb)
  end
  func_call_cache = {}
end

local function clearLocalVariables(is_player_offline)
  if is_player_offline then
    real_get_channel_friends_on_request_map = {}
    real_get_friend_id_list_on_request_map = {}
    real_refresh_channel_friends_on_request_map = {}
  end
  refresh_channel_friends_cache = {}
  all_friend_channels = {}
  already_get_friend_id_list_data = {}
end

local function login_handler()
  player_entered = false
end

local function logout_handler()
  player_entered = false
  friend_cache.clear()
  clearLocalVariables(true)
end

local function player_offline_handler()
  player_entered = false
  friend_cache.clear()
  clearLocalVariables(true)
end

local last_login_acc_info

local function gangplank_acquire_handler(_user_info)
  local EG = require("ejoysdk_lua.ejoysdk_gangplank")
  local current_info = EG.user_info()
  if last_login_acc_info and last_login_acc_info.uid and current_info and current_info.uid ~= last_login_acc_info.uid then
    E.log("gangplank_acquire_handler last login acc is not logout")
    player_entered = false
    friend_cache.clear()
  end
  last_login_acc_info = current_info
end

local function player_online_handler(_player_token)
  local function get_scene_infos_after_action()
    player_entered = true
    
    friend_cache.clear()
    clearLocalVariables(false)
    ET.publish(ET.friend.INITED, true)
    invoke_cache_func()
  end
  
  local scene_ids = {
    player_scene.OFFICIAL_SCENE.DEFAULT,
    player_scene.OFFICIAL_SCENE.FRIEND,
    player_scene.OFFICIAL_SCENE.FRIEND_APPLY,
    player_scene.OFFICIAL_SCENE.BLACK_LIST,
    player_scene.OFFICIAL_SCENE.FOLLOW
  }
  local get_scene_infos_action_max_retry_count = 3
  local get_scene_infos_action_curr_retry_count = 0
  local get_scene_infos_action
  
  function get_scene_infos_action()
    get_scene_infos_action_curr_retry_count = get_scene_infos_action_curr_retry_count + 1
    player_scene.get_scene_infos(scene_ids, function(succ, ...)
      if not succ then
        local code, msg = ...
        if get_scene_infos_action_curr_retry_count > get_scene_infos_action_max_retry_count then
          ESTAT.stat_action_with_limit("friend", "get_scenes_fail_on_reach_max_retry_count", "get_scenes_fail_on_reach_max_retry_count", "friend_err", {code = code, msg = msg})
          get_scene_infos_after_action()
          return
        end
        get_scene_infos_action()
        return
      end
      local return_scene_infos = (...)
      if return_scene_infos[player_scene.OFFICIAL_SCENE.FRIEND_APPLY] then
        player_scene_ready_flag[player_scene.OFFICIAL_SCENE.FRIEND_APPLY] = true
      end
      if return_scene_infos[player_scene.OFFICIAL_SCENE.BLACK_LIST] then
        player_scene_ready_flag[player_scene.OFFICIAL_SCENE.BLACK_LIST] = true
      end
      if return_scene_infos[player_scene.OFFICIAL_SCENE.FOLLOW] then
        player_scene_ready_flag[player_scene.OFFICIAL_SCENE.FOLLOW] = true
      end
      get_scene_infos_after_action()
    end)
  end
  
  get_scene_infos_action()
  if not init_tick then
    init_tick = true
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

local function invoke_callback(handler_name, ...)
  chat_base.callback_destination(CHAT_SERVER.DESTINATION.CLIENT_FRIEND, handler_name, ...)
  chat_base.callback_destination(CHAT_SERVER.DESTINATION.CLIENT_FRIEND_CHAT, handler_name, ...)
end

local function invoke_callback_channel(channel, channel_handler_name, ...)
  chat_base.callback_channel(CHAT_SERVER.DESTINATION.CLIENT_FRIEND, channel, channel_handler_name, ...)
  chat_base.callback_channel(CHAT_SERVER.DESTINATION.CLIENT_FRIEND_CHAT_ACCOUNT, channel, channel_handler_name, ...)
end

local start_with = E.Utils.start_with
local _split_string = E.Utils.split_string
local FRIEND_HANDLERS = {}
local FAVOR_HANDLERS = {}
local FOLLOW_HANDLERS = {}

function M.HANDLERS(header, msg)
  local method = header.method
  if not method then
    return
  end
  if start_with(method, "friend") then
    DISPATCHER.dispatch_friend_msg(msg, FRIEND_HANDLERS, method)
  elseif start_with(method, "favor") then
    DISPATCHER.dispatch_favor_msg(msg, FAVOR_HANDLERS, method)
  elseif start_with(method, "follow") then
    DISPATCHER.dispatch_follow_msg(msg, FOLLOW_HANDLERS, method)
  end
end

FRIEND_HANDLERS.friend_add = {
  channel = function(data)
    local channel = data.user_list[1].channel
    chat_base.process_channel_friend_add(channel, data, function(succ, ...)
      if succ then
        local mix_user_list = (...)
        invoke_callback_channel(channel, CALLBACK_MGR.HANDLER_NAME.CHANNEL_FRIEND_ADD, mix_user_list)
        if channel == friend_cache.CHANNELS.CUSTOMER and mix_user_list and #mix_user_list > 0 then
          ET.publish(ET.account_chat.CUSTOMER_CHANGED, mix_user_list)
        end
      end
    end)
  end,
  player = function(data)
    chat_base.process_player_friend_add(data, function(succ, ...)
      if succ then
        local add_msgs = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_ADD, add_msgs)
      end
    end)
  end
}
FRIEND_HANDLERS.friend_del = {
  channel = function(data)
    local channel = data.user_list[1].channel
    chat_base.process_channel_friend_del(channel, data, function(succ, ...)
      if succ then
        local mix_user_list = (...)
        invoke_callback_channel(channel, CALLBACK_MGR.HANDLER_NAME.CHANNEL_FRIEND_DEL, mix_user_list)
      end
    end)
  end,
  player = function(data)
    chat_base.process_player_friend_del(data, function(succ, ...)
      if succ then
        local delete_msgs = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_DEL, delete_msgs)
      end
    end)
  end
}

function FRIEND_HANDLERS.friend_channel_info_change(data)
  local channel = data.user_list[1].channel
  chat_base.process_friend_channel_info_change(channel, data, function(succ, ...)
    if succ then
      local mix_user_list = (...)
      invoke_callback_channel(channel, CALLBACK_MGR.HANDLER_NAME.CHANNEL_FRIEND_INFO_CHANGE, mix_user_list)
    end
  end)
end

FRIEND_HANDLERS.friend_info_change = {
  player = function(data)
    chat_base.process_friend_player_info_change(data, function(succ, ...)
      if succ then
        local info_change_msgs = (...)
        if info_change_msgs and next(info_change_msgs) ~= nil then
          invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_INFO_CHANGE, info_change_msgs)
        end
      end
    end)
  end
}
FRIEND_HANDLERS.friend_apply = {
  player = function(data)
    chat_base.process_friend_player_apply(data, function(succ, ...)
      if succ then
        local apply_msgs = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_APPLY, apply_msgs)
      end
    end)
  end
}
FRIEND_HANDLERS.friend_apply_refuse = {
  player = function(data)
    chat_friend.process_friend_player_apply_refuse(data, function(succ, ...)
      if succ then
        local apply_refuse_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_APPLY_REFUSE, apply_refuse_msg)
      end
    end)
  end
}
FRIEND_HANDLERS.friend_apply_delete = {
  player = function(data)
    chat_friend.process_friend_player_apply_delete(data, function(succ, ...)
      if succ then
        local apply_delete_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FRIEND_APPLY_DELETE, apply_delete_msg)
      end
    end)
  end
}
FOLLOW_HANDLERS.follow_add = {
  player = function(data)
    chat_base.process_player_follow_add(data, function(succ, ...)
      if succ then
        local follow_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FOLLOW_ADD, follow_msg)
      end
    end)
  end
}
FOLLOW_HANDLERS.follow_be_add = {
  player = function(data)
    chat_base.process_player_follow_be_add(data, function(succ, ...)
      if succ then
        local follow_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FOLLOW_BE_ADD, follow_msg)
      end
    end)
  end
}
FOLLOW_HANDLERS.follow_del = {
  player = function(data)
    chat_base.process_player_follow_del(data, function(succ, ...)
      if succ then
        local follow_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FOLLOW_DEL, follow_msg)
      end
    end)
  end
}
FOLLOW_HANDLERS.follow_be_del = {
  player = function(data)
    chat_base.process_player_follow_be_del(data, function(succ, ...)
      if succ then
        local follow_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FOLLOW_BE_DEL, follow_msg)
      end
    end)
  end
}
FOLLOW_HANDLERS.follow_info_change = {
  player = function(data)
    chat_base.process_player_follow_info_change(data, function(succ, ...)
      if succ then
        local follow_msg = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FOLLOW_INFO_CHANGE, follow_msg)
      end
    end)
  end
}
FAVOR_HANDLERS.favor_change = {
  player = function(data)
    chat_base.process_favor_change(data, function(succ, ...)
      if succ then
        local favor_change_msgs = (...)
        invoke_callback(CALLBACK_MGR.HANDLER_NAME.INFO_FAVOR_CHANGE, favor_change_msgs)
      end
    end)
  end
}

local function chat_update_state_handler(state, login_result_params)
  if state == STATES.LOGIN_SUCC then
    if login_result_params and login_result_params.destination == "chat" then
      already_get_friend_id_list_data = {}
    end
    M.get_friend_id_list_v2(nil, nil, function(...)
    end)
    friend_log.info(friend_log_util.header(), TAG, "auto_get_channel_friends_on_socket_connect", "friend_handle", {all_friend_channels = all_friend_channels}, {})
    for channel, _value in pairs(all_friend_channels) do
      M.get_channel_friends(channel, function(...)
      end)
      M.refresh_channel_friends(channel, function(...)
      end)
    end
  end
end

function M.init(game_handlers)
  friend_log.call_api(friend_log_util.header(), TAG, "init", friend_log.LOG_LEVEL.HIGH, {})
  if module_inited then
    return
  end
  friend_cache.init()
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, player_online_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  ET.subscribe(ET.gangplank.ACQUIRE, gangplank_acquire_handler)
  ET.subscribe(ET.chat.UPDATE_STATE, chat_update_state_handler)
  local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  CHAT.real_init()
  M.register_handlers()
  if game_handlers and next(game_handlers) then
    CALLBACK_MGR.register_callback(CHAT_SERVER.DESTINATION.CLIENT_FRIEND, game_handlers)
  end
  module_inited = true
end

function M.register_handlers()
  DISPATCHER.register_chat_handlers(CHAT_SERVER.DESTINATION.CLIENT_FRIEND, M.HANDLERS)
end

function M._sync_friend_scene()
  E.log(player_entered)
  if not player_entered then
    player_online_handler()
  end
end

function M.accept_friend_apply_v2(player_id, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "accept_friend_apply_v2", friend_log.LOG_LEVEL.HIGH, {}, player_id, rtype, ext, cb)
  local params = {player_id = player_id, rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("accept_friend_apply", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "accept_friend_apply_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_jf.accept_friend_apply_fail({
        method = "accept_friend_apply_v2",
        code = body.code or status,
        msg = body.message or ""
      })
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "accept_friend_apply_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.accept_friend_apply(player_id, cb)
  M.accept_friend_apply_v2(player_id, nil, nil, cb)
end

function M.accept_friend_apply_batch_v2(player_ids, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "accept_friend_apply_batch_v2", friend_log.LOG_LEVEL.HIGH, {}, player_ids, rtype, ext, cb)
  local params = {player_ids = player_ids, rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("accept_friend_apply_batch", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body or {})
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "accept_friend_apply_batch_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_jf.accept_friend_apply_fail({
        method = "accept_friend_apply_batch_v2",
        code = body.code or status,
        msg = body.message or ""
      })
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "accept_friend_apply_batch_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.accept_friend_apply_batch(player_ids, cb)
  M.accept_friend_apply_batch_v2(player_ids, nil, nil, cb)
end

function M.add_friend_apply_v2(player_id, apply_content, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "add_friend_apply_v2", friend_log.LOG_LEVEL.HIGH, {}, player_id, apply_content, rtype, ext, cb)
  local params = {
    player_id = player_id,
    content = apply_content,
    rtype = rtype
  }
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("add_friend_apply", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_apply_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_jf.add_friend_fail({
        code = body.code or status,
        msg = body.message or ""
      })
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_apply_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.add_friend_apply(player_id, apply_content, cb)
  M.add_friend_apply_v2(player_id, apply_content, nil, nil, cb)
end

function M.del_friend_v2(friend_player_id, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "del_friend_v2", friend_log.LOG_LEVEL.LOW, {}, friend_player_id, rtype, ext, cb)
  local params = {friend_player_id = friend_player_id, rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("del_friend", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.del_friend(friend_player_id, cb)
  M.del_friend_v2(friend_player_id, nil, nil, cb)
end

local function get_friend_apply_list_inner(state, last_time_index, cb)
  local params = {state = state, last_time_index = last_time_index}
  friend_post("get_friend_apply_list", params, function(_status, body)
    cb(body.last_indexTime, body.friend_apply_list)
  end)
end

local simple_cursor = Class:Inherit("FriendSimpleCursor")

function simple_cursor:_init(type, list_field_name, state)
  assert(type, "simple_cursor type should be string")
  assert(list_field_name, "list_field_name type should be string")
  self.type = type
  self.list_field_name = list_field_name
  self.state = state
  self.list = {}
  self.last_index_time = nil
end

function simple_cursor:load(cb)
  local params = {
    state = self.state,
    last_index_time = self.last_index_time
  }
  friend_post(self.type, params, function(status, body)
    if 200 == status then
      cb(true, body)
    else
      cb(false, body.code or status, body.message or "")
    end
  end)
end

local function fill_player_infos(list, cb, fail_cb, scene)
  local use_v1 = E.CONFIG.get_config("friend_use_v1")
  if not use_v1 then
    local id_to_object = {}
    local ids = {}
    for _, info in pairs(list) do
      if info.user_id then
        table.insert(ids, info.user_id)
        if not id_to_object[info.user_id] then
          id_to_object[info.user_id] = {}
        end
        table.insert(id_to_object[info.user_id], info)
      end
    end
    player_info.get_player_infos(ids, {
      playerid_to_info = true,
      scene = scene or player_scene.OFFICIAL_SCENE.FRIEND
    }, function(succ, ...)
      if succ then
        local players = (...)
        for player_id, player in pairs(players) do
          local obj_array = id_to_object[player_id]
          for _, obj in pairs(obj_array) do
            local copy_player = util.deepcopy(player)
            obj.player = copy_player
            obj.player_info = copy_player.player_info
          end
        end
        cb(list)
      else
        fail_cb()
      end
    end)
  else
    cb(list)
  end
end

function simple_cursor:load_all(cb, scene)
  local function listener(succ, body)
    if succ then
      self.last_index_time = body.last_index_time
      
      local cur_list = body[self.list_field_name]
      if cur_list and #cur_list > 0 then
        for _, item in pairs(cur_list) do
          table.insert(self.list, item)
        end
        self:load(listener)
      else
        local safe_scene = player_scene.OFFICIAL_SCENE.FRIEND
        if player_scene_ready_flag[scene] then
          safe_scene = scene
        end
        fill_player_infos(self.list, function(replace_list)
          cb(true, replace_list)
        end, function()
          cb(false, -1, "get player info fail")
        end, safe_scene)
      end
    else
      cb(false, -1, "")
    end
  end
  
  self:load(listener)
end

local cursor = Class:Inherit("FriendCursor")

function cursor:_init(state)
  self.state = state or {
    0,
    1,
    2
  }
  self.index = 1
  self.list = {}
end

function cursor:load(cb)
  local cur_item = self.list[self.index]
  if cur_item then
    cb(cur_item)
    return
  end
  if 1 == self.index then
  end
  local last_time_index = self.list[self.index - 1].last_time_index
  
  local function listener(index, list)
    local new_item = {last_time_index = index, list = list}
    self.list[self.index] = new_item
    cb(new_item)
  end
  
  get_friend_apply_list_inner(self.state, last_time_index, listener)
end

local function real_get_friend_id_list(rtype, ext, cb)
  if not rtype or 0 == #rtype then
    rtype = "friend"
  end
  local params = {rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  if not real_get_friend_id_list_on_request_map[rtype] or real_get_friend_id_list_on_request_map[rtype] and next(real_get_friend_id_list_on_request_map[rtype]) == nil then
    real_get_friend_id_list_on_request_map[rtype] = {}
    table.insert(real_get_friend_id_list_on_request_map[rtype], cb)
  else
    table.insert(real_get_friend_id_list_on_request_map[rtype], cb)
    return
  end
  friend_post("get_friend_id_list", params, function(status, body)
    local callback_cache_list = real_get_friend_id_list_on_request_map[rtype] or {}
    if 200 == status then
      friend_cache.clear_friend_ids(rtype)
      friend_cache.add_friend_ids(body.friend_id_list, rtype)
      friend_cache.merge_wait_operation()
      already_get_friend_id_list_data[rtype] = true
      for _, callback_item in pairs(callback_cache_list) do
        util.safe_call_cb(callback_item, true, friend_cache.get_all_friend_ids(rtype))
      end
    else
      for _, callback_item in pairs(callback_cache_list) do
        util.safe_call_cb(callback_item, false, body.code or status, body.message or "")
      end
    end
    real_get_friend_id_list_on_request_map[rtype] = {}
  end)
end

function M.is_process_get_friend_id_list(rtype)
  local cache_key = "friend"
  if rtype and #rtype > 0 then
    cache_key = rtype
  end
  if real_get_friend_id_list_on_request_map[cache_key] and next(real_get_friend_id_list_on_request_map[cache_key]) ~= nil then
    return true
  else
    return false
  end
end

function M.get_friend_id_list_v2(rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_id_list_v2", friend_log.LOG_LEVEL.HIGH, {}, rtype, ext, cb)
  if not rtype or 0 == #rtype then
    rtype = "friend"
  end
  if already_get_friend_id_list_data[rtype] then
    util.safe_call_cb(cb, true, friend_cache.get_all_friend_ids(rtype))
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_id_list_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, true, friend_cache.get_all_friend_ids(rtype))
    return
  end
  real_get_friend_id_list(rtype, ext, function(succ, ...)
    if not succ then
      local code, msg = ...
      friend_jf.get_friend_list_fail({
        method = "get_friend_id_list_v2",
        code = code,
        msg = msg
      })
    end
    util.safe_call_cb(cb, succ, ...)
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_id_list_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, succ, ...)
  end)
end

function M.get_friend_id_list(cb)
  M.get_friend_id_list_v2(nil, nil, cb)
end

function M.get_friend_info_list(player_id_list, cb)
  M.get_friend_info_list_v2(player_id_list, cb)
end

function M.get_friend_info_list_v2(player_id_list, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_info_list_v2", friend_log.LOG_LEVEL.LOW, {}, player_id_list, cb)
  player_info.get_player_infos(player_id_list, {
    scene = player_scene.OFFICIAL_SCENE.FRIEND
  }, function(succ, ...)
    if not succ then
      local code, msg = ...
      friend_jf.get_friend_list_fail({
        method = "get_friend_info_list_v2",
        code = code,
        msg = msg
      })
    end
    if cb then
      cb(succ, ...)
    end
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_info_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
  end)
end

function M.get_my_friend_info_list_v2(rtype, _params, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_my_friend_info_list_v2", friend_log.LOG_LEVEL.LOW, {}, rtype, _params, cb)
  local params = {rtype = rtype}
  for k, v in pairs(_params) do
    params[k] = v
  end
  
  local function friend_post_succ_action(_status, body)
    local friend_players = body.friend_info_list
    local player_infos = {}
    local player_ids = {}
    for _, player in pairs(friend_players) do
      player_cache.add_player_info_unsafe(player.player_id, player, "user_info_http", player_scene.OFFICIAL_SCENE.FRIEND)
      local friend_player_info = player_cache.get_player_info(player.player_id, player_scene.OFFICIAL_SCENE.FRIEND)
      if nil ~= friend_player_info then
        table.insert(player_infos, friend_player_info)
      end
      if player.player_id ~= nil then
        table.insert(player_ids, player.player_id)
      end
    end
    friend_cache.clear_friend_ids(params.rtype)
    friend_cache.add_friend_ids(player_ids, params.rtype)
    if cb then
      cb(true, player_infos)
    end
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_my_friend_info_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, player_infos)
  end
  
  local function friend_post_fail_action(status, body)
    local code = body.code or status
    local msg = body.message or ""
    util.safe_call_cb(cb, false, code, msg)
    friend_jf.get_friend_list_fail({
      method = "get_my_friend_info_list_v2",
      code = code,
      msg = msg
    })
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_my_friend_info_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, code, msg)
  end
  
  player_scene.get_scene_info(player_scene.OFFICIAL_SCENE.FRIEND, function(succ, ...)
    if not succ then
      util.safe_call_cb(cb, false, CONSTANTS.FRIEND_ERROR_CODES.CODE_FRIEND_SCENE_FETCH_FAIL, "friend scene data fetch fail")
      return
    end
    friend_post("get_friend_info_list", params, function(status, body)
      if 200 == status then
        friend_post_succ_action(status, body)
      else
        friend_post_fail_action(status, body)
      end
    end)
  end)
end

function M.get_my_friend_info_list(_params, cb)
  M.get_my_friend_info_list_v2(nil, _params, cb)
end

function M.get_friend_list_v2(rtype, _params, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_list_v2", friend_log.LOG_LEVEL.HIGH, {}, rtype, _params, cb)
  local params = {rtype = rtype}
  for k, v in pairs(_params) do
    params[k] = v
  end
  friend_post("get_friend_list", params, function(status, body)
    if 200 == status then
      local friend_players = body.friend_list
      local friend_ids = {}
      for _, player in pairs(friend_players) do
        if player.user_id ~= nil then
          table.insert(friend_ids, player.user_id)
        end
      end
      friend_cache.clear_friend_ids(params.rtype)
      friend_cache.add_friend_ids(friend_ids, params.rtype)
      if cb then
        cb(true, friend_players)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_list_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, true, friend_players)
    else
      local code = body.code or status
      local msg = body.message or ""
      friend_jf.get_friend_list_fail({
        method = "get_friend_list_v2",
        code = code,
        msg = msg
      })
      if cb then
        cb(false, code, msg)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_list_v2", friend_log.LOG_LEVEL.HIGH, {}, cb, false, code, msg)
    end
  end)
end

function M.get_friend_list(_params, cb)
  M.get_friend_list_v2(nil, _params, cb)
end

function M.get_friend_apply_list(state, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_apply_list", friend_log.LOG_LEVEL.LOW, {}, state, cb)
  local type = "get_friend_apply_list"
  local list_field_name = "friend_apply_list"
  if state then
    local safe_state = {}
    for _, value in ipairs(state) do
      table.insert(safe_state, tonumber(value))
    end
    state = safe_state
  end
  local apply_list_cursor = simple_cursor:New(type, list_field_name, state or {
    0,
    1,
    2
  })
  apply_list_cursor:load_all(function(...)
    if cb then
      cb(...)
    end
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, ...)
  end, player_scene.OFFICIAL_SCENE.FRIEND_APPLY)
end

function M.get_friend_to_apply_list(state, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_to_apply_list", friend_log.LOG_LEVEL.LOW, {}, state, cb)
  local type = "get_friend_to_apply_list"
  local list_field_name = "friend_apply_list"
  if state then
    local safe_state = {}
    for _, value in ipairs(state) do
      table.insert(safe_state, tonumber(value))
    end
    state = safe_state
  end
  local to_apply_list_cursor = simple_cursor:New(type, list_field_name, state or {
    0,
    1,
    2
  })
  to_apply_list_cursor:load_all(function(succ, ...)
    if not succ then
      if cb then
        cb(false, ...)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_to_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, false, ...)
      return
    end
    local apply_list = (...)
    local target_ids = {}
    for _, apply in ipairs(apply_list) do
      if apply.target_id then
        table.insert(target_ids, apply.target_id)
      end
    end
    if 0 == #target_ids then
      if cb then
        cb(true, apply_list)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_to_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, true, apply_list)
      return
    end
    local scene = player_scene.OFFICIAL_SCENE.FRIEND
    if player_scene_ready_flag[player_scene.OFFICIAL_SCENE.FRIEND_APPLY] then
      scene = player_scene.OFFICIAL_SCENE.FRIEND_APPLY
    end
    player_info.get_player_infos(target_ids, {playerid_to_info = true, scene = scene}, function(succ2, ...)
      if succ2 then
        local player_infos = (...)
        for _, apply in ipairs(apply_list) do
          if apply.target_id then
            apply.target_player = player_infos[apply.target_id]
          end
        end
        if cb then
          cb(true, apply_list)
        end
        friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_to_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, true, apply_list)
      else
        if cb then
          cb(false, ...)
        end
        friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_to_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, false, ...)
      end
    end)
  end, player_scene.OFFICIAL_SCENE.FRIEND_APPLY)
end

function M.get_new_friend_apply_list(_params, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_new_friend_apply_list", friend_log.LOG_LEVEL.LOW, {}, _params, cb)
  local params = _params or {}
  friend_post("get_new_friend_apply_list", params, function(status, body)
    if 200 == status then
      local apply_list = body.friend_apply_list
      local target_ids = {}
      for _, apply in ipairs(apply_list) do
        if apply.target_id then
          table.insert(target_ids, apply.target_id)
        end
      end
      if 0 == #target_ids then
        if cb then
          cb(true, apply_list)
        end
        friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_friend_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, true, apply_list)
        return
      end
      local scene = player_scene.OFFICIAL_SCENE.FRIEND
      if player_scene_ready_flag[player_scene.OFFICIAL_SCENE.FRIEND_APPLY] then
        scene = player_scene.OFFICIAL_SCENE.FRIEND_APPLY
      end
      player_info.get_player_infos(target_ids, {playerid_to_info = true, scene = scene}, function(succ2, ...)
        if succ2 then
          local player_infos = (...)
          for _, apply in ipairs(apply_list) do
            if apply.target_id then
              apply.target_player = player_infos[apply.target_id]
            end
          end
          if cb then
            cb(true, apply_list)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_friend_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, true, apply_list)
        else
          if cb then
            cb(false, ...)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_friend_apply_list", friend_log.LOG_LEVEL.LOW, {}, cb, false, ...)
        end
      end)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_friend_apply_list", friend_log.LOG_LEVEL.HIGH, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_new_friend_list(_params, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_new_friend_list", friend_log.LOG_LEVEL.LOW, {}, _params, cb)
  local params = _params or {}
  friend_post("get_new_friend_list", params, function(status, body)
    if 200 == status then
      local friend_players = body.friend_list
      if cb then
        cb(true, friend_players)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_friend_list", friend_log.LOG_LEVEL.LOW, {}, cb, true, friend_players)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_friend_list", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.refuse_friend_apply_v2(player_id, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "refuse_friend_apply_v2", friend_log.LOG_LEVEL.LOW, {}, player_id, rtype, ext, cb)
  local params = {player_id = player_id, rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("refuse_friend_apply", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refuse_friend_apply_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refuse_friend_apply_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.refuse_friend_apply(player_id, cb)
  M.refuse_friend_apply_v2(player_id, nil, nil, cb)
end

function M.refuse_friend_apply_batch_v2(player_ids, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "refuse_friend_apply_batch_v2", friend_log.LOG_LEVEL.LOW, {}, player_ids, rtype, ext, cb)
  local params = {player_ids = player_ids, rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("refuse_friend_apply_batch", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refuse_friend_apply_batch_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refuse_friend_apply_batch_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.refuse_friend_apply_batch(player_ids, cb)
  M.refuse_friend_apply_batch_v2(player_ids, nil, nil, cb)
end

function M.del_friend_apply_v2(player_id, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "del_friend_apply_v2", friend_log.LOG_LEVEL.LOW, {}, player_id, rtype, ext, cb)
  local params = {player_id = player_id, rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("del_friend_apply", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_apply_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_apply_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.del_friend_apply(player_id, cb)
  M.del_friend_apply_v2(player_id, nil, nil, cb)
end

function M.add_friend_black(player_id, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "add_friend_black", friend_log.LOG_LEVEL.LOW, {}, player_id, cb)
  local params = {player_id = player_id}
  friend_post("add_friend_black", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_black", friend_log.LOG_LEVEL.HIGH, {}, cb, true)
    else
      local code = body.code or status
      local msg = body.message or ""
      friend_jf.add_black_fail({code = code, msg = msg})
      if cb then
        cb(false, code, msg)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_black", friend_log.LOG_LEVEL.HIGH, {}, cb, false, code, msg)
    end
  end)
end

function M.del_friend_black(player_id, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "del_friend_black", friend_log.LOG_LEVEL.LOW, {}, player_id, cb)
  local params = {player_id = player_id}
  friend_post("del_friend_black", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_black", friend_log.LOG_LEVEL.HIGH, {}, cb, true)
    else
      local code = body.code or status
      local msg = body.message or ""
      friend_jf.del_black_fail({code = code, msg = msg})
      if cb then
        cb(false, code, msg)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_black", friend_log.LOG_LEVEL.HIGH, {}, cb, false, code, msg)
    end
  end)
end

function M.get_friend_black_list(cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_black_list", friend_log.LOG_LEVEL.LOW, {}, cb)
  local type = "get_friend_black_list"
  local list_field_name = "friend_black_list"
  local black_list_cursor = simple_cursor:New(type, list_field_name)
  black_list_cursor:load_all(function(...)
    if cb then
      cb(...)
    end
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_black_list", friend_log.LOG_LEVEL.LOW, {}, cb, ...)
  end, player_scene.OFFICIAL_SCENE.BLACK_LIST)
end

local function real_get_channel_friends(channel, cb, channel_friends_callback)
  friend_log.info(friend_log_util.header(), TAG, "real_http_get", "get_channel_friends", {channel = channel}, {})
  local params = {}
  params.channel = channel
  if not real_get_channel_friends_on_request_map[channel] or real_get_channel_friends_on_request_map[channel] and next(real_get_channel_friends_on_request_map[channel]) == nil then
    real_get_channel_friends_on_request_map[channel] = {}
    table.insert(real_get_channel_friends_on_request_map[channel], {fail_cb = cb, succ_cb = channel_friends_callback})
  else
    table.insert(real_get_channel_friends_on_request_map[channel], {fail_cb = cb, succ_cb = channel_friends_callback})
    return
  end
  friend_post("get_channel_friend_list", params, function(status, body)
    local callback_cache_list = real_get_channel_friends_on_request_map[channel] or {}
    if 200 == status then
      local channel_friends = body.user_list
      friend_cache.add_channel_friends(channel, channel_friends)
      for _, callback_fail_succ_pair in pairs(callback_cache_list) do
        util.safe_call_cb(callback_fail_succ_pair.succ_cb, util.deepcopy(channel_friends))
      end
      local channel_friend_ids = {}
      for _, v in pairs(channel_friends) do
        if v.user_id then
          table.insert(channel_friend_ids, v.user_id)
        end
      end
      friend_log.info(friend_log_util.header(), TAG, "real_http_get_succ", "get_channel_friends", {channel_friend_ids = channel_friend_ids}, {})
    else
      local code = body.code or status
      local msg = body.message or ""
      friend_log.warn(friend_log_util.header(), TAG, "real_http_get_fail", {code = code, msg = msg}, {})
      for _, callback_fail_succ_pair in pairs(callback_cache_list) do
        util.safe_call_cb(callback_fail_succ_pair.fail_cb, false, code, msg)
      end
    end
    real_get_channel_friends_on_request_map[channel] = {}
  end)
end

local function fill_channel_friend_infos(channel, user_list, cb)
  local item_maps = {}
  local account_ids = {}
  for _, item in ipairs(user_list) do
    local account_id = item.user_id
    if account_id then
      item.account_id = account_id
      item_maps[account_id] = item
      table.insert(account_ids, item.user_id)
    end
  end
  if 0 == #account_ids then
    cb(true, user_list)
    return
  end
  
  local function callback_with_infos(succ, ...)
    if succ then
      local new_user_list = {}
      for _account_id, mix_item in pairs(item_maps) do
        table.insert(new_user_list, mix_item)
      end
      cb(true, new_user_list)
    else
      cb(false, ...)
    end
  end
  
  if channel == friend_cache.CHANNELS.CUSTOMER then
    player_info.get_customer_infos(account_ids, function(succ, ...)
      if succ then
        local customer_infos = (...)
        for _, info in ipairs(customer_infos) do
          item_maps[info.account_id].channel_ext_info = info.account_info
        end
        if #customer_infos > 0 then
          ET.publish(ET.account_chat.OPEN, customer_infos)
        end
        callback_with_infos(succ, item_maps)
      else
        callback_with_infos(false, ...)
      end
    end)
  else
    player_info.get_filled_player_account_infos(account_ids, function(succ, ...)
      if succ then
        local info_map = (...)
        for account_id, info in pairs(info_map) do
          item_maps[account_id].account_info = info
        end
        callback_with_infos(true, item_maps)
      else
        callback_with_infos(false, ...)
      end
    end)
  end
end

function M.get_channel_friends(channel, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_channel_friends", friend_log.LOG_LEVEL.HIGH, {}, channel, cb)
  
  local function channel_friends_callback(channel_friends)
    fill_channel_friend_infos(channel, channel_friends, function(succ, ...)
      if not succ then
        local code, msg = ...
        friend_jf.get_friend_list_fail({
          method = "get_channel_friends",
          code = code,
          msg = msg
        })
      end
      util.safe_call_cb(cb, succ, ...)
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_channel_friends", friend_log.LOG_LEVEL.LOW, {}, cb, succ, "channel_friends_placeholder")
    end)
  end
  
  all_friend_channels[channel] = 1
  local channel_friends_cache = friend_cache.get_channel_friends(channel)
  if channel_friends_cache then
    local cache_user_ids = {}
    for _, item in pairs(channel_friends_cache) do
      if item.user_id then
        table.insert(cache_user_ids, item.user_id)
      end
    end
    friend_log.info(friend_log_util.header(), TAG, "has_channel_friends_cache", "get_channel_friends", {channel = channel, cache_user_ids = cache_user_ids}, {})
    channel_friends_callback(channel_friends_cache)
    return
  end
  real_get_channel_friends(channel, function(succ, ...)
    if not succ then
      local code, msg = ...
      friend_jf.get_friend_list_fail({
        method = "get_channel_friends",
        code = code,
        msg = msg
      })
    end
    util.safe_call_cb(cb, succ, ...)
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_channel_friends", friend_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
  end, channel_friends_callback)
end

local function real_refresh_channel_friends(channel, cb)
  cb = cb or function(_is_succ, _error_code, _error_msg)
  end
  local params = {}
  params.channel = channel
  if not real_refresh_channel_friends_on_request_map[channel] or real_refresh_channel_friends_on_request_map[channel] and next(real_refresh_channel_friends_on_request_map[channel]) == nil then
    real_refresh_channel_friends_on_request_map[channel] = {}
    table.insert(real_refresh_channel_friends_on_request_map[channel], cb)
  else
    table.insert(real_refresh_channel_friends_on_request_map[channel], cb)
    return
  end
  friend_post("refresh_channel_friend_list", params, function(status, body)
    local callback_cache_list = real_refresh_channel_friends_on_request_map[channel] or {}
    if 200 == status then
      refresh_channel_friends_cache = {
        time = os.time(),
        is_succ = true
      }
      for _, callback_item in pairs(callback_cache_list) do
        util.safe_call_cb(callback_item, true)
      end
    else
      local error_code = body.code or status
      local error_msg = body.message or ""
      refresh_channel_friends_cache = {
        time = os.time(),
        is_succ = false,
        error_code = error_code,
        error_msg = error_msg
      }
      for _, callback_item in pairs(callback_cache_list) do
        util.safe_call_cb(callback_item, false, error_code, error_msg)
      end
    end
    real_refresh_channel_friends_on_request_map[channel] = {}
  end)
end

function M.refresh_channel_friends(channel, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "refresh_channel_friends", friend_log.LOG_LEVEL.LOW, {}, channel, cb)
  all_friend_channels[channel] = 1
  if next(refresh_channel_friends_cache) and os.time() <= refresh_channel_friends_cache.time + 60 then
    if refresh_channel_friends_cache.is_succ then
      util.safe_call_cb(cb, true)
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refresh_channel_friends", friend_log.LOG_LEVEL.HIGH, {}, cb, refresh_channel_friends_cache.is_succ)
    else
      util.safe_call_cb(cb, false, refresh_channel_friends_cache.error_code or -1, refresh_channel_friends_cache.error_msg or "")
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refresh_channel_friends", friend_log.LOG_LEVEL.HIGH, {}, cb, refresh_channel_friends_cache.is_succ, refresh_channel_friends_cache.error_code or -1, refresh_channel_friends_cache.error_msg or "")
    end
    return
  end
  real_refresh_channel_friends(channel, function(succ, ...)
    if not succ then
      local code, msg = ...
      friend_jf.get_friend_list_fail({
        method = "refresh_channel_friends",
        code = code,
        msg = msg
      })
    end
    util.safe_call_cb(cb, succ, ...)
    friend_log.call_api_async_callback(friend_log_util.header(), TAG, "refresh_channel_friends", friend_log.LOG_LEVEL.LOW, {}, cb, succ, ...)
  end)
end

local function start_timer_60_minute()
  for channel, _value in pairs(all_friend_channels) do
    real_get_channel_friends(channel, function(...)
    end, function(...)
    end)
    real_refresh_channel_friends(channel, function(...)
    end)
  end
  E.Timer.once(auto_refresh_time_gap, start_timer_60_minute)
end

E.Timer.once(auto_refresh_time_gap, start_timer_60_minute)

function M.add_follow_v2(player_id, follow_type, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "add_follow_v2", friend_log.LOG_LEVEL.LOW, {}, player_id, follow_type, ext, cb)
  local params = {follow_user_id = player_id, follow_type = follow_type}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("add_follow", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.follow_info)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_follow_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.follow_info)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_follow_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.add_follow(player_id, cb)
  M.add_follow_v2(player_id, nil, nil, cb)
end

function M.del_follow_v2(player_id, follow_type, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "del_follow_v2", friend_log.LOG_LEVEL.LOW, {}, player_id, follow_type, ext, cb)
  local params = {follow_user_id = player_id, follow_type = follow_type}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("del_follow", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_follow_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_follow_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.del_follow(player_id, cb)
  M.del_follow_v2(player_id, nil, nil, cb)
end

function M.get_follow_ext(cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_follow_ext", friend_log.LOG_LEVEL.LOW, {}, cb)
  friend_post("get_follow_ext", {}, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.follow_ext)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_follow_ext", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.follow_ext)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_follow_ext", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_follow_id_list_v2(player_id, follow_type, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_follow_id_list_v2", friend_log.LOG_LEVEL.LOW, {}, player_id, follow_type, ext, cb)
  local params = {user_id = player_id, follow_type = follow_type}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("get_follow_id_list", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.user_id_list)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_follow_id_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.user_id_list)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_follow_id_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_follow_id_list(player_id, cb)
  M.get_follow_id_list_v2(player_id, nil, nil, cb)
end

local function get_player_info_map(player_ids, cb, scene)
  local player_maps = {}
  local safe_scene = player_scene.OFFICIAL_SCENE.FRIEND
  if player_scene_ready_flag[scene] then
    safe_scene = scene
  end
  player_info.get_player_infos(player_ids, {scene = safe_scene}, function(succ, ...)
    if succ then
      local player_infos = (...)
      for _, pinfo in ipairs(player_infos) do
        player_maps[pinfo.player_id] = pinfo
      end
      cb(true, player_maps)
    else
      local code, message = ...
      cb(false, code, message)
    end
  end)
end

local function fill_object_player_info(obj_list, player_id_key, cb, scene)
  if nil == obj_list then
    cb(false, -1, "obj_list is nil")
  end
  local player_ids = {}
  for i = 1, #obj_list do
    local player_id = obj_list[i][player_id_key]
    table.insert(player_ids, player_id)
  end
  get_player_info_map(player_ids, function(succ, ...)
    if succ then
      local player_maps = (...)
      for i = 1, #obj_list do
        local info = obj_list[i]
        info.player_detail_info = player_maps[info[player_id_key]]
      end
      cb(true, obj_list)
    else
      local code, msg = ...
      cb(false, code, msg)
    end
  end, scene)
end

function M.get_follow_list_v2(player_id, follow_type, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_follow_list_v2", friend_log.LOG_LEVEL.LOW, {}, player_id, follow_type, ext, cb)
  local params = {user_id = player_id, follow_type = follow_type}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("get_follow_list", params, function(status, body)
    if 200 == status then
      fill_object_player_info(body.follow_list, "follow_user_id", function(...)
        if cb then
          cb(...)
        end
        friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_follow_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, ...)
      end, player_scene.OFFICIAL_SCENE.FOLLOW)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_follow_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_follow_list(player_id, cb)
  M.get_follow_list_v2(player_id, nil, nil, cb)
end

function M.get_followed_list_v2(last_index_time, follow_type, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, last_index_time, follow_type, ext, cb)
  local params = {last_index_time = last_index_time, follow_type = follow_type}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("get_followed_list", params, function(status, body)
    if 200 == status then
      fill_object_player_info(body.follow_list, "user_id", function(succ, ...)
        if succ then
          if cb then
            cb(true, body)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, body)
        else
          if cb then
            cb(false, ...)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, ...)
        end
      end, player_scene.OFFICIAL_SCENE.FOLLOW)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_followed_list(last_index_time, cb)
  M.get_followed_list_v2(last_index_time, nil, nil, cb)
end

function M.get_new_followed_list_v2(last_index_time, follow_type, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_new_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, last_index_time, follow_type, ext, cb)
  local params = {last_index_time = last_index_time, follow_type = follow_type}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("get_new_followed_list", params, function(status, body)
    if 200 == status then
      fill_object_player_info(body.follow_list, "user_id", function(succ, ...)
        if succ then
          if cb then
            cb(true, body)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, body)
        else
          if cb then
            cb(false, ...)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, ...)
        end
      end, player_scene.OFFICIAL_SCENE.FOLLOW)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_new_followed_list_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_new_followed_list(last_index_time, cb)
  M.get_new_followed_list_v2(last_index_time, nil, nil, cb)
end

function M.add_friend_group_v2(group_name, members, group_ext, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "add_friend_group_v2", friend_log.LOG_LEVEL.LOW, {}, group_name, members, group_ext, rtype, ext, cb)
  local params = {
    name = group_name,
    ext = group_ext,
    rtype = rtype
  }
  if #members > 0 then
    params.friend_player_id_list = members
  end
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("add_friend_group", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.friend_group)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_group_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.friend_group)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_group_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.add_friend_group(group_name, members, group_ext, cb)
  M.add_friend_group_v2(group_name, members, group_ext, nil, nil, cb)
end

function M.del_friend_group(group_id, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "del_friend_group", friend_log.LOG_LEVEL.LOW, {}, group_id, cb)
  local params = {group_id = group_id}
  friend_post("del_friend_group", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_group", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_group", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_friend_group_v2(rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_group_v2", friend_log.LOG_LEVEL.LOW, {}, rtype, ext, cb)
  local params = {rtype = rtype}
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("get_friend_group", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body.friend_group_list)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_group_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.friend_group_list)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_group_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_friend_group(cb)
  M.get_friend_group_v2(nil, nil, cb)
end

function M.add_friend_group_member_v2(friend_player_id_list, group_id, rtype, ext, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "add_friend_group_member_v2", friend_log.LOG_LEVEL.LOW, {}, friend_player_id_list, group_id, rtype, ext, cb)
  local params = {
    friend_player_id_list = friend_player_id_list,
    group_id = group_id,
    rtype = rtype
  }
  if ext then
    for k, v in pairs(ext) do
      params[k] = v
    end
  end
  friend_post("add_friend_group_member", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_group_member_v2", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "add_friend_group_member_v2", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.add_friend_group_member(friend_player_id_list, group_id, cb)
  M.add_friend_group_member_v2(friend_player_id_list, group_id, nil, nil, cb)
end

function M.del_friend_group_member(group_id, friend_player_id, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "del_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, group_id, friend_player_id, cb)
  local params = {group_id = group_id, friend_player_id = friend_player_id}
  friend_post("del_friend_group_member", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true)
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, cb, true)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "del_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.get_friend_group_member(group_id, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, group_id, cb)
  local params = {group_id = group_id}
  friend_post("get_friend_group_member", params, function(status, body)
    if 200 == status then
      local ids = {}
      for _, info in ipairs(body.friend_list) do
        table.insert(ids, info.user_id)
      end
      player_info.get_player_infos(ids, {
        playerid_to_info = true,
        scene = player_scene.OFFICIAL_SCENE.FRIEND
      }, function(succ, ...)
        if succ then
          local players = (...)
          for _, info in pairs(body.friend_list) do
            if info.user_id and players[info.user_id] then
              info.player = players[info.user_id]
            end
          end
          if cb then
            cb(true, body.friend_list)
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, cb, true, body.friend_list)
        else
          if cb then
            cb(false, -1, "get player info fail")
          end
          friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, cb, false, -1, "get player info fail")
        end
      end)
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "get_friend_group_member", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

function M.update_friend_group_info(group_infos, cb)
  friend_log.call_api(friend_log_util.header(), TAG, "update_friend_group_info", friend_log.LOG_LEVEL.LOW, {}, group_infos, cb)
  local params = {update_list = group_infos}
  friend_post("update_friend_group_info", params, function(status, body)
    if 200 == status then
      if cb then
        cb(true, body or {})
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "update_friend_group_info", friend_log.LOG_LEVEL.LOW, {}, cb, true, body or {})
    else
      if cb then
        cb(false, body.code or status, body.message or "")
      end
      friend_log.call_api_async_callback(friend_log_util.header(), TAG, "update_friend_group_info", friend_log.LOG_LEVEL.LOW, {}, cb, false, body.code or status, body.message or "")
    end
  end)
end

return M
