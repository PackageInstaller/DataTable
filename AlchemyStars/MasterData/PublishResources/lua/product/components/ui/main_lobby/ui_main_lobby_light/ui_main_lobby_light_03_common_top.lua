require("ui_main_lobby_light_03_common")
_class("UIMainLobbyLight03CommonTop", UIMainLobbyLight03Common)
UIMainLobbyLight03CommonTop = UIMainLobbyLight03CommonTop

function UIMainLobbyLight03CommonTop:OnShow()
  local inTime = 1333
  self.event = GameGlobal.Timer():AddEvent(inTime, function()
    self:PlayLoopAnim()
  end)
end

function UIMainLobbyLight03CommonTop:PlayLoopAnim()
  local anim = self:GetUIComponent("Animation", "UIMainLight03_up")
  anim:Play("uieff_UIMainLight03up_loop")
end

function UIMainLobbyLight03CommonTop:OnHide()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
end
