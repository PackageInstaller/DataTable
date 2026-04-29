_class("UITopPape", UICustomWidget)

function UITopPape:Constructor()
end

function UITopPape:OnShow(uiParams)
  self._brightIcon = self:GetGameObject("gaoliang")
  self._blackIcon = self:GetGameObject("black")
end

function UITopPape:ChangeBrightAndBlackState(isBright)
  self._brightIcon:SetActive(isBright)
  self._blackIcon:SetActive(not isBright)
end
