_class("FeatureEffectParamTrapDefence", FeatureEffectParamBase)
FeatureEffectParamTrapDefence = FeatureEffectParamTrapDefence

function FeatureEffectParamTrapDefence:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamTrapDefence:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
end

function FeatureEffectParamTrapDefence:GetFeatureType()
  return FeatureType.TrapDefence
end

function FeatureEffectParamTrapDefence:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamTrapDefence:CloneSelf()
  local param = FeatureEffectParamTrapDefence:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamTrapDefence:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamTrapDefence:GetMasterSkillID()
  return self._skillID
end
