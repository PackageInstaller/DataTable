local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityAnni24Enum = require("Game.ActivityAnniversary24.Data.ActAnniversary24Enum")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local ActAnniversary24Enum = require("Game.ActivityAnniversary24.Data.ActAnniversary24Enum")
local cs_MessageCommon = CS.MessageCommon
local CS_GameObject = CS.UnityEngine.GameObject
local JumpManager = require("Game.Jump.JumpManager")

function eActInteract.__GetActData()
  local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if not anniversary24Ctrl then
    return
  end
  return anniversary24Ctrl:GetActFirstData()
end

function eActInteract.__GetActEnd()
  local anniversary24Data = eActInteract.__GetActData()
  if anniversary24Data == nil or not anniversary24Data:IsActivityRunning() then
    return true
  end
  return false
end

eActInteract.eMissonBtn = {
  Task = 1,
  Activity1 = 2,
  Activity2 = 3
}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function(isFirstSelectTermTask)
    local anni24Data = eActInteract.__GetActData()
    local dailyTaskData = anni24Data:GetAnniversary24DailyTaskData()
    local termTaskData = anni24Data:GetAnniversary24TermTaskData()
    if dailyTaskData == nil then
      if isGameDev then
        warn(" daily task not open ")
      end
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.UI24WinterTask, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitAnniversary23Task(anni24Data:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end, isFirstSelectTermTask)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local anni24Data = eActInteract.__GetActData()
    local reddot = anni24Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityAnni24Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivityAnni24Enum.reddotType.OnceTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end,
  [eActInteract.eMissonBtn.Activity1] = function()
    local anni24Data = eActInteract.__GetActData()
    local reddot = anni24Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActAnniversary24Enum.reddotType.Activity1)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end,
  [eActInteract.eMissonBtn.Activity2] = function()
    local anni24Data = eActInteract.__GetActData()
    local reddot = anni24Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActAnniversary24Enum.reddotType.Activity2)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end
}

local function EnterMapEp(isRepeat)
  local anni24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
  sectorLevelChapterCtrl:ChangeChapterDataType(SectorChapterEnum.chapterDataType.actAnniversary24)
  if anni24Ctrl then
    local actData = eActInteract:__GetActData()
    if actData == nil then
      error("anni24 act data not exist")
      return
    end
    if not actData:IsActivityRunning() then
      return
    end
    local mainCfg = actData:GetAnniversary24Cfg()
    local sectorId = mainCfg.normal_sector
    local flag, defaultSectorId = actData:GetLastAnniversary24MainSector()
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
        local actName, mainName = anni24Ctrl:GetActAnniversary24NameAndMainMode(eActInteract)
        local _, repeatName = anni24Ctrl:GetActAnniversary24NameAndRepeatMode(eActInteract)
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
    anni24Ctrl:EnterAnniversary24MainEp(sectorId, isRepeat, realReturnFunc, chapterId, false, eActInteract)
  end
end

eActInteract.eLbIntrctActionId = {
  Board = 1,
  Main = 2,
  Repeat = 3,
  Dungeon = 4,
  Shop = 5,
  EggTalk = 6
}
eActInteract.eLbIntrctEntityId = {
  Board = 1,
  Main = 2,
  Repeat = 3,
  Dungeon = 4,
  Shop = 5
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, args)
    EnterMapEp(false)
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function()
    EnterMapEp(true)
  end,
  [eActInteract.eLbIntrctActionId.Dungeon] = function(entity, args)
    local actData = eActInteract.__GetActData()
    local playType = args and args.playType or 0
    ActLbUtil.OnActLbInteractEnter(true)
    UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardMain, function(window)
      window:InitReinforceCardMain(actData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end, playType)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local mainCfg = actData:GetAnniversary24Cfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winrwe23Shop, function(window)
      if window == nil then
        return
      end
      window:BindRedShopFunc(function(shopId)
        return not actData:IsAnniversary24ShopLooked(shopId)
      end)
      window:BindSelectShopFunc(function(shopId)
        actData:SetAnniversary24ShopLooked(shopId)
      end)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitSum22ShopByShopList(actData, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.EggTalk] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local canInteract, storyId = actData:GetHeroIsAlReadByEntity(entity)
    ActLbUtil.OnActLbInteractEnter(true)
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, storyId, function()
      ActLbUtil.OnActLbInteractEnter(false)
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
    return not eActInteract.__GetActEnd()
  end,
  [eActInteract.eLbIntrctEntityId.Dungeon] = function(lbIntrctData)
    return true
  end,
  [eActInteract.eLbIntrctEntityId.Shop] = function(lbIntrctData)
    return true
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local anniversary24Data = eActInteract.__GetActData()
    local playEndTime = anniversary24Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.Repeat] = function(entity)
    local anniversary24Data = eActInteract.__GetActData()
    local playEndTime = anniversary24Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
  end,
  [eActInteract.eLbIntrctActionId.Main] = function(lbIntrctData)
    local anniversary24Data = eActInteract.__GetActData()
    local childReddot = anniversary24Data:GetActChildRedDot(ActAnniversary24Enum.reddotType.main)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Dungeon] = function(entity)
    local anniversary24Data = eActInteract.__GetActData()
    local childReddot = anniversary24Data:GetActChildRedDot(ActAnniversary24Enum.reddotType.ThreeInOne)
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
end

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    local actFrameId = ActLbUtil.GetCurActLbActId()
    if actFrameId then
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
      local actData = ctrl:GetActDataByFrameId(actFrameId)
      win:InitJumpFuncByActivityFrameId(actFrameId, actData)
    end
    win:SetBtnReddotFunc(eActInteract.eMissonBtn.Activity1 - 1, MissonBtnRedFunc[eActInteract.eMissonBtn.Activity1])
    win:SetBtnReddotFunc(eActInteract.eMissonBtn.Activity2 - 1, MissonBtnRedFunc[eActInteract.eMissonBtn.Activity2])
    win:RefreshMissonReddot()
  end)
  local anniversary24Data = eActInteract.__GetActData()
  local reddot = anniversary24Data:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  actLbCtrl:SetCmderObjShow(false)
  local graph = CS.AstarPath.active.data.recastGraph
  graph:Scan()
  actLbCtrl:SetCmderObjShow(true)
  local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  lobbyCtrl.actLbCmderCtrl.lbCmderEntity:SetEndReachedDistance(0.07)
  UIManager:ShowWindowAsync(UIWindowTypeID.UIAnni24Interactive, function(win)
    if win == nil then
      return
    end
    win:InitAnni24Interactive(anniversary24Data, actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic())
  end)
  EggOnLoaded(actLbCtrl)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  while UIManager:GetWindow(UIWindowTypeID.UIAnni24Interactive) == nil do
    coroutine.yield(nil)
  end
  local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if not anniversary24Ctrl then
    return
  end
  local actData = eActInteract.__GetActData()
  anniversary24Ctrl:RunEnterCompleteFunc(actData)
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
    UIManager:HideWindow(UIWindowTypeID.UIAnni24Interactive)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    local win = UIManager:GetWindow(UIWindowTypeID.Spring23Misson)
    if win then
      win:RefreshTipBoard()
      win:RefreshMissonReddot()
    end
    local actData = eActInteract.__GetActData()
    local interactWin = UIManager:ShowWindowOnly(UIWindowTypeID.UIAnni24Interactive)
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if interactWin then
      interactWin:InitAnni24Interactive(actData, actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic())
    end
  end
end

function eActInteract.OnActCamChangeFunc()
  local interactWin = UIManager:GetWindow(UIWindowTypeID.UIAnni24Interactive)
  if interactWin and interactWin.active then
    interactWin:UpdateInteractive()
  end
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
  local win = UIManager:GetWindow(UIWindowTypeID.UIReinforceCardMain)
  if win then
    win:RefreshLockState()
  end
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local anniversary24Data = eActInteract.__GetActData()
  if anniversary24Data ~= nil then
    local reddot = anniversary24Data:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
