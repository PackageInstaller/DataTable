local this = {}

function this:req_queryPlayerBaseInfo(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoPlayerInfo, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:syncPlayerBaseInfoList(rspData.player_infos)
    end
    if callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_operationPlayer(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoOpFriend, data, function(rspData, errorCode)
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_modifyFriendMark(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoChangeFriendRemark, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.friendList[data.id].mark = rspData.remark
      self:call(self.event.refreshIdList)
    end
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_reportOnPlayer(data, callback)
  if callback then
    callback(L_Const.errorCode.ErrCodeSucc)
  end
end

function this:req_blockPlayerChat(playerId, callback)
  local data = {
    tar_id = playerId,
    op = L_Const.friendOp.add
  }
  L_Net:sendMessage(MsgGenCode.CSProtoChatShieldOp, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:rspBlockChatPlayerList(rspData)
      L_ChatStore:call(L_ChatStore.event.refreshChatShield)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_unblockPlayerChat(playerId, callback)
  local data = {
    tar_id = playerId,
    op = L_Const.friendOp.delete
  }
  L_Net:sendMessage(MsgGenCode.CSProtoChatShieldOp, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:rspBlockChatPlayerList(rspData)
      L_ChatStore:call(L_ChatStore.event.refreshChatShield)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_blockChatPlayerList(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoChatGetShieldList, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:rspBlockChatPlayerList(rspData)
      if callback then
        callback()
      end
    end
  end)
end

function this:CSharpSetSyncPlayerBaseInfoList(callback)
  self.CSharpSyncPlayerBaseInfoCallBack = callback
end

function this:rsp_syncPlayerBaseInfos(data, errorCode)
  if self.CSharpSyncPlayerBaseInfoCallBack then
    self:syncPlayerBaseInfoList(data.player_infos)
    self.CSharpSyncPlayerBaseInfoCallBack()
    self.CSharpSyncPlayerBaseInfoCallBack = false
  end
end

function this:rsp_syncPlayerList(data)
  local listAll = data.info
  local friendList = listAll.friends
  local applicationList = listAll.apply
  local blackList = listAll.ban
  local recentTeamList = listAll.recent
  self.data.friendList = {}
  if friendList then
    for i, v in pairs(friendList) do
      local entity = self:getPlayerItem(self.data.friendList, v.id, true)
      entity.playerUid = v.id
      entity.mark = v.remark
      entity.time = v.time
      entity.isShield = v.is_shield
      entity.isTarShield = v.tar_shield
    end
  end
  self.data.friendApplicationList = {}
  if applicationList then
    for i, v in pairs(applicationList) do
      local entity = self:getPlayerItem(self.data.friendApplicationList, v.id, true)
      entity.playerUid = v.id
      entity.time = v.time
    end
    L_ReddotManager._dirtyList[L_ReddotManager.DotDef.Friend] = true
  end
  self.data.blackList = {}
  if blackList then
    for i, v in pairs(blackList) do
      local entity = self:getPlayerItem(self.data.blackList, v.id, true)
      entity.playerUid = v.id
      entity.time = v.time
    end
  end
  self.data.recentTeamList = {}
  if recentTeamList then
    for i, v in pairs(recentTeamList) do
      local entity = self:getPlayerItem(self.data.recentTeamList, v.id, true)
      entity.playerUid = v.id
      entity.time = v.time
    end
  end
  self:call(self.event.refreshIdList)
  self:req_blockChatPlayerList()
end

function this:rsp_friendIncChange(data)
  for _, v in ipairs(data.datalist) do
    if v.type & L_Const.FriendChangeType.Add2FriendList == L_Const.FriendChangeType.Add2FriendList then
      local entity = self:getPlayerItem(self.data.friendList, v.friendItem.id, true)
      entity.playerUid = v.friendItem.id
      entity.mark = v.friendItem.remark
      entity.time = v.friendItem.time
      entity.isShield = v.friendItem.is_shield
      entity.isTarShield = v.friendItem.tar_shield
    end
    if v.type & L_Const.FriendChangeType.Add2BlackList == L_Const.FriendChangeType.Add2BlackList then
      local entity = self:getPlayerItem(self.data.blackList, v.friendItem.id, true)
      entity.playerUid = v.friendItem.id
      entity.time = v.friendItem.time
      entity.isShield = v.friendItem.is_shield
      entity.isTarShield = v.friendItem.tar_shield
    end
    if v.type & L_Const.FriendChangeType.Add2ApplyList == L_Const.FriendChangeType.Add2ApplyList then
      local entity = self:getPlayerItem(self.data.friendApplicationList, v.friendItem.id, true)
      entity.playerUid = v.friendItem.id
      entity.time = v.friendItem.time
      entity.isShield = v.friendItem.is_shield
      entity.isTarShield = v.friendItem.tar_shield
      L_AudioUtil.playSound("Play_SFX_System_FB_Chat_Apply")
    end
    if v.type & L_Const.FriendChangeType.DelFromFriendList == L_Const.FriendChangeType.DelFromFriendList then
      self.data.friendList[v.friendItem.id] = nil
    end
    if v.type & L_Const.FriendChangeType.DelFromBlackList == L_Const.FriendChangeType.DelFromBlackList then
      self.data.blackList[v.friendItem.id] = nil
    end
    if v.type & L_Const.FriendChangeType.DelFromApplyList == L_Const.FriendChangeType.DelFromApplyList then
      self.data.friendApplicationList[v.friendItem.id] = nil
    end
    if v.type & L_Const.FriendChangeType.ClearApplyList == L_Const.FriendChangeType.ClearApplyList then
      self.data.friendApplicationList = {}
    end
  end
  self:call(self.event.refreshIdList)
end

function this:req_recommandFriend(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoFriendRecommend, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:syncRecommandFriendInfoList(rspData.player_infos)
    end
    if callback then
      callback(errorCode)
    end
  end)
end

function this:rsp_friendBlockNtf(data)
  local entity = self:getPlayerItem(self.data.friendList, self.data.friend_id)
  if entity then
    entity.isTarShield = data.bShield
  end
end

function this:syncPlayerBaseInfoList(data)
  if table.isEmpty(data) then
    return
  end
  for i, v in pairs(data) do
    local entity = self:getPlayerBaseInfo(v.id, true)
    table.merge(entity, v)
  end
end

function this:syncRecommandFriendInfoList(data)
  if table.isEmpty(data) then
    return
  end
  self:clearRecommandFriendList()
  for i, v in pairs(data) do
    if not L_FriendStore:getIsFriend(v.id) and not L_FriendStore:getPlayerItem(L_FriendStore:getBlackList(), v.id) then
      local entity = self:getRecommandFriendBaseInfo(v.id, true)
      table.merge(entity, v)
    end
  end
end

function this:rspBlockChatPlayerList(data)
  self.data.blockChatList = {}
  local blockPlayerList = data.items
  if blockPlayerList then
    for _, v in pairs(blockPlayerList) do
      local entity = self:getPlayerItem(self.data.blockChatList, v.pid, true)
      entity.playerUid = v.pid
      entity.time = v.time
    end
  end
end

return this
