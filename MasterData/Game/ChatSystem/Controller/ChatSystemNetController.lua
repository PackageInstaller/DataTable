local ChatSystemNetController = class("ChatSystemNetController", NetworkCtrlBase)
local base = NetworkCtrlBase
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")

function ChatSystemNetController:ctor()
  self._chatMsg = {
    message = {
      content = {},
      tar = {}
    }
  }
end

function ChatSystemNetController:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_Message, self, proto_csmsg.SC_CHAT_Message, self.SC_CHAT_Message)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_PushMessage, self, proto_csmsg.SC_CHAT_PushMessage, self.SC_CHAT_PushMessage)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_GM_Ban, self, proto_csmsg.SC_CHAT_GM_Ban, self.SC_CHAT_GM_Ban)
end

function ChatSystemNetController:CS_CHAT_Message(targetTpe, targetId, chatType, content, callback)
  if chatType == ChatSystemEnum.EChatContentType.Emoji then
    self._chatMsg.message.content.emojiId = content
    self._chatMsg.message.content.text = nil
  else
    self._chatMsg.message.content.emojiId = nil
    self._chatMsg.message.content.text = content
  end
  self._chatMsg.message.tar.tpe = targetTpe
  self._chatMsg.message.tar.id = targetId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_Message, proto_csmsg.CS_CHAT_Message, self._chatMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_Message, callback, proto_csmsg_MSG_ID.MSG_SC_CHAT_Message)
end

function ChatSystemNetController:SC_CHAT_Message(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.ERROR_FRIEND_NOT_FRIEND then
      local err = ConfigData:GetTipContent(6111)
      cs_MessageCommon.ShowMessageTips(err)
    elseif msg.ret == proto_csmsg_ErrorCode.ERROR_CHAT_GM_BAN then
      local err = ConfigData:GetTipContent(6103)
      cs_MessageCommon.ShowMessageTips(err)
      local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
      userChatCtrl:SetIsChatSystemBan(true)
    elseif msg.ret == proto_csmsg_ErrorCode.ERROR_CHAT_LENGTH_INVALID or msg.ret == proto_csmsg_ErrorCode.ERROR_CHAT_INVALID then
      local err = ConfigData:GetTipContent(6114)
      cs_MessageCommon.ShowMessageTips(err)
    elseif msg.ret == proto_csmsg_ErrorCode.ERROR_CHAT_CONTAIN_NEWLINE then
      local err = ConfigData:GetTipContent(6115)
      cs_MessageCommon.ShowMessageTips(err)
    else
      local err = "SC_CHAT_Message error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_CHAT_Message)
    return
  end
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  userChatCtrl:SetRudeMsgCount(msg.ioValidParseCode == 2)
  local chatRecieve = {
    message = msg.message,
    sender = {
      uid = PlayerDataCenter.inforData:GetUserUID()
    },
    sendTime = msg.sendTm
  }
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  userChatData:AddChatMsg(chatRecieve)
  local emojiId = msg.message.content.emojiId
  if emojiId ~= nil then
    userChatData:TryAddEmojiToRecentEmojis(emojiId)
  end
end

function ChatSystemNetController:SC_CHAT_PushMessage(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  for _, recieveMsg in pairs(msg.message) do
    userChatData:AddChatMsg(recieveMsg)
  end
end

function ChatSystemNetController:SC_CHAT_GM_Ban(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  userChatCtrl:SetIsChatSystemBan(msg.ban)
end

return ChatSystemNetController
