require("skill_damage_effect_param")
_class("SkillEffectParam_CoffinMusumeSetCandleLight", SkillEffectParamBase)
SkillEffectParam_CoffinMusumeSetCandleLight = SkillEffectParam_CoffinMusumeSetCandleLight

function SkillEffectParam_CoffinMusumeSetCandleLight:Constructor(t, petId, effectIndex, skillType, grade, awaking)
  self._isLight = tonumber(t.isLight) == 1
end

function SkillEffectParam_CoffinMusumeSetCandleLight:GetEffectType()
  return SkillEffectType.CoffinMusumeSetCandleLight
end

function SkillEffectParam_CoffinMusumeSetCandleLight:IsLight()
  return self._isLight
end
