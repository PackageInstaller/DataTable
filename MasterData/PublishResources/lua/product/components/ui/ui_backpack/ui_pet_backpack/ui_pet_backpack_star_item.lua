_class("UIPetBackpackStarItem", UICustomWidget)
UIPetBackpackStarItem = UIPetBackpackStarItem

function UIPetBackpackStarItem:Constructor()
end

function UIPetBackpackStarItem:SetData(showLight)
  self._backImg = self:GetUIComponent("Image", "Image")
  self._lightImg = self:GetUIComponent("Image", "Image (1)")
  if showLight then
    self._lightImg.gameObject:SetActive(true)
  else
    self._lightImg.gameObject:SetActive(false)
  end
end
