local PVPFinishFlow = System.NewClass("PVPFinishFlow")

function PVPFinishFlow:Start(winCamp, battleFinishData)
  local isWin = winCamp == bg.battleDataCenter:GetMyCamp()
  if isWin then
    self:Win(battleFinishData)
  else
    self:Fail(battleFinishData)
  end
  return self
end

function PVPFinishFlow:Win(battleFinishData)
  local finishQueue = Z1Queue()
  self.finishQueue = finishQueue
  local battleResult = CommonDefine.BattleResult.Win
  finishQueue:Insert("PlayVoice", function()
    AudioManager.Instance:PostSoundEvent("Audio_Result_Fight_Win")
    bg.battleScene:PlayRandomVictoryVoice()
    finishQueue:Next()
  end)
  finishQueue:Insert("NotifyBattleResult", function()
    EventMgr.Instance.BattleResult:Dispatch(battleResult, battleFinishData)
    finishQueue:Next()
  end)
  if battleFinishData and battleFinishData.finishType == bc.BattleEndType.BoutLimit then
    finishQueue:Insert("ShowBoutMaxEnd", function()
      Alert.Show("PVPExceedMaxRoundsTips_Winner", nil, function()
        finishQueue:Next()
      end)
    end)
  end
  finishQueue:Insert("ShowSettleUpPanel", function()
    UIManager.Instance:Reopen(Urls.WorldStageBattleWinTip, function()
      if bg.battleData.isMock or bg.isReplay then
        finishQueue:OnDestroy()
        bg.battleScene:ClearPvP()
      else
        finishQueue:Next()
      end
    end)
  end)
  if not bg.isReplay then
    finishQueue:Insert("CheckPVPSettleData", function()
      local dura, total = 0.1, 5
      self.checkSettleDataTimer = TimerManager.Instance:CreateTimer(dura, total / dura, function()
        if PvPSettleDataUtils.IsHaveSettleData() then
          finishQueue:Next()
          TimerManager.Instance:StopTimer(self.checkSettleDataTimer)
          self.checkSettleDataTimer = nil
        end
      end, function()
        finishQueue:Next()
      end)
    end)
    finishQueue:Insert("ShowRankSettlePanel", function()
      if not PvPSettleDataUtils.IsHaveSettleData() then
        finishQueue:Next()
        return
      end
      if PvPSettleDataUtils.GetIsFriendGame() or PvPSettleDataUtils.GetIsPasswordGame() then
        finishQueue:Next()
        return
      end
      PvPSettleDataUtils.OpenPvPBattleRankSettlePanel(true, function()
        finishQueue:Next()
      end)
      DailyChallengeController.Instance:ReqOnOpenDailyChallenge()
    end)
    finishQueue:Insert("ShowDataSettlePanel", function()
      if not PvPSettleDataUtils.IsHaveSettleData() then
        finishQueue:Next()
        return
      end
      PvPSettleDataUtils.OpenPvPBattleDataSettlePanel(function()
        finishQueue:Next()
      end, battleResult)
    end)
    finishQueue:Insert("Finish", function()
      BattleManager.Instance:OnBattleFinish(battleResult, battleFinishData)
      finishQueue:Next()
    end)
    finishQueue:Insert("ClearPvP", function()
      bg.battleScene:ClearPvP()
      finishQueue:OnDestroy()
    end)
  else
    self:_FinishPvP(finishQueue)
  end
end

function PVPFinishFlow:_FinishPvP(finishQueue)
  finishQueue:Insert("FinishReplay", function()
    if bg.replayPlayer then
      bg.replayPlayer:Stop()
    end
    finishQueue:Next()
  end)
  finishQueue:Insert("ClearPvP", function()
    bg.battleScene:ClearPvP()
    finishQueue:OnDestroy()
  end)
end

function PVPFinishFlow:Fail(battleFinishData)
  local finishQueue = Z1Queue()
  self.finishQueue = finishQueue
  local battleResult = CommonDefine.BattleResult.Fail
  finishQueue:Insert("NotifyBattleResult", function()
    EventMgr.Instance.BattleResult:Dispatch(battleResult, battleFinishData)
    finishQueue:Next()
  end)
  if battleFinishData and battleFinishData.finishType == bc.BattleEndType.BoutLimit then
    finishQueue:Insert("ShowBoutMaxEnd", function()
      Alert.Show("PVPExceedMaxRoundsTips_Loser", nil, function()
        finishQueue:Next()
      end)
    end)
  end
  finishQueue:Insert("CheckFailTip", function()
    local failPanelUrl = Urls.WorldStageBattleFailTip
    if bg.isPVP_TRAIN then
      failPanelUrl = Urls.WorldStageBattleWinTip
    end
    UIManager.Instance:Reopen(failPanelUrl, function()
      if bg.battleData.isMock or bg.isReplay then
        finishQueue:OnDestroy()
        bg.battleScene:ClearPvP()
      else
        finishQueue:Next()
      end
    end)
  end)
  if not bg.isReplay then
    finishQueue:Insert("CheckPVPSettleData", function()
      local dura, total = 0.1, 5
      self.checkSettleDataTimer = TimerManager.Instance:CreateTimer(dura, total / dura, function()
        if PvPSettleDataUtils.IsHaveSettleData() then
          finishQueue:Next()
          TimerManager.Instance:StopTimer(self.checkSettleDataTimer)
          self.checkSettleDataTimer = nil
        end
      end, function()
        finishQueue:Next()
      end)
    end)
    finishQueue:Insert("ShowRankSettlePanel", function()
      if not PvPSettleDataUtils.IsHaveSettleData() then
        finishQueue:Next()
        return
      end
      if PvPSettleDataUtils.GetIsPasswordGame() then
        finishQueue:Next()
        return
      end
      if PvPSettleDataUtils.GetIsFriendGame() then
        finishQueue:Next()
        return
      end
      PvPSettleDataUtils.OpenPvPBattleRankSettlePanel(false, function()
        finishQueue:Next()
      end)
    end)
    finishQueue:Insert("ShowDataSettlePanel", function()
      PvPSettleDataUtils.OpenPvPBattleDataSettlePanel(function()
        finishQueue:Next()
      end, battleResult)
    end)
    finishQueue:Insert("Finish", function()
      BattleManager.Instance:OnBattleFinish(battleResult, battleFinishData)
      finishQueue:Next()
    end)
    finishQueue:Insert("ClearPvP", function()
      bg.battleScene:ClearPvP()
      finishQueue:OnDestroy()
    end)
  else
    self:_FinishPvP(finishQueue)
  end
end

function PVPFinishFlow:RunAll()
  if self.finishQueue then
    self.finishQueue:RunAll()
  end
end

function PVPFinishFlow:Dispose()
  if self.checkSettleDataTimer then
    TimerManager.Instance:StopTimer(self.checkSettleDataTimer)
    self.checkSettleDataTimer = nil
  end
  if self.finishQueue then
    self.finishQueue:OnDestroy()
    self.finishQueue = nil
  end
end

return PVPFinishFlow
