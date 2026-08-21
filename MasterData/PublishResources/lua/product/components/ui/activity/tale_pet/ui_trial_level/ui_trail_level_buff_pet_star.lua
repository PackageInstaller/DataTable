_class("UITrailLevelBuffPetStar", UICustomWidget)
UITrailLevelBuffPetStar = UITrailLevelBuffPetStar

function UITrailLevelBuffPetStar:OnShow()
  self._starUnOpen = self:GetGameObject("StarUnOpen")
  self._starOpen = self:GetGameObject("StarOpen")
end

function UITrailLevelBuffPetStar:Refresh(isOpen)
  self._starOpen:SetActive(isOpen)
  self._starUnOpen:SetActive(not isOpen)
end
