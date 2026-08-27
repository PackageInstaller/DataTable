local UIUltSkillVideo = class("UIUltSkillVideo", UIBaseWindow)
local base = UIBaseWindow
local cs_MovieManager = CS.MovieManager.Instance
local cs_BattleManager = CS.BattleManager.Instance

function UIUltSkillVideo:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_ultSkip, self, self.OnUltSkip)
end

function UIUltSkillVideo:InitBattlePlayerUltVideo()
  self.ultEffectSkipFunc = nil
  self._moviePlayer = cs_MovieManager:GetMoviePlayer()
  self._moviePlayer:SetVideoRender(self.ui.videoRenderer)
end

function UIUltSkillVideo:PlayUltMoive(ultMovieFileName)
  if ultMovieFileName == nil then
    return
  end
  local battleCtrl = cs_BattleManager.CurBattleController
  local curUltSkill = battleCtrl.CurUltSkill
  if curUltSkill == nil then
    return
  end
  self._moviePlayer:SetVideoFadeInoutPercent(0.1)
  if self.timer == nil then
    self.timer = TimerManager:StartTimer(5, function()
      curUltSkill:CheckAndInvokeSelfTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    end, self, true, true, true)
  end
  local runningState = battleCtrl.fsm.currentState
  local originTimeScale = 1
  if runningState ~= nil and battleCtrl:BattleIsRunning() then
    originTimeScale = runningState:GetLastTimeScale()
  end
  cs_BattleManager.IsSkillToStart = true
  self._moviePlayer:PlayVideo(ultMovieFileName, function()
    local ctrl = cs_BattleManager.CurBattleController
    cs_BattleManager.IsSkillToStart = false
    ctrl:TrySetBattlePause(false)
    self:Delete()
  end)
end

function UIUltSkillVideo:OnUltSkip()
  local ctrl = cs_BattleManager.CurBattleController
  if cs_BattleManager.IsSkillToStart == false then
    ctrl:TrySetBattlePause(false)
    self:Delete()
  end
end

function UIUltSkillVideo:GetUltSkillMovieRenderer()
  return self.ui.videoRenderer
end

function UIUltSkillVideo:GetUltSkipBtnRenderer()
  return self.ui.btn_ultSkipRender
end

function UIUltSkillVideo:OnDelete()
  if self._moviePlayer ~= nil then
    cs_MovieManager:ReturnMoviePlayer(self._moviePlayer)
    self._moviePlayer = nil
  end
  if self.timer == nil then
    TimerManager:StopTimer(self.timer)
    self.timer = nil
    return
  end
  base.OnDelete(self)
end

return UIUltSkillVideo
