local FriendshipNetworkCtrl = class("FriendshipNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function FriendshipNetworkCtrl:ctor()
end

function FriendshipNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Detail, self, proto_csmsg.SC_INTIMACY_Detail, self.SC_INTIMACY_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Presentation, self, proto_csmsg.SC_INTIMACY_Presentation, self.SC_INTIMACY_Presentation)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_UpgradeLine, self, proto_csmsg.SC_INTIMACY_UpgradeLine, self.SC_INTIMACY_UpgradeLine)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_INTIMACY_SyncDiff, self, proto_csmsg.SC_INTIMACY_SyncDiff, self.SC_INTIMACY_SyncDiff)
end

function FriendshipNetworkCtrl:CS_INTIMACY_Detail(isInitData)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Detail, proto_csmsg.CS_INTIMACY_Detail, {})
end

function FriendshipNetworkCtrl:SC_INTIMACY_Detail(msg)
  PlayerDataCenter.allFriendshipData:UpdateData(msg.heroIntimacy)
  MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if not PlayerDataCenter.allFriendshipData.isInitData then
    PlayerDataCenter.allFriendshipData:InitFriendship()
  end
end

function FriendshipNetworkCtrl:CS_INTIMACY_Presentation(heroId, giftsDic, callback, newLevel, newExp)
  self.msg = {}
  self.msg.heroId = heroId
  self.msg.data = giftsDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Presentation, proto_csmsg.CS_INTIMACY_Presentation, self.msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Presentation, function()
    if PlayerDataCenter.allFriendshipData.FriendshipDataList[heroId] == nil then
      self:CS_INTIMACY_Detail()
    else
      PlayerDataCenter.allFriendshipData.FriendshipDataList[heroId].exp = newExp
      if newLevel ~= nil then
        PlayerDataCenter.allFriendshipData.FriendshipDataList[heroId].lv = newLevel
      end
    end
    MsgCenter:Broadcast(eMsgEventId.OnHeroFriendshipDataChange)
    PlayerDataCenter.allFriendshipData:AddFriendshipgBonus()
    if callback ~= nil then
      callback()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Presentation)
end

function FriendshipNetworkCtrl:SC_INTIMACY_Presentation(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FriendshipNetworkCtrl:OnRecvSendGift error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_Presentation)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FriendshipNetworkCtrl:CS_INTIMACY_UpgradeLine(heroId, lineId, callback)
  self.msg = {}
  self.msg.heroId = heroId
  self.msg.lineId = lineId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_UpgradeLine, proto_csmsg.CS_INTIMACY_UpgradeLine, self.msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_UpgradeLine, function()
    PlayerDataCenter.allFriendshipData:AddFosterBonus()
    if callback ~= nil then
      callback()
    end
  end, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_UpgradeLine, proto_csmsg_MSG_ID.MSG_SC_INTIMACY_Detail)
end

function FriendshipNetworkCtrl:SC_INTIMACY_UpgradeLine(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "FriendshipNetworkCtrl:OnRecvUpgradeLine error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_INTIMACY_UpgradeLine)
  else
    PlayerDataCenter.allFriendshipData:RemoveFosterBonus()
    self:CS_INTIMACY_Detail()
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function FriendshipNetworkCtrl:SC_INTIMACY_SyncDiff(msg)
  PlayerDataCenter.allFriendshipData:UpdateData(msg.update)
end

function FriendshipNetworkCtrl:Reset()
end

return FriendshipNetworkCtrl
