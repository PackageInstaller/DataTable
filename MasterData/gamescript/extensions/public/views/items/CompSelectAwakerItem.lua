local CompSelectAwakerItem, Super = NewViewComponent("CompSelectAwakerItem", CompSelectBaseItem)

function CompSelectAwakerItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view, data)
  self.awakerItemTid = data.awakerItemTid
end

function CompSelectAwakerItem:InitOtherUIElement()
  self.ui.Image_Icon:SetActive(false)
  self.ui.Image_Awaker:SetActive(true)
  self.ui.Image_Career:SetActive(true)
  self:SetActive(self.ui.Image_Have, false)
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(self.awakerItemTid)
  local isOwned = AwakerDataUtils.HasOwnedAwaker(awakerTid)
  self:SetActive(self.ui.UI_Common_Item_Potency, isOwned)
  self:SetActive(self.ui.Image_Mask, isOwned)
  local awakerCfg = DT.AwakerConfig[awakerTid]
  if isOwned then
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    self:AddViewComponentOnce(self.ui.UI_Common_Item_Potency, CompAwakerPotencyItem, {
      awakerTid = awakerTid,
      potency = awakerData.potency
    })
    local curActivePotencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency)
    local numFragments = ItemDataUtils.GetItemNum(awakerCfg.AwakerSpecialItem)
    local costNumList = DT.GetOriginalConstant("AwakerPotencyUpgradeConsumeNum")
    local maxPotency = curActivePotencyIndex + numFragments >= #costNumList
    self:SetActive(self.ui.Image_Have, not maxPotency and isOwned)
    self:SetActive(self.ui.Image_Full, maxPotency)
  else
    self:SetActive(self.ui.Image_Have, false)
    self:SetActive(self.ui.Image_Full, false)
  end
  local qualityCfg = DT.ItemQuality[awakerCfg.Quality]
  self:SetImage(self.ui.Image_Quality, qualityCfg.AwakerWeaponSelectQualityColor)
  self:SetText(self.ui.Text_Name, AwakerDataUtils.GetAwakerName(awakerTid))
  self:SetText(self.ui.Text_C_Full, LT.Text("MaxPotencyAwakerShopTips"))
  self:SetImage(self.ui.Image_Awaker, AwakerDataUtils.GetFullHeadIcon(awakerTid))
  self:SetImage(self.ui.Image_Career, AwakerDataUtils.GetAwakerSchoolIcon(awakerTid))
end

function CompSelectAwakerItem:OnClick()
  if self.data.clickFunc then
    self.data.clickFunc()
  end
end

function CompSelectAwakerItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompSelectAwakerItem
