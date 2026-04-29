_class("UIDiffNodeItemStar", UICustomWidget)
UIDiffNodeItemStar = UIDiffNodeItemStar

function UIDiffNodeItemStar:OnShow()
  self._imgStar = self:GetGameObject("imgStar")
end

function UIDiffNodeItemStar:OnHide()
  self._imgStar = nil
end

function UIDiffNodeItemStar:Flush(active)
  self._imgStar:SetActive(active)
end
