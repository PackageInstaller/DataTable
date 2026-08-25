local WeaponMainDetailComp, Super = System.NewComponent("WeaponMainDetailComp")

function WeaponMainDetailComp:ctor(uiNode, model, displayType)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_EntranceResource(uiNode)
  self.model = model
  self.displayType = displayType
  self:_SetActiveStateForDisplayType()
end

function WeaponMainDetailComp:_SetActiveStateForDisplayType()
  self.ui.RootAwakerName:SetActive(self.displayType == CommonDefine.WeaponEnhance.DetailPanelType_1)
  self.ui.Group_Awaker_Equip:SetActive(self.displayType == CommonDefine.WeaponEnhance.DetailPanelType_2)
end

function WeaponMainDetailComp:OnBind(binder)
  self.binder = binder
  local model = self.model
  binder:SetText(self.ui.Text_Unequip, LT.Text("WeaponUnequip"))
  binder:BindToRaw(function(_, tid)
    self.ui.Bg:SetActive(tid and tid > 0)
    self.ui.UI_Common_Btn_Lock:SetActive(false)
    self.ui.RootSecAttribute:SetActive(tid and tid > 0)
    self.ui.Group_Bg:SetActive(tid and tid > 0)
  end, function()
    return model.weapon.tid
  end)
  binder:BindToText(self.ui.Text_Weapon_Name, function()
    do return model.GetWeaponName end
    return model.GetWeaponName, model
  end)
  binder:BindToRaw(function(_, attr)
    local uiIcon = self.ui.Image_Icon
    local uiName = self.ui.Text_Secondary_Attr
    local uiValue = self.ui.Text_Secondary_Attr_Value
    self:_SetAttr(binder, uiIcon, uiName, uiValue, attr)
  end, function()
    do return model.GetSecondaryAttr end
    return model.GetSecondaryAttr, model
  end)
  binder:BindToRaw(function(_, refineLevel)
    self.ui.RefineStage1_Star1:SetActive(refineLevel >= 1)
    self.ui.RefineStage1_Star2:SetActive(refineLevel >= 2)
    self.ui.RefineStage1_Star3:SetActive(refineLevel >= 3)
    local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
    self.ui.RefineStage2Bg:SetActive(refineLevel > refineStage1MaxLevel)
    self.ui.RefineStage2_Level:SetActive(refineLevel > refineStage1MaxLevel)
    binder:SetText(self.ui.RefineStage2_Level, refineLevel - refineStage1MaxLevel)
  end, function()
    do return model.GetWeaponlevel end
    return model.GetWeaponlevel, model
  end)
  binder:BindToRaw(function(cb, value)
    cb:BindTimer(0.01, 0, nil, function()
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
    end)
    if "" == value then
      self.ui.Text_Weapon_Desc_1:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_1:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_1, value, nil, nil, true)
  end, function()
    do return model.GetStateDesc end
    return model.GetStateDesc, model
  end)
  binder:BindToRaw(function(_, value)
    if "" == value then
      self.ui.Text_Weapon_Desc_2:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_2:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_2, value)
  end, function()
    do return model.GetExclusiveDesc end
    return model.GetExclusiveDesc, model
  end)
  binder:BindToText(self.ui.Text_Weapon_Desc_Sec, function()
    do return model.GetStory end
    return model.GetStory, model
  end)
  self:_OnBindForDisplayType(binder, model)
end

function WeaponMainDetailComp:_SetAttr(binder, uiIcon, uiName, uiValue, attr)
  if not attr or not attr.id then
    return
  end
  local attrConfig = DT.ActorAttrType[attr.id]
  binder:SetImage(uiIcon, attrConfig.Icon)
  local text = attrConfig and attrConfig.Text or ""
  binder:SetText(uiName, LT.Text(text))
  if 0 == self.model.weapon.tid then
    binder:SetText(uiValue, "-")
  else
    local attrShowVal = attr.value
    local value
    if attrConfig and attrConfig.Percentage then
      value = attrShowVal .. "%"
    else
      value = attrShowVal
    end
    binder:SetText(uiValue, value)
  end
end

function WeaponMainDetailComp:_OnBindForDisplayType(binder, model)
  if self.displayType == CommonDefine.WeaponEnhance.DetailPanelType_1 then
    self:_OnBindForPanelType_1(binder, model)
  elseif self.displayType == CommonDefine.WeaponEnhance.DetailPanelType_2 then
    self:_OnBindForPanelType_2(binder, model)
  end
end

function WeaponMainDetailComp:_OnBindForPanelType_1(binder, model)
  binder:BindToVisible(self.ui.Text_Awaker_Name, function()
    do return model.HasOwner end
    return model.HasOwner, model
  end)
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    do return model.GetAwakerName end
    return model.GetAwakerName, model
  end)
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    do return model.GetSchoolIcon end
    return model.GetSchoolIcon, model
  end)
  binder:BindToText(self.ui.Text_Career_Name, function()
    do return model.GetAwakerQualityDesc end
    return model.GetAwakerQualityDesc, model
  end)
end

function WeaponMainDetailComp:_OnBindForPanelType_2(binder, model)
  binder:BindToVisible(self.ui.Group_Awaker_Equip, function()
    do return model.HasOwner end
    return model.HasOwner, model
  end)
  binder:BindToImage(self.ui.Icon_Awaker, function()
    do return model.GetAwakerIcon end
    return model.GetAwakerIcon, model
  end)
  binder:BindToText(self.ui.Text_Weapon_Equip, function()
    do return LT.Textf, "TipsAwakerEquip", model:GetAwakerName() end
    return LT.Textf, "TipsAwakerEquip", model:GetAwakerName()
  end)
end

function WeaponMainDetailComp:OnUnbind()
  Super.OnUnbind(self)
end

return WeaponMainDetailComp
