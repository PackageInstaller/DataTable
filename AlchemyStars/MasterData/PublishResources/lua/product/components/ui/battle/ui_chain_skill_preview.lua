_class("UIChainSkillPreview", UICustomWidget)
UIChainSkillPreview = UIChainSkillPreview

function UIChainSkillPreview:OnShow()
  self._goOffset = self:GetGameObject("offset")
  self._btnOK = self:GetUIComponent("Button", "btnOK")
  self.enableFakeInput = true
  self:_ShowHideUIPreviewChain(false)
  self:_ActiveUIPreviewChainBtnOK(false)
  self:AttachEvent(GameEventType.ShowHideUIPreviewChain, self._ShowHideUIPreviewChain)
  self:AttachEvent(GameEventType.ActiveUIPreviewChainBtnOK, self._ActiveUIPreviewChainBtnOK)
end

function UIChainSkillPreview:OnHide()
  self:DetachEvent(GameEventType.ShowHideUIPreviewChain, self._ShowHideUIPreviewChain)
  self:DetachEvent(GameEventType.ActiveUIPreviewChainBtnOK, self._ActiveUIPreviewChainBtnOK)
end

function UIChainSkillPreview:_ShowHideUIPreviewChain(isShow)
  self._goOffset:SetActive(isShow)
end

function UIChainSkillPreview:_ActiveUIPreviewChainBtnOK(isOKEnabled)
  self._btnOK.interactable = isOKEnabled
end

function UIChainSkillPreview:btnCancelOnClick(go)
  self:_ShowHideUIPreviewChain(false)
  self:_ActiveUIPreviewChainBtnOK(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelChainSkillCast)
end

function UIChainSkillPreview:btnOKOnClick(go)
  if self._btnOK.interactable then
    self:_ShowHideUIPreviewChain(false)
    self:_ActiveUIPreviewChainBtnOK(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CastPickUpChainSkill)
  end
end
