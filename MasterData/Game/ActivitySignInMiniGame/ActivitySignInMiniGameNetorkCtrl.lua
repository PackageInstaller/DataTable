local ActivitySignInMiniGameNetorkCtrl = class("ActivitySignInMiniGameNetorkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivitySignInMiniGameNetorkCtrl:ctor()
  self._msg = {}
  self._signTab = {}
  self._cartoonTab = {}
end

function ActivitySignInMiniGameNetorkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SignMiniGame_Sign, self, proto_csmsg.SC_ACTIVITY_SignMiniGame_Sign, self.SC_ACTIVITY_SignMiniGame_Sign)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SignMiniGame_PlayCartoon, self, proto_csmsg.SC_ACTIVITY_SignMiniGame_PlayCartoon, self.SC_ACTIVITY_SignMiniGame_PlayCartoon)
end

function ActivitySignInMiniGameNetorkCtrl:CS_ACTIVITY_SignMiniGame_Sign(actId, emojiId, callback)
  self._signTab.actId = actId
  self._signTab.emojiId = emojiId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_Sign, proto_csmsg.CS_ACTIVITY_SignMiniGame_Sign, self._signTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_Sign, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SignMiniGame_Sign)
end

function ActivitySignInMiniGameNetorkCtrl:SC_ACTIVITY_SignMiniGame_Sign(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_SignMiniGame_Sign error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_Sign)
  end
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_Sign, msg)
end

function ActivitySignInMiniGameNetorkCtrl:CS_ACTIVITY_SignMiniGame_PlayCartoon(actId, callback)
  self._cartoonTab.actId = actId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_PlayCartoon, proto_csmsg.CS_ACTIVITY_SignMiniGame_PlayCartoon, self._cartoonTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_PlayCartoon, callback, proto_csmsg_MSG_ID.MSG_SC_ACTIVITY_SignMiniGame_PlayCartoon)
end

function ActivitySignInMiniGameNetorkCtrl:SC_ACTIVITY_SignMiniGame_PlayCartoon(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ACTIVITY_SignMiniGame_PlayCartoon error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ACTIVITY_SignMiniGame_PlayCartoon)
  end
end

return ActivitySignInMiniGameNetorkCtrl
