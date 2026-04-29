require("skill_effect_param_base")
_class("SkillEffectTransportParam", SkillEffectParamBase)
SkillEffectTransportParam = SkillEffectTransportParam

function SkillEffectTransportParam:Constructor(t)
  self._times = t.times or 1
  self._isLoop = t.isLoop or 1
  self._offsetPosX = t.offsetPosX or 0
  self._offsetPosY = t.offsetPosY or 0
  self._offsetBodyAreaTimes = t.offsetBodyAreaTimes or 1
end

function SkillEffectTransportParam:GetEffectType()
  return SkillEffectType.Transport
end

function SkillEffectTransportParam:GetTimes()
  return self._times
end

function SkillEffectTransportParam:GetIsLoop()
  return self._isLoop
end

function SkillEffectTransportParam:GetOffsetPos()
  return Vector2(self._offsetPosX, self._offsetPosY)
end

function SkillEffectTransportParam:GetOffsetBodyAreaTimes()
  return self._offsetBodyAreaTimes
end
