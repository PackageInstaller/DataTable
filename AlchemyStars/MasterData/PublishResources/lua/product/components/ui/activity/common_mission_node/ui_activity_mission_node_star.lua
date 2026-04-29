_class("UIActivityMissionNodeStar", UICustomWidget)
UIActivityMissionNodeStar = UIActivityMissionNodeStar

function UIActivityMissionNodeStar:OnShow()
  self._imgStar = self:GetGameObject("imgStar")
end

function UIActivityMissionNodeStar:OnHide()
  self._imgStar = nil
end

function UIActivityMissionNodeStar:Flush(active)
  self._imgStar:SetActive(active)
end
