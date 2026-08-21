_class("UIShopGiftPackItemContainer", UICustomWidget)
UIShopGiftPackItemContainer = UIShopGiftPackItemContainer

function UIShopGiftPackItemContainer:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetGiftPackShopData()
end

function UIShopGiftPackItemContainer:OnShow()
  self.normal_month = self:GetUIComponent("UISelectObjectPath", "normal_month")
  self.gonormal_month = self:GetGameObject("normal_month")
  self.uiNormal = self.normal_month:SpawnObject("UIShopGiftPackItem")
  self.uiNormal:GetGameObject().name = 0
  self.week = self:GetUIComponent("UISelectObjectPath", "week")
  self.goweek = self:GetGameObject("week")
  self.uiWeek = self.week:SpawnObject("UIShopGiftPackItemWeek")
  self.uiWeek:GetGameObject().name = 0
end

function UIShopGiftPackItemContainer:OnHide()
end

function UIShopGiftPackItemContainer:Flush(id)
  self._itemData = self._data:GetGoodBuyId(id)
  if self._itemData:IsWeekCard() and false then
    self.gonormal_month:SetActive(false)
    self.goweek:SetActive(true)
    self.uiWeek:Flush(id)
  else
    self.gonormal_month:SetActive(true)
    self.goweek:SetActive(false)
    self.uiNormal:Flush(id)
  end
end

function UIShopGiftPackItemContainer:OpenUIShopGiftPackDetail()
  if self._itemData:IsWeekCard() and false then
    self.uiWeek:OpenUIShopGiftPackDetail()
  else
    self.uiNormal:OpenUIShopGiftPackDetail()
  end
end

function UIShopGiftPackItemContainer:PlayInAnimation()
  return self.uiNormal:PlayInAnimation()
end
