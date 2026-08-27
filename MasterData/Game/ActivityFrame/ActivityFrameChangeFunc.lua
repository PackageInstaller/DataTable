local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

local function ActivityTaskChangeFunc(activityFrameData, eTaskType, taskList)
  local isOpen = activityFrameData:IsActivityOpen()
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task, true)
  if isOpen then
    taskCtrl:AddTimeLimitTask(eTaskType, taskList, activityFrameData:GetActivityRewardEndTime())
    return
  end
  for _, taskId in pairs(taskList) do
    local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
    if taskData ~= nil then
      PlayerDataCenter.allTaskData:RemoveTaskData(taskData)
    end
  end
  taskCtrl:ReomveTimeLimitTask(eTaskType, taskList)
  local ok, TaskWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task)
  if ok then
    local taskPageNode = TaskWindowNode:RemoveChild(eTaskType)
  end
  local win = UIManager:GetWindow(UIWindowTypeID.Task)
  if win ~= nil then
    win:RefreshPages()
  end
  local navigationWin = UIManager:GetWindow(UIWindowTypeID.NavigationBar)
  if navigationWin ~= nil then
    navigationWin:UpdateNaviTaskQucikPreview()
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil then
    window.homeLeftNode:RefreshTaskBtn()
  end
end

local ActivityFrameChangeFunc = {
  [ActivityFrameEnum.eActivityType.Lotter] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      PlayerDataCenter.allLtrData:OpenLtrPoolData(activityFrameData)
      if PlayerDataCenter.isSyncUserDataEnd then
        NetworkManager:GetNetwork(NetworkTypeID.Lottery):CS_LOTTERY_Detail()
      end
      return
    end
    PlayerDataCenter.allLtrData:CloseLtrPoolData(activityFrameData)
  end,
  [ActivityFrameEnum.eActivityType.Tickets] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.EventWeChat) ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.DungeonDouble] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    local doubleActivityCfg = ConfigData.activity_double[actId]
    if doubleActivityCfg == nil then
      error("can't find doubleActivityCfg with actId:" .. tostring(actId))
      return
    end
    for index, logic in ipairs(doubleActivityCfg.logic) do
      if isOpen then
        local para1 = doubleActivityCfg.para1[index]
        local para2 = doubleActivityCfg.para2[index]
        local para3 = doubleActivityCfg.para3[index]
        PlayerDataCenter.playerBonus:InstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active, actId, logic, para1, para2, para3)
      else
        PlayerDataCenter.playerBonus:UninstallPlayerBonus(proto_csmsg_SystemFunctionID.SystemFunctionID_Double_Active, actId, logic)
        break
      end
    end
    MsgCenter:Broadcast(eMsgEventId.OnBattleDungeonLimitChange)
  end,
  [ActivityFrameEnum.eActivityType.SectorI] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    local network = NetworkManager:GetNetwork(NetworkTypeID.ActivitySectorI)
    local taskList = ConfigData.activity_time_limit[actId].task_list
    ActivityTaskChangeFunc(activityFrameData, TaskEnum.eTaskType.LargeActivityTask, taskList)
    if isOpen then
      network:CS_ACTIVITYSECTORI_Detail(function()
        MsgCenter:Broadcast(eMsgEventId.SectorActivityChange)
        local HomeEnum = require("Game.Home.HomeEnum")
        local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity)
        local HomeController = ControllerManager:GetController(ControllerTypeId.HomeController)
        if isUnlock and HomeController ~= nil and HomeController.homeState == HomeEnum.eHomeState.Normal then
          HomeController:AddAutoShowGuide(HomeEnum.eAutoShwoCommand.SectorActivity)
        end
      end)
      return
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.ActSummer) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActSummer, true)
    end
    local actCfg = ConfigData.activity_time_limit[actId]
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sectorCtrl ~= nil then
      local sctSceneUI = sectorCtrl.mainSctCtrl.GetMainSctSceneUI()
      if sctSceneUI then
        sctSceneUI.sctChaptNode:ShowSctChaptItemBySectorId(actCfg.hard_stage)
      end
    end
    TimerManager:StartTimer(1, function()
      network:CS_ACTIVITYSECTORI_Detail(function()
        if ExplorationManager:IsInExploration() then
          local stageCfg = ExplorationManager:GetSectorStageCfg()
          if stageCfg ~= nil then
            local sectorIActId = ConfigData.activity_time_limit.sectorMapping[stageCfg.sector]
            if sectorIActId == actId and actCfg.hard_stage ~= stageCfg.sector then
              ExplorationManager:ForceExitEp()
            end
          end
        else
          local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
          local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
          if stageCfg ~= nil then
            local sectorIActId = ConfigData.activity_time_limit.sectorMapping[stageCfg.sector]
            if sectorIActId == actId and actCfg.hard_stage ~= stageCfg.sector then
              local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
              explorationNetwork:CS_EXPLORATION_Detail()
            end
          end
        end
        MsgCenter:Broadcast(eMsgEventId.SectorActivityChange)
      end)
    end, nil, true)
  end,
  [ActivityFrameEnum.eActivityType.HeroGrow] = function(activityFrameData)
    local activityHeroCfg = ConfigData.activity_hero[activityFrameData.actId]
    if activityHeroCfg == nil then
      error("HeroGrowCfg Miss  id is " .. tostring(activityFrameData.actId))
    else
      local taskList = ConfigData.activity_hero[activityFrameData.actId].task_list
      if 0 < #taskList then
        ActivityTaskChangeFunc(activityFrameData, TaskEnum.eTaskType.HeroActivityTask, taskList)
      end
    end
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CharacterDungeon) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.CharacterDungeon, true)
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CharDunVer2) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.CharDunVer2, true)
    end
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
    if heroGrowCtrl == nil then
      return
    end
    if ExplorationManager:IsInExploration() then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      if stageCfg ~= nil then
        local actId, isChallenge, canFight = heroGrowCtrl:IsHeroGrowChallengeSector(stageCfg.sector)
        if actId ~= nil and not canFight then
          ExplorationManager:ForceExitEp()
        end
      end
    else
      local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        local actId, isChallenge, canFight = heroGrowCtrl:IsHeroGrowChallengeSector(stageCfg.sector)
        if actId ~= nil and not canFight then
          TimerManager:StartTimer(1, function()
            local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
            explorationNetwork:CS_EXPLORATION_Detail()
          end, nil, true)
        end
      end
    end
    if WarChessManager:GetIsInWarChess() then
      local stageCfg = WarChessManager:GetWCSectorStageCfg()
      if stageCfg ~= nil then
        local actId, isChallenge, canFight = heroGrowCtrl:IsHeroGrowChallengeSector(stageCfg.sector)
        if actId ~= nil and not canFight then
          WarChessManager:ForceExitWarchess()
        end
      end
    else
      local hasUnComplete, stageId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Warchess)
      local stageCfg = hasUnComplete and ConfigData.sector_stage[stageId] or nil
      if stageCfg ~= nil then
        local actId, isChallenge, canFight = heroGrowCtrl:IsHeroGrowChallengeSector(stageCfg.sector)
        if actId ~= nil and not canFight then
          TimerManager:StartTimer(1, function()
            WarChessManager:SyncIsHaveUncompletedWarChess()
          end, nil, true)
        end
      end
    end
    heroGrowCtrl:RemoveHeroGrow(activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.SectorII] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    local taskList
    if isOpen then
      local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII, true)
      sectorIICtrl:OnSectorIIActivityOpen(actId)
      local sectorIIdata = sectorIICtrl:GetSectorIIDataByActId(actId)
      taskList = sectorIIdata:GetSectorIIActivityTaskList()
      activityFrameData:SetActivityData(sectorIIdata)
    else
      local SectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
      local sectorIIdata = SectorIICtrl:GetSectorIIDataByActId(actId)
      local AWMainMapWin = UIManager:GetWindow(UIWindowTypeID.ActivityWinterMainMap)
      if AWMainMapWin ~= nil then
        UIUtil.ReturnHome()
      end
      if BattleDungeonManager:InBattleDungeon() then
        local dunInterfaceType = BattleDungeonManager.dunInterfaceData:GetInterfaceType()
        if dunInterfaceType == DungeonLevelEnum.InterfaceType.SectorIIDungeon or dunInterfaceType == DungeonLevelEnum.InterfaceType.WinterChallenge then
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
      taskList = sectorIIdata:GetSectorIIActivityTaskList()
      SectorIICtrl:OnSectorIIActivityClose(actId)
      activityFrameData:SetActivityData(nil)
    end
    ActivityTaskChangeFunc(activityFrameData, TaskEnum.eTaskType.LargeActivityTask, taskList)
  end,
  [ActivityFrameEnum.eActivityType.WhiteDay] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    if isOpen then
      local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay, true)
      whiteDayCtrl:OnWhiteDayActivityOpen(actId)
      local whiteDayData = whiteDayCtrl:GetWhiteDayDataByActId(actId)
      activityFrameData:SetActivityData(whiteDayData)
    else
      local win = UIManager:GetWindow(UIWindowTypeID.WhiteDay)
      if win ~= nil then
        UIUtil.ReturnHome()
      else
        win = UIManager:GetWindow(UIWindowTypeID.WhiteDayAlbum)
        if win ~= nil then
          UIUtil.ReturnHome()
        end
      end
      local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
      if ExplorationManager:IsInExploration() then
        local stageCfg = ExplorationManager:GetSectorStageCfg()
        if stageCfg ~= nil then
          local isWDSector = whiteDayCtrl:IsWDSector(stageCfg.sector)
          if isWDSector then
            PlayerDataCenter.sectorStage:SetSelectSectorId(nil)
            ExplorationManager:ForceExitEp()
          end
        end
      else
        local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
        local stageCfg = hasHasUncompletedEp and ConfigData.sector_stage[stageId] or nil
        if stageCfg ~= nil then
          local isWDSector = whiteDayCtrl:IsWDSector(stageCfg.sector)
          if isWDSector then
            PlayerDataCenter.sectorStage:SetSelectSectorId(nil)
            TimerManager:StartTimer(1, function()
              local explorationNetwork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
              explorationNetwork:CS_EXPLORATION_Detail()
            end, nil, true)
          end
        end
      end
      whiteDayCtrl:OnWhiteDayActivityClose(actId)
    end
  end,
  [ActivityFrameEnum.eActivityType.Comeback] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      return
    end
    local actId = activityFrameData.actId
    local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
    if comebackCtrl == nil then
      return
    end
    comebackCtrl:RemoveComebackActivity(actId)
    if not comebackCtrl:HasActivityComeback() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityComeback)
    end
  end,
  [ActivityFrameEnum.eActivityType.Task] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      return
    end
    local actId = activityFrameData.actId
    local actTaskCtrl = ControllerManager:GetController(ControllerTypeId.ActivityTask)
    if actTaskCtrl == nil then
      return
    end
    actTaskCtrl:RemoveActivityTask(actId)
    if not actTaskCtrl:HasActivityTask() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityTask)
    end
  end,
  [ActivityFrameEnum.eActivityType.Round] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      return
    end
    local actId = activityFrameData.actId
    local actRoundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityRound)
    if actRoundCtrl == nil then
      return
    end
    actRoundCtrl:RemoveActivityRound(actId)
    if not actRoundCtrl:HasActivityRound() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityRound)
    end
  end,
  [ActivityFrameEnum.eActivityType.RefreshDun] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    local taskList
    if isOpen then
      local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon, true)
      refreshDunCtrl:OnRefreshDunActivityOpen(actId)
      local ARDData = refreshDunCtrl:GetRefreshDunDataByActId(actId)
      activityFrameData:SetActivityData(ARDData)
      taskList = ARDData:GetARDDTaskList()
    else
      local win = UIManager:GetWindow(UIWindowTypeID.AprilFool)
      if win ~= nil then
        UIUtil.ReturnHome()
      end
      local refreshDunCtrl = ControllerManager:GetController(ControllerTypeId.ActRefreshDungeon)
      local ARDData = refreshDunCtrl:GetRefreshDunDataByActId(actId)
      taskList = ARDData:GetARDDTaskList()
      refreshDunCtrl:OnRefreshDunActivityClose(actId)
    end
    if taskList ~= nil then
      ActivityTaskChangeFunc(activityFrameData, TaskEnum.eTaskType.LargeActivityTask, taskList)
    end
  end,
  [ActivityFrameEnum.eActivityType.Carnival] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    if isOpen then
      return
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.Carnival22Main) then
      UIManager:HideWindow(UIWindowTypeID.MessageCommon)
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.Carnival22Main, true)
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
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
    if carnivalCtrl == nil then
      return
    end
    carnivalCtrl:RemoveCarnivalAct(actId)
    if not carnivalCtrl:IsHaveCarnivalAct() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityCarnival)
    end
  end,
  [ActivityFrameEnum.eActivityType.HistoryTinyGame] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    if isOpen then
      return
    end
    local historyTinyGameCtrl = ControllerManager:GetController(ControllerTypeId.HistoryTinyGameActivity)
    if historyTinyGameCtrl == nil then
      return
    end
    historyTinyGameCtrl:OnActivityClose(actId)
    local win = UIManager:GetWindow(UIWindowTypeID.ActivityMiniGameMain)
    if win ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.DailyChallenge] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    if isOpen then
      return
    end
    local adcCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDailyChallenge)
    if adcCtrl == nil then
      return
    end
    adcCtrl:RemoveADC(actId)
    if not adcCtrl:HasLiveADC() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityDailyChallenge)
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.EventDaliyChallenge) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.EventDaliyChallenge, true)
    end
  end,
  [ActivityFrameEnum.eActivityType.ActvtLimitTask] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      ControllerManager:GetController(ControllerTypeId.ActivityTaskLimit, true):InitActLimitTaskCtrl(activityFrameData)
      return
    end
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityTaskLimit)
    if ctrl == nil then
      return
    end
    ctrl:CloseActLimitTaskCtrl(activityFrameData)
  end,
  [ActivityFrameEnum.eActivityType.SignInMiniGame] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame, true):InitCtrl(activityFrameData)
      return
    end
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame)
    if ctrl == nil then
      return
    end
    ctrl:CloseActLimitTaskCtrl(activityFrameData)
  end,
  [ActivityFrameEnum.eActivityType.SectorIII] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    local actId = activityFrameData.actId
    if isOpen then
      return
    end
    local sectorIIICtrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
    if sectorIIICtrl == nil then
      return
    end
    sectorIIICtrl:RemoveSectorIIIData(actId)
    if not sectorIIICtrl:IsHaveSectorIIIAct() then
      ControllerManager:DeleteController(ControllerTypeId.ActivitySectorIII)
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.ActSum22Main) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActSum22Main, true)
    end
  end,
  [ActivityFrameEnum.eActivityType.Hallowmas] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local hallowmasCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    if hallowmasCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    hallowmasCtrl:RemoveHallowmas(actId)
    if not hallowmasCtrl:IsHaveHallowmas() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityHallowmas)
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.Halloween22Main) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.Halloween22Main, true)
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.Christmas22Main) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.Christmas22Main, true)
    end
  end,
  [ActivityFrameEnum.eActivityType.KeyExertion] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion, true):InitKeyExertion(activityFrameData)
      return
    end
    local keyExertionCtrl = ControllerManager:GetController(ControllerTypeId.ActivityKeyExertion)
    if keyExertionCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    keyExertionCtrl:RemoveKeyExertion(actId)
    if not keyExertionCtrl:IsHaveKeyExertion() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityKeyExertion)
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.ActivityKeyExertion) then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActivityKeyExertion, true)
    end
  end,
  [ActivityFrameEnum.eActivityType.Spring] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    springCtrl:TryExitSpringBrotatoExploration(actId)
    springCtrl:RemoveSpring(actId)
    if not springCtrl:IsHaveSpring() then
      ControllerManager:DeleteController(ControllerTypeId.ActivitySpring)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.Winter23] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    if winter23Ctrl == nil then
      return
    end
    local actId = activityFrameData.actId
    winter23Ctrl:RemoveWinter23(actId)
    if not winter23Ctrl:IsHaveWinter23() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityWinter23)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.Invitation] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local invitationWin = UIManager:GetWindow(UIWindowTypeID.EventInvitation)
    if invitationWin ~= nil then
      UIUtil.ReturnHome()
    end
    local invitationCtrl = ControllerManager:GetController(ControllerTypeId.ActivityInvitation)
    if invitationCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    invitationCtrl:RemoveInvitation(actId)
    if not invitationCtrl:IsHaveInvitation() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityInvitation)
    end
  end,
  [ActivityFrameEnum.eActivityType.LadderGift] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      local ladderGiftCtrl = ControllerManager:GetController(ControllerTypeId.EventLadderGift, true)
      ladderGiftCtrl:InitLadderGift(activityFrameData)
      return
    end
    local ladderGiftCtrl = ControllerManager:GetController(ControllerTypeId.EventLadderGift)
    if ladderGiftCtrl == nil then
      return
    end
    ControllerManager:DeleteController(ControllerTypeId.EventLadderGift)
    if UIManager:GetWindow(UIWindowTypeID.EventLadderGift) ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.EventAngelaGift] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      local angelaGiftCtrl = ControllerManager:GetController(ControllerTypeId.EventAngelaGift, true)
      angelaGiftCtrl:InitAngelaGift(activityFrameData)
      return
    end
    local angelaGiftCtrl = ControllerManager:GetController(ControllerTypeId.EventAngelaGift)
    if angelaGiftCtrl == nil then
      return
    end
    ControllerManager:DeleteController(ControllerTypeId.EventAngelaGift)
  end,
  [ActivityFrameEnum.eActivityType.Gift] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      if ConfigData.activity_gift == nil then
        local eDynConfigData = require("Game.ConfigData.eDynConfigData")
        ConfigData:LoadDynCfg(eDynConfigData.activity_gift)
      end
      local reddot = activityFrameData:GetActivityReddotNode()
      local reddoutCount = 0
      local cfg = ConfigData.activity_gift[activityFrameData:GetActId()]
      local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
      for i, giftid in ipairs(cfg.giftlist) do
        local gift = payGiftCtrl:GetPayGiftDataById(giftid)
        if gift ~= nil and not gift:IsSoldOut() and gift:IsFreeGift() then
          reddoutCount = 1
          break
        end
      end
      reddot:SetRedDotCount(reddoutCount)
    else
      local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      if not actCtrl:IsExistOpenActByActType() then
        local eDynConfigData = require("Game.ConfigData.eDynConfigData")
        ConfigData:ReleaseDynCfg(eDynConfigData.activity_gift)
      end
      if UIManager:GetWindow(UIWindowTypeID.EventOptionalGift) ~= nil then
        UIUtil.ReturnHome()
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.Season] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if seasonCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    seasonCtrl:RemoveSeason(actId)
    if not seasonCtrl:IsHaveSeason() then
      ControllerManager:DeleteController(ControllerTypeId.ActivitySeason)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.SaveMoney] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local saveMoneyCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney)
    if saveMoneyCtrl == nil then
      return
    end
    saveMoneyCtrl:RemoveSaveMoneyData(activityFrameData.actId)
    if not saveMoneyCtrl:IsHaveSaveMoneyData() then
      ControllerManager:DeleteController(ControllerTypeId.ActivitySaveMoney)
    end
    local saveMoneyWin = UIManager:GetWindow(UIWindowTypeID.SaveMoney)
    if saveMoneyWin ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.ActivityCarnival23] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
    if carnival23Ctrl == nil then
      return
    end
    local actId = activityFrameData.actId
    carnival23Ctrl:RemoveCarnival23(actId)
    if not carnival23Ctrl:IsHaveCarnival23() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityCarnival23)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.LuckyRaffle] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local luckyRaffleCtrl = ControllerManager:GetController(ControllerTypeId.LuckyRaffle)
    if luckyRaffleCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    luckyRaffleCtrl:RemoveLuckyRaffle(actId)
    if not luckyRaffleCtrl:IsHaveLuckyRaffle() then
      ControllerManager:DeleteController(ControllerTypeId.LuckyRaffle)
    end
    if UIManager:GetWindow(UIWindowTypeID.LuckyRaffle) ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.BattlePass] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    PlayerDataCenter.battlepassData:OnBattlePassEnd(activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.EventWeeklyQA] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local weeklyQACtrl = ControllerManager:GetController(ControllerTypeId.EventWeeklyQA)
    if weeklyQACtrl == nil then
      return
    end
    weeklyQACtrl:RemoveWeeklyQAData(activityFrameData.actId)
    if UIManager:GetWindow(UIWindowTypeID.EventWeeklyQA) ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.Divergent] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.ActivityDivergentMain) ~= nil then
      UIUtil.ReturnHome()
    end
  end,
  [ActivityFrameEnum.eActivityType.ExplorationFund] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund)
    if explorationFundCtrl == nil then
      return
    end
    explorationFundCtrl:RemoveExplorationFundData(activityFrameData.actId)
  end,
  [ActivityFrameEnum.eActivityType.ShortTheatre] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      ControllerManager:GetController(ControllerTypeId.ShortTheatre, true):InitCtrl(activityFrameData)
      return
    end
    local ctrl = ControllerManager:GetController(ControllerTypeId.ShortTheatre)
    if ctrl == nil then
      return
    end
    ctrl:CloseActLimitTaskCtrl(activityFrameData)
  end,
  [ActivityFrameEnum.eActivityType.Anniversary23] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return
    end
    local actId = activityFrameData.actId
    anniversary23Ctrl:RemoveAnniversary23(actId)
    if not anniversary23Ctrl:IsHaveAnniversary23() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityAnniversary23)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.FlipCard] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.ActivityFlipCardMain) ~= nil then
      UIUtil.ReturnHome()
    end
    local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
    if flipCardCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    flipCardCtrl:RemoveFlipCard(actId)
    if not flipCardCtrl:IsHaveFlipCard() then
      ControllerManager:DeleteController(ControllerTypeId.FlipCard)
    end
  end,
  [ActivityFrameEnum.eActivityType.SkinLimit] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.ActivitySkinLimitMain) ~= nil then
      UIUtil.ReturnHome()
    end
    local skinLimitCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySkinLimit)
    if skinLimitCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    skinLimitCtrl:RemoveSkinLimit(actId)
    if not skinLimitCtrl:IsHaveSkinLimit() then
      ControllerManager:DeleteController(ControllerTypeId.ActivitySkinLimit)
    end
  end,
  [ActivityFrameEnum.eActivityType.ActBlackHole] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.ActivityBlackHoleMain) ~= nil then
      UIUtil.ReturnHome()
    end
    local actBlackHoleCtrl = ControllerManager:GetController(ControllerTypeId.ActBlackHole)
    if actBlackHoleCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actBlackHoleCtrl:RemoveBlackHole(actId)
    if not actBlackHoleCtrl:IsHaveBlackHole() then
      ControllerManager:DeleteController(ControllerTypeId.ActBlackHole)
    end
  end,
  [ActivityFrameEnum.eActivityType.CardSet] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if ctrl == nil then
      return
    end
    local actId = activityFrameData.actId
    ctrl:OnCardSetActEnd(actId)
  end,
  [ActivityFrameEnum.eActivityType.SteinsGateMiniGame] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.ActivitySteinsGateMiniGameMain) ~= nil then
      UIUtil.ReturnHome()
    end
    local actSGMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActSteinsGateMiniGame)
    if actSGMiniGameCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actSGMiniGameCtrl:RemoveUpdateSteinsGateMiniGame(actId)
    if not actSGMiniGameCtrl:IsHaveSteinsGateMiniGame() then
      ControllerManager:DeleteController(ControllerTypeId.ActSteinsGateMiniGame)
    end
  end,
  [ActivityFrameEnum.eActivityType.SteinsGate] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    if steinsGate23Ctrl == nil then
      return
    end
    local actId = activityFrameData.actId
    steinsGate23Ctrl:RemoveSteinsGate(actId)
    if not steinsGate23Ctrl:IsHaveSteinsGate() then
      ControllerManager:DeleteController(ControllerTypeId.Activity23SteinsGate)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.HazeGift] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.ActivityHazeGiftMain) ~= nil then
      UIUtil.ReturnHome()
    end
    local hazeGiftCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHazeGift)
    if hazeGiftCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    hazeGiftCtrl:RemoveHazeGiftDataByActId(actId)
    if not hazeGiftCtrl:IsHaveHazeGiftActivity() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityHazeGift)
    end
  end,
  [ActivityFrameEnum.eActivityType.DrawLottery] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIManager:GetWindow(UIWindowTypeID.EventDrawLottery) ~= nil then
      UIUtil.ReturnHome()
    end
    local eventDrawCtrl = ControllerManager:GetController(ControllerTypeId.EventDrawLottery)
    if eventDrawCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    eventDrawCtrl:RemoveEventDrawLottery(actId)
    if not eventDrawCtrl:IsHaveEventDrawLottery() then
      ControllerManager:DeleteController(ControllerTypeId.EventDrawLottery)
    end
  end,
  [ActivityFrameEnum.eActivityType.ComebackNewSystem] = function(activityFrameData)
    if activityFrameData:IsActivityOpen() then
      return
    end
    local actId = activityFrameData.actId
    local comebackCtrl = ControllerManager:GetController(ControllerTypeId.ActivityComeback)
    if comebackCtrl == nil then
      return
    end
    comebackCtrl:RemoveComebackNewSystem(actId)
  end,
  [ActivityFrameEnum.eActivityType.Spring24] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
    if actCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actCtrl:RemoveActData(actId)
    if not actCtrl:IsHaveActData() then
      ControllerManager:DeleteController(ControllerTypeId.ActivitySpring24)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.CollectFortune] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCollectFortune)
    if actCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actCtrl:RemoveCollectFortune(actId)
    if not actCtrl:IsHaveCollectFortuneActivity() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityCollectFortune)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.SoundPlayMiniGame] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if not isOpen then
      return
    end
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameInfo = actFrameCtrl:GetActivityFrameData(activityFrameData:GetActivityFrameId())
    if activityFrameInfo ~= nil and not activityFrameInfo:GetIsActivityFinished() and activityFrameInfo:GetActivityData() == nil then
      local actType = activityFrameData:GetActivityFrameCat()
      local actId = activityFrameData:GetActId()
      local ActivityBase = require("Game.ActivityFrame.ActivityBase")
      local activityData = ActivityBase.New()
      activityData:SetActFrameDataByType(ActivityFrameEnum.eActivityType.SoundPlayMiniGame, actId)
      activityFrameInfo:SetActivityData(activityData)
      local miniGameMusicController = ControllerManager:GetController(ControllerTypeId.MiniGameMusic, true)
      
      function activityData.GetActivityReddotNum()
        local tinigameData = miniGameMusicController:GetTinyGameSoundPlayData()
        if tinigameData == nil then
          miniGameMusicController:InitTiniGameActivityData(actType, actId, activityFrameData)
          tinigameData = miniGameMusicController:GetTinyGameSoundPlayData()
        end
        if tinigameData == nil then
          return false, 0
        end
        local count = 0
        if tinigameData:IsSoundPlayTaskComplete() then
          count = count + 1
        end
        if tinigameData:IsSoundPlayAchieveComplete() then
          count = count + 1
        end
        return false, count
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.Carnival24] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    if actCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    local data = actCtrl:GetActDataByActId(actId)
    local actHisData = PlayerDataCenter.actHisSpecialData
    actHisData:AssignmentCarnival24Data(actId, data.fragMentDemandTable)
    actCtrl:RemoveActData(actId)
    if not actCtrl:IsHaveActData() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityCarnival24)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end,
  [ActivityFrameEnum.eActivityType.Bond] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
    if actCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actCtrl:RemoveActData(actId)
    if not actCtrl:IsHaveActData() then
      ControllerManager:DeleteController(ControllerTypeId.ActivityBond)
    end
  end,
  [ActivityFrameEnum.eActivityType.Brotato] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if not isOpen then
      return
    end
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local activityFrameInfo = actFrameCtrl:GetActivityFrameData(activityFrameData:GetActivityFrameId())
    if activityFrameInfo ~= nil and not activityFrameInfo:GetIsActivityFinished() and activityFrameInfo:GetActivityData() == nil then
      local actType = activityFrameData:GetActivityFrameCat()
      local actId = activityFrameData:GetActId()
      local ActivityBase = require("Game.ActivityFrame.ActivityBase")
      local activityData = ActivityBase.New()
      activityData:SetActFrameDataByType(ActivityFrameEnum.eActivityType.Brotato, actId)
      activityFrameInfo:SetActivityData(activityData)
      local brotatoController = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
      local brotatoData = brotatoController:GetBrotatoData(actId)
      if brotatoData == nil then
        brotatoData = brotatoController:CreateBrotatoData(actId)
      end
      if brotatoData ~= nil then
        brotatoData:SetBrotatoRedDot(activityData:GetActivityReddot())
      end
    end
  end,
  [ActivityFrameEnum.eActivityType.DeliverySimulator] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.DeliverySimulatorEntrance) then
      UIUtil.ReturnHome()
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
    if actCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actCtrl:RemoveActData(actId)
    if not actCtrl:IsHaveActData() then
      ControllerManager:DeleteController(ControllerTypeId.ActDeliverySimulator)
    end
  end,
  [ActivityFrameEnum.eActivityType.ActAnniversary24] = function(activityFrameData)
    local isOpen = activityFrameData:IsActivityOpen()
    if isOpen then
      return
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    if actCtrl == nil then
      return
    end
    local actId = activityFrameData.actId
    actCtrl:RemoveActData(actId)
    if not actCtrl:IsHaveActData() then
      ControllerManager:DeleteController(ControllerTypeId.ActAnniversary24)
    end
    local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
    ActLbUtil.ActLbActivityFinish(activityFrameData:GetActivityFrameId())
  end
}
return ActivityFrameChangeFunc
