local WeaponEnhanceMtrlSlot, Super = System.NewComponent("WeaponEnhanceMtrlSlot")

function WeaponEnhanceMtrlSlot:ctor(go, slot, mtrlModel, weaponDetailModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_MaterialResource(go)
  self.slot = slot
  self.mtrlModel = mtrlModel
  self.weaponDetailModel = weaponDetailModel
end

function WeaponEnhanceMtrlSlot:OnBind(binder)
  self.binder = binder
  binder:BindToRaw(function(childBinder, tid)
    local mtrlGO = self.ui.UI_Common_Item_WuPin_Type1
    if tid then
      mtrlGO:SetActive(true)
      childBinder:BindComponent(WeaponEnhanceMaterial(mtrlGO, self.slot))
    else
      mtrlGO:SetActive(false)
    end
    childBinder:BindButtonClick(self.ui.Btn_Click, function()
      UIManager.Instance:Reopen(Urls.AwakerWeaponEnhanceMtrlSelection, self.mtrlModel, self.weaponDetailModel)
      if self.slot.uid then
        self.mtrlModel:SetCurrClickedMtrl(self.slot.uid)
      end
    end)
  end, function()
    return self.slot.tid
  end, nil)
end

return WeaponEnhanceMtrlSlot
