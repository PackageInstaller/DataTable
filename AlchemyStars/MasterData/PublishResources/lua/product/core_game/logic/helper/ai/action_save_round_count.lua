require("ai_node_new")
_class("ActionRoundBase", AINewNode)
ActionRoundBase = ActionRoundBase

function ActionRoundBase:Constructor()
  self.m_nRoundData = 0
end

function ActionRoundBase:InitializeNode(cfg, context, logicOwn, configData)
  ActionRoundBase.super.InitializeNode(self, cfg, context, logicOwn, configData)
end

function ActionRoundBase:Reset()
  ActionRoundBase.super.Reset(self)
  self.m_nRoundData = self:GetRuntimeData("RoundCount") or 0
end

function ActionRoundBase:_MakeRoundCount(nRoundData, nLoopLimit)
  local nNewRound = math.fmod(nRoundData - 1, nLoopLimit) + 1
  return nNewRound
end

function ActionRoundBase:_SaveRoundCount(nSaveRound, nLoopLimit)
  local nRountNow = self:_MakeRoundCount(nSaveRound + 1, nLoopLimit)
  local nRountNext = self:_MakeRoundCount(nRountNow + 1, nLoopLimit)
  self:SetRuntimeData("RoundCount", nRountNow)
  self:SetRuntimeData("NextRoundCount", nRountNext)
  self:PrintLog("m_nRoundNow = ", nRountNow, ", m_nRountNext = ", nRountNext)
  return nRountNow
end

function ActionRoundBase:TryToSaveRoundCount(nLoopLimit)
  local nGameRound = self:GetGameRountNow()
  local nSaveRound = self:GetRuntimeData("GameRound")
  if nil == nSaveRound or nSaveRound ~= nGameRound then
    self.m_nRoundData = self:_SaveRoundCount(self.m_nRoundData, nLoopLimit)
    self:SetRuntimeData("GameRound", nGameRound)
    return true
  else
    self.m_nRoundData = self:GetRuntimeData("RoundCount")
  end
  return false
end

_class("ActionRound_SaveOnly", ActionRoundBase)
ActionRound_SaveOnly = ActionRound_SaveOnly

function ActionRound_SaveOnly:OnBegin()
  local nLoopLimit = self:GetLogicData(-1)
  if nil == nLoopLimit or nLoopLimit <= 0 then
    nLoopLimit = self:GetRuntimeData("SkillCount") or 1
  end
  local nSaveAction = self:TryToSaveRoundCount(nLoopLimit)
end

function ActionRound_SaveOnly:OnUpdate()
  return AINewNodeStatus.Success
end

_class("ActionSaveRoundCount", ActionRound_SaveOnly)
ActionSaveRoundCount = ActionSaveRoundCount

function ActionSaveRoundCount:OnUpdate()
  local nRoundCount = self.m_nRoundData
  self:PrintDebugLog("RoundCount = ", nRoundCount)
  return AINewNodeStatus.Other + nRoundCount
end

_class("ActionRound_GetSave", AINewNode)
ActionRound_GetSave = ActionRound_GetSave

function ActionRound_GetSave:OnUpdate()
  local nRoundLogic = self:GetRuntimeData("RoundCount")
  self:PrintDebugLog("RoundCount = ", nRoundLogic)
  return AINewNodeStatus.Other + nRoundLogic
end

_class("ActionRound_IsSame", AINewNode)
ActionRound_IsSame = ActionRound_IsSame

function ActionRound_IsSame:OnUpdate()
  local nConfigData = self:GetLogicData(-1)
  local nGameRound = self:GetGameRountNow()
  local nSaveRound = self:GetRuntimeData("GameRound")
  local nRoundLogic = self:GetRuntimeData("RoundCount") or 0
  if nGameRound == nSaveRound then
    nRoundLogic = self:GetRuntimeData("RoundCount") or 0
  else
    nRoundLogic = self:GetRuntimeData("NextRoundCount") or 0
  end
  self:PrintLog(" nSaveRound = ", nRoundLogic, ", nConfigData = ", nConfigData)
  self:PrintDebugLog(" nSaveRound = ", nRoundLogic, ", nConfigData = ", nConfigData)
  if nConfigData == nRoundLogic then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end

_class("ActionRound_IsLimit", ActionRoundBase)
ActionRound_IsLimit = ActionRound_IsLimit

function ActionRound_IsLimit:OnBegin()
  local nLoopLimit = 10000
  self:TryToSaveRoundCount(nLoopLimit)
end

function ActionRound_IsLimit:OnUpdate()
  local nRountCount = self.m_nRoundData
  local nLimitCount = self:GetLogicData(-1)
  self:PrintDebugLog("RoundCount = ", nRountCount, " LimitCount = ", nLimitCount)
  if nRountCount >= nLimitCount then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end

_class("ActionSetRoundCount", ActionRoundBase)
ActionSetRoundCount = ActionSetRoundCount

function ActionSetRoundCount:OnBegin()
  local roundCount = self:GetLogicData(-1)
  local nextRoundCount = self:GetLogicData(-2)
  local gameRound = self:GetLogicData(-3)
  self:SetRuntimeData("RoundCount", roundCount)
  self:SetRuntimeData("NextRoundCount", nextRoundCount)
  gameRound = gameRound or self:GetGameRountNow()
  self:SetRuntimeData("GameRound", gameRound)
end

function ActionSetRoundCount:OnUpdate()
  return AINewNodeStatus.Success
end
