local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivitySpringEnum = require("Game.ActivitySpring.Data.ActivitySpringEnum")

function eActInteract.__GetActData()
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if not springCtrl then
    return
  end
  local actFrameId = ActLbUtil.GetCurActLbActId()
  return springCtrl:GetActSpringDataByFrameId(actFrameId)
end

eActInteract.eMissonBtn = {Task = 1}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local springData = eActInteract.__GetActData()
    local dailyTaskData = springData:GetSpringDailyTaskData()
    local termTaskData = springData:GetSpringTermTaskData()
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
      win:InitWinter23Task(springData:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local spring23Data = eActInteract.__GetActData()
    local reddot = spring23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivitySpringEnum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivitySpringEnum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end
}
eActInteract.eLbIntrctEntityId = {
  EnvSelect = 1,
  StoryReview = 2,
  TechTree = 3,
  HardLevel = 4,
  PaintedEggshell = 5
}

local function CreateUIWhenEnterFinish(springData)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Interactive, function(win)
    if win == nil then
      return
    end
    win:InitSpring23Interactive(springData, actLbCtrl.actLbIntrctCtrl:GetAllHeroEntity())
  end)
  
  local function Local_Spring23UnlockFunc(callback)
    local unlockInfo = springData:GetSpringUnlockInfo()
    if unlockInfo ~= nil and unlockInfo:IsExistActUnlockInfo() then
      UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Unlock, function(win)
        if win == nil then
          return
        end
        ActLbUtil.OnActLbInteractEnter(true)
        win:InitSpring23Unlock(unlockInfo, function()
          ActLbUtil.OnActLbInteractEnter(false)
        end)
        callback()
      end)
    else
      callback()
    end
  end
  
  local createSort = {Local_Spring23UnlockFunc}
  local Local_SortNextFunc
  
  function Local_SortNextFunc()
    if createSort[1] ~= nil then
      local func = createSort[1]
      table.remove(createSort, 1)
      func(Local_SortNextFunc)
    end
  end
  
  Local_SortNextFunc()
end

local function TryOpenUnlockWin(springData)
  local unlockInfo = springData:GetSpringUnlockInfo()
  if unlockInfo ~= nil and unlockInfo:IsExistActUnlockInfo() then
    UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Unlock, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitSpring23Unlock(unlockInfo, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
end

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

eActInteract.eIntrctFuncs = {
  [1] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if not springCtrl then
      return
    end
    local springData = eActInteract.__GetActData()
    if springData == nil then
      error("spring act data not exist")
      return
    end
    local mainCfg = springData:GetSpringMainCfg()
    local sectorId = mainCfg.main_stage
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      return
    end
    if SectorStageDetailHelper.IsSectorHasUnComplete(sectorId) then
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      SectorStageDetailHelper.ContinueUncompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    UIManager:ShowWindowAsync(UIWindowTypeID.Spring23LevelModSelect, function(window)
      if window == nil then
        return
      end
      window:InitSpring23ModeSelect(springData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [2] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if not springCtrl then
      return
    end
    local springData = eActInteract.__GetActData()
    UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Story, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      local heroId = intrctData:GetLbIntrctObjHeroId()
      win:InitSpring23Story(springData, heroId, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [3] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if not springCtrl then
      return
    end
    local springData = eActInteract.__GetActData()
    local actTechTree = springData:GetSpringTechTree()
    local specialBranchId = springData:GetSpringMainCfg().tech_special_branch
    UIManager:ShowWindowAsync(UIWindowTypeID.Winter23StrategyOverview, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitChristmas22StrategyOverview(actTechTree, specialBranchId, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [4] = function(entity)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if not springCtrl then
      return
    end
    local springData = eActInteract.__GetActData()
    local objNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    objNetwork:CS_Rank_Detail(springData:GetRankId(), 0, function(args)
      if not args then
        return
      end
      local msg = args[0]
      UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Challenge, function(win)
        if win == nil then
          return
        end
        ActLbUtil.OnActLbInteractEnter(true)
        win:InitSpring23HardLevel(springData, function()
          ActLbUtil.OnActLbInteractEnter(false)
        end)
        win:SetRankTex(msg.myRank)
      end)
    end)
  end,
  [5] = function(entity)
    if IsNull(entity.gameObject) then
      error("entity.gameObject is nil")
      return
    end
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    actLbCtrl.actLbCmderCtrl:LbHeroAndCmdFace2Face(entity, function()
      local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
      if not springCtrl then
        return
      end
      local springData = eActInteract.__GetActData()
      local intrctData = entity:GetLbIntrctEntData()
      local heroId = intrctData:GetLbIntrctObjHeroId()
      local success = springCtrl:CheckAndTalk(springData:GetActId(), heroId, function()
        ActLbUtil.UpdLbCurInteractList()
        ActLbUtil.OnActLbInteractEnter(false)
        TryOpenUnlockWin(springData)
      end)
      if success then
        ActLbUtil.OnActLbInteractEnter(true)
      end
    end)
  end,
  [6] = function(entity)
    local lbIntrctData = entity:GetLbIntrctEntData()
    local actionData = lbIntrctData:GetLbIntrctObjActionFirst()
    local params = actionData:GetLbIntrctActionParams()
    local avgId = params[1]
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(nil, avgId, function()
      ActLbUtil.UpdActLbEnttUnlockStateByObjId(eActInteract.eLbIntrctEntityId.PaintedEggshell)
    end)
  end
}
eActInteract.eActIntrctActionUIInitFunc = {
  [5] = function(uiItem, entity, actionCfg)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if not springCtrl then
      return
    end
    local springData = eActInteract.__GetActData()
    if springData == nil then
      return
    end
    local springStoryData = springData:GetSpringStoryData()
    local intrctData = entity:GetLbIntrctEntData()
    local heroId = intrctData:GetLbIntrctObjHeroId()
    local interactCfg, cantTalk = springStoryData:GetNowCfgByHeroId(heroId)
    if not interactCfg or cantTalk then
      uiItem:SetSetActLbIntrctItemLock()
      return
    end
    local needCost = springStoryData:GetNeedExp(interactCfg.id)
    local allCost = springData:GetInteractCostNum()
    if needCost <= allCost then
      uiItem:SetActLbIntrctItemHighlight()
    end
    uiItem:SetSetActLbIntrctItemProgress(tostring(allCost) .. "/" .. tostring(needCost))
  end
}
eActInteract.eSubNameFuncs = {
  [5] = function(entity, actionCfg)
    local intrctData = entity:GetLbIntrctEntData()
    local heroId = intrctData:GetLbIntrctObjHeroId()
    local heroCfg = ConfigData.hero_data[heroId]
    local heroName = LanguageUtil.GetLocaleText(heroCfg.name)
    return string.format(LanguageUtil.GetLocaleText(actionCfg.obj_func_subname), heroName)
  end
}

local function checkActRunningEnd()
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if not springCtrl then
    return false
  end
  local springData = eActInteract.__GetActData()
  return springData ~= nil and springData:IsActivityRunning()
end

eActInteract.eUnlockIntrctFunc = {
  [1] = function(lbIntrctData)
    return checkActRunningEnd()
  end,
  [3] = function(lbIntrctData)
    return checkActRunningEnd()
  end,
  [eActInteract.eLbIntrctEntityId.HardLevel] = function(lbIntrctData)
    return checkActRunningEnd()
  end,
  [eActInteract.eLbIntrctEntityId.PaintedEggshell] = function(lbIntrctData)
    local actionData = lbIntrctData:GetLbIntrctObjActionFirst()
    local params = actionData:GetLbIntrctActionParams()
    local avgId = params[1]
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(avgId)
    return not played
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {
  [1] = function(entity, actionCfg)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return false
    end
    local springData = eActInteract.__GetActData()
    if springData == nil then
      return false
    end
    local playEndTime = springData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [3] = function(entity)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return false
    end
    local springData = eActInteract.__GetActData()
    if springData == nil then
      return false
    end
    local playEndTime = springData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [4] = function(entity, actionCfg)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return false
    end
    local springData = eActInteract.__GetActData()
    if springData == nil then
      return false
    end
    local playEndTime = springData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [1] = function(entity, actionCfg)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return false
    end
    local springData = eActInteract.__GetActData()
    if springData == nil or not springData:IsActivityRunning() then
      return false
    end
    local reddot = springData:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.EpEnv)
    if childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end,
  [3] = function(lbIntrctData)
    local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
    if springCtrl == nil then
      return false
    end
    local springData = eActInteract.__GetActData()
    if springData == nil or not springData:IsActivityRunning() then
      return false
    end
    local reddot = springData:GetActivityReddot()
    local childReddot1 = reddot:AddChild(ActivitySpringEnum.reddotType.Tech)
    local childReddot2 = reddot:AddChild(ActivitySpringEnum.reddotType.TechItemLimit)
    return childReddot1 ~= nil and childReddot1:GetRedDotCount() > 0 or childReddot2 ~= nil and childReddot2:GetRedDotCount() > 0
  end
}

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if not springCtrl then
    return
  end
  local springData = eActInteract.__GetActData()
  CreateUIWhenEnterFinish(springData)
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
  local reddot = springData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  while UIManager:GetWindow(UIWindowTypeID.Spring23Interactive) == nil do
    coroutine.yield(nil)
  end
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if not springCtrl then
    return
  end
  springCtrl:RunEnterCompleteFunc()
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  local springData = eActInteract.__GetActData()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
    UIManager:HideWindow(UIWindowTypeID.Spring23Interactive)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    local interactWin = UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Interactive)
    if interactWin then
      interactWin:InitSpring23Interactive(springData, actLbCtrl.actLbIntrctCtrl:GetAllHeroEntity())
    end
  end
  if not isEnter then
    TryOpenUnlockWin(springData)
  end
end

function eActInteract.OnActCamChangeFunc()
  local interactWin = UIManager:GetWindow(UIWindowTypeID.Spring23Interactive)
  if interactWin and interactWin.active then
    interactWin:UpdateInteractive()
  end
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
  if not springCtrl then
    return
  end
  local springData = eActInteract.__GetActData()
  if springData ~= nil then
    local reddot = springData:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
