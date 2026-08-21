require("skill_effect_param_base")
_class("SkillEffectParam_AddBloodOverFlowForDamage", SkillEffectParamBase)
SkillEffectParam_AddBloodOverFlowForDamage = SkillEffectParam_AddBloodOverFlowForDamage

function SkillEffectParam_AddBloodOverFlowForDamage:Constructor(t)
  self._addBlood = t.addBlood
  self._damage = t.damage
end

function SkillEffectParam_AddBloodOverFlowForDamage:GetEffectType()
  return SkillEffectType.AddBloodOverFlowForDamage
end

function SkillEffectParam_AddBloodOverFlowForDamage:GetAddBlood()
  return self._addBlood
end

function SkillEffectParam_AddBloodOverFlowForDamage:GetDamage()
  return self._damage
end
