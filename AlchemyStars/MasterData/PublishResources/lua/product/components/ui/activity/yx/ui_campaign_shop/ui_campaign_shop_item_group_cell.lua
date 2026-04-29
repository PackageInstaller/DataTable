_class("UICampaignShopItemGroupCell", UICustomWidget)
UICampaignShopItemGroupCell = UICampaignShopItemGroupCell

function UICampaignShopItemGroupCell:OnShow(uiParams)
  self:InitWidget()
end

function UICampaignShopItemGroupCell:InitWidget()
  self._smallBoxGen = self:GetUIComponent("UISelectObjectPath", "SmallBoxGen")
  self._bigItemGen = self:GetUIComponent("UISelectObjectPath", "BigItemGen")
  self._rootLayout = self:GetUIComponent("LayoutElement", "Root")
end

function UICampaignShopItemGroupCell:SetData()
end

function UICampaignShopItemGroupCell:InitData(data)
  local item
  if data.GetIsSpecial and data:GetIsSpecial() then
    item = self._bigItemGen:SpawnObject("UICampaignShopItemBig")
    self._rootLayout.minWidth = 400
    self._rootLayout.preferredWidth = 400
  else
    item = self._smallBoxGen:SpawnObject("UICampaignShopSmallItemBox")
    self._rootLayout.minWidth = 350
    self._rootLayout.preferredWidth = 350
  end
  if item then
    item:InitData(data)
  end
end
