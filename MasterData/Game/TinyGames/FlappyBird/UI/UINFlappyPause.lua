local UINFlappyPause = class("UINFlappyPause", UIBaseNode)
local base = UIBaseNode
local FlappyBirdAudioConfig = require("Game.TinyGames.FlappyBird.Config.FlappyBirdAudioConfig")

function UINFlappyPause:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.OnPauseExit)
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self.OnResume)
  UIUtil.AddButtonListener(self.ui.btn_Restart, self, self.RestartGame)
end

function UINFlappyPause:ShowScore(score)
  self.ui.tex_Score.text = tostring(score)
end

function UINFlappyPause:RestartGame()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  self:HideAndBack()
  if self.__restartAction ~= nil then
    self.__restartAction()
  end
end

function UINFlappyPause:InjectPauseAction(resumeAction, restartAction, exitAction)
  self.__resumeAction = resumeAction
  self.__restartAction = restartAction
  self.__exitAction = exitAction
end

function UINFlappyPause:OnPauseExit()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  if self.__exitAction ~= nil then
    self.__exitAction()
  end
end

function UINFlappyPause:OnResume()
  AudioManager:PlayAudioById(FlappyBirdAudioConfig.OnClickButton)
  self:HideAndBack()
  if self.__resumeAction ~= nil then
    self.__resumeAction()
  end
end

function UINFlappyPause:HideAndBack()
  self:Hide()
end

function UINFlappyPause:OnDelete()
  base.OnDelete(self)
end

return UINFlappyPause
