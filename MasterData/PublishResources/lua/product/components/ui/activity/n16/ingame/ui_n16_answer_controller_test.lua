_class("UIN16AnswerControllerTest", UIController)
UIN16AnswerControllerTest = UIN16AnswerControllerTest

function UIN16AnswerControllerTest:OnShow(uiParams)
  self._storyIDTxt = self:GetUIComponent("Text", "Text")
  self._debugModeToggle = self:GetUIComponent("Toggle", "Toggle")
end

function UIN16AnswerControllerTest:EnterStoryBtnOnClick()
  local idStr = self._storyIDTxt.text
  local idNumber = tonumber(idStr)
  local debug = self._debugModeToggle.isOn
  if idNumber then
    UIN16Const.SetCheckIds({idNumber})
  else
  end
  local levelconfig = UIN16Const.GetLevelConfig()
  local data = UIN16SubjectLevelGradeData:New(levelconfig[1], {
    rewarded_levels = {}
  })
  data.isGm = true
  self:ShowDialog("UIN16AnswerController", data)
end

function UIN16AnswerControllerTest:ExitBtnOnClick()
  self:CloseDialog()
end
