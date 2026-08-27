local HomeChatDataCenter = class("HomeChatDataCenter")
local HomeChatData = require("Game.Chat.HomeChatData")

function HomeChatDataCenter:ctor()
  self.curChannel = nil
  self.homeChatDatalist = {}
  self.newChatDataNum = 0
  self.curCDLevel = 0
  self.sendCd = 0
  self.OnCdChangeCallbackDic = {}
  self.lastSendTimeStamp = nil
  self.lastSendN = nil
  self.lastSenderMsg = nil
  self.lastInputMsg = nil
  self.MAX_CHATDATA_NUM = ConfigData.game_config.chatListMaxDataNum
  self.MAX_INPUT_LENGTH = ConfigData.game_config.chatMessageLength
  self.MAX_SAME_MESSAGE = ConfigData.game_config.chatMatchSameMessage
end

function HomeChatDataCenter:AddNewChatData(chatData)
  local removeNum = 0
  if #self.homeChatDatalist >= self.MAX_CHATDATA_NUM then
    removeNum = 1
    table.remove(self.homeChatDatalist, 1)
  end
  self.newChatDataNum = self.newChatDataNum + 1
  table.insert(self.homeChatDatalist, chatData)
  MsgCenter:Broadcast(eMsgEventId.OnNewWordChatDataCome, removeNum)
end

function HomeChatDataCenter:AddOnSendCdChangeCallback(callback)
  self.OnCdChangeCallbackDic[callback] = true
end

function HomeChatDataCenter:SetCurChannel(channel)
  self.curChannel = channel
end

function HomeChatDataCenter:SetLastInputMsg(string)
  self.lastInputMsg = string
end

function HomeChatDataCenter:GetChatDataAtIndex(index)
  if index <= 0 or index > #self.homeChatDatalist then
    return nil
  end
  return self.homeChatDatalist[index]
end

function HomeChatDataCenter:GetCurDataCount()
  return #self.homeChatDatalist
end

function HomeChatDataCenter:GetLatestChatData()
  local index = self:GetCurDataCount()
  return self:GetChatDataAtIndex(index)
end

function HomeChatDataCenter:GetNewChatNum()
  return self.newChatDataNum
end

function HomeChatDataCenter:GetSendCd()
  return math.ceil(self.sendCd or 0)
end

function HomeChatDataCenter:GetLastInputMsg(string)
  self.lastInputMsg = string
end

function HomeChatDataCenter:RemoveOnSendCdChangeCallback(callback)
  self.OnCdChangeCallbackDic[callback] = nil
end

function HomeChatDataCenter:CleanNewChatNum()
  self.newChatDataNum = 0
end

function HomeChatDataCenter:CleanAllChatData()
  self.homeChatDatalist = {}
  self.newChatDataNum = 0
end

function HomeChatDataCenter:ValidInputChange(str)
  if string.len(str) > self.MAX_INPUT_LENGTH then
    return false, string.sub(str, 1, self.MAX_INPUT_LENGTH)
  end
  return true, str
end

function HomeChatDataCenter:ValidSendChat(str)
  str = string.trim(str)
  if string.len(str) <= 0 then
    return false
  end
  return true
end

function HomeChatDataCenter:ValidSendTime()
  if self.sendCd ~= nil and self.sendCd > 0 then
    return false
  end
  local now = PlayerDataCenter.timestamp
  local cdChatNum = 0
  local cdTimeSpace = 0
  for level, cfg in ipairs(ConfigData.chat_cd) do
    if level > self.curCDLevel or level == #ConfigData.chat_cd then
      cdChatNum = cfg.message
      cdTimeSpace = cfg.time
      break
    end
  end
  self.lastSendN = (self.lastSendN or 0) + 1
  if self.lastSendN == 1 then
    self.lastSendTimeStamp = now
  end
  if cdChatNum <= self.lastSendN then
    if cdTimeSpace > now - self.lastSendTimeStamp then
      self.lastSendN = 0
      if self.curCDLevel + 1 < #ConfigData.chat_cd then
        self.curCDLevel = self.curCDLevel + 1
      end
      self.sendCd = math.ceil(cdTimeSpace - (now - self.lastSendTimeStamp))
      self.lastSendTimeStamp = now
      self:StartChatCDTimer()
    else
      self.curCDLevel = 0
      self.lastSendTimeStamp = now
      self.lastSendN = 0
    end
  end
  return true
end

function HomeChatDataCenter:StartChatCDTimer()
  TimerManager:StopTimer(self.timerId)
  self.timerId = TimerManager:StartTimer(1, function()
    for callback, _ in pairs(self.OnCdChangeCallbackDic) do
      self.sendCd = self.sendCd - 1
      callback(self.sendCd)
      if self.sendCd <= 0 then
        self.sendCd = nil
        TimerManager:StopTimer(self.timerId)
      end
    end
  end, self, false, false, false)
end

function HomeChatDataCenter:Delete()
  TimerManager:StopTimer(self.timerId)
end

return HomeChatDataCenter
