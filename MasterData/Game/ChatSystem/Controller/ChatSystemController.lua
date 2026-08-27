local ChatSystemController = class("ChatSystemController", ControllerBase)
local base = ControllerBase
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")
local CS_MessageCommon = CS.MessageCommon
local CS_ClientConsts = CS.ClientConsts
local newLine = CS.System.Environment.NewLine
local patternString = "[ \t]"
local emptyString = ""

function ChatSystemController:OnInit()
  self._dataDic = {}
  self._net = NetworkManager:GetNetwork(NetworkTypeID.ChatSystem)
  self.__OnEmojiItemUpdate = BindCallback(self, self.OnEmojiItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnEmojiItemUpdate)
  self.isForceBlocked = false
  self.rudeMsgCount = 0
end

function ChatSystemController:GetIsChatSystemCanShow()
  if CS_ClientConsts.IsAudit then
    return false
  end
  return true
end

function ChatSystemController:GetIsChatSystemUnlock()
  if CS_ClientConsts.IsAudit then
    return false
  end
  local openCfg = ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_newchat]
  if self.isForceBlocked or openCfg ~= nil and openCfg.screening then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6103))
    return false
  end
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_newchat)
  if not isUnlock then
    local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_newchat)
    CS_MessageCommon.ShowMessageTips(unlockDes)
    return false
  end
  return true
end

function ChatSystemController:GetIsChatSystemForceBlocked()
  return self.isForceBlocked
end

function ChatSystemController:SetIsChatSystemBan(isChatBan)
  self.isForceBlocked = isChatBan == true
  MsgCenter:Broadcast(eMsgEventId.OnChatSystemBanChange, self.isForceBlocked)
end

function ChatSystemController:SetRudeMsgCount(isAdd)
  if isAdd then
    self.rudeMsgCount = self.rudeMsgCount + 1
    if self.rudeMsgCount >= self:GetChatSystemMainCfg().speak_warning then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6116))
    end
  else
    self.rudeMsgCount = 0
  end
end

function ChatSystemController:InitChatSystemEmojiData()
  self.chatSystemEmojiDic = {}
  for emojiId, emojiCfg in pairs(ConfigData.new_chat_emoticon) do
    if PlayerDataCenter:GetItemCount(emojiId) > 0 or emojiCfg.locked then
      self:__InsertEmoji(emojiCfg.series_id, emojiId)
    end
  end
  self.chatSystemEmojiPageIds = {}
  for seriesId, _ in pairs(ConfigData.new_chat_emoticon_series) do
    table.insert(self.chatSystemEmojiPageIds, seriesId)
  end
  table.sort(self.chatSystemEmojiPageIds)
  for _, seriesId in ipairs(self.chatSystemEmojiPageIds) do
    if self.chatSystemEmojiDic[seriesId] ~= nil then
      table.sort(self.chatSystemEmojiDic[seriesId])
    end
  end
  self.prefSendMsgTime = 0
  self.speakCd = self:GetChatSystemMainCfg().speak_cd
end

function ChatSystemController:OnEmojiItemUpdate(itemUpdateDic)
  for itemId, itemCfg in pairs(itemUpdateDic) do
    local emojiCfg = ConfigData.new_chat_emoticon[itemId]
    if emojiCfg ~= nil then
      self:__InsertEmoji(emojiCfg.series_id, itemId)
      table.sort(self.chatSystemEmojiDic[emojiCfg.series_id])
    end
  end
end

function ChatSystemController:__InsertEmoji(seriesId, emojiId)
  self.chatSystemEmojiDic[seriesId] = self.chatSystemEmojiDic[seriesId] or {}
  table.insert(self.chatSystemEmojiDic[seriesId], emojiId)
end

function ChatSystemController:GetEmojiCfg(emojiId)
  local emojiCfg = ConfigData.new_chat_emoticon[emojiId]
  if emojiCfg == nil then
    return nil
  end
  return emojiCfg
end

function ChatSystemController:GetIsHasEmoji(emojiId)
  local emojiCfg = ConfigData.new_chat_emoticon[emojiId]
  if emojiCfg == nil or self.chatSystemEmojiDic[emojiCfg.series_id] == nil then
    return false
  end
  for index, id in ipairs(self.chatSystemEmojiDic[emojiCfg.series_id]) do
    if id == emojiId then
      return true, index
    end
  end
  return false
end

function ChatSystemController:GetChatSystemEmojiPageIds()
  return self.chatSystemEmojiPageIds
end

function ChatSystemController:GetEmojiPage(pageId)
  if pageId == 0 then
    local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
    return userChatData:GetRecentEmojis()
  end
  return self.chatSystemEmojiDic[pageId]
end

function ChatSystemController:GetChatSystemMainCfg()
  return ConfigData.new_chat_main[1]
end

function ChatSystemController:GetPrefSendMsgTime()
  return self.prefSendMsgTime
end

function ChatSystemController:GetIsContentAllSpace(contentString)
  if type(contentString) ~= "string" then
    error("content apace check fail, content type is not string!")
    return true
  end
  if emptyString ~= string.gsub(contentString, patternString, emptyString) then
    return false
  end
  return true
end

function ChatSystemController:ReqSendChatMsg(targetTpe, targetId, chatType, content, callback)
  local currentTm = PlayerDataCenter.timestamp
  if currentTm - self.prefSendMsgTime < self.speakCd then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6017))
    return
  end
  if chatType == ChatSystemEnum.EChatContentType.Text and self:GetIsContentAllSpace(content) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6114))
    return
  end
  self.prefSendMsgTime = currentTm
  self._net:CS_CHAT_Message(targetTpe, targetId, chatType, content, callback)
end

function ChatSystemController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnEmojiItemUpdate)
end

return ChatSystemController
