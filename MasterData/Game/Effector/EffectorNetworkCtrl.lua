local EffectorNetworkCtrl = class("EffectorNetworkCtrl", NetworkCtrlBase)

function EffectorNetworkCtrl:ctor()
end

function EffectorNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_ResourceGenerator, self, proto_csmsg.SC_EFFECTOR_ResourceGenerator, self.SC_EFFECTOR_ResourceGenerator)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_RGSyncUpdateDiff, self, proto_csmsg.SC_EFFECTOR_RGSyncUpdateDiff, self.SC_EFFECTOR_RGSyncUpdateDiff)
end

function EffectorNetworkCtrl:CS_EFFECTOR_ResourceGenerator()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EFFECTOR_ResourceGenerator, proto_csmsg.CS_EFFECTOR_ResourceGenerator, table.emptytable)
end

function EffectorNetworkCtrl:SC_EFFECTOR_ResourceGenerator(msg)
  for _, v in pairs(msg.detail.data) do
    PlayerDataCenter.allEffectorData:UpdateResourceData(v)
  end
  for _, v in pairs(msg.detail.autoResData) do
    PlayerDataCenter.allEffectorData:UpdateAutoResourceGenerator(v)
  end
  PlayerDataCenter.allEffectorData:OnUpdateItemCeil()
  PlayerDataCenter.allEffectorData:OnUpdateItemGenerateSpeed()
  PlayerDataCenter.allEffectorData:OnARGItemChnage()
  NetworkManager:GetNetwork(NetworkTypeID.Building):InitBuildingRedDotOasis()
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function EffectorNetworkCtrl:SC_EFFECTOR_RGSyncUpdateDiff(msg)
  local allEffectorData = PlayerDataCenter.allEffectorData
  for _, v in pairs(msg.update) do
    allEffectorData:UpdateResourceData(v)
  end
  for uid, _ in pairs(msg.rgDelete) do
    allEffectorData:DeleteResourceData(uid)
  end
  for _, v in pairs(msg.autoRg) do
    allEffectorData:UpdateAutoResourceGenerator(v)
  end
  for uid, _ in pairs(msg.argDelete) do
  end
  PlayerDataCenter.allEffectorData:OnUpdateItemCeil()
  PlayerDataCenter.allEffectorData:OnUpdateItemGenerateSpeed()
  PlayerDataCenter.allEffectorData:OnARGItemChnage()
end

function EffectorNetworkCtrl:Reset()
end

return EffectorNetworkCtrl
