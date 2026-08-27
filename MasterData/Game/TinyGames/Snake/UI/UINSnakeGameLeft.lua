local UINSnakeGameLeft = class("UINSnakeGameLeft", UIBaseNode)
local SnakeGameConfig = require("Game.TinyGames.Snake.Config.SnakeGameConfig")

function UINSnakeGameLeft:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Play, self, self._OnBtnStartSnakeGame)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self._OnBtnRank)
  UIUtil.AddButtonListener(self.ui.btn_EndRank, self, self._OnBtnRank)
  UIUtil.AddButtonListener(self.ui.btn_Rule, self, self._OnBtnGameRule)
  UIUtil.AddButtonListener(self.ui.btn_Retry, self, self._OnBtnRetry)
  self.ui.joystick:onTouchMove("+", BindCallback(self, self.OnJoyStickMove))
  self.ui.joystick:onTouchUp("+", BindCallback(self, self.OnJoyStickUp))
  self._lastStickDir = 0
end

function UINSnakeGameLeft:InitSnakeGameLeft(snakeCtrl, snakeWindow)
  self._snakeCtrl = snakeCtrl
  self._snakeWindow = snakeWindow
  local showEndTime = self._snakeCtrl:GetSnakeActEndTime()
  local timeTable = TimeUtil:TimestampToDate(showEndTime, false, true)
  self.ui.tex_Time.text = string.format("%2d/%2d %2d:%2d", timeTable.month, timeTable.day, timeTable.hour, timeTable.min)
end

function UINSnakeGameLeft:EnterSnakeGameLeftInit()
  self.ui.controlNode:SetActive(false)
  self.ui.resultlNode:SetActive(false)
  self.ui.initialNode:SetActive(true)
end

function UINSnakeGameLeft:InitSnakeGameLeftPlay()
  self.ui.controlNode:SetActive(true)
  self.ui.resultlNode:SetActive(false)
  self.ui.initialNode:SetActive(false)
  self:OnJoyStickUp()
  self._lastStickDir = 0
  self:RefreshSnakeLeftScore(0)
end

function UINSnakeGameLeft:InitSnakeGameLeftEnd()
  self.ui.controlNode:SetActive(false)
  self.ui.resultlNode:SetActive(true)
end

function UINSnakeGameLeft:RefeshSnakeLeftBestScore(bestScore, rankIndex)
  self.ui.tex_score.text = tostring(bestScore)
  self.ui.tex_Rank:SetIndex(0, tostring(rankIndex))
  self.ui.tex_BestScore.text = tostring(bestScore)
end

function UINSnakeGameLeft:RefreshSnakeLeftScore(score)
  self.ui.tex_PlayScore.text = tostring(score)
end

function UINSnakeGameLeft:OnJoyStickMove(joyStickData)
  local angle = joyStickData.angle360
  if joyStickData.power < SnakeGameConfig.JoyStickPowerZone then
    return
  end
  local dir
  if self._lastStickDir == 0 then
    if 45 <= angle and angle < 135 then
      dir = 1
    elseif 135 <= angle and angle < 225 then
      dir = 3
    elseif 225 <= angle and angle < 315 then
      dir = 2
    else
      dir = 4
    end
  else
    local deadAngle = SnakeGameConfig.JoyStickDeadZone
    if angle >= 45 + deadAngle and angle < 135 - deadAngle then
      dir = 1
    elseif angle >= 135 + deadAngle and angle < 225 - deadAngle then
      dir = 3
    elseif angle >= 225 + deadAngle and angle < 315 - deadAngle then
      dir = 2
    elseif angle >= 315 + deadAngle or angle < 45 - deadAngle then
      dir = 4
    else
      return
    end
  end
  if dir == self._lastStickDir then
    return
  end
  self:OnJoyStickUp()
  self._lastStickDir = dir
  self._snakeCtrl:TryChangeSnakeDir(dir)
  local img = self.ui.obj_highlights[self._lastStickDir]
  if img ~= nil then
    img.color = Color.white
  end
end

function UINSnakeGameLeft:OnJoyStickUp()
  if self._lastStickDir > 0 then
    local img = self.ui.obj_highlights[self._lastStickDir]
    if img ~= nil then
      img.color = self.ui.color_normal
    end
  end
  self._lastStickDir = 0
end

function UINSnakeGameLeft:_OnBtnStartSnakeGame()
  self._snakeCtrl:StartSnakeGame()
end

function UINSnakeGameLeft:_OnBtnGameRule()
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(self._snakeCtrl:GetSnakeRuleId())
end

function UINSnakeGameLeft:_OnBtnRank()
  self._snakeCtrl:ClickSnakeRank()
end

function UINSnakeGameLeft:_OnBtnRetry()
  self._snakeCtrl:ClickSnakeRetry()
end

return UINSnakeGameLeft
