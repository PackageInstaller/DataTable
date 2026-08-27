local GuideConditionChecker = {}
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local GuideEnum = require("Game.Guide.GuideEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local guideCheckFunc = {
  [eGuideCondition.None] = function()
    return true
  end,
  [eGuideCondition.InHome] = function(condition_arg)
    local homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
    if homeController.homeState ~= HomeEnum.eHomeState.Normal then
      return false
    end
    if #condition_arg == 1 then
      local arg1 = condition_arg[1]
      local hasHasUncompletedEp, stageId, moduleId = ExplorationManager:HasUncompletedEp()
      if arg1 == 1 then
        if not hasHasUncompletedEp then
          return false
        end
      elseif arg1 == 2 and hasHasUncompletedEp then
        return false
      end
    end
    return true
  end,
  [eGuideCondition.InExploration] = function()
    return ExplorationManager:IsInExplorationAndScene()
  end,
  [eGuideCondition.InEpRoomOutside] = function(condition_arg)
    local inExplorationScene = ExplorationManager:IsInExplorationAndScene() and ExplorationManager.epCtrl.sceneCtrl:InBattleScene() == false
    if not inExplorationScene then
      return false
    end
    if ExplorationManager.epCtrl.autoCtrl ~= nil and ExplorationManager.epCtrl.autoCtrl:IsAutoModeRunning() then
      return false
    end
    local explorationWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
    if explorationWindow ~= nil and explorationWindow.monsterLevelNode:IsMonsterLevelPreviewOpen() then
      return false
    end
    if #condition_arg == 0 then
      return true
    end
    if 0 < condition_arg[1] and condition_arg[1] ~= ExplorationManager:GetCurExplorationId() then
      return false
    end
    if condition_arg[2] ~= nil and condition_arg[2] == 1 and (explorationWindow == nil or not explorationWindow:IsShowAutoEpBtn()) then
      return false
    end
    return true
  end,
  [eGuideCondition.InBattleDeploy] = function()
    return ExplorationManager:IsInExplorationAndScene() and ExplorationManager.epCtrl.battleCtrl:IsBattleState(eBattleState.Deploy)
  end,
  [eGuideCondition.InSelectChip] = function()
    return UIManager:GetWindow(UIWindowTypeID.SelectChip) ~= nil
  end,
  [eGuideCondition.InBattleScene] = function()
    return ExplorationManager:IsInExplorationAndScene() and ExplorationManager.epCtrl.sceneCtrl:InBattleScene()
  end,
  [eGuideCondition.InEpTreasureRoom] = function()
    return UIManager:GetWindow(UIWindowTypeID.EpTreasureRoom) ~= nil
  end,
  [eGuideCondition.InEpEventRoom] = function()
    return UIManager:GetWindow(UIWindowTypeID.EpEventRoom) ~= nil
  end,
  [eGuideCondition.InSectorLevel] = function(condition_arg)
    local sectorLevelWindow = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
    if sectorLevelWindow == nil or sectorLevelWindow.active == false then
      return false
    end
    if #condition_arg == 1 then
      local arg = condition_arg[1]
      if arg == 1 then
        if ExplorationManager:HasUncompletedEp() then
          return false
        end
        if PlayerDataCenter.sectorStage.lastSatgeData ~= nil and not PlayerDataCenter.sectorStage.lastSatgeData.isWin then
          return false
        end
      end
    else
    end
    return ControllerManager:GetController(ControllerTypeId.Avg) == nil
  end,
  [eGuideCondition.InOassisBuildingDetail] = function()
    local oasisWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if oasisWindow == nil then
      return false
    end
    local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
    return oasisCtrl:IsOasisNormalState()
  end,
  [eGuideCondition.InFormation] = function(condition_arg)
    if not UIManager:IsMainCameraEnable() then
      return false
    end
    if UIManager:GetWindow(UIWindowTypeID.SelectSupportList) ~= nil then
      return false
    end
    local formationWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if formationWindow == nil then
      return false
    end
    local formationCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
    if formationCtrl == nil then
      return false
    end
    if #condition_arg == 0 then
      return true
    end
    local entFmtData = formationCtrl:GetCurEnterFmtData()
    local fromModule = entFmtData:GetFmtCtrlFromModule()
    local moduleArg = entFmtData:GetFmtCtrlFmtIdStageId()
    if condition_arg[1] ~= fromModule then
      return false
    end
    if 1 < #condition_arg and condition_arg[2] ~= moduleArg then
      return false
    end
    return true
  end,
  [eGuideCondition.InSectorSceneNormal] = function(condition_arg)
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    if sectorCtrl == nil or not sectorCtrl:IsSectorNormalState() then
      return false
    end
    if 0 < #condition_arg and condition_arg[1] == 1 then
      local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
      local isNew = dungeonDyncElem.isDailyDungeonNew
      return isNew
    end
    return true
  end,
  [eGuideCondition.InMainScene] = function()
    local sceneName = CS_GSceneManager_Ins.curSceneName
    return sceneName == Consts.SceneName.Main
  end,
  [eGuideCondition.InHeroStateUI] = function()
    local heroState = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if heroState == nil or not heroState.active then
      return false
    end
    if CS.BattleManager.Instance.IsInBattle then
      return false
    end
    return true
  end,
  [eGuideCondition.InNewMonsterDetail] = function()
    local inBattleDeploy = ExplorationManager:IsInExplorationAndScene() and ExplorationManager.epCtrl.battleCtrl:IsBattleState(eBattleState.Deploy)
    if not inBattleDeploy then
      return false
    end
    return ExplorationManager.epCtrl.battleCtrl.hasNewEnemyDetail == true
  end,
  [eGuideCondition.InEpBattleResult] = function()
    return UIManager:GetWindow(UIWindowTypeID.BattleResult) ~= nil
  end,
  [eGuideCondition.InLottery] = function()
    local lotteryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery)
    return lotteryCtrl ~= nil and lotteryCtrl:IsLotteryNormalState()
  end,
  [eGuideCondition.InATHRefactor] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.AthRefactor)
    return window ~= nil and window.active
  end,
  [eGuideCondition.AfterEpCrossRoom] = function()
    if not ExplorationManager:IsInExplorationAndScene() then
      return false
    end
    if ExplorationManager:GetIsInWeeklyChallenge() then
      return false
    end
    local roomData = ExplorationManager.epCtrl:GetCurrentRoomData()
    return roomData ~= nil and roomData:IsCrossRoom()
  end,
  [eGuideCondition.InEpRewardBagSettle] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.EpRewardBag)
    return window ~= nil and window.active
  end,
  [eGuideCondition.InHeroPotential] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.HeroPotential)
    return window ~= nil
  end,
  [eGuideCondition.InEpResultFail] = function()
    local resultWindow = UIManager:GetWindow(UIWindowTypeID.ExplorationResult)
    if resultWindow == nil then
      return false
    end
    return resultWindow:IsEpResultType(resultWindow.EpResultType.Fail)
  end,
  [eGuideCondition.InEpStoreRoom] = function()
    local epStoreWindow = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
    return epStoreWindow ~= nil
  end,
  [eGuideCondition.InFormationSpecial] = function(condition_arg)
    if not UIManager:IsMainCameraEnable() then
      return false
    end
    if UIManager:GetWindow(UIWindowTypeID.SelectSupportList) ~= nil then
      return false
    end
    local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
    if fmtWindow == nil then
      return false
    end
    if 0 < #condition_arg and condition_arg[1] == 1 then
      local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
      if fmtCtrl == nil then
        return false
      end
      local ui3dFmt = fmtCtrl.fmtSceneCtrl:Get3DUIFormation()
      if ui3dFmt == nil then
        return false
      end
      local platformDic = ui3dFmt:GetPlotformItemDic()
      for index, platItem in pairs(platformDic) do
        if platItem:IsAbleQuickLevelup() then
          return true
        end
      end
      return false
    end
    for k, heroInfoItem in pairs(fmtWindow.heroInfoDic) do
      if heroInfoItem:FmtHeroAblePotential() then
        return true
      end
    end
    return false
  end,
  [eGuideCondition.InLotteryFragChanged] = function()
    local lotteryResultWindow = UIManager:GetWindow(UIWindowTypeID.LotteryResult)
    if lotteryResultWindow == nil then
      return false
    end
    return lotteryResultWindow:IsLotteryFragChanged()
  end,
  [eGuideCondition.ActSectorIIMain] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.ActivityWinterMainMap)
    if window == nil then
      return false
    end
    return true
  end,
  [eGuideCondition.ActWhiteDayMain] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.WhiteDay)
    if window == nil then
      return false
    end
    return true
  end,
  [eGuideCondition.ActAprilFool] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.AprilFool)
    if window == nil then
      return false
    end
    return true
  end,
  [eGuideCondition.ActSum22Strategy] = function()
    local window = UIManager:GetWindow(UIWindowTypeID.ActSum22StrategyMain)
    if window == nil or not window.active then
      return false
    end
    return true
  end,
  [eGuideCondition.WCLevelFirstStart] = function(condition_arg)
    if not WarChessManager:GetIsInWarChess() then
      return false
    end
    local levelId = WarChessManager:GetWCLevelId()
    if 0 < #condition_arg then
      for _, id in pairs(condition_arg) do
        if id == levelId then
          return true
        end
      end
    end
    return false
  end,
  [eGuideCondition.WCLevelEnterDeploy] = function(condition_arg)
    if not WarChessManager:GetIsInWarChess() then
      return false
    end
    if #condition_arg == 0 or condition_arg[1] == 0 then
      return true
    end
    local levelId = WarChessManager:GetWCLevelId()
    if 0 < #condition_arg then
      for _, id in pairs(condition_arg) do
        if id == levelId then
          return true
        end
      end
    end
    return false
  end,
  [eGuideCondition.InActLobby] = function(condition_arg)
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl ~= nil then
      return true
    end
    return false
  end,
  [eGuideCondition.InWeeklyChallenge] = function(condition_arg)
    local window = UIManager:GetWindow(UIWindowTypeID.DailyChallenge)
    if window == nil then
      return false
    end
    if 0 < #condition_arg and condition_arg[1] == 1 then
      return window:IsRealDailyNodeActive()
    end
    return true
  end,
  [eGuideCondition.CommonActMain] = function(condition_arg, extendArg)
    if 0 < #condition_arg then
      local actFrameId = condition_arg[1]
      if extendArg == nil then
        return false
      end
      local targetActFrameId = extendArg[1]
      return actFrameId == targetActFrameId
    end
    return true
  end,
  [eGuideCondition.InMilestone] = function(condition_arg, extendArg)
    local isIncludeOther = false
    if 0 < #condition_arg then
      isIncludeOther = condition_arg[1] ~= 0
    end
    local window = UIManager:GetWindow(UIWindowTypeID.MailStoneMian)
    if not isIncludeOther and window ~= nil then
      return window:GetIsSelfMileStone()
    end
    return window ~= nil
  end,
  [eGuideCondition.FInHome] = function()
    local home = UIManager:GetWindow(UIWindowTypeID.Home)
    return home ~= nil
  end,
  [eGuideCondition.FInSectorScene] = function()
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
    return sectorCtrl ~= nil
  end,
  [eGuideCondition.FInSectorLevel] = function()
    return UIManager:GetWindow(UIWindowTypeID.SectorLevel) ~= nil
  end
}

function GuideConditionChecker.CheckGuideCondition(condition_type, condition_arg, extendArg)
  local checkFunc = guideCheckFunc[condition_type]
  if checkFunc ~= nil then
    return checkFunc(condition_arg, extendArg)
  else
    return false
  end
end

local guideTriggerCheckFunc = {
  [GuideEnum.TriggerGuideCondition.FuncUnlock] = function(condition_arg)
    return FunctionUnlockMgr:ValidateUnlock(condition_arg)
  end,
  [GuideEnum.TriggerGuideCondition.HasItem] = function(condition_arg)
    local result = PlayerDataCenter:GetItemCount(condition_arg[1]) >= condition_arg[2]
    return result
  end,
  [GuideEnum.TriggerGuideCondition.SectorStage] = function(condition_arg)
    return PlayerDataCenter.sectorStage:IsStageComplete(condition_arg)
  end,
  [GuideEnum.TriggerGuideCondition.HeroLevelGreater] = function(condition_arg)
    local heroData = PlayerDataCenter.heroDic[condition_arg[1]]
    if heroData == nil then
      return false
    end
    return heroData.level >= condition_arg[2]
  end,
  [GuideEnum.TriggerGuideCondition.InExploration] = function(condition_arg)
    if not ExplorationManager:IsInExplorationAndScene() then
      return false
    end
    local dungeonId = condition_arg[1]
    return ExplorationManager:GetEpDungeonId() == dungeonId
  end,
  [GuideEnum.TriggerGuideCondition.BattleBenchHasRole] = function(condition_arg)
    if not ExplorationManager:IsInExplorationAndScene() then
      return false
    end
    local battleMgr = CS.BattleManager.Instance
    if not battleMgr.IsInBattle then
      return
    end
    return battleMgr.CurBattleController.battleFieldData:IsHasBenchRole()
  end,
  [GuideEnum.TriggerGuideCondition.ActivityExist] = function(condition_arg)
    local activityFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    local actCatId = 0
    if condition_arg ~= nil then
      actCatId = condition_arg[1] or 0
    end
    local actFrame = activityFrameCtr:GetActivityFrameData(actCatId)
    if actFrame ~= nil and actFrame:IsActivityOpen() then
      return true
    end
    return false
  end,
  [GuideEnum.TriggerGuideCondition.AnyAthCanSign] = function(condition_arg)
    for k, athData in pairs(PlayerDataCenter.allAthData.athDic) do
      if athData:CanSignAth() then
        return true
      end
    end
    return false
  end
}

function GuideConditionChecker.CheckTriggerGuideCondition(condition_type, condition_arg)
  for index, ctype in pairs(condition_type) do
    if not guideTriggerCheckFunc[ctype](condition_arg[index]) then
      return false
    end
  end
  return true
end

return GuideConditionChecker
