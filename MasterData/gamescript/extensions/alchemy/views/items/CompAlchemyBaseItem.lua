local ItemType = CommonDefine.ItemType
local CompAlchemyBaseItem, Super = NewViewComponent("CompAlchemyBaseItem")

function CompAlchemyBaseItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_WuPin_Type1Resource(uiNode)
  self.data = data
  self.tid = data.tid
  self.uid = data.uid
  self.num = data.num
  self.clickCb = data.clickCb
  self.alchemyItemType = data.alchemyItemType
  self.selectFunc = data.selectFunc
  self.btnSubFunc = data.btnSubFunc
  self.selectedFunc = data.selectedFunc
  self.itemLockFunc = data.itemLockFunc
  self.numFunc = data.numFunc
  self.config = DT.Item[self.tid] or {}
  self.itemType = self.config.Type
end

function CompAlchemyBaseItem:OnEnterComponent()
  local config = self.config
  local itemType = config.Type
  local isSelected = self.selectedFunc and self.selectedFunc()
  self.ui.Image_Bg_White:SetActive(false)
  self.ui.Image_Select:SetActive(self:_GetImageSelectActive())
  self.ui.Image_Michi:SetActive(itemType == ItemType.Trinket)
  self.ui.Image_Dis:SetActive(self.itemLockFunc and self.itemLockFunc())
  self.ui.Image_Sub_Lock:SetActive(self:_GetSubLockActive())
  self.ui.Image_Get_Frame:SetActive(false)
  self.ui.Image_Get_Icon:SetActive(false)
  self.ui.Btn_Sub_Subtract:SetActive(isSelected)
  self.ui.Group_Sub_Select:SetActive(isSelected)
  self.ui.Image_Tick:SetActive(isSelected)
  self.ui.Group_Using:SetActive(self.isUsingFunc and self.isUsingFunc())
  self:SetImage(self.ui.Icon_Article, config.Icon)
  self:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(config, self.ui.Image_Bg_Black))
  self:SetImage(self.ui.Image_Icon, self:_GetIconImage())
  self:SetText(self.ui.Text_Article_Number, self:_GetTextNumber())
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Click, tonumber(DT.GetConstant("Role_Press_Time")))
  self:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnClick))
  self:_RefresWeaponView()
  self:SetLongPressButtonIntervalTime(self.ui.Btn_Sub_Subtract, tonumber(DT.GetConstant("Role_Press_Time")))
  self:AddShortPressButtonListener(self.ui.Btn_Sub_Subtract, function()
    if self.btnSubFunc then
      self.btnSubFunc()
    end
  end)
end

function CompAlchemyBaseItem:_RefresWeaponView()
  self.ui.Group_Stars:SetActive(self.itemType == CommonDefine.ItemType.Weapon)
  if self.itemType ~= CommonDefine.ItemType.Weapon then
    return
  end
  local level = ItemDataUtils.GetWeaponLevel(self.uid)
  local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  local numStars = math.min(level, refineStage1MaxLevel)
  for i = 1, 5 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if level > refineStage1MaxLevel then
    self.ui.Image_Max:SetActive(true)
    self:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
end

function CompAlchemyBaseItem:OnClick()
  if self.clickCb then
    self.clickCb()
  end
end

function CompAlchemyBaseItem:GetTrinketLevel()
  local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.uid)
  return completRate .. "%"
end

function CompAlchemyBaseItem:_GetTextNumber()
  if self.numFunc then
    do return end
    return self.numFunc, nil, nil, nil, nil, nil, nil
  end
  local config = DT.Item[self.tid]
  if self.itemType == CommonDefine.ItemType.Weapon then
    return ""
  end
  if self.itemType == CommonDefine.ItemType.Trinket then
    do return self.GetTrinketLevel end
    return self.GetTrinketLevel, self, nil, nil, nil, nil
  end
  if self.alchemyItemType == AlchemyDefine.AlchemyItemType.Formula then
    return config.Name
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.CompositeCostItem then
    local haveNum = ItemDataUtils.GetItemNum(self.tid)
    local consumeData = AlchemyCompositeExtModel.Instance:GetConsumeDataByTid(self.tid)
    if not consumeData then
      return ""
    end
    if haveNum < self.num then
      do return LT.Textf, "<color=#FA3A50>{s1}</color>/{s2}", haveNum end
      return LT.Textf, "<color=#FA3A50>{s1}</color>/{s2}", haveNum, self.num
    end
    do return LT.Textf, "{s1}/{s2}", haveNum end
    return LT.Textf, "{s1}/{s2}", haveNum, self.num
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.DecompositeConvertItem then
    do return LT.Text end
    return LT.Text, self.num, LT.Textf, "{s1}/{s2}", haveNum, self.num
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.RecastTrinketItem then
    do return self.GetTrinketLevel end
    return self.GetTrinketLevel, self, LT.Textf, "{s1}/{s2}", haveNum, self.num
  end
  return self.num or ""
end

function CompAlchemyBaseItem:_GetImageSelectActive()
  if self.selectFunc then
    do return end
    return self.selectFunc
  end
  return false
end

function CompAlchemyBaseItem:_GetIconImage()
  if not self.uid then
    return ""
  end
  if self.itemType ~= ItemType.Trinket then
    return ""
  end
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.uid)
  if not mainAttr then
    return ""
  end
  local attrType = DT.ActorAttrType[mainAttr.attrId]
  return attrType and attrType.Icon or ""
end

function CompAlchemyBaseItem:_GetSubLockActive()
  if self.itemType ~= CommonDefine.ItemType.Weapon and self.itemType ~= CommonDefine.ItemType.Trinket then
    return false
  end
  local locked = ItemDataUtils.GetItemLocked(self.uid)
  return locked
end

function CompAlchemyBaseItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompAlchemyBaseItem
