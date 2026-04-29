require("ui_main_lobby_light_03_common")
_class("UIMainLobbyLight03CommonDown", UIMainLobbyLight03Common)
UIMainLobbyLight03CommonDown = UIMainLobbyLight03CommonDown

function UIMainLobbyLight03CommonDown:OnShow()
  local inTime = 2100
  self.event = GameGlobal.Timer():AddEvent(inTime, function()
    self:PlayLoopAnim()
  end)
end

function UIMainLobbyLight03CommonDown:PlayLoopAnim()
  local anim = self:GetUIComponent("Animation", "UIMainLight03_right_4")
  anim:Play("uieff_UIMainLight03right4_loop")
end

function UIMainLobbyLight03CommonDown:OnHide()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
end
