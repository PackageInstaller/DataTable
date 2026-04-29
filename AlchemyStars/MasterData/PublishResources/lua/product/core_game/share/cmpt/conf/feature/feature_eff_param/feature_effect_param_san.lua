_class("FeatureEffectParamSan", FeatureEffectParamBase)
FeatureEffectParamSan = FeatureEffectParamSan

function FeatureEffectParamSan:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamSan:_RefreshData(t)
  if not t then
    return
  end
  if t.EnterSanValue then
    self._enterSanValue = t.EnterSanValue
  end
  if t.MaxSanValue then
    self._maxSanValue = t.MaxSanValue
  end
  if t.MinSanValue then
    self._minSanValue = t.MinSanValue
  end
  if t.RoundDelValue then
    self._roundDelValue = t.RoundDelValue
  end
  if t.SanSysCfgId then
    Log.notice("SanSysCfgId:", t.SanSysCfgId, " curId:", self._sanSysCfgId)
    self._sanSysCfgId = t.SanSysCfgId
  end
end

function FeatureEffectParamSan:GetFeatureType()
  return FeatureType.Sanity
end

function FeatureEffectParamSan:CopyFrom(param)
  if param then
    for k, v in pairs(param) do
      self[k] = v
    end
  end
end

function FeatureEffectParamSan:CloneSelf()
  local param = FeatureEffectParamSan:New()
  param:CopyFrom(self)
  return param
end

function FeatureEffectParamSan:ReplaceByCustomCfg(t)
  self:_RefreshData(t)
end

function FeatureEffectParamSan:GetSanityParam()
  if self._sanSysCfgId then
    local sanityCfg = Cfg.cfg_sanity[self._sanSysCfgId]
    if sanityCfg then
      return sanityCfg.Param
    end
  end
end

function FeatureEffectParamSan:GetEnterSanValue()
  return self._enterSanValue
end

function FeatureEffectParamSan:GetMaxSanValue()
  return self._maxSanValue
end

function FeatureEffectParamSan:GetMinSanValue()
  return self._minSanValue or 0
end

function FeatureEffectParamSan:GetRoundDelValue()
  return self._roundDelValue
end
