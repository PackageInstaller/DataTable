require("skill_damage_effect_param")
require("calc_increase_san")
_class("SkillEffectParam_IncreaseSan", SkillEffectParamBase)
SkillEffectParam_IncreaseSan = SkillEffectParam_IncreaseSan

function SkillEffectParam_IncreaseSan:Constructor(t)
  self._mode = t.mode or SkillEffectIncreaseSanMode.FixVal
  self._val = t.val
end

function SkillEffectParam_IncreaseSan:GetEffectType()
  return SkillEffectType.IncreaseSan
end

function SkillEffectParam_IncreaseSan:GetSanValue()
  return self._val
end

function SkillEffectParam_IncreaseSan:GetMode()
  return self._mode
end
