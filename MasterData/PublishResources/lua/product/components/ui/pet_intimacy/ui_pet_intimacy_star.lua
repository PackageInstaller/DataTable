_class("UIPetIntimacyStar", UICustomWidget)
UIPetIntimacyStar = UIPetIntimacyStar

function UIPetIntimacyStar:OnShow(uiParams)
  self._starOnyGo = self:GetGameObject("UIPetIntimacyStarOn")
  self._starBreakBackOn = self:GetGameObject("UIPetIntimacyStarBreakBackOn")
end

function UIPetIntimacyStar:Refresh(isOn, isback)
  if isback then
    self._starBreakBackOn:SetActive(true)
    self._starOnyGo:SetActive(false)
  else
    self._starBreakBackOn:SetActive(false)
    self._starOnyGo:SetActive(isOn)
  end
end
