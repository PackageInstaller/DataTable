local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local TimePassFunc = {
  [proto_object_CounterModule.CounterModuleNone] = function(data, moduleRefreshTables)
    warn("timePass : CounterModuleNone")
  end,
  [proto_object_CounterModule.CounterModuleDailyQuest] = function(data, moduleRefreshTables)
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] or {isSendMsg = false}
    if not refreshTable.isSendMsg then
      local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
      if taskCtrl ~= nil then
        taskCtrl:CheckExpiredAndUpdate()
        refreshTable.isSendMsg = true
      end
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] = refreshTable
  end,
  [proto_object_CounterModule.CounterModuleWeeklyQuest] = function(data, moduleRefreshTables)
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] or {isSendMsg = false}
    if not refreshTable.isSendMsg then
      local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
      if taskCtrl ~= nil then
        taskCtrl:CheckExpiredAndUpdate()
        refreshTable.isSendMsg = true
      end
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDailyQuest] = refreshTable
  end,
  [proto_object_CounterModule.CounterModuleDungeonModuleCount] = function(data, moduleRefreshTables)
    local moduleId = data.specifyId
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] or {isSendMsg = false, isSendResDundeonNotice = false}
    if not refreshTable.isSendMsg then
      NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_STATIC_Detail()
      refreshTable.isSendMsg = true
    end
    if not refreshTable.isSendResDundeonNotice and (moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_GoldDungeron or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_ExpDungeon or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon2 or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon3) then
      refreshTable.isSendResDundeonNotice = true
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(data.nextExpiredTm, NoticeManager.eNoticeType.ResDungeonRefresh, {
        jumpType = JumpManager.eJumpTarget.resourceDungeon,
        argList = {1701}
      }, nil, nil))
    elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_friendship then
      local heroId = ConfigData.game_config.firtBoardHeroID
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(data.nextExpiredTm, NoticeManager.eNoticeType.FragDungeonRefresh, {
        jumpType = JumpManager.eJumpTarget.fragDungeon,
        argList = {heroId}
      }, nil, nil))
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] = refreshTable
  end,
  [proto_object_CounterModule.CounterModuleGlobalDailyFlush] = function(data, moduleRefreshTables)
    local moduleId = data.specifyId
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleGlobalDailyFlush] or {isSendMsg = false}
    local dungeonRefreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] or {isSendMsg = false, isSendResDundeonNotice = false}
    local WCRefreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] or {isSendMsg = false}
    if not refreshTable.isSendMsg then
      NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_SystemOverDay()
      refreshTable.isSendMsg = true
    end
    if not dungeonRefreshTable.isSendMsg then
      NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_STATIC_Detail()
      dungeonRefreshTable.isSendMsg = true
    end
    if not WCRefreshTable.isSendMsg and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) then
      WCRefreshTable.isSendMsg = true
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_Detail(function()
      end)
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = WCRefreshTable
    moduleRefreshTables[proto_object_CounterModule.CounterModuleGlobalDailyFlush] = refreshTable
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDungeonModuleCount] = dungeonRefreshTable
    local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    if activityFrameCtrl ~= nil then
      activityFrameCtrl:UpdateActivityDailyFlush()
    end
    local setCtrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
    setCtrl:CleanIsTodayPlayedUltSkillAnimi()
    PlayerDataCenter.supportHeroData:SetCachedSupportData(nil, nil, nil, nil, nil)
    MsgCenter:Broadcast(eMsgEventId.OnCommonDayPass)
    local dayPassStr = ConfigData:GetTipContent(TipContent.ExpiredMention)
    cs_MessageCommon.ShowMessageTipsWithErrorSound(dayPassStr)
    if isGameDev then
      print(dayPassStr)
    end
  end,
  [proto_object_CounterModule.CounterModuleDailyChallenge] = function(data, moduleRefreshTables)
    local moduleId = data.specifyId
    PlayerDataCenter.periodicChallengeData:SetIsDailyOutOfData(true)
    NoticeManager:AddNotice(NoticeData.CreateNoticeData(data.nextExpiredTm, NoticeManager.eNoticeType.dailyChallenge, {
      jumpType = JumpManager.eJumpTarget.Sector,
      argList = nil
    }, nil, nil))
    local isInChallengeEp = ExplorationManager:IsInExploration() and ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
    if isInChallengeEp then
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_DAILYCHALLENGE_Detail(function()
        ExplorationManager:ExitExploration()
        if Time.unity_time.timeScale ~= 1 then
          Time.unity_time.timeScale = 1
        end
      end)
      return
    end
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    if hasHasUncompletedEp and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
      local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
      explorationNetwork:CS_EXPLORATION_Detail()
    end
    NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_DAILYCHALLENGE_Detail(function()
      MsgCenter:Broadcast(eMsgEventId.ChallengeOutOfData)
    end)
  end,
  [proto_object_CounterModule.CounterModuleDailyBouns] = function(data, moduleRefreshTables)
  end,
  [proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = function(data, moduleRefreshTables)
    local WCRefreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] or {isSendMsg = false}
    PlayerDataCenter.allWeeklyChallengeData:SetOutOfData()
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge) and PlayerDataCenter.allWeeklyChallengeData:IsExistChallenge() then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(data.nextExpiredTm, NoticeManager.eNoticeType.weeklyChallenge, {
        jumpType = JumpManager.eJumpTarget.Sector,
        argList = nil
      }, nil, nil))
    end
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.DailyChallenge, false)
    local isInChallengeEp = ExplorationManager:IsInExploration() and ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
    if isInChallengeEp then
      WCRefreshTable.isSendMsg = true
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_Detail(function()
        ExplorationManager:ForceExitEp()
      end)
      moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = WCRefreshTable
      return
    end
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    if hasHasUncompletedEp and moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
      local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
      explorationNetwork:CS_EXPLORATION_Detail()
    end
    if not WCRefreshTable.isSendMsg then
      WCRefreshTable.isSendMsg = true
      NetworkManager:GetNetwork(NetworkTypeID.Sector):CS_WEEKLYCHALLENGE_Detail(function()
        MsgCenter:Broadcast(eMsgEventId.ChallengeOutOfData)
      end)
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleWeeklyChallengeFresh] = WCRefreshTable
  end,
  [proto_object_CounterModule.CounterModuleRefreshableDungeon] = function(data, moduleRefreshTables)
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleRefreshableDungeon] or {isSendMsg = false}
    moduleRefreshTables[proto_object_CounterModule.CounterModuleRefreshableDungeon] = refreshTable
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    local isNew = dungeonDyncElem.isDailyDungeonNew
    if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon) and isNew then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(data.nextExpiredTm, NoticeManager.eNoticeType.DailyDungeon, {
        jumpType = JumpManager.eJumpTarget.Sector,
        argList = nil
      }, nil, nil))
    end
    if BattleUtil.IsInDailyDungeon() then
      refreshTable.isSendMsg = true
      NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_Dync_Detail(function()
        local dungeonCtrl = BattleDungeonManager:GetDungeonCtrl()
        if dungeonCtrl ~= nil and dungeonCtrl:DungeonIsInWaitFirstLoadScene() then
          dungeonCtrl:SetDungeonAfterEnterSceneExit()
        else
          BattleDungeonManager:RetreatDungeonNoReq()
          if Time.unity_time.timeScale ~= 1 then
            Time.unity_time.timeScale = 1
          end
        end
      end)
      return
    end
    if not refreshTable.isSendMsg then
      refreshTable.isSendMsg = true
      NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon):CS_DUNGEON_Dync_Detail(function()
        MsgCenter:Broadcast(eMsgEventId.DailyDungeonOutOfData)
      end)
    end
  end,
  [proto_object_CounterModule.CounterModuleWekklyChallengeQuest] = function(data, moduleRefreshTables)
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleWekklyChallengeQuest] or {isSendMsg = false}
    if not refreshTable.isSendMsg then
      local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
      if taskCtrl ~= nil then
        taskCtrl:CheckExpiredAndUpdate()
        refreshTable.isSendMsg = true
      end
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleWekklyChallengeQuest] = refreshTable
  end,
  [proto_object_CounterModule.CounterModuleDormFixedRewardFresh] = function(data, moduleRefreshTables)
    local refreshTable = moduleRefreshTables[proto_object_CounterModule.CounterModuleDormFixedRewardFresh] or {isSendMsg = false}
    if not refreshTable.isSendMsg then
      refreshTable.isSendMsg = true
      NetworkManager:GetNetwork(NetworkTypeID.TimingProduct):CS_TimingProduct_Detail(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, function()
        MsgCenter:Broadcast(eMsgEventId.TimingProductOutOfDate)
      end)
    end
    moduleRefreshTables[proto_object_CounterModule.CounterModuleDormFixedRewardFresh] = refreshTable
  end,
  [proto_object_CounterModule.CounterModuleMaintain] = function(data, moduleRefreshTables)
    return
  end
}
return TimePassFunc
