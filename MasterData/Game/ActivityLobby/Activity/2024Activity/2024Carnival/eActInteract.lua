local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local cs_MessageCommon = CS.MessageCommon
local ActivityCarnival24Enum = require("Game.ActivityCarnival24.Data.ActivityCarnival24Enum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function eActInteract.__GetActData()
  local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if not carnival24Ctrl then
    return
  end
  local actFrameId = ActLbUtil.GetCurActLbActId()
  return carnival24Ctrl:GetActDataByFrameId(actFrameId)
end

eActInteract.eMissonBtn = {Task = 1, ActivityBP = 2}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function(ignoreInteract)
    local actData = eActInteract.__GetActData()
    local dailyTaskData = actData:GetCarnival24DailyTaskData()
    local termTaskData = actData:GetCarnival24TermTaskData()
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
      win:InitWinter23Task(actData:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local actData = eActInteract.__GetActData()
    local reddot = actData:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityCarnival24Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivityCarnival24Enum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eMissonBtn.ActivityBP] = function()
    local actData = eActInteract.__GetActData()
    local reddot = actData:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityCarnival24Enum.reddotType.Jump1)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end
}
eActInteract.eLbIntrctActionId = {
  None = 0,
  Main = 1,
  SideGame = 2,
  Memory = 3,
  RewardBp = 4,
  Shop = 5,
  Story = 6,
  MonsterCard = 7
}
eActInteract.eLbIntrctEntityId = {
  None = 0,
  Main = 1,
  SideGame = 2,
  Memory = 3,
  RewardBp = 4,
  Shop = 5,
  Story = 6,
  MonsterCard = 7
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    if not carnival24Ctrl then
      return
    end
    local actFrameId = ActLbUtil.GetCurActLbActId()
    local actData = eActInteract.__GetActData()
    local mainCfg = ConfigData.act_general_ep_main[actFrameId]
    local sectorId = mainCfg.main_stage
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      return
    end
    if SectorStageDetailHelper.IsSectorHasUnComplete(sectorId) then
      if not ExplorationManager:GetIsLastEpDataQuitMode() then
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      end
      SectorStageDetailHelper.ContinueUncompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    UIManager:CreateWindowAsync(UIWindowTypeID.CommonEpModeSelect, function(win)
      if win == nil then
        return
      end
      local ModeSelectData = require("Game.CommonUI.ModeSelect.Data.ModeSelectData")
      local modeSelectData = ModeSelectData.New(actFrameId)
      modeSelectData:SetGetInifinityCurrentScoreCallback(BindCallback(actData, actData.GetEpInfinityCurrentScoreByDiffId))
      modeSelectData:SetGetInifinityPickedScoreCallback(BindCallback(actData, actData.GetEpInfinityPickedScoreByDiffId))
      modeSelectData:SetRefreshInifinityPickedScoreCallback(BindCallback(actData, actData.LocalRefreshPickedEpInfinityRewardScore))
      modeSelectData:SetGetEnvRedDotNodeCallback(BindCallback(actData, actData.GetEnvReddotNode))
      modeSelectData:SetGetInfinityRewardReddotNodeCallback(BindCallback(actData, actData.GetInfinityRewardReddotNode))
      win:InitEpCommonModeSelect(modeSelectData, BindCallback(carnival24Ctrl, carnival24Ctrl.EnterAnniversaryEp), BindCallback(carnival24Ctrl, carnival24Ctrl.EnterAnniversaryEpQuickBattle), function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end,
  [eActInteract.eLbIntrctActionId.SideGame] = function(entity)
    local carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    local carnival24Data = carnival24Controller:GetActFirstData()
    local mainCfg = carnival24Data:GetMainCfg()
    local actFrameId = mainCfg.second_id
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
    local actId = actFrameData:GetActId()
    
    local function returnActLbfunc()
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
      if ctrl then
        ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.SideGame)
      end
    end
    
    local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
    if bondCtrl ~= nil then
      ActLbUtil.OnActLbInteractEnter(true)
      bondCtrl:OpenActBondUI(actId, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end, nil, carnival24Data, returnActLbfunc, function()
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      end)
    end
  end,
  [eActInteract.eLbIntrctActionId.Memory] = function(entity)
    local carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    if carnival24Controller == nil then
      return
    end
    local carnival24Data = carnival24Controller:GetActFirstData()
    
    local function _ShowMemoryAlbumsWindow()
      UIManager:ShowWindowAsync(UIWindowTypeID.UICarnivalMemoryAlbums, function(window)
        if window == nil then
          return
        end
        ActLbUtil.OnActLbInteractEnter(true)
        local mainCfg = carnival24Data:GetMainCfg()
        window:InitCarnivalMemoryAlbums(mainCfg, function()
          ActLbUtil.OnActLbInteractEnter(false)
        end)
      end)
    end
    
    local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local isFirstOpen = not userData:GetIsLookedFragmentOpenAVG(carnival24Data:GetActId())
    if isFirstOpen then
      local actData = eActInteract.__GetActData()
      local mainCfg = actData:GetMainCfg()
      local avgCfg = ConfigData.story_avg[mainCfg.fragment_avg]
      local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
      avgCtrl:StartAvg(avgCfg.script_id, avgCfg.id, function()
        userData:SetIsLookedFragmentOpenAVG(carnival24Data:GetActId(), true)
        _ShowMemoryAlbumsWindow()
      end)
    else
      _ShowMemoryAlbumsWindow()
    end
  end,
  [eActInteract.eLbIntrctActionId.RewardBp] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    if carnival24Ctrl == nil then
      return
    end
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    ActLbUtil.OnActLbInteractEnter(true)
    carnival24Ctrl:ShowRewardBp(realReturnFunc)
  end,
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local mainCfg = actData:GetMainCfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winrwe23Shop, function(window)
      if window == nil then
        return
      end
      window:BindRedShopFunc(function(shopId)
        return not actData:IsCarnival24ShopLooked(shopId)
      end)
      window:BindSelectShopFunc(function(shopId)
        actData:SetCarnival24ShopLooked(shopId)
      end)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitSum22ShopByShopList(actData, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Story] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local mainCfg = actData:GetMainCfg()
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
      window:SetCustomExBattleStartCallback(function()
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.MonsterCard] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonMonsterCard, function(window)
      if window == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitActCommonMonsterCardUI(actData.actMonsterCardPlayData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
eActInteract.eActIntrctActionUIInitFunc = {}
eActInteract.eSubNameFuncs = {}
eActInteract.eActIntrctActionLockClickTipFunc = {
  [eActInteract.eLbIntrctEntityId.SideGame] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    local mainCfg = actData:GetMainCfg()
    local startTime = mainCfg.second_time
    local timeDate = TimeUtil:TimestampToDate(startTime, nil, true)
    if not actData:IsActivityRunning() then
      return 6033
    end
    return ConfigData:GetTipContent(426, timeDate.month, timeDate.day)
  end
}

local function CommonIsUnlockFunc()
  local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Ctrl == nil then
    return false
  end
  local actData = eActInteract.__GetActData()
  if actData == nil then
    return false
  end
  return actData:IsActivityRunning()
end

eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    return CommonIsUnlockFunc()
  end,
  [eActInteract.eLbIntrctEntityId.MonsterCard] = function(lbIntrctData)
    return CommonIsUnlockFunc()
  end,
  [eActInteract.eLbIntrctEntityId.Memory] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    return true
  end,
  [eActInteract.eLbIntrctEntityId.RewardBp] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    return true
  end,
  [eActInteract.eLbIntrctEntityId.Shop] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    return true
  end,
  [eActInteract.eLbIntrctEntityId.SideGame] = function(lbIntrctData)
    local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
    if carnival24Ctrl == nil then
      return false
    end
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    local startTime = actData:GetMainCfg().second_time
    return startTime <= PlayerDataCenter.timestamp and actData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Story] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    return true
  end
}

local function CommonLockStateDesFun()
  local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Ctrl == nil then
    return false
  end
  local actData = eActInteract.__GetActData()
  if actData == nil then
    return false
  end
  local playEndTime = actData:GetActivityEndTime()
  if playEndTime < PlayerDataCenter.timestamp then
    return 1
  end
  return 0
end

eActInteract.eActIntrctActionLockStateDesFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, actionCfg)
    return CommonLockStateDesFun()
  end,
  [eActInteract.eLbIntrctActionId.MonsterCard] = function(entity, actionCfg)
    return CommonLockStateDesFun()
  end,
  [eActInteract.eLbIntrctActionId.SideGame] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return 0
    end
    local playEndTime = actData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local carnival24Data = eActInteract.__GetActData()
    local childReddot = carnival24Data:GetActChildRedDot(ActivityCarnival24Enum.reddotType.Shop)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.RewardBp] = function(entity)
    local carnival24Data = eActInteract.__GetActData()
    local childReddot = carnival24Data:GetActChildRedDot(ActivityCarnival24Enum.reddotType.BpReward)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local carnival24Data = eActInteract.__GetActData()
    local childReddot = carnival24Data:GetActChildRedDot(ActivityCarnival24Enum.reddotType.Infinity)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.SideGame] = function(entity)
    local carnival24Data = eActInteract.__GetActData()
    local childReddot = carnival24Data:GetActChildRedDot(ActivityCarnival24Enum.reddotType.SubAct_Bond)
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

eActInteract.eSpecialOpeEntInfoFunc = {
  [eActInteract.eLbIntrctEntityId.None] = function(entInfoItem)
  end
}
eActInteract.eActIntrctEntityShowFunc = {}

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  local carnival24Data = eActInteract.__GetActData()
  local reddot = carnival24Data:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    local actFrameId = ActLbUtil.GetCurActLbActId()
    win:InitJumpFuncByActivityFrameId(actFrameId)
    win:SetBtnReddotFunc(eActInteract.eMissonBtn.ActivityBP - 1, MissonBtnRedFunc[eActInteract.eMissonBtn.ActivityBP])
    win:RefreshMissonReddot()
  end)
  actLbCtrl:SetCmderObjShow(false)
  local graph = CS.AstarPath.active.data.recastGraph
  graph:Scan()
  actLbCtrl:SetCmderObjShow(true)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if not carnival24Ctrl then
    return
  end
  carnival24Ctrl:RunEnterCompleteFunc()
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    ActLbUtil.UpdLbCurFollowInfoShow()
  end
end

function eActInteract.OnActCamChangeFunc()
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local actData = eActInteract.__GetActData()
  if actData ~= nil then
    local reddot = actData:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
