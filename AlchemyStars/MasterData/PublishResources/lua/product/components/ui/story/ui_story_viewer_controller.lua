_class("UIStoryViewerController", UIController)
UIStoryViewerController = UIStoryViewerController

function UIStoryViewerController:OnShow(uiParams)
  self._storyIDTxt = self:GetUIComponent("Text", "Text")
  self._dropDown = self:GetUIComponent("Dropdown", "Dropdown")
  self._chapSecGO = self:GetGameObject("ChapSec")
  self._stringKeyGO = self:GetGameObject("StringKey")
  self._chapTxt = self:GetUIComponent("Text", "ChapText")
  self._secTxt = self:GetUIComponent("Text", "SecText")
  self._stringKeyTxt = self:GetUIComponent("InputField", "StrKeyText")
  
  function self._dropDownCallback(idx)
    self:OnDropDownChanged(idx)
  end
  
  self._dropDown.onValueChanged:AddListener(self._dropDownCallback)
  AudioHelperController.StopBGM(1)
  self:AttachEvent(GameEventType.UIShowEnd, self.OnUIShowEnd)
  self._idx = 0
end

function UIStoryViewerController:OnHide()
  self._dropDown.onValueChanged:RemoveListener(self._dropDownCallback)
end

function UIStoryViewerController:EnterStoryBtnOnClick()
  local idStr = self._storyIDTxt.text
  local idNumber = tonumber(idStr)
  if idNumber then
    GameGlobal.GetModule(StoryModule):StartStory(idNumber, nil)
  end
end

function UIStoryViewerController:ExitBtnOnClick()
  self:SwitchState(UIStateType.UIMain)
end

function UIStoryViewerController:OnDropDownChanged(idx)
  self._idx = idx
  self._chapSecGO:SetActive(idx == 1)
  self._stringKeyGO:SetActive(idx == 2)
end

function UIStoryViewerController:OnUIShowEnd(uiName)
  if uiName == "UIStoryController" and self._idx ~= 0 then
    local storyController = self:Manager():GetController("UIStoryController")
    local storyManager = storyController._storyManager
    if self._idx == 1 then
      local chap = tonumber(self._chapTxt.text)
      local sec = tonumber(self._secTxt.text)
      if chap and sec then
        storyManager:_Seek(chap, sec)
      end
    elseif self._idx == 2 then
      local chap, sec = storyManager:_FindDialogParagraphSection(self._stringKeyTxt.text)
      if chap and sec then
        storyManager:_Seek(chap, sec)
      else
        ToastManager.ShowToast("未找到包含指定文本key的章节")
      end
    end
  end
end
