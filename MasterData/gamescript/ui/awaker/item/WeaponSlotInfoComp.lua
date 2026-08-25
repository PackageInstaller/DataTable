local WeaponSlotComp, Super = System.NewComponent("WeaponSlotComp")

function WeaponSlotComp:ctor(uiNode, awakerModel, weaponSlotModel, awakerWeaponModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Panel_Weapon_Main_ItemResource(uiNode)
  self.awakerModel = awakerModel
  self.weaponSlotModel = weaponSlotModel
  self.weaponModel = awakerWeaponModel
end

function WeaponSlotComp:OnBind(binder)
  CameraManager:SetUICameraModel(true)
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
  binder:BindToVisible(self.ui.Image_Weapon_Quality, function()
    local qualityFrame = self.weaponSlotModel:GetWeaponQualityLarge()
    return qualityFrame and "" ~= qualityFrame
  end)
  binder:BindToText(self.ui.Text_WeaponName, function()
    do return self.weaponSlotModel.GetWeaponName end
    return self.weaponSlotModel.GetWeaponName, self.weaponSlotModel
  end)
  binder:BindToRaw(function(_, refineLevel)
    local rootStarsTrans = self.ui.RootStars.transform
    for idx = 0, rootStarsTrans.childCount - 1 do
      local starGO = rootStarsTrans:GetChild(idx).gameObject
      starGO:SetActive(refineLevel >= idx + 1)
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
end

function WeaponSlotComp:OnUnbind()
  CameraManager:SetUICameraModel(false)
end

return WeaponSlotComp
