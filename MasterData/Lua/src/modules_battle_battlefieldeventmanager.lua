local this = class("battleFieldEventManager", G_EventManagerBase)

function this:ctor()
  this.super.ctor(self)
end

function this:initialize()
  self.onEvent_battleEnterHandle = self.onEvent_battleEnterHandle or handler(self, self.onEvent_battleEnter)
  C_ExternalManager.AddEvent(C_EExternalEventType.BattleEnter, self.onEvent_battleEnterHandle)
  self.onEvent_battleStartHandle = self.onEvent_battleStartHandle or handler(self, self.onEvent_batterStart)
  C_ExternalManager.AddEvent(C_EExternalEventType.BattleStart, self.onEvent_battleStartHandle)
  self.onEvent_battleExitHandle = self.onEvent_battleExitHandle or handler(self, self.onEvent_battleExit)
  C_ExternalManager.AddEvent(C_EExternalEventType.BattleExit, self.onEvent_battleExitHandle)
  self.onEvent_battleFieldCreateMonsterHandle = self.onEvent_battleFieldCreateMonsterHandle or handler(self, self.onEvent_battleFieldCreateMonster)
  C_ExternalManager.AddEvent(C_EExternalEventType.BattleFieldCreateMonster, self.onEvent_battleFieldCreateMonsterHandle)
  self.onEvent_operatePlayerMountStatusHandle = self.onEvent_operatePlayerMountStatusHandle or handler(self, self.onEvent_operatePlayerMountStatus)
  C_ExternalManager.AddEvent(C_EExternalEventType.OperatePlayerMountStatus, self.onEvent_operatePlayerMountStatusHandle)
  self.onEvent_hideBossHPBarHandle = self.onEvent_hideBossHPBarHandle or handler(self, self.onEvent_hideBossHPBar)
  C_ExternalManager.AddEvent(C_EExternalEventType.HideBossHPBar, self.onEvent_hideBossHPBarHandle)
  self.entityRemoveHandle = self.entityRemoveHandle or handler(self, self.onEvent_EntityRemove)
  C_EntityManager.AddEntityOnRemoveHandler(self.entityRemoveHandle)
  self.onEvent_tmpPauseInputHandle = self.onEvent_tmpPauseInputHandle or handler(self, self.onEvent_tmpPauseInput)
  C_ExternalManager.AddEvent(C_EExternalEventType.TmpPauseInput, self.onEvent_tmpPauseInputHandle)
  self.onEvent_MonsterInBattleStatusChangeHandle = self.onEvent_MonsterInBattleStatusChangeHandle or handler(self, self.onEvent_MonsterInBattleStatusChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.MonsterInBattleStatusChange, self.onEvent_MonsterInBattleStatusChangeHandle)
end

function this:dispose()
  C_ExternalManager.RemoveEvent(C_EExternalEventType.BattleEnter, self.onEvent_battleEnterHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.BattleStart, self.onEvent_battleStartHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.BattleExit, self.onEvent_battleExitHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.BattleFieldCreateMonster, self.onEvent_battleFieldCreateMonsterHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.OperatePlayerMountStatus, self.onEvent_operatePlayerMountStatusHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.HideBossHPBar, self.onEvent_hideBossHPBarHandle)
  C_EntityManager.RemoveEntityOnRemoveHandler(self.entityRemoveHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.TmpPauseInput, self.onEvent_tmpPauseInputHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.MonsterInBattleStatusChange, self.onEvent_MonsterInBattleStatusChangeHandle)
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

function this:onEvent_operatePlayerMountStatus(args)
  L_BattleDataManager:setIsCanMount(args.intArg == 0)
end

function this:onEvent_hideBossHPBar(args)
  L_BattleDataManager:setShowBossHpNode(args.boolArg)
end

function this:onEvent_battleEnter()
  L_BattleManager:sendEvent(L_BattleManager.event.battleEnter)
end

function this:onEvent_batterStart()
  L_BattleManager:sendBattleEvent(L_BattleManager.event.battleStart)
end

function this:onEvent_battleExit(args)
  L_BattleStore:exitBattle()
  L_BattleManager:sendBattleEvent(L_BattleManager.event.exitBattle, args)
  L_BattleDataManager:onExitBattle(args.finishType)
end

function this:onEvent_battleFieldCreateMonster(args)
  L_EntityManager:registerCSEntityTriggerStack(args.summon)
end

function this:onEvent_EntityRemove(entity)
  L_EntityManager:unRegisterCSEntityTriggerStack(entity)
end

function this:onEvent_tmpPauseInput(args)
  L_UIManager:tmpPauseInput(args.pause)
end

return this
