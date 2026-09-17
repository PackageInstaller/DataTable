local this = {
  channelType = 0,
  channelConversation = nil,
  channelId = -1,
  chatCDTimer = nil,
  channelChatCD = 0,
  channelChatTimeCountCallback = nil,
  channelChatTimeEndCallback = nil,
  channelGetNewMessage = false
}

function this:init(channelType, channelDataList)
  self.channelType = channelType
  self.channelConversation = require(L_R.store .. "chat.data.conversation").new()
  self.channelId = -1
  self.chatCDTimer = nil
  self.channelChatCD = 0
  self.channelChatTimeCountCallback = nil
  self.channelChatTimeEndCallback = nil
  self.channelGetNewMessage = false
  if channelDataList then
    channelDataList[self.channelType] = self
  end
end

function this:getRefreshEventId()
  return nil
end

function this:getRedDotEnum()
  return nil
end

function this:getChannelConversation()
  return self.channelConversation
end

function this:InitChatCD()
  self.channelChatCD = self:getFinalChannelChatCD()
  
  local function refreshChatCDFunc()
    self.channelChatCD = self.channelChatCD - 1
    if self.channelChatTimeCountCallback then
      self.channelChatTimeCountCallback(self.channelChatCD)
    end
    if self.channelChatCD <= 0 then
      self:resetChatCD()
      if self.channelChatTimeEndCallback then
        self.channelChatTimeEndCallback()
      end
      return
    end
  end
  
  if not self.chatCDTimer then
    self.chatCDTimer = Timer.repeated(1, function()
      refreshChatCDFunc()
    end, self)
  end
end

function this:getFinalChannelChatCD()
  if self:isNeedCheckFreq() then
    local chatCD = L_ChatStore:checkChatFreqLimit(self.channelConversation)
    if chatCD <= 0 then
      chatCD = self:getInitChannelChatCD() or 0
    end
    return chatCD
  end
  return self:getInitChannelChatCD()
end

function this:getInitChannelChatCD()
  return L_GameTpl:getGameConstTpl():getWorldChatCD()
end

function this:getCurrentChannelId()
  return self.channelId
end

function this:getChannelActive()
  return true
end

function this:getChannelChatCD()
  return self.channelChatCD
end

function this:resetChatCD()
  if self.chatCDTimer then
    Timer.remove(self.chatCDTimer)
    self.chatCDTimer = nil
  end
  self.channelChatCD = 0
end

function this:setChannelChatTimeCountCallback(callback)
  self.channelChatTimeCountCallback = callback
end

function this:setChannelChatTimeEndCallback(callback)
  self.channelChatTimeEndCallback = callback
end

function this:updateChannelGetNewMessage(isNew)
  self.channelGetNewMessage = isNew
  local redDotEnum = self:getRedDotEnum()
  if redDotEnum then
    L_ReddotManager._dirtyList[redDotEnum] = true
  end
end

function this:getChannelGetNewMessage()
  return self.channelGetNewMessage
end

function this:onRoomSync(sysId)
  self.channelId = sysId
  self.channelConversation:clear()
  local refreshEventId = self:getRefreshEventId()
  if refreshEventId then
    L_ChatStore:call(refreshEventId)
  end
end

function this:getChannelChatMaxLimit()
  return L_GameTpl:getGameConstTpl():getWorldChannelChatMaxLimit()
end

function this:isNeedCheckFreq()
  return false
end

function this:isNeedCheckSpam()
  return false
end

function this:syncChannelConversation(chat)
  local entity = self.channelConversation
  local entityMsg = require(L_R.store .. "chat.data.chatMessage").new()
  entityMsg.player_id = chat.player_id
  entityMsg.msg = chat.msg
  entityMsg.time = chat.time
  entityMsg.type = chat.type
  entityMsg.extra_info = chat.extra_info
  entityMsg.bubbleConfigId = chat.bubbleId
  entityMsg.order = chat.order
  local baseInfo = chat.player_id == L_PlayerStore:getPlayerId() and require(L_R.store .. "player.data.playerBaseInfo").new() or L_FriendStore:getPlayerBaseInfo(chat.player_id, true)
  table.merge(baseInfo, chat.basic_info)
  entityMsg.baseInfo = baseInfo
  table.insert(entity.chats, entityMsg)
  self:updateChannelGetNewMessage(true)
  if #entity.chats > self:getChannelChatMaxLimit() then
    table.remove(entity.chats, 1)
  end
  table.sort(entity.chats, function(a, b)
    return a.time < b.time
  end)
  if self:isNeedCheckFreq() or self:isNeedCheckSpam() then
    self:recordMyConversionTime(entityMsg)
    self:recordMyConversionMessage(entityMsg)
  end
  L_ChatStore:call(L_ChatStore.event.refreshChannelConversationList, {
    type = self.channelType,
    chat = entityMsg
  })
end

function this:recordMyConversionTime(entityMsg)
  if entityMsg.player_id ~= L_PlayerStore:getPlayerId() then
    return
  end
  local chatTimes = self.channelConversation.chatTimes
  local chatLimit = L_GameTpl:getGameConstTpl():getChatFreqLimit()
  local chatLimit1 = chatLimit[1]
  if chatLimit1 <= #chatTimes then
    table.remove(chatTimes, 1)
  end
  table.insert(chatTimes, entityMsg.time)
end

function this:recordMyConversionMessage(entityMsg)
  if entityMsg.player_id ~= L_PlayerStore:getPlayerId() then
    return
  end
  local chatMessages = self.channelConversation.chatMessages
  local chatSpamParam = L_GameTpl:getGameConstTpl():getChatSpamParam()
  local paramX = chatSpamParam[1][1]
  local paramU = chatSpamParam[2][1]
  if #chatMessages >= math.max(paramX, paramU) then
    table.remove(chatMessages, 1)
  end
  table.insert(chatMessages, {
    msg = entityMsg.msg,
    type = entityMsg.type
  })
end

return this
