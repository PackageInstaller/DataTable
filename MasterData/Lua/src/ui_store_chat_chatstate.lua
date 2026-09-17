local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    conversationList = {},
    currentChatFriendId = -1,
    shieldList = {},
    emojiOwnedDic = {},
    emojiCollectedList = {},
    inRecentlyEmotionList = {},
    channelDataList = {},
    partyFirstEnterChannel = -1,
    curLang = -1,
    isolateLangs = {},
    isolateLangList = {}
  }
  self:initChannelChatList()
end

function this:initChannelChatList()
  self.data.worldChannelData = require(L_R.store .. "chat.data.worldChannelData").new(self.data.channelDataList)
  self.data.teamChannelData = require(L_R.store .. "chat.data.teamChannelData").new(self.data.channelDataList)
  self.data.cityChannelData = require(L_R.store .. "chat.data.cityChannelData").new(self.data.channelDataList)
  self.data.partyChannelData = require(L_R.store .. "chat.data.partyChannelData").new(self.data.channelDataList)
end

function this:getConversationList()
  return self.data.conversationList
end

function this:getCurrentChatFriendId()
  return self.data.currentChatFriendId
end

function this:getShieldList()
  return self.data.shieldList
end

function this:getChannelData(channelType)
  return self.data.channelDataList[channelType]
end

function this:getChannelConversation(channelType)
  return self:getChannelData(channelType).channelConversation
end

function this:getChannelActive(channelType)
  local channelData = self:getChannelData(channelType)
  return channelData:getChannelActive()
end

function this:getEmojiOwnedDic()
  return self.data.emojiOwnedDic
end

function this:getEmojiCollectedList()
  return self.data.emojiCollectedList
end

function this:getEmojiRecentlyList()
  return self.data.inRecentlyEmotionList
end

function this:checkEmojiOwnedDic(emojiId)
  if self.data.emojiOwnedDic and emojiId then
    for type, list in pairs(self.data.emojiOwnedDic) do
      for i, id in ipairs(list) do
        if emojiId == id then
          return true
        end
      end
    end
    return false
  else
    return false
  end
end

function this:getConversation(playerUid, isCreate)
  local conversationList = self:getConversationList()
  local entity = conversationList[playerUid]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "chat.data.conversation").new()
    conversationList[playerUid] = entity
    entity.playerUid = playerUid
  end
  return entity
end

function this:getPlayerUid(conversation)
  return conversation.playerUid
end

function this:getUnreadMessageNum(conversation)
  return conversation.num
end

function this:getUpgradeTime(conversation)
  return conversation.upgrade
end

function this:getMessageList(conversation)
  return conversation.chats
end

function this:getIsQeqChatInfo(conversation)
  return conversation.hasReqChat
end

function this:getMessageMsg(message)
  return message.msg
end

function this:getMessageContent(message)
  if message.type == L_Const.ChatInfoType.CHAT_NORMAL then
    return message.msg
  elseif message.type == L_Const.ChatInfoType.CHAT_COMMON then
    local chatQuickTpl = L_GameTpl:getChatQuickTpl()
    local tpl = chatQuickTpl:getTplById(tonumber(message.msg))
    return chatQuickTpl:getWords(tpl)
  elseif message.type == L_Const.ChatInfoType.CHAT_EMOJI then
    local chatEmojiTpl = L_GameTpl:getChatEmojiTpl()
    local tpl = chatEmojiTpl:getTplById(tonumber(message.msg))
    return chatEmojiTpl:getResource(tpl)
  end
end

function this:getMessageTime(message)
  return message.time
end

function this:getMessageType(message)
  return message.type
end

function this:getIsMessageSendByMyself(message)
  return message.player_id == L_PlayerStore:getPlayerId()
end

function this:getMessageSender(message)
  return message.player_id
end

function this:getIsMessageFromMeeting(message)
  return message.isMeeting
end

function this:getMessageBubble(message)
  return message.bubbleConfigId
end

function this:getIsShieldChat(uid)
  local friend = L_FriendStore:getPlayerItem(L_FriendStore:getFriendList(), uid)
  if friend then
    return friend:getIsShield()
  end
  return self.data.shieldList[uid] ~= nil
end

function this:getAllUnReadNum()
  local conversation = self:getConversationList()
  local res = 0
  for i, v in pairs(conversation) do
    res = res + self:getUnreadMessageNum(v)
  end
  return res
end

function this:sendTeamMsg()
  if self.data.worldChannelTeamReq then
    self.data.worldChannelTeamReq()
    self.data.worldChannelTeamReq = nil
  end
end

function this:getWorldChannelChatCD()
  return self.data.worldChannelData:getChannelChatCD()
end

function this:getCurrentWorldChannelId()
  return self.data.worldChannelData:getCurrentChannelId()
end

function this:getCurSysLangId()
  local curLang = self:getCurSysLang()
  return self.data.isolateLangList[curLang] or 0
end

function this:getCurSysLang()
  local sysLang = CS.UnityEngine.Application.systemLanguage
  if sysLang == CS.UnityEngine.SystemLanguage.Chinese or sysLang == CS.UnityEngine.SystemLanguage.ChineseSimplified then
    return "chs"
  elseif sysLang == CS.UnityEngine.SystemLanguage.ChineseTraditional then
    return "cht"
  elseif sysLang == CS.UnityEngine.SystemLanguage.English then
    return "en"
  elseif sysLang == CS.UnityEngine.SystemLanguage.Japanese then
    return "jp"
  elseif sysLang == CS.UnityEngine.SystemLanguage.Korean then
    return "kr"
  else
    return "other"
  end
end

function this:getCurLang()
  if self.data.curLang < 0 then
    self.data.curLang = self:getCurSysLangId()
  end
  return self.data.curLang
end

function this:initIsolateLangs(data)
  local isolates = data.isolates
  local lists = data.lists
  self.data.isolateLangs = {}
  if isolates then
    for i, v in ipairs(isolates) do
      self.data.isolateLangs[v] = true
    end
  end
  self.data.isolateLangList = {}
  if lists then
    for i, v in ipairs(lists) do
      self.data.isolateLangList[v.lang] = v.id
    end
  end
  self.data.curLang = self:getCurSysLangId()
end

return this
