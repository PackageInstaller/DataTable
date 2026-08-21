require("skill_effect_param_base")
_class("SkillSummonTrapEffectParam", SkillEffectParamBase)
SkillSummonTrapEffectParam = SkillSummonTrapEffectParam

function SkillSummonTrapEffectParam:Constructor(t)
  self._trapID = t.trapID
  self._block = t.block or 1
  self._transferDisabled = t.transferDisabled == 1
  self._overlapFlag = t.overlapFlag or 1
  self._overlapCheckSuper = t.overlapCheckSuper or 0
  self._absorbTrapNum = t.absorbTrapNum or 0
  self._moveTrap = t.moveTrap or 0
  self._type = t.type or SummonTrapType.Normal
  self._stopSummonTrapType = t.stopSummonTrapType
  self._blockByMonster = t.blockByMonster or 0
  self._randomCount = t.randomCount
  self._usePickUpDir = t.usePickUpDir or 0
  self._aiOrder = t.aiOrder
  self._rangeM = t.rangeM
end

function SkillSummonTrapEffectParam:GetEffectType()
  return SkillEffectType.SummonTrap
end

function SkillSummonTrapEffectParam:GetTrapID()
  return self._trapID
end

function SkillSummonTrapEffectParam:GetBlock()
  return self._block
end

function SkillSummonTrapEffectParam:IsTransferDisabled()
  return self._transferDisabled
end

function SkillSummonTrapEffectParam:IsTrapOverlap()
  return self._overlapFlag == 1
end

function SkillSummonTrapEffectParam:IsTrapOverlapCheckSuper()
  return self._overlapCheckSuper == 1
end

function SkillSummonTrapEffectParam:GetAbsorbTrapNum()
  return self._absorbTrapNum
end

function SkillSummonTrapEffectParam:GetMoveTrap()
  return self._moveTrap == 1
end

function SkillSummonTrapEffectParam:GetSummonType()
  return self._type
end

function SkillSummonTrapEffectParam:GetStopSummonTrapType()
  return self._stopSummonTrapType
end

function SkillSummonTrapEffectParam:GetRandomCount()
  return self._randomCount
end

function SkillSummonTrapEffectParam:IsBlockByMonster()
  return self._blockByMonster == 1
end

function SkillSummonTrapEffectParam:IsUsePickUpDir()
  return self._usePickUpDir == 1
end

function SkillSummonTrapEffectParam:GetTrapAIOrder()
  return self._aiOrder
end

function SkillSummonTrapEffectParam:GetRangeM()
  return self._rangeM
end

local SummonTrapType = {
  Normal = 1,
  ByTargetUnderGrid = 2,
  Range = 3,
  RandomRange = 4,
  RandomRangeWithBlock = 5
}
_enum("SummonTrapType", SummonTrapType)
