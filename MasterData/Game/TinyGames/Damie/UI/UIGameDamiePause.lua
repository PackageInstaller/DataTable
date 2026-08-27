local UIGameDamiePause = class("UINFlappyPause", UIBaseNode)
local base = UIBaseNode

function UIGameDamiePause:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnPauseExit)
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self.OnResume)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.RestartGame)
end

function UIGameDamiePause:ShowScore(score)
  self.ui.tex_Score.text = tostring(score)
end

function UIGameDamiePause:RestartGame()
  self:HideAndBack()
  if self.__restartAction ~= nil then
    self.__restartAction()
  end
end

function UIGameDamiePause:InjectPauseAction(resumeAction, restartAction, exitAction)
  self.__resumeAction = resumeAction
  self.__restartAction = restartAction
  self.__exitAction = exitAction
end

function UIGameDamiePause:OnPauseExit()
  self:HideAndBack()
  if self.__exitAction ~= nil then
    self.__exitAction()
  end
end

function UIGameDamiePause:OnResume()
  self:HideAndBack()
  if self.__resumeAction ~= nil then
    self.__resumeAction()
  end
end

function UIGameDamiePause:HideAndBack()
  self:Hide()
end

function UIGameDamiePause:OnDelete()
  base.OnDelete(self)
end

return UIGameDamiePause
