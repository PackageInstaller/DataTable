local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityCarnival23Enum = require("Game.ActivityCarnival23.Data.ActivityCarnival23Enum")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local cs_MessageCommon = CS.MessageCommon
local CS_GameObject = CS.UnityEngine.GameObject
local JumpManager = require("Game.Jump.JumpManager")

function eActInteract.__GetActData()
  local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
  if not carnival23Ctrl then
    return
  end
  return carnival23Ctrl:GetCarnival23Data()
end

function eActInteract.__GetActEnd()
  local carnival23Data = eActInteract.__GetActData()
  if carnival23Data == nil or not carnival23Data:IsActivityRunning() then
    return true
  end
  return false
end

eActInteract.eMissonBtn = {Task = 1, ActivityBP = 3}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local carnival23Data = eActInteract.__GetActData()
    local dailyTaskData = carnival23Data:GetCarnival23DailyTaskData()
    local termTaskData = carnival23Data:GetCarnival23TermTaskData()
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
      win:InitWinter23Task(carnival23Data:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local carnival23Data = eActInteract.__GetActData()
    local reddot = carnival23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityCarnival23Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivityCarnival23Enum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eMissonBtn.ActivityBP] = function()
    local carnival23Data = eActInteract.__GetActData()
    local reddot = carnival23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityCarnival23Enum.reddotType.ActivityBP)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end
}

local function EnterMapEp(isRepeat)
  local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actSummer24)
  if carnival23Ctrl then
    local carnival23Data = carnival23Ctrl:GetCarnival23Data()
    if carnival23Data == nil then
      error("winter23 act data not exist")
      return
    end
    if not carnival23Data:IsActivityRunning() then
      return
    end
    carnival23Ctrl:SetActCar23TipMode(isRepeat)
    local mainCfg = carnival23Data:GetCarnival23Cfg()
    local sectorId = mainCfg.normal_sector
    local flag, defaultSectorId = carnival23Data:GetLastCarnival23MainSector()
    if flag then
      sectorId = defaultSectorId
    end
    local unCompleteCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
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
        local actName, mainName = carnival23Ctrl:GetActCarnival23NameAndMainMode(eActInteract)
        local _, repeatName = carnival23Ctrl:GetActCarnival23NameAndRepeatMode(eActInteract)
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
      SectorStageDetailHelper.ContinueUncompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    local chapterId = sectorLevelChapterCtrl:GetNowChapterId()
    carnival23Ctrl:EnterCarnival23MainEp(sectorId, isRepeat, realReturnFunc, chapterId, true, eActInteract)
  end
end

eActInteract.eLbIntrctActionId = {
  Main = 1,
  Repeat = 2,
  Guard = 3,
  Shop = 4,
  Board = 5
}
eActInteract.eLbIntrctEntityId = {
  Main = 1,
  Repeat = 2,
  Guard = 3,
  Shop = 4,
  Board = 5,
  Decoration_1 = 6
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, args)
    local isQuick = args ~= nil and args.isQuickEntrance
    EnterMapEp(false)
  end,
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local carnivalData = eActInteract.__GetActData()
    local mainCfg = carnivalData:GetCarnival23Cfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winrwe23Shop, function(window)
      if window == nil then
        return
      end
      window:BindRedShopFunc(function(shopId)
        return not carnivalData:IsCarnival23ShopLooked(shopId)
      end)
      window:BindSelectShopFunc(function(shopId)
        carnivalData:SetCarnival23ShopLooked(shopId)
      end)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitSum22ShopByShopList(carnivalData, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function()
    EnterMapEp(true)
  end,
  [eActInteract.eLbIntrctActionId.Guard] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local sectorId = actData:GetExtraSectorId()
    if sectorId == 0 then
      return
    end
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    actData:SetExtraSectorIsLooked()
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
      if window == nil then
        return
      end
      window:InitSectorLevel(sectorId, realReturnFunc, 1)
      window:SetCustomExBattleStartCallback(function()
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      end)
    end)
  end
}
eActInteract.eActIntrctEntityEnterFunc = {}
eActInteract.eActIntrctActionUIInitFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(uiItem, entity, actionCfg)
  end
}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    return not eActInteract.__GetActEnd()
  end,
  [eActInteract.eLbIntrctEntityId.Repeat] = function(lbIntrctData)
    local carnival23Data = eActInteract.__GetActData()
    return carnival23Data ~= nil and carnival23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Guard] = function(lbIntrctData)
    local carnival23Data = eActInteract.__GetActData()
    return carnival23Data ~= nil and carnival23Data:IsActivityRunning()
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local carnival23Data = eActInteract.__GetActData()
    local playEndTime = carnival23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function(entity)
    local carnival23Data = eActInteract.__GetActData()
    local playEndTime = carnival23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.Guard] = function(entity)
    local carnival23Data = eActInteract.__GetActData()
    local playEndTime = carnival23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local carnival23Data = eActInteract.__GetActData()
    local reddot = carnival23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.Shop)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Main] = function(lbIntrctData)
    local carnival23Data = eActInteract.__GetActData()
    local reddot = carnival23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.main)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Guard] = function(lbIntrctData)
    local carnival23Data = eActInteract.__GetActData()
    local reddot = carnival23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityCarnival23Enum.reddotType.SectorExLooked)
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

local function EggOnLoaded(actLbCtrl)
  local carnival23Data = eActInteract.__GetActData()
  local eggCfgList = ConfigData.activity_carnival23_surprise[carnival23Data:GetActFrameId()]
  local changeOne = PlayerDataCenter.sectorStage:IsStageComplete(eggCfgList[1].surprise_param[1])
  local gameObj = CS_GameObject.Find("model_hesperus")
  if changeOne and not IsNull(gameObj) then
    gameObj:SetActive(false)
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
    win:SetBtnReddotFunc(1, MissonBtnRedFunc[eActInteract.eMissonBtn.ActivityBP])
    win:RefreshMissonReddot()
  end)
  local carnival23Data = eActInteract.__GetActData()
  local reddot = carnival23Data:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  EggOnLoaded(actLbCtrl)
  actLbCtrl:SetCmderObjShow(false)
  local graph = CS.AstarPath.active.data.recastGraph
  graph:Scan()
  actLbCtrl:SetCmderObjShow(true)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
  if not carnival23Ctrl then
    return
  end
  carnival23Ctrl:RunEnterCompleteFunc()
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
  local carnival23Data = eActInteract.__GetActData()
  if carnival23Data ~= nil then
    local reddot = carnival23Data:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
