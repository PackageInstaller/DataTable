_class("UIShopFlashSaleItemContainer", UICustomWidget)
UIShopFlashSaleItemContainer = UIShopFlashSaleItemContainer

function UIShopFlashSaleItemContainer:Constructor()
end

function UIShopFlashSaleItemContainer:OnShow()
  self.normal_month = self:GetUIComponent("UISelectObjectPath", "normal_month")
  self.gonormal_month = self:GetGameObject("normal_month")
  self.uiNormal = self.normal_month:SpawnObject("UIShopflashSaleItem")
  self.week = self:GetUIComponent("UISelectObjectPath", "week")
  self.goweek = self:GetGameObject("week")
  self.uiWeek = self.week:SpawnObject("UIShopFlashSaleItemWeek")
end

function UIShopFlashSaleItemContainer:OnHide()
end

function UIShopFlashSaleItemContainer:Flush(itemData)
  self._itemData = itemData
  if self._itemData:IsWeekCard() then
    self.gonormal_month:SetActive(false)
    self.goweek:SetActive(true)
    self.uiWeek:Flush(self._itemData)
  else
    self.gonormal_month:SetActive(true)
    self.goweek:SetActive(false)
    self.uiNormal:Flush(self._itemData)
  end
end

function UIShopFlashSaleItemContainer:OpenUIShopFlashSaleDetail()
  if self._itemData:IsWeekCard() then
    self.uiWeek:OpenUIShopGiftPackDetail()
  else
    self.uiNormal:OpenUIShopGiftPackDetail()
  end
end
