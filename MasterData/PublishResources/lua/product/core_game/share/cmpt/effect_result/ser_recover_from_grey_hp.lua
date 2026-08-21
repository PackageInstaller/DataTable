require("skill_effect_result_base")
_class("SkillEffectResult_RecoverFromGreyHP", SkillEffectResultBase)
SkillEffectResult_RecoverFromGreyHP = SkillEffectResult_RecoverFromGreyHP
SkillEffectResult_RecoverFromGreyHP.__EFFECT_TYPE = SkillEffectType.RecoverFromGreyHP

function SkillEffectResult_RecoverFromGreyHP:Constructor(entityID, damageInfo)
  self._entityID = entityID
  self._damageInfo = damageInfo
end

function SkillEffectResult_RecoverFromGreyHP:GetEntityID()
  return self._entityID
end

function SkillEffectResult_RecoverFromGreyHP:GetDamageInfo()
  return self._damageInfo
end

function SkillEffectResult_RecoverFromGreyHP:GetCurrentGreyVal()
  return self._currentGreyVal
end

function SkillEffectResult_RecoverFromGreyHP:SetCurrentGreyVal(v)
  self._currentGreyVal = v
end
