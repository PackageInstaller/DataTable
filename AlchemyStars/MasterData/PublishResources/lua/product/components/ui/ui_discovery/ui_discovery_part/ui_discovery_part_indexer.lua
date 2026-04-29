_class("UIDiscoveryPartIndexer", UICustomWidget)
UIDiscoveryPartIndexer = UIDiscoveryPartIndexer

function UIDiscoveryPartIndexer:OnShow(uiParams)
  self:InitWidget()
  self:Select(false)
end

function UIDiscoveryPartIndexer:InitWidget()
  self.imageTr = self:GetUIComponent("RectTransform", "ImageTr")
end

function UIDiscoveryPartIndexer:SetData()
end

function UIDiscoveryPartIndexer:Select(bselect)
  if bselect then
    self.imageTr.sizeDelta = Vector2(48, 22)
  else
    self.imageTr.sizeDelta = Vector2(23, 22)
  end
end
