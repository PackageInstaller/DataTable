local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local Utils = require("ejoysdk_lua.native.utils.Utils")
local FRIEND = require("ejoysdk_lua.friend.ejoysdk_friend")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local M = {}
local notify_callback
local MSG_TYPE = {NEW_FRIENT_APPLY = 100}

local function notify_native(type, data_table)
  Utils.notify(notify_callback, 9999, "收到推送", {type = type, data = data_table})
end

function M.init(cb)
  notify_callback = cb
end

function M.get_my_info()
  local player_info = EG.player_info() or {}
  local user_info = EG.user_info() or {}
  local result_table = Utils.merge_tables(player_info, user_info)
  do return Utils.notify, nil, 200, "获取成功" end
  return Utils.notify, nil, 200, "获取成功", result_table
end

function M.get_friends_list(params, cb)
  local channel = params.channel
  local rtype = params.rtype
  local ext = EU.deepcopy(params)
  ext.channel = nil
  ext.rtype = nil
  
  local function callback(success, ...)
    local id_list = (...)
    if success then
      Utils.notify(cb, 200, "获取列表成功", id_list)
    else
      local code, message = ...
      Utils.notify(cb, -1, "获取列表失败, code: " .. code .. " ,msg: " .. message)
    end
  end
  
  if channel and string.len(channel) > 0 then
    FRIEND.get_channel_friends(channel, callback)
  else
    FRIEND.get_friend_id_list_v2(rtype, ext, callback)
  end
end

function M.refresh_friends_list(params, cb)
  local channel = params.channel
  if channel and string.len(channel) > 0 then
    FRIEND.refresh_channel_friends(channel, function(success, ...)
      if success then
        M.get_friends_list(params, cb)
      else
        local code, message = ...
        Utils.notify(cb, -1, "刷新好友列表失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  else
    M.get_friends_list(params, cb)
  end
end

function M.get_followed_list(params, cb)
  local last_index_time = params.last_index_time
  local follow_type = params.follow_type
  local ext = EU.deepcopy(params)
  ext.last_index_time = nil
  ext.follow_type = nil
  FRIEND.get_followed_list_v2(last_index_time, follow_type, ext, function(success, ...)
    if success then
      local body = (...)
      Utils.notify(cb, 200, "拉取粉丝列表成功", body)
    else
      local code, message = ...
      Utils.notify(cb, -1, "拉取粉丝列表失败, code: " .. code .. " ,msg: " .. message)
    end
  end)
end

function M.get_follow_list(params, cb)
  local player_id = params.player_id
  local follow_type = params.follow_type
  if player_id and string.len(player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.follow_type = nil
    FRIEND.get_follow_list_v2(player_id, follow_type, ext, function(success, ...)
      if success then
        local follow_list = (...)
        Utils.notify(cb, 200, "拉取关注列表成功", follow_list)
      else
        local code, message = ...
        Utils.notify(cb, -1, "拉取关注列表失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.get_friend_apply_list(params, cb)
  local state = params.state or {0}
  FRIEND.get_friend_apply_list(state, function(success, ret)
    if success then
      Utils.notify(cb, 200, "拉取申请加好友列表成功", ret)
    else
      Utils.notify(cb, -1, "拉取申请加好友列表失败")
    end
  end)
end

function M.get_player_info(params, cb)
  local player_id_list = params.player_id_list or {}
  FRIEND.get_friend_info_list_v2(player_id_list, function(success, ...)
    local info_list = (...)
    if success then
      Utils.notify(cb, 200, "拉取好友信息成功", info_list)
    else
      local code, message = ...
      Utils.notify(cb, -1, "拉取好友信息失败, code: " .. code .. " ,msg: " .. message)
    end
  end)
end

function M.get_my_apply_friend_list(params, cb)
  local state = params.state or {
    0,
    1,
    2
  }
  FRIEND.get_friend_to_apply_list(state, function(success, ...)
    if success then
      local to_apply_list = (...)
      Utils.notify(cb, 200, "拉取发出的添加好友信息成功", to_apply_list)
    else
      local code, message = ...
      Utils.notify(cb, -1, "拉取发出的添加好友信息失败, code: " .. code .. " ,msg: " .. message)
    end
  end)
end

function M.get_blocked_user_list(cb)
  FRIEND.get_friend_black_list(function(success, ret)
    if success then
      Utils.notify(cb, 200, "获取黑名单列表成功", ret)
    else
      Utils.notify(cb, -1, "获取黑名单列表失败")
    end
  end)
end

function M.remove_friend(params, cb)
  local friend_player_id = params.player_id
  local rtype = params.rtype
  if friend_player_id and string.len(friend_player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.rtype = nil
    FRIEND.del_friend_v2(friend_player_id, rtype, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "删除成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "删除好友失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.remove_follow_player(params, cb)
  local friend_player_id = params.player_id
  local follow_type = params.follow_type
  if friend_player_id and string.len(friend_player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.follow_type = nil
    FRIEND.del_follow_v2(friend_player_id, follow_type, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "取消关注成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "取消关注失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.block_player(params, cb)
  local friend_player_id = params.player_id
  if friend_player_id and string.len(friend_player_id) > 0 then
    FRIEND.add_friend_black(friend_player_id, function(success, ...)
      if success then
        Utils.notify(cb, 200, "拉黑成功,player_id: " .. friend_player_id)
      else
        local code, message = ...
        Utils.notify(cb, -1, "拉黑失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.unblock_player(params, cb)
  local friend_player_id = params.player_id
  if friend_player_id and string.len(friend_player_id) > 0 then
    FRIEND.del_friend_black(friend_player_id, function(success, ...)
      if success then
        Utils.notify(cb, 200, "撤消拉黑成功,player_id: " .. friend_player_id)
      else
        local code, message = ...
        Utils.notify(cb, -1, "撤消拉黑失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.accept_friend_apply(params, cb)
  local player_id = params.player_id
  local rtype = params.rtype
  if player_id and string.len(player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.rtype = nil
    FRIEND.accept_friend_apply_v2(player_id, rtype, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "接入好友申请成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "接入好友申请失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.refuse_friend_apply(params, cb)
  local player_id = params.player_id
  local rtype = params.rtype
  if player_id and string.len(player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.rtype = nil
    FRIEND.refuse_friend_apply_v2(player_id, rtype, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "拒绝好友申请成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "拒绝好友申请失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.del_friend_apply(params, cb)
  local player_id = params.player_id
  local rtype = params.rtype
  if player_id and string.len(player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.rtype = nil
    FRIEND.del_friend_apply_v2(player_id, rtype, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "删除好友申请成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "删除好友申请失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.add_friend(params, cb)
  local player_id = params.player_id
  local apply_text = params.apply_text or ""
  local rtype = params.rtype
  if player_id and string.len(player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.apply_text = nil
    ext.rtype = nil
    FRIEND.add_friend_apply_v2(player_id, apply_text, rtype, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "添加好友申请成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "添加好友申请失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.follow_player(params, cb)
  local player_id = params.player_id
  local follow_type = params.follow_type
  if player_id and string.len(player_id) > 0 then
    local ext = EU.deepcopy(params)
    ext.player_id = nil
    ext.follow_type = nil
    FRIEND.add_follow_v2(player_id, follow_type, ext, function(success, ...)
      if success then
        Utils.notify(cb, 200, "关注好友成功")
      else
        local code, message = ...
        Utils.notify(cb, -1, "关注好友失败, code: " .. code .. " ,msg: " .. message)
      end
    end)
  end
end

function M.msg_new_friend_apply(apply_msgs)
  if apply_msgs then
    notify_native(MSG_TYPE.NEW_FRIENT_APPLY, apply_msgs)
  else
    E.log("msg_new_friend_apply 数据有问题")
  end
end

function M.msg_del_friend(del_msgs)
  for _, msg in pairs(del_msgs) do
    local player = msg.player
    E.log("demonk, del friend: " .. player)
  end
end

function M.msg_add_friend(add_msgs)
  for _, msg in pairs(add_msgs) do
    local player = msg.player
    E.log("demonk, add friend: " .. player)
  end
end

function M.msg_friend_info_change(_change_msgs)
end

return M
