_class("UIActivityN27DiffLevelNodeCup", UICustomWidget)
UIActivityN27DiffLevelNodeCup = UIActivityN27DiffLevelNodeCup

function UIActivityN27DiffLevelNodeCup:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN27DiffLevelNodeCup:InitWidget()
  self._complete = self:GetGameObject("Complete")
  self._uncomplete = self:GetGameObject("UnComplete")
end

function UIActivityN27DiffLevelNodeCup:SetData(complete)
  self._complete:SetActive(complete)
  self._uncomplete:SetActive(not complete)
end
