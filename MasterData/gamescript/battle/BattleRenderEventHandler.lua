local RespawnHandle = require("Battle.RespawnHandle")
local BattleRenderEventHandler = System.NewClass("BattleRenderEventHandler")

function BattleRenderEventHandler:ctor(battleRender)
  self.battleRender = battleRender
  self.respawnHandle = RespawnHandle(battleRender)
end

function BattleRenderEventHandler:Awake()
  self:RegisterEvents()
end

function BattleRenderEventHandler:RegisterEvents()
  local eventMgr = bg.battleRender.eventMgr
  eventMgr:RegisterEvent(BattleRenderEvent.BattleBegin, self.OnBattleBegin, self)
  eventMgr:RegisterEvent(BattleRenderEvent.BattleRecover, self.OnBattleRecover, self)
  eventMgr:RegisterEvent(BattleRenderEvent.ChangeWave, self.OnChangeWave, self)
  eventMgr:RegisterEvent(BattleRenderEvent.BattleFinish, self.OnBattleFinish, self)
  eventMgr:RegisterEvent(BattleRenderEvent.PlayStory, self.OnPlayStory, self)
  eventMgr:RegisterEvent(BattleRenderEvent.Confirm, self.OnResConfirmMsg, self)
  eventMgr:RegisterEvent(BattleRenderEvent.UpdateSchoolArgs, self.OnUpdateSchoolArgs, self)
  eventMgr:RegisterEvent(BattleRenderEvent.SelectInitCard, self.OnSelectInitCard, self)
  eventMgr:RegisterEvent(BattleRenderEvent.InsertHistory, self.OnInsertHistory, self)
  eventMgr:RegisterEvent(BattleRenderEvent.ChangeKeeperSkill, self.OnChangeKeeperSkill, self)
  eventMgr:RegisterEvent(BattleRenderEvent.SwitchOceanModel, self.OnSetOceanModel, self)
  eventMgr:RegisterEvent(BattleRenderEvent.RunTimeline, self.OnRunTimeline, self)
  eventMgr:RegisterEvent(BattleRenderEvent.UpdateMonsterDamage, self.OnUpdateMonsterDamage, self)
  eventMgr:RegisterEvent(BattleRenderEvent.BloodRecoverTimesChange, self.OnUpdateBloodRecoverTimes, self)
  eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  eventMgr:RegisterEvent(BattleRenderEvent.UpdateSchoolSpecialArgs, self.OnUpdateSchoolSpecialArgs, self)
  eventMgr:RegisterEvent(BattleRenderEvent.PlayOpeningDialogue, self._OnPlayOpeningDialogue, self)
  eventMgr:RegisterEvent(BattleRenderEvent.PlayNormalDialogue, self._OnPlayNormalDialogue, self)
  eventMgr:RegisterEvent(BattleRenderEvent.AttachPostAction, self.OnAttachPostAction, self)
  eventMgr:RegisterEvent(BattleRenderEvent.UpdateStats, self.OnUpdateStats, self)
  eventMgr:RegisterEvent(BattleRenderEvent.ChangeDiePerform, self.OnChangeDiePerform, self)
  eventMgr:RegisterEvent(BattleRenderEvent.SyncLives, self.OnSyncLives, self)
  if BattleRenderEvent.LockedEnemyChanged then
    eventMgr:RegisterEvent(BattleRenderEvent.LockedEnemyChanged, self.OnLockedEnemyChanged, self)
  end
  EventMgr.Instance.ChooseRewindToBout:RegisterEvent(System.fn(self, self.OnChooseRewindToBout))
end

function BattleRenderEventHandler:UnregisterEvents()
  EventMgr.Instance.ChooseRewindToBout:RemoveEvent(System.fn(self, self.OnChooseRewindToBout))
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function BattleRenderEventHandler:Dispose()
  self:UnregisterEvents()
  if self.respawnHandle then
    self.respawnHandle:Dispose()
    self.respawnHandle = nil
  end
  if self.battleRender then
    self.battleRender.recordMgr:RecycleAllAnimAwaiters()
  end
  self.battleRender = nil
end

function BattleRenderEventHandler:OnBattleBegin()
  bg.battleRender:OnBattleBegin()
end

function BattleRenderEventHandler:OnBattleRecover()
  self.battleRender.battlePhase = bc.BattlePhase.Battle
  bg.battleScene:OnBattleRecover()
end

function BattleRenderEventHandler:OnBattleFinish(data)
  local myCamp = bg.battleDataCenter:GetMyCamp()
  local result = data.winCamp == myCamp and cd.BattleResult.Win or cd.BattleResult.Fail
  self.battleRender:PerformWithDelay(cd.BattleFinishOverTime, function()
    self.battleRender:OnBattleFinishOverTime(result, data)
  end, self.battleRender)
  self.battleRender:SetWinCamp(data.winCamp)
  self.battleRender.battleFinished = true
  self.battleRender:DoBatttleFinish(data)
  if self.battleRender then
    self.battleRender.recordMgr:RecycleAllAnimAwaiters()
  end
end

function BattleRenderEventHandler:OnPlayStory(data)
  local storyId = data.storyId
  if storyId then
    local awaiter = Awaiter.Get()
    EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiter, "OnPlayStory", 9999, true)
    local isBubbleStory = AvgStoryManager.Instance:IsAvgBubble(storyId)
    if isBubbleStory then
      AvgStoryManager.Instance:StartStoryById(storyId)
      if AvgStoryManager.Instance:IsSkipPlot() then
        awaiter:SetCompleted()
      else
        self.battleRender:PerformWithDelay(7, function()
          awaiter:SetCompleted()
        end)
      end
    else
      AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
        awaiter:SetCompleted()
      end)
    end
  end
end

function BattleRenderEventHandler:OnChangeWave(data)
end

function BattleRenderEventHandler:OnResConfirmMsg(data)
  if data.confirmType == bc.ConfirmType.Respawn then
    self.respawnHandle:OnResRespawnConfirm(data)
  end
end

function BattleRenderEventHandler:OnUpdateSchoolArgs(data)
  local role
  if data.roleUid then
    role = bg.battleScene:GetRole(data.roleUid)
  else
    role = bg.battleScene:GetPlayerRole()
  end
  if not role then
    return
  end
  role:UpdateSchoolArgs(data.schoolArgs)
end

function BattleRenderEventHandler:OnSelectInitCard(data)
  local roleCamp = bg.battleDataCenter:GetRoleCamp(data.roleUid)
  if roleCamp == bg.battleDataCenter:GetMyCamp() then
    local battlePanel = UIManager.Instance:GetWindow(Urls.PvPBattleMainPanel)
    local cardUI = battlePanel:GetCardUI(roleCamp)
    local cardMgr = self.battleRender.cardMgr:GetCardMgrByCamp(roleCamp)
    local handCards = cardMgr:GetCardListByDeck(bc.CardDeck.HandDeck)
    if #handCards > 0 then
      return
    end
    cardUI:CreateSelectedCard()
    UIManager.Instance:Reopen(Urls.PvPSelectInitCardPanel, data)
  end
end

function BattleRenderEventHandler:OnInsertHistory(data)
  bg.battleDataCenter:InsertHistory(data)
end

function BattleRenderEventHandler:OnChangeKeeperSkill(data)
  bg.battleDataCenter:SetPlayerKeeperSkill(data.tid)
  BattleKeeperSkillAssetCache.Instance:ChangeKeeperSkill(data.tid)
  if data.changeType == bc.KeeperSkillChangeType.Permanent then
    local stageData = WorldStageManager.Instance:GetCurStageData()
    if stageData then
      stageData.keeperSkillId = data.tid
    end
  end
end

function BattleRenderEventHandler:OnSetOceanModel(data)
  bg.battleDataCenter:SetOceanModel(data.model)
end

function BattleRenderEventHandler:OnRunTimeline(data)
  local timelinePath = data.timelinePath
  if data.runType == bc.TimelineRunType.Caster then
    local casterRole = bg.battleScene:GetRoleByUid(data.roleUid)
    if casterRole then
      casterRole:PlayKeeperSkillTimeline(timelinePath, "", nil, false)
    end
  elseif data.runType == bc.TimelineRunType.Target then
    local targetUids = data.targetUids or {}
    for i = 1, #targetUids do
      local role = bg.battleScene:GetRoleByUid(targetUids[i])
      local awakerList = role.awakerList or {}
      for j = 1, #awakerList do
        local awaker = awakerList[j]
        awaker:PlayAssignTimeline(timelinePath, function()
          awaker:Change2Idle_WhenNotDie()
        end)
      end
    end
  else
    Logger.Error("OnRunTimeline failed: runType error ", data.runType)
  end
end

function BattleRenderEventHandler:OnUpdateMonsterDamage(data)
  bg.battleDataCenter.monsterDamage.value = data.monsterDamage
  bg.battleDataCenter.damageOrder.value = data.damageOrder
  EventMgr.Instance.UpdateMonsterDamage:Dispatch()
end

function BattleRenderEventHandler:OnUpdateBloodRecoverTimes(data)
  bg.battleDataCenter.boutBloodRecoverTimes.value = data.times
end

function BattleRenderEventHandler:OnUpdateSchoolSpecialArgs(data)
  local playerDataModel = bg.battleDataCenter:GetRoleDataModel(data.roleUid)
  if not playerDataModel then
    return
  end
  playerDataModel:UpdateSchoolSpecialArgs(data.schoolSpecialArgs)
end

function BattleRenderEventHandler:_OnPlayOpeningDialogue(data)
  local duration = DT.GetConstant("ReletedAwakerDisplayTime")
  local targetVoiceTid = data.voiceID
  local voiceInfo = {
    voiceTid = targetVoiceTid,
    camp = data.camp,
    duration = duration
  }
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
  local relatedVoiceTid = PvpOpeningVoiceCfgUtils.GetCfgField("ReletedVoiceID", targetVoiceTid)
  local relatedVoiceCamp = data.camp == bc.BattleCamp.Camp1 and bc.BattleCamp.Camp2 or bc.BattleCamp.Camp1
  local voiceInfo2 = {
    voiceTid = relatedVoiceTid,
    camp = relatedVoiceCamp,
    duration = duration
  }
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo2)
end

function BattleRenderEventHandler:_OnPlayNormalDialogue(data)
  local duration = DT.GetConstant("OtherDisplayTime")
  local voiceInfo = {
    voiceTid = data.camp1VoiceID,
    camp = bc.BattleCamp.Camp1,
    duration = duration
  }
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
  local voiceInfo2 = {
    voiceTid = data.camp2VoiceID,
    camp = bc.BattleCamp.Camp2,
    duration = duration
  }
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo2)
end

function BattleRenderEventHandler:OnUpdateStats(data)
  local curBoutStats = data and data.statsData and data.statsData.curBoutStats
  if curBoutStats and curBoutStats.MonsterBeDamage and bg.battleDataCenter and bg.battleDataCenter.boutData then
    bg.battleDataCenter.boutData:SetStatsBoutDamage(curBoutStats.MonsterBeDamage)
  end
end

function BattleRenderEventHandler:OnChangeDiePerform(data)
  print("tlslash OnChangeDiePerform", table.tostring(data))
  if not data or "table" ~= type(data) or not data.roleUid then
    return
  end
  local constantId = data.perform
  local awakerClient = bg.battleScene:GetAwakerByUid(data.roleUid)
  if awakerClient then
    awakerClient.changeDieShow = constantId
  end
end

function BattleRenderEventHandler:OnSyncLives(data)
  if self.battleRender then
    self.battleRender.lives = data.lives
  end
end

function BattleRenderEventHandler:OnLockedEnemyChanged(data)
  if bg.battleDataCenter then
    bg.battleDataCenter:SetLockerUidToLockedUid(data and data.lockerUidToLockedUid)
  end
end

function BattleRenderEventHandler:OnAttachPostAction(data)
  if not data.casterUid or not data.skillTid then
    return
  end
  if data.isPerform ~= cd.AttachPostActionPerformType.ActorPainting and data.isPerform ~= cd.AttachPostActionPerformType.CardFace then
    return
  end
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.casterUid)
  if not roleDataModel then
    return
  end
  UIManager.Instance:Reopen(Urls.BattleAttachPostSkillPanel, roleDataModel.tid, data.skillTid, roleDataModel.curSkin, roleDataModel.gender, data.isPerform)
end

function BattleRenderEventHandler:OnCommandResult(data)
end

function BattleRenderEventHandler:OnChooseRewindToBout(boutNumber, forBattleRestart)
  if not bg.battleRender then
    return
  end
  bg.battleRender:SendCommand(BattleCommand.lg_RewindToBout, {
    boutNumber = boutNumber,
    forBattleRestart = forBattleRestart or nil
  })
end

return BattleRenderEventHandler
