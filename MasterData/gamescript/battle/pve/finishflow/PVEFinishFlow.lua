local PVEFinishFlow = System.NewClass("PVEFinishFlow")

function PVEFinishFlow:Start(winCamp, battleFinishData, isShow)
  local isWin = winCamp == bg.battleDataCenter:GetMyCamp()
  self.isShowSettle = isShow
  self:_ReportSettleStep("Start", "isWin=" .. tostring(isWin))
  if isWin then
    self:Win(battleFinishData)
  else
    self:Fail(battleFinishData)
  end
  return self
end

function PVEFinishFlow:Win(battleFinishData)
  local finishQueue = Z1Queue()
  self.finishQueue = finishQueue
  local battleResult = CommonDefine.BattleResult.Win
  finishQueue:Insert("CloseSceneUIQueue", function()
    self:_ReportSettleStep("Win.CloseSceneUIQueue", "begin")
    SceneMgr.Instance:SetOpenUIQueueEnabled(false)
    self:_ReportSettleStep("Win.CloseSceneUIQueue", "next")
    finishQueue:Next()
  end)
  if self.isShowSettle then
    finishQueue:Insert("PlayWinVoice", function()
      self:_ReportSettleStep("Win.PlayWinVoice", "begin")
      AudioManager.Instance:PostSoundEvent("Audio_Result_Fight_Win")
      bg.battleScene:PlayRandomVictoryVoice()
      self:_ReportSettleStep("Win.PlayWinVoice", "next")
      finishQueue:Next()
    end)
  end
  finishQueue:Insert("NotifyBattleResult", function()
    self:_ReportSettleStep("Win.NotifyBattleResult", "begin")
    if bg.battleRender then
      bg.battleRender:NotifyBattleResult(battleResult, battleFinishData)
    end
    self:_ReportSettleStep("Win.NotifyBattleResult", "next")
    finishQueue:Next()
  end)
  if self.isShowSettle then
    finishQueue:Insert("ShowSettleUpPanel", function()
      self:_ReportSettleStep("Win.ShowSettleUpPanel", "reopen")
      UIManager.Instance:Reopen(Urls.WorldStageBattleSettleTip, battleFinishData, battleResult, nil, function()
        self:_ReportSettleStep("Win.ShowSettleUpPanel", "callback")
        finishQueue:Next()
      end)
    end)
  else
    finishQueue:Insert("WaitFinish", function()
      self:_ReportSettleStep("Win.WaitFinish", "createTimer")
      TimerManager.Instance:CreateTimer(2.5, 0, nil, function()
        self:_ReportSettleStep("Win.WaitFinish", "timerCallback")
        finishQueue:Next()
      end)
    end)
  end
  if not bg.isReplay then
    finishQueue:Insert("PlayStory", function()
      local storyId = bg.battleScene.battleCfg.VictoryDialogueId
      self:_ReportSettleStep("Win.PlayStory", "storyId=" .. tostring(storyId))
      if storyId then
        AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
          self:_ReportSettleStep("Win.PlayStory", "storyCallback")
          finishQueue:Next()
        end)
        return
      end
      self:_ReportSettleStep("Win.PlayStory", "noStory")
      finishQueue:Next()
    end)
    finishQueue:Insert("OpenSceneUIQueue", function()
      self:_ReportSettleStep("Win.OpenSceneUIQueue", "begin")
      SceneMgr.Instance:SetOpenUIQueueEnabled(true, function()
        self:_ReportSettleStep("Win.OpenSceneUIQueue", "callback")
        finishQueue:Next()
      end)
    end)
    finishQueue:Insert("Finish", function()
      self:_ReportSettleStep("Win.Finish", "OnBattleFinish")
      BattleManager.Instance:OnBattleFinish(battleResult, battleFinishData)
      self:_ReportSettleStep("Win.Finish", "next")
      finishQueue:Next()
    end)
  else
    finishQueue:Insert("FinishReplay", function()
      self:_ReportSettleStep("Win.FinishReplay", "begin")
      if bg.replayPlayer then
        bg.replayPlayer:Stop()
      end
      self:_ReportSettleStep("Win.FinishReplay", "next")
      finishQueue:Next()
    end)
  end
end

function PVEFinishFlow:Fail(battleFinishData)
  local finishQueue = Z1Queue()
  self.finishQueue = finishQueue
  local battleResult = CommonDefine.BattleResult.Fail
  finishQueue:Insert("CloseSceneUIQueue", function()
    self:_ReportSettleStep("Fail.CloseSceneUIQueue", "begin")
    SceneMgr.Instance:SetOpenUIQueueEnabled(false)
    self:_ReportSettleStep("Fail.CloseSceneUIQueue", "next")
    finishQueue:Next()
  end)
  if self.isShowSettle then
    finishQueue:Insert("PlayVoice", function()
      self:_ReportSettleStep("Fail.PlayVoice", "next")
      finishQueue:Next()
    end)
    finishQueue:Insert("CheckFailTip", function()
      self:_ReportSettleStep("Fail.CheckFailTip", "begin")
      if bg.battleData.notRestart then
        self:_ReportSettleStep("Fail.CheckFailTip", "notRestart")
        finishQueue:Next()
        return
      end
      BattleBackTrackUtils.ShowFailTips(function()
        self:_ReportSettleStep("Fail.CheckFailTip", "callbackContinue")
        finishQueue:Next()
      end, function()
        self:_ReportSettleStep("Fail.CheckFailTip", "callbackDestroy")
        finishQueue:OnDestroy()
        BattleBackTrackUtils.RestartBattle()
      end)
    end)
  end
  finishQueue:Insert("NotifyBattleResult", function()
    self:_ReportSettleStep("Fail.NotifyBattleResult", "dispatch")
    EventMgr.Instance.BattleResult:Dispatch(battleResult, battleFinishData)
    self:_ReportSettleStep("Fail.NotifyBattleResult", "next")
    finishQueue:Next()
  end)
  finishQueue:Insert("PlayStory", function()
    local storyId = BattleManager.Instance:GetFailStoryId()
    self:_ReportSettleStep("Fail.PlayStory", "storyId=" .. tostring(storyId))
    if storyId then
      AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
        self:_ReportSettleStep("Fail.PlayStory", "storyCallback")
        finishQueue:Next()
      end)
      return
    end
    self:_ReportSettleStep("Fail.PlayStory", "noStory")
    finishQueue:Next()
  end)
  finishQueue:Insert("OpenSceneUIQueue", function()
    self:_ReportSettleStep("Fail.OpenSceneUIQueue", "begin")
    SceneMgr.Instance:SetOpenUIQueueEnabled(true, function()
      self:_ReportSettleStep("Fail.OpenSceneUIQueue", "callback")
      finishQueue:Next()
    end)
  end)
  finishQueue:Insert("Finish", function()
    self:_ReportSettleStep("Fail.Finish", "begin")
    if not bg.isReplay then
      self:_ReportSettleStep("Fail.Finish", "OnBattleFinish")
      BattleManager.Instance:OnBattleFinish(battleResult, battleFinishData)
    end
    self:_ReportSettleStep("Fail.Finish", "next")
    finishQueue:Next()
  end)
end

function PVEFinishFlow:RunAll()
  if self.finishQueue then
    self:_ReportSettleStep("RunAll", "begin")
    self.finishQueue:RunAll()
  end
end

function PVEFinishFlow:Dispose()
  if self.finishQueue then
    self:_ReportSettleStep("Dispose", "destroyQueue")
    self.finishQueue:OnDestroy()
    self.finishQueue = nil
  end
end

function PVEFinishFlow:_ReportSettleStep(step, msg)
end

return PVEFinishFlow
