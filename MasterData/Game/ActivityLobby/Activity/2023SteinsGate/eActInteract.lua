local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local Act23SGPerformUtil = require("Game.Activity23SteinsGate.Act23SteinsGatePerformUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local Act23SteinsGateEnum = require("Game.Activity23SteinsGate.Data.Act23SteinsGateEnum")
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local CS_GameObject = CS.UnityEngine.GameObject
local CS_Application = CS.UnityEngine.Application
eActInteract.eLbIntrctEntityId = {
  Main = 1,
  RepeatDg = 2,
  GachaponShop = 3,
  CardSet = 4,
  Brotato = 5,
  Task = 6,
  MiniGame = 7
}
eActInteract.eLbIntrctActionId = {
  None = 0,
  Main = 1,
  RepeatDg = 2,
  GachaponShop = 3,
  CardSet = 4,
  Brotato = 5,
  Task = 6,
  MiniGame = 7,
  Interact = 8
}

function eActInteract.__GetActData()
  local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
  if not steinsGate23Ctrl then
    return
  end
  local actFrameId = ActLbUtil.GetCurActLbActId()
  return steinsGate23Ctrl:GetActSteinsGateDataByFrameId(actFrameId)
end

eActInteract.eMissonBtn = {Task = 1}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local actData = eActInteract.__GetActData()
    local dailyTaskData = actData:GetSteinsGateDailyTaskData()
    local termTaskData = actData:GetSteinsGateTermTaskData()
    if dailyTaskData == nil then
      if isGameDev then
        warn(" daily task not open ")
      end
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.UI23SteinsGateTask, function(win)
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
local MissonBtnRedFunc = {}

local function CreateUIWhenEnterFinish(sgData)
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.UISteinsGate23Interactive, function(win)
    if win == nil then
      return
    end
    win:InitSG23Interactive(sgData, actLbCtrl.actLbIntrctCtrl:GetLbIntrctAllEntityDic())
  end)
end

local function isNeedPlayUnlock()
  local steinsGateData = eActInteract.__GetActData()
  steinsGateData:CheckIsSteinsGateInteractUnlock()
  local unlockInfo = steinsGateData:GetSteinsGateUnlockInfo()
  return unlockInfo ~= nil and unlockInfo:IsExistActUnlockInfo()
end

local function TryOpenUnlockWin(steinsGateData)
  steinsGateData:CheckIsSteinsGateInteractUnlock()
  local unlockInfo = steinsGateData:GetSteinsGateUnlockInfo()
  if unlockInfo ~= nil and unlockInfo:IsExistActUnlockInfo() then
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    UIManager:ShowWindowAsync(UIWindowTypeID.UI23SteinsGateUnlock, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:Init23SteinsGateUnlock(unlockInfo, steinsGateData:GetActId(), actLbCtrl:GetActLobbyId(), function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
      win:Bind23SteinsGateUnlockFunc(eActInteract.eUnlockIntrctFunc[eActInteract.eLbIntrctEntityId.RepeatDg], eActInteract.eIntrctFuncs[eActInteract.eLbIntrctEntityId.RepeatDg], eActInteract.eUnlockIntrctFunc[eActInteract.eLbIntrctEntityId.CardSet], eActInteract.eIntrctFuncs[eActInteract.eLbIntrctEntityId.CardSet])
    end)
  end
end

function eActInteract.TryOpenUnlockWin()
  local steinsGateData = eActInteract.__GetActData()
  TryOpenUnlockWin(steinsGateData)
end

function eActInteract.UpdateActivityReddotChange()
  ActLbUtil.UpdLbEntranceBlueDot(eActInteract.eLbIntrctEntityId, eActInteract.eActIntrctActionShowBlueDotFunc)
  for k, v in pairs(eActInteract.eLbIntrctEntityId) do
    ActLbUtil.UpdLbEnttBluedot(v)
  end
end

local function RefreshTipFunc()
  local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if lobbyCtrl == nil then
    return
  end
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if mainWin then
    local quickCheck = mainWin:GetQuickCheckItem()
    local actData = eActInteract.__GetActData()
    if not actData:IsActivityRunning() then
      quickCheck:SetToDoTip(false)
      return
    end
    local haveTip, tipContent = actData:GetSteinsGateTipInfo()
    quickCheck:SetToDoTip(haveTip, tipContent)
  end
end

local function InteractLobbyFunc()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local lobbyId = actLbCtrl:GetActLobbyIndex()
  local actData = eActInteract.__GetActData()
  local paraList = actData:GetSteinsGateCfg().outline_obj
  local needLobbyId = paraList[1]
  local originObjId = paraList[2]
  local interactId = paraList[3]
  if lobbyId ~= needLobbyId then
    return
  end
  local originEntity = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(originObjId)
  local outlineGo = originEntity.gameObject.transform:Find("2023STEINS_table_03")
  local isInteract = actData:GetSteinsGateInteractData():GetThisTalkStateById(interactId)
  outlineGo.gameObject:SetActive(not isInteract)
end

local function ShowLobbyEffectFunc()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local lobbyId = actLbCtrl:GetActLobbyIndex()
  local cfg = ConfigData.activity_23steinsgate_lobby_effect[lobbyId]
  if cfg == nil then
    return
  end
  local effectCtrl = actLbCtrl.actLbEffectCtrl
  if cfg.effect_para == 1 then
    effectCtrl:OpenOldMovieEffect()
  elseif cfg.effect_para == 2 then
    effectCtrl:OpenBlackBk()
  end
end

eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, args)
    local unlockFunc = eActInteract.eUnlockIntrctFunc[eActInteract.eLbIntrctEntityId.Main]
    if unlockFunc and not unlockFunc() then
      return
    end
    local steinsGate23Data = eActInteract.__GetActData()
    UIManager:ShowWindowAsync(UIWindowTypeID.Activity23SteinsGateChapterMap, function(window)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitAct21SGChaperMap(steinsGate23Data, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end, function()
        if args ~= nil then
          if args.lastStage ~= nil then
            window:Act23SG_TryLoacteStage(args.lastStage)
          elseif args.performData then
            local id = args.performData.id
            local para = args.performData.para
            window:PlayAct23GSMapPerform(id, para)
          end
        end
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.MiniGame] = function(entity)
    local webLink = ConfigData.game_config.steinsGateH5Url
    if webLink then
      local actData = eActInteract.__GetActData()
      local actId = actData:GetActId()
      local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
      saveUserData:SetSteinsGateH5MiniGameLooked(actId)
      actData:RefreshRedSteinsGate_H5MiniGame()
      CS_Application.OpenURL(webLink)
    end
  end,
  [eActInteract.eLbIntrctActionId.RepeatDg] = function(entity, args)
    local actData = eActInteract.__GetActData()
    local actDungeonCollect = actData:GetSteinsGateRepeatDgData()
    
    local function battleReturnFunc()
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
      if ctrl then
        local unlockFunc = eActInteract.eUnlockIntrctFunc[eActInteract.eLbIntrctActionId.RepeatDg]
        if unlockFunc and not unlockFunc() then
          return
        end
        ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.RepeatDg)
      end
    end
    
    local isAsSub = false
    if args ~= nil then
      isAsSub = args.isAsSub
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.SteinsGateRepeat, function(win)
      if win == nil then
        return
      end
      if not isAsSub then
        ActLbUtil.OnActLbInteractEnter(true)
      else
        UIManager:HideWindow(UIWindowTypeID.Activity23SteinsGateChapterMap)
      end
      win:InitSteinsGateRepeat(actDungeonCollect, function()
        if not isAsSub then
          ActLbUtil.OnActLbInteractEnter(false)
        else
          UIManager:ShowWindowOnly(UIWindowTypeID.Activity23SteinsGateChapterMap)
        end
      end, battleReturnFunc)
      local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
      if aftertTeatmentCtrl ~= nil then
        aftertTeatmentCtrl:TeatmentBengin()
      end
    end)
  end,
  [eActInteract.eLbIntrctActionId.Brotato] = function(entity)
    local actCtrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    local actData = eActInteract.__GetActData()
    if not actCtrl then
      return
    end
    local mainCfg = actData:GetSteinsGateCfg()
    if mainCfg == nil then
      return
    end
    local brotatoId = mainCfg.game_brotato
    if not actData:IsActivityRunning() then
      return
    end
    local actId = actData:GetActId()
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetSteinsGateBrotatoLooked(actId)
    actData:RefreshRedSteinsGate_Brotato()
    local endtime = actData:GetActivityEndTime()
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    ActLbUtil.OnActLbInteractEnter(true)
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:InitBrotatoLobbyCtrl(endtime, brotatoId, realReturnFunc)
    local brotatoData = activityBrotatoLobbyCtrl:GetBrotatoData(brotatoId)
    if brotatoData ~= nil then
    end
    activityBrotatoLobbyCtrl:ShowBrotatoLobbyUIMain(brotatoId, actCtrl:GetIsOpenByResultWithBrotato())
    actCtrl:SetIsOpenByResultWithBrotato(false)
    UIManager:DeleteWindow(UIWindowTypeID.SteinsGateCommonMask, true)
    UIManager:DeleteWindow(UIWindowTypeID.UI23SteinsGateScenesLoading, true)
  end,
  [eActInteract.eLbIntrctActionId.CardSet] = function(entity)
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return
    end
    local steinsGate23Data = eActInteract.__GetActData()
    ActLbUtil.OnActLbInteractEnter(true)
    
    local function returnActLbfunc()
      local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
      if ctrl then
        local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
        if actCardSetData == nil or not actCardSetData:IsActivityRunning() then
          return
        end
        local _cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
        if _cardSetActCtrl ~= nil then
          _cardSetActCtrl:ForceActCardSetNextIsReturn()
          ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.CardSet)
        end
      end
    end
    
    cardSetActCtrl:OpenActCardSetUI(false, steinsGate23Data, function()
      ActLbUtil.OnActLbInteractEnter(false)
    end, returnActLbfunc)
  end,
  [eActInteract.eLbIntrctActionId.Task] = function(entity)
    local actData = eActInteract.__GetActData()
    local dailyTaskData = actData:GetSteinsGateDailyTaskData()
    local termTaskData = actData:GetSteinsGateTermTaskData()
    if dailyTaskData == nil then
      if isGameDev then
        warn(" daily task not open ")
      end
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.UI23SteinsGateTask, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitWinter23Task(actData:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.GachaponShop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local mainCfg = actData:GetSteinsGateCfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.UI23SteinsGateGachaponShop, function(window)
      if window == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitUI23SteinsGateGachaponShop(actData, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Interact] = function(entity)
    if IsNull(entity.gameObject) then
      error("entity.gameObject is nil")
      return
    end
    local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    if not steinsGate23Ctrl then
      return
    end
    local actData = eActInteract.__GetActData()
    local intrctData = entity:GetLbIntrctEntData()
    local heroId = intrctData:GetLbIntrctObjHeroId()
    local objId = intrctData:GetLbIntrctObjId()
    local success = steinsGate23Ctrl:CheckAndTalk(actData:GetActId(), heroId, objId, function(isFinish, interactId)
      ActLbUtil.UpdLbCurInteractList()
      ActLbUtil.OnActLbInteractEnter(false)
      if not isFinish then
        warn("cant interact,id:" .. tostring(interactId))
        return
      end
      InteractLobbyFunc()
      local storyLineCfg = actData:GetSteinsGateStoryLineCfgByInteractId(interactId)
      if storyLineCfg.interact_perform ~= 0 then
        Act23SGPerformUtil.PerformFuncDic[storyLineCfg.interact_perform](storyLineCfg, true)
      end
    end)
    if success then
      ActLbUtil.OnActLbInteractEnter(true)
    end
  end
}
eActInteract.eActIntrctActionUIInitFunc = {
  [eActInteract.eLbIntrctActionId.Interact] = function(uiItem, entity, actionCfg)
    local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
    if not steinsGate23Ctrl then
      return
    end
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return
    end
    local intrctData = entity:GetLbIntrctEntData()
    local heroId = intrctData:GetLbIntrctObjHeroId()
    local objId = intrctData:GetLbIntrctObjId()
    local interactCfg, cantTalk = actData:GetSteinsGateInteractData():GetNowCfgByHeroIdOrObjId(heroId, objId)
    if cantTalk or interactCfg == nil then
      uiItem.gameObject:SetActive(false)
      return
    end
    local isTalk = ConfigData.activity_23steinsgate_interact_icon[interactCfg.id] and ConfigData.activity_23steinsgate_interact_icon[interactCfg.id].is_talk or false
    uiItem:SetInteractIsTalk(isTalk)
    local name
    if 0 < heroId then
      local heroCfg = ConfigData.hero_data[heroId]
      name = LanguageUtil.GetLocaleText(heroCfg.name)
    end
    uiItem:SetSGInteractDes(name)
  end
}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    return actData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.RepeatDg] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    local actDungeonCollect = actData:GetSteinsGateRepeatDgData()
    if not actDungeonCollect:IsDgLevelCollectUnlock() then
      return false
    end
    return actData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.CardSet] = function(lbIntrctData)
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return false
    end
    local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
    if actCardSetData == nil or not actCardSetData:GetActivityIsUnlock() then
      return false
    end
    return actCardSetData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.GachaponShop] = function(lbIntrctData)
    return true
  end,
  [eActInteract.eLbIntrctEntityId.Brotato] = function(lbIntrctData)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    return actData:IsActivityRunning()
  end
}
eActInteract.eActIntrctActionLockClickTipFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    if not actData:IsActivityRunning() then
      return ConfigData:GetTipContent(6033)
    end
    return ConfigData:GetTipContent(250)
  end,
  [eActInteract.eLbIntrctActionId.RepeatDg] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    local actDungeonCollect = actData:GetSteinsGateRepeatDgData()
    if not actData:IsActivityRunning() then
      return ConfigData:GetTipContent(6033)
    end
    if not actDungeonCollect:IsDgLevelCollectUnlock() then
      return actData:GetSteinsGateLockTipByType(eActInteract.eLbIntrctEntityId.RepeatDg)
    end
    return ConfigData:GetTipContent(250)
  end,
  [eActInteract.eLbIntrctActionId.Brotato] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    if actData == nil then
      return false
    end
    local playEndTime = actData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return ConfigData:GetTipContent(6033)
    end
    return ConfigData:GetTipContent(250)
  end,
  [eActInteract.eLbIntrctEntityId.CardSet] = function(entity, actionCfg)
    local actData = eActInteract.__GetActData()
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return actData:GetSteinsGateLockTipByType(eActInteract.eLbIntrctEntityId.CardSet)
    end
    local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
    if actCardSetData == nil then
      local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
      local steinsGateCardSetCfg = ConfigData.activity[ActivityFrameEnum.eActivityId.SteinsGateCardSet]
      if steinsGateCardSetCfg == nil then
        error("cant find activity cfg,id=" .. ActivityFrameEnum.eActivityId.SteinsGateCardSet)
        return
      end
      local startTime = steinsGateCardSetCfg.start_time
      local timeDate = TimeUtil:TimestampToDate(startTime, nil, true)
      if steinsGateCardSetCfg.rewardEnd_time > 0 and PlayerDataCenter.timestamp >= steinsGateCardSetCfg.rewardEnd_time then
        return ConfigData:GetTipContent(6033)
      end
      return ConfigData:GetTipContent(426, timeDate.month, timeDate.day)
    elseif actCardSetData:GetActivityIsUnlock() then
      if not actCardSetData:IsActivityRunning() then
        return ConfigData:GetTipContent(6033)
      end
    else
      local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
      local steinsGateCardSetCfg = ConfigData.activity[ActivityFrameEnum.eActivityId.SteinsGateCardSet]
      if steinsGateCardSetCfg == nil then
        error("cant find activity cfg,id=" .. ActivityFrameEnum.eActivityId.SteinsGateCardSet)
        return
      end
      if steinsGateCardSetCfg.rewardEnd_time > 0 and PlayerDataCenter.timestamp >= steinsGateCardSetCfg.rewardEnd_time then
        return ConfigData:GetTipContent(6033)
      else
        return actData:GetSteinsGateLockTipByType(eActInteract.eLbIntrctEntityId.CardSet)
      end
    end
    return ConfigData:GetTipContent(250)
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local unlockFunc = eActInteract.eUnlockIntrctFunc[eActInteract.eLbIntrctEntityId.Main]
    if unlockFunc and not unlockFunc() then
      return false
    end
    local steinsGate23Data = eActInteract.__GetActData()
    local sgStoryData = steinsGate23Data:GetSteinsGateStotyData()
    local curNode = sgStoryData:GetCurNode()
    if curNode:Act23GSSN_GetIsClear() then
      return false
    end
    return true
  end,
  [eActInteract.eLbIntrctActionId.CardSet] = function(entity)
    local unlockFunc = eActInteract.eUnlockIntrctFunc[eActInteract.eLbIntrctEntityId.CardSet]
    if unlockFunc and not unlockFunc() then
      return false
    end
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return false
    end
    local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
    local redDotRoot = actCardSetData:GetActivityReddot()
    local taskCompleteNode = redDotRoot:GetChild(CardSetEnum.reddotType.rankTask)
    if taskCompleteNode ~= nil and taskCompleteNode:GetRedDotCount() > 0 then
      return true
    end
    local taskfirstNode = redDotRoot:GetChild(CardSetEnum.reddotType.firstEnterTaskBlue)
    if taskfirstNode ~= nil and taskfirstNode:GetRedDotCount() > 0 then
      return true
    end
  end,
  [eActInteract.eLbIntrctActionId.Task] = function(entity)
    local steinsGate23Data = eActInteract.__GetActData()
    local reddot = steinsGate23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(Act23SteinsGateEnum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(Act23SteinsGateEnum.reddotType.OnceTask)
    if childReddot == nil then
      return false
    end
    return childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.MiniGame] = function(entity)
    local steinsGate23Data = eActInteract.__GetActData()
    local reddot = steinsGate23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(Act23SteinsGateEnum.reddotType.H5MiniGame)
    if childReddot == nil then
      return false
    end
    return childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Brotato] = function(entity)
    local steinsGate23Data = eActInteract.__GetActData()
    local reddot = steinsGate23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(Act23SteinsGateEnum.reddotType.Brotato)
    if childReddot == nil then
      return false
    end
    return childReddot:GetRedDotCount() > 0
  end
}

local function lobbySpecialFunc(actLbCtrl)
  local lobbyId = actLbCtrl:GetActLobbyIndex()
  local sexCfg = ConfigData.activity_23steinsgate_professor_sex[lobbyId]
  local isGirl = PlayerDataCenter.inforData:GetSex()
  if sexCfg then
    local proId = sexCfg.obj_id
    local pro = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(proId)
    if pro ~= nil and not IsNull(pro.transform) then
      pro:SetRenderHide(isGirl)
      local proTran = pro.transform:Find("professor_boy")
      if not IsNull(proTran) then
        proTran.gameObject:SetActive(not isGirl)
      end
    end
    local go
    local parentObjPath = sexCfg.parent_obj
    if not string.IsNullOrEmpty(parentObjPath) then
      local parentGo = CS_GameObject.Find(parentObjPath)
      go = parentGo.transform:Find(sexCfg.female_obj).gameObject
    else
      go = CS_GameObject.Find(sexCfg.female_obj)
    end
    if not IsNull(go) then
      go:SetActive(isGirl)
    end
  end
end

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  actLbCtrl:SetLobbyBgmPause(false)
  local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
  if not steinsGate23Ctrl then
    return
  end
  steinsGate23Ctrl:PlaySGSceneLoadedFunc()
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    win:SetTaskFunc(nil, nil)
    local actFrameId = ActLbUtil.GetCurActLbActId()
    if actFrameId then
      win:InitJumpFuncByActivityFrameId(actFrameId)
    end
    win:RefreshMissonReddot()
  end)
  actLbCtrl:SetCmderObjShow(false)
  local graph = CS.AstarPath.active.data.recastGraph
  graph:Scan()
  actLbCtrl:SetCmderObjShow(true)
  local movieWin = UIManager:GetWindow(UIWindowTypeID.MoviePlayer)
  if movieWin and movieWin.active then
    movieWin:SetUIMaskOpen(false)
  end
  local steinsGateData = eActInteract.__GetActData()
  CreateUIWhenEnterFinish(steinsGateData)
  lobbySpecialFunc(actLbCtrl)
  InteractLobbyFunc()
  local reddot = steinsGateData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
end

local function LobbyMainIsShow()
  local win = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  if win and win.active then
    return true
  end
  return false
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
  if not steinsGate23Ctrl then
    return
  end
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local steinsGate23Data = eActInteract.__GetActData()
  local storyLineCfg = steinsGate23Data:GetNowSteinsGateStoryLineCfg()
  ShowLobbyEffectFunc()
  RefreshTipFunc()
  local isChangeLobby = true
  if storyLineCfg.win_perform == Act23SteinsGateEnum.performType.WorldLineSwitchAndChangeLobby then
    local para = storyLineCfg.win_para
    local lobbyId = para[1]
    local worldLineId = para[2]
    local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if lobbyCtrl == nil or lobbyCtrl:GetActLobbyIndex() == lobbyId then
    else
      steinsGate23Ctrl:RecordSteinsGateWorldLineChange(storyLineCfg.id, lobbyId)
      if storyLineCfg.win_perform ~= 0 then
        Act23SGPerformUtil.PerformFuncDic[storyLineCfg.win_perform](storyLineCfg, false)
      end
      return
    end
  else
    isChangeLobby = false
  end
  steinsGate23Ctrl:RunEnterCompleteFunc()
  steinsGate23Ctrl:InitSteinsGatePerform()
  if not isChangeLobby and storyLineCfg.win_perform ~= 0 then
    steinsGate23Ctrl:InsertSteinsGatePerform(function()
      Act23SGPerformUtil.PerformFuncDic[storyLineCfg.win_perform](storyLineCfg, false)
    end)
  elseif steinsGate23Ctrl:IsNeedPlayCmderTimeLine() then
    steinsGate23Ctrl:InsertSteinsGatePerform(function()
      local function closeFunc(isEnter)
        ActLbUtil.OnActLbInteractEnter(isEnter)
        
        if isEnter then
          UIUtil.AddOneCover("SGCmderTimeLine")
        else
          UIUtil.CloseOneCover("SGCmderTimeLine")
        end
      end
      
      steinsGate23Ctrl:TryPlayCmderTimeLine(closeFunc)
    end)
  end
  if isNeedPlayUnlock() then
    steinsGate23Ctrl:InsertSteinsGatePerform(function()
      eActInteract.TryOpenUnlockWin()
    end)
  end
  local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
  if aftertTeatmentCtrl ~= nil then
    aftertTeatmentCtrl:BindResultAfterAction(function()
      if LobbyMainIsShow() then
        steinsGate23Ctrl:RunSteinsGatePerform()
      end
    end)
    return
  end
  if LobbyMainIsShow() and steinsGate23Ctrl:IsEmptySteinsGatePerformQueue() then
    local actData = eActInteract.__GetActData()
    local actId = actData:GetActId()
    steinsGate23Ctrl:TryReShowSteinsGateMap(actId)
    return
  end
  if LobbyMainIsShow() then
    steinsGate23Ctrl:RunSteinsGatePerform()
  end
end

function eActInteract.OnActLbInteractEnterFunc(isEnter, isEye)
  local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
  local steinsGate23Data = eActInteract.__GetActData()
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
    UIManager:HideWindow(UIWindowTypeID.UISteinsGate23Interactive)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    UIManager:ShowWindowOnly(UIWindowTypeID.UISteinsGate23Interactive)
    eActInteract.OnActCamChangeFunc()
    local infoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
    if infoWin then
      infoWin:UpdUIActLbFollowInfoExternalShowUI()
    end
  end
  if not isEnter then
    RefreshTipFunc()
    steinsGate23Ctrl:RunSteinsGatePerform()
    local unlockWin = UIManager:GetWindow(UIWindowTypeID.UI23SteinsGateUnlock)
    if unlockWin then
      UIManager:ShowWindow(UIWindowTypeID.UI23SteinsGateUnlock)
      eActInteract.TryOpenUnlockWin()
    end
  end
  if isEye then
    return
  end
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actCtrl then
    local effectCtrl = actCtrl.actLbEffectCtrl
    effectCtrl:SetLbEffectPause(isEnter)
  end
end

function eActInteract.OnActCamChangeFunc()
  local interactWin = UIManager:GetWindow(UIWindowTypeID.UISteinsGate23Interactive)
  if interactWin and interactWin.active then
    interactWin:UpdateInteractive()
  end
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
  RefreshTipFunc()
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
  if not steinsGate23Ctrl then
    return
  end
  local steinsGate23Data = eActInteract.__GetActData()
  if steinsGate23Data ~= nil then
    local reddot = steinsGate23Data:GetActivityReddot()
    if reddot == nil then
      return
    end
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
