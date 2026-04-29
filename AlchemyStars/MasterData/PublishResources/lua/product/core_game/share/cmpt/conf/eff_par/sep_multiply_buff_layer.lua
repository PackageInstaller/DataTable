require("skill_effect_param_base")
_class("SkillEffectParam_MultiplyBuffLayer", SkillEffectParamBase)
SkillEffectParam_MultiplyBuffLayer = SkillEffectParam_MultiplyBuffLayer

function SkillEffectParam_MultiplyBuffLayer:Constructor(t)
  self._multiplier = t.multiplier
  self._buffEffectType = t.buffEffectType
  self._buffID = t.buffID
end

function SkillEffectParam_MultiplyBuffLayer:GetEffectType()
  return SkillEffectType.MultiplyBuffLayer
end

function SkillEffectParam_MultiplyBuffLayer:GetMultiplier()
  return self._multiplier
end

function SkillEffectParam_MultiplyBuffLayer:GetLayerBuffEffectType()
  return self._buffEffectType
end

function SkillEffectParam_MultiplyBuffLayer:GetLayerBuffID()
  return self._buffID
end
