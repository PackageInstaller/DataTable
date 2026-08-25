local CommonAwakerListItem, Super = System.NewComponent("CommonAwakerListItem")

function CommonAwakerListItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_ListResource(uiNode)
  self.clickFunc = data.clickFunc
  self.awakerData = data.awakerData
  self.selectBgFunc = data.selectBgFunc
  self.selectFunc = data.selectFunc
  self.wrongBgFunc = data.wrongBgFunc
  self.fullAwakenFunc = data.fullAwakenFunc
  self.showTextFunc = data.showTextFunc
  self.itemTid = data.itemTid
  self.showNumFunc = data.showNumFunc
  self.showPotencyInfoFunc = data.showPotencyInfoFunc
  self.getWrongTextFunc = data.getWrongTextFunc
end

function CommonAwakerListItem:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToImage(self.ui.Image_Goods, function()
    do return self.GetImage end
    return self.GetImage, self
  end)
  binder:BindToVisible(self.ui.Image_Goods, function()
    return not self.awakerData
  end)
  binder:BindToImage(self.ui.Image_Awaker, function()
    do return self.GetImage end
    return self.GetImage, self
  end)
  binder:BindToVisible(self.ui.Image_Awaker, function()
    return self.awakerData
  end)
  binder:BindToImage(self.ui.Image_D_Quality_Color, function()
    if self.awakerData then
      do return AwakerDataUtils.GetAwakerQualityColor end
      return AwakerDataUtils.GetAwakerQualityColor, self.awakerData.tid, nil
    end
    local itemCfg = DT.Item[self.itemTid]
    return DT.ItemQuality[itemCfg.Quality].ItemQualityColor
  end)
  binder:BindToText(self.ui.Text_Level, function()
    if self.showTextFunc then
      do return end
      return self.showTextFunc, nil, nil
    end
    local showText = AwakerDataUtils.GetSortTypeTagContent(CommonDefine.AwakerSortType.Level, self.awakerData)
    return showText
  end)
  binder:BindToText(self.ui.Text_Quantity, function()
    if self.showNumFunc then
      do return end
      return self.showNumFunc, nil
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Text_Quantity, function()
    return self.showNumFunc
  end)
  binder:BindToImage(self.ui.Image_Career_Icon, function()
    if self.awakerData then
      local awakerTid = self.awakerData.tid
      local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
      local iconPath = AwakerDataUtils.GetSchoolIcon(awakerConfig.School)
      return iconPath
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Image_Career_Icon, function()
    return self.awakerData
  end)
  binder:BindToVisible(self.ui.Image_Full, function()
    if self.fullAwakenFunc then
      do return end
      return self.fullAwakenFunc, nil
    end
    return false
  end)
  binder:BindToVisible(self.ui.Image_wrong, function()
    if self.wrongBgFunc then
      do return end
      return self.wrongBgFunc, nil
    end
    return false
  end)
  binder:BindToText(self.ui.Text_Wrong, function()
    if self.getWrongTextFunc then
      do return end
      return self.getWrongTextFunc, nil
    end
    do return LT.Text end
    return LT.Text, "Task_Dispatch_AwakerState"
  end)
  binder:BindToVisible(self.ui.Image_Select, function()
    if self.selectFunc then
      do return end
      return self.selectFunc, nil
    end
    return false
  end)
  binder:BindToVisible(self.ui.Image_Select_Bg, function()
    if self.selectBgFunc then
      do return end
      return self.selectBgFunc, nil
    end
    return false
  end)
  self:_BindPotencyShow(binder)
end

function CommonAwakerListItem:_BindPotencyShow(binder)
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local awakerTid = data[1]
    local potency = data[2]
    childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potency = potency}))
  end, function()
    return {
      self.awakerData.tid,
      self.awakerData.potency
    }
  end)
  binder:BindToVisible(self.ui.UI_Common_Item_Potency, function()
    if self.showPotencyInfoFunc then
      do return end
      return self.showPotencyInfoFunc, nil
    end
    return false
  end)
end

function CommonAwakerListItem:GetImage()
  if self.awakerData then
    do return AwakerDataUtils.GetAwakerBust end
    return AwakerDataUtils.GetAwakerBust, self.awakerData.tid
  end
  return DT.Item[self.itemTid].Icon
end

function CommonAwakerListItem:OnClick()
  if self.clickFunc then
    self.clickFunc()
  end
end

return CommonAwakerListItem
