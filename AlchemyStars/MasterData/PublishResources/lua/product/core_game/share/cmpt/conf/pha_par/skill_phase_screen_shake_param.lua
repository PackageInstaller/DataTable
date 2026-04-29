require("skill_phase_param_base")
_class("SkillPhaseScreenShakeParam", SkillPhaseParamBase)
SkillPhaseScreenShakeParam = SkillPhaseScreenShakeParam

function SkillPhaseScreenShakeParam:Constructor(t)
  self._angleRandomness = t.angleRandomness
  self._decayRate = t.decayRate
  self._delay = t.delay
  self._duration = t.duration
  self._intenseRandomness = t.intenseRandomness
  self._intensity = t.intensity
  self._mainVibAngle = t.mainVibAngle
  self._vibrato = t.vibrato
end

function SkillPhaseScreenShakeParam:GetCacheTable()
end

function SkillPhaseScreenShakeParam:GetPhaseType()
  return SkillViewPhaseType.ScreenShake
end

function SkillPhaseScreenShakeParam:GetAngleRandomness()
  return self._angleRandomness
end

function SkillPhaseScreenShakeParam:GetDecayRate()
  return self._decayRate
end

function SkillPhaseScreenShakeParam:GetDelay()
  return self._delay
end

function SkillPhaseScreenShakeParam:GetDuration()
  return self._duration
end

function SkillPhaseScreenShakeParam:GetIntenseRandomness()
  return self._intenseRandomness
end

function SkillPhaseScreenShakeParam:GetMainVibAngle()
  return self._mainVibAngle
end

function SkillPhaseScreenShakeParam:GetIntensity()
  return self._intensity
end

function SkillPhaseScreenShakeParam:GetVibrato()
  return self._vibrato
end
