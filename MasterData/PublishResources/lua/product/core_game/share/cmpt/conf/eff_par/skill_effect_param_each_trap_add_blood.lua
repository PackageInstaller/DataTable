require("skill_effect_param_base")
local TrapAddBloodParamType = {CasterMaxHP = 1}
_enum("TrapAddBloodParamType", TrapAddBloodParamType)
_class("SkillEffectParamEachTrapAddBlood", SkillEffectParamBase)
SkillEffectParamEachTrapAddBlood = SkillEffectParamEachTrapAddBlood

function SkillEffectParamEachTrapAddBlood:Constructor(t)
  self._trapId = t.trapId
  self._oneTrapAddValue = t.oneTrapAddValue
  self._baseAddValue = t.baseAddValue or 0
  self._addParamType = t.addParamType or TrapAddBloodParamType.CasterMaxHP
end

function SkillEffectParamEachTrapAddBlood:GetEffectType()
  return SkillEffectType.EachTrapAddBlood
end

function SkillEffectParamEachTrapAddBlood:GetBaseAddValue()
  return self._baseAddValue
end

function SkillEffectParamEachTrapAddBlood:GetOneTrapAddValue()
  return self._oneTrapAddValue
end

function SkillEffectParamEachTrapAddBlood:GetAddParamType()
  return self._addParamType
end

function SkillEffectParamEachTrapAddBlood:GetTrapId()
  return self._trapId
end
