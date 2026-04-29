_class("UIWidgetShopRefreshBtn", UICustomWidget)
UIWidgetShopRefreshBtn = UIWidgetShopRefreshBtn

function UIWidgetShopRefreshBtn:OnShow()
  self:InitWidget()
  self:AddListener()
end

function UIWidgetShopRefreshBtn:InitWidget()
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.curCountTxt = self:GetUIComponent("UILocalizationText", "curcount")
  self.maxCountTxt = self:GetUIComponent("UILocalizationText", "maxcount")
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIWidgetShopRefreshBtn:OnHide()
  self:RemoveListener()
end

function UIWidgetShopRefreshBtn:AddListener()
end

function UIWidgetShopRefreshBtn:RemoveListener()
end

function UIWidgetShopRefreshBtn:Refresh(subTabType)
  self.subTabType = subTabType
end

function UIWidgetShopRefreshBtn:SetData(clickCb)
  self._clickCb = clickCb
end

function UIWidgetShopRefreshBtn:RefreshInfo(curCount, maxCount, consume, costType)
  self.curCountTxt:SetText(maxCount - curCount)
  self.maxCountTxt:SetText(maxCount)
  self.priceTxt:SetText(consume)
  local _cfg = Cfg.cfg_top_tips[costType]
  self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(_cfg.Icon)
end

function UIWidgetShopRefreshBtn:BtnRefreshOnClick(go)
  if self._clickCb then
    self._clickCb()
  end
end
