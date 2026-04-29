_class("UIChooseStaticDynamicBtns", UICustomWidget)
UIChooseStaticDynamicBtns = UIChooseStaticDynamicBtns

function UIChooseStaticDynamicBtns:Constructor()
  self._roleModule = self:GetModule(RoleModule)
end

function UIChooseStaticDynamicBtns:GetComponents()
  self._staticRect = self:GetUIComponent("RectTransform", "static")
  self._dynamicRect = self:GetUIComponent("RectTransform", "dynamic")
  self._staticText = self:GetUIComponent("UILocalizationText", "staticText")
  self._dynamicText = self:GetUIComponent("UILocalizationText", "dynamicText")
  self._bg2 = self:GetGameObject("bg2")
  self._bg1 = self:GetGameObject("bg1")
end

function UIChooseStaticDynamicBtns:OnShow(uiParams)
  self:GetComponents()
  self:_InitSkinState()
  self:ChangeDynamicAndStatic(self._cgState)
end

function UIChooseStaticDynamicBtns:_InitSkinState()
  local flagValue = self._roleModule:GetExtFlag(CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE)
  if flagValue then
    self._cgState = DynamicAndStaticState.Static
  else
    self._cgState = DynamicAndStaticState.Dynamic
  end
end

function UIChooseStaticDynamicBtns:StaticDynamicBtnsOnClick()
  if self._cgState == DynamicAndStaticState.Static then
    self._cgState = DynamicAndStaticState.Dynamic
    GameGlobal.UAReportForceGuideEvent("UIMainClick", {
      "Click_Dynamic"
    }, true)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlideDynamic)
  else
    self._cgState = DynamicAndStaticState.Static
    GameGlobal.UAReportForceGuideEvent("UIMainClick", {
      "Click_Static"
    }, true)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSlide)
  end
  self:ChangeDynamicAndStatic(self._cgState)
  GameGlobal.TaskManager():StartTask(self._OnGetExtData, self, self._cgState)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchSkinStaticOrDynamic, self._cgState)
end

function UIChooseStaticDynamicBtns:_OnGetExtData(TT, state)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local flagValue = false
  if state == DynamicAndStaticState.Static then
    flagValue = true
  else
    flagValue = false
  end
  roleModule:SetExtFlag(TT, CharExtFlag.CEFT_MAIN_UI_SHOW_SPINE, flagValue)
end

function UIChooseStaticDynamicBtns:ChangeDynamicAndStatic(state)
  if self._dsTween then
    self._dsTween:Kill()
  end
  if state == DynamicAndStaticState.Dynamic then
    local pos = self._dynamicRect.anchoredPosition
    self._bg1:SetActive(false)
    self._bg2:SetActive(true)
    self._dynamicText.color = Color.black
    self._staticText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
  else
    local pos = self._staticRect.anchoredPosition
    self._bg1:SetActive(true)
    self._bg2:SetActive(false)
    self._staticText.color = Color.black
    self._dynamicText.color = Color(0.38823529411764707, 0.38823529411764707, 0.38823529411764707, 1)
  end
end
