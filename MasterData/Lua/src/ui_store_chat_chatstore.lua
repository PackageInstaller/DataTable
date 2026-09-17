local this = class("chatStore", G_BaseStore)
this.event = {
  refreshMessage = "chatStore_refreshMessage",
  refreshConversationList = "chatStore_refreshConversationList",
  refreshChatShield = "chatStore_refreshChatShield",
  deleteConversation = "chatStore_deleteConversation",
  refreshMeetingMessage = "chatStore_refreshMeetingMessage",
  clearUnreadNum = "chatStore_clearUnreadNum",
  clearMeetingUnreadNum = "chatStore_clearMeetingUnreadNum",
  refreshEmojiInfo = "chatStore_refreshEmojiInfo",
  refreshEmojiRedDot = "chatStore_refreshEmojiRedDot",
  refreshChannelConversationList = "chatStore_refreshChannelConversationList",
  refreshCurrentWorldChannelId = "chatStore_refreshCurrentWorldChannelId",
  refreshCurrentTeamChannelId = "chatStore_refreshCurrentTeamChannelId",
  refreshCurrentCityChannelId = "chatStore_refreshCurrentCityChannelId",
  refreshCurrentPartyChannelId = "chatStore_refreshCurrentPartyChannelId",
  refreshChatMessageBubbleOrBg = "chatStore_refreshChatMessageBubbleOrBg",
  refreshWorldChannelCD = "chatStore_refreshWorldChannelCD"
}
this:importPartialClass(require(L_R.store .. "chat.chatState"))
this:importPartialClass(require(L_R.store .. "chat.chatAction"))

function this:clearUnreadNum(playerUid)
  local conversation = self:getConversation(playerUid)
  conversation.num = 0
  self:call(self.event.clearUnreadNum, playerUid)
end

function this:checkMsgIsValid(chat)
  if chat.type == L_Const.ChatInfoType.CHAT_NORMAL then
  elseif chat.type == L_Const.ChatInfoType.CHAT_EMOJI then
    local chatEmojiTpl = L_GameTpl:getChatEmojiTpl()
    local tpl = chatEmojiTpl:getTplById(tonumber(chat.msg))
    return not table.isEmpty(tpl)
  elseif chat.type == L_Const.ChatInfoType.CHAT_COMMON then
    local chatQuickTpl = L_GameTpl:getChatQuickTpl()
    local tpl = chatQuickTpl:getTplById(tonumber(chat.msg))
    return not table.isEmpty(tpl)
  end
  return true
end

function this:checkMsgIsForbid(player_id)
  return L_FriendStore:getIsBlockChatList(player_id) or L_FriendStore:getIsBlackList(player_id)
end

function this:checkMsgLangIsForbid(data)
  if (data.target.chat_type == L_Const.chatType.world or data.target.chat_type == L_Const.chatType.city) and data.chat.type == L_Const.ChatInfoType.CHAT_NORMAL then
    local curLang = self:getCurLang()
    local isolateLang = self.data.isolateLangs
    local chatLang = data.chat.language
    if isolateLang[curLang] or isolateLang[chatLang] then
      return curLang ~= chatLang
    end
  end
  return false
end

function this:clearChannelConversation(channelType)
  self:getChannelConversation(channelType):clear()
end

function this:clearPlayerChatRecord(playerId, callback)
  local function dataCallback()
    local conversationList = self:getConversationList()
    
    conversationList[playerId] = require(L_R.store .. "chat.data.conversation").new()
    L_ChatManager:deleteLocalMessages(L_PlayerStore:getPlayerId(), playerId)
    if callback then
      callback()
    end
  end
  
  L_ChatStore:req_deleteChatConversation(playerId, dataCallback)
end

function this:deletePlayerChatRecord(playerId, callback)
  local function dataCallback()
    local conversationList = self:getConversationList()
    
    conversationList[playerId] = nil
    L_ChatManager:deleteLocalMessages(L_PlayerStore:getPlayerId(), playerId)
    if callback then
      callback()
    end
  end
  
  L_ChatStore:req_deleteChatConversation(playerId, dataCallback)
end

function this:checkChatIsBan()
  local isBan = C_IntegrateMgr.SystemUnlockModule:getSystemIsBan(L_SystemConst.enum.onlyChat)
  if isBan then
    local banReason = C_IntegrateMgr.SystemUnlockModule:getSystemBanReason(L_SystemConst.enum.onlyChat)
    if not banReason or banReason == "" then
      local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
      local systemUnlock = systemUnlockTpl:getTplById(L_SystemConst.enum.chat)
      if systemUnlock then
        banReason = systemUnlockTpl:getGmCloseTips(systemUnlock)
      end
    end
    L_FlyMsgManager:showNormalMsg(banReason)
    return true
  end
  return false
end

function this:checkChatFreqLimit(conversation)
  local chatTimes = conversation.chatTimes
  local chatLimit = L_GameTpl:getGameConstTpl():getChatFreqLimit()
  local chatLimit1 = chatLimit[1]
  if chatLimit1 > #chatTimes then
    return 0
  end
  local chatLimit2 = chatLimit[2]
  if chatLimit2 < chatTimes[#chatTimes] - chatTimes[1] then
    return 0
  end
  local chatLimit3 = chatLimit[3]
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_chat_tips_speak_fast"))
  return chatLimit3
end

function this:checkChatIsSpam(message, type, conversation)
  if conversation.chatSpamLimit and L_TimeUtil.getServerTime() <= conversation.chatSpamLimitTime then
    return true
  end
  local chatMessages = conversation.chatMessages
  local chatSpamParam = L_GameTpl:getGameConstTpl():getChatSpamParam()
  local paramZ = chatSpamParam[1][3]
  if paramZ <= #chatMessages then
    local paramX = chatSpamParam[1][1]
    local paramY = chatSpamParam[1][2]
    local percent = paramY / 10000
    local count = 0
    local startIndex = math.max(1, #chatMessages - paramX + 1)
    for i = startIndex, #chatMessages do
      if chatMessages[i].type == type then
        if type == L_Const.ChatInfoType.CHAT_NORMAL then
          if percent <= self:checkTextSimilarity(chatMessages[i].msg, message) then
            count = count + 1
            if paramZ <= count then
              return true
            end
          end
        elseif chatMessages[i].msg == message then
          count = count + 1
          if paramZ <= count then
            return true
          end
        end
      end
    end
  end
  local paramV = chatSpamParam[2][2]
  local numberCount = self:extractNumbers(message)
  if paramV <= numberCount then
    local paramW = chatSpamParam[2][3] - 1
    if paramW <= #chatMessages then
      local count = 0
      local paramU = chatSpamParam[2][1] - 1
      local startIndex = math.max(1, #chatMessages - paramU + 1)
      for i = startIndex, #chatMessages do
        if chatMessages[i].type == L_Const.ChatInfoType.CHAT_NORMAL then
          local numberCount = self:extractNumbers(chatMessages[i].msg)
          if paramV <= numberCount then
            count = count + 1
            if paramW <= count then
              return true
            end
          end
        end
      end
    end
  end
  return false
end

function this:checkTextSimilarity(text1, text2)
  if text1 == "" or text2 == "" then
    return 0
  end
  if text1 == text2 then
    return 1
  end
  local len1 = string.len(text1)
  local len2 = string.len(text2)
  local dp = {}
  for i = 0, len1 do
    dp[i] = {}
    for j = 0, len2 do
      dp[i][j] = 0
    end
  end
  for i = 1, len1 do
    for j = 1, len2 do
      if text1:sub(i, i) == text2:sub(j, j) then
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = math.min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1
      end
    end
  end
  local distance = dp[len1][len2]
  local similarity = 1 - distance / math.max(len1, len2)
  return similarity
end

function this:extractNumbers(text)
  local pattern = "%d+"
  local count = 0
  for word in string.gmatch(text, pattern) do
    count = count + #word
  end
  return count
end

function this:checkChatSpamLimit(chatType, message, messageType, Id)
  local channelData = self:getChannelData(chatType)
  if channelData and channelData:isNeedCheckSpam() then
    local conversation = channelData.channelConversation
    if self:checkChatIsSpam(message, messageType, conversation) then
      channelData:syncChannelConversation({
        player_id = L_PlayerStore:getPlayerId(),
        msg = message,
        time = L_TimeUtil.getServerTime(),
        type = messageType
      })
      return true
    end
  end
  return false
end

return this
