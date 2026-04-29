_class("UIMainLobbyLightBanner", UICustomWidget)
UIMainLobbyLightBanner = UIMainLobbyLightBanner

function UIMainLobbyLightBanner:OnShow()
  self._anim_in = "uieff_MainLight_2_On"
  self._anim_loop = "uieff_MainLight_2_Loop"
  self._anim = self:GetUIComponent("Animation", "anim")
  if self._anim then
    self._anim:Play(self._anim_in)
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._event = nil
    end
    self._event = GameGlobal.Timer():AddEvent(2100, function()
      self:PlayLoopAnim()
    end)
  end
end

function UIMainLobbyLightBanner:PlayLoopAnim()
  if self._anim then
    self._anim:Play(self._anim_loop)
  end
end

function UIMainLobbyLightBanner:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._anim = nil
end
