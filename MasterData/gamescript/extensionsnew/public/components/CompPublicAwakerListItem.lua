local CompPublicAwakerListItem, Super = NewViewComponent("CompPublicAwakerListItem")

function CompPublicAwakerListItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
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

function CompPublicAwakerListItem:OnEnterComponent()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
  self:SetImage(self.ui.Image_Goods, self:_GetImage())
  self.ui.Image_Goods:SetActive(not self.awakerData)
  self:SetImage(self.ui.Image_Awaker, self:_GetImage())
  self.ui.Image_Awaker:SetActive(self.awakerData ~= nil)
  self:SetImage(self.ui.Image_D_Quality_Color, self:_GetQualityColor())
  self:SetText(self.ui.Text_Level, self:_GetLevelText())
  if self.showNumFunc then
    self:SetText(self.ui.Text_Quantity, self.showNumFunc())
  else
    self:SetText(self.ui.Text_Quantity, "")
  end
  self.ui.Text_Quantity:SetActive(nil ~= self.showNumFunc)
  self:SetImage(self.ui.Image_Career_Icon, self:_GetCareerIcon())
  self.ui.Image_Career_Icon:SetActive(self.awakerData ~= nil)
  if self.fullAwakenFunc then
    self.ui.Image_Full:SetActive(self.fullAwakenFunc())
  else
    self.ui.Image_Full:SetActive(false)
  end
  if self.wrongBgFunc then
    self.ui.Image_wrong:SetActive(self.wrongBgFunc())
  else
    self.ui.Image_wrong:SetActive(false)
  end
  if self.getWrongTextFunc then
    self:SetText(self.ui.Text_Wrong, self.getWrongTextFunc())
  else
    self:SetText(self.ui.Text_Wrong, LT.Text("Task_Dispatch_AwakerState"))
  end
  if self.selectFunc then
    self.ui.Image_Select:SetActive(self.selectFunc())
  else
    self.ui.Image_Select:SetActive(false)
  end
  if self.selectBgFunc then
    self.ui.Image_Select_Bg:SetActive(self.selectBgFunc())
  else
    self.ui.Image_Select_Bg:SetActive(false)
  end
  self:_InitPotencyShow()
  self:_InitAwakerFavorBorder()
end

function CompPublicAwakerListItem:_InitAwakerFavorBorder()
  if not self.ui.Image_AwakerFavor then
    return
  end
  if not self.awakerData then
    self.ui.Image_AwakerFavor:SetActive(false)
    return
  end
  local showFavor = FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(self.awakerData.tid, self.awakerData)
  self.ui.Image_AwakerFavor:SetActive(showFavor)
end

function CompPublicAwakerListItem:_InitPotencyShow()
  if self.showPotencyInfoFunc and self.showPotencyInfoFunc() and self.awakerData then
    local potencyData = {
      awakerTid = self.awakerData.tid,
      potency = self.awakerData.potency
    }
    self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompAwakerPotencyItem, potencyData)
    self.ui.UI_Common_Item_Potency:SetActive(true)
  else
    self.ui.UI_Common_Item_Potency:SetActive(false)
  end
end

function CompPublicAwakerListItem:_GetImage()
  if self.awakerData then
    do return AwakerDataUtils.GetAwakerBust end
    return AwakerDataUtils.GetAwakerBust, self.awakerData.tid
  end
  return DT.Item[self.itemTid].Icon
end

function CompPublicAwakerListItem:_GetQualityColor()
  if self.awakerData then
    do return AwakerDataUtils.GetAwakerQualityColor end
    return AwakerDataUtils.GetAwakerQualityColor, self.awakerData.tid, nil
  end
  local itemCfg = DT.Item[self.itemTid]
  return DT.ItemQuality[itemCfg.Quality].ItemQualityColor
end

function CompPublicAwakerListItem:_GetLevelText()
  if self.showTextFunc then
    do return end
    return self.showTextFunc, nil, nil
  end
  do return AwakerDataUtils.GetSortTypeTagContent, CommonDefine.AwakerSortType.Level end
  return AwakerDataUtils.GetSortTypeTagContent, CommonDefine.AwakerSortType.Level, self.awakerData
end

function CompPublicAwakerListItem:_GetCareerIcon()
  if self.awakerData then
    local awakerTid = self.awakerData.tid
    local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
    do return AwakerDataUtils.GetSchoolIcon end
    return AwakerDataUtils.GetSchoolIcon, awakerConfig.School
  end
  return ""
end

function CompPublicAwakerListItem:_OnClick()
  if self.clickFunc then
    self.clickFunc()
  end
end

function CompPublicAwakerListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicAwakerListItem
