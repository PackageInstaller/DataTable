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
    if childReddot == nil then
      return false
    end
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

local function PlayerClickCollect(entity, isQuick)
  if isQuick then
    PlayerClickCollectManager:BtnClickNumCollect(1020)
    return
  end
  local entityId = entity:GetLbIntrctEntData():GetLbIntrctObjId()
  PlayerClickCollectManager:BtnClickNumCollect(1012 + entityId)
end

eActInteract.eLbIntrctActionId = {
  Board = 1,
  Repeat = 3,
  Shop = 4,
  Main = 2
}
eActInteract.eLbIntrctEntityId = {
  Board = 1,
  Repeat = 2,
  Shop = 3,
  Main = 4,
  inlet_1 = 5,
  inlet_2 = 6,
  inlet_3 = 7,
  inlet_5_die = 8,
  inlet_6_die = 9
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, args)
    local isQuick = args ~= nil and args.isQuickEntrance
    EnterMapEp(false)
    PlayerClickCollect(entity, isQuick)
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
  end
}
eActInteract.eActIntrctEntityEnterFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, isEnter)
    if eActInteract.__GetActEnd() then
      return
    end
    local interactWin = UIManager:GetWindow(UIWindowTypeID.Summer23Interactive)
    if interactWin then
      interactWin:SetInfoBoardOpen(entity:GetLbInteractEntityId(), isEnter)
    end
  end
}
eActInteract.eActIntrctActionUIInitFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(uiItem, entity, actionCfg)
    local carnival23Data = eActInteract.__GetActData()
    if eActInteract.__GetActEnd() then
      return
    end
    local cfgList = ConfigData.activity_chapter_interact[carnival23Data:GetActFrameId()]
    local isOpen = false
    for i = #cfgList, 1, -1 do
      local cfg = cfgList[i]
      if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
        if cfg.obj_id == entity:GetLbInteractEntityId() then
          isOpen = true
          break
        end
        isOpen = false
        break
      end
    end
    uiItem.transform.gameObject:SetActive(isOpen)
  end
}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    return not eActInteract.__GetActEnd()
  end,
  [eActInteract.eLbIntrctEntityId.inlet_1] = function(lbIntrctData)
    return not eActInteract.__GetActEnd()
  end,
  [eActInteract.eLbIntrctEntityId.inlet_2] = function(lbIntrctData)
    return not eActInteract.__GetActEnd()
  end,
  [eActInteract.eLbIntrctEntityId.inlet_3] = function(lbIntrctData)
    return not eActInteract.__GetActEnd()
  end,
  [eActInteract.eLbIntrctEntityId.Repeat] = function(lbIntrctData)
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
  local uskyProGo = CS_GameObject.Find("uSkyPro")
  if IsNull(uskyProGo) then
    error("IsNull(uskyProGo) ")
    return
  end
  local uskyPro = uskyProGo:GetComponent(typeof(CS.uSkyPro))
  if IsNull(uskyPro) then
    error("IsNull(uskyPro)")
    return
  end
  local carnival23Data = eActInteract.__GetActData()
  local cfgList = ConfigData.activity_chapter_skybox[carnival23Data:GetActFrameId()]
  local starIntensity = 5
  local aetherLightObjName = ""
  for i = #cfgList, 1, -1 do
    local cfg = cfgList[i]
    if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      starIntensity = cfg.star_intensity
      aetherLightObjName = cfg.obj_display
      break
    end
  end
  uskyPro.StarIntensity = starIntensity
  local aetherRootGo = CS_GameObject.Find("2023Aether_state")
  if IsNull(aetherRootGo) then
    error("IsNull(aetherRootGo) ")
    return
  end
  local targetObj = aetherRootGo.transform:Find(aetherLightObjName)
  if IsNull(targetObj) then
    error("IsNull(targetObj) ")
    return
  end
  targetObj.gameObject:SetActive(true)
  local eggCfgList = ConfigData.activity_carnival23_surprise[carnival23Data:GetActFrameId()]
  local changeOne = PlayerDataCenter.sectorStage:IsStageComplete(eggCfgList[1].surprise_param[1])
  local one = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.Repeat)
  if one ~= nil and not IsNull(one.transform) then
    local oneTran = one.transform:Find("model_xinghuan")
    if not IsNull(oneTran) then
      oneTran.gameObject:SetActive(not changeOne)
    end
  end
  local one2 = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.inlet_5_die)
  if one2 then
    one2:SetLbEnityGameObjectActive(changeOne)
  end
  local changeTwo = PlayerDataCenter.sectorStage:IsStageComplete(eggCfgList[2].surprise_param[1])
  local two = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.Shop)
  if two ~= nil and not IsNull(two.transform) then
    local twoTran = two.transform:Find("model_yuwang")
    if not IsNull(twoTran) then
      twoTran.gameObject:SetActive(not changeTwo)
    end
  end
  local one2 = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(eActInteract.eLbIntrctEntityId.inlet_6_die)
  if one2 then
    one2:SetLbEnityGameObjectActive(changeTwo)
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
  local isActClose = eActInteract.__GetActEnd()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.Summer23Interactive, function(win)
    if win == nil then
      return
    end
    win:InitSummer23Interactive(carnival23Data, actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic(), isActClose)
  end)
  local reddot = carnival23Data:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  EggOnLoaded(actLbCtrl)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  while UIManager:GetWindow(UIWindowTypeID.Summer23Interactive) == nil do
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
    UIManager:HideWindow(UIWindowTypeID.Summer23Interactive)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    local carnival23Data = eActInteract.__GetActData()
    local isActClose = eActInteract.__GetActEnd()
    local interactWin = UIManager:ShowWindowOnly(UIWindowTypeID.Summer23Interactive)
    if interactWin then
      interactWin:InitSummer23Interactive(carnival23Data, actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic(), isActClose)
    end
  end
end

function eActInteract.OnActCamChangeFunc()
  local interactWin = UIManager:GetWindow(UIWindowTypeID.Summer23Interactive)
  if interactWin and interactWin.active then
    interactWin:UpdateInteractive()
  end
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
  local interactWin = UIManager:GetWindow(UIWindowTypeID.Summer23Interactive)
  if interactWin and interactWin.active then
    interactWin:SetActClose()
  end
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
