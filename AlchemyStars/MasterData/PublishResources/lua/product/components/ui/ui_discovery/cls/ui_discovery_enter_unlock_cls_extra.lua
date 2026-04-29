_class("UIDiscoveryEnterUnlockClsExtra", UIDiscoveryEnterUnlockClsBase)
UIDiscoveryEnterUnlockClsExtra = UIDiscoveryEnterUnlockClsExtra

function UIDiscoveryEnterUnlockClsExtra:Constructor(moduleID, go, tex, img)
end

function UIDiscoveryEnterUnlockClsExtra:IsUnlock()
  return self._roleModule:CheckModuleUnlock(GameModuleID.MD_ExtMission) or self._roleModule:CheckModuleUnlock(GameModuleID.MD_CAMPAIGNREVIEW)
end
