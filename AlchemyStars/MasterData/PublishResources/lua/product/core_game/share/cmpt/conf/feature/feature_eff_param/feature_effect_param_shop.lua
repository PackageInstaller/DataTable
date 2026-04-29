_class("FeatureEffectParamShop", FeatureEffectParamBase)
FeatureEffectParamShop = FeatureEffectParamShop

function FeatureEffectParamShop:Constructor(t)
  if not t then
    return
  end
  self:_RefreshData(t)
end

function FeatureEffectParamShop:_RefreshData(t)
  if not t then
    return
  end
  if t.SkillID then
    self._skillID = t.SkillID
  end
  if t.EnterCoinCount then
    self._enterCoinCount = t.EnterCoinCount
  end
  if t.GroupDataList then
    self._groupDataList = t.GroupDataList
  end
  if t.UnlockParam then
    self._unlockParam = t.UnlockParam
  end
  if t.UnlockParam1 then
    self._unlockParam1 = t.UnlockParam1
  end
  if t.UnlockParam2 then
    self._unlockParam2 = t.UnlockParam2
  end
  if t.AddAttackParam then
    self._addAttackParam = t.AddAttackParam
  end
end

function FeatureEffectParamShop:GetFeatureType()
  return FeatureType.Shop
end

function FeatureEffectParamShop:GetSkillID()
  return self._skillID
end

function FeatureEffectParamShop:GetGroupDataList()
  return self._groupDataList
end

function FeatureEffectParamShop:GetUnlockParam()
  local unlockParam = {}
  if self._unlockParam1 then
    unlockParam[1] = self._unlockParam1
  end
  if self._unlockParam2 then
    unlockParam[2] = self._unlockParam2
  end
  if self._unlockParam then
    unlockParam = self._unlockParam
  end
  return unlockParam
end

function FeatureEffectParamShop:GetEnterCoinCount()
  return self._enterCoinCount or 0
end

function FeatureEffectParamShop:GetAddAttackParam()
  return self._addAttackParam
end
