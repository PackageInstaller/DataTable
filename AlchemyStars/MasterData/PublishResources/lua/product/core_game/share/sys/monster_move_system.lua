require("main_state_sys")
_class("MonsterMoveSystem", MainStateSystem)
MonsterMoveSystem = MonsterMoveSystem

function MonsterMoveSystem:_GetMainStateID()
  return GameStateID.MonsterTurn
end

function MonsterMoveSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  self:_DoLogicCloseAuroraTime()
  self:_DoRenderCloseAuroraTime(TT)
  self:_DoRenderHideBesiegedTips(TT)
  self:_WaitBeHitSkillFinish(TT)
  self:_DoLogicWorldBossStageBuff()
  self:_DoRenderWorldBossStageBuff(TT)
  self:_DoCalcMonsterLockHPState()
  self:_DoRenderMonsterLockHPState(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  self:_DoRenderHidePetInfo(TT)
  self:_DoLogicBuffBeforeTrapRoundCount(teamEntity)
  self:_DoRenderBuffBeforeTrapRoundCount(TT, teamEntity)
  local calcStateTraps = self:_DoLogicCalcTrapState()
  self:_DoRenderTrapState(TT, calcStateTraps)
  self:_DoLogicTrapBeforeMonster()
  self:_DoRenderTrapBeforeMonster(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  if self:_IsBattleEnd() then
    self:_DoLogicChangeGameState(teamEntity)
    self:_DoRenderShowPetInfo(TT)
    return
  end
  local traps, monsters = self:_DoLogicSpawnInWaveMonsters(MonsterWaveInternalTime.MonsterTurn)
  self:_DoRenderInWave(TT, traps, monsters)
  self:_DoRenderInnerStoryMonsterTurn(TT)
  self:_DoLogicMonsterBuff(teamEntity)
  self:_DoRenderMonsterBuff(TT)
  self:_WaitBeHitSkillFinish(TT)
  self:_DoLogicCalcMonsterAction()
  self:_DoRenderPlayMonsterAction(TT)
  self:_DoClearMonsterActionResult()
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  self:_DoLogicTrapAfterMonster()
  self:_DoRenderTrapAfterMonster(TT)
  self:_UpdateTrapGridRound(TT)
  self:_DoLogicMonsterBuffDelayed()
  self:_DoRenderMonsterBuffDelayed(TT)
  self:_DoLogicNotifyMonsterTurnEnd(teamEntity)
  self:_DoRenderNotifyMonsterTurnEnd(TT)
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  self:_DoPrintAIDebugInfo(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  if self._world:MatchType() == MatchType.MT_Chess then
    self:_DoLogicChessPetDead()
    self:_DoRenderChessPetDead(TT)
  end
  local battleResult = self:_IsBattleEnd()
  if not battleResult then
    self:_DoRenderShowInnerStory(TT)
  end
  self:_DoLogicChangeGameState(teamEntity)
end

function MonsterMoveSystem:_DoLogicCalcTrapState()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  return trapServiceLogic:CalcTrapState(TrapDestroyType.DestroyByRound)
end

function MonsterMoveSystem:_DoLogicChangeGameState(teamEntity)
  local mirageSvc = self._world:GetService("MirageLogic")
  local isMirageOpen = mirageSvc:IsMirageOpen()
  if isMirageOpen then
    self._world:EventDispatcher():Dispatch(GameEventType.MonsterTurnFinish, 3)
    return
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local isTriggerDimension = boardServiceLogic:IsPlayerOnDimension(teamEntity)
  if isTriggerDimension then
    self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.RoundResult)
    self._world:EventDispatcher():Dispatch(GameEventType.MonsterTurnFinish, 2)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.MonsterTurnFinish, 1)
  end
end

function MonsterMoveSystem:_DoLogicMonsterBuff(teamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:CalcMonsterBuffTurn(teamEntity)
end

function MonsterMoveSystem:_DoLogicMonsterBuffDelayed()
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:CalcMonsterBuffDelayedTurn()
end

function MonsterMoveSystem:_DoLogicNotifyMonsterTurnEnd(teamEntity)
  self._world:GetService("Trigger"):Notify(NTMonsterTurnEnd:New(teamEntity))
end

function MonsterMoveSystem:_DoCalcMonsterLockHPState()
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:RefreshLockHPLogic()
end

function MonsterMoveSystem:_DoLogicCalcMonsterAction()
  local monsterMoveServiceLogic = self.world:GetService("MonsterMoveLogic")
  monsterMoveServiceLogic:_DoLogicCalcMonsterAction()
end

function MonsterMoveSystem:_DoLogicTrapBeforeMonster()
  local monsterMoveServiceLogic = self.world:GetService("MonsterMoveLogic")
  monsterMoveServiceLogic:_DoLogicTrapBeforeMonster()
end

function MonsterMoveSystem:_DoLogicTrapAfterMonster()
  local monsterMoveServiceLogic = self.world:GetService("MonsterMoveLogic")
  monsterMoveServiceLogic:_DoLogicTrapAfterMonster()
end

function MonsterMoveSystem:_DoLogicWorldBossStageBuff()
  if self.world:MatchType(GetMatchTypeType.WorldBossBattle) == MatchType.MT_WorldBoss then
    local battleSvc = self.world:GetService("Battle")
    local buffLogicSvc = self.world:GetService("BuffLogic")
    local affixService = self.world:GetService("Affix")
    local entityArray = battleSvc:GetWorldBossEntityArray()
    for index, entity in ipairs(entityArray) do
      local monsterIDCmpt = entity:MonsterID()
      local monsterID = monsterIDCmpt:GetMonsterID()
      local addBuffList, newAttrData = monsterIDCmpt:WorldBossSwitchStage()
      if newAttrData then
        local attributeCmpt = entity:Attributes()
        local newAtk = newAttrData.atk
        local newDef = newAttrData.def
        if newAtk then
          newAtk = affixService:ChangeMonsterAttr(monsterID, newAtk, AffixAttrType.Attack)
          attributeCmpt:Modify("Attack", newAtk)
        end
        if newDef then
          newDef = affixService:ChangeMonsterAttr(monsterID, newDef, AffixAttrType.Defence)
          attributeCmpt:Modify("Defense", newDef)
        end
      end
      for i, buffID in ipairs(addBuffList) do
        buffLogicSvc:AddBuff(buffID, entity)
      end
      local changeStageCount = monsterIDCmpt:GetCurRoundChangeStageCount()
      for i = 1, changeStageCount do
        self.world:GetService("Trigger"):Notify(NTWorldBossStageSwitch:New(monsterIDCmpt:GetCurStage()))
      end
      monsterIDCmpt:ResetCurRoundChangeStageCount()
    end
  end
end

function MonsterMoveSystem:_DoClearMonsterActionResult()
  local boardEntity = self._world:GetBoardEntity()
  local recorderCmpt = self._world:GetBoardEntity():AIRecorder()
  recorderCmpt:ClearAIRecorder()
  boardEntity:ReplaceShareSkillResult()
end

function MonsterMoveSystem:_DoLogicBuffBeforeTrapRoundCount(teamEntity)
  local triggerSvc = self._world:GetService("Trigger")
  triggerSvc:Notify(NTMonsterRoundBeforeTrapRoundCount:New(teamEntity))
end

function MonsterMoveSystem:_DoRenderHidePetInfo(TT)
end

function MonsterMoveSystem:_DoRenderShowPetInfo(TT)
end

function MonsterMoveSystem:_DoRenderInnerStoryMonsterTurn(TT)
end

function MonsterMoveSystem:_DoRenderMonsterBuff(TT)
end

function MonsterMoveSystem:_DoRenderMonsterBuffDelayed(TT)
end

function MonsterMoveSystem:_DoRenderNotifyMonsterTurnEnd(TT)
end

function MonsterMoveSystem:_DoRenderShowInnerStory(TT)
end

function MonsterMoveSystem:_WaitBeHitSkillFinish(TT)
end

function MonsterMoveSystem:_DoRenderTrapState(TT, calcStateTraps)
end

function MonsterMoveSystem:_UpdateTrapGridRound(TT)
end

function MonsterMoveSystem:_DoRenderPlayMonsterAction(TT)
end

function MonsterMoveSystem:_DoRenderTrapBeforeMonster(TT)
end

function MonsterMoveSystem:_DoRenderTrapAfterMonster(TT)
end

function MonsterMoveSystem:_DoRenderHideBesiegedTips(TT)
end

function MonsterMoveSystem:_DoRenderInWave(TT, traps, monsters)
end

function MonsterMoveSystem:_DoRenderMonsterLockHPState(TT)
end

function MonsterMoveSystem:_DoRenderWorldBossStageBuff(TT)
end

function MonsterMoveSystem:_DoPrintAIDebugInfo(TT)
end

function MonsterMoveSystem:_DoRenderBuffBeforeTrapRoundCount(TT, teamEntity)
end
