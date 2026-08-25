local util = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local friend_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local friend_log_util = require("ejoysdk_lua.friend.ejoysdk_friend_log_util")
local M = {}
local TAG = EM.MODULE.FRIEND .. "friend_cache"

local function merge_table(old_table, new_table)
  assert(type(old_table) == "table", "param old_table must be table type")
  assert(type(new_table) == "table", "param new_table must be table type")
  for k, v in pairs(new_table) do
    if type(v) ~= type(old_table[k]) then
      old_table[k] = v
    elseif type(v) == "table" then
      old_table[k] = merge_table(old_table[k], v)
    else
      old_table[k] = v
    end
  end
  return old_table
end

local channel_friend_cache = {}
local DEFAULT_RTYPE = "friend"
local rtype_friend_id_cache = {}
local wait_operation = {}
M.CHANNELS = {FB = "FB", CUSTOMER = "Customer"}
local CHANNEL_EXT_ID_ADAPTER = {
  [M.CHANNELS.FB] = "id",
  [M.CHANNELS.CUSTOMER] = "chatUserId"
}

function M.clear()
  friend_log.call_api(friend_log_util.header(), TAG, "clear", friend_log.LOG_LEVEL.HIGH, {})
  channel_friend_cache = {}
  rtype_friend_id_cache = {}
  wait_operation = {}
end

function M.init()
  friend_log.call_api(friend_log_util.header(), TAG, "init", friend_log.LOG_LEVEL.HIGH, {})
  M.clear()
end

local function user_id_key(channel)
  return CHANNEL_EXT_ID_ADAPTER[channel]
end

function M.add_channel_friend(channel, channel_friend)
  friend_log.call_api(friend_log_util.header(), TAG, "add_channel_friend", friend_log.LOG_LEVEL.LOW, {}, channel, channel_friend)
  channel_friend_cache[channel] = channel_friend_cache[channel] or {}
  local channel_user_id = channel_friend.channel_ext_info[user_id_key(channel)]
  if channel_user_id then
    channel_friend_cache[channel][channel_user_id] = util.deepcopy(channel_friend)
  end
end

function M.add_channel_friends(channel, channel_friends)
  friend_log.call_api(friend_log_util.header(), TAG, "add_channel_friends", friend_log.LOG_LEVEL.LOW, {}, channel, channel_friends)
  channel_friend_cache[channel] = channel_friend_cache[channel] or {}
  for _, account_friend in ipairs(channel_friends) do
    M.add_channel_friend(channel, account_friend)
  end
end

function M.remove_channel_friend(channel, channel_friend)
  friend_log.call_api(friend_log_util.header(), TAG, "remove_channel_friend", friend_log.LOG_LEVEL.LOW, {}, channel, channel_friend)
  if channel_friend_cache[channel] then
    local channel_user_id = channel_friend.channel_ext_info[user_id_key(channel)]
    if channel_user_id then
      local cache = channel_friend_cache[channel]
      cache[channel_user_id] = nil
    end
  end
end

function M.get_channel_friends(channel)
  friend_log.call_api(friend_log_util.header(), TAG, "get_channel_friends", friend_log.LOG_LEVEL.LOW, {}, channel)
  if channel_friend_cache[channel] then
    local cache = channel_friend_cache[channel]
    local channel_friend_list = {}
    for _, channel_friend in pairs(cache) do
      table.insert(channel_friend_list, util.deepcopy(channel_friend))
    end
    return channel_friend_list
  else
    return nil
  end
end

function M.update_channel_friend(channel, new_channel_friend)
  friend_log.call_api(friend_log_util.header(), TAG, "update_channel_friend", friend_log.LOG_LEVEL.LOW, {}, channel, new_channel_friend)
  local cache = channel_friend_cache[channel]
  if not cache then
    friend_log.call_api_sync_return(friend_log_util.header(), TAG, "update_channel_friend", friend_log.LOG_LEVEL.LOW, {}, nil)
    return nil
  end
  local channel_user_id = new_channel_friend.channel_ext_info[user_id_key(channel)]
  if not channel_user_id then
    friend_log.call_api_sync_return(friend_log_util.header(), TAG, "update_channel_friend", friend_log.LOG_LEVEL.LOW, {}, nil)
    return nil
  end
  local old_channel_friend = cache[channel_user_id]
  if old_channel_friend then
    merge_table(old_channel_friend, new_channel_friend)
    local res = util.deepcopy(old_channel_friend)
    friend_log.call_api_sync_return(friend_log_util.header(), TAG, "update_channel_friend", friend_log.LOG_LEVEL.LOW, {}, res)
    return res
  else
    friend_log.call_api_sync_return(friend_log_util.header(), TAG, "update_channel_friend", friend_log.LOG_LEVEL.LOW, {}, nil)
    return nil
  end
end

function M.get_friend_ids_cache_length(rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "get_friend_ids_cache_length", friend_log.LOG_LEVEL.LOW, {}, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  local res = util.tablelength(rtype_friend_id_cache[rtype] or {})
  friend_log.call_api_sync_return(friend_log_util.header(), TAG, "get_friend_ids_cache_length", friend_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_all_friend_ids(rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "get_all_friend_ids", friend_log.LOG_LEVEL.LOW, {}, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  local temp_array = {}
  for player_id, _ in pairs(rtype_friend_id_cache[rtype] or {}) do
    table.insert(temp_array, player_id)
  end
  friend_log.call_api_sync_return(friend_log_util.header(), TAG, "get_all_friend_ids", friend_log.LOG_LEVEL.LOW, {}, temp_array)
  return temp_array
end

function M.add_friend_id(player_id, rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "add_friend_id", friend_log.LOG_LEVEL.LOW, {}, player_id, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  rtype_friend_id_cache[rtype] = rtype_friend_id_cache[rtype] or {}
  rtype_friend_id_cache[rtype][player_id] = true
end

function M.add_friend_ids(player_ids, rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "add_friend_ids", friend_log.LOG_LEVEL.LOW, {}, player_ids, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  rtype_friend_id_cache[rtype] = rtype_friend_id_cache[rtype] or {}
  for _, player_id in ipairs(player_ids) do
    rtype_friend_id_cache[rtype][player_id] = true
  end
end

function M.remove_friend_id(player_id, rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "remove_friend_id", friend_log.LOG_LEVEL.LOW, {}, player_id, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  local id_cache = rtype_friend_id_cache[rtype] or {}
  id_cache[player_id] = nil
  rtype_friend_id_cache[rtype] = id_cache
end

function M.add_wait_operation(type, player_ids, rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "add_wait_operation", friend_log.LOG_LEVEL.LOW, {}, type, player_ids, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  table.insert(wait_operation, {
    type = type,
    player_ids = player_ids,
    rtype = rtype
  })
end

function M.get_wait_operation()
  do return util.deepcopy end
  return util.deepcopy, wait_operation
end

function M.clear_wait_operation()
  wait_operation = {}
end

function M.merge_wait_operation()
  for _, operation in pairs(wait_operation) do
    if operation.type == "add" then
      local rtype = operation.rtype or "friend"
      rtype_friend_id_cache[rtype] = rtype_friend_id_cache[rtype] or {}
      for _, player_id in ipairs(operation.player_ids) do
        rtype_friend_id_cache[rtype][player_id] = true
      end
    elseif operation.type == "del" then
      local rtype = operation.rtype or "friend"
      local id_cache = rtype_friend_id_cache[rtype] or {}
      for _, player_id in ipairs(operation.player_ids) do
        id_cache[player_id] = nil
      end
      rtype_friend_id_cache[rtype] = id_cache
    end
  end
  M.clear_wait_operation()
end

function M.remove_friend_ids(player_ids, rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "remove_friend_ids", friend_log.LOG_LEVEL.LOW, {}, player_ids, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  local id_cache = rtype_friend_id_cache[rtype] or {}
  for _, player_id in ipairs(player_ids) do
    id_cache[player_id] = nil
  end
  rtype_friend_id_cache[rtype] = id_cache
end

function M.clear_friend_ids(rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "clear_friend_ids", friend_log.LOG_LEVEL.LOW, {}, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  rtype_friend_id_cache[rtype] = {}
end

function M.is_friend_id(player_id, rtype)
  friend_log.call_api(friend_log_util.header(), TAG, "is_friend_id", friend_log.LOG_LEVEL.LOW, {}, player_id, rtype)
  if not rtype or 0 == #rtype then
    rtype = DEFAULT_RTYPE
  end
  local id_cache = rtype_friend_id_cache[rtype] or {}
  local res = id_cache[player_id]
  friend_log.call_api_sync_return(friend_log_util.header(), TAG, "is_friend_id", friend_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_cache()
  friend_log.call_api(friend_log_util.header(), TAG, "get_cache", friend_log.LOG_LEVEL.LOW, {})
  local res = util.deepcopy(rtype_friend_id_cache)
  friend_log.call_api_sync_return(friend_log_util.header(), TAG, "get_cache", friend_log.LOG_LEVEL.LOW, {}, res)
  return res
end

return M
