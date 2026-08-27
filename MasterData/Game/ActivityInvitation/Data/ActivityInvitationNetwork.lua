local ActivityInvitationNetwork = class("ActivityInvitationNetwork", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local cs_MessageCommon = CS.MessageCommon

function ActivityInvitationNetwork:ctor()
  self._registTable = {}
  self._pickTable = {}
end

function ActivityInvitationNetwork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Invitation_Register, self, proto_csmsg.SC_ACTIVITY_Invitation_Register, self.SC_ACTIVITY_Invitation_Register)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Invitation_Pick, self, proto_csmsg.SC_ACTIVITY_Invitation_Pick, self.SC_ACTIVITY_Invitation_Pick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Invitation_RegisterNtf, self, proto_csmsg.SC_ACTIVITY_Invitation_RegisterNtf, self.SC_ACTIVITY_Invitation_RegisterNtf)
end

function ActivityInvitationNetwork:CS_ACTIVITY_Invitation_Register(actFrameId, code, callback)
  self._registTable.actLongId = actFrameId
  self._registTable.invitationCode = code
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_Register, proto_csmsg.CS_ACTIVITY_Invitation_Register, self._registTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_Register, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Invitation_Register)
end

function ActivityInvitationNetwork:SC_ACTIVITY_Invitation_Register(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_LIMIT then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7707))
    elseif msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_CODE_PARSE_ERROR or msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_CODE_LEN_ERROR or msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_CODE_NOT_MATCH then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7705))
    else
      local err = "SC_ACTIVITY_Invitation_Register error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_Register)
    return
  end
end

function ActivityInvitationNetwork:CS_ACTIVITY_Invitation_Pick(actFrameId, index, callback)
  self._pickTable.actLongId = actFrameId
  self._pickTable.rewardIdx = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_Pick, proto_csmsg.CS_ACTIVITY_Invitation_Pick, self._pickTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_Pick, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_Invitation_Pick)
end

function ActivityInvitationNetwork:SC_ACTIVITY_Invitation_Pick(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_Invitation_Pick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_Pick)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
end

function ActivityInvitationNetwork:SC_ACTIVITY_Invitation_RegisterNtf(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_LIMIT then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7707))
    elseif msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_CODE_PARSE_ERROR or msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_CODE_LEN_ERROR or msg.ret == proto_csmsg_ErrorCode.ACTIVITY_INVITATION_CODE_NOT_MATCH then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7705))
    else
      local err = "SC_ACTIVITY_Invitation_RegisterNtf error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_Invitation_RegisterNtf)
    return
  end
  UIUtil.ShowCommonReward(msg.rewards)
  MsgCenter:Broadcast(eMsgEventId.InvitationCodeRegister, msg.actLontId)
end

return ActivityInvitationNetwork
