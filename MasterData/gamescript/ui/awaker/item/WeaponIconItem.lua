local WeaponIconItem, Super = System.NewComponent("WeaponIconItem", CommonIconItem)

function WeaponIconItem:ctor(uiNode, data, awakerModel, awakerWeaponModel, primaryWeaponSlotModel, secondaryWeaponSlotModel)
  Super.ctor(self, uiNode, data)
  self.data = data
  self.awakerModel = awakerModel
  self.awakerWeaponModel = awakerWeaponModel
  self.primaryWeaponSlotModel = primaryWeaponSlotModel
  self.secondaryWeaponSlotModel = secondaryWeaponSlotModel
end

function WeaponIconItem:OnBind(binder)
  Super.OnBind(self, binder)
  binder:BindToVisible(self.ui.Group_NoEquip, function()
    return self:_SSRForbidden() or self:_SameWeaponForbidden()
  end)
end

function WeaponIconItem:OnClick()
  if self:_SSRForbidden() then
    Alert.Show(10702)
    return
  end
  if self:_SameWeaponForbidden() then
    Alert.Show(10703)
    return
  end
  Super.OnClick(self)
end

function WeaponIconItem:_SSRForbidden()
  local awakerTid = self.awakerModel.selectAwakerId
  local awaker = self.awakerModel:GetAwakerData(awakerTid)
  local unselectedSlotType = self:_GetUnselectedSlotType()
  local unselectedSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, unselectedSlotType)
  if not unselectedSlot.unlocked then
    return false
  end
  if 0 == unselectedSlot.weaponUid then
    return false
  end
  do return AwakerDataUtils.CheckSSRWeaponForbidden, self.data.uid end
  return AwakerDataUtils.CheckSSRWeaponForbidden, self.data.uid, unselectedSlot.weaponUid
end

function WeaponIconItem:_SameWeaponForbidden()
  local awakerTid = self.awakerModel.selectAwakerId
  local awaker = self.awakerModel:GetAwakerData(awakerTid)
  local unselectedSlotType = self:_GetUnselectedSlotType()
  local unselectedSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, unselectedSlotType)
  if not unselectedSlot.unlocked then
    return false
  end
  if 0 == unselectedSlot.weaponUid then
    return false
  end
  do return AwakerDataUtils.CheckSameWeaponForbidden, self.data.tid end
  return AwakerDataUtils.CheckSameWeaponForbidden, self.data.tid, unselectedSlot.weaponUid
end

function WeaponIconItem:_GetUnselectedSlotType()
  local selectedSlotType = self.awakerWeaponModel:GetCurrSelectedWeaponSlotType()
  if selectedSlotType == CommonDefine.WeaponSlotType.Primary then
    return CommonDefine.WeaponSlotType.Secondary
  elseif selectedSlotType == CommonDefine.WeaponSlotType.Secondary then
    return CommonDefine.WeaponSlotType.Primary
  end
end

return WeaponIconItem
