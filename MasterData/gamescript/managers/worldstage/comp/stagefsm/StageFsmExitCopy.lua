local StageFsmExitCopy = System.NewClass("StageFsmExitCopy", LinearFsmState)

function StageFsmExitCopy:CheckEnter()
  if self.entity:GetStageExitData() then
    return true
  end
end

function StageFsmExitCopy:Reset()
  if self.finishQueue then
    self.finishQueue:OnDestroy()
    self.finishQueue = nil
  end
end

function StageFsmExitCopy:OnStageExit()
  local stageData = self.entity.stageData
  local stageId = stageData and stageData.stageId
  local stageCfg = CopyDataUtils.GetStageCfg(stageId)
  if not stageCfg then
    return
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupCfgByStage(stageCfg.BelongGroup)
  local LimitedTimeActivityStageGroupType = DT.GetOriginalConstant("LimitedTimeActivityStageGroupType", {})
  if table.contains(LimitedTimeActivityStageGroupType, stageGroupCfg.Type) then
    DailyChallengeController.Instance:ReqOnOpenDailyChallenge()
  end
end

function StageFsmExitCopy:Enter()
  self.finishQueue = Z1Queue()
  local finishQueue = self.finishQueue
  finishQueue:Insert("WaitBattleFinish", function()
    if self.entity:GetIsGiveUp() then
      do return finishQueue.Next end
      return finishQueue.Next, finishQueue, nil
    end
    if not SceneMgr.Instance:IsInBattle() then
      finishQueue:Next()
    else
      BattleManager.Instance:WaitBattleFinish(function()
        finishQueue:Next()
      end)
    end
  end, 8)
  finishQueue:Insert("ClearWork", function()
    BattleManager.Instance:WaitBattleFinish(function()
    end)
    if not self.entity:IsStoryStage() then
      if WorldRecoveryManager.Instance:IsWaitingAbyssResetConfirm() then
        UIManager.Instance:CloseAllExcept({
          Urls.AlertConfirmPanel,
          Urls.AlertConfirm2Panel,
          Urls.AlertConfirm3Panel
        })
      else
        UIManager.Instance:CloseAllExcept()
      end
    end
    self.entity:DestroyMap()
    self:OnStageExit()
    finishQueue:Next()
  end)
  if not StageFsmBeforeBattle.isSkipRecoverBattle and not WorldStageComp.isSkipRecoverWorldStage and not self.entity.isSaveAndExit then
    finishQueue:Insert("PlayEndStory", function()
      if self.entity.isGiveUp then
        do return finishQueue.Next end
        return finishQueue.Next, finishQueue, nil, nil, nil, nil, nil
      end
      local exitData = self.entity:GetStageExitData()
      if not exitData.isFinish then
        do return finishQueue.Next end
        return finishQueue.Next, finishQueue, nil, nil, nil, nil
      end
      local storyId = self.entity:GetEndStoryId()
      if storyId then
        AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
          finishQueue:Next()
        end)
      else
        do return finishQueue.Next end
        return finishQueue.Next, finishQueue, storyId, nil, function()
          finishQueue:Next()
        end
      end
    end)
    finishQueue:Insert("PlayAudio", function()
      UIManager.Instance:CloseByUrl(Urls.AvgDialogPanelNew)
      local exitData = self.entity:GetStageExitData()
      if self.entity.isGiveUp then
        AudioManager.Instance:PostSoundEvent("CHAPTER_QUIT_MUSIC")
      elseif exitData.isFinish then
        local notStoryStage = not self.entity:IsStoryStage()
        local notFinishPlay = not MainCopyDataUtils.IsPlayChapterFinishPlay(self.entity.stageData.stageId)
        if notFinishPlay or notStoryStage then
          AudioManager.Instance:PostSoundEvent("CHAPTER_WIN_MUSIC")
        end
      else
        AudioManager.Instance:PostSoundEvent("CHAPTER_FAIL_MUSIC")
      end
      finishQueue:Next()
    end)
    finishQueue:Insert("ShowSettlePanel", function()
      if self.entity:IsStoryStage() then
        AvgStoryManager.Instance:WaitStoryFinish(nil, function()
          finishQueue:Next()
        end)
        return
      end
      if self.entity:IsAwakerTrialStage() then
        finishQueue:Next()
        return
      end
      self.entity:ShowCopySettlePanel(function()
        SceneMgr.Instance:ClosePermanentUIs()
        finishQueue:Next()
      end)
    end)
    finishQueue:Insert("PlayAvgFinish", function()
      local stageData = WorldStageManager.Instance:GetCurStageData()
      local stageId = stageData.stageId
      local exitData = self.entity:GetStageExitData()
      if exitData and exitData.isFinish == false then
        do return finishQueue.Next end
        return finishQueue.Next, finishQueue, nil, nil, nil
      end
      if MainCopyDataUtils.IsPlayChapterFinishPlay(self.entity.stageData.stageId) then
        UIManager.Instance:Reopen(Urls.AvgFinishPanel, stageId, function()
          finishQueue:Next()
        end)
      else
        do return finishQueue.Next end
        return finishQueue.Next, finishQueue, Urls.AvgFinishPanel, stageId, function()
          finishQueue:Next()
        end
      end
    end)
  else
    StageFsmBeforeBattle.isSkipRecoverBattle = false
    WorldStageComp.isSkipRecoverWorldStage = false
  end
  StageFsmBeforeBattle.isSkipRecoverBattle = false
  WorldStageComp.isSkipRecoverWorldStage = false
  finishQueue:Insert("ExitCopy", function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    StageFsmBeforeBattle.isSkipRecoverBattle = false
    WorldStageComp.isSkipRecoverWorldStage = false
    local isStoryStage = self.entity:IsStoryStage()
    local isRecover = self.entity:IsRecover()
    if isRecover then
      StageExitPanelManager.Instance:PushWhenWorldStageRecover(stageData.stageId)
    end
    self.entity:ExitCopy()
    self.entity:PopRatingTips()
    if isStoryStage and isRecover then
      SceneMgr.Instance:EnterTown()
    end
    SettingManager.Instance:SetAutoFight(false)
    finishQueue:Next()
    WorldStageComp.isSaveAndExit = false
  end)
end

return StageFsmExitCopy
