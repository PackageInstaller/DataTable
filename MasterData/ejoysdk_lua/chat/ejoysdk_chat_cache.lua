local E = require("ejoysdk_lua.ejoysdk")
local util = require("ejoysdk_lua.ejoysdk_utils")
local player_cache = require("ejoysdk_lua.player.player_info_cache")
local EXPRIED_TIME = 60
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local TAG = EM.MODULE.CHAT .. "cache"
local M = {}
local SESSION_PENDING_ATTRS_KEYSTORE = E.LazyKeyStore:New("EJOYSDK_SESSION_TOP_SAVE_PENDING", false, true, false)
local static_session_attrs_pending_cache

function M.init(expried_time)
  chat_log.call_api(chat_log_util.header(), TAG, "init", chat_log.LOG_LEVEL.HIGH, {}, expried_time)
  if expried_time then
    assert(type(expried_time) == "number", "expried_time must be number")
    EXPRIED_TIME = expried_time
  end
end

function M.set_expried_time(expried_time)
  chat_log.call_api(chat_log_util.header(), TAG, "set_expried_time", chat_log.LOG_LEVEL.HIGH, {}, expried_time)
  assert(type(expried_time) == "number", "expried_time must be number")
  EXPRIED_TIME = expried_time
  player_cache.set_expire_time(expried_time)
end

local cache_groups = {}

function M.login_group(groups)
  local log_groups = chat_log_util.simple_group_infos(groups)
  local log_group_sections = chat_log.list_by_section(log_groups, 3)
  for _, v in pairs(log_group_sections) do
    chat_log.call_api(chat_log_util.header(), TAG, "login_group", chat_log.LOG_LEVEL.HIGH, {}, v)
  end
  for _, group in ipairs(groups) do
    local group_id = group.group_id
    local group_copyed = util.deepcopy(group)
    if group_copyed.voice_channel_users then
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
    end
    cache_groups[group_id] = group_copyed
  end
end

function M.create_group(group)
  local log_group = chat_log_util.simple_group_info(group)
  chat_log.call_api(chat_log_util.header(), TAG, "create_group", chat_log.LOG_LEVEL.HIGH, {}, log_group)
  local group_copyed = util.deepcopy(group)
  if group_copyed.voice_channel_users then
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
  end
  cache_groups[group.group_id] = group_copyed
end

function M.delete_group(group_id)
  chat_log.call_api(chat_log_util.header(), TAG, "delete_group", chat_log.LOG_LEVEL.HIGH, {}, group_id)
  cache_groups[group_id] = nil
end

function M.update_group(group)
  local log_group = chat_log_util.simple_group_info(group)
  chat_log.call_api(chat_log_util.header(), TAG, "update_group", chat_log.LOG_LEVEL.HIGH, {}, log_group)
  local group_copyed = util.deepcopy(group)
  if group_copyed.voice_channel_users then
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
  end
  cache_groups[group.group_id] = group_copyed
end

function M.voice_channel_user_change_update_group(group_id, removes_map, updates_map, ext)
  chat_log.call_api(chat_log_util.header(), TAG, "voice_channel_user_change_update_group", chat_log.LOG_LEVEL.LOW, {}, group_id, removes_map, updates_map)
  local old = cache_groups[group_id]
  if old then
    if removes_map and old.voice_channel_users and #old.voice_channel_users > 0 then
      for i = #old.voice_channel_users, 1, -1 do
        if removes_map[old.voice_channel_users[i].user_id] then
          table.remove(old.voice_channel_users, i)
        end
      end
    end
    if updates_map then
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
  end
end

local _chat_impl_instance

function M.set_chat_model(impl_instance)
  _chat_impl_instance = impl_instance
end

function M.get_group(group_id)
  if _chat_impl_instance then
    do return _chat_impl_instance.get_group_cache, _chat_impl_instance end
    return _chat_impl_instance.get_group_cache, _chat_impl_instance, group_id, nil, nil, nil, nil, nil, nil, nil
  end
  chat_log.call_api(chat_log_util.header(), TAG, "get_group", chat_log.LOG_LEVEL.LOW, {}, group_id)
  if not group_id then
    return nil
  end
  local group = cache_groups[group_id]
  local res
  if group then
    res = util.deepcopy(group)
  else
    res = nil
  end
  local log_group = chat_log_util.simple_group_info(res)
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "get_group", chat_log.LOG_LEVEL.LOW, {}, log_group)
  return res
end

function M.get_all_groups()
  chat_log.call_api(chat_log_util.header(), TAG, "get_all_groups", chat_log.LOG_LEVEL.LOW, {})
  local groups_by_type = {}
  for _, group in pairs(cache_groups) do
    local coped = util.deepcopy(group)
    if coped and coped.info and coped.info.type then
      if not groups_by_type[coped.info.type] then
        groups_by_type[coped.info.type] = {}
      end
      local one_type_groups = groups_by_type[coped.info.type]
      table.insert(one_type_groups, coped)
    end
  end
  local log_groups = chat_log_util.simple_group_infos(cache_groups)
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "get_all_groups", chat_log.LOG_LEVEL.LOW, {}, log_groups)
  return groups_by_type
end

local ignore_sessions = {}
local ignore_group_types = {}

function M.get_ignore_data()
  chat_log.call_api(chat_log_util.header(), TAG, "get_ignore_data", chat_log.LOG_LEVEL.LOW, {})
  local ignore_data = {}
  ignore_data.sessions = util.deepcopy(ignore_sessions)
  ignore_data.group_types = util.deepcopy(ignore_group_types)
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "get_ignore_data", chat_log.LOG_LEVEL.LOW, {}, ignore_data)
  return ignore_data
end

function M.set_ignore_data(data)
  chat_log.call_api(chat_log_util.header(), TAG, "set_ignore_data", chat_log.LOG_LEVEL.HIGH, {}, data)
  local sessions = data.sessions
  ignore_sessions = {}
  ignore_group_types = {}
  if sessions then
    for _, session_id in pairs(sessions) do
      ignore_sessions[session_id] = true
    end
  end
  local group_types = data.group_types
  if group_types then
    for _, group_type in pairs(group_types) do
      ignore_group_types[group_type] = true
    end
  end
end

function M.is_ignore_session(session_id)
  chat_log.call_api(chat_log_util.header(), TAG, "is_ignore_session", chat_log.LOG_LEVEL.LOW, {}, session_id)
  if ignore_sessions[session_id] then
    chat_log.call_api_sync_return(chat_log_util.header(), TAG, "is_ignore_session", chat_log.LOG_LEVEL.LOW, {}, true)
    return true
  end
  local group = cache_groups[session_id]
  if group then
    local group_info = group.info
    local group_type = group_info.type or ""
    if ignore_group_types[group_type] then
      chat_log.call_api_sync_return(chat_log_util.header(), TAG, "is_ignore_session", chat_log.LOG_LEVEL.LOW, {}, true)
      return true
    end
  end
  chat_log.call_api_sync_return(chat_log_util.header(), TAG, "is_ignore_session", chat_log.LOG_LEVEL.LOW, {}, false)
  return false
end

function M.clear()
  chat_log.call_api(chat_log_util.header(), TAG, "clear", chat_log.LOG_LEVEL.HIGH, {})
  ignore_sessions = {}
  ignore_group_types = {}
  cache_groups = {}
end

function M.get_session_attrs_pending_cache()
  local PD = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
  local destinations = {
    PD.DESTINATION.ACCOUNT,
    PD.DESTINATION.PLAYER
  }
  local all_cache = {}
  for _, destination in ipairs(destinations) do
    local cache_map = M.get_session_attrs_pending_cache_with_destination(destination)
    for sid, attrs in pairs(cache_map) do
      all_cache[sid] = attrs
    end
  end
  return all_cache
end

function M.get_session_attrs_pending_cache_with_destination(destination)
  if not static_session_attrs_pending_cache then
    E.LOG.debug(TAG, "get_session_attrs_pending_cache begin init local pending cache")
    static_session_attrs_pending_cache = SESSION_PENDING_ATTRS_KEYSTORE:get() or {}
  end
  static_session_attrs_pending_cache[destination] = static_session_attrs_pending_cache[destination] or {}
  return static_session_attrs_pending_cache[destination]
end

function M.save_session_attrs_pending_cache(session_attrs_map)
  local CS = require("ejoysdk_lua.chat.ejoysdk_chat_base")
  local dest_attrs_map = {}
  for sid, attrs in pairs(session_attrs_map) do
    local destination = CS.get_session_destination(sid)
    dest_attrs_map[destination] = dest_attrs_map[destination] or {}
    dest_attrs_map[destination][sid] = attrs
  end
  for destination, attrs in pairs(dest_attrs_map) do
    M.save_session_attrs_pending_cache_with_destination(destination, attrs)
  end
end

function M.save_session_attrs_pending_cache_to_disk()
  SESSION_PENDING_ATTRS_KEYSTORE:set(util.deepcopy(static_session_attrs_pending_cache))
end

function M.save_session_attrs_pending_cache_with_destination(destination, new_session_attrs_map)
  local destination_cache_map = M.get_session_attrs_pending_cache_with_destination(destination)
  new_session_attrs_map = new_session_attrs_map or {}
  for session_id, attrs in pairs(new_session_attrs_map) do
    local last_cache_data = destination_cache_map[session_id]
    if last_cache_data then
      E.log("last_cache_data >>>")
      E.log(last_cache_data)
      E.log("attrs>>")
      E.log(attrs)
      attrs = util.merge_table(last_cache_data, attrs)
    end
    destination_cache_map[session_id] = attrs
  end
  M.save_session_attrs_pending_cache_to_disk()
end

function M.remove_session_attrs_pending_cache(destination, session_attrs_map)
  local dest_cache_map = M.get_session_attrs_pending_cache_with_destination(destination)
  for session_id, _ in pairs(session_attrs_map) do
    dest_cache_map[session_id] = nil
  end
  M.save_session_attrs_pending_cache_to_disk()
end

function M.remove_session_attrs_pending_cache_by_id(destination, session_id)
  local dest_pending_cache = M.get_session_attrs_pending_cache_with_destination(destination)
  dest_pending_cache[session_id] = nil
  M.save_session_attrs_pending_cache_to_disk()
end

function M.get_session_attrs_pending_cache_with_id(destination, session_id)
  local dest_pending_cache = M.get_session_attrs_pending_cache_with_destination(destination)
  local session_attr = dest_pending_cache[session_id]
  return session_attr
end

return M
