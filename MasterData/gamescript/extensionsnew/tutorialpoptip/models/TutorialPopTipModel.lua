local TutorialPopTipModel = NewClass("TutorialPopTipModel", BaseModel)

function TutorialPopTipModel:OnInit()
  self:OnReset()
end

function TutorialPopTipModel:OnReset()
  self._tidGroup = nil
end

function TutorialPopTipModel:SetTidGroup(tidGroup)
  self._tidGroup = tidGroup
end

function TutorialPopTipModel:GetTidGroup()
  return self._tidGroup
end

function TutorialPopTipModel:IsMultiTutorialUnlock()
  return self._tidGroup ~= nil and #self._tidGroup > 1
end

function TutorialPopTipModel:GetTitle()
  if self:IsMultiTutorialUnlock() then
    do return LT.Text end
    return LT.Text, "CoursePopMultiTipText", nil
  end
  local tid = self._tidGroup and self._tidGroup[1]
  if not tid then
    return ""
  end
  local tutorialCfg = TutorialDataUtils.GetConfigByTid(tid)
  return tutorialCfg and tutorialCfg.Title or ""
end

function TutorialPopTipModel:GetIcon()
  if self:IsMultiTutorialUnlock() then
    return CommonDefine.TutorialPopTipIcon.Multi
  end
  return CommonDefine.TutorialPopTipIcon.Single
end

return TutorialPopTipModel
