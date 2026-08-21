_class("UIN25CampaignShopItemSmall", UICampaignShopItemSmall)
UIN25CampaignShopItemSmall = UIN25CampaignShopItemSmall

function UIN25CampaignShopItemSmall:_FillRemainArea()
  local showRemain = self._data:ShowRemain()
  local remainCount = self._data:GetRemainCount()
  if showRemain == false then
    self._itemRestAreaGO:SetActive(false)
  elseif self._data:IsUnLimit() then
    self._itemRestAreaGO:SetActive(false)
  elseif remainCount <= 0 then
    self._itemRestAreaGO:SetActive(false)
  else
    self._itemRestAreaGO:SetActive(true)
    self._itemRestText:SetText(remainCount)
  end
  if self._data:IsUnLimit() then
    self._selledAreaGO:SetActive(false)
    self._infoCanvasGroup.blocksRaycasts = true
  elseif remainCount <= 0 then
    self._selledAreaGO:SetActive(true)
    self._infoCanvasGroup.blocksRaycasts = false
  else
    self._selledAreaGO:SetActive(false)
    self._infoCanvasGroup.blocksRaycasts = true
  end
end

function UIN25CampaignShopItemSmall:PlaySellOutAni()
  if not self.sellOutAni then
    self.sellOutAni = self:GetUIComponent("Animation", "sellOutAni")
  end
  self.sellOutAni:Play()
end
