local HomeChatNetworkCtrl = class("HomeChatNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function HomeChatNetworkCtrl:ctor()
  self.msg4switchChannel = {}
  self.msg4send = {}
end

function HomeChatNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_AssignChannel, self, proto_csmsg.SC_CHAT_AssignChannel, self.SC_CHAT_AssignChannel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_AvailableChannels, self, proto_csmsg.SC_CHAT_AvailableChannels, self.SC_CHAT_AvailableChannels)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_SwitchChannel, self, proto_csmsg.SC_CHAT_SwitchChannel, self.SC_CHAT_SwitchChannel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_Message, self, proto_csmsg.SC_CHAT_Message, self.SC_CHAT_Message)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_CHAT_PushMessage, self, proto_csmsg.SC_CHAT_PushMessage, self.SC_CHAT_PushMessage)
end

function HomeChatNetworkCtrl:SC_CHAT_AssignChannel(msg)
  PlayerDataCenter.homeChatDataCenter:SetCurChannel(msg.channel)
end

function HomeChatNetworkCtrl:CS_CHAT_AvailableChannels(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_AvailableChannels, proto_csmsg.CS_CHAT_AvailableChannels, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_AvailableChannels, function()
    if callback ~= nil then
      callback()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_CHAT_AvailableChannels)
end

function HomeChatNetworkCtrl:SC_CHAT_AvailableChannels(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_CHAT_AvailableChannels, msg)
end

function HomeChatNetworkCtrl:CS_CHAT_SwitchChannel(channel, callback)
  self.msg4switchChannel.channel = channel
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_SwitchChannel, proto_csmsg.CS_CHAT_SwitchChannel, self.msg4switchChannel)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_SwitchChannel, function()
    if callback ~= nil then
      callback()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_CHAT_SwitchChannel)
end

function HomeChatNetworkCtrl:SC_CHAT_SwitchChannel(msg)
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_CHAT_SwitchChannel, msg)
end

function HomeChatNetworkCtrl:CS_CHAT_Message(emoji_id, message)
  self.msg4send.emoji_id = emoji_id
  self.msg4send.message = message
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_CHAT_Message, proto_csmsg.CS_CHAT_Message, self.msg4send)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_CHAT_Message, proto_csmsg_MSG_ID.MSG_SC_CHAT_Message)
end

function HomeChatNetworkCtrl:SC_CHAT_Message()
end

function HomeChatNetworkCtrl:SC_CHAT_PushMessage()
end

function HomeChatNetworkCtrl:Reset()
end

return HomeChatNetworkCtrl
