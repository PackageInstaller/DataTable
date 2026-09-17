local this = class("chatManager", G_EventManagerBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local CELL_TYPE = {
  text = 0,
  commonWords = 1,
  emotion = 2,
  time = 3,
  meeting = 4,
  multiInvite = 5,
  nestInvite = 6,
  multiMaterialInvite = 7,
  multiWeeklyInvite = 8
}
local CELL_OWNER = {me = 1, you = 2}
local CELL_PARAM = {
  [CELL_TYPE.text] = {
    moduleName = "pages/Chat/cellChatMessage",
    identify = {
      [CELL_OWNER.me] = "cellMessage",
      [CELL_OWNER.you] = "cellMessageOpposite"
    }
  },
  [CELL_TYPE.emotion] = {
    moduleName = "pages/Chat/cellChatEmotion",
    identify = {
      [CELL_OWNER.me] = "cellMessageEmotion",
      [CELL_OWNER.you] = "cellMessageEmotionOpposite"
    }
  },
  [CELL_TYPE.commonWords] = {
    moduleName = "pages/Chat/cellChatMessage",
    identify = {
      [CELL_OWNER.me] = "cellMessage",
      [CELL_OWNER.you] = "cellMessageOpposite"
    }
  },
  [CELL_TYPE.time] = {
    moduleName = "pages/Chat/cellChatTime",
    identify = "cellMessageTime"
  },
  [CELL_TYPE.meeting] = {
    moduleName = "pages/Chat/cellChatTime",
    identify = "cellMessageMeeting"
  },
  [CELL_TYPE.multiInvite] = {
    moduleName = "pages/Chat/cellMessageMultiInvite",
    identify = {
      [CELL_OWNER.me] = "cellMessageMultiInvite",
      [CELL_OWNER.you] = "cellMessageMultiOpposite"
    }
  },
  [CELL_TYPE.nestInvite] = {
    moduleName = "pages/Chat/cellMessageMultiInvite",
    identify = {
      [CELL_OWNER.me] = "cellMessageNestInvite",
      [CELL_OWNER.you] = "cellMessageNestOpposite"
    }
  },
  [CELL_TYPE.multiMaterialInvite] = {
    moduleName = "pages/Chat/cellMessageMultiInvite",
    identify = {
      [CELL_OWNER.me] = "cellMessageMultiMaterial",
      [CELL_OWNER.you] = "cellMessageMultiMaterialOpposite"
    }
  },
  [CELL_TYPE.multiWeeklyInvite] = {
    moduleName = "pages/Chat/cellMessageMultiInvite",
    identify = {
      [CELL_OWNER.me] = "cellMessageMultiMaterial",
      [CELL_OWNER.you] = "cellMessageMultiMaterialOpposite"
    }
  }
}

function this:initialize()
  self.onReqPrivateChatHandler = self.onReqPrivateChatHandler or handler(self, self.OnReqPrivate)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.ScenePrepared, self.onReqPrivateChatHandler)
  C_WorldEvent.instance:Listen(C_EWorldEvent.MultiPlayerCityChange, self.multiPlayerCityChange)
  C_WorldEvent.instance:Listen(C_EWorldEvent.MultiPlayerCityLineChange, self.multiPlayerCityChange)
  self.lastReqPrivateTime = 0
end

function this:dispose()
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.ScenePrepared, self.onReqPrivateChatHandler)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.MultiPlayerCityChange, self.multiPlayerCityChange)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.MultiPlayerCityLineChange, self.multiPlayerCityChange)
end

function this:getChatPlayerInfo(callback)
  local chatType = self:getCurChatType()
  local players = {}
  local conversationList = L_ChatStore:getConversationList()
  for i, v in pairs(conversationList) do
    table.insert(players, L_ChatStore:getPlayerUid(v))
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_NAME,
    L_Const.PlayerBasicQueryType.PBQT_FACE_MINI
  }
  L_FriendManager:requestBaseInfo(types, players, function()
    callback()
  end)
end

function this:getCurChatType()
  local sceneModule = L_WorldManager:getCurModule()
  if sceneModule == L_Const.worldModule.meeting then
    return L_Const.chatType.meeting
  else
    return L_Const.chatType.personal
  end
end

function this:getConversationList()
  local chatType = self:getCurChatType()
  local res = {}
  if chatType == L_Const.chatType.meeting then
    table.insert(res, {
      conversationType = L_Const.chatType.meeting,
      serverData = L_ChatStore:getMeetingConversation()
    })
  end
  local tmp = {}
  local conversationList = L_ChatStore:getConversationList()
  for i, v in pairs(conversationList) do
    table.insert(tmp, {
      conversationType = L_Const.chatType.personal,
      serverData = v
    })
  end
  table.sort(tmp, function(a, b)
    return a.serverData.upgrade > b.serverData.upgrade
  end)
  return table.fill(res, tmp)
end

function this:parseMsg(message, baseInfo)
  if not baseInfo then
    return
  end
  local isSender = L_ChatStore:getIsMessageSendByMyself(message)
  local msg = {
    identify = CELL_PARAM[L_ChatStore:getMessageType(message)].identify[isSender and 1 or 2],
    moduleName = CELL_PARAM[L_ChatStore:getMessageType(message)].moduleName,
    serverData = message
  }
  if isSender then
    local playerbaseInfo = baseInfo
    msg.playerUid = L_PlayerStore:getPlayerId()
    msg.txt_name = L_PlayerStore:getPlayerName()
    msg.txt_level = tostring(L_FriendStore:getPlayerLevel(playerbaseInfo))
    msg.txt_title = L_FriendStore:ParsePlayerTitle(playerbaseInfo)
    msg.icon_frame = L_PlayerDisplayStore:loadHeadFrame(playerbaseInfo)
    msg.url_head = L_PlayerStore:getPlayerModHeadImgName()
    msg.is_sender = true
    msg.is_mark = false
  else
    local oppositeBaseInfo = baseInfo
    msg.playerUid = L_ChatStore:getMessageSender(message)
    local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), msg.playerUid)
    local isMark = friend and not string.isEmpty(friend:getFriendMark())
    msg.txt_name = isMark and friend:getFriendMark() or L_FriendStore:getPlayerName(oppositeBaseInfo)
    msg.txt_level = tostring(L_FriendStore:getPlayerLevel(oppositeBaseInfo))
    msg.txt_title = L_FriendStore:ParsePlayerTitle(oppositeBaseInfo)
    msg.icon_frame = L_PlayerDisplayStore:loadHeadFrame(oppositeBaseInfo)
    msg.url_head = L_FriendStore:getPlayerAvatarsHead(oppositeBaseInfo)
    msg.is_sender = false
    msg.is_mark = isMark
  end
  if L_ChatStore:getMessageType(message) == L_Const.ChatInfoType.CHAT_EMOJI then
    msg.emotionData = L_ChatStore:getMessageContent(message)
  else
    msg.txt_message = L_ChatStore:getMessageContent(message)
  end
  msg.bubbleConfigId = L_ChatStore:getMessageBubble(message)
  if L_ChatStore:getMessageType(message) == CELL_TYPE.multiInvite then
    local list = string.split(message.extra_info, ":")
    msg.multi_level = tonumber(list[1])
    msg.teamId = tonumber(list[2])
    local name = string.empty
    if 3 <= #list then
      name = list[3]
    end
    if 5 <= #list then
      msg.index = tonumber(list[5])
    end
    msg.type = CELL_TYPE.multiInvite
    msg.player_name = name
  end
  if L_ChatStore:getMessageType(message) == CELL_TYPE.nestInvite then
    local list = string.split(message.extra_info, ":")
    msg.multi_level = tonumber(list[1])
    msg.teamId = tonumber(list[2])
    local name = string.empty
    if 3 <= #list then
      name = list[3]
    end
    if 5 <= #list then
      msg.index = tonumber(list[5])
    end
    msg.type = CELL_TYPE.nestInvite
    msg.player_name = name
  end
  if L_ChatStore:getMessageType(message) == CELL_TYPE.multiMaterialInvite or L_ChatStore:getMessageType(message) == CELL_TYPE.multiWeeklyInvite then
    local list = string.split(message.extra_info, ":")
    msg.teamId = tonumber(list[1])
    msg.configId = tonumber(list[2])
    msg.type = L_ChatStore:getMessageType(message)
    msg.player_name = list[3]
    if 3 < #list then
      msg.campType = list[4]
    end
    if 4 < #list then
      msg.index = list[5]
    end
  end
  return msg
end

function this:parseTimeMsg(lastMessage, curMessage)
  local timeCur = L_ChatStore:getMessageTime(curMessage)
  local timeLast = lastMessage and L_ChatStore:getMessageTime(lastMessage) or 0
  if not timeCur or 300 < timeCur - timeLast then
    local msg = {
      identify = CELL_PARAM[CELL_TYPE.time].identify,
      moduleName = CELL_PARAM[CELL_TYPE.time].moduleName,
      txt_time = L_TimeUtil.getChatDisplayTime(timeCur)
    }
    return msg
  end
end

function this:parseSwitchMeetingMsg(lastMessage, curMessage)
  local timeCur = L_ChatStore:getMessageTime(curMessage)
  local timeLast = lastMessage and L_ChatStore:getMessageTime(lastMessage) or 0
  local record = L_ChatStore:getMeetingSwitchLineRecord()
  local res = {}
  for i, v in ipairs(record) do
    if timeLast < v.time and timeCur >= v.time then
      table.insert(res, self:generateSwitchMeetingMsg(v))
    end
  end
  return res
end

function this:generateSwitchMeetingMsg(record)
  local sceneName = _worldCityTpl:getCity(_worldCityTpl:getTplById(record.mapId))
  local data = {
    identify = CELL_PARAM[CELL_TYPE.meeting].identify,
    moduleName = CELL_PARAM[CELL_TYPE.meeting].moduleName,
    txt_time = L_WordsTpl:getValue("ui_chatManager", {
      [0] = sceneName,
      [1] = record.lineId
    })
  }
  return data
end

function this:OnReqPrivate(type, args)
  local currentTime = L_TimeUtil:getServerTime()
  if currentTime - self.lastReqPrivateTime < 1 then
    return
  end
  self.lastReqPrivateTime = currentTime
  L_ChatManager:getAllConversationMessages()
  L_ChatStore:req_chatIsolateList()
end

function this:getAllConversationMessages(callback)
  self:initChatMaxMessagesNum()
  local localPlayersIds = C_ChatUtility.GetLocalPrivateMessagePlayerId(L_PlayerStore:getPlayerId())
  local friends = L_FriendStore:getFriendList()
  local count = localPlayersIds.Count - 1
  local unFriendplayerIds = {}
  local friendplayerIds = {}
  local playerIds = {}
  for id, v in pairs(friends) do
    table.insert(friendplayerIds, id)
    table.insert(playerIds, id)
  end
  for i = 0, count do
    if not L_FriendStore:getIsFriend(localPlayersIds[i]) then
      table.insert(unFriendplayerIds, localPlayersIds[i])
      table.insert(playerIds, localPlayersIds[i])
    end
  end
  local types = {
    L_Const.PlayerBasicQueryType.PBQT_ALL
  }
  for _, playerId in ipairs(playerIds) do
    local localLastIndex = self:getLocalPrivateMessagesLastIndex(L_PlayerStore:getPlayerId(), playerId)
    if localLastIndex ~= -1 then
      local conversation = L_ChatStore:getConversation(playerId, true)
      self:CreatePlayerBaseInfoByLocalData(L_PlayerStore:getPlayerId(), playerId)
      if localLastIndex > conversation.lastOrder then
        local messageList = self:getLocalConversationMessages(L_PlayerStore:getPlayerId(), playerId)
        conversation.chats = messageList
        conversation.lastOrder = localLastIndex
        conversation.currentOrder = localLastIndex
      end
    end
  end
  if table.count(friendplayerIds) == 0 then
    return
  end
  L_FriendManager:requestBaseInfo(types, friendplayerIds, function()
    local function reqServerCallback(chatInfos)
      if not chatInfos then
        return
      end
      for i, chatInfo in pairs(chatInfos) do
        if not L_ChatStore:checkMsgIsForbid(chatInfo.id) then
          if chatInfo.chats and table.count(chatInfo.chats) > 0 then
            local conversation = L_ChatStore:getConversation(chatInfo.id, true)
            conversation.readedOrder = chatInfo.read_order
            local existOrderSet = {}
            for _, existMsg in ipairs(conversation.chats) do
              if existMsg.order and 0 < existMsg.order then
                existOrderSet[existMsg.order] = true
              end
            end
            for j, chat in pairs(chatInfo.chats) do
              if chat.order > conversation.lastOrder and not existOrderSet[chat.order] then
                local msgEntity = require(L_R.store .. "chat.data.chatMessage").new()
                msgEntity.player_id = chat.player_id
                msgEntity.msg = chat.msg
                msgEntity.time = chat.time
                msgEntity.type = chat.type
                msgEntity.bubbleConfigId = chat.bubbleId
                msgEntity.order = chat.order
                table.insert(conversation.chats, msgEntity)
                existOrderSet[chat.order] = true
                conversation.currentOrder = chat.order
                local isLocalSender = msgEntity.player_id == L_PlayerStore:getPlayerId()
                self:addPrivateMessagesWithoutSave(isLocalSender, L_PlayerStore:getPlayerId(), chatInfo.id, msgEntity.msg, msgEntity.type, msgEntity.time, chat.order, msgEntity.bubbleConfigId)
              end
            end
            table.sort(conversation.chats, function(a, b)
              return a.time < b.time
            end)
            local baseInfo = L_FriendStore:getPlayerBaseInfo(chatInfo.id)
            self:saveChatOppositeInfo(L_PlayerStore:getPlayerId(), chatInfo.id, baseInfo.name, baseInfo.lv, baseInfo.preffix_title, baseInfo.suffix_title, baseInfo.stand_plates.profile_frame, baseInfo.little_avatar)
            self:savePrivateMessagesByHand(L_PlayerStore:getPlayerId(), chatInfo.id)
          end
        else
          local conversation = L_ChatStore:getConversation(chatInfo.id, true)
          conversation.readedOrder = chatInfo.read_order
          conversation.currentOrder = chatInfo.read_order
        end
      end
      if callback then
        callback()
      end
      L_ReddotManager._dirtyList[L_ReddotManager.DotDef.FriendPrivateChat_Player] = true
    end
    
    L_ChatStore:req_allFriendConversation(friendplayerIds, reqServerCallback)
  end)
end

function this:CreatePlayerBaseInfoByLocalData(playerId, oppositeId)
  local entity = L_FriendStore:getPlayerBaseInfo(oppositeId, true)
  local chatOppositeInfo = C_ChatUtility.GetChatOppositeInfo(playerId, oppositeId)
  local playerbaseInfo = {
    id = oppositeId,
    name = chatOppositeInfo.name,
    lv = chatOppositeInfo.lv,
    preffix_title = chatOppositeInfo.preffix_title,
    suffix_title = chatOppositeInfo.suffix_title,
    little_avatar = chatOppositeInfo.little_avatar,
    stand_plates = {
      profile_frame = chatOppositeInfo.profile_frame
    }
  }
  table.merge(entity, playerbaseInfo)
end

function this:initChatMaxMessagesNum()
  C_ChatUtility.InitChatMaxMessagesNum(L_GameTpl:getGameConstTpl():getPlayerRecordMaxNum())
end

function this:deleteLocalMessages(playerId, oppositeId)
  C_ChatUtility.DeleteLocalMessages(playerId, oppositeId)
end

function this:saveChatOppositeInfo(playerId, oppositeId, name, lv, preffix_title, suffix_title, profile_frame, little_avatar)
  C_ChatUtility.SetChatOppositeInfo(playerId, oppositeId, name, lv, preffix_title, suffix_title, profile_frame, little_avatar)
end

function this:addPrivateMessagesWithoutSave(isLocalSender, playerId, oppositeId, msg, msgtype, timestamp, lastIndex, bubbleId)
  C_ChatUtility.AddPrivateArrayMessageWithoutSave(isLocalSender, playerId, oppositeId, msg, msgtype, timestamp, lastIndex, bubbleId)
end

function this:savePrivateMessagesByHand(playerId, oppositeId)
  C_ChatUtility.SavePrivateMessagesByHand(playerId, oppositeId)
end

function this:addPrivateMessages(isLocalSender, playerId, oppositeId, msg, msgtype, timestamp, lastIndex, name, lv, preffix_title, suffix_title, profile_frame, little_avatar, bubbleId)
  C_ChatUtility.AddPrivateMessage(isLocalSender, playerId, oppositeId, msg, msgtype, timestamp, lastIndex, name, lv, preffix_title, suffix_title, profile_frame, little_avatar, bubbleId)
end

function this:getLocalConversationMessages(playerId, oppositeId)
  local entityMsgList = {}
  local chatSession = C_ChatUtility.GetPrivateConversationMessages(tostring(playerId), tostring(oppositeId))
  local messages = chatSession.messages
  local count = messages.Count - 1
  for i = 0, count do
    local message = messages[i]
    local entityMsg = require(L_R.store .. "chat.data.chatMessage").new()
    entityMsg.player_id = message.playerUid
    entityMsg.msg = message.content
    entityMsg.type = message.type
    entityMsg.time = message.timestamp
    entityMsg.bubbleConfigId = message.bubbleId
    entityMsg.order = message.order
    table.insert(entityMsgList, entityMsg)
  end
  table.sort(entityMsgList, function(a, b)
    return a.time < b.time
  end)
  return entityMsgList
end

function this:getLocalPrivateMessagesLastIndex(playerId, oppositeId)
  local chatSession = C_ChatUtility.GetPrivateConversationMessages(playerId, oppositeId)
  return chatSession.lastIndex
end

function this:saveLocalPrivateMessageLastIndex(playerId, oppositeId, lastIndex)
  C_ChatUtility.SavePrivateMessagesLastIndex(playerId, oppositeId, lastIndex)
end

function this:multiPlayerCityChange()
  local chatData = L_ChatStore:getChannelData(L_Const.chatType.city)
  chatData:getChannelConversation():clear()
  chatData:resetChatCD()
  L_ChatStore:call(chatData:getRefreshEventId())
end

return this
