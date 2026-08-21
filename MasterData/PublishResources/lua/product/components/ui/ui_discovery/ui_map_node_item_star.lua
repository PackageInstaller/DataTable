_class("UIMapNodeItemStar", UICustomWidget)
UIMapNodeItemStar = UIMapNodeItemStar

function UIMapNodeItemStar:OnShow()
  self._imgStar = self:GetGameObject("imgStar")
end

function UIMapNodeItemStar:OnHide()
  self._imgStar = nil
end

function UIMapNodeItemStar:Flush(active)
  self._imgStar:SetActive(active)
end
