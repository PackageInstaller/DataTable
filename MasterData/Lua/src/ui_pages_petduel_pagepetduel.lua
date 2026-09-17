local this = class("pagePetDuel", G_UIPageBase)
local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local worldSpawnerTpl = L_GameTpl:getWorldSpawnerTpl()
local commonConditionTpl = L_GameTpl:getCommonConditionTpl()
local templateValueTpl = L_GameTpl:getTemplateValueTpl()
local _kiboDuelMapTpl = L_GameTpl:getKiboDuelMapTpl()
local _areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()
local tipType = {
  Normal = 0,
  Error = 1,
  Rapid = 2
}
local KiboDuelProcedure = {
  None = 0,
  KiboDuel = 1,
  Nest = 2,
  Arena = 4
}
local animatorPlayDelay = {
  countdownShow = 0,
  cardListShow = 3.6497,
  cardShow1 = 3.65,
  cardShow2 = 3.7163,
  cardShow3 = 3.7997,
  cardShow4 = 4.0497,
  cardNextShow = 4.65,
  energyShow = 3.65,
  energyCellShow = 3.813,
  commonShow = 4.4167,
  hpShow = 4.55
}
local petOrdinaryPos = {
  [1] = {x = -309.8, y = 14.4},
  [2] = {x = -146.2, y = 22.2},
  [3] = {x = 14.9, y = 24.1},
  [4] = {x = 179.5, y = 18.3}
}
local descriptionOrdinaryPos = {
  [1] = {x = -258, y = 0},
  [2] = {x = -81, y = 0},
  [3] = {x = 81, y = 0},
  [4] = {x = 258, y = 0}
}
local feverEffectPath = "Effect/Scene/Kiboduel/pre_petduel_fever.prefab"
local CustomEventSelfInfoTip = "selfInfoTip"
local CustomEventOtherInfoTip = "otherInfoTip"

function this.bind()
  return {
    timeText = "300",
    playerNameText = "",
    enemyNameText = "",
    playerHpTxt = "",
    enemyHpTxt = "",
    img_currentCostNum = "",
    img_maxCostNum = "",
    costList = {
      moduleName = "pages/petDuel/cellDuelCostItem"
    },
    petList = {
      moduleName = "pages/petDuel/cellIconPetDuel"
    },
    nextPet = {
      moduleName = "pages/petDuel/cellIconPetDuel"
    },
    summonBtnNodeActive = false,
    skillBtnNodeActive = false,
    fightTipActive = false,
    toggle_fightTip = 0,
    fightTipText = "",
    eSkill = {
      moduleName = "pages/petDuel/cellKiBoDuelSkill"
    },
    rSkill = {
      moduleName = "pages/petDuel/cellKiBoDuelSkill"
    },
    skillBtnNodeMobileActive = false,
    eSkillMobile = {
      moduleName = "pages/petDuel/cellKiBoDuelSkill"
    },
    rSkillMobile = {
      moduleName = "pages/petDuel/cellKiBoDuelSkill"
    },
    dodgeMount = {
      moduleName = "pages/petDuel/cellKiboDuelDodge"
    },
    btnDogeActive = true,
    mobileSkillBtnNode = false,
    kiBoDescription = {
      moduleName = "pages/petDuel/moduleKiBoDescription"
    },
    rect_kiBoDescription = C_Vector2(0, 0),
    summonNotify = {
      moduleName = "pages/petDuel/moduleSummonNotify"
    },
    summonNotifyModuleActive = true,
    moduleKiBoList = {
      moduleName = "pages/petDuel/moduleKiboList"
    },
    moduleDuelResult = {
      moduleName = "pages/petDuel/moduleDuelResult"
    },
    active_statistics = false,
    moduleDuelSKill = {
      moduleName = "pages/petDuel/moduleDuelSkillRelease"
    },
    moduleDuelTarget = {
      moduleName = "pages/petDuel/moduleDuelTarget"
    },
    boardActive = true,
    go_leftContent = true,
    go_helpContent = false,
    txt_buffDesc = "",
    mobileResultDebugActive = false,
    rotate_minimap = C_Vector3(0, 0, 0),
    tran_starts = C_Vector2(162, -68),
    alpha_energy = 1,
    go_mobileSummonNode = false,
    go_moduleDuelHealthy = true,
    go_mobileMoveBlock = false,
    go_moduleBattleEffectRoot = nil,
    go_moduleBossHpList = nil,
    go_socialRoulette = nil,
    interactable_buttonContent = true,
    go_BtnExitCopy = nil,
    go_petList = nil,
    go_autoBtn = nil,
    go_autoLock = nil,
    go_autoNormal = nil,
    go_autoSelect = nil,
    go_cancelAutoBtn = nil,
    go_skillLayout = nil,
    camHighOn = false,
    camHighOff = true,
    camLowOn = true,
    camLowOff = false
  }
end

function this.methods()
  return {
    onClick_Exit = function(self)
      self:onClickEscBtn()
    end,
    onClick_ExitCopy = function(self)
      self:onClickEscBtn()
    end,
    onClick_dogeBtn = function(self)
      if not self.duelStar then
        return
      end
      L_PlayerManager:fireEvade()
    end,
    onClick_summonBtn = function(self)
      C_KiboDuelSystemMgr:HandleKiBoSummonConfirm()
    end,
    onClick_summonCancleBtn = function(self)
      C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
    end,
    onClick_Jump = function(self)
      if not self.duelStar then
        return
      end
    end,
    onClick_eSkill = function(self)
      if C_KiboDuelSystemMgr:GetIsPlayAnimation() or not self.duelStar then
        return
      end
      C_KiboDuelSystemMgr:ChangeSkillStatus(L_Const.skillType.KiBoVersusCommonSkill1, C_EKiboDuelSkillStatus.WaitConfirm)
    end,
    onClick_rSkill = function(self)
      if C_KiboDuelSystemMgr:GetIsPlayAnimation() or not self.duelStar then
        return
      end
      C_KiboDuelSystemMgr:ChangeSkillStatus(L_Const.skillType.KiBoVersusCommonSkill2, C_EKiboDuelSkillStatus.WaitConfirm)
    end,
    onClick_eSkillMobile = function(self)
      if C_KiboDuelSystemMgr:GetIsPlayAnimation() or not self.duelStar then
        return
      end
      C_KiboDuelSystemMgr:ChangeSkillStatus(L_Const.skillType.KiBoVersusCommonSkill1, C_EKiboDuelSkillStatus.WaitConfirm)
    end,
    onClick_rSkillMobile = function(self)
      if C_KiboDuelSystemMgr:GetIsPlayAnimation() or not self.duelStar then
        return
      end
      C_KiboDuelSystemMgr:ChangeSkillStatus(L_Const.skillType.KiBoVersusCommonSkill2, C_EKiboDuelSkillStatus.WaitConfirm)
    end,
    onClick_help = function(self)
      local state = not self.bind.go_helpContent
      self.bind.go_helpContent = state
    end,
    onClick_mobile_win = function(self)
      C_KiBoDuelLuaWrapper.EndKiboDuel(false)
    end,
    onClick_mobile_lose = function(self)
      C_KiBoDuelLuaWrapper.EndKiboDuel(true)
    end,
    petList = {
      onClick = function(self, index)
        self:onCardClick(index)
      end,
      onDragBegin = function(self, index, screenPos)
        self:onCardDragBegin(index)
      end,
      onDrag = function(self, index, screenPos, pointerId)
        self.pointerId = pointerId
        self:onCardDrag(index, screenPos)
      end,
      onDragEnd = function(self, index, screenPos)
        self:onCardDragEnd(index, screenPos)
      end,
      onDown = function(self)
        self:onCardDown()
      end,
      onUp = function(self)
        self:onCardUp()
      end
    },
    onClickSummon = function(self)
      self:onMobileClickSummon()
    end,
    onClickCancelSummon = function(self)
      self:onMobileClickCancelSummon()
    end,
    onClickSocialRoulette = function(self)
      if C_KiboDuelSystemMgr:IsInNestCoop() or C_KiboArenaSystemMgr.isInArena and not C_KiboArenaSystemMgr.isPVE then
        C_KiboDuelSystemMgr:OpenSocialQuickRoulette()
      end
    end,
    onClickAutoBattle = function(self)
      self:onClickAutoBattle()
    end,
    onClickCancelAutoBattle = function(self)
      self:onClickCancelAuto()
    end,
    onClickCameraHigh = function(self)
      self:SetCameraInitial()
    end,
    onClickCameraLow = function(self)
      self:SetCameraBest()
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
  if not C_KiboArenaSystemMgr.isInArena then
  else
    self.bindComponents.moduleDuelMinimap.gameObject:SetActive(false)
  end
  if not L_DeviceTpl:getIsPc() and not C_KiboArenaSystemMgr.IsInArena then
    local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleMovementBlockMobile, CS.UnityEngine.GameObject)
    self.mobileMoveBlock = addModule(self.csharpPage, self.csharpPage, self.bindComponents.moblieMoveBlockTran.gameObject)
    local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModulePetDuelControlMobile, CS.UnityEngine.GameObject)
    self.mobilePetDuelControl = addModule(self.csharpPage, self.csharpPage, self.bindComponents.transMobilePetDuelControl.gameObject)
  end
  local addModuleBattleStatistics = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleBattleStatistics, CS.UnityEngine.GameObject)
  self.moduleBattleStatistics = addModuleBattleStatistics(self.csharpPage, self.csharpPage, self.bindComponents.moduleBattleStatistics.gameObject)
  if C_KiboArenaSystemMgr.isInArena then
    local addModuleDuelEnergy = addModuleGeneric(CS.Lens.Gameplay.UI.PetDuelArena.ModuleDuelEnergy, CS.UnityEngine.GameObject)
    self.moduleDuelEnergy = addModuleDuelEnergy(self.csharpPage, self.csharpPage, self.bindComponents.moduleDuelEnergy.gameObject)
  end
  if C_KiboDuelSystemMgr:IsInNestCoop() then
    local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleBattleEffect, CS.UnityEngine.GameObject)
    self.moduleBattleEffect = addModule(self.csharpPage, self.csharpPage, self.bindComponents.moduleBattleEffect.gameObject)
    local addBossHpModule = addModuleGeneric(CS.Lens.Gameplay.UI.ModuleBossHpList, CS.UnityEngine.GameObject)
    self.moduleBossHpList = addBossHpModule(self.csharpPage, self.csharpPage, self.bindComponents.moduleBossHpList.gameObject)
  end
end

function this:preOpen(options)
  self.IsInNestCoop = C_KiboDuelSystemMgr:IsInNestCoop()
  self.IsInArena = C_KiboArenaSystemMgr.isInArena
  printLog("KIBODUEL_DEBUG:pagePetDuel.lua:preOpen")
  self:registerModule()
  self:refreshInputMap()
  self.bind.boardActive = true
  self.bind.go_cancelAutoBtn = false
  self.bind.go_autoBtn = self.IsInArena and C_KiboArenaSystemMgr.isPVE
  self.bind.go_autoLock = self.IsInArena and not C_KiboArenaSystemMgr:CheckCanAutoBattle()
  self.bind.go_autoSelect = self.IsInArena and C_KiboArenaSystemMgr.isInAutoBattle
  self.bind.go_autoNormal = self.IsInArena and not C_KiboArenaSystemMgr.isInAutoBattle
  self.bind.go_skillLayout = not self.IsInArena
  self.pointerId = 0
  local isPc = L_DeviceTpl:getIsPc()
  self.isPc = isPc
  self.isMobile = L_DeviceTpl:getIsMobile()
  if not isPc and Unity.Debug.isDebugBuild then
    self.bind.mobileResultDebugActive = true
  else
    self.bind.mobileResultDebugActive = false
  end
  self.bind.go_mobileMoveBlock = not isPc and not self.IsInArena
  self.maxCost = 0
  self:playPageEffect(false, false)
  self.onChangeSkillStatusHandler = self.onChangeSkillStatusHandler or handler(self, self.onChangeSkillStatus)
  self.refreshSummonControlHandler = self.refreshSummonControlHandler or function(e, varList)
    local index = varList:GetInt(0)
    local isDrag = varList:GetBool(1)
    self:refreshSummonControl(index, isDrag)
  end
  self.summonConfirmedHandler = self.summonConfirmedHandler or handler(self, self.summonConfirmed)
  self.summonCancledHandler = self.summonCancledHandler or handler(self, self.summonCancled)
  self.onKiBoDuelEntityCreatedHandler = self.onKiBoDuelEntityCreatedHandler or handler(self, self.onKiBoDuelEntityCreated)
  self.refreshKiBoDuelCostHandler = self.refreshKiBoDuelCostHandler or function(e, varList)
    local cost = varList:GetFloat(0)
    self:refreshKiBoDuelCost(cost)
  end
  self.onRefreshTowerHpHandler = self.onRefreshTowerHpHandler or handler(self, self.onRefreshTowerHp)
  self.refreshSummonFieldHandler = self.refreshSummonFieldHandler or handler(self, self.refreshSummonField)
  self.onStartRapidStateHandler = self.onStartRapidStateHandler or handler(self, self.onStartRapidState)
  self.onClickEscHandler = self.onClickEscHandler or handler(self, self.onClickEsc)
  self.stopDragSummonHandler = self.stopDragSummonHandler or handler(self, self.stopDragSummon)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.ChangeSkillStatus, self.onChangeSkillStatusHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.KiBoSummonStart, self.refreshSummonControlHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.KiBoSummonConfirm, self.summonConfirmedHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.KiBoSummonCancel, self.summonCancledHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.KiBoDuelEntityCreated, self.onKiBoDuelEntityCreatedHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RefreshKiBoDuelCost, self.refreshKiBoDuelCostHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RefreshTowerHp, self.onRefreshTowerHpHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RefreshSummonField, self.refreshSummonFieldHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.StartRapidState, self.onStartRapidStateHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.OnClickEsc, self.onClickEscHandler)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.CancelDragCard, self.stopDragSummonHandler)
  self.onStartSwapHandler = self.onStartSwapHandler or handler(self, self.onStartSwap)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.StartSwapSummon, self.onStartSwapHandler)
  self.onEndSwapHandler = self.onEndSwapHandler or handler(self, self.onEndSwap)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.EndSwapSummon, self.onEndSwapHandler)
  self.duelEndHandler = self.duelEndHandler or handler(self, self.onCampainInfoSync)
  C_ExternalManager.AddEvent(C_EExternalEventType.BattleResultCall, self.duelEndHandler)
  L_UI:addListener(L_UI.pageEvent.closed, self.onPageClose, self)
  self.birdViewHandler = self.birdViewHandler or handler(self, self.onSwitchBirdView)
  C_ExternalManager.AddEvent(C_EExternalEventType.PetFightBirdView, self.birdViewHandler)
  self.restartKiBoDuelHandler = self.restartKiBoDuelHandler or handler(self, self.restartKiBoDuel)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RestartKiBoDuel, self.restartKiBoDuelHandler)
  L_UI:addListener(L_UI.pageEvent.preOpen, self.onPageOpen, self)
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  self.nestStateChangedHandler = self.nestStateChangedHandler or function(e, var)
    self:nestStateCheck()
  end
  C_NestCoopMgr:RegisterEvent(C_ENestCoopEvent.SyncServerData, self.nestStateChangedHandler)
  self.startTimelinePlayEndHandler = self.startTimelinePlayEndHandler or handler(self, self.onStartTimelinePlayEnd)
  C_NestCoopMgr:RegisterEvent(C_ENestCoopEvent.StartTimelinePlayEnd, self.startTimelinePlayEndHandler)
  if self.IsInNestCoop then
    self.onEvent_FullReconnected = handler(self, self.onReconnected)
    L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  end
  local state = C_KiboDuelSystemMgr:IsInNestCoop() and KiboDuelProcedure.Nest or KiboDuelProcedure.KiboDuel
  if C_KiboArenaSystemMgr.isInArena then
    state = KiboDuelProcedure.Arena
  end
  self.duelId = L_PetDuelStore:getCurChallengeLevelId() or 1001
  local tpl = kiBoDuelTpl:getTplById(self.duelId)
  if tpl == nil then
    self.duelId = 1001
    error("kiBoDuel表找不到duelId" .. self.duelId)
  end
  self.KiboDuelTpl = kiBoDuelTpl:getTplById(self.duelId or 1001)
  self.kiboDuelCost = kiBoDuelTpl:getCost(self.KiboDuelTpl)
  self.maxCost = C_KiboDuelAPI.GetMaxCost()
  self.bind.img_maxCostNum = string.format("UI/Atlas/PetDuel/tex_petduel_num_0%d.png", self.maxCost)
  self:switchState(state)
  self:resetPercentValue()
  self:initPage()
  if self.IsInNestCoop then
    C_KiboDuelSystemMgr:StartDuel()
    L_ShortCutManager:removeShortCut(C_EWorldType.KiboDuel)
    L_ShortCutManager:registerPageMainShortCut(C_EWorldType.KiboDuel)
    self:nestStateCheck(true)
  end
  if self.IsInArena then
    self:registerArenaEvent()
    C_KiboArenaSystemMgr:InitState()
    self:arenaStateCheck()
  end
  self.bind.go_moduleBattleEffectRoot = self.IsInNestCoop
  self.bind.go_moduleBossHpList = self.IsInNestCoop
  local equip = L_DeviceTpl:getIsMobile()
  if equip then
    self.bindComponents.transRSkillBtn.anchoredPosition = C_Vector2(-117.8, 63)
    self.bindComponents.transESkillBtn.anchoredPosition = C_Vector2(-263.2, 62.1)
  end
  if state == KiboDuelProcedure.Arena then
    self.bind.go_petList = false
    self.bind.go_skillPanel = false
  end
end

function this:registerModule()
  if not self.subModuleMgr then
    self.subModuleMgr = require("ui.manager.ui.uiSubModuleManager").new(self)
  end
  self.subModuleMgr:init()
  self.subModuleMgr:initSubModules(self, KiboDuelProcedure.None)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Nest, "moduleNestBlueTowerHp", self.bindComponents.transNestBlueTowerHp)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Nest, "moduleNestLoading", self.bindComponents.transNestLoading)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Nest, "moduleNestCountdown", self.bindComponents.transNestCountdown)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Nest, "moduleNestPlayerPanel", self.bindComponents.transNestPlayerPanel)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Nest, "moduleNestSwapSummon", self.bindComponents.transNestSwapSummon)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.KiboDuel, "moduleKiboList", self.bindComponents.transKiboList)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Arena, "moduleKiboArenaCardList", self.bindComponents.moduleArenaCards)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Arena, "moduleKiboArenaSwapSummon", self.bindComponents.moduleArenaSwapSummon)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Arena, "moduleKiboArenaSimulatorPoint", self.bindComponents.moduleKiboArenaSimulatorPoint)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Arena, "moduleKiboArenaScore", self.bindComponents.moduleKiboArenaScore)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Arena, "moduleKiboArenaPlayerPanel", self.bindComponents.moduleKiboArenaPlayerPanel)
  self.subModuleMgr:addSubModules(KiboDuelProcedure.Arena, "moduleKiboArenaTips", self.bindComponents.moduleKiboArenaTips)
end

function this:switchState(state)
  self.state = state
  self.subModuleMgr:openSubModulesByIndex(state)
  if state ~= KiboDuelProcedure.KiboDuel then
    self.bind.go_moduleDuelHealthy = false
  end
end

function this:playPageEffect(isShow, isPlayAni, isUseTime, isBlockCountDown)
  if not (self.bindComponents.cardsAnimator and self.bindComponents.healthyAnimator and self.bindComponents.countDownAnimator and self.bindComponents.energyAnimator) or not self.bindComponents.commonAnimator then
    return
  end
  if not self.isBind then
    return
  end
  if isUseTime then
    Timer.once(animatorPlayDelay.countdownShow, function()
      self.bindComponents.countDownAnimator:SetBool("PlayAnim", isPlayAni)
      self.bindComponents.countDownAnimator:SetBool("Show", isShow)
    end, self, self.gameObject)
    Timer.once(animatorPlayDelay.hpShow, function()
      self.bindComponents.healthyAnimator:SetBool("PlayAnim", isPlayAni)
      self.bindComponents.healthyAnimator:SetBool("Show", isShow)
    end, self, self.gameObject)
    Timer.once(animatorPlayDelay.cardListShow, function()
      self.bindComponents.cardsAnimator:SetBool("PlayAnim", isPlayAni)
      self.bindComponents.cardsAnimator:SetBool("Show", isShow)
      L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Card_Appear")
    end, self, self.gameObject)
    Timer.once(animatorPlayDelay.commonShow, function()
      self.bindComponents.commonAnimator:SetBool("PlayAnim", isPlayAni)
      self.bindComponents.commonAnimator:SetBool("Show", isShow)
    end, self, self.gameObject)
    Timer.once(animatorPlayDelay.commonShow, function()
      self.bindComponents.bottomAnimator:SetBool("PlayAnim", isPlayAni)
      self.bindComponents.bottomAnimator:SetBool("Show", isShow)
    end, self, self.gameObject)
    Timer.once(animatorPlayDelay.countdownShow, function()
      self:refreshHelpInfo()
    end, self, self.gameObject)
  else
    if not isBlockCountDown then
      self.bindComponents.countDownAnimator:SetBool("PlayAnim", isPlayAni)
      self.bindComponents.countDownAnimator:SetBool("Show", isShow)
    else
      self.bindComponents.countDownAnimator:SetBool("PlayAnim", false)
      self.bindComponents.countDownAnimator:SetBool("Show", false)
    end
    self.bindComponents.healthyAnimator:SetBool("PlayAnim", isPlayAni)
    self.bindComponents.healthyAnimator:SetBool("Show", isShow)
    self.bindComponents.cardsAnimator:SetBool("PlayAnim", isPlayAni)
    self.bindComponents.cardsAnimator:SetBool("Show", isShow)
    self.bindComponents.commonAnimator:SetBool("PlayAnim", isPlayAni)
    self.bindComponents.commonAnimator:SetBool("Show", isShow)
    self.bindComponents.bottomAnimator:SetBool("PlayAnim", isPlayAni)
    self.bindComponents.bottomAnimator:SetBool("Show", isShow)
    self:refreshHelpInfo()
  end
  local petList = self.bind.petList
  local nextPetModule = self.modules.nextPet
  local cardNum = #petList + 1
  for i = 1, cardNum do
    if i < cardNum then
      local delayTime = animatorPlayDelay["cardShow" .. i] or 0
      if not isUseTime then
        delayTime = 0
      end
      local petItem = petList:getItemCls(i)
      petItem:playAnimator(isShow, isPlayAni, delayTime)
    elseif i >= cardNum and isShow == false then
      local nextDelayTime = animatorPlayDelay.cardNextShow or 0
      if not isUseTime then
        nextDelayTime = 0
      end
      nextPetModule:playNextAnimation("anim_petduel_card_nextcard_init_hide", nextDelayTime)
    elseif i >= cardNum and isShow ~= false then
      local nextDelayTime = animatorPlayDelay.cardNextShow or 0
      if not isUseTime then
        nextDelayTime = 0
      end
      nextPetModule:playNextAnimation("anim_petduel_card_nextcard_show", nextDelayTime)
    end
  end
end

function this:onPageOpen(pageName)
end

function this:onPageClose(pageName)
  printLog("KIBODUEL_DEBUG:pagePetDuel.lua:onPageClose", pageName)
  if pageName == "loading" and self.IsInNestCoop and not C_KiboDuelSystemMgr:IsSoloNest() then
    self:onReconnectedLoadingEnd()
  end
  if string.find(pageName, "dialog") then
    C_WorldProxy:GetInstance():Resume()
    self:refreshInputMap()
  end
  local curPage = L_UI:currentPage(L_UI.groupKeys.stack)
  if curPage == self.pageName then
    self:refreshInputMap()
  end
end

function this:setUIActive(isShow)
  self.bind.active_statistics = isShow
  self.bindComponents.rootCanvasGroup.blocksRaycasts = isShow
end

function this:close()
  self.subModuleMgr:closeAllSubModules()
  C_ExternalManager.RemoveEvent(C_EExternalEventType.BattleResultCall, self.duelEndHandler)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.PetFightBirdView, self.birdViewHandler)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onPageClose, self)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.ChangeSkillStatus, self.onChangeSkillStatusHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.KiBoSummonStart, self.refreshSummonControlHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.KiBoSummonConfirm, self.summonConfirmedHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.KiBoSummonCancel, self.summonCancledHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.KiBoDuelEntityCreated, self.onKiBoDuelEntityCreatedHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RefreshKiBoDuelCost, self.refreshKiBoDuelCostHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RefreshTowerHp, self.onRefreshTowerHpHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RefreshSummonField, self.refreshSummonFieldHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.StartRapidState, self.onStartRapidStateHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.OnClickEsc, self.onClickEscHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.CancelDragCard, self.stopDragSummonHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RestartKiBoDuel, self.restartKiBoDuelHandler)
  C_NestCoopMgr:UnregisterEvent(C_ENestCoopEvent.SyncServerData, self.nestStateChangedHandler)
  C_NestCoopMgr:UnregisterEvent(C_ENestCoopEvent.StartTimelinePlayEnd, self.startTimelinePlayEndHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.StartSwapSummon, self.onStartSwapHandler)
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.EndSwapSummon, self.onEndSwapHandler)
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
  if self.IsInNestCoop then
    L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  end
  L_UI:removeListener(L_UI.pageEvent.preOpen, self.onPageOpen, self)
  if self.openingTimer ~= nil then
    Timer.remove(self.openingTimer)
    self.openingTimer = nil
  end
  self:disposeDuelTimer()
  C_KiboDuelSystemMgr:SetRapidState(false)
  self:playFeverEffect(false)
  L_ShortCutManager:removeShortCut(C_EWorldType.KiboDuel)
  L_TimerManager:stopTimer(self, "nextCardDraw")
  L_TimerManager:stopTimer(self, "nextCardShow")
  self:killEnergyUIMoveTween()
  self:killRotateMiniMapTween()
  self.openedCountDown = false
  self:showShortCut(27, false)
  self:showShortCut(28, false)
  self:showShortCut(20, false)
  self:showShortCut(208, false)
  self:showShortCut(209, false)
  if self.IsInArena then
    self:unregisterArenaEvent()
  end
end

function this:open()
  self.isInitCostAnim = true
end

function this:show(options)
  self.subModuleMgr:show({
    parentPageName = self.pageName
  })
  if self.state == KiboDuelProcedure.Nest then
  end
  C_ExternalManager.DispatchEvent(C_EExternalEventType.PetFightStart)
  self:refreshInputMap()
  if self.duelStar then
    self:playPageEffect(true, false, false, true)
    if not self.isInitCostAnim then
      self.isInitCostAnim = true
    end
  end
end

function this:destroy(options)
  self.subModuleMgr:destroyAllSubModules()
end

function this:hide()
  self.subModuleMgr:hide()
  self.isInitCostAnim = false
end

function this:refreshInputMap()
  if self.duelStar then
    L_ShortCutManager:removeShortCut(C_EWorldType.KiboDuel)
    L_ShortCutManager:registerPageMainShortCut(C_EWorldType.KiboDuel)
    if self.IsInArena then
      return
    end
    if C_KiboDuelSystemMgr:IsInSummon() then
      if C_KiboDuelSystemMgr.isInSwapSummon then
        C_InputManager.SetInputmap(C_InputManager_MapType.NestSwapSummon, true)
      else
        C_InputManager.SetInputmap(C_InputManager_MapType.KiBoDuelMap, true)
      end
    elseif C_KiboDuelSystemMgr:IsInReleaseSkill() then
      C_InputManager.SetInputmap(C_InputManager_MapType.KiBoDuelSkill, true)
    else
      C_InputManager.SetInputmap(C_InputManager_MapType.KiBoDuelMap, true)
    end
  elseif not self.IsInNestCoop then
    C_InputManager.SetInputmap(C_InputManager_MapType.BlanketInputMap, true)
  end
end

function this:refreshHelpInfo()
  local state = L_EntrustStore:isActivityEntrustLevel(self.duelId)
  self.bind.go_leftContent = state
  local activityID = L_EntrustStore:getActivityIdByDuelID(self.duelId)
  if activityID ~= 0 and activityID ~= 0 then
    local gameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
    local tpl = gameEventKiboDuleTpl:getTplById(activityID)
    local desc = gameEventKiboDuleTpl:getBuffDesc(tpl)
    self.bind.txt_buffDesc = desc
  end
end

function this:restartKiBoDuel(e, v)
  C_InputManager.SetInputmap(C_InputManager_MapType.BlanketInputMap, true)
  self.openedCountDown = false
  self.duelStar = false
  self.cost = 0
  self.lastCost = 0
  self.playedCost = 0
  self.playedLstCost = 0
  self.selectedIndex = nil
  self.currentCost = nil
  self.mapTpl = nil
  self.bind.petList:clear()
  self:resetPercentValue()
  self:playPageEffect(false, false)
  self:initPage()
  if self.mobilePetDuelControl then
    self.mobilePetDuelControl:DuelStart(false)
  end
  printLog("KIBODUEL_DEBUG:restartKiBoDuel", self.openedCountDown)
end

function this:resetPercentValue()
  self.blueMaxHp = 100
  self.redMaxHp = 100
  self.blueHp = 100
  self.redHp = 100
end

function this:initPage()
  self:playFeverEffect(false)
  self.bind.playerNameText = L_PlayerStore:getPlayerName()
  local tpl = kiBoDuelTpl:getTplById(self.duelId)
  self.duelTime = kiBoDuelTpl:getTime(tpl)
  self.bind.timeText = tostring(self.duelTime)
  local npcSpawnerID = kiBoDuelTpl:getNpcSpawnerID(tpl)
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
    npcSpawnerID = L_KiboDuelSimulatorStore.data.playerInfo[2].playerEntityId
  end
  local tpl_worldSpawner = worldSpawnerTpl:getTplById(npcSpawnerID)
  self.bind.enemyNameText = worldSpawnerTpl:getName(tpl_worldSpawner)
  self.bind.playerHpTxt = tostring(self.blueMaxHp) .. "%"
  self.bind.enemyHpTxt = tostring(self.redMaxHp) .. "%"
  self.bindComponents.playerHealthy:InitHp(1)
  self.bindComponents.enemyHealthy:InitHp(1)
  self.bind.rotate_minimap = C_Vector3(0, 0, 0)
  if self.miniMap then
  end
  if not self.IsInArena then
    self:initPetFormation()
  end
  if self.IsInArena then
    self:refreshKiBoDuelCost(C_KiboArenaSystemMgr:GetCurCost())
  elseif not self.IsInNestCoop then
    self:refreshKiBoDuelCost(self.kiboDuelCost[L_Const.kiBoDuelEnum.originalCost])
  else
    self:refreshKiBoDuelCost(C_KiboDuelSystemMgr:GetNestCost())
  end
  self:refreshButtonStatus()
  self:initSkills()
end

function this:initSkills()
  self.modules.eSkill:initSkillType(L_Const.skillType.KiBoVersusCommonSkill1, true)
  self.modules.rSkill:initSkillType(L_Const.skillType.KiBoVersusCommonSkill2, true)
  self.modules.eSkillMobile:initSkillType(L_Const.skillType.KiBoVersusCommonSkill1, true)
  self.modules.rSkillMobile:initSkillType(L_Const.skillType.KiBoVersusCommonSkill2, true)
end

function this:onKiBoDuelEntityCreated(e, v)
  self.blueMaxHp, self.redMaxHp = C_KiboDuelSystemMgr:GetTowerMaxHp()
  self.blueHp = self.blueMaxHp
  self.redHp = self.redMaxHp
end

function this:onRefreshTowerHp(e, varList)
  local data = {
    hp = varList:GetInt(0),
    isBlue = varList:GetBool(1)
  }
  self.blueMaxHp, self.redMaxHp = C_KiboDuelSystemMgr:GetTowerMaxHp()
  if data.isBlue then
    local value = data.hp / self.blueMaxHp
    self.bindComponents.playerHealthy:SetHp(value)
    self.blueHp = data.hp
    self.bind.playerHpTxt = string.format("%.0f", value * 100) .. "%"
  else
    local value = data.hp / self.redMaxHp
    printLog(L_WordsTpl:getValue("ui_kiboDuel_01"), L_WordsTpl:getValue("ui_kiboDuel_02:") .. data.hp .. L_WordsTpl:getValue(" ui_kiboDuel_03:") .. self.redMaxHp)
    self.bindComponents.enemyHealthy:SetHp(value)
    self.redHp = data.hp
    self.bind.enemyHpTxt = string.format("%.0f", value * 100) .. "%"
  end
end

function this:initPetFormation()
  self.petListData = {}
  self.petCardAnimState = {}
  if self.IsInNestCoop then
    local handList = C_KiboDuelSystemMgr:GetNestHandCards()
    for i = 0, 3 do
      local data = handList[i]
      table.insert(self.petListData, {
        isNext = false,
        guid = data.guid,
        petInfo = data,
        index = i + 1
      })
      table.insert(self.petCardAnimState, {isPlayingAnim = false})
    end
    self.nextPetInfo = handList[4]
    table.insert(self.petListData, {
      isNext = true,
      guid = self.nextPetInfo.guid,
      petInfo = self.nextPetInfo,
      index = #self.petListData + 1
    })
    self:initPetList()
    local petList = self.bind.petList
    for i = 1, #petList do
      petList:getItemCls(i):playAnimator(false, false, 0)
    end
  else
    self.formationQueue = C_KiboDuelSystemMgr:GetFormationGuid()
    for i = 1, 4 do
      if 0 < self.formationQueue.Count then
        local data = self.formationQueue:Dequeue()
        table.insert(self.petListData, {
          isNext = false,
          guid = data.guid,
          petInfo = data,
          index = i
        })
        table.insert(self.petCardAnimState, {isPlayingAnim = false})
      end
    end
    self.nextPetInfo = self.formationQueue:Dequeue()
    table.insert(self.petListData, {
      isNext = true,
      guid = self.nextPetInfo.guid,
      petInfo = self.nextPetInfo,
      index = #self.petListData + 1
    })
    self:initPetList()
    local petList = self.bind.petList
    for i = 1, #petList do
      petList:getItemCls(i):playAnimator(false, false, 0)
    end
  end
end

function this:initPetList(index)
  L_ProfilerUtil.BeginSample(L_WordsTpl:getValue("residual_code_pagepetduel_01"))
  self.petListData = self.petListData or {}
  local petList = self.bind.petList
  local petListData = self.petListData
  if #petList == #petListData then
    for i = 1, #petListData do
      if index == i then
        petList:getItemCls(i):playAnimator(false, true, 0)
      end
      petList:change(i, petListData[i])
      if index == i then
        petList:getItemCls(i):playAnimator(true, true, 0)
      end
    end
  else
    petList:clear()
    petList:insert_array(petListData)
  end
  L_ProfilerUtil.EndSample()
end

function this:summonConfirmed(e, v)
  if self.selectedIndex == nil then
    return
  end
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Card_Use")
  local index = self.selectedIndex
  self.bind.petList:getItemCls(index):setCastStatus(true)
  self:refreshPetListCast(index)
  self.petCardAnimState[index].isPlayingAnim = true
  L_TimerManager:newOrResetTimer(self, "nextCardDraw" .. tostring(index), function()
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Card_Reload")
    self.modules.nextPet:playNextAnimation("anim_petduel_card_nextcard_draw")
    L_TimerManager:stopTimer(self, "nextCardDraw")
    self.bind.petList:getItemCls(index):setCastStatus(false)
    self:refreshPetListCast(index)
    self:initPetList(index)
    Timer.once(0.3, function()
      table.remove(self.petListData, #self.petListData)
      table.insert(self.petListData, {
        isNext = true,
        guid = self.nextPetInfo.guid,
        petInfo = self.nextPetInfo,
        index = #self.petListData + 1
      })
      self:initPetList(#self.petListData)
      self:refreshPetListCd(true)
      if self.selectedIndex == index then
        self.selectedIndex = nil
        self.lastCost = nil
        self.cost = nil
        self.playedCost = nil
        self.playedLstCost = nil
      end
      self.petCardAnimState[index].isPlayingAnim = false
    end, self)
    self:refreshPetListCd(true)
    self.bind.fightTipActive = false
    L_TimerManager:newOrResetTimer(self, "nextCardShow", function()
      self.modules.nextPet:playNextAnimation("anim_petduel_card_nextcard_show")
      L_TimerManager:stopTimer(self, "nextCardShow")
    end, 0.433)
  end, 0.6)
  local res = {}
  local petListData = self.petListData
  local formationQueue = self.formationQueue
  if self.IsInNestCoop then
    local handList = C_KiboDuelSystemMgr:GetNestHandCards()
    for i = 0, 3 do
      local data = handList[i]
      table.insert(res, {
        isNext = false,
        guid = data.guid,
        petInfo = data,
        index = i + 1
      })
    end
    self.nextPetInfo = handList[4]
    table.insert(res, {
      isNext = true,
      guid = self.nextPetInfo.guid,
      petInfo = self.nextPetInfo,
      index = 5
    })
    for _, v in pairs(petListData) do
      if v.index == index then
        C_KiboDuelSystemMgr:PlayerSummonKiBo(v.petInfo)
        break
      end
    end
  else
    for _, v in pairs(petListData) do
      local vIndex = v.index
      if vIndex ~= index then
        table.insert(res, v)
      end
      if vIndex == index then
        if not self.IsInNestCoop then
          formationQueue:Enqueue(v.petInfo)
        end
        C_KiboDuelSystemMgr:PlayerSummonKiBo(v.petInfo)
      end
    end
    table.insert(res, {
      isNext = false,
      guid = self.nextPetInfo.guid,
      petInfo = self.nextPetInfo,
      index = index
    })
  end
  if self.IsInNestCoop then
  else
    self.nextPetInfo = self.formationQueue:Dequeue()
  end
  table.sort(res, function(a, b)
    return a.index < b.index
  end)
  self.petListData = res
end

function this:getPetDuelCost(id, isTrial)
  if not isTrial then
    local petData = L_PetStore:getPetItem(id)
    if petData then
      return self:getPetCost(petData.id)
    end
  else
    local trialPetTpl = L_GameTpl:getTrialPetTpl()
    local trialTpl = trialPetTpl:getTplById(id)
    local petId = trialPetTpl:getTrialPet(trialTpl)
    return self:getPetCost(petId)
  end
end

function this:getPetCost(petId)
  local tempTpl = templateValueTpl:getTplById(petId)
  local cost = templateValueTpl:getPetBaseAttribute(tempTpl)[L_Const.kiBoDuelEnum.petCost]
  return cost or 0
end

function this:summonCancled(e, v)
  self.cost = 0
  self.playedCost = self.cost
  self.lastCost = self.cost
  self.playedLstCost = self.lastCost
  self.selectedIndex = nil
  self:refreshPetListSelect(nil)
  if self.tipType ~= tipType.Rapid then
    self.bind.fightTipActive = false
  end
  self:showMobileSummonNode(false)
end

function this:refreshSummonControl(index, isDrag)
  if self.selectedIndex == index then
    return
  end
  if self.petCardAnimState[index].isPlayingAnim == true then
    return
  end
  if index ~= nil and self.petListData[index] then
    C_KiboDuelSystemMgr:SetIsPlayAnimation(true)
    Timer.once(0.05, function()
      C_KiboDuelSystemMgr:SetIsPlayAnimation(false)
    end)
    self.lastCost = self.cost or 0
    self.playedLstCost = self.lastCost
    self.cost = self:getPetDuelCost(self.petListData[index].petInfo.id, self.petListData[index].petInfo.is_trial)
    self.playedCost = self.cost
    if self.cost > self.currentCost then
      return
    end
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Card_Select")
    self.bind.rect_kiBoDescription = C_Vector2(descriptionOrdinaryPos[index].x, descriptionOrdinaryPos[index].y)
    self.modules.kiBoDescription:initModule(self.petListData[index].petInfo)
    C_KiboDuelSystemMgr:SetSummonStatus(C_ESummonStatus.InSummon, isDrag or false)
    local guid = self.petListData[index].petInfo.guid
    if isDrag then
      C_KiBoDuelLuaWrapper.KiBoDragSummonStart(guid, self.pointerId)
    else
      C_KiBoDuelLuaWrapper.KiBoSummonStart(guid)
    end
    C_KiboDuelSystemMgr:SetSummonGuid(guid)
    C_KiboDuelSystemMgr:UpdatePetHealingIcon()
    self:disposeOpenTipTimer()
    self.bind.fightTipActive = true
    self:refreshSummonField()
    self:showMobileSummonNode(true)
  end
  self:refreshPetListSelect(index)
  self.selectedIndex = index
end

function this:refreshSummonField(e, v)
  if C_KiboDuelSystemMgr:GetSummonFieldStatus() then
    if self.isMobile then
      self.bind.fightTipActive = false
      return
    end
    self.tipType = tipType.Normal
    self:dealTipShowAnim(L_WordsTpl:getValue("notice_kibo_duel_in_battle_05"))
  else
    self.tipType = tipType.Error
    self:dealTipShowAnim(L_WordsTpl:getValue("notice_kibo_duel_in_battle_06"))
  end
end

function this:refreshPetListStatus(index, isUse)
  local petList = self.bind.petList
  for i = 1, #petList do
    local value = petList:getValue(i, "index")
    petList:getItemCls(i):refreshSelect(index == value, isUse)
  end
  self:refreshButtonStatus()
end

function this:refreshPetListSelect(index)
  local petList = self.bind.petList
  for i = 1, #petList do
    petList:getItemCls(i):refreshSelectNew(index)
  end
  self:refreshButtonStatus()
end

function this:refreshPetListCast(index)
  local petList = self.bind.petList
  for i = 1, #petList do
    petList:getItemCls(i):refreshCast(index)
  end
  self:refreshButtonStatus()
end

function this:refreshKiBoDuelCost(currentCost, nextTime, startTime)
  local inRecover = true
  if not currentCost then
    currentCost = self.kiboDuelCost[L_Const.kiBoDuelEnum.originalCost]
    inRecover = false
  end
  self.refreshCostTime = nextTime
  local bPlay = false
  if self.currentCost ~= nil then
    bPlay = math.floor(currentCost) > math.floor(self.currentCost)
  end
  local bPlayCast = self.currentCost ~= nil and currentCost < self.currentCost
  self.currentCost = currentCost
  currentCost = math.floor(currentCost)
  if bPlay then
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Energy_Get")
  else
  end
  self:refreshPetListCd(inRecover)
end

function this:refreshPetListCd(inRecover)
  self.petListRefreshCostParamList = self.petListRefreshCostParamList or {}
  local petList = self.bind.petList
  for i = 1, #petList do
    self.petListRefreshCostParamList[i] = self.petListRefreshCostParamList[i] or {}
    local param = self.petListRefreshCostParamList[i]
    param.currentCost = self.currentCost
    param.inRecover = inRecover
    petList:getItemCls(i):refreshKiBoDuelCost(param)
  end
end

function this:startOpenCountDown()
  printLog("KIBODUEL_DEBUG:startOpenCountDown", self.openedCountDown)
  if self.openedCountDown then
    return
  end
  self.openedCountDown = true
  self.bind.go_mobileMoveBlock = false
  self.startCountDown = 3
  L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Begin")
  C_KiboDuelSystemMgr:StartDuel()
  self:dealControlInput(true)
  self:playPageEffect(true, true, true)
  self.openingTimer = Timer.repeated(1, function()
    self.startCountDown = self.startCountDown - 1
    if self.startCountDown < 1 then
      if self.openingTimer then
        Timer.remove(self.openingTimer)
      end
      self.openingTimer = nil
      return
    end
  end, self, self.gameObject)
  self:setUIActive(false)
  Timer.once(4.45, function()
    if not self.isBind then
      return
    end
    self.bind.go_mobileMoveBlock = self.isMobile and not self.IsInArena
    self:setUIActive(true)
    self:dealStart()
  end, self, self.gameObject)
end

function this:dealControlInput(isShow)
  C_UIMgr.uiListenerMiddleware:ControlCameraLock(self.pageName, isShow)
  if isShow then
    C_InputManager.DeactivatePlayerInput()
  else
    C_InputManager.ActivatePlayerInput()
  end
end

function this:dealStart()
  self:onKiBoDuelEntityCreated()
  self.duelStar = true
  C_KiboDuelSystemMgr:SetSummonStatus(C_ESummonStatus.Normal)
  if self.openingTimer then
    Timer.remove(self.openingTimer)
  end
  self.openingTimer = nil
  self:dealControlInput(false)
  C_InputManager.SetInputmap(C_InputManager_MapType.KiBoDuelMap, true)
  L_ShortCutManager:removeShortCut(C_EWorldType.KiboDuel)
  L_ShortCutManager:registerPageMainShortCut(C_EWorldType.KiboDuel)
  self.tipType = tipType.Normal
  self:dealTipShowAnim(L_WordsTpl:getValue("notice_kibo_duel_in_battle_01"))
  printLog("KIBODUEL_DEBUG:dealStart", self.openedCountDown)
  L_PetDuelStore:req_CSProtoKiboRealStart()
  C_DriveManager.DispatchDrive(C_EExternalDrive.KiBoBattleUITimeOver)
  if self.mobilePetDuelControl then
    self.mobilePetDuelControl:DuelStart(true)
  end
  self.openTipTimer = Timer.once(5, function()
    if not self.isBind then
      return
    end
    self.bind.fightTipActive = false
    self:disposeOpenTipTimer()
  end)
  self:setDuelTime()
  self.isSusscess = L_PetDuelStore:getIsSuccess(self.duelId)
end

function this:dealTipShowAnim(strValue)
  do return end
  self.bind.toggle_fightTip = self.tipType
  if self.bind.fightTipActive then
    self.bind.fightTipActive = false
  end
  self:disposeTimer()
  if self.lastStrValue ~= strValue and not self.isProtect then
    self.bind.fightTipActive = true
    self.bind.fightTipText = strValue
    return
  end
  self.bind.fightTipActive = true
  self.bind.fightTipText = strValue
  self.tipAnimTimer = Timer.once(1.333, function()
    if not self.isBind then
      return
    end
    self.bind.fightTipActive = false
  end, self, self.gameObject)
  self.isProtect = true
  self.protectTimer = Timer.once(0.5, function()
    self.isProtect = false
  end, self, self.gameObject)
  self.lastStrValue = strValue
end

function this:disposeTimer()
  if self.tipAnimTimer then
    Timer.remove(self.tipAnimTimer)
    self.tipAnimTimer = nil
  end
  if self.protectTimer then
    Timer.remove(self.protectTimer)
    self.protectTimer = nil
  end
end

function this:disposeOpenTipTimer()
  if self.openTipTimer then
    Timer.remove(self.openTipTimer)
  end
  self.openTipTimer = nil
end

function this:setDuelTime()
  if self.IsInArena then
    return
  end
  self:disposeDuelTimer()
  self.duelTimer = Timer.repeated(0.1, function()
    self:setTimeLabel()
  end, self, self.gameObject)
end

function this:setTimeLabel()
  self.leftTime = self.duelTime - math.floor(C_KiboDuelSystemMgr:GetDuelTime())
  if self.leftTime < 0 then
    self.leftTime = 0
    self:disposeDuelTimer()
    return
  end
  local rapidTime = self:getRapidTime()
  C_KiboDuelSystemMgr:SetRapidState(rapidTime < C_KiboDuelSystemMgr:GetDuelTime())
  self.bind.timeText = tostring(self.leftTime)
end

function this:getRapidTime()
  if not self.duelId then
    return 99999999999
  end
  local tpl = kiBoDuelTpl:getTplById(self.duelId)
  local rapidTimes = kiBoDuelTpl:getCostTime(tpl)
  if not rapidTimes and not rapidTimes[1] and not rapidTimes[1][1] then
    return 99999999999
  end
  local rapidTime = rapidTimes[1][1]
  return rapidTime
end

function this:disposeDuelTimer()
  if self.duelTimer then
    Timer.remove(self.duelTimer)
  end
  self.duelTimer = nil
end

function this:refreshButtonStatus()
  if not self.isBind then
    return
  end
  local isInSummon = C_KiboDuelSystemMgr:IsInSummon()
  self.bind.btnDogeActive = self.isPc
  self.bind.skillBtnNodeActive = not isInSummon and self.isPc and not self.IsInArena
  self.bind.skillBtnNodeMobileActive = not self.isPc and not isInSummon and not self.IsInArena
  local isInReleaseSkill = C_KiboDuelSystemMgr:IsInReleaseSkill()
  self:showShortCut(27, isInSummon and not isInReleaseSkill and self.isPc)
  self:showShortCut(28, isInSummon and not isInReleaseSkill and self.isPc)
  if self.IsInNestCoop then
    self:showShortCut(20, self.afterStartCountdown and not isInSummon and not isInReleaseSkill and self.isPc)
  end
  if self.IsInArena and not C_KiboArenaSystemMgr.isPVE then
    self:showShortCut(20, not isInSummon and not isInReleaseSkill and self.isPc)
  end
  local isOn = isInSummon and not self.isPc
  self.bind.go_mobileSummonNode = isOn
  self.bind.mobileSkillBtnNode = not self.isPc
  self.bind.interactable_buttonContent = not isInReleaseSkill
end

function this:escHandle()
  return
end

function this:onClickEscBtn()
  if not self.IsInNestCoop and C_KiboDuelSystemMgr:IsInSummon() then
    C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
  end
  if C_KiboDuelSystemMgr:IsInReleaseSkill() then
    C_KiboDuelSystemMgr:HandleCancelSkillRelease()
  end
  if self.isOver then
    return
  end
  if self.IsInNestCoop then
    self:dealExit()
  else
    self:dealExit()
  end
end

function this:onClickEsc(e, v)
  if C_KiboDuelSystemMgr:IsInSummon() then
    C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
    return
  end
  if C_KiboDuelSystemMgr:IsInReleaseSkill() then
    C_KiboDuelSystemMgr:HandleCancelSkillRelease()
    return
  end
  if not self.duelStar and not self.IsInNestCoop then
    return
  end
  if self.IsInNestCoop and C_NestCoopMgr.GetNestCoopStatus == C_NestCoopStatus.NccsPreStart then
    return
  end
  self:dealExit()
end

function this:dealExit()
  if C_KiboDuelSystemMgr.isQuit then
    return
  end
  if self.IsInNestCoop then
    local data_tip = {
      txtContent = L_WordsTpl:getValue("window_nestcoop_combat_quit"),
      confirmCallback = function()
        C_KiboDuelSystemMgr:QuitKiBoDuel()
      end,
      pageClosedCallback = function()
        if C_KiboDuelSystemMgr:GetBirdView() then
          C_InputManager.SetCameraFollowMouse(false)
        end
      end
    }
    L_GameUtil.showCommonTip(data_tip)
    return
  end
  if self.IsInArena and C_KiboArenaMgr.serverStatus ~= CS.Protocal.Cs.KiboDuelArenaStatus.KiboDuelArenaStatusRegular then
    printLog("[奇波擂台系统] Status is not regular, can not open pagePetDuelExit")
    return
  end
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
    C_KiboDuelSimulatorManager.instance:ExitBattle()
    C_KiboDuelSystemMgr:QuitKiBoDuel()
    return
  end
  local data_tip = {
    txtTitle = L_WordsTpl:getValue("notice_kibo_duel_in_battle_10"),
    txtContent = L_WordsTpl:getValue("notice_kibo_duel_in_battle_11"),
    txtConfirm = L_WordsTpl:getValue("notice_kibo_duel_in_battle_10"),
    confirmCallback = function()
      C_KiboDuelSystemMgr:QuitKiBoDuel()
    end,
    pageClosedCallback = function()
    end,
    duelId = self.duelId,
    leftTime = self.leftTime
  }
  if C_KiboArenaSystemMgr.isPVE then
    data_tip.isFull = true
    L_UI:open("pagePetDuelExitFull", data_tip)
  else
    L_UI:open("pagePetDuelExit", data_tip)
  end
end

function this:onCampainInfoSync(data)
  if self.IsInNestCoop then
    return
  end
  self:disposeDuelTimer()
  C_KiboDuelSystemMgr:SetRapidState(false)
  local isWin = data.finishType == C_EBattlerServerFinishType.Win
  local isFirst = isWin and not self.isSusscess
  local options = {
    winStatus = isWin,
    duelTime = self.leftTime,
    duelId = self.duelId,
    isFirstWin = isFirst,
    blueHp = self.blueHp,
    blueHpPercent = self.blueHp / self.blueMaxHp,
    redHpPercent = self.redHp / self.redMaxHp
  }
  self:stopDragSummon()
  C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
  if isWin then
    L_UI:open("pagePetFinishDuel", options)
  else
    L_UI:open("PageFailureKiboDuel", options)
  end
  C_KiboDuelSystemMgr:ExitDuel()
end

function this:onStartRapidState(e, v)
  local isRapid = v:GetBool(0)
  if isRapid then
    self.isProtect = false
    self.tipType = tipType.Rapid
    self:dealTipShowAnim(L_WordsTpl:getValue("notice_kibo_duel_in_battle_12", {
      [0] = self:getRapidTime()
    }))
    self.isProtect = true
  end
  self:playFeverEffect(isRapid)
end

function this:playFeverEffect(isPlay)
  if isPlay and not L_CommonUtil.isValid(self.feverEffect) then
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_RushTime_Begin")
    L_ResPool:asyncGameObject(feverEffectPath, function(id, go)
      self.feverEffect = go
      local feverTrans = self.feverEffect.transform
      feverTrans:SetParent(C_CameraManager.mainCamera.transform)
      L_Vector3.setLocalPos(feverTrans, L_Vector3.zero)
      L_Vector3.setLocalRot(feverTrans, L_Vector3.zero)
    end)
  end
  if not isPlay and L_CommonUtil.isValid(self.feverEffect) then
    L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_RushTime_End")
    Unity.GameObject.Destroy(self.feverEffect)
    self.feverEffect = nil
  end
  if not self.IsInArena then
    self.bindComponents.energyAnimator:SetBool("Fever", isPlay)
  end
end

function this:onChangeSkillStatus(e, varList)
  self:refreshButtonStatus()
  local isInReleaseSkill = C_KiboDuelSystemMgr:IsInReleaseSkill()
  self:controlCardShow(not isInReleaseSkill)
  self:controlSkillShow(isInReleaseSkill)
  self:controlEnergyShow(not isInReleaseSkill)
end

function this:showShortCut(id, idAdd)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuideEventArgs()
  args.isLuaEvent = true
  args.luaTable = {
    tdId = id,
    isAdd = idAdd or false,
    isGray = false
  }
  C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcChange, args)
end

function this:controlCardShow(isShow)
  self.bindComponents.cardsAnimator:SetBool("PlayAnim", false)
  self.bindComponents.cardsAnimator:SetBool("Show", isShow)
end

function this:controlSkillShow(isShow)
  self.bindComponents.bottomAnimator:SetBool("Skill", isShow)
end

function this:controlEnergyShow(isShow)
  self.bind.alpha_energy = isShow and 1 or 0
end

function this:hideBoard()
  L_UI:close("pagePetDuelExit")
  self.isOver = true
  self.bind.boardActive = false
end

function this:endActivity(activityId)
  local gameEventsKiboDuelTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local data = gameEventsKiboDuelTpl:getData()
  if data ~= nil then
    for i, v in pairs(data) do
      if v.groupId == activityId and v.kiboDuelId == self.duelId then
        L_PetDuelStore:req_CSProtoKiboDuelQuit(function()
        end)
        return
      end
    end
  end
end

function this:SetCameraInitial()
  if not self.IsInArena then
    return
  end
  self:SetCameraStatus(true)
  C_KiboDuelSystemMgr:SetCameraInitial()
end

function this:SetCameraBest()
  if not self.IsInArena then
    return
  end
  self:SetCameraStatus(false)
  C_KiboDuelSystemMgr:SetCameraBest()
end

function this:SetCameraStatus(isHigh)
  self.bind.camHighOn = not isHigh
  self.bind.camHighOff = isHigh
  self.bind.camLowOn = isHigh
  self.bind.camLowOff = not isHigh
end

function this:onSwitchBirdView(data)
  self.bind.toggle_birdView = data.isEnable
  self:onBirdViewChange(data.isEnable)
end

function this:setBridView(isEnable)
  C_KiboDuelSystemMgr:OnSwitchBirdView()
  self:onBirdViewChange(isEnable)
end

function this:onBirdViewChange(isEnable)
  C_KiboDuelSystemMgr:SetBirdView(isEnable)
  local tpl = kiBoDuelTpl:getTplById(self.duelId)
  local mapId = kiBoDuelTpl:getMapId(tpl)
  local mapTpl = _kiboDuelMapTpl:getTplById(mapId)
  local angle = _kiboDuelMapTpl:getCameraAnglePlane(mapTpl)
  self:doRotateMiniMap(C_Vector3(0, 0, isEnable and -90 + angle or 0))
  local targetPos = isEnable and C_Vector2(-710, -460) or C_Vector2(162, -68)
  self:doMoveModuleEnergy(targetPos)
  if self.miniMap then
  end
end

function this:doRotateMiniMap(targetRotation)
  self:killRotateMiniMapTween()
  self.rotateMiniMapTween = self.bindComponents.miniMapTran:DOLocalRotate(targetRotation, 0.667):SetEase(Tweening.Ease.OutQuint):OnComplete(function()
    if not self.isBind then
      return
    end
    self:killRotateMiniMapTween()
    self.bind.rotate_minimap = targetRotation
  end, self)
end

function this:killRotateMiniMapTween()
  if self.rotateMiniMapTween then
    self.rotateMiniMapTween:Kill()
    self.rotateMiniMapTween = nil
  end
end

function this:doMoveModuleEnergy(targetPos)
  self:killEnergyUIMoveTween()
  self.moduleEnergyTween = self.bindComponents.moduleDuelEnergyTran:DOLocalMove(C_Vector3(targetPos.x, targetPos.y, 0), 0.667):SetEase(Tweening.Ease.OutQuint):OnComplete(function()
    if not self.isBind then
      return
    end
    self.bind.tran_starts = targetPos
    self:killEnergyUIMoveTween()
  end, self)
end

function this:killEnergyUIMoveTween()
  if self.moduleEnergyTween then
    self.moduleEnergyTween:Kill()
    self.moduleEnergyTween = nil
  end
end

function this:onCardClick(index)
  if self.draggingSpawn then
    return
  end
  if self.selectedIndex == index then
    if L_GuideManager:isGuideOnRunning() then
      return
    end
    C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
  else
    if self.openingTimer ~= nil or not self.duelStar then
      return
    end
    C_KiboDuelSystemMgr:HandleKiBoSummonStart(index)
  end
end

function this:showMobileSummonNode(isOn)
  if self.isMobile then
    self.bind.go_mobileSummonNode = isOn
  else
    self.bind.go_mobileSummonNode = false
  end
end

function this:refreshMobileBtnDodgePos(isOn)
  if not self.isMobile then
    return
  end
  self.bind.mobileBtnDodgePos = isOn and C_Vector2(-183.7, 121.2) or C_Vector2(-150.6, 246)
  self.bind.mobileBtnJumpPos = isOn and C_Vector2(-111.8, 256.3) or C_Vector2(-297.4, 246)
end

function this:onMobileClickSummon()
  C_KiboDuelSystemMgr:HandleKiBoSummonConfirm(true)
end

function this:onMobileClickCancelSummon()
  if C_KiboArenaSystemMgr.isInAutoBattle then
    return
  end
  C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
end

function this:onCardDown()
end

function this:onCardUp()
end

function this:onCardDragBegin(index)
  if C_KiboArenaSystemMgr.isInAutoBattle then
    return
  end
  if L_GuideManager:isGuideOnRunning() then
    return
  end
  C_KiboDuelSystemMgr.isDraggingCard = true
  self.draggingSpawn = true
end

function this:onCardDrag(index, screenPos)
  if C_KiboArenaSystemMgr.isInAutoBattle then
    return
  end
  if not self.draggingSpawn then
    return
  end
  if L_GuideManager:isGuideOnRunning() then
    return
  end
  C_KiboDuelSystemMgr.isDraggingCard = true
  local rect = self.bindComponents.DragArea
  local screenRect = self.gameObject.transform
  local uiCamera = C_CameraManager.uiCamera
  local isInScreen = C_RectTransformUtility.RectangleContainsScreenPoint(screenRect, screenPos, uiCamera)
  if not isInScreen then
    self.draggingSpawn = false
    C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
    return
  end
  local isIn = C_RectTransformUtility.RectangleContainsScreenPoint(rect, screenPos, uiCamera)
  if not isIn then
    if self.selectedIndex ~= index then
      if C_KiboDuelSystemMgr.isDragSummoning then
        return
      end
      if self.openingTimer ~= nil or not self.duelStar then
        return
      end
      C_KiboDuelSystemMgr:HandleKiBoSummonStart(index, true)
    end
  elseif self.selectedIndex == index then
    C_KiboDuelSystemMgr:HandleKiBoSummonCancel()
  end
end

function this:onCardDragEnd(index, screenPos)
  if C_KiboArenaSystemMgr.isInAutoBattle then
    return
  end
  if not self.draggingSpawn then
    return
  end
  self.draggingSpawn = false
  C_KiboDuelSystemMgr.isDraggingCard = false
  local rect = self.bindComponents.DragArea
  local uiCamera = C_CameraManager.uiCamera
  local isIn = C_RectTransformUtility.RectangleContainsScreenPoint(rect, screenPos, uiCamera)
  if not isIn and self.selectedIndex ~= nil then
    C_KiboDuelSystemMgr:HandleKiBoSummonConfirm(false, true)
  end
end

function this:stopDragSummon(e, v)
  if C_ESummonStatus.InSummon ~= C_KiboDuelSystemMgr.summonStatus then
    return
  end
  if self.draggingSpawn then
    self.draggingSpawn = false
  end
end

function this:update()
  L_ProfilerUtil.BeginSample("pagepetduel.updateAll")
  local birdView = self.IsInNestCoop and AzurWorld.NestCoopKiboDuelMgr.m_birdViewTactic or AzurWorld.KiBoDuelSceneMgr.m_birdViewTactic
  if L_DeviceTpl:getIsPc() then
    local mousePos = CS.UnityEngine.Input.mousePosition
    local screenPos = C_Vector2(mousePos.x, mousePos.y)
    local uiCamera = C_CameraManager.uiCamera
    if birdView ~= nil and self.isBind then
      birdView.isOnScrollView = false
      local rectStatistics = self.bindComponents.statisticsRect
      local isOn = self.moduleBattleStatistics.StatisticsToggleIsOn
      local isIn = C_RectTransformUtility.RectangleContainsScreenPoint(rectStatistics, screenPos, uiCamera)
      local isOnScroll = isOn and isIn
      birdView.isOnScrollView = isOnScroll
    end
    local dragRect = self.bindComponents.DragArea
    local isInCard = C_RectTransformUtility.RectangleContainsScreenPoint(dragRect, screenPos, uiCamera)
    C_KiboDuelSystemMgr.isInCard = isInCard
  end
  L_ProfilerUtil.EndSample()
end

function this:dealNestStart()
  self.duelStar = true
  C_KiboDuelSystemMgr:SetSummonStatus(C_ESummonStatus.Normal)
  C_InputManager.SetInputmap(C_InputManager_MapType.KiBoDuelMap, true)
  L_ShortCutManager:removeShortCut(C_EWorldType.KiboDuel)
  L_ShortCutManager:registerPageMainShortCut(C_EWorldType.KiboDuel)
  self.tipType = tipType.Normal
  printLog("Nest_DEBUG:dealStart")
  self:setUIActive(true)
  if self.mobilePetDuelControl then
    self.mobilePetDuelControl:DuelStart(true)
  end
end

function this:nestStateCheck(initCheck)
  local state = C_NestCoopMgr.GetNestCoopStatus
  if self.nestState == state then
    return
  end
  self.nestState = state
  print("pagePetDuel 巢穴状态转换 " .. tostring(state))
  local page = C_UIMgr.GetPage(self.pageName)
  if page then
    page.overrideInputMap = C_InputManager_MapType.BlanketInputMap
  end
  if initCheck then
    L_AudioUtil.playBgm("Play_Music_GamePlay_Nest_TeamUp_Ingame")
  end
  if state == C_NestCoopStatus.NccsPreStart then
    L_AudioUtil.playSound("Set_State_GamePlay_Nest_Battle")
    self.bind.boardActive = false
    self:controlEnergyShow(false)
    C_InputManager.SetInputmap(C_InputManager_MapType.NestMovement, true)
    local page = C_UIMgr.GetPage(self.pageName)
    if page then
      page.overrideInputMap = C_InputManager_MapType.NestMovement
    end
    self.bind.go_BtnExitCopy = false
  elseif state == C_NestCoopStatus.NccsReady1 or state == C_NestCoopStatus.NccsReady2 then
    if C_KiboDuelSystemMgr:IsSoloNest() then
      L_AudioUtil.playSound("Set_State_GamePlay_Nest_Battle")
    else
      self.bind.go_BtnExitCopy = true
    end
    self:controlEnergyShow(false)
    C_InputManager.SetInputmap(C_InputManager_MapType.NestMovement, true)
    local page = C_UIMgr.GetPage(self.pageName)
    if page then
      page.overrideInputMap = C_InputManager_MapType.NestMovement
    end
    self.bindComponents.AnimRootCanvasGroup.blocksRaycasts = false
  elseif state == C_NestCoopStatus.NccsStart then
    L_AudioUtil.playSound("Set_State_GamePlay_Nest_Battle")
    self.bind.boardActive = true
    self:controlEnergyShow(true)
    self:dealNestStart()
    self:refreshInputMap()
    self.bindComponents.AnimRootCanvasGroup.blocksRaycasts = true
    if not self.playedStart and (initCheck or self.isReconnected) then
      self:playPageEffect(true, true, false, true)
      self.afterStartCountdown = true
      self:showShortCut(20, self.isPc)
      self.bind.go_socialRoulette = self.isMobile
    end
    self.bind.go_BtnExitCopy = false
  else
    self.bind.go_BtnExitCopy = false
  end
  self.isReconnected = false
end

function this:onStartTimelinePlayEnd()
  L_AudioUtil.playSound("Play_SFX_System_MountChallenge_Begin")
  self.bind.boardActive = true
  self:playPageEffect(true, true, true)
  self.playedStart = true
  Timer.once(4.45, function()
    if not self.isBind then
      return
    end
    self.afterStartCountdown = true
    self:refreshInputMap()
    self:showShortCut(20, self.isPc)
    self.bind.go_socialRoulette = self.isMobile
  end, self, self.gameObject)
end

function this:onStartSwap()
  self.bindComponents.bottomAnimator:SetBool("NestSwap", true)
end

function this:onEndSwap()
  self.bindComponents.bottomAnimator:SetBool("NestSwap", false)
end

function this:onReconnected()
  self.isReconnected = true
end

function this:onReconnectedLoadingEnd()
  L_AudioUtil.playBgm("Play_Music_GamePlay_Nest_TeamUp_Ingame")
  local state = C_NestCoopMgr.GetNestCoopStatus
  if state == C_NestCoopStatus.NccsPreStart then
    L_AudioUtil.playSound("Set_State_GamePlay_Nest_Battle")
  elseif state == C_NestCoopStatus.NccsReady1 or state == C_NestCoopStatus.NccsReady2 then
  else
    if state == C_NestCoopStatus.NccsStart then
      L_AudioUtil.playSound("Set_State_GamePlay_Nest_Battle")
    else
    end
  end
end

function this:registerArenaEvent()
  self.onEnterInitPickHandler = self.onEnterInitPickHandler or handler(self, self.onEnterInitPick)
  self.onFinishInitPickHandler = self.onFinishInitPickHandler or handler(self, self.onFinishInitPick)
  self.onEnterStoryPerformHandler = self.onEnterStoryPerformHandler or handler(self, self.onEnterStoryPerform)
  self.onArenaMainUIShowHandler = self.onArenaMainUIShowHandler or handler(self, self.onArenaMainUIShow)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.EnterInitPick, self.onEnterInitPickHandler)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.FinishInitPick, self.onFinishInitPickHandler)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.EnterStoryPerform, self.onEnterStoryPerformHandler)
  C_KiboArenaSystemMgr:RegisterEvent(C_EKiboArenaSystemEvent.MainUIShow, self.onArenaMainUIShowHandler)
end

function this:unregisterArenaEvent()
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.EnterInitPick, self.onEnterInitPickHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.FinishInitPick, self.onFinishInitPickHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.EnterStoryPerform, self.onEnterStoryPerformHandler)
  C_KiboArenaSystemMgr:UnregisterEvent(C_EKiboArenaSystemEvent.MainUIShow, self.onArenaMainUIShowHandler)
end

function this:onArenaMainUIShow(e, v)
  Timer.once(0.1, function()
    if not self.isBind then
      return
    end
    if not self.pageAnimator then
      self.pageAnimator = self.gameObject:GetComponent(typeof(CS.UnityEngine.Animator))
    end
    if self.pageAnimator then
      self.pageAnimator:SetBool("Show", true)
    end
    self.bindComponents.countDownAnimator:Play("Show")
    self.bindComponents.bottomAnimator:SetBool("Show", true)
    self.bindComponents.bottomAnimator:SetBool("PlayAnim", true)
  end, self, self.gameObject)
end

function this:arenaStateCheck(e, v)
  local serverState = C_KiboArenaMgr.serverStatus
  if serverState == CS.Protocal.Cs.KiboDuelArenaStatus.KiboDuelArenaStatusRegular then
    self:dealArenaStart()
  else
    self.bind.boardActive = false
  end
end

function this:onEnterInitPick(e, v)
  self.bind.boardActive = false
end

function this:onFinishInitPick(e, v)
  self:dealArenaStart()
end

function this:dealArenaStart()
  if self.playedStart then
    printLog("[奇波擂台系统] self.playedStart is true::: return")
    return
  end
  C_KiboDuelSystemMgr:StartDuel()
  L_UI:close("pagePetDuelRoleInfo")
  self:SetCameraStatus(true)
  self:showShortCut(208, self.IsInArena and self.isPc)
  self:showShortCut(209, self.IsInArena and self.isPc)
  self.bind.boardActive = true
  self:playPageEffect(true, true, false, true)
  self.playedStart = true
  self.duelStar = true
  C_InputManager.SetInputmap(C_InputManager_MapType.KiBoDuelMap, true)
  L_ShortCutManager:removeShortCut(C_EWorldType.KiboDuel)
  L_ShortCutManager:registerPageMainShortCut(C_EWorldType.KiboDuel)
  self.tipType = tipType.Normal
  printLog("Arena_DEBUG:dealStart")
  self:setUIActive(true)
  if self.mobilePetDuelControl then
    self.mobilePetDuelControl:DuelStart(true)
  end
  C_DriveManager.DispatchDrive(C_EExternalDrive.KiBoBattleUITimeOver)
end

function this:onClickAutoBattle()
  if not self.duelStar then
    print("duelStar = false 不能进自动战斗")
  end
  if C_KiboArenaSystemMgr.isInAutoBattle then
    C_KiboArenaSystemMgr:EnableAutoBattle(false)
  else
    C_KiboArenaSystemMgr:EnableAutoBattle(true)
  end
  self:refreshAutoState()
end

function this:onClickCancelAuto()
  C_KiboArenaSystemMgr:EnableAutoBattle(false)
  self:refreshAutoState()
end

function this:refreshAutoState()
  self.bind.go_autoSelect = C_KiboArenaSystemMgr.isInAutoBattle
  self.bind.go_autoNormal = not C_KiboArenaSystemMgr.isInAutoBattle
  self.bind.go_cancelAutoBtn = C_KiboArenaSystemMgr.isInAutoBattle
  self.bind.interactable_buttonContent = not C_KiboArenaSystemMgr.isInAutoBattle
  self.bindComponents.cardListCanvasGroup.interactable = not C_KiboArenaSystemMgr.isInAutoBattle
  self.bindComponents.cardListCanvasGroup.blocksRaycasts = not C_KiboArenaSystemMgr.isInAutoBattle
end

function this:onEnterStoryPerform()
  self:ShowRankInfo()
end

function this:ShowRankInfo()
  local option = {
    duelId = self.duelId,
    playerName = self.bind.playerNameText,
    enemyName = self.bind.enemyNameText
  }
  L_UI:open("pagePetDuelRoleInfo", option)
end

return this
