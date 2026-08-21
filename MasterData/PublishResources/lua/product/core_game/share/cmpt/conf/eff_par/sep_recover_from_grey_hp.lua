_class("SkillEffectParam_RecoverFromGreyHP", SkillEffectParamBase)
SkillEffectParam_RecoverFromGreyHP = SkillEffectParam_RecoverFromGreyHP

function SkillEffectParam_RecoverFromGreyHP:Constructor(t)
  self._recoverRate = t.rate
end

function SkillEffectParam_RecoverFromGreyHP:GetEffectType()
  return SkillEffectType.RecoverFromGreyHP
end

function SkillEffectParam_RecoverFromGreyHP:GetRecoverRate()
  return self._recoverRate
end
