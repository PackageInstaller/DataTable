_class("UIStarItem", UICustomWidget)
UIStarItem = UIStarItem

function UIStarItem:OnShow()
  self._imgStarGray = self:GetGameObject("imgStarGray")
  self._imgStar = self:GetGameObject("imgStar")
end

function UIStarItem:OnHide()
  self._imgStarGray = nil
  self._imgStar = nil
end

function UIStarItem:Flush(active)
  self._imgStarGray:SetActive(not active)
  self._imgStar:SetActive(active)
end
