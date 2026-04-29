require("skill_effect_type")
require("skill_effect_result_base")
_class("SkillEffectResult_MultiplyBuffLayer", SkillEffectResultBase)
SkillEffectResult_MultiplyBuffLayer = SkillEffectResult_MultiplyBuffLayer
SkillEffectResult_MultiplyBuffLayer.__EFFECT_TYPE = SkillEffectType.MultiplyBuffLayer

function SkillEffectResult_MultiplyBuffLayer:Constructor(targetID, buffEffectType, val, buffSeq)
  self._targetID = targetID
  self._buffEffectType = buffEffectType
  self._val = val
  self._seq = buffSeq
end

function SkillEffectResult_MultiplyBuffLayer:GetTargetID()
  return self._targetID
end

function SkillEffectResult_MultiplyBuffLayer:GetLayerBuffEffectType()
  return self._buffEffectType
end

function SkillEffectResult_MultiplyBuffLayer:GetExpectFinalLayer()
  return self._val
end

function SkillEffectResult_MultiplyBuffLayer:GetLayerBuffSeq()
  return self._seq
end

function SkillEffectResult_MultiplyBuffLayer:SetFinalLayerCount(v)
  self._finalLayerCount = v
end

function SkillEffectResult_MultiplyBuffLayer:GetFinalLayerCount()
  return self._finalLayerCount
end
