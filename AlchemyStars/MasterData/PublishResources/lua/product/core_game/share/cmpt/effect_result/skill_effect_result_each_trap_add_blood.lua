_class("SkillEffectResultEachTrapAddBlood", SkillEffectResultBase)
SkillEffectResultEachTrapAddBlood = SkillEffectResultEachTrapAddBlood

function SkillEffectResultEachTrapAddBlood:Constructor()
  self._targetID = 0
  self._addValue = 0
end

function SkillEffectResultEachTrapAddBlood:GetEffectType()
  return SkillEffectType.EachTrapAddBlood
end

function SkillEffectResultEachTrapAddBlood:SetAddData(targetID, addValue)
  self._targetID = targetID
  self._addValue = addValue
end

function SkillEffectResultEachTrapAddBlood:GetTargetID()
  return self._targetID
end

function SkillEffectResultEachTrapAddBlood:GetAddValue()
  return self._addValue
end

function SkillEffectResultEachTrapAddBlood:SetAddValue(addValue)
  self._addValue = addValue
end

function SkillEffectResultEachTrapAddBlood:SetDamageInfo(damageInfo)
  self._damageInfo = damageInfo
end

function SkillEffectResultEachTrapAddBlood:GetDamageInfo()
  return self._damageInfo
end
