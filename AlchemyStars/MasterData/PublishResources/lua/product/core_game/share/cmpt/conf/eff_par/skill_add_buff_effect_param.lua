require("skill_effect_param_base")
_class("SkillAddBuffEffectParam", SkillEffectParamBase)
SkillAddBuffEffectParam = SkillAddBuffEffectParam

function SkillAddBuffEffectParam:Constructor(t)
  self._buffProb = t.prob or 0
  self._buffProbType = t.probType or SkillAddBuffPropType.Default
  self._buffID = t.buffID
  self._buffRoundCount = t.buffRoundCount
  self._addBuffType = t.addBuffType or SkillAddBuffType.Default
  self._remove = t.remove or false
  self._buffTargetType = t.buffTargetType or BuffTargetType.SkillTarget
  self._transmitAttack = t.transmitAttack or false
  self._isTransmitFinalAtk = t.isTransmitFinalAtk or false
  self._transmitDefence = t.transmitDefence or false
  self._transmitFinalDefense = t.isTransmitFinalDefense or false
  self._buffTargetParam = t.buffTargetParam
  self._buffCountParam = t.buffCountParam
  self._buffInitLayer = t.buffInitLayer
  self._addToNonMissDamageTarget = t.addToNonMissDamageTarget
  self._mustHaveSkillTarget = t.mustHaveSkillTarget or false
  self._featureShopSelectCellID = t.featureShopSelectCellID
end

function SkillAddBuffEffectParam:GetBuffTargetParam()
  return self._buffTargetParam
end

function SkillAddBuffEffectParam:GetEffectType()
  return SkillEffectType.AddBuff
end

function SkillAddBuffEffectParam:GetBuffProb()
  return self._buffProb
end

function SkillAddBuffEffectParam:GetBuffProbType()
  return self._buffProbType
end

function SkillAddBuffEffectParam:GetBuffID()
  return self._buffID
end

function SkillAddBuffEffectParam:GetBuffRoundCount()
  return self._buffRoundCount
end

function SkillAddBuffEffectParam:GetAddBuffType()
  return self._addBuffType
end

function SkillAddBuffEffectParam:GetRemove()
  return self._remove
end

function SkillAddBuffEffectParam:GetBuffTargetType()
  return self._buffTargetType
end

function SkillAddBuffEffectParam:TransmitAttack()
  return self._transmitAttack
end

function SkillAddBuffEffectParam:IsTransmitFinalAttack()
  return self._isTransmitFinalAtk
end

function SkillAddBuffEffectParam:TransmitDefence()
  return self._transmitDefence
end

function SkillAddBuffEffectParam:IsTransmitFinalDefense()
  return self._transmitFinalDefense
end

function SkillAddBuffEffectParam:GetBuffCountParam()
  return self._buffCountParam
end

function SkillAddBuffEffectParam:SetBuffInitLayer(layer)
  self._buffInitLayer = layer
end

function SkillAddBuffEffectParam:GetBuffInitLayer()
  return self._buffInitLayer
end

function SkillAddBuffEffectParam:CanAddToNonMissDamageTarget()
  return self._addToNonMissDamageTarget
end

function SkillAddBuffEffectParam:MustHaveSkillTarget()
  return self._mustHaveSkillTarget
end

function SkillAddBuffEffectParam:GetfeatureShopSelectCellID()
  return self._featureShopSelectCellID
end
