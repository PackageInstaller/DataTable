local eActInteract = {}
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")
local ActivityAnniversary23Enum = require("Game.ActivityAnniversary23.Data.ActivityAnniversary23Enum")
local cs_MessageCommon = CS.MessageCommon

function eActInteract.__GetActData()
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if not actCtrl then
    return
  end
  local actFrameId = ActLbUtil.GetCurActLbActId()
  return actCtrl:GetActAnniversary23DataByFrameId(actFrameId)
end

eActInteract.eMissonBtn = {Task = 1, ActivityBP = 2}
local MissonBtnOpenFunc = {
  [eActInteract.eMissonBtn.Task] = function(isFirstSelectTermTask)
    local actData = eActInteract.__GetActData()
    local dailyTaskData = actData:GetAnniversary23DailyTaskData()
    local termTaskData = actData:GetAnniversary23TermTaskData()
    if dailyTaskData == nil then
      if isGameDev then
        warn("daily task not open")
      end
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.UI24WinterTask, function(win)
      if win == nil then
        return
      end
      ActLbUtil.OnActLbInteractEnter(true)
      win:InitAnniversary23Task(actData:GetActFrameId(), dailyTaskData, termTaskData, function()
        ActLbUtil.OnActLbInteractEnter(false)
      end, isFirstSelectTermTask)
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
    local childReddot = reddot:GetChild(ActivityAnniversary23Enum.reddotType.DailyTask)
    if childReddot ~= nil and childReddot:GetRedDotCount() > 0 then
      return true
    end
    childReddot = reddot:GetChild(ActivityAnniversary23Enum.reddotType.OnceTask)
    return childReddot:GetRedDotCount() > 0
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
eActInteract.eLbIntrctActionId = {
  None = 0,
  Board = 1,
  Main = 2,
  HardLevel = 3,
  Tower = 4,
  Brotato = 5,
  Guard = 6,
  MainStory = 7,
  Shop = 8,
  MonsterCard = 9
}
eActInteract.eLbIntrctEntityId = {
  Board = 1,
  Main = 2,
  HardLevel = 3,
  Tower = 4,
  Brotato = 5,
  Guard = 6,
  MainStory = 7,
  Shop = 8,
  MonsterCard = 9
}
eActInteract.eIntrctFuncs = {
  [eActInteract.eLbIntrctActionId.Board] = function()
  end,
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
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end,
  [eActInteract.eLbIntrctActionId.HardLevel] = function()
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    local hardLevelPlayData = anniversary23Data:GetCommonHardLevelPlayData()
    local rankId = hardLevelPlayData:AHLPD_GetRankId()
    local objNetwork = NetworkManager:GetNetwork(NetworkTypeID.Object)
    objNetwork:CS_Rank_Detail(rankId, 0, function(args)
      if not args then
        return
      end
      local msg = args[0]
      UIManager:CreateWindowAsync(UIWindowTypeID.CommonHardLevel, function(win)
        if win == nil then
          return
        end
        ActLbUtil.OnActLbInteractEnter(true)
        win:InitActCommonHardLevel(hardLevelPlayData, msg.myRank, function()
          ActLbUtil.OnActLbInteractEnter(false)
        end, function()
          anniversary23Data:RefreshtHardLevelRedDot()
        end)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Tower] = function()
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if not anniversary23Ctrl then
      return
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    local curSeasonId = anniversary23Data:GetAnvsr23WarchessSeasonId()
    local isUnComplete, unCompleteData = WarChessSeasonManager:GetUncompleteWCSData()
    if isUnComplete then
      if unCompleteData.seasonId == curSeasonId then
        anniversary23Ctrl:ContinueAnvsr23Season()
        return
      end
      SectorStageDetailHelper.IsWarchessSeasonNoCollide(curSeasonId, true, true)
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    anniversary23Ctrl:EnterActAnvsr23WarChessSeasonLevelSelect(function()
      ActLbUtil.OnActLbInteractEnter(false)
    end)
  end,
  [eActInteract.eLbIntrctActionId.Brotato] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    if not actData then
      return
    end
    local mainCfg = actData:GetAnniversary23Cfg()
    if mainCfg == nil then
      return
    end
    local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    local brotatoId = mainCfg.brotato_id
    local actId = actData:GetActId()
    local endtime = actData:GetActivityEndTime()
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    ActLbUtil.OnActLbInteractEnter(true)
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:InitBrotatoLobbyCtrl(endtime, brotatoId, realReturnFunc)
    activityBrotatoLobbyCtrl:ShowBrotatoLobbyUIMain(brotatoId, actCtrl:GetIsOpenByResultWithBrotato())
    actCtrl:SetIsOpenByResultWithBrotato(false)
  end,
  [eActInteract.eLbIntrctActionId.Guard] = function()
    local anniData = eActInteract.__GetActData()
    local mainCfg = anniData:GetAnniversary23Cfg()
    local sectorId = mainCfg.guard_sector_id
    
    local function realReturnFunc()
      ActLbUtil.OnActLbInteractEnter(false)
    end
    
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      return
    end
    ActLbUtil.OnActLbInteractEnter(true)
    UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
      if window == nil then
        return
      end
      window:InitSectorLevel(sectorId, realReturnFunc, 1)
      window:SetCustomExBattleStartCallback(function()
        ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      end)
    end)
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entInfoItem)
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
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local intrctData = entity:GetLbIntrctEntData()
    local unlock = intrctData:IsLbIntrctUnlock()
    if not unlock then
      return
    end
    local actData = eActInteract.__GetActData()
    local mainCfg = actData:GetAnniversary23Cfg()
    UIManager:ShowWindowAsync(UIWindowTypeID.Winrwe23Shop, function(window)
      if window == nil then
        return
      end
      window:BindRedShopFunc(function(shopId)
        return not actData:IsAnniversary23ShopLooked(shopId)
      end)
      window:BindSelectShopFunc(function(shopId)
        actData:SetAnniversary23ShopLooked(shopId)
      end)
      ActLbUtil.OnActLbInteractEnter(true)
      window:InitSum22ShopByShopList(actData, mainCfg.shop_list, mainCfg.token_item, function()
        ActLbUtil.OnActLbInteractEnter(false)
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
      actData:RefreshtMonsterCardRedDot()
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
  [eActInteract.eLbIntrctEntityId.Tower] = function(lbIntrctData)
    local anniversary23Data = eActInteract.__GetActData()
    local seasonId = anniversary23Data:GetAnvsr23WarchessSeasonId()
    local unlock = WarChessSeasonManager:IsWCSUnlock(seasonId)
    return anniversary23Data ~= nil and anniversary23Data:IsActivityRunning() and unlock
  end,
  [eActInteract.eLbIntrctEntityId.Brotato] = function(lbIntrctData)
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
  [eActInteract.eLbIntrctEntityId.Guard] = function(lbIntrctData)
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
  [eActInteract.eLbIntrctEntityId.HardLevel] = function(lbIntrctData)
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
  [eActInteract.eLbIntrctEntityId.MainStory] = function(lbIntrctData)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    return true
  end,
  [eActInteract.eLbIntrctEntityId.Shop] = function(lbIntrctData)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    return true
  end,
  [eActInteract.eLbIntrctEntityId.MonsterCard] = function(lbIntrctData)
    local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
    if anniversary23Ctrl == nil then
      return false
    end
    local anniversary23Data = eActInteract.__GetActData()
    if anniversary23Data == nil then
      return false
    end
    return true
  end
}
eActInteract.eActIntrctActionLockClickTipFunc = {
  [eActInteract.eLbIntrctActionId.Tower] = function(entity, actionCfg)
    local anniversary23Data = eActInteract.__GetActData()
    if not anniversary23Data:IsActivityRunning() then
      return nil
    end
    local seasonId = anniversary23Data:GetAnvsr23WarchessSeasonId()
    local unlock = WarChessSeasonManager:IsWCSUnlock(seasonId)
    if not unlock then
      return WarChessSeasonManager:GetWCSUnlockDes(seasonId)
    end
  end
}

local function CheckTagUIFunc(entityInfo, entityItem)
  local actData = eActInteract.__GetActData()
  local entityId = entityItem:GetLbInteractEntityId()
  local isShow, isMain = actData:CheckSpecialTaskCanMove2Entt(entityId)
  local tagId = isShow and (isMain and 1 or 2) or 0
  entityInfo:UpdActLbEntiInfoTag(tagId)
end

eActInteract.eSpecialOpeEntInfoFunc = {
  [eActInteract.eLbIntrctEntityId.Board] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.Main] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.HardLevel] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.Tower] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.Brotato] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.Guard] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.MainStory] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.Shop] = CheckTagUIFunc,
  [eActInteract.eLbIntrctEntityId.MonsterCard] = CheckTagUIFunc
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
  [eActInteract.eLbIntrctEntityId.Tower] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local playEndTime = anniversary23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end,
  [eActInteract.eLbIntrctEntityId.HardLevel] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local playEndTime = anniversary23Data:GetActivityEndTime()
    if playEndTime < PlayerDataCenter.timestamp then
      return 1
    end
    return 0
  end
}
eActInteract.eActIntrctActionShowBlueDotFunc = {
  [eActInteract.eLbIntrctEntityId.Tower] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.WCSEnvTask)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.MainStory)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.MonsterCard] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.MonsterCard)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.HardLevel] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.HardLevel)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.Shop] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.Shop)
    return childReddot ~= nil and childReddot:GetRedDotCount() > 0
  end,
  [eActInteract.eLbIntrctActionId.MainStory] = function(entity)
    local anniversary23Data = eActInteract.__GetActData()
    local reddot = anniversary23Data:GetActivityReddot()
    local childReddot = reddot:AddChild(ActivityAnniversary23Enum.reddotType.MainStory)
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

local function ExTaskJumpFunc(JumpArgs)
  local entityId = JumpArgs[3]
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return false
  end
  local entity = actLbCtrl.actLbIntrctCtrl:GetLbIntrctEntFxUnlockById(entityId)
  if entity == nil then
    return false
  end
  actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(entity)
  return true
end

function eActInteract.OnActLbSceneLoadedFunc(actLbCtrl)
  UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Misson, function(win)
    if win == nil then
      return
    end
    win:SetTaskFunc(MissonBtnOpenFunc[eActInteract.eMissonBtn.Task], MissonBtnRedFunc[eActInteract.eMissonBtn.Task])
    win:SetSpecialTaskJumpFunc(ExTaskJumpFunc)
    local actFrameId = ActLbUtil.GetCurActLbActId()
    local actData = eActInteract.__GetActData()
    if actFrameId then
      win:InitJumpFuncByActivityFrameId(actFrameId, actData)
    end
    win:SetBtnReddotFunc(eActInteract.eMissonBtn.ActivityBP - 1, MissonBtnRedFunc[eActInteract.eMissonBtn.ActivityBP])
    win:RefreshMissonReddot()
  end)
  local actData = eActInteract.__GetActData()
  local reddot = actData:GetActivityReddot()
  RedDotController:AddListener(reddot.nodePath, eActInteract.UpdateActivityReddotChange)
end

local storyBpId = 2

local function CheckPlayStoryUnLockSequence(winter24Ctrl, storyBpId)
  if winter24Ctrl:IsCanPlayStoryUnLockSequence(storyBpId) then
    UIManager:ShowWindowAsync(UIWindowTypeID.ActivityAnniversary23Unlock, function(win)
      if not win then
        return
      end
      local storyList = ConfigData.activity_general_story_bp[storyBpId].story_id
      win:PlayStoryUnLockSequence(storyList, eActInteract.eIntrctFuncs[eActInteract.eLbIntrctActionId.MainStory])
    end)
  end
end

function eActInteract.OnActLbStartShowEndCoFunc(actLbCtrl)
  local winter24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if not winter24Ctrl then
    return
  end
  winter24Ctrl:RunEnterCompleteFunc()
  CheckPlayStoryUnLockSequence(winter24Ctrl, storyBpId)
end

function eActInteract.OnActLbInteractEnterFunc(isEnter)
  local winter24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
  if isEnter then
    UIManager:HideWindow(UIWindowTypeID.Spring23Misson)
  else
    UIManager:ShowWindowOnly(UIWindowTypeID.Spring23Misson)
    local infoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
    if infoWin then
      infoWin:UpdUIActLbFollowInfoExternalShowUI()
    end
    local win = UIManager:GetWindow(UIWindowTypeID.Spring23Misson)
    if win then
      win:RefreshTipBoard()
      win:RefreshMissonReddot()
    end
    local isInTaskJump = winter24Ctrl:GetActTaskIsJump()
    if not isInTaskJump then
      CheckPlayStoryUnLockSequence(winter24Ctrl, storyBpId)
    end
  end
  winter24Ctrl:SetActTaskIsJump(false)
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
