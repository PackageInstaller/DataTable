local WeaponSlotComp, Super = System.NewComponent("WeaponSlotComp")

function WeaponSlotComp:ctor(uiNode, awakerModel, weaponSlotModel, awakerWeaponModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Panel_Weapon_Main_ItemResource(uiNode)
  self.awakerModel = awakerModel
  self.weaponSlotModel = weaponSlotModel
  self.weaponModel = awakerWeaponModel
  self.refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  self.refineStage1Stars = AwakerBreakthroughStars(self.ui.RootStars, self.refineStage1MaxLevel)
end

function WeaponSlotComp:OnBind(binder)
  binder:BindToVisible(self.ui.Group_Lock, function()
    do return self.weaponSlotModel.IsLocked end
    return self.weaponSlotModel.IsLocked, self.weaponSlotModel
  end)
  binder:BindToVisible(self.ui.Group_Empty, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return false
    end
    return not self.weaponSlotModel:IsLocked() and not self.weaponSlotModel:HasWeapon()
  end)
  binder:BindToVisible(self.ui.Group_Weapon_Info, function()
    do return self.weaponSlotModel.HasWeapon end
    return self.weaponSlotModel.HasWeapon, self.weaponSlotModel
  end)
  binder:BindToRaw(function(childBinder, path)
    if "" ~= path then
      childBinder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon_Large, path, 0.8))
    end
  end, function()
    do return self.weaponSlotModel.GetWeaponIconLarge end
    return self.weaponSlotModel.GetWeaponIconLarge, self.weaponSlotModel
  end)
  binder:BindToImage(self.ui.Image_Weapon_Quality, function()
    do return self.weaponSlotModel.GetWeaponQualityLarge end
    return self.weaponSlotModel.GetWeaponQualityLarge, self.weaponSlotModel
  end)
  binder:BindToText(self.ui.Text_WeaponName, function()
    do return self.weaponSlotModel.GetWeaponName end
    return self.weaponSlotModel.GetWeaponName, self.weaponSlotModel
  end)
  binder:BindToRaw(function(_, refineLevel)
    for idx = 1, self.refineStage1Stars:NumStars() do
      if idx <= refineLevel then
        self.refineStage1Stars:TurnOn(idx)
      else
        self.refineStage1Stars:TurnOff(idx)
      end
    end
    if refineLevel > self.refineStage1MaxLevel then
      self.ui.RootLevel:SetActive(true)
      binder:SetText(self.ui.Text_Level, refineLevel - self.refineStage1MaxLevel)
    else
      self.ui.RootLevel:SetActive(false)
    end
  end, function()
    do return self.weaponSlotModel.GetWeaponRefineLevel end
    return self.weaponSlotModel.GetWeaponRefineLevel, self.weaponSlotModel
  end)
  binder:BindToRaw(function(_, attr)
    if attr.id then
      local attrCfg = DT.ActorAttrType[attr.id]
      local name = LT.Text(attrCfg.Text)
      local value = attr.value
      value = attrCfg.Percentage and value .. "%" or value
      binder:SetImage(self.ui.Attr_Icon, attrCfg.Icon)
      binder:SetText(self.ui.Attr_Name, name)
      binder:SetText(self.ui.Attr_Num, value)
    end
  end, function()
    do return self.weaponSlotModel.GetWeaponSecondaryAttr end
    return self.weaponSlotModel.GetWeaponSecondaryAttr, self.weaponSlotModel
  end)
  binder:BindToText(self.ui.Text_WeaponInfo, function()
    do return self.weaponSlotModel.GetStateDesc end
    return self.weaponSlotModel.GetStateDesc, self.weaponSlotModel
  end)
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if table.next(AwakerDataUtils.GetMockAwakerMap()) then
      return
    end
    if self.weaponSlotModel:IsLocked() then
      local tips = self.weaponSlotModel:GetLockTips()
      Alert.ShowStr(tips)
      return
    end
    local slotType = self.weaponSlotModel:GetType()
    self.weaponModel:SelectWeaponSlot(slotType)
    self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.WeaponChange)
    self.weaponModel:SetSelectedChangeWeaponUid(self.weaponModel.weapon.uid)
  end)
end

return WeaponSlotComp
