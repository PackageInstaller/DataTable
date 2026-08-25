local PVPCollectionIconItem, Super = System.NewComponent("PVPCollectionIconItem")

function PVPCollectionIconItem:ctor(uiNode, collectTid, clickCallback, isSelectedFunc)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_List_2Resource(uiNode)
  self.collectTid = collectTid
  self.clickCallback = clickCallback
  self.isSelectedFunc = isSelectedFunc
end

function PVPCollectionIconItem:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Image_Awaker, System.fn(self, self._GetAwakerOrKeeperSkillCollectionIcon))
  binder:BindToImage(self.ui.Image_Weapon, System.fn(self, self._GetWeaponCollectionIcon))
  local weaponCollectionType = CommonDefine.PVPCollectionType.Weapon
  binder:BindToVisible(self.ui.Image_Awaker, System.fn(self, self._IsAwakerOrKeeperSkill))
  binder:BindToVisible(self.ui.Image_Weapon_Mask, System.bind(self._IsTargetCollectionType, self, weaponCollectionType))
  binder:BindToVisible(self.ui.Image_Select, System.fn(self, self._IsSelected))
  binder:BindToVisible(self.ui.Group_None, System.fn(self, self._IsCollectionLocked))
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClick))
  binder:BindToVisible(self.ui.TemporaryUnLock, function()
    do return PVPCollectionDataUtils.IsUnlockByBattlePass end
    return PVPCollectionDataUtils.IsUnlockByBattlePass, self.collectTid
  end)
end

function PVPCollectionIconItem:_IsTargetCollectionType(targetType)
  local collectTid = self.collectTid
  if not (targetType and collectTid) or 0 == collectTid then
    return
  end
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  return collectionType and collectionType == targetType
end

function PVPCollectionIconItem:_IsAwakerOrKeeperSkill()
  local awakerCollectionType = CommonDefine.PVPCollectionType.Awaker
  local keeperSkillCollectionType = CommonDefine.PVPCollectionType.KeeperSkill
  local result = self:_IsTargetCollectionType(awakerCollectionType) or self:_IsTargetCollectionType(keeperSkillCollectionType)
  return result
end

function PVPCollectionIconItem:_GetAwakerOrKeeperSkillCollectionIcon()
  local weaponCollectionType = CommonDefine.PVPCollectionType.Weapon
  if self:_IsTargetCollectionType(weaponCollectionType) then
    return
  end
  local collectionType = PvpCollectCfgUtils.GetCollectionType(self.collectTid)
  if collectionType == CommonDefine.PVPCollectionType.KeeperSkill then
    do return PVPCollectionDataUtils.GetKeeperSkillCollectionPortrait end
    return PVPCollectionDataUtils.GetKeeperSkillCollectionPortrait, self.collectTid, nil, nil
  end
  local awakerTid = PvpCollectCfgUtils.GetAwakerTidByCollectTid(self.collectTid)
  if awakerTid then
    do return AwakerDataUtils.GetLittleIcon, awakerTid end
    return AwakerDataUtils.GetLittleIcon, awakerTid, false
  end
  do return PvpCollectCfgUtils.GetCollectionFormationImage end
  return PvpCollectCfgUtils.GetCollectionFormationImage, self.collectTid, false
end

function PVPCollectionIconItem:_GetWeaponCollectionIcon()
  if self:_IsAwakerOrKeeperSkill() then
    return
  end
  do return PvpCollectCfgUtils.GetCollectionFormationImage end
  return PvpCollectCfgUtils.GetCollectionFormationImage, self.collectTid
end

function PVPCollectionIconItem:_IsSelected()
  if self.isSelectedFunc then
    do return end
    return self.isSelectedFunc
  end
  return false
end

function PVPCollectionIconItem:_IsCollectionLocked()
  return not PVPCollectionDataUtils.HasOwnedCollection(self.collectTid)
end

function PVPCollectionIconItem:_OnClick()
  if self.clickCallback then
    self.clickCallback()
  end
end

return PVPCollectionIconItem
