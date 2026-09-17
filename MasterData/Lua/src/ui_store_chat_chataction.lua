local this = {}
local emojiTpl = L_GameTpl:getChatEmojiTpl()

function this:req_getChatInfo(playerId, callback)
  local conversation = self:getConversation(playerId)
  if self:getIsQeqChatInfo(conversation) then
    if callback then
      callback()
    end
    return
  end
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  local data = {id = playerId}
  L_Net:sendMessage(MsgGenCode.CSProtoChatInfoSync, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local entity = self:getConversation(playerId)
      entity.hasReqChat = true
      self:syncConversation(rspData)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_sendChatInfo(Id, chatType, messageType, message, tarBlock, callback, extraInfo)
  if tarBlock == nil then
    tarBlock = false
  end
  if self:checkChatSpamLimit(chatType, message, messageType, Id) then
    if callback then
      callback()
    end
    return
  end
  if chatType == L_Const.chatType.city then
    chatType = L_Const.chatType.map
  end
  local bubbleConfigId = AzurWorld.ChatMgr:GetByChatBubbleId()
  local data = {
    target = {
      tid = Id,
      chat_type = chatType,
      shield = tarBlock
    },
    msg = message,
    extra_info = extraInfo,
    type = messageType,
    bubbleId = bubbleConfigId,
    language = self:getCurLang()
  }
  L_Net:sendMessage(MsgGenCode.CSProtoAddChat, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeDirtyWord then
      L_FlyMsgManager:showNormalMsgByKey("tips_chat_illegal_message")
    elseif errorCode == L_Const.errorCode.ErrCodeBan then
      local sysBanTime = rspData.ban_time
      local banTime = L_TimeUtil.getDisplayTime(sysBanTime, L_TimeUtil.TimeFormat.YMD_HM)
      local banMsg = L_WordsTpl:getValue("chatmute_toast", {
        [0] = banTime
      })
      L_FlyMsgManager:showNormalMsg(banMsg)
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_chat_5"))
    end
  end)
end

function this:req_multiChatInfo(Id, chatType, messageType, extraInfo, message)
  if L_ChatStore:getWorldChannelChatCD() > 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_cd", {
      [0] = L_ChatStore:getWorldChannelChatCD()
    }))
    return
  end
  
  local function callback()
    local chatData = L_ChatStore:getChannelData(chatType)
    chatData:InitChatCD()
    self:call(self.event.refreshWorldChannelCD)
  end
  
  local function req()
    self:req_sendChatInfo(Id, chatType, messageType, message, false, callback, extraInfo)
  end
  
  self.data.worldChannelTeamReq = req
end

function this:req_deleteChatConversation(playerId, callback)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  local data = {id = playerId}
  L_Net:sendMessage(MsgGenCode.CSProtoDelFriendChat, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_readChatInfo(playerId, callback)
  local conversation = self:getConversation(playerId)
  if self:getUnreadMessageNum(conversation) <= 0 then
    self:clearUnreadNum(playerId)
    return
  end
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  local data = {id = playerId}
  L_Net:sendMessage(MsgGenCode.CSProtoReadFriendChat, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:clearUnreadNum(playerId)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_createConversation(playerId, callback)
  local baseInfo = L_FriendStore:getPlayerBaseInfo(playerId)
  local data = {id = playerId}
  L_Net:sendMessage(MsgGenCode.CSProtoCreateFriendChat, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:syncConversationUpgrade(playerId, rspData.upgrade)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_shieldChat(playerId, callback)
  local data = {friend_id = playerId, bShield = true}
  L_Net:sendMessage(MsgGenCode.CSProtoFriendShield, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), playerId)
      friend.isShield = true
      self:call(self.event.refreshChatShield)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_unmaskChat(playerId, callback)
  local data = {friend_id = playerId, bShield = false}
  L_Net:sendMessage(MsgGenCode.CSProtoFriendShield, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.shieldList[playerId] = nil
      local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), playerId)
      friend.isShield = false
      self:call(self.event.refreshChatShield)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_collectChatEmojiChange(emojiIdList)
  local data = {u32s = emojiIdList}
  L_Net:sendMessage(MsgGenCode.CSProtoCollectChatEmojiChange, data, function(rspData, errorCode)
  end)
end

function this:req_collectChatEmojiDel(emojiCollectedIndexList)
  local data = {u32s = emojiCollectedIndexList}
  L_Net:sendMessage(MsgGenCode.CSProtoCollectChatEmojiDel, data, function(rspData, errorCode)
  end)
end

function this:req_chatWorldJoin(id, callback)
  local data = {sysId = id}
  L_Net:sendMessage(MsgGenCode.CSProtoChatWorldJoin, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeChatRoomFull then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("tips_chat_channelfull"))
    end
  end)
end

function this:req_chatWorldMaxNum(callback)
  local data = {
    chat_type = L_Const.chatType.world
  }
  L_Net:sendMessage(MsgGenCode.CSProtoChatRoomNum, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData.count)
    end
  end)
end

function this:req_allFriendConversation(playerIds, callback)
  local data = {pids = playerIds}
  L_Net:sendMessage(MsgGenCode.CSProtoChatSyncNew, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData.chat_infos)
    end
  end)
end

function this:req_chatIsolateList()
  L_Net:sendMessage(MsgGenCode.CSProtoChatGetIsolateList, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:initIsolateLangs(rspData)
    end
  end)
end

function this:rsp_syncConversationMsgNum(list)
  for _, v in ipairs(list) do
    local entity = self:getConversation(v)
    if entity then
      entity.num = v.cnt
    end
  end
  self:call(self.event.refreshConversationList)
end

function this:rsp_syncConversationList(data)
  for i, v in pairs(data) do
    self:syncConversation(v)
  end
end

function this:syncConversation(data)
  local entity = self:getConversation(data.id, true)
  local chats = entity.chats
  table.merge(entity, data)
  entity.chats = chats
  if table.isEmpty(data.chats) then
    return
  end
  for i, v in pairs(data.chats) do
    if self:checkMsgIsValid(v) then
      local entityMsg = require(L_R.store .. "chat.data.chatMessage").new()
      entityMsg.player_id = v.player_id
      entityMsg.msg = v.msg
      entityMsg.time = v.time
      entityMsg.type = v.type
      entityMsg.bubbleConfigId = v.bubbleId
      entityMsg.order = v.order
      table.insert(entity.chats, entityMsg)
      entity.currentOrder = v.order
    end
  end
  table.sort(entity.chats, function(a, b)
    return a.time < b.time
  end)
end

function this:rsp_syncConversationMessage(data)
  if data.target.chat_type == L_Const.chatType.map and data.target.tid >= 4.294967296E9 then
    data.target.chat_type = L_Const.chatType.city
  end
  if L_ChatStore:checkMsgIsForbid(data.chat.player_id) then
    return
  end
  if L_ChatStore:checkMsgLangIsForbid(data) then
    return
  end
  if data.target.chat_type == L_Const.chatType.personal then
    self:syncFriendConversation(data)
  else
    self:syncChannelConversation(data.target.chat_type, data.chat)
  end
end

function this:rsp_syncShieldList(data)
  for i, v in pairs(data) do
    self.data.shieldList[v] = v
  end
end

function this:rsp_unmarkChat(data)
  self.data.shieldList[data.del] = nil
end

function this:rsp_chatEmojiSync(data)
  local bags = data.bags or {}
  local collects = data.collects or {}
  local lateLy = data.lately_collects or {}
  for _, chatEmojiInfo in pairs(bags) do
    local emojiId = chatEmojiInfo.id
    local tpl = emojiTpl:getTplById(emojiId)
    if tpl then
      local emojiGroupId = tpl.groupId
      self.data.emojiOwnedDic[emojiGroupId] = self.data.emojiOwnedDic[emojiGroupId] or {}
      if not table.containsValue(self.data.emojiOwnedDic[emojiGroupId], emojiId) then
        table.insert(self.data.emojiOwnedDic[emojiGroupId], emojiId)
      end
    else
      warn("聊天表情同步：客户端中不存在的配置id:" .. emojiId)
    end
  end
  table.clear(self.data.emojiCollectedList)
  for _, emojiId in pairs(collects) do
    table.insert(self.data.emojiCollectedList, emojiId)
  end
  for _, tmpTable in pairs(self.data.emojiOwnedDic) do
    table.sort(tmpTable, function(left, right)
      return left < right
    end)
  end
  table.clear(self.data.inRecentlyEmotionList)
  for _, emojiId in pairs(lateLy) do
    local tpl = emojiTpl:getTplById(emojiId)
    if tpl then
      table.insert(self.data.inRecentlyEmotionList, emojiId)
    else
      warn("聊天表情同步：客户端中不存在的配置id:" .. emojiId)
    end
  end
  self:call(self.event.refreshEmojiInfo)
end

function this:syncConversationUpgrade(uid, time)
  local entity = self:getConversation(uid, true)
  entity.upgrade = time
  self:call(self.event.refreshConversationList)
end

function this:syncFriendConversation(data)
  if not L_FriendStore:getIsFriend(data.target.tid) then
    return
  end
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), data.target.tid)
  local isShield = L_FriendStore:getIsBlockChatList(data.oppositePlayerId)
  if isShield then
    return
  end
  local entity = self:getConversation(data.target.tid, true)
  local msgEntity = require(L_R.store .. "chat.data.chatMessage").new()
  msgEntity.player_id = data.chat.player_id
  msgEntity.msg = data.chat.msg
  msgEntity.time = data.chat.time
  msgEntity.type = data.chat.type
  msgEntity.bubbleConfigId = data.chat.bubbleId
  msgEntity.order = data.chat.order
  table.insert(entity.chats, msgEntity)
  entity.currentOrder = data.chat.order
  entity.upgrade = data.upgrade
  if msgEntity.player_id ~= L_PlayerStore:getPlayerId() then
    entity.num = entity.num + 1
    L_AudioUtil.playSound("Play_SFX_System_FB_Chat_Message_Receive")
  end
  local isLocalSender = data.chat.player_id == L_PlayerStore:getPlayerId()
  local baseInfo = L_FriendStore:getPlayerBaseInfo(data.target.tid)
  self:call(self.event.refreshMessage, {
    oppositePlayerId = data.target.tid,
    chat = msgEntity
  })
  if not isLocalSender then
    L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
  end
  L_ChatManager:addPrivateMessages(isLocalSender, L_PlayerStore:getPlayerId(), data.target.tid, data.chat.msg, data.chat.type, data.chat.time, data.chat.order, baseInfo.name, baseInfo.lv, baseInfo.preffix_title, baseInfo.suffix_title, baseInfo.stand_plates.profile_frame, baseInfo.little_avatar, msgEntity.bubbleConfigId)
end

function this:syncChannelConversation(chatType, chat)
  local channelData = self:getChannelData(chatType)
  channelData:syncChannelConversation(chat)
end

function this:rsp_chatRoomSync(data)
  local channelData = self:getChannelData(data.chat_type)
  if channelData then
    channelData:onRoomSync(data.sysId)
  end
end

function this:rsp_chatIsolateListSync(data)
  self:initIsolateLangs(data)
end

return this
