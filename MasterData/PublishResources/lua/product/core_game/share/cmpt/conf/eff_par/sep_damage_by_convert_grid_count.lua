require("skill_damage_effect_param")
_class("SkillEffectParamByConvertGridCount", SkillDamageEffectParam)
SkillEffectParamByConvertGridCount = SkillEffectParamByConvertGridCount

function SkillEffectParamByConvertGridCount:Constructor(t)
  self._gridType = t.gridType
end

function SkillEffectParamByConvertGridCount:GetGridType()
  return self._gridType
end

function SkillEffectParamByConvertGridCount:GetEffectType()
  return SkillEffectType.DamageByConvertGridCount
end
