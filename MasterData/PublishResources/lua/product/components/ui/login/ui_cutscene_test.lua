_class("UICutsceneTestController", UIController)
UICutsceneTestController = UICutsceneTestController

function UICutsceneTestController:OnShow(uiParams)
  self._storyIDTxt = self:GetUIComponent("Text", "Text")
  self._debugModeToggle = self:GetUIComponent("Toggle", "Toggle")
  AudioHelperController.StopBGM(1)
end

function UICutsceneTestController:EnterStoryBtnOnClick()
  local idStr = self._storyIDTxt.text
  local idNumber = tonumber(idStr)
  local debug = self._debugModeToggle.isOn
  if idNumber then
    local uiStoryModule = self:GetModule(StoryModule):GetUIModule()
    uiStoryModule:SetLevelID(idNumber)
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Cutscene_Enter)
  end
end

function UICutsceneTestController:ExitBtnOnClick()
  self:SwitchState(UIStateType.UIMain)
end
