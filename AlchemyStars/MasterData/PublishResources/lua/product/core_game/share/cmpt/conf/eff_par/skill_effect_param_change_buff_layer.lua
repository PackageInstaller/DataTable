require("skill_effect_param_base")
_class("SkillEffectParamChangeBuffLayer", SkillEffectParamBase)
SkillEffectParamChangeBuffLayer = SkillEffectParamChangeBuffLayer

function SkillEffectParamChangeBuffLayer:Constructor(t)
  self._buffID = t.buffID
  self._buffEffectType = t.buffEffectType
  self._checkDamageEffectResultWithStageIndex = t.checkDamageEffectResultWithStageIndex or 1
  self._buffTargetType = t.buffTargetType or BuffTargetType.SkillTarget
  self._buffTargetParam = t.buffTargetParam
  self._addToNonMissDamageTarget = t.addToNonMissDamageTarget
  self._changeBuffLayerType = t.changeBuffLayerType or BuffTargetType.Count
  self._changeBuffLayerParam = t.changeBuffLayerParam
  self._unloadZeroLayer = t.unloadZeroLayer or 0
  self._needPickUpDir = t.needPickUpDir or 0
end

function SkillEffectParamChangeBuffLayer:GetEffectType()
  return SkillEffectType.ChangeBuffLayer
end

function SkillEffectParamChangeBuffLayer:GetCheckDamageEffectResultWithStageIndex()
  return self._checkDamageEffectResultWithStageIndex
end

function SkillEffectParamChangeBuffLayer:GetBuffID()
  return self._buffID
end

function SkillEffectParamChangeBuffLayer:GetBuffEffectType()
  return self._buffEffectType
end

function SkillEffectParamChangeBuffLayer:GetBuffTargetType()
  return self._buffTargetType
end

function SkillEffectParamChangeBuffLayer:GetBuffTargetParam()
  return self._buffTargetParam
end

function SkillEffectParamChangeBuffLayer:CanAddToNonMissDamageTarget()
  return self._addToNonMissDamageTarget
end

function SkillEffectParamChangeBuffLayer:GetChangeBuffLayerType()
  return self._changeBuffLayerType
end

function SkillEffectParamChangeBuffLayer:GetChangeBuffLayerParam()
  return self._changeBuffLayerParam
end

function SkillEffectParamChangeBuffLayer:GetUnloadZeroLayer()
  return self._unloadZeroLayer
end

function SkillEffectParamChangeBuffLayer:IsNeedPickUpDir()
  return self._needPickUpDir == 1
end

ChangeBuffLayerType = {
  Percent = 1,
  Count = 2,
  Prob = 3
}
_enum("ChangeBuffLayerType", ChangeBuffLayerType)
