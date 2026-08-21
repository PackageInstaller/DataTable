require("skill_effect_result_base")
_class("SkillEffectResult_CoffinMusumeSetCandleLight", SkillEffectResultBase)
SkillEffectResult_CoffinMusumeSetCandleLight = SkillEffectResult_CoffinMusumeSetCandleLight
SkillEffectResult_CoffinMusumeSetCandleLight.__EFFECT_TYPE = SkillEffectType.CoffinMusumeSetCandleLight

function SkillEffectResult_CoffinMusumeSetCandleLight:Constructor(entityID, isLight)
  self._entityID = entityID
  self._isLight = isLight
end

function SkillEffectResult_CoffinMusumeSetCandleLight:GetEntityID()
  return self._entityID
end

function SkillEffectResult_CoffinMusumeSetCandleLight:IsLight()
  return self._isLight
end
