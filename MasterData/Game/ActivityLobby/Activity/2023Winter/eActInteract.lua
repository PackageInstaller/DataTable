local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityWinter23Enum = require("Game.ActivityWinter23.Data.ActivityWinter23Enum")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local cs_MessageCommon = CS.MessageCommon

function eActInteract.__GetActData()
  local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
  if not winter23Ctrl then
    return
  end
  return winter23Ctrl:GetWinter23Data()
end

eActInteract.eMissonBtn = {Task = 1}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local winter23Data = eActInteract.__GetActData()
    local dailyTaskData = winter23Data:GetWinter23DailyTaskData()
    local termTaskData = winter23Data:GetWinter23TermTaskData()
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
      win:InitWinter23Task(winter23Data:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local winter23Data = eActInteract.__GetActData()
    local reddot = winter23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityWinter23Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivityWinter23Enum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end
}

local function EnterMapEp(isRepeat)
  local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actWinter23)
  if win23Ctrl then
    local winter23Data = win23Ctrl:GetWinter23Data()
    if winter23Data == nil then
      error("winter23 act data not exist")
      return
    end
    if not winter23Data:IsActivityRunning() then
      return
    end
    win23Ctrl:SetActWin23TipMode(isRepeat)
    local mainCfg = winter23Data:GetWinter23Cfg()
    local sectorId = mainCfg.normal_sector
    local flag, defaultSectorId = winter23Data:GetLastWinter23MainSector()
    if flag then
      sectorId = defaultSectorId
    end
    local unCompleteCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.EpMixWarchess)
    if unCompleteCfg then
      if sectorId ~= mainCfg.normal_sector and unCompleteCfg.sector == mainCfg.normal_sector then
        error("记录的扇区与正在进行游戏的扇区不是同一个")
        sectorId = mainCfg.normal_sector
      elseif sectorId ~= mainCfg.hard_stage and unCompleteCfg.sector == mainCfg.hard_stage then
        error("记录的扇区与正在进行游戏的扇区不是同一个")
        sectorId = mainCfg.hard_stage
      end
      if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
        return
      end
      if sectorLevelChapterCtrl:IsNotRepeatStage(unCompleteCfg.id) and isRepeat then
        local actName, mainName = win23Ctrl:GetActWin23NameAndMainMode()
        local _, repeatName = win23Ctrl:GetActWin23NameAndRepeatMode()
        local msg = LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7136, actName, mainName, tostring(unCompleteCfg.num), actName, repeatName))
        cs_MessageCommon.ShowMessageBox(msg)
        return
      end
    end
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    if SectorStageDetailHelper.IsSectorHasUnComplete(sectorId) then
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      sectorLevelChapterCtrl:SetChapterBaseInfo(sectorId, isRepeat, realReturnFunc, true)
      SectorStageDetailHelper.ContinueUncompleteStage(SectorStageDetailHelper.PlayMoudleType.EpMixWarchess)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    local chapterId = sectorLevelChapterCtrl:GetNowChapterId()
    win23Ctrl:EnterWinter23MainEp(sectorId, isRepeat, realReturnFunc, chapterId)
  end
end

eActInteract.eLbIntrctActionId = {
  Main = 1,
  Shop = 2,
  Tech = 3,
  Repeat = 4,
  MiniGame = 6,
  WarChessSeason = 7,
  ChessGreenHand = 8
}
eActInteract.eLbIntrctEntityId = {
  Main = 1,
  Shop = 2,
  Tech = 3,
  Repeat = 4,
  MiniGame = 6,
  WarChessSeason = 7,
  ChessGreenHand = 8,
  sol = 9,
  deadSol = 13
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    EnterMapEp(false)
  end,
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local winter23Data = eActInteract.__GetActData()
    local mainCfg = winter23Data:GetWinter23Cfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winrwe23Shop, function(window)
      if window == nil then
        return
      end
      window:BindRedShopFunc(function(shopId)
        return not winter23Data:IsWinter23ShopLooked(shopId)
      end)
      window:BindSelectShopFunc(function(shopId)
        winter23Data:SetWinter23ShopLooked(shopId)
      end)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitSum22ShopByShopList(winter23Data, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Tech] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local winter23Data = eActInteract.__GetActData()
    local mainCfg = winter23Data:GetWinter23Cfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winter23StrategyOverview, function(window)
      if window == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitChristmas22StrategyOverview(winter23Data:GetWinter23TechTree(), mainCfg.tech_special_branch, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function()
    EnterMapEp(true)
  end,
  [5] = function()
  end,
  [eActInteract.eLbIntrctActionId.MiniGame] = function()
    local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    local winter23Data
    if win23Ctrl then
      winter23Data = win23Ctrl:GetWinter23Data()
      if winter23Data == nil then
        error("winter23 act data not exist")
        return
      end
    end
    if not winter23Data:IsActivityRunning() then
      return
    end
    local activityFwId = winter23Data:GetActFrameId()
    local miniGameConfigId = winter23Data:GetMiniGameId()
    local joinRewards = winter23Data:GetMiniGameIsGottenJoinRewards()
    local maxScore = winter23Data:GetMiniGameMaxScore()
    local setMaxScore = BindCallback(winter23Data, winter23Data.SetMiniGameMineMaxScore)
    local setJoinRewards = BindCallback(winter23Data, winter23Data.SetMiniGameIsGottenJoinRewards)
    local endtime = winter23Data:GetActivityEndTime()
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    ActLbUtil.OnActLbInteractEnter(true)
    local smashingPenguinsController = ControllerManager:GetController(ControllerTypeId.SmashingPenguins, true)
    smashingPenguinsController:InjectModifyMsgAction(setMaxScore, setJoinRewards)
    smashingPenguinsController:SetSmashingPenguinsActEndTime(endtime)
    smashingPenguinsController:ShowSmashingPenguinUIMain(activityFwId, miniGameConfigId, joinRewards, maxScore, realReturnFunc)
  end,
  [eActInteract.eLbIntrctActionId.WarChessSeason] = function()
    local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    if win23Ctrl then
      local winter23Data = win23Ctrl:GetWinter23Data()
      if winter23Data == nil then
        error("winter23 act data not exist")
        return
      end
      local curSeasonId = winter23Data:GetWinter23WarchessSeasonId()
      local unComplete, seasonId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.WarchessSeason)
      if unComplete then
        if seasonId == curSeasonId then
          win23Ctrl:ContinuehallowmasSeason()
          return
        end
        SectorStageDetailHelper.IsWarchessSeasonNoCollide(curSeasonId, true, true)
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win23Ctrl:EnterWinter23WarChessSeasonLevelSelect(function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end
  end,
  [eActInteract.eLbIntrctActionId.ChessGreenHand] = function()
    local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
    if win23Ctrl then
      local winter23Data = win23Ctrl:GetWinter23Data()
      if winter23Data == nil then
        error("winter23 act data not exist")
        return
      end
      local warChessGreenHandSectorId = winter23Data:GetWarChessGreenHandSectorId()
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
      win23Ctrl:EnterGreenHandWarChessSeasonLevels(warChessGreenHandSectorId, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end
  end
}
eActInteract.eActIntrctActionUIInitFunc = {}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Tech] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    return winter23Data ~= nil and winter23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    return winter23Data ~= nil and winter23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Repeat] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    return winter23Data ~= nil and winter23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.MiniGame] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    return winter23Data ~= nil and winter23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.WarChessSeason] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    return winter23Data ~= nil and winter23Data:IsActivityRunning()
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {
  [eActInteract.eLbIntrctEntityId.Tech] = function(entity)
    local winter23Data = eActInteract.__GetActData()
    local playEndTime = winter23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctEntityId.Main] = function(entity)
    local winter23Data = eActInteract.__GetActData()
    local playEndTime = winter23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctEntityId.Repeat] = function(entity)
    local winter23Data = eActInteract.__GetActData()
    local playEndTime = winter23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctEntityId.MiniGame] = function(entity)
    local winter23Data = eActInteract.__GetActData()
    local playEndTime = winter23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctEntityId.WarChessSeason] = function(entity)
    local winter23Data = eActInteract.__GetActData()
    local playEndTime = winter23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctEntityId.Shop] = function(entity)
    local winter23Data = eActInteract.__GetActData()
    local reddot = winter23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.Shop)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctEntityId.Tech] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    local reddot = winter23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.Tech)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local winter23Data = eActInteract.__GetActData()
    local reddot = winter23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityWinter23Enum.reddotType.main)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end
}

function eActInteract.UpdateActivityReddotChange()
  ActLbUtil.UpdLbEntranceBlueDot(eActInteract.eLbIntrctEntityId, eActInteract.eActIntrctActionShowBlueDotFunc)
  for k, v in pairs(eActInteract.eActIntrctActionShowBlueDotFunc) do
    ActLbUtil.UpdLbEnttBluedot(k)
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
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    local actFrameId = ActLbUtil.GetCurActLbActId()
    if actFrameId then
      win:InitJumpFuncByActivityFrameId(actFrameId)
    end
    win:RefreshMissonReddot()
  end)
  local winter23Data = eActInteract.__GetActData()
  local reddot = winter23Data:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  local isSolDead = winter23Data:GetIsExterUnlock()
  local sol = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.sol)
  if sol ~= nil then
    sol:SetLbEnityGameObjectActive(not isSolDead)
  end
  local deadSol = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.deadSol)
  if deadSol ~= nil then
    deadSol:SetLbEnityGameObjectActive(isSolDead)
  end
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
  if not winter23Ctrl then
    return
  end
  winter23Ctrl:RunEnterCompleteFunc()
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
  end
end

function eActInteract.OnActCamChangeFunc()
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local winter23Data = eActInteract.__GetActData()
  if winter23Data ~= nil then
    local reddot = winter23Data:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
