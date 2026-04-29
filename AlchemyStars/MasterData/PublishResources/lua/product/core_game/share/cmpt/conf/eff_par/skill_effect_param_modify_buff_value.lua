_class("SkillEffectParam_ModifyBuffValue", SkillEffectParamBase)
SkillEffectParam_ModifyBuffValue = SkillEffectParam_ModifyBuffValue

function SkillEffectParam_ModifyBuffValue:Constructor(t)
  self._buffID = t.buffID
  self._valueName = t.valueName
  self._addValue = t.addValue
  self._certainValue = t.certainValue
  self._maxValue = t.maxValue
  self._needKill = t.needKill
end

function SkillEffectParam_ModifyBuffValue:GetEffectType()
  return SkillEffectType.ModifyBuffValue
end

function SkillEffectParam_ModifyBuffValue:GetBuffID()
  return self._buffID
end

function SkillEffectParam_ModifyBuffValue:GetValueName()
  return self._valueName
end

function SkillEffectParam_ModifyBuffValue:GetAddValue()
  return self._addValue
end

function SkillEffectParam_ModifyBuffValue:GetCertainValue()
  return self._certainValue
end

function SkillEffectParam_ModifyBuffValue:GetMaxValue()
  return self._maxValue
end

function SkillEffectParam_ModifyBuffValue:NeedKill()
  return self._needKill
end
