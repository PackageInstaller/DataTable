_class("SkillSummonTrapEffectResult", SkillEffectResultBase)
SkillSummonTrapEffectResult = SkillSummonTrapEffectResult

function SkillSummonTrapEffectResult:Constructor(trapID, pos, transferDisabled, stageIndex, dir, aiOrder)
  self._effectType = SkillEffectType.SummonTrap
  self._trapID = trapID
  self._pos = pos
  self._trapIDList = {}
  self._transferDisabled = transferDisabled or false
  self._stageIndex = stageIndex or 1
  self._dir = dir
  self._aiOrder = aiOrder
end

function SkillSummonTrapEffectResult:GetEffectType()
  return SkillEffectType.SummonTrap
end

function SkillSummonTrapEffectResult:GetTrapID()
  return self._trapID
end

function SkillSummonTrapEffectResult:GetPos()
  return self._pos
end

function SkillSummonTrapEffectResult:GetDir()
  return self._dir
end

function SkillSummonTrapEffectResult:GetTrapAIOrder()
  return self._aiOrder
end

function SkillSummonTrapEffectResult:SetTrapIDList(trapIDList)
  self._trapIDList = trapIDList
end

function SkillSummonTrapEffectResult:GetTrapIDList()
  return self._trapIDList
end

function SkillSummonTrapEffectResult:SetTransferDisabled(b)
  self._transferDisabled = b
end

function SkillSummonTrapEffectResult:IsTransferDisabled()
  return self._transferDisabled
end

function SkillSummonTrapEffectResult:GetDamageStageIndex()
  return self._stageIndex
end
