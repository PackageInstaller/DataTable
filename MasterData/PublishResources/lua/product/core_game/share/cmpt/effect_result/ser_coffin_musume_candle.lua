require("skill_effect_result_base")
_class("SkillEffectResult_CoffinMusumeCandle", SkillEffectResultBase)
SkillEffectResult_CoffinMusumeCandle = SkillEffectResult_CoffinMusumeCandle
SkillEffectResult_CoffinMusumeCandle.__EFFECT_TYPE = SkillEffectType.CoffinMusumeCandle

function SkillEffectResult_CoffinMusumeCandle:Constructor(lights, addHPResult, damageResult, damageParam)
  self._selectedLights = lights
  self._addHPResult = addHPResult
  self._damageResult = damageResult
  self._damageParam = damageParam
end

function SkillEffectResult_CoffinMusumeCandle:GetSelectedLights()
  return self._selectedLights
end

function SkillEffectResult_CoffinMusumeCandle:GetAddHPResult()
  return self._addHPResult
end

function SkillEffectResult_CoffinMusumeCandle:GetDamageResult()
  return self._damageResult
end

function SkillEffectResult_CoffinMusumeCandle:GetDamageParam()
  return self._damageParam
end
