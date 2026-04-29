_class("UIDefaultComponent", UIComponent)

function UIDefaultComponent:Constructor()
end

function UIDefaultComponent:Show(uiParams)
  local keepVoice = self.uiController:GetComponentSharedParam(UIComponentParamType.KeepVoice)
  if not keepVoice then
    GameGlobal.GetModule(PetAudioModule):StopAll()
  end
end

function UIDefaultComponent:AfterShow(TT)
end

function UIDefaultComponent:BeforeHide(TT)
end

function UIDefaultComponent:Hide()
end
