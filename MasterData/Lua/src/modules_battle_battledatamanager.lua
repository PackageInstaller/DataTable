local this = class("battleDataManager", G_EventManagerBase)
this.event = {
  battleHeroLeave = "battleHeroLeave",
  battleHeroWaringLock = "battleHeroWaringLock",
  battleWinWithKillAll = "BattleWinWithKillAll",
  activeNodeWithGroupId = "ActiveNodeWithGroupId",
  switchCD = "SwitchCD",
  skillNotice = "SkillNotice",
  weakBreakNotice = "WeakBreakNotice",
  refreshCombo = "RefreshCombo",
  comboDisappear = "ComboDisappear",
  addShield = "AddShield",
  refreshShield = "RefreshShield",
  removeShield = "RemoveShield",
  battleFinished = "BattleFinished",
  onCastSkill = "OnCastSkill",
  onCastSwitchSkill = "onCastSwitchSkill",
  jointStrikeSkill = "JointStrikeSkill",
  refreshAttackStatus = "RefreshAttackStatus",
  cameraLookAtNotice = "CameraLookAtNotice",
  attackAlertNotice = "attackAlertNotice",
  petCatchNotice = "petCatchNotice",
  multiSkillNotice = "multiSkillNotice",
  skillStopNotice = "skillStopNotice",
  skillEventNotice = "skillEventNotice",
  switchSkillNotice = "switchSkillNotice",
  refreshSkillIcon = "RefreshSkillIcon",
  refreshPetSkill = "refreshPetSkill",
  setBattleStartTime = "setBattleStartTime",
  startBattleLimitTime = "startBattleLimitTime",
  leaveWallTime = "leaveWallTime",
  leaveWallBattle = "leaveWallBattle",
  canMountStatusChange = "canMountStatusChange",
  showBossHpNodeStatusChange = "showBossHpNodeStatusChange",
  playerFightStateChange = "playerFightStateChange",
  battleMonsterEntityInfoChange = "battleMonsterEntityInfoChange",
  bossShowSkillProcessBar = "bossShowSkillProcessBar",
  onStopSkill = "onStopSkill",
  triggerCountermeasures = "triggerCountermeasures",
  refreshUIChargingSkill = "refreshUIChargingSkill",
  petResponseSpChange = "petResponseSpChange",
  bossHpIndexChange = "bossHpIndexChange",
  bossAreaEnter = "bossAreaEnter",
  refreshPageMainLeftBottomLayout = "refreshPageMainLeftBottomLayout",
  refreshHeroSettleData = "refreshHeroSettleData"
}
this.battleKey = {
  IsDefaultWin = "IsDefaultWin"
}
local C_EPlayerFightStateEnum = CS.Lens.Gameplay.Modules.BigWorld.EPlayerFightState

function this:ctor()
  this.super.ctor(self)
end

function this:onEvent_playerUnityInit()
  self:playerUnitAddHandler()
end

function this:onEvent_playerUnityRemove()
  self:playerUnitRemoveHandler()
end

function this:playerUnitAddHandler()
  function self.playerEventHandle(type, args)
    if type == C_EUIEventType.UnderControlWarning then
      self:setHeroWarningLock(args.entityId, args.isControled)
    elseif type == C_EUIEventType.SwitchCD then
      self:onEvent_SwitchCD(args)
    elseif type == C_EUIEventType.SkillNotice then
      self:onEvent_SkillNotice(args)
    elseif type == C_EUIEventType.WeakBreakNotice then
      self:onEvent_WeakBreakNotice(args)
    elseif type == C_EUIEventType.CameraLookAtNotice then
      self:onEvent_CameraLookAtNotice(args)
    elseif type == C_EUIEventType.AttackAlertNotice then
      self:onEvent_AttackAlertNotice(args)
    elseif type == C_EUIEventType.PetCatchNotice then
      self:onEvent_PetCatchNotice(args)
    elseif type == C_EUIEventType.MultiSkillNotice then
      self:onEvent_MultiSkillNotice(args)
    elseif type == C_EUIEventType.SkillStopNotice then
      self:onEvent_SkillStopNotice(args)
    elseif type == C_EUIEventType.SkillEventNotice then
      self:onEvent_SkillEventNotice(args)
    elseif type == C_EUIEventType.SwitchSkillNotice then
      self:onEvent_SwitchSkillNotice(args)
    elseif type == C_EUIEventType.FightStateChange then
      self:onEvent_FightStateChange(args)
    elseif type == C_EUIEventType.Countermeasures then
      self:onEvent_TriggerCountermeasures(args)
    end
  end
  
  AzurWorld.playerMgr.myPlayerUnit:Register3CEntityEvent(self.playerEventHandle)
end

function this:playerUnitRemoveHandler()
  if AzurWorld.playerMgr.myPlayerUnit ~= nil then
    AzurWorld.playerMgr.myPlayerUnit:Unregister3CEntityEvent(self.playerEventHandle)
  end
end

function this:initialize()
  self.data = {
    heroLeaveState = {},
    heroWarningLock = {},
    dyingEntityDic = {},
    heroInCd = false,
    isCanMount = true,
    bShowBossHpNode = true,
    battleStartTime = nil,
    limitedTime = nil,
    playerFightState = C_EPlayerFightStateEnum.Idle,
    csMonsterEntityDic = {},
    bossAreaEnterTime = 0,
    bossAreaEnterCD = L_GameTpl:getGameConstTpl():getData("BOSS_AREA_INTO_TIPS_CD", L_Const.GameTplType.int),
    heroLevelSettleData = {},
    petLevelSettleData = {}
  }
  L_PlayerManager:addListener(L_PlayerManager.event.playerUnitInit, self.onEvent_playerUnityInit, self)
  L_PlayerManager:addListener(L_PlayerManager.event.playerUnitRemove, self.onEvent_playerUnityRemove, self)
  self.onEvent_HeroLeaveHandle = self.onEvent_HeroLeaveHandle or handler(self, self.onEvent_HeroLeave)
  C_ExternalManager.AddEvent(C_EExternalEventType.HeroLeave, self.onEvent_HeroLeaveHandle)
  self.onEvent_RefreshComboHandle = self.onEvent_RefreshComboHandle or handler(self, self.onEvent_RefreshCombo)
  C_ExternalManager.AddEvent(C_EExternalEventType.RefreshCombo, self.onEvent_RefreshComboHandle)
  self.onEvent_ComboDisappearHandle = self.onEvent_ComboDisappearHandle or handler(self, self.onEvent_ComboDisappear)
  C_ExternalManager.AddEvent(C_EExternalEventType.ComboDisappear, self.onEvent_ComboDisappearHandle)
  self.onEvent_AddShieldHandle = self.onEvent_AddShieldHandle or handler(self, self.onEvent_AddShield)
  C_ExternalManager.AddEvent(C_EExternalEventType.AddShield, self.onEvent_AddShieldHandle)
  self.onEvent_RefreshShieldHandle = self.onEvent_RefreshShieldHandle or handler(self, self.onEvent_RefreshShield)
  C_ExternalManager.AddEvent(C_EExternalEventType.RefreshShield, self.onEvent_RefreshShieldHandle)
  self.onEvent_RemoveShieldHandle = self.onEvent_RemoveShieldHandle or handler(self, self.onEvent_RemoveShield)
  C_ExternalManager.AddEvent(C_EExternalEventType.RemoveShield, self.onEvent_RemoveShieldHandle)
  self.onEvent_onCastSkillHandle = self.onEvent_onCastSkillHandle or handler(self, self.onEvent_onCastSkill)
  C_ExternalManager.AddEvent(C_EExternalEventType.OnCastSkill, self.onEvent_onCastSkillHandle)
  self.onEvent_onCastSwitchSkillHandle = self.onEvent_onCastSwitchSkillHandle or handler(self, self.onEvent_onCastSwitchSkill)
  C_ExternalManager.AddEvent(C_EExternalEventType.OnCastSwitchSkill, self.onEvent_onCastSwitchSkillHandle)
  self.onEvent_RefreshSkillIconHandle = self.onEvent_RefreshSkillIconHandle or handler(self, self.onEvent_RefreshSkillIcon)
  C_ExternalManager.AddEvent(C_EExternalEventType.RefreshSkillIcon, self.onEvent_RefreshSkillIconHandle)
  self.onEvent_RefreshPetSkillHandle = self.onEvent_RefreshPetSkillHandle or handler(self, self.onEvent_RefreshPetSkill)
  C_ExternalManager.AddEvent(C_EExternalEventType.RefreshPetSkill, self.onEvent_RefreshPetSkillHandle)
  self.onEvent_onCastJointStrikeSkillHandle = self.onEvent_onCastJointStrikeSkillHandle or handler(self, self.onEvent_onCastJointStrikeSkill)
  C_ExternalManager.AddEvent(C_EExternalEventType.JointStrikeSkill, self.onEvent_onCastJointStrikeSkillHandle)
  self.onEvent_RefreshAttackStatusHandle = self.onEvent_RefreshAttackStatusHandle or handler(self, self.onEvent_RefreshAttackStatus)
  C_ExternalManager.AddEvent(C_EExternalEventType.RefreshAttackStatus, self.onEvent_RefreshAttackStatusHandle)
  self.onEvent_leaveWallTimeHandle = self.onEvent_leaveWallTimeHandle or handler(self, self.onEvent_leaveWallTime)
  C_ExternalManager.AddEvent(C_EExternalEventType.LeaveWallTime, self.onEvent_leaveWallTimeHandle)
  self.onEvent_leaveWallBattleHandle = self.onEvent_leaveWallBattleHandle or handler(self, self.onEvent_leaveWallBattle)
  C_ExternalManager.AddEvent(C_EExternalEventType.LeaveWallBattle, self.onEvent_leaveWallBattleHandle)
  self.onEvent_onCatchSuccessHandle = self.onEvent_onCatchSuccessHandle or handler(self, self.onEvent_onCatchSuccess)
  C_ExternalManager.AddEvent(C_EExternalEventType.ShowPetCatchResult, self.onEvent_onCatchSuccessHandle)
  self.onEvent_StartBattleLimitTimeHandle = self.onEvent_StartBattleLimitTimeHandle or handler(self, self.onEvent_StartBattleLimitTime)
  C_ExternalManager.AddEvent(C_EExternalEventType.StartBattleLimitTime, self.onEvent_StartBattleLimitTimeHandle)
  self.onEvent_SetBattleStartTimeHandle = self.onEvent_SetBattleStartTimeHandle or handler(self, self.onEvent_SetBattleStartTime)
  C_ExternalManager.AddEvent(C_EExternalEventType.SetBattleStartTime, self.onEvent_SetBattleStartTimeHandle)
  self.onEvent_FirstEnterBattleHandle = self.onEvent_FirstEnterBattleHandle or handler(self, self.onEvent_FirstEnterBattle)
  C_ExternalManager.AddEvent(C_EExternalEventType.FirstEnterBattle, self.onEvent_FirstEnterBattleHandle)
  self.onEvent_MonsterInBattleStatusChangeHandle = self.onEvent_MonsterInBattleStatusChangeHandle or handler(self, self.onEvent_MonsterInBattleStatusChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.MonsterInBattleStatusChange, self.onEvent_MonsterInBattleStatusChangeHandle)
  self.onEvent_BossShowSkillProcessBarHandle = self.onEvent_BossShowSkillProcessBarHandle or handler(self, self.onEvent_BossShowSkillProcess)
  C_ExternalManager.AddEvent(C_EExternalEventType.ShowSkillProcessBar, self.onEvent_BossShowSkillProcessBarHandle)
  self.onEvent_OnStopSkillHandle = self.onEvent_OnStopSkillHandle or handler(self, self.onEvent_OnStopSkill)
  C_ExternalManager.AddEvent(C_EExternalEventType.OnStopSkill, self.onEvent_OnStopSkillHandle)
  self.onEvent_RefreshUIChargingSkillHandle = self.onEvent_RefreshUIChargingSkillHandle or handler(self, self.onEvent_RefreshUIChargingSkill)
  C_ExternalManager.AddEvent(C_EExternalEventType.UIChargingSkill, self.onEvent_RefreshUIChargingSkillHandle)
  self.onEvent_PetResponseSpChangeHandle = self.onEvent_PetResponseSpChangeHandle or handler(self, self.onEvent_PetResponseSpChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.PetResponseSpChange, self.onEvent_PetResponseSpChangeHandle)
  self.onEvent_BossHpIndexChangeHandle = self.onEvent_BossHpIndexChangeHandle or handler(self, self.onEvent_BossHpIndexChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.BossHpIndexChange, self.onEvent_BossHpIndexChangeHandle)
  self.onEvent_BossAreaEnterHandle = self.onEvent_BossAreaEnterHandle or handler(self, self.OnEvent_BossAreaEnter)
  C_WorldObjectEvent.instance:Listen(C_EWorldObjectEvent.MonsterInEnterBattleRangeChange, self.onEvent_BossAreaEnterHandle)
  self._onCutWorldComplete = self._onCutWorldComplete or handler(self, self.onCutWorldComplete)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  self.onEvent_PauseWorldHandle = self.onEvent_PauseWorldHandle or L_CommonUtil.handle(self.onEvent_PauseWorld, self)
  C_WorldEvent.instance:Listen(C_EWorldEvent.EPauseWorld, self.onEvent_PauseWorldHandle)
  self.onEvent_ResumeWorldHandle = self.onEvent_ResumeWorldHandle or L_CommonUtil.handle(self.onEvent_ResumeWorld, self)
  C_WorldEvent.instance:Listen(C_EWorldEvent.EResumeWorld, self.onEvent_ResumeWorldHandle)
end

function this:dispose()
  C_ExternalManager.RemoveEvent(C_EExternalEventType.HeroLeave, self.onEvent_HeroLeaveHandle)
  self:playerUnitRemoveHandler()
  C_EntityManager.RemoveOnEntityDyingHandler(self.entityDyingHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.StartBattleLimitTime, self.onEvent_StartBattleLimitTimeHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.SetBattleStartTime, self.onEvent_SetBattleStartTimeHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ActiveNodeWithGroupId, self.onEvent_ActiveNodeWithGroupIdHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ComboDisappear, self.onEvent_ComboDisappear)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.RefreshCombo, self.onEvent_RefreshComboHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.AddShield, self.onEvent_RefreshShieldHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.RefreshShield, self.onEvent_RefreshShieldHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.RemoveShield, self.onEvent_RemoveShieldHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.OnCastSkill, self.onEvent_onCastSkillHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.OnCastSwitchSkill, self.onEvent_onCastSwitchSkillHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.JointStrikeSkill, self.onEvent_onCastJointStrikeSkillHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.RefreshAttackStatus, self.onEvent_RefreshAttackStatusHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ShowPetCatchResult, self.onEvent_onCatchSuccessHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.LeaveWallBattle, self.onEvent_leaveWallBattleHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.LeaveWallTime, self.onEvent_leaveWallTimeHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.UIChargingSkill, self.onEvent_RefreshUIChargingSkillHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.PetResponseSpChange, self.onEvent_PetResponseSpChangeHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.BossHpIndexChange, self.onEvent_BossHpIndexChangeHandle)
  C_WorldObjectEvent.instance:Cancel(C_EWorldObjectEvent.MonsterInEnterBattleRangeChange, self.onEvent_BossAreaEnterHandle)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerManager:removeListener(L_PlayerManager.event.playerUnitInit, self.onEvent_playerUnityInit, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playerUnitRemove, self.onEvent_playerUnityRemove, self)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.EPauseWorld, self.onEvent_PauseWorldHandle)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.EResumeWorld, self.onEvent_ResumeWorldHandle)
  self.data = nil
end

function this:getIsInBattle()
  return self:checkPlayerBattle()
end

function this:getIsInCD()
  return self.data and self.data.heroInCd or false
end

function this:onEvent_leaveWallTime(args)
  self:sendEvent(this.event.leaveWallTime, args)
end

function this:onEvent_leaveWallBattle()
  self:sendEvent(this.event.leaveWallBattle)
end

function this:onEvent_SwitchCD(args)
  self.data.heroInCd = not args.canSwitch
  self:sendEvent(this.event.switchCD, args)
end

function this:onEvent_SkillNotice(args)
  self:sendEvent(this.event.skillNotice, args)
end

function this:onEvent_WeakBreakNotice(args)
  self:sendEvent(this.event.weakBreakNotice, args)
end

function this:onEvent_CameraLookAtNotice(args)
  self:sendEvent(this.event.cameraLookAtNotice, args)
end

function this:onEvent_AttackAlertNotice(args)
  self:sendEvent(this.event.attackAlertNotice, args)
end

this.noticeCatchEnterMsgReceiveData = nil

function this:onEvent_PetCatchNotice(args)
  if args.noticeType == "noticeEnterCatch" then
    L_UI:open("pageBattlePetCatch", {
      petInfo = args.petInfos
    })
    self.noticeCatchEnterMsgReceiveData = {
      petInfo = args.petInfos
    }
  elseif args.noticeType == "noticeCatchEnterMsgReceive" then
    self.noticeCatchEnterMsgReceiveData = {
      petInfo = args.petInfos
    }
  end
  self:sendEvent(this.event.petCatchNotice, args)
end

function this:onEvent_MultiSkillNotice(args)
  self:sendEvent(this.event.multiSkillNotice, args)
end

function this:onEvent_SkillStopNotice(args)
  self:sendEvent(this.event.skillStopNotice, args)
end

function this:onEvent_SkillEventNotice(args)
  self:sendEvent(this.event.skillEventNotice, args)
end

function this:onEvent_SwitchSkillNotice(args)
  self:sendEvent(this.event.switchSkillNotice, args)
end

function this:onEvent_FightStateChange(args)
  self.data.playerFightState = args.state
  if args.state == C_EPlayerFightStateEnum.Idle then
    self:resetBattleMountState()
    self:resetBattleShowBossHpNodeState()
  end
  self:sendEvent(this.event.playerFightStateChange, args.state)
end

function this:onEvent_TriggerCountermeasures(args)
  self:sendEvent(this.event.triggerCountermeasures, args)
end

function this:onEvent_RefreshUIChargingSkill(args)
  self:sendEvent(this.event.refreshUIChargingSkill, args)
end

function this:onEvent_PetResponseSpChange(args)
  self:sendEvent(this.event.petResponseSpChange, args)
end

function this:onEvent_BossHpIndexChange(args)
  self:sendEvent(this.event.bossHpIndexChange, args)
end

function this:onEvent_MonsterInBattleStatusChange(args)
  local monsterCsEntity = C_EntityManager.GetEntity(args.intArg)
  if not monsterCsEntity then
    return
  end
  local entityScene = monsterCsEntity.entity:GetMonsterScene()
  if entityScene == CS.Lens.Gameplay.Modules.BigWorld.EEntityScene.Battle then
    L_EntityManager:registerCSEntityTriggerStack(monsterCsEntity)
    return
  end
  L_EntityManager:unRegisterCSEntityTriggerStack(monsterCsEntity)
end

function this:onEvent_BossShowSkillProcess(args)
  self:sendEvent(this.event.bossShowSkillProcessBar, args)
end

function this:onEvent_OnStopSkill(args)
  self:sendEvent(this.event.onStopSkill, args)
end

function this:OnEvent_BossAreaEnter(eventId, c_varList)
  local bEnter = c_varList:GetBool(0)
  local monsterId = c_varList:GetInt(2)
  local table = {enter = bEnter, monsterId = monsterId}
  if not bEnter then
    self:sendEvent(this.event.bossAreaEnter, table)
    return
  end
  if C_TimeManager.globalTime - self.data.bossAreaEnterTime <= self.data.bossAreaEnterCD then
    return
  end
  if self:checkPlayerBattle() then
    return
  end
  self.data.bossAreaEnterTime = C_TimeManager.globalTime
  self:sendEvent(this.event.bossAreaEnter, table)
end

function this:onCutWorldComplete()
  self:resetPlayerBattleState()
end

function this:onStartBattle()
end

function this:onExitBattle(finishType)
  self:sendEvent(self.event.battleFinished, {finishType = finishType})
end

function this:onEvent_HeroLeave(param)
  self.data.heroLeaveState[param.entityId] = param.isLeaveStart
  self:sendEvent(this.event.battleHeroLeave, param)
end

function this:onEvent_RefreshCombo(param)
  self:sendEvent(this.event.refreshCombo, param)
end

function this:onEvent_ComboDisappear(args)
  self:sendEvent(self.event.comboDisappear, args)
end

function this:onEvent_RefreshSkillIcon(args)
  self:sendEvent(self.event.refreshSkillIcon, args)
end

function this:onEvent_RefreshPetSkill(args)
  self:sendEvent(self.event.refreshPetSkill, args)
end

function this:onEvent_AddShield(args)
  self:sendEvent(self.event.addShield, args)
end

function this:onEvent_onCastJointStrikeSkill(args)
  self:sendEvent(self.event.jointStrikeSkill, args)
end

function this:onEvent_RemoveShield(args)
  self:sendEvent(self.event.removeShield, args)
end

function this:onEvent_RefreshShield(args)
  self:sendEvent(self.event.refreshShield, args)
end

function this:onEvent_onCastSkill(args)
  self:sendEvent(self.event.onCastSkill, args)
end

function this:onEvent_onCastSwitchSkill(args)
  self:sendEvent(self.event.onCastSwitchSkill, args)
end

function this:onEvent_RefreshAttackStatus(args)
  self:sendEvent(self.event.refreshAttackStatus, args)
end

function this:onEvent_FirstEnterBattle()
  printf("开始战斗了：：：：：：")
end

function this:onEvent_onCatchSuccess(args)
  local guid = args.GUID
  printf("抓捕宠物", guid)
  local entity = L_PetStore:getPetItem(guid)
  if entity then
    local options = {
      pet = entity,
      showType = L_Const.getPetShowType.long,
      closeCallback = function(alreadyGetBefore)
        if not alreadyGetBefore then
          AzurWorld.PetCatchManagerMgr:CloseCatchResultUI()
        end
        L_RewardManager:showBattlePage(nil, L_Const.FightRewardReason.FRR_Catch)
      end,
      voiceCallBack = function()
        L_PetStore:playPetVoiceSound(entity.id, L_PetConst.PetSystemVoiceType.CaptureSuccess)
      end
    }
    local top = C_UIMgr.GetTopPage(0)
    if top and top.name == "pageMainCity" then
      L_PetManager:commonGetPet(options, L_PetManager.gmForceGetPetNew, nil, false)
    else
      L_PetManager:commonGetPetAsOwned(options)
    end
  else
    errorf("抓捕的宠物没有数据,guid=" .. guid)
  end
end

function this:onEvent_SetBattleStartTime(args)
  self.data.battleStartTime = args.floatArg
  self:sendEvent(self.event.setBattleStartTime, args)
end

function this:onEvent_StartBattleLimitTime(args)
  self.data.limitedTime = args.intArg
  self:sendEvent(self.event.startBattleLimitTime, args)
end

function this:getBattleLimitTime()
  return self.data.limitedTime
end

function this:getBattleStartTime()
  return self.data.battleStartTime
end

function this:getHeroLeaveState(entityId)
  return self.data.heroLeaveState[entityId]
end

function this:setHeroWarningLock(entityId, isControled)
  local entity = C_EntityManager.GetEntity(entityId)
  self.data.heroWarningLock[entity.data.UUID] = isControled
  self:sendEvent(this.event.battleHeroWaringLock, entity.data.UUID)
end

function this:getHeroWarningLock(heroId)
  return self.data.heroWarningLock[heroId] or false
end

function this:setIsCanMount(flag)
  self.data.isCanMount = flag
  self:sendEvent(self.event.canMountStatusChange, flag)
end

function this:getIsCanMount()
  if self.data then
    return self.data.isCanMount == true
  end
  return true
end

function this:setShowBossHpNode(bHide)
  self.data.bShowBossHpNode = not bHide
  self:sendEvent(self.event.showBossHpNodeStatusChange)
end

function this:getShowBossHpNode()
  if self.data then
    return self.data.bShowBossHpNode
  end
  return true
end

function this:setCapturePetBallData(saveData)
  if saveData.sphereId == 0 then
    return
  end
  local capturePetBallData = {}
  capturePetBallData.id = saveData.sphereId
  capturePetBallData.quality = saveData.quality
  capturePetBallData.cnt = saveData.cnt
  self.data.capturePetBallData = capturePetBallData
  local itemTpl = L_GameTpl:getCommonItemTpl():getTplById(capturePetBallData.id)
  if itemTpl then
    AzurWorld.PetCatchManagerMgr:SetBattleCatchBall(L_GameTpl:getCommonItemTpl():getSubId(itemTpl), capturePetBallData.id)
  end
end

function this:getCapturePetBallData()
  return self.data.capturePetBallData
end

function this:resetPlayerBattleState()
  self.data.playerFightState = C_EPlayerFightStateEnum.Idle
  self:resetBattleMountState()
  self:resetBattleShowBossHpNodeState()
end

function this:resetBattleMountState()
  self.data.isCanMount = true
  self.data.battleStartTime = nil
  self.data.limitedTime = nil
end

function this:resetBattleShowBossHpNodeState()
  self.data.bShowBossHpNode = true
end

function this:checkPlayerBattle()
  return self.data.playerFightState == C_EPlayerFightStateEnum.Fighting
end

function this:getMonsterCsEntityDic()
  return self.data.csMonsterEntityDic
end

function this:addMonsterCsEntity(entityId, bAdd, csEntity)
  AzurWorld.UIBattleDataMgr:AddMonsterEntity(entityId, bAdd, csEntity)
  if not bAdd then
    self.data.csMonsterEntityDic[entityId] = nil
    self:sendEvent(this.event.battleMonsterEntityInfoChange, false, entityId)
    return
  end
  self.data.csMonsterEntityDic[entityId] = csEntity
  self:sendEvent(this.event.battleMonsterEntityInfoChange, true, entityId)
end

local _fightProhibitTbl = L_GameTpl:getFightProhibitTpl()

function this:getBattleBlockTips(blockTypeId)
  local cfg = _fightProhibitTbl:getTplById(blockTypeId)
  return _fightProhibitTbl:getBlockTips(cfg)
end

function this:getHeroLevelSettleData(heroGuid)
  if math.isEmpty(heroGuid) then
    return {}
  end
  return self.data.heroLevelSettleData[heroGuid] or {}
end

function this:getPetLevelSettleData(petGuid)
  if math.isEmpty(petGuid) then
    return {}
  end
  return self.data.petLevelSettleData[petGuid] or {}
end

function this:setLevelSettleData(roleType, guid, key)
  if roleType == L_Const.roleType.pet then
    self.data.petLevelSettleData[guid] = self.data.petLevelSettleData[guid] or {}
    self.data.petLevelSettleData[guid][key] = true
  elseif roleType == L_Const.roleType.hero then
    self.data.heroLevelSettleData[guid] = self.data.heroLevelSettleData[guid] or {}
    self.data.heroLevelSettleData[guid][key] = true
  end
  self:sendEvent(self.event.refreshHeroSettleData, roleType, guid)
end

function this:clearLevelSettleDataByGuid(roleType, guid)
  if roleType == L_Const.roleType.pet then
    self.data.petLevelSettleData[guid] = nil
  elseif roleType == L_Const.roleType.hero then
    self.data.heroLevelSettleData[guid] = nil
  end
end

function this:clearLevelSettleData()
  if self.data == nil then
    return
  end
  self.data.heroLevelSettleData = {}
  self.data.petLevelSettleData = {}
end

function this:onEvent_PauseWorld(args)
  L_BuffStore:pauseWorldBuff()
end

function this:onEvent_ResumeWorld(args)
  L_BuffStore:resumeWorldBuff()
end

return this
