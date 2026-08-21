require("action_is_base")
_class("ActionIs_HaveLessMobility", ActionIsBase)
ActionIs_HaveLessMobility = ActionIs_HaveLessMobility

function ActionIs_HaveLessMobility:Constructor()
end

function ActionIs_HaveLessMobility:OnUpdate()
  local nConfigMobility = self:GetLogicData(-1)
  local aiCmpt = self.m_entityOwn:AI()
  local nMobilityValid = aiCmpt:GetMobilityValid()
  local totalMobility = aiCmpt:GetMobilityConfig()
  local nReturn = AINewNodeStatus.Failure
  if nConfigMobility >= nMobilityValid then
    nReturn = AINewNodeStatus.Success
  end
  self:PrintLog("检测剩余行动力 nMobilityValid = ", nMobilityValid, "TotalMobility =", totalMobility)
  self:PrintDebugLog("检测剩余行动力 nMobilityValid = ", nMobilityValid, "TotalMobility =", totalMobility)
  return nReturn
end
