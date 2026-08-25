local WeaponRefineMaterialTips, Super = System.NewComponent("WeaponRefineMaterialTips")

function WeaponRefineMaterialTips:ctor(uiNode, mtrl, lockCallback)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_TipResource(uiNode)
  self.mtrl = mtrl
  self.lockCallback = lockCallback
end

function WeaponRefineMaterialTips:OnBind(binder)
  local mtrlTID = self.mtrl.tid
  binder:BindToText(self.ui.Text_Name, function()
    do return ItemDataUtils.GetName end
    return ItemDataUtils.GetName, mtrlTID
  end)
  binder:BindToText(self.ui.Text_Type, function()
    do return ItemDataUtils.GetItemSubTypeName end
    return ItemDataUtils.GetItemSubTypeName, mtrlTID
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    do return ItemDataUtils.GetIcon end
    return ItemDataUtils.GetIcon, mtrlTID
  end)
  binder:BindToImage(self.ui.Image_Title_Quality, function()
    do return ItemDataUtils.GetTitleQualityFramePath end
    return ItemDataUtils.GetTitleQualityFramePath, mtrlTID
  end)
  binder:BindToImage(self.ui.Image_Bg_Quality, function()
    do return ItemDataUtils.GetBgQualityFramePath end
    return ItemDataUtils.GetBgQualityFramePath, mtrlTID
  end)
  self.ui.UI_Common_Btn_Lock:SetActive(false)
  local weaponDetailModel = binder:createModel(WeaponDetailModel, self.mtrl)
  self.ui.Text_Main_Property:SetActive(true)
  self.ui.Textt_Main_Property_Count:SetActive(true)
  self.ui.Group_Weapon_Attrs:SetActive(true)
  self.ui.Group_Weapon:SetActive(true)
  binder:BindToRaw(function(_, attr)
    local uiName = self.ui.Text_Main_Property
    local uiValue = self.ui.Textt_Main_Property_Count
    self:_SetAttr(binder, uiName, uiValue, attr)
  end, function()
    do return weaponDetailModel.GetSecondaryAttr end
    return weaponDetailModel.GetSecondaryAttr, weaponDetailModel
  end)
  binder:BindToRaw(function(_, primaryAttrs)
    local uiName_1 = self.ui.Text_Prim_Attr_Name_1
    local uiValue_1 = self.ui.Text_Prim_Attr_Value_1
    self:_SetAttr(binder, uiName_1, uiValue_1, primaryAttrs[1])
    local uiName_2 = self.ui.Text_Prim_Attr_Name_2
    local uiValue_2 = self.ui.Text_Prim_Attr_Value_2
    self:_SetAttr(binder, uiName_2, uiValue_2, primaryAttrs[2])
    local uiName_3 = self.ui.Text_Prim_Attr_Name_3
    local uiValue_3 = self.ui.Text_Prim_Attr_Value_3
    self:_SetAttr(binder, uiName_3, uiValue_3, primaryAttrs[3])
  end, function()
    do return weaponDetailModel.GetPrimaryAttrs end
    return weaponDetailModel.GetPrimaryAttrs, weaponDetailModel
  end)
  binder:BindToRaw(function(_, enhanceLevel)
    local enhanceLevelLimit = weaponDetailModel:GetEnhanceLevelLimit()
    binder:SetText(self.ui.Text_Grade, string.format("Lv.%s/%s", enhanceLevel, enhanceLevelLimit))
  end, function()
    do return weaponDetailModel.GetEnhanceLevel end
    return weaponDetailModel.GetEnhanceLevel, weaponDetailModel
  end)
  binder:BindToRaw(function(_, enhanceLevelLimit)
    local enhanceLevel = weaponDetailModel:GetEnhanceLevel()
    binder:SetText(self.ui.Text_Grade, string.format("Lv.%s/%s", enhanceLevel, enhanceLevelLimit))
  end, function()
    do return weaponDetailModel.GetEnhanceLevelLimit end
    return weaponDetailModel.GetEnhanceLevelLimit, weaponDetailModel
  end)
  binder:BindToRaw(function(_, breakthroughStar)
    local rootStarsTrans = self.ui.Group_Breakthrough_Stars.transform
    for idx = 0, rootStarsTrans.childCount - 1 do
      local starGO = rootStarsTrans:GetChild(idx).gameObject
      starGO:SetActive(breakthroughStar >= idx + 1)
    end
  end, function()
    do return weaponDetailModel.GetBreakthroughStar end
    return weaponDetailModel.GetBreakthroughStar, weaponDetailModel
  end)
  binder:BindToText(self.ui.Text_Weapon_Level, function()
    do return LT.Textf, "WeaponRefineLevel", weaponDetailModel:GetWeaponlevel() end
    return LT.Textf, "WeaponRefineLevel", weaponDetailModel:GetWeaponlevel()
  end)
  binder:BindToRaw(function(_, weaponLevel)
    local rootStarsTrans = self.ui.Group_Stars.transform
    for idx = 0, rootStarsTrans.childCount - 1 do
      local starGO = rootStarsTrans:GetChild(idx).gameObject
      starGO:SetActive(weaponLevel >= idx + 1)
    end
  end, function()
    do return weaponDetailModel.GetWeaponlevel end
    return weaponDetailModel.GetWeaponlevel, weaponDetailModel
  end)
  binder:BindToRaw(function(cb, value)
    cb:BindTimer(0.01, 0, nil, function()
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_Tip_List)
    end)
    if "" == value then
      self.ui.Text_Weapon_Desc_1:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_1:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_1, value)
  end, function()
    do return weaponDetailModel.GetStateDesc end
    return weaponDetailModel.GetStateDesc, weaponDetailModel
  end)
  binder:BindToRaw(function(_, value)
    if "" == value then
      self.ui.Text_Weapon_Desc_2:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_2:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_2, value)
  end, function()
    do return weaponDetailModel.GetExclusiveDesc end
    return weaponDetailModel.GetExclusiveDesc, weaponDetailModel
  end)
  binder:BindToText(self.ui.Text_Story, function()
    do return weaponDetailModel.GetStory end
    return weaponDetailModel.GetStory, weaponDetailModel
  end)
end

function WeaponRefineMaterialTips:_SetAttr(binder, uiName, uiValue, attr)
  local attrConfig = DT.ActorAttrType[attr.id]
  local name = LT.Text(attrConfig.Text)
  local value = math.ceil(attr.value)
  value = attrConfig.Percentage and value .. "%" or value
  binder:SetText(uiName, name)
  binder:SetText(uiValue, value)
end

function WeaponRefineMaterialTips:OnUnbind()
  Super.OnUnbind(self)
end

return WeaponRefineMaterialTips
