local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local ActivitySeasonEnum = require("Game.ActivitySeason.ActivitySeasonEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_MessageCommon = CS.MessageCommon

function eActInteract.__GetActData()
  local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
  if not seasonCtrl then
    return
  end
  return seasonCtrl:GetSeasonData()
end

eActInteract.eMissonBtn = {Task = 1}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local seasonData = eActInteract.__GetActData()
    local dailyTaskData = seasonData:GetSeasonDailyTaskData()
    local termTaskData = seasonData:GetSeasonTermTaskData()
    if dailyTaskData == nil then
      if isGameDev then
        warn(" daily task not open ")
      end
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.Winter23Task, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitWinter23Task(seasonData:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local seasonData = eActInteract.__GetActData()
    local reddot = seasonData:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivitySeasonEnum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivitySeasonEnum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end
}
eActInteract.eLbIntrctActionId = {
  Main = 1,
  Bonus = 2,
  Tech = 3,
  Repeat = 4,
  ChessGreenHand = 6,
  MainStory = 7
}
eActInteract.eLbIntrctEntityId = {
  Main = 1,
  Bonus = 2,
  Tech = 3,
  Repeat = 7,
  ChessGreenHand = 6,
  MainStory = 4
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if not seasonCtrl then
      return
    end
    local seasonData = eActInteract.__GetActData()
    local wcsId = seasonData:GetSeasonId()
    local unComplete, seasonId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.WarchessSeason)
    if unComplete then
      if seasonId == wcsId then
        seasonCtrl:ContinueSeason()
        return
      end
      SectorStageDetailHelper.IsWarchessSeasonNoCollide(wcsId, true, true)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    seasonCtrl:EnterCommonSeasonWarChessSeasonLevelSelect(function()
      ActLbUtil.OnActLbInteractEnter(false)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Bonus] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local seasonController = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if seasonController == nil then
      return
    end
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    ActLbUtil.OnActLbInteractEnter(true)
    seasonController:ShowSeasonBonus(realReturnFunc)
  end,
  [eActInteract.eLbIntrctActionId.Tech] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local seasonData = eActInteract.__GetActData()
    local mainCfg = seasonData:GetSeasonMainCfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winter23StrategyOverview, function(window)
      if window == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitChristmas22StrategyOverview(seasonData:GetSeasonTechTree(), mainCfg.tech_special_branch, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function()
    local seasonData = eActInteract.__GetActData()
    local actDungeonCollect = seasonData:GetSeasonDungeonCollect()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonActivityRepeatDungeon, function(win)
      if win == nil then
        if isGameDev then
          warn(" CommonActivityRepeatDungeon not open ")
        end
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitActivityRepeatDungeon(actDungeonCollect, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
      local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
      if aftertTeatmentCtrl ~= nil then
        aftertTeatmentCtrl:TeatmentBengin()
      end
    end)
  end,
  [5] = function()
  end,
  [eActInteract.eLbIntrctActionId.ChessGreenHand] = function()
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if not seasonCtrl then
      return
    end
    local seasonData = eActInteract.__GetActData()
    local warChessGreenHandSectorId = seasonData:GetGreenHandSectorId()
    if not SectorStageDetailHelper.IsSectorNoCollide(warChessGreenHandSectorId, true) then
      return
    end
    local isUnComplete = WarChessSeasonManager:GetUncompleteWCSData()
    if isUnComplete then
      local tips = ConfigData:GetTipContent(8704)
      CS.MessageCommon.ShowMessageTips(tips)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    seasonCtrl:EnterGreenHandWarChessSeasonLevels(warChessGreenHandSectorId, function()
      ActLbUtil.OnActLbInteractEnter(false)
    end)
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function()
    local seasonData = eActInteract.__GetActData()
    local mainCfg = seasonData:GetSeasonMainCfg()
    local storySector = mainCfg.story_stage
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    if not SectorStageDetailHelper.IsSectorNoCollide(storySector, true) then
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
      if window == nil then
        return
      end
      window:InitSectorLevel(storySector, realReturnFunc, 1)
    end)
  end
}
eActInteract.eActIntrctActionUIInitFunc = {}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    return seasonData ~= nil and seasonData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Tech] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    return seasonData ~= nil and seasonData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Bonus] = function(lbIntrctData)
    return true
  end,
  [eActInteract.eLbIntrctEntityId.Repeat] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    return seasonData ~= nil and seasonData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.MainStory] = function(lbIntrctData)
    return true
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    local playEndTime = seasonData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.Tech] = function(entity)
    local seasonData = eActInteract.__GetActData()
    local playEndTime = seasonData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.Bonus] = function(entity)
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function(entity)
    local seasonData = eActInteract.__GetActData()
    local playEndTime = seasonData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entity)
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.Tech] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    local reddot = seasonData:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.Tech)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Bonus] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    local reddot = seasonData:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.Bonus)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Main] = function(lbIntrctData)
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(lbIntrctData)
    local seasonData = eActInteract.__GetActData()
    local reddot = seasonData:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivitySeasonEnum.reddotType.mainStory)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end
}

function eActInteract.UpdateActivityReddotChange()
  ActLbUtil.UpdLbEntranceBlueDot(eActInteract.eLbIntrctEntityId, eActInteract.eActIntrctActionShowBlueDotFunc)
  for k, v in pairs(eActInteract.eLbIntrctEntityId) do
    ActLbUtil.UpdLbEnttBluedot(v)
  end
  local missonUI = UIManager:GetWindow(UIWindowTypeID.Spring23Misson)
  if missonUI ~= nil then
    missonUI:RefreshMissonReddot()
  end
end

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    local actFrameId = ActLbUtil.GetCurActLbActId()
    if actFrameId then
      win:InitJumpFuncByActivityFrameId(actFrameId)
    end
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    win:RefreshMissonReddot()
  end)
  local seasonData = eActInteract.__GetActData()
  local reddot = seasonData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
  if not seasonCtrl then
    return
  end
  seasonCtrl:RunEnterCompleteFunc()
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    local seasonData = eActInteract.__GetActData()
    local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
    if not seasonCtrl then
      return
    end
    seasonCtrl:TryOpenUnlockWin(seasonData)
  end
end

function eActInteract.OnActCamChangeFunc()
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.WCSModeSelect) then
    UIManager:HideWindow(UIWindowTypeID.MessageCommon)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.WCSModeSelect, true)
  end
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.Winter23StrategyOverview) then
    UIManager:HideWindow(UIWindowTypeID.MessageCommon)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.Winter23StrategyOverview, true)
  end
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.CommonActivityRepeatDungeon) then
    UIManager:HideWindow(UIWindowTypeID.MessageCommon)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.CommonActivityRepeatDungeon, true)
  end
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local seasonData = eActInteract.__GetActData()
  if seasonData ~= nil then
    local reddot = seasonData:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
