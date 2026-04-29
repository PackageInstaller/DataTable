_class("UIHauteCoutureDrawBgPLM", UICustomWidget)
UIHauteCoutureDrawBgPLM = UIHauteCoutureDrawBgPLM

function UIHauteCoutureDrawBgPLM:Constructor()
  self:AttachEvent(GameEventType.UIHauteCoutureDrawBgPLMAnimOut, self.PlayOutAnim)
  self:AttachEvent(GameEventType.UIHauteCoutureDrawBgPLMAnimIn, self.PlayInAnim)
end

function UIHauteCoutureDrawBgPLM:PlayOutAnim()
  self._anim = self:GetUIComponent("Animation", "anim")
  self._anim:Play("uieff_UIHauteCoutureDrawBgPLM_out")
end

function UIHauteCoutureDrawBgPLM:PlayInAnim()
  self._anim = self:GetUIComponent("Animation", "anim")
  self._anim:Play("uieff_UIHauteCoutureDrawBgPLM_in")
end

function UIHauteCoutureDrawBgPLM:OnHide()
  self:DetachEvent(GameEventType.UIHauteCoutureDrawBgPLMAnimOut, self.PlayOutAnim)
  self:DetachEvent(GameEventType.UIHauteCoutureDrawBgPLMAnimIn, self.PlayInAnim)
end
