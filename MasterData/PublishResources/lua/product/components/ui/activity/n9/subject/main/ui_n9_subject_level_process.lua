_class("UIN9SubjectLevelProcess", UICustomWidget)
UIN9SubjectLevelProcess = UIN9SubjectLevelProcess

function UIN9SubjectLevelProcess:OnShow()
  self._complete = self:GetGameObject("Complete")
end

function UIN9SubjectLevelProcess:Refresh(isComplete)
  self._complete:SetActive(isComplete)
end
