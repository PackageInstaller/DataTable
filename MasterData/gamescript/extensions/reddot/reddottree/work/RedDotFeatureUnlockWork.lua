local RedDotFeatureUnlockWork, Super = System.NewPoolClass("RedDotFeatureUnlockWork", RedDotSingleFlow)

function RedDotFeatureUnlockWork:ctor(featureId, featureKey)
  Super.ctor(self, "功能解锁检查节点")
  self.featureId = featureId
  self.featureKey = featureKey or PlayerDataUtils.GetFeatureMainTypeKey()
end

function RedDotFeatureUnlockWork:Execute()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(self.featureId, self.featureKey)
  if not unlocked then
    return RedDotDefine.RedDotType.None
  end
  return false
end

return RedDotFeatureUnlockWork
