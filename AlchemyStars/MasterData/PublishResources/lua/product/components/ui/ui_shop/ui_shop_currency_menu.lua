_class("UIShopCurrencyMenu", UICustomWidget)
UIShopCurrencyMenu = UIShopCurrencyMenu

function UIShopCurrencyMenu:OnShow()
  self.diamondGO = self:GetGameObject("diamondpanel")
  self.goldGO = self:GetGameObject("goldpanel")
  self.secretGO = self:GetGameObject("secretpanel")
  self.diamondTxt = self:GetUIComponent("UILocalizationText", "diamondtxt")
  self.goldTxt = self:GetUIComponent("UILocalizationText", "goldtxt")
  self.secretTxt = self:GetUIComponent("UILocalizationText", "secrettxt")
  self.roleModule = self:GetModule(RoleModule)
  self:AddListener()
end

function UIShopCurrencyMenu:OnHide()
  self:RemoveListener()
end

function UIShopCurrencyMenu:AddListener()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
  self:AttachEvent(GameEventType.DiamondCountChanged, self.OnItemCountChange)
end

function UIShopCurrencyMenu:RemoveListener()
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
  self:DetachEvent(GameEventType.DiamondCountChanged, self.OnItemCountChange)
end

function UIShopCurrencyMenu:Refresh(subTabType)
  self.subTabType = subTabType
  if self.subTabType == MarketType.Shop_BlackMarket then
    self.diamondGO:SetActive(true)
    self.goldGO:SetActive(true)
    self.secretGO:SetActive(false)
    self.diamondTxt:SetText(self.roleModule:GetGlow())
    self.goldTxt:SetText(self.roleModule:GetGold())
  elseif self.subTabType == MarketType.Shop_MysteryMarket then
    self.diamondGO:SetActive(false)
    self.goldGO:SetActive(false)
    self.secretGO:SetActive(true)
    self.secretTxt:SetText(self.roleModule:GetMazeCoin())
  elseif self.subTabType == MarketType.Shop_WorldBoss then
    self.diamondGO:SetActive(false)
    self.goldGO:SetActive(false)
    self.secretGO:SetActive(true)
    self.secretTxt:SetText(self.roleModule:GetMazeCoin())
  end
end

function UIShopCurrencyMenu:OnItemCountChange()
  self:Refresh(self.subTabType)
end

function UIShopCurrencyMenu:btndiamondOnClick(go)
  ToastManager.ShowLockTip()
end

function UIShopCurrencyMenu:btnsecretOnClick(go)
  ToastManager.ShowLockTip()
end

function UIShopCurrencyMenu:btngoldOnClick(go)
  ToastManager.ShowLockTip()
end

function UIShopCurrencyMenu:SetData(iconClick)
  self._iconClick = iconClick
end

function UIShopCurrencyMenu:secreticonOnClick()
  if self._iconClick then
    local go = self:GetGameObject("secreticon")
    self._iconClick(RoleAssetID.RoleAssetMazeCoin, go)
  end
end

function UIShopCurrencyMenu:goldiconOnClick()
  if self._iconClick then
    local go = self:GetGameObject("goldicon")
    self._iconClick(RoleAssetID.RoleAssetGold, go)
  end
end

function UIShopCurrencyMenu:diamondiconOnClick()
  if self._iconClick then
    local go = self:GetGameObject("diamondicon")
    self._iconClick(RoleAssetID.RoleAssetGlow, go)
  end
end
