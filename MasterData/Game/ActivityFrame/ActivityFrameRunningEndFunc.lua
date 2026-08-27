local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local ActivityFrameRunningEndFunc = {
  [ActivityFrameEnum.eActivityType.SectorI] = function(activityFrameData)
    local sectorActivity = PlayerDataCenter.allActivitySectorIData:GetSectorIData(activityFrameData.actId)
    if sectorActivity == nil then
      return
    end
    sectorActivity:RefreshSectorIReddot()
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.ActSummerLvSwitch) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActSummerLvSwitch, true)
    end
    local actId = activityFrameData.actId
    local network = NetworkManager:GetNetwork(NetworkTypeID.ActivitySectorI)
    local actCfg = ConfigData.activity_time_limit[actId]
    if ExplorationManager:IsInExploration() then
    else
      local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        local sectorIActId = ConfigData.activity_time_limit.sectorMapping[stageCfg.sector]
        if sectorIActId == actId and actCfg.hard_stage ~= stageCfg.sector then
          TimerManager:StartTimer(1, function()
            local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
            explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
          end, nil, true)
        end
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(activityFrameData)
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
    if heroGrowCtrl ~= nil then
      local data = heroGrowCtrl:GetHeroGrowActivity(activityFrameData.actId)
      if data ~= nil then
        data:RefreshHeroGrowChallengeNewReddot()
      end
    end
    MsgCenter:Broadcast(eMsgEventId.HeroGrowActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.SectorII] = function(activityFrameData)
    local actId = activityFrameData.actId
    local SectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII, true)
    local sectorIIdata = SectorIICtrl:GetSectorIIDataByActId(actId)
    if sectorIIdata == nil then
      return
    end
    sectorIIdata:RefreshSectorIIReddotWhenActEnd()
    local AWMainMapWin = UIManager:GetWindow(UIWindowTypeID.ActivityWinterMainMap)
    if AWMainMapWin ~= nil then
      if UIManager:GetWindow(UIWindowTypeID.Win21Shop) == nil then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActivityWinterMainMap)
      end
      AWMainMapWin:ShowActivtyFinishedUI()
    end
    local Win21SectorBarWin = UIManager:GetWindow(UIWindowTypeID.Win21SectorBar)
    if Win21SectorBarWin ~= nil then
      Win21SectorBarWin:SetIsTreeFinishedUI(true)
    end
    if ExplorationManager:IsInExploration() then
    else
      local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil and sectorIIdata:GetSectorIIActId() == actId then
        local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
        explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.RefreshDun] = function(activityFrameData)
    local daMieWin = UIManager:GetWindow(UIWindowTypeID.AprilGameDamie)
    if daMieWin ~= nil then
      daMieWin:OnClickDamieBack()
    end
    local win = UIManager:GetWindow(UIWindowTypeID.AprilFool)
    if win ~= nil then
      win:RefreshAprilFoolMain()
    end
    if BattleDungeonManager:InBattleDungeon() then
      local dunInterfaceType = BattleDungeonManager.dunInterfaceData:GetInterfaceType()
      if dunInterfaceType == DungeonLevelEnum.InterfaceType.RefreshDun then
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
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.Carnival] = function(activityFrameData)
    local actId = activityFrameData.actId
    local activityCarnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
    if activityCarnivalCtrl == nil then
      return
    end
    local carnivalData = activityCarnivalCtrl:GetCarnivalAct(actId)
    if carnivalData == nil then
      return
    end
    carnivalData:DealCarnivalWhenEnd()
    local carnivalWin = UIManager:GetWindow(UIWindowTypeID.Carnival22Main)
    if carnivalWin ~= nil then
      carnivalWin:RefreshCarnivalBtnState()
      if UIManager:GetWindow(UIWindowTypeID.Carnival22Select) ~= nil or UIManager:GetWindow(UIWindowTypeID.Carnival22Task) ~= nil or UIManager:GetWindow(UIWindowTypeID.Carnival22StrategyOverview) ~= nil or UIManager:GetWindow(UIWindowTypeID.Carnival22MiniGame) ~= nil or UIManager:GetWindow(UIWindowTypeID.Carnival22Challenge) ~= nil then
        UIManager:HideWindow(UIWindowTypeID.MessageCommon)
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.Carnival22Main, false)
      end
    end
    if BattleDungeonManager:InBattleDungeon() then
      local dunInterfaceType = BattleDungeonManager.dunInterfaceData:GetInterfaceType()
      if dunInterfaceType == DungeonLevelEnum.InterfaceType.Carnival then
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
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.WhiteDay] = function(activityFrameData)
    local win = UIManager:GetWindow(UIWindowTypeID.WhiteDay)
    if win ~= nil then
      UIUtil.ReturnHome()
    end
    if ExplorationManager:IsInExploration() then
    else
      local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        local stageActType, atageActId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(stageCfg.sector)
        if stageActType == ActivityFrameEnum.eActivityType.WhiteDay and atageActId == activityFrameData.actId then
          PlayerDataCenter.sectorStage:SetSelectSectorId(nil)
          TimerManager:StartTimer(1, function()
            local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
            explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
          end, nil, true)
        end
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.SectorIII] = function(activityFrameData)
    local actId = activityFrameData.actId
    local SectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII, true)
    local sectorIIIdata = SectorIIICtrl:GetSectorIIIAct(actId)
    if sectorIIIdata == nil then
      return
    end
    sectorIIIdata:RefreshSectorIIIMapReddot()
    sectorIIIdata:RefreshSectorIIITaskReddot()
    sectorIIIdata:UpdActSum22TechRedDot()
    local mapUI = UIManager:GetWindow(UIWindowTypeID.ActSum22Map)
    local repeatUI = UIManager:GetWindow(UIWindowTypeID.ActSum22DunRepeat)
    local techUI = UIManager:GetWindow(UIWindowTypeID.ActSum22StrategyMain)
    local taskUI = UIManager:GetWindow(UIWindowTypeID.ActSum22Task)
    if mapUI ~= nil or repeatUI ~= nil or techUI or taskUI then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActSum22Main)
    end
    local snakeGameUI = UIManager:GetWindow(UIWindowTypeID.SnakeGame)
    if snakeGameUI ~= nil then
      UIUtil.ReturnHome()
    end
    if ExplorationManager:IsInExploration() then
    else
      local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
        explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Hallowmas] = function(activityFrameData)
    local actId = activityFrameData.actId
    local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    if hallowmasCtrl == nil then
      return
    end
    local data = hallowmasCtrl:GetHallowmasData(actId)
    if data == nil then
      return
    end
    data:RefreshHallowmasRedDailyTask()
    data:RefreshHallowmasRedAchievement()
    data:RefreshHallowmasRedRedEnvTask()
    data:DealHallowmasWhenEnd()
    if WarChessSeasonManager:IsInWCS() then
      local seasonId = WarChessSeasonManager:GetWCSSeasonId()
      local actType, actId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySeasonId(seasonId)
      if actType == activityFrameData:GetActivityFrameCat() and actId == activityFrameData:GetActId() then
        TimerManager:StartTimer(1, function()
          WarChessManager:ExitWarChess(Consts.SceneName.Sector, false, nil)
        end, nil, true)
      end
    else
      local uncomplete, seasonData = WarChessSeasonManager:GetUncompleteWCSData()
      if uncomplete then
        local actType, actId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySeasonId(seasonData.seasonId)
        if actType == activityFrameData:GetActivityFrameCat() and actId == activityFrameData:GetActId() then
          TimerManager:StartTimer(1, function()
            WarChessManager:SyncIsHaveUncompletedWarChess()
          end, nil, true)
        end
      end
    end
    if WarChessManager:GetIsInWarChess() then
      local sectorStage = WarChessManager:GetWCSectorStageCfg()
      local sectorId = sectorStage ~= nil and sectorStage.sector or 0
      local actType, actId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
      if actType == activityFrameData:GetActivityFrameCat() and actId == activityFrameData:GetActId() then
        TimerManager:StartTimer(1, function()
          GuideManager:SkipGuide()
          WarChessManager:ExitWarChess(Consts.SceneName.Sector, false, nil)
        end, nil, true)
      end
    else
      local uncomplete, stageId = WarChessManager:GetIsHaveUncompletedWarChess()
      if uncomplete then
        local sectorStageCfg = ConfigData.sector_stage[stageId]
        local sectorId = sectorStage ~= nil and sectorStage.sectorId or 0
        local actType, actId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
        if actType == activityFrameData:GetActivityFrameCat() and actId == activityFrameData:GetActId() then
          TimerManager:StartTimer(1, function()
            WarChessManager:SyncIsHaveUncompletedWarChess()
          end, nil, true)
        end
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Spring] = function(activityFrameData)
    local actId = activityFrameData.actId
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return
    end
    local unCompleteActTable, sectorActId
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
    if stageCfg ~= nil then
      unCompleteActTable, sectorActId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(stageCfg.sector)
    end
    if unCompleteActTable ~= nil and sectorActId == actId then
      TimerManager:StartTimer(1, function()
        local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
        explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
      end, nil, true)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
    local data = springCtrl:GetSpringData(actId)
    if data == nil then
      return
    end
    data:RefreshRedSpringTech()
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(activityFrameData)
    local actId = activityFrameData.actId
    local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    if winter23Ctrl == nil then
      return
    end
    local data = winter23Ctrl:GetWinter23DataByActId(actId)
    if data == nil then
      return
    end
    data:RefreshRedWinter23Tech()
    data:RefreshRedWinter23Main()
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
    sectorLevelChapterCtrl:RemoveChapterDataType(SectorChapterEnum.chapterDataType.actWinter23)
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.EpMixWarchess)
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        TimerManager:StartTimer(1, function()
          local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
          explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
        end, nil, true)
      end
    else
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        local sectorId = stageCfg.sectorId or 0
        local actType, actId = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
        if actType == activityFrameData:GetActivityFrameCat() and actId == activityFrameData:GetActId() then
          TimerManager:StartTimer(1, function()
            WarChessManager:SyncIsHaveUncompletedWarChess()
          end, nil, true)
        end
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Season] = function(activityFrameData)
    local actId = activityFrameData.actId
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if seasonCtrl == nil then
      return
    end
    local data = seasonCtrl:GetSeasonDataByActId(actId)
    if data == nil then
      return
    end
    data:RefreshRedSeasonTech()
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(activityFrameData)
    local actId = activityFrameData.actId
    local activityCarnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
    if activityCarnival23Ctrl == nil then
      return
    end
    local data = activityCarnival23Ctrl:GetCarnival23DataByActId(actId)
    if data == nil then
      return
    end
    data:RefreshRedCarnival23Main()
    data:RefreshRedCarnival23ExtraSector()
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
    sectorLevelChapterCtrl:RemoveChapterDataType(SectorChapterEnum.chapterDataType.actCarnival23)
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
    if stageCfg ~= nil then
      TimerManager:StartTimer(1, function()
        local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
        explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
      end, nil, true)
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.BattlePass] = function(activityFrameData)
    local bpData = PlayerDataCenter.battlepassData:GetBattlePassByActId(activityFrameData:GetActId())
    if bpData == nil then
      return
    end
    MsgCenter:Broadcast(eMsgEventId.BattlePassRunningEnd, bpData)
  end,
  [ActivityFrameEnum.eActivityType.CardSet] = function(activityFrameData)
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CardSetEntrance) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.CardSetEntrance, true)
    end
    if BattleDungeonManager:InBattleDungeon() then
      local dunInterfaceType = BattleDungeonManager.dunInterfaceData:GetInterfaceType()
      if dunInterfaceType == DungeonLevelEnum.InterfaceType.CardSet then
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
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.DailyChallenge] = function(activityFrameData)
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.EventDaliyChallenge) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.EventDaliyChallenge, false)
      local win = UIManager:GetWindow(UIWindowTypeID.EventDaliyChallenge)
      if win then
        win:RefreshADCDungeonList()
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Anniversary23] = function(activityFrameData)
    local actId = activityFrameData.actId
    local activityAnniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if activityAnniversary23Ctrl == nil then
      return
    end
    local data = activityAnniversary23Ctrl:GetAnniversary23DataByActId(actId)
    if data == nil then
      return
    end
    data:RefreshRedAnniversary23WCSTask()
    data:RefreshRedAnniversary23Tech()
    data:RefreshtHardLevelRedDot()
    data:RefreshRedAnniversary23MainStory()
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
    if stageCfg ~= nil then
      TimerManager:StartTimer(1, function()
        local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
        explorationNetwork:CS_EXPLORATION_Detail(activityFrameData:GetActivityFrameId())
      end, nil, true)
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.SteinsGate] = function(activityFrameData)
    local actId = activityFrameData.actId
    local activitySteinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    if activitySteinsGate23Ctrl == nil then
      return
    end
    local data = activitySteinsGate23Ctrl:GetSteinsGateDataByActId(actId)
    if data == nil then
      return
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    BattleDungeonManager:TryExitDungeonAfterActEnd(DungeonLevelEnum.InterfaceType.Repeat)
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Spring24] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
    if actCtrl == nil then
      return
    end
    local data = actCtrl:GetActDataByActId(actId)
    if data == nil then
      return
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrowV3] = function(activityFrameData)
    local hgV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
    if hgV3Ctrl ~= nil then
      local data = hgV3Ctrl:GetHeroGrowActivity(activityFrameData.actId)
      if data ~= nil then
        data:RefreshHeroGrowV3AllReddot()
      end
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CharDunVer3) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.CharDunVer3, true)
    end
    if BattleDungeonManager:InBattleDungeon() then
      local dunInterfaceType = BattleDungeonManager.dunInterfaceData:GetInterfaceType()
      if dunInterfaceType == DungeonLevelEnum.InterfaceType.HeroGrowV3Repeat or dunInterfaceType == DungeonLevelEnum.InterfaceType.HeroGrowChallenge or dunInterfaceType == DungeonLevelEnum.InterfaceType.HeroGrowV3Normal then
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
      end
    end
    MsgCenter:Broadcast(eMsgEventId.HeroGrowActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Carnival24] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    if actCtrl == nil then
      return
    end
    local data = actCtrl:GetActDataByActId(actId)
    if data == nil then
      return
    end
    data:RefreshRed_InfinityRewardPick()
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.Bond] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
    if actCtrl == nil then
      return
    end
    local data = actCtrl:GetActDataByActId(actId)
    if data == nil then
      return
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(activityFrameData)
    local actId = activityFrameData.actId
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    if actCtrl == nil then
      return
    end
    local data = actCtrl:GetActDataByActId(actId)
    if data == nil then
      return
    end
    data:RefreshRedAnni24Main()
    data:RefreshRedAnni24InifinityRankReward()
    data:RefreshRedAnni24InifinityLayerReward()
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityRunningTimeout(activityFrameData:GetActivityFrameId())
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl then
      local winLbMain = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
      if winLbMain then
        UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.SectorActivityRunEnd, activityFrameData.actId)
  end
}
return ActivityFrameRunningEndFunc
