local ItemType = CommonDefine.ItemType
local ItemAddSpeed = tonumber(DT.GetConstant("ItemAddSpeed"))
local AlchemyIconBase = NewClass("AlchemyIconBase")

function AlchemyIconBase:ctor(container)
  self.gameObject = container.gameObject
  self.data = nil
  self.ui = UI_Common_Item_WuPin_Type1Resource(container.gameObject)
end

function AlchemyIconBase:GetData()
  return self.data
end

function AlchemyIconBase:SetProxy(proxy)
  self.proxy = proxy
end

function AlchemyIconBase:SetData(data)
  self.data = data
  self.tid = data.tid
  self.uid = data.uid
  self.num = data.num
  self.numFunc = data.numFunc
  self.clickCb = data.clickCb
  self.selectFunc = data.selectFunc
  self.selectedFunc = data.selectedFunc
  self.btnSubFunc = data.btnSubFunc
  self.itemLockFunc = data.itemLockFunc
  self.alchemyItemType = data.alchemyItemType
  self.isUsingFunc = data.isUsingFunc
  self.sortType = data.sortType or CommonDefine.AwakerTrinketSortType.Level
  self.remainTimes = data.remainTimes
  self.refreshTime = data.refreshTime
  self.conversionId = data.conversionId
  self.selectNumFunc = data.selectNumFunc
  self.showMultiSelect = data.showMultiSelect
  self.addLongPressFunc = data.addLongPressFunc
  self.subLongPressFunc = data.subLongPressFunc
end

function AlchemyIconBase:SetView(view)
  self.view = view
end

function AlchemyIconBase:Dispose()
end

function AlchemyIconBase:OnActive()
  if self.gameObject and self.view and self.view.binder then
    self.view.binder:UpdateLocalizedTextAndResouce(self.gameObject)
  end
  self:Refresh()
end

function AlchemyIconBase:OnDeative()
end

function AlchemyIconBase:Refresh()
  local config = DT.Item[self.tid]
  local itemType = config.Type
  self.ui.Image_Get_Icon:SetActive(false)
  self.ui.Image_Get_Frame:SetActive(false)
  self.ui.Image_Select:SetActive(self:_GetImageSelectActive())
  self.ui.Image_Michi:SetActive(itemType == ItemType.Trinket)
  self.ui.Image_Sub_Lock:SetActive(self:_GetSubLockActive(itemType))
  local isSelected = false
  if self.selectedFunc then
    isSelected = self.selectedFunc()
  end
  local selectNum = 0
  if self.showMultiSelect and self.selectNumFunc then
    selectNum = self.selectNumFunc() or 0
  end
  local showCount = self.showMultiSelect and selectNum > 0
  self.view:SetActive(self.ui.Btn_Sub_Subtract, isSelected)
  self.view:SetActive(self.ui.Group_Sub_Select, isSelected)
  self.view:SetActive(self.ui.Image_Tick, isSelected and not showCount)
  self.ui.Image_Dis:SetActive(self.itemLockFunc and self.itemLockFunc())
  self.ui.Group_Using:SetActive(self.isUsingFunc and self.isUsingFunc())
  self.view:SetImage(self.ui.Icon_Article, config.Icon)
  self.view:SetImage(self.ui.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(config, self.ui.Image_Bg_Black))
  self.view:SetImage(self.ui.Image_Icon, self:_GetIconImage())
  self.view:SetText(self.ui.Text_Article_Number, self:_GetTextNumber())
  self:_RefreshSelectCount()
  local clickPressTime = self.addLongPressFunc and DT.GetConstant("ItemAddPressTime") or DT.GetConstant("Role_Press_Time")
  self.view:SetLongPressButtonIntervalTime(self.ui.Btn_Click, tonumber(clickPressTime))
  if self.addLongPressFunc then
    self.view:AddLongPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnLongPressAdd))
  end
  self.view:AddShortPressButtonListener(self.ui.Btn_Click, System.fn(self, self.OnClick))
  self:_RefresWeaponView(itemType)
  self:_RefreshRemainTimes()
  self:_RefreshRefreshTime()
  local subPressTime = self.subLongPressFunc and DT.GetConstant("ItemAddPressTime") or DT.GetConstant("Role_Press_Time")
  self.view:SetLongPressButtonIntervalTime(self.ui.Btn_Sub_Subtract, tonumber(subPressTime))
  if self.subLongPressFunc then
    self.view:AddLongPressButtonListener(self.ui.Btn_Sub_Subtract, System.fn(self, self.OnLongPressSub))
  end
  self.view:AddShortPressButtonListener(self.ui.Btn_Sub_Subtract, function()
    if self.btnSubFunc then
      self.btnSubFunc()
    end
  end)
end

function AlchemyIconBase:_RefreshRemainTimes()
  self.view:SetActive(self.ui.Group_RemainTimes, false)
  self.view:SetActive(self.ui.Group_UpperLimit, false)
  if not self.remainTimes then
    self.view:SetActive(self.ui.Group_Sub_RedDot, false)
    return
  end
  self.view:SetActive(self.ui.Group_UpperLimit, 0 == self.remainTimes)
  self.view:SetActive(self.ui.Group_Sub_RedDot, true)
  self.view:AddViewComponentOnce(self.ui.Group_Sub_RedDot, UICompRedDotNew, RedDotDefine.DynamicRedDotID.RedDotConversionRemain, {
    self.conversionId
  })
end

function AlchemyIconBase:_RefreshRefreshTime()
  if not self.refreshTime then
    self.view:SetActive(self.ui.Group_RefreshTime, false)
    return
  end
  self.view:SetActive(self.ui.Group_RefreshTime, true)
  self:_RefreshRefreshCountDown()
  self.view:BindTimer(1, -1, System.fn(self, self._RefreshRefreshCountDown))
end

function AlchemyIconBase:_RefreshRefreshCountDown()
  if not self.refreshTime then
    self.view:SetActive(self.ui.Group_RefreshTime, false)
    return
  end
  local curTime = TimeUtils.GetServerTime()
  local leftTime = self.refreshTime - curTime
  if leftTime <= 0 then
    self.view:SetActive(self.ui.Group_RefreshTime, false)
    return
  end
  self.view:SetActive(self.ui.Group_RefreshTime, true)
  local days, hours = TimeUtils.ShopItemFormat(leftTime)
  self.view:SetText(self.ui.Text_RefreshTime, LT.Textf("UI_Recharge_Panel_DayShopItemRefresh", days, hours))
end

function AlchemyIconBase:_RefresWeaponView(itemType)
  self.ui.Group_Stars:SetActive(itemType == CommonDefine.ItemType.Weapon)
  if itemType ~= CommonDefine.ItemType.Weapon then
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
    self.view:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
end

function AlchemyIconBase:_RefreshSelectCount()
  if not self.ui.Text_Article_Count then
    return
  end
  if not self.showMultiSelect or not self.selectNumFunc then
    self.view:SetActive(self.ui.Text_Article_Count, false)
    return
  end
  local selectNum = self.selectNumFunc()
  self.view:SetActive(self.ui.Text_Article_Count, selectNum and selectNum > 0)
  self.view:SetText(self.ui.Text_Article_Count, selectNum or 0)
  self:_RefreshSelectCountLayout(selectNum)
end

function AlchemyIconBase:_RefreshSelectCountLayout(selectNum)
  UIUtils.RefreshSelectCountLayout(self.ui.Text_Article_Count, self.ui.Image_Select_Bg, selectNum)
end

function AlchemyIconBase:RefreshMultiSelect()
  self.ui.Image_Select:SetActive(self:_GetImageSelectActive())
  local isSelected = false
  if self.selectedFunc then
    isSelected = self.selectedFunc()
  end
  local selectNum = 0
  if self.showMultiSelect and self.selectNumFunc then
    selectNum = self.selectNumFunc() or 0
  end
  local showCount = self.showMultiSelect and selectNum > 0
  self.view:SetActive(self.ui.Btn_Sub_Subtract, isSelected)
  self.view:SetActive(self.ui.Group_Sub_Select, isSelected)
  self.view:SetActive(self.ui.Image_Tick, isSelected and not showCount)
  self:_RefreshSelectCount()
end

function AlchemyIconBase:OnLongPressAdd(triggeredTimes)
  if triggeredTimes <= 1 then
    self.addDeltaNum = 1
  elseif self.addDeltaNum then
    self.addDeltaNum = math.ceil(self.addDeltaNum * ItemAddSpeed)
  else
    self.addDeltaNum = 1
  end
  if self.addLongPressFunc then
    self.addLongPressFunc(self.tid, self.uid, self.addDeltaNum)
  end
end

function AlchemyIconBase:OnLongPressSub(triggeredTimes)
  if triggeredTimes <= 1 then
    self.subDeltaNum = 1
  elseif self.subDeltaNum then
    self.subDeltaNum = math.ceil(self.subDeltaNum * ItemAddSpeed)
  else
    self.subDeltaNum = 1
  end
  if self.subLongPressFunc then
    self.subLongPressFunc(self.tid, self.uid, self.subDeltaNum)
  end
end

function AlchemyIconBase:OnClick()
  if self.clickCb then
    self.clickCb()
  end
end

function AlchemyIconBase:GetTrinketLevel()
  if self.sortType == CommonDefine.AwakerTrinketSortType.Level then
    local itemData = ItemDataUtils.GetItemByUid(self.uid)
    local level = itemData and (itemData.level or 0) or 0
    if level < 0 then
      level = 0
    end
    do return string.format, "+%s" end
    return string.format, "+%s", level
  end
  local completRate = AwakerTrinketDataUtils.GetTrinketCompletionRateByUid(self.uid)
  return completRate .. "%"
end

function AlchemyIconBase:_GetTextNumber()
  if self.numFunc then
    do return end
    return self.numFunc, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local config = DT.Item[self.tid]
  local itemType = config.Type
  if itemType == CommonDefine.ItemType.Weapon then
    return ""
  end
  if itemType == CommonDefine.ItemType.Trinket then
    do return self.GetTrinketLevel end
    return self.GetTrinketLevel, self, nil, nil, nil, nil, nil, nil
  end
  if self.alchemyItemType == AlchemyDefine.AlchemyItemType.Formula then
    return config.Name
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.DecomposeItem then
    if self.numFunc then
      do return end
      return self.numFunc, AlchemyDefine.AlchemyItemType.DecomposeItem, nil, nil, nil, nil, nil, nil
    end
    do return ItemDataUtils.GetItemNum end
    return ItemDataUtils.GetItemNum, self.tid, nil, nil, nil, nil, nil, nil
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.CompositeCostItem then
    local haveNum = ItemDataUtils.GetItemNum(self.tid)
    local consumeData = AlchemyCompositeExtModel.Instance:GetConsumeDataByTid(self.tid)
    if not consumeData then
      return ""
    end
    local perCostNum = consumeData.num
    local totalCostNum = perCostNum * AlchemyCompositeExtModel.Instance.curCompositeNum
    if haveNum < totalCostNum then
      do return LT.Textf, "<color=#FA3A50>{s1}</color>/{s2}", haveNum end
      return LT.Textf, "<color=#FA3A50>{s1}</color>/{s2}", haveNum, totalCostNum
    end
    do return LT.Textf, "{s1}/{s2}", haveNum end
    return LT.Textf, "{s1}/{s2}", haveNum, totalCostNum
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.DecompositeConvertItem then
    do return LT.Text end
    return LT.Text, self.num, consumeData.num, perCostNum * AlchemyCompositeExtModel.Instance.curCompositeNum, LT.Textf, "{s1}/{s2}", haveNum, totalCostNum
  elseif self.alchemyItemType == AlchemyDefine.AlchemyItemType.RecastTrinketItem then
    do return self.GetTrinketLevel end
    return self.GetTrinketLevel, self, consumeData.num, perCostNum * AlchemyCompositeExtModel.Instance.curCompositeNum, LT.Textf, "{s1}/{s2}", haveNum, totalCostNum
  end
  return self.num or ""
end

function AlchemyIconBase:_GetImageSelectActive()
  if self.selectFunc then
    do return end
    return self.selectFunc
  end
  return false
end

function AlchemyIconBase:_GetIconImage()
  if not self.uid then
    return ""
  end
  local itemType = ItemDataUtils.GetItemType(self.tid)
  if itemType ~= ItemType.Trinket then
    return ""
  end
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(self.uid)
  if not mainAttr then
    return ""
  end
  local attrType = DT.ActorAttrType[mainAttr.attrId]
  return attrType and attrType.Icon or ""
end

function AlchemyIconBase:_GetSubLockActive(itemType)
  if itemType ~= CommonDefine.ItemType.Weapon and itemType ~= CommonDefine.ItemType.Trinket then
    return false
  end
  local locked = ItemDataUtils.GetItemLocked(self.uid)
  return locked
end

return AlchemyIconBase
