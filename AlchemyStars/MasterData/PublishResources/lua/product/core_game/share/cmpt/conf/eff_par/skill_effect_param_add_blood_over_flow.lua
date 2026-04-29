require("skill_effect_param_base")
_class("SkillEffectParam_AddBloodOverFlow", SkillEffectParamBase)
SkillEffectParam_AddBloodOverFlow = SkillEffectParam_AddBloodOverFlow

function SkillEffectParam_AddBloodOverFlow:Constructor(t)
  self._addBlood = t.addBlood
  self._summonTrap = t.summonTrap
end

function SkillEffectParam_AddBloodOverFlow:GetEffectType()
  return SkillEffectType.AddBloodOverFlow
end

function SkillEffectParam_AddBloodOverFlow:GetAddBlood()
  return self._addBlood
end

function SkillEffectParam_AddBloodOverFlow:GetSummonTrap()
  return self._summonTrap
end
