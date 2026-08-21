_class("FeatureEffectParamScan", FeatureEffectParamBase)
FeatureEffectParamScan = FeatureEffectParamScan

function FeatureEffectParamScan:GetFeatureType()
  return FeatureType.Scan
end

function FeatureEffectParamScan:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamScan:_RefreshData(t)
  self._summonTrapSkillID = t.SummonTrapSkillID
  self._forceMovementSkillID = t.ForceMovementSkillID
  self._summonScanTrapSkillID = t.SummonScanTrapSkillID
  self._emptySkillID = t.EmptySkillID
  self._diedTrapIncluded = t.DiedTrapIncluded == 1
  self._summonTrapDescKey = t.summonTrapDescKey
end

function FeatureEffectParamScan:GetSummonTrapSkillID()
  return self._summonTrapSkillID
end

function FeatureEffectParamScan:GetForceMovementSkillID()
  return self._forceMovementSkillID
end

function FeatureEffectParamScan:GetSummonScanTrapSkillID()
  return self._summonScanTrapSkillID
end

function FeatureEffectParamScan:GetEmptySkillID()
  return self._emptySkillID
end

function FeatureEffectParamScan:IsDiedTrapIncluded()
  return self._diedTrapIncluded
end

function FeatureEffectParamScan:GetFeatureSummonTrapDescKey()
  return self._summonTrapDescKey
end
