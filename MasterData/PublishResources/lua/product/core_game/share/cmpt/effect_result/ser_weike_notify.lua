_class("SkillEffectResult_WeikeNotify", SkillEffectResultBase)
SkillEffectResult_WeikeNotify = SkillEffectResult_WeikeNotify
SkillEffectResult_WeikeNotify.__EFFECT_TYPE = SkillEffectType.WeikeNotify

function SkillEffectResult_WeikeNotify:Constructor(notifyType, skillType, casterPos, multiCastCount)
  self._notifyType = notifyType
  self._skillType = skillType
  self._casterPos = casterPos
  self._multiCastCount = multiCastCount
end

function SkillEffectResult_WeikeNotify:GetNotifyType()
  return self._notifyType
end

function SkillEffectResult_WeikeNotify:GetSkillType()
  return self._skillType
end

function SkillEffectResult_WeikeNotify:GetCasterPos()
  return self._casterPos
end

function SkillEffectResult_WeikeNotify:GetMultiCastCount()
  return self._multiCastCount
end
