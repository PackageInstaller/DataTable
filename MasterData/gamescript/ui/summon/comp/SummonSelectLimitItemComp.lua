local SummonSelectLimitItemComp, Super = System.NewComponent("SummonSelectLimitItemComp")
SummonSelectLimitItemComp.uiResCls = UI_Summon_Item_SelectLimitResource

function SummonSelectLimitItemComp:ctor(uiNode, itemTid, showWeapon)
  Super.ctor(self)
  self.ui = SummonSelectLimitItemComp.uiResCls(uiNode)
  self.itemTid = itemTid
  self.showWeapon = true == showWeapon
  self.weaponItemTid = nil
end

function SummonSelectLimitItemComp:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self._OnClickAwaker))
  self:_BindWeaponClick()
  self:_RefreshView()
end

function SummonSelectLimitItemComp:_EnsureButton(owner)
  if not owner then
    return nil
  end
  local buttonComp = owner:GetComponent(typeof(CS.UnityEngine.UI.Button))
  if buttonComp then
    return buttonComp
  end
  buttonComp = CS.Framework.GameObjectUtil.AddComponentOnce(owner, typeof(CS.UnityEngine.UI.Button))
  if buttonComp then
    buttonComp.transition = CS.UnityEngine.UI.Selectable.Transition.None
  end
  return buttonComp
end

function SummonSelectLimitItemComp:_SetWeaponRaycastTarget(enable)
  if not self.ui.Image_Weapon then
    return
  end
  local imageComp = self.ui.Image_Weapon:GetComponent(typeof(CS.UnityEngine.UI.Image))
  if imageComp then
    imageComp.raycastTarget = true == enable
  end
end

function SummonSelectLimitItemComp:_BindWeaponClick()
  if not self.showWeapon or not self.ui.Image_Weapon then
    return
  end
  if not self:_EnsureButton(self.ui.Image_Weapon) then
    return
  end
  self.ui.Image_Weapon.transform:SetAsLastSibling()
  self.binder:BindButtonClick(self.ui.Image_Weapon, System.fn(self, self._OnClickWeapon))
end

function SummonSelectLimitItemComp:_OnClickAwaker()
  SummonUiUtils.ShowAwakerDetailByItemTid(self.itemTid)
end

function SummonSelectLimitItemComp:_OnClickWeapon()
  if not self.weaponItemTid then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Image_Weapon, nil, self.weaponItemTid, nil, {showWeaponHave = true})
end

function SummonSelectLimitItemComp:_RefreshView()
  self:_RefreshAwakerIcon()
  self:_RefreshWeaponIcon()
end

function SummonSelectLimitItemComp:_RefreshAwakerIcon()
  if not self.itemTid or not self.binder then
    return
  end
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.itemTid)
  local iconPath = AwakerDataUtils.GetAwakerBust(awakerTid, 0)
  if self.ui.Image_Awaker then
    self.binder:SetImage(self.ui.Image_Awaker, iconPath)
  end
end

function SummonSelectLimitItemComp:_RefreshWeaponIcon()
  if not self.ui.Image_Weapon or not self.binder then
    return
  end
  self.weaponItemTid = nil
  if not self.showWeapon or not self.itemTid then
    self:_SetWeaponRaycastTarget(false)
    self.binder:SetActive(self.ui.Image_Weapon, false)
    return
  end
  local weaponItemTid = SummonCategorySelectDataUtils.GetRecommendWeaponItemTid(self.itemTid)
  self.weaponItemTid = weaponItemTid
  local hasWeapon = nil ~= weaponItemTid
  self:_SetWeaponRaycastTarget(hasWeapon)
  self.binder:SetActive(self.ui.Image_Weapon, hasWeapon)
  if not hasWeapon then
    return
  end
  self.binder:SetImage(self.ui.Image_Weapon, ItemDataUtils.GetItemIcon(weaponItemTid))
  self.ui.Image_Weapon.transform:SetAsLastSibling()
end

function SummonSelectLimitItemComp:UpdateItemTid(itemTid)
  self.itemTid = itemTid
  self:_RefreshView()
end

return SummonSelectLimitItemComp
