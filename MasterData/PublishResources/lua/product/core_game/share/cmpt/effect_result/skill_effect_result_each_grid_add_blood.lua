_class("SkillEffectResultEachGridAddBlood", SkillEffectResultBase)
SkillEffectResultEachGridAddBlood = SkillEffectResultEachGridAddBlood

function SkillEffectResultEachGridAddBlood:Constructor()
  self._targetID = 0
  self._addValue = 0
end

function SkillEffectResultEachGridAddBlood:GetEffectType()
  return SkillEffectType.EachGridAddBlood
end

function SkillEffectResultEachGridAddBlood:SetAddData(targetID, addValue)
  self._targetID = targetID
  self._addValue = addValue
end

function SkillEffectResultEachGridAddBlood:GetTargetID()
  return self._targetID
end

function SkillEffectResultEachGridAddBlood:GetAddValue()
  return self._addValue
end

function SkillEffectResultEachGridAddBlood:SetAddValue(addValue)
  self._addValue = addValue
end

function SkillEffectResultEachGridAddBlood:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function SkillEffectResultEachGridAddBlood:GetDamageInfo()
  return self._damageInfo
end
