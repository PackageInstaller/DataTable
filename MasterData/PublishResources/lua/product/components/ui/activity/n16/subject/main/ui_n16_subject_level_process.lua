_class("UIN16SubjectLevelProcess", UICustomWidget)
UIN16SubjectLevelProcess = UIN16SubjectLevelProcess

function UIN16SubjectLevelProcess:OnShow()
  self._complete = self:GetGameObject("Complete")
end

function UIN16SubjectLevelProcess:Refresh(isComplete)
  self._complete:SetActive(isComplete)
end
