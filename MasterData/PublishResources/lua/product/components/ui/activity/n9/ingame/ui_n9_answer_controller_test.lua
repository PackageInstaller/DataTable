_class("UIN9AnswerControllerTest", UIController)
UIN9AnswerControllerTest = UIN9AnswerControllerTest

function UIN9AnswerControllerTest:OnShow(uiParams)
  self._storyIDTxt = self:GetUIComponent("Text", "Text")
  self._debugModeToggle = self:GetUIComponent("Toggle", "Toggle")
end

function UIN9AnswerControllerTest:EnterStoryBtnOnClick()
  local idStr = self._storyIDTxt.text
  local idNumber = tonumber(idStr)
  local debug = self._debugModeToggle.isOn
  if idNumber then
    UIN9Const.SetCheckIds({idNumber})
  else
  end
  local levelconfig = UIN9Const.GetLevelConfig()
  local data = UIN9SubjectLevelGradeData:New(levelconfig[1], {
    rewarded_levels = {}
  })
  data.isGm = true
  self:ShowDialog("UIN9AnswerController", data)
end

function UIN9AnswerControllerTest:ExitBtnOnClick()
  self:CloseDialog()
end
