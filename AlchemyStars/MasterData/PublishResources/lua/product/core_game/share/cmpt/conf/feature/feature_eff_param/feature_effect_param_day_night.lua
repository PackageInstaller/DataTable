_class("FeatureEffectParamDayNight", FeatureEffectParamBase)
FeatureEffectParamDayNight = FeatureEffectParamDayNight

function FeatureEffectParamDayNight:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamDayNight:_RefreshData(t)
  if not t then
    return
  end
  if t.EnterState then
    self._enterState = t.EnterState
  end
  if t.DayRound then
    self._dayRound = t.DayRound
  end
  if t.NightRound then
    self._nightRound = t.NightRound
  end
end

function FeatureEffectParamDayNight:GetFeatureType()
  return FeatureType.DayNight
end

function FeatureEffectParamDayNight:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamDayNight:CloneSelf()
  local param = FeatureEffectParamDayNight:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamDayNight:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamDayNight:GetEnterState()
  return self._enterState
end

function FeatureEffectParamDayNight:GetDayRound()
  return self._dayRound
end

function FeatureEffectParamDayNight:GetNightRound()
  return self._nightRound
end

function FeatureEffectParamDayNight:GetLastRound(state)
  if state == FeatureDayNightState.Day then
    return self:GetDayRound()
  elseif state == FeatureDayNightState.Night then
    return self:GetNightRound()
  end
end
