local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local ActivityAnniversary23Enum = require("Game.ActivityAnniversary23.Data.ActivityAnniversary23Enum")
local CS_GameObject = CS.UnityEngine.GameObject
local CS_PlayableDirector = CS.UnityEngine.Playables.PlayableDirector
local cs_DoTween = CS.DG.Tweening.DOTween
eActInteract.eLbIntrctEntityId = {
  Board = 1,
  Main = 2,
  Card = 3,
  Shop = 4,
  MainStory = 5,
  TechTree = 6
}
eActInteract.eLbIntrctActionId = {
  None = 0,
  Board = 1,
  Main = 2,
  Card = 3,
  Shop = 4,
  MainStory = 5,
  TechTree = 6
}

function eActInteract.__GetActData()
  local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if not anniversary23Ctrl then
    return
  end
  local actFrameId = ActLbUtil.GetCurActLbActId()
  return anniversary23Ctrl:GetActAnniversary23DataByFrameId(actFrameId)
end

eActInteract.eMissonBtn = {
  Task = 1,
  ActivityBP = 2,
  FlipCard = 3,
  LotteryJump = 4
}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local anniversary23Data = eActInteract.__GetActData()
    local dailyTaskData = anniversary23Data:GetAnniversary23DailyTaskData()
    local termTaskData = anniversary23Data:GetAnniversary23TermTaskData()
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
      win:InitWinter23Task(anniversary23Data:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
local MissonBtnRedFunc = {
  [eActInteract.eMissonBtn.Task] = function()
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityAnniversary23Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivityAnniversary23Enum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eMissonBtn.FlipCard] = function()
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityAnniversary23Enum.reddotType.Jump2)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end,
  [eActInteract.eMissonBtn.ActivityBP] = function()
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    if reddot == nil then
      return false
    end
    local childReddot = reddot:GetChild(ActivityAnniversary23Enum.reddotType.Jump1)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    return false
  end
}

local function CreateUIWhenEnterFinish(springData)
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
  [eActInteract.eLbIntrctActionId.Main] = function(entity)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if not anniversary23Ctrl then
      return
    end
    local actFrameId = ActLbUtil.GetCurActLbActId()
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
      win:InitEpCommonModeSelect(actFrameId, BindCallback(anniversary23Ctrl, anniversary23Ctrl.EnterAnniversaryEp), BindCallback(anniversary23Ctrl, anniversary23Ctrl.EnterAnniversaryEpQuickBattle), function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Card] = function(entity)
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return
    end
    local anniversary23Data = eActInteract.__GetActData()
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
          ctrl.actLbIntrctCtrl:InvokeActLbEntity(eActInteract.eLbIntrctEntityId.Card)
        end
      end
    end
    
    cardSetActCtrl:OpenActCardSetUI(false, anniversary23Data, function()
      ActLbUtil.OnActLbInteractEnter(false)
    end, returnActLbfunc)
  end,
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local anniversary23Data = eActInteract.__GetActData()
    local mainCfg = anniversary23Data:GetAnniversary23Cfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winrwe23Shop, function(window)
      if window == nil then
        return
      end
      window:BindRedShopFunc(function(shopId)
        return not anniversary23Data:IsAnniversary23ShopLooked(shopId)
      end)
      window:BindSelectShopFunc(function(shopId)
        anniversary23Data:SetAnniversary23ShopLooked(shopId)
      end)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitSum22ShopByShopList(anniversary23Data, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Board] = function(entity)
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function()
    local anniData = eActInteract.__GetActData()
    local mainCfg = anniData:GetAnniversary23Cfg()
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
  end,
  [eActInteract.eLbIntrctActionId.TechTree] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local anniversary23Data = eActInteract.__GetActData()
    local actTechTree = anniversary23Data:GetAnniversary23TechTree()
    local specialBranchId = ConfigData.activity_tech_type[anniversary23Data:GetActFrameId()].tech_special_branch
    UIManager:ShowWindowAsync(UIWindowTypeID.Winter23StrategyOverview, function(window)
      if window == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitChristmas22StrategyOverview(actTechTree, specialBranchId, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end)
    end)
  end
}
eActInteract.eActIntrctActionUIInitFunc = {}
eActInteract.eSubNameFuncs = {}
eActInteract.eUnlockIntrctFunc = {
  [eActInteract.eLbIntrctEntityId.Main] = function(lbIntrctData)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    return anniversary23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Card] = function(lbIntrctData)
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return false
    end
    local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
    return actCardSetData and actCardSetData:GetActivityEndTime() > PlayerDataCenter.timestamp and actCardSetData:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.TechTree] = function(lbIntrctData)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    return anniversary23Data:IsActivityRunning()
  end,
  [eActInteract.eLbIntrctEntityId.Shop] = function(lbIntrctData)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    return true
  end
}
local storyBpId = 1
local textShowTime = 0.5
eActInteract.eSpecialOpeEntInfoFunc = {
  [eActInteract.eLbIntrctActionId.None] = function(entInfoItem)
    local ui = entInfoItem:GetEntiUI()
    ui.avgProgressNode:SetActive(false)
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entInfoItem)
    local ui = entInfoItem:GetEntiUI()
    ui.avgProgressNode:SetActive(true)
    local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleActivityStoryBP, storyBpId)
    local alNum = counterElem and counterElem.times or 0
    local storyList = ConfigData.activity_general_story_bp[storyBpId].story_id
    local lastStoryId, storyIndex
    local realNeedNum = 0
    local lastTargetNum = 0
    for i, storyId in ipairs(storyList) do
      local avgCfg = ConfigData.story_avg[storyId]
      if not avgCfg then
        error("avg Id:" .. tostring(storyId) .. "not have avg")
      end
      local needNum = avgCfg.pre_para2[1] or 0
      realNeedNum = needNum
      if alNum < needNum then
        break
      end
      lastStoryId = storyId
      storyIndex = i
    end
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    local needFresh, isChange = anniversary23Ctrl:IsNeedRefreshText(alNum, realNeedNum)
    local value = math.clamp(alNum * 100 // realNeedNum, 0, 100)
    local str = tostring(value) .. "%"
    if not needFresh then
      ui.tex_Progress.text = tostring(value) .. "%"
      return
    end
    if not isChange then
      ui.tex_Progress.text = ""
      ui.tex_Progress:DOKill()
      ui.tex_Progress:DOText(str, textShowTime):SetLink(ui.tex_Progress.gameObject)
      return
    end
    local sequence = anniversary23Ctrl:GetStoryChangeSequence()
    
    local function continueFunc(isJump)
      if isJump then
        anniversary23Ctrl:ClearStoryChangeSequence()
        ui.tex_Progress.text = tostring(value) .. "%"
      else
        ui.tex_Progress.text = ""
        ui.tex_Progress:DOKill()
        sequence:Play()
      end
      anniversary23Ctrl:ChangeTimeLineState(false, 2)
    end
    
    sequence:AppendCallback(function()
      UIUtil.AddOneCover("storyBp")
      anniversary23Ctrl:TryPlayStarChapterTimeLine()
      ui.tex_Progress.text = ""
      ui.tex_Progress:DOKill()
    end)
    sequence:Append(ui.tex_Progress:DOText("100%", textShowTime):SetLink(ui.tex_Progress.gameObject))
    sequence:AppendInterval(textShowTime)
    sequence:AppendCallback(function()
      anniversary23Ctrl:ChangeTimeLineState(true)
      sequence:Pause()
      UIUtil.CloseOneCover("storyBp")
      UIManager:ShowWindowAsync(UIWindowTypeID.ActivityAnniversary23Unlock, function(win)
        if not win then
          return
        end
        win:InitAnniversary23Unlock(storyList, storyIndex, lastStoryId, function()
          continueFunc(false)
        end, function()
          continueFunc(true)
          eActInteract.eIntrctFuncs[eActInteract.eLbIntrctActionId.MainStory]()
        end)
      end)
    end)
    sequence:Append(ui.tex_Progress:DOText(str, textShowTime):SetLink(ui.tex_Progress.gameObject))
  end
}
eActInteract.eActIntrctActionLockStateDesFunc = {
  [eActInteract.eLbIntrctActionId.Main] = function(entity, actionCfg)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    local playEndTime = anniversary23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.Card] = function(entity, actionCfg)
    local cardSetActCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCardSet)
    if cardSetActCtrl == nil then
      return
    end
    local actCardSetData = cardSetActCtrl:GetOneActCardSetData()
    local playEndTime = actCardSetData:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctActionId.TechTree] = function(entity)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    local playEndTime = anniversary23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.Shop)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.TechTree] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot1 = reddot:AddChild(ActivityAnniversary23Enum.reddotType.Tech)
    local childReddot2 = reddot:AddChild(ActivityAnniversary23Enum.reddotType.TechItemLimit)
    return childReddot1 ~= nil and childReddot1:GetRedDotCount() > 0 or childReddot2 ~= nil and childReddot2:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.MainStory)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end
}

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if not anniversary23Ctrl then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    local actFrameId = ActLbUtil.GetCurActLbActId()
    if actFrameId then
      win:InitJumpFuncByActivityFrameId(actFrameId)
    end
    win:SetBtnReddotFunc(eActInteract.eMissonBtn.FlipCard - 1, MissonBtnRedFunc[eActInteract.eMissonBtn.FlipCard])
    win:SetBtnReddotFunc(eActInteract.eMissonBtn.ActivityBP - 1, MissonBtnRedFunc[eActInteract.eMissonBtn.ActivityBP])
    win:RefreshMissonReddot()
  end)
  local springData = eActInteract.__GetActData()
  CreateUIWhenEnterFinish(springData)
  local reddot = springData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  while UIManager:GetWindow(UIWindowTypeID.Spring23Misson) == nil do
    coroutine.yield(nil)
  end
  local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if not anniversary23Ctrl then
    return
  end
  anniversary23Ctrl:RunEnterCompleteFunc()
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    local infoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
    if infoWin then
      infoWin:UpdUIActLbFollowInfoExternalShowUI()
    end
  end
end

function eActInteract.OnActCamChangeFunc()
end

function eActInteract.OnLbActivityRunningTimeoutFunc(actLbCtrl)
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
end

function eActInteract.OnLbActivityFinishedFunc(actLbCtrl)
end

function eActInteract.OnActLbExitFunc(actLbCtrl)
  local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if not anniversary23Ctrl then
    return
  end
  anniversary23Ctrl:ClearStoryChangeSequence()
  anniversary23Ctrl:ClearPlayableDir()
  local anniversary23Data = eActInteract.__GetActData()
  if anniversary23Data ~= nil then
    local reddot = anniversary23Data:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
  end
end

return eActInteract
