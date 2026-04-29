_class("UISailingLevelResetTeam", UIController)
UISailingLevelResetTeam = UISailingLevelResetTeam

function UISailingLevelResetTeam:OnShow(uiParams)
  self._callback = uiParams[1]
end

function UISailingLevelResetTeam:OnHide()
end

function UISailingLevelResetTeam:ConfirmBtnOnClick()
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end

function UISailingLevelResetTeam:CancelBtnOnClick()
  self:CloseDialog()
end
