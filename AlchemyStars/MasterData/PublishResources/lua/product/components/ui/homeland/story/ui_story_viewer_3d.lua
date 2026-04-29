_class("UIStoryViewer3D", UIController)
UIStoryViewer3D = UIStoryViewer3D

function UIStoryViewer3D:OnShow(uiParams)
  self._storyIDTxt = self:GetUIComponent("Text", "Text")
  self._debugModeToggle = self:GetUIComponent("Toggle", "Toggle")
  self._uiroot = self:GetGameObject()
  AudioHelperController.StopBGM(1)
end

function UIStoryViewer3D:ShowRoot(active)
  self._uiroot:SetActive(active)
end

function UIStoryViewer3D:EnterStoryBtnOnClick()
  local idStr = self._storyIDTxt.text
  local idNumber = tonumber(idStr)
  local debug = self._debugModeToggle.isOn
  if idNumber then
    self:ShowRoot(false)
    if EditorGlobal.IsHomeMovieMode() then
      self:ShowDialog("UIHomeMovieStoryController", idNumber, function()
      end, nil, true, true, false, true)
    else
      CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeStoryController, function()
        self:SwitchState(UIStateType.UIHomeStoryController, idNumber, function()
        end, true, true, true)
      end)
    end
  end
end

function UIStoryViewer3D:ExitBtnOnClick()
  self:SwitchState(UIStateType.UIMain)
end
