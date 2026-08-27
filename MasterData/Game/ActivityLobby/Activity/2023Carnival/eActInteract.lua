local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityCarnival23Enum = require("Game.ActivityCarnival23.Data.ActivityCarnival23Enum")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local cs_MessageCommon = CS.MessageCommon
local JumpManager = require("Game.Jump.JumpManager")

function eActInteract.__GetActData()
  local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
  if not carnival23Ctrl then
    return
  end
  return carnival23Ctrl:GetCarnival23Data()
end

eActInteract.eMissonBtn = {
  Task = 1,
  LotteryJump = 2,
  ActivityBP = 3
}
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
  end,
  [eActInteract.eMissonBtn.LotteryJump] = function()
    JumpManager:Jump(108, nil, nil, {nil, 6})
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
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actCarnival23)
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
        local actName, mainName = carnival23Ctrl:GetActCarnival23NameAndMainMode()
        local _, repeatName = carnival23Ctrl:GetActCarnival23NameAndRepeatMode()
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
    carnival23Ctrl:EnterCarnival23MainEp(sectorId, isRepeat, realReturnFunc, chapterId)
  end
end

eActInteract.eLbIntrctActionId = {
  Main = 1,
  Shop = 2,
  Repeat = 3,
  MiniGame = 5
}
eActInteract.eLbIntrctEntityId = {
  Main = 1,
  Shop = 2,
  Repeat = 3,
  MiniGame = 5,
  Gabrie = 6,
  Beelneith = 7,
  Eos2 = 8
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
  [eActInteract.eLbIntrctActionId.MiniGame] = function()
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
    local carnivalData
    if carnivalCtrl then
      carnivalData = carnivalCtrl:GetCarnival23Data()
      if carnivalData == nil then
        error("carnival act data not exist")
        return
      end
    end
    local tinyGameBrotatoId = carnivalData:GetCarnival23TinyGame()
    if tinyGameBrotatoId == -1 then
      return
    end
    if not carnivalData:IsActivityRunning() then
      return
    end
    local endtime = carnivalData:GetActivityEndTime()
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    ActLbUtil.OnActLbInteractEnter(true)
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:InitBrotatoLobbyCtrl(endtime, tinyGameBrotatoId, realReturnFunc)
    activityBrotatoLobbyCtrl:ShowBrotatoLobbyUIMain(tinyGameBrotatoId, carnivalCtrl.isOpenByBattleResult)
    carnivalCtrl:SetIsOpenByResultWithBrotato(false)
    carnivalData:SetCarnival23TinyGameStageId(activityBrotatoLobbyCtrl:GetTinyGameStageId())
  end
}
eActInteract.eActIntrctActionUIInitFunc = {}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local carnival23Data = eActInteract.__GetActData()
    return carnival23Data ~= nil and carnival23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Repeat] = function(lbIntrctData)
    local carnival23Data = eActInteract.__GetActData()
    return carnival23Data ~= nil and carnival23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.MiniGame] = function(lbIntrctData)
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
  [eActInteract.eLbIntrctActionId.MiniGame] = function(entity)
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
  local gabrie = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.Gabrie)
  if gabrie ~= nil then
    local show = not PlayerDataCenter.sectorStage:IsStageComplete(330012121)
    gabrie:SetLbEnityGameObjectActive(show)
  end
  local beelneith = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.Beelneith)
  if beelneith ~= nil then
    local show = not PlayerDataCenter.sectorStage:IsStageComplete(330012121)
    beelneith:SetLbEnityGameObjectActive(show)
  end
  local changeEos = PlayerDataCenter.sectorStage:IsStageComplete(330012126)
  local eos = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.Shop)
  if eos ~= nil and not IsNull(eos.transform) then
    local eosTran = eos.transform:Find("eos")
    if not IsNull(eosTran) then
      eosTran.gameObject:SetActive(not changeEos)
    end
  end
  local eos2 = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.Eos2)
  if eos2 then
    eos2:SetLbEnityGameObjectActive(changeEos)
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
