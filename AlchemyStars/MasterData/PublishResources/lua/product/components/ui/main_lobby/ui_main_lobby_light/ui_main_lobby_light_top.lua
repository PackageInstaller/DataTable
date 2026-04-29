_class("UIMainLobbyLightTop", UICustomWidget)
UIMainLobbyLightTop = UIMainLobbyLightTop

function UIMainLobbyLightTop:OnShow()
  self._lights = {}
  self._anim_in = "uieff_MainLight_2_On"
  self._anim_loop = "uieff_MainLight_2_Loop"
  local l1 = self:GetUIComponent("Animation", "l1")
  local l2 = self:GetUIComponent("Animation", "l2")
  local l3 = self:GetUIComponent("Animation", "l3")
  local l4 = self:GetUIComponent("Animation", "l4")
  if l1 then
    table.insert(self._lights, l1)
  end
  if l2 then
    table.insert(self._lights, l2)
  end
  if l3 then
    table.insert(self._lights, l3)
  end
  if l4 then
    table.insert(self._lights, l4)
  end
  if self._lights and #self._lights > 0 then
    for i = 1, #self._lights do
      local anim = self._lights[i]
      anim:Play(self._anim_in)
    end
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._event = nil
    end
    self._event = GameGlobal.Timer():AddEvent(2100, function()
      self:PlayLoopAnim()
    end)
  end
end

function UIMainLobbyLightTop:PlayLoopAnim()
  if self._lights and #self._lights > 0 then
    for i = 1, #self._lights do
      local anim = self._lights[i]
      anim:Play(self._anim_loop)
    end
  end
end

function UIMainLobbyLightTop:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._lights = nil
end
