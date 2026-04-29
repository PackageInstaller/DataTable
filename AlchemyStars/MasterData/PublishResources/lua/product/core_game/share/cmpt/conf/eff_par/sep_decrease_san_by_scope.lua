require("skill_damage_effect_param")
_class("SkillEffectParam_DecreaseSanByScope", SkillEffectParamBase)
SkillEffectParam_DecreaseSanByScope = SkillEffectParam_DecreaseSanByScope

function SkillEffectParam_DecreaseSanByScope:Constructor(t)
  self._sanPerGrid = t.sanPerGrid
end

function SkillEffectParam_DecreaseSanByScope:GetEffectType()
  return SkillEffectType.DecreaseSanByScope
end

function SkillEffectParam_DecreaseSanByScope:GetSanPerGrid()
  return self._sanPerGrid
end
