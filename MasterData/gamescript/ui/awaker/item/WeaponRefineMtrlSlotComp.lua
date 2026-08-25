local WeaponRefineMtrlSlotComp, Super = System.NewComponent("WeaponRefineMtrlSlotComp")

function WeaponRefineMtrlSlotComp:ctor(go, slotIndex, awakerWeaponModel, clickCallback)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_Refining_ItemResource(go)
  self.slotIndex = slotIndex
  self.awakerWeaponModel = awakerWeaponModel
  self.clickCallback = clickCallback
end

function WeaponRefineMtrlSlotComp:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Selected, function()
    self.clickCallback()
  end)
  binder:BindToRaw(function(childBinder, mtrl)
    childBinder:SetActive(self.ui.UI_Common_Item_WuPin_Type1, nil ~= mtrl)
    if not mtrl then
      return
    end
    local item = ItemDataUtils.GetItemByUid(mtrl.uid)
    local itemData = {
      uid = item.uid,
      tid = item.tid,
      level = item.level,
      num = mtrl.num or 1
    }
    childBinder:BindComponent(WeaponRefineMaterial(self.ui.UI_Common_Item_WuPin_Type1, itemData, function()
      self.awakerWeaponModel:SubSelectedCostItemGroup(item.uid)
    end))
  end, function()
    return self.awakerWeaponModel.selectedCostItemGroup[self.slotIndex]
  end)
end

return WeaponRefineMtrlSlotComp
