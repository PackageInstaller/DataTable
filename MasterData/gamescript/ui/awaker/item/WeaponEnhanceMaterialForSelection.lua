local WeaponEnhanceMaterialForSelection, Super = System.NewComponent("WeaponEnhanceMaterialForSelection")

function WeaponEnhanceMaterialForSelection:ctor(go, model, mtrl, weaponDetailModel)
  Super.ctor(self)
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.model = model
  self.mtrl = mtrl
  self.weaponDetailModel = weaponDetailModel
end

function WeaponEnhanceMaterialForSelection:OnBind(binder)
  self.binder = binder
  binder:BindToImage(self.ui.Icon_Article, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, self.mtrl.tid
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    local config = DT.Item[self.mtrl.tid]
    do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
    return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    if self.mtrl.isWeapon then
      do return string.format, "Lv.%s" end
      return string.format, "Lv.%s", self.mtrl.enhanceLevel
    else
      return self.mtrl.count
    end
  end)
  binder:BindToRaw(function(_, refineLevel)
    self.ui.Group_Refine_Level:SetActive(self.mtrl.isWeapon)
    binder:SetText(self.ui.Text_Refine_Level, refineLevel)
  end, function()
    return self.mtrl.refineLevel
  end, nil)
  binder:BindToRaw(function(_, selectCount)
    self.ui.Group_Sub_Select:SetActive(selectCount > 0)
    self.ui.Btn_Sub_Subtract:SetActive(selectCount > 0)
    self.ui.Image_Tick:SetActive(self.mtrl.isWeapon)
    self.ui.Text_Article_Count:SetActive(not self.mtrl.isWeapon)
    binder:SetText(self.ui.Text_Article_Count, selectCount)
  end, function()
    return self.mtrl.selectCount
  end, nil)
  if self.mtrl.isWeapon then
    self:_BindPressDown(binder)
  else
    binder:BindToRaw(function(childBinder, bindPressDown)
      if bindPressDown then
        self:_BindPressDown(childBinder)
      else
        self:_BindLongPress(childBinder)
      end
    end, function()
      local model = self.weaponDetailModel
      local reachEnhanceLevelLimit = model:IsReachEnhanceLevelLimit()
      local mtrlsCanReachLevelLimit = self.model:MtrlsInSlotsCanReachLevelLimit().canReach
      local selectCount = self.mtrl.selectCount
      local item = ItemDataUtils.GetItemByUid(self.mtrl.uid)
      local totalCount = item and item.num or 0
      return reachEnhanceLevelLimit or mtrlsCanReachLevelLimit or selectCount == totalCount
    end, nil)
  end
  binder:BindLongPressButton(self.ui.Btn_Sub_Subtract, function()
  end, function()
    self.model:UnselectMtrl(self.mtrl.uid)
    self.model:SetSortTypeShow(false)
  end, tonumber(DT.GetConstant("ItemAddPressTime")))
end

function WeaponEnhanceMaterialForSelection:_BindLongPress(binder)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
    self:_SelectMtrl()
  end, function()
    self:_SelectMtrl()
  end, tonumber(DT.GetConstant("ItemAddPressTime")))
end

function WeaponEnhanceMaterialForSelection:_BindPressDown(binder)
  binder:BindPressDown(self.ui.Btn_Click, function()
    self:_SelectMtrl()
  end)
end

function WeaponEnhanceMaterialForSelection:_SelectMtrl()
  self.model:SelectMtrl(self.mtrl.uid)
  self.model:SetSortTypeShow(false)
end

return WeaponEnhanceMaterialForSelection
