require("main_state_sys")
_class("PersonaSkillSystem", MainStateSystem)
PersonaSkillSystem = PersonaSkillSystem

function PersonaSkillSystem:_GetMainStateID()
  return GameStateID.PersonaSkill
end

function PersonaSkillSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local featureSkillCmpt = teamEntity:FeatureSkill()
  local skillID = featureSkillCmpt:GetFeatureSkillID()
  local featureType = featureSkillCmpt:GetFeatureType()
  local casterEntityID = featureSkillCmpt:GetFeatureSkillCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  self:_DoRenderPreFeatureSkillStart(TT)
  local posCasterOld = teamEntity:GetGridPosition()
  self:_DoLogicCastFeatureSkill(teamEntity, casterEntity)
  self:_DoLogicTrapDeadSkill()
  self:_DoLogicFeatureSkillMonsterDead(teamEntity, casterEntity)
  self:_DoRenderNotifyFeatureSkillStart(TT, teamEntity, casterEntity)
  local isFinalAttack = self:_DoLogicCalcIsFinalAttack()
  local castSkillTaskID = self:_DoRenderPlayFeatureSkill(isFinalAttack, teamEntity, casterEntity)
  self:_WaitTasksEnd(TT, {castSkillTaskID})
  self:_DoRenderWaitPlaySkillTaskFinish(TT)
  self:_DoRenderResetPieceAnim(TT, teamEntity, casterEntity)
  self:_DoRenderResetPreview(TT, teamEntity, casterEntity)
  self:_DoLogicUpdateBattleStat(skillID)
  self:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  self:_DoRenderNotifyFeatureSkillFinish(TT, teamEntity, casterEntity, featureType, skillID)
  self:_DoRenderShowAfterFeatureSkill(TT, teamEntity, casterEntity)
  local listTrapTrigger = self:_DoLogicWaitTeleportFinish(teamEntity, casterEntity, posCasterOld)
  self:_DoLogicMonsterDead()
  self:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity, casterEntity)
  self:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  self:_DoLogicResetPickUp(teamEntity)
  self:_DoRenderResetPickUp()
  self:_DoLogicFeatureSkillEnd(teamEntity, casterEntity)
  self:_DoRenderFeatureSkillEnd(TT, teamEntity, casterEntity)
  self:_DoLogicSyncPieceType()
  self:_DoLogicSwitchMainState(teamEntity)
end

function PersonaSkillSystem:_DoLogicFeatureSkillMonsterDead(teamEntity, casterEntity)
  local deadMonsterList = self:_DoLogicMonsterDead()
end

function PersonaSkillSystem:_DoLogicCastFeatureSkill(teamEntity, casterEntity)
  local featureSkillCmpt = teamEntity:FeatureSkill()
  local skillID = featureSkillCmpt:GetFeatureSkillID()
  local featureType = featureSkillCmpt:GetFeatureType()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:Clear()
  Log.debug("CastPersonaSkill skillID=", skillID)
  local logicService = self._world:GetService("SkillLogic")
  logicService:CalcSkillEffect(casterEntity, skillID, SkillType.FeatureSkill)
  local notifyData = NTFeatureSkillAttackEnd:New(featureType, skillID)
  self._world:GetService("Trigger"):Notify(notifyData)
  local svc = self._world:GetService("L2R")
  svc:L2RFeatureAttackData(casterEntity, skillID)
  svc:L2RBoardLogicData()
end

function PersonaSkillSystem:_DoLogicUpdateBattleStat(skillID)
  local configsvc = self._world:GetService("Config")
  local skillConfig = configsvc:GetSkillConfigData(skillID)
  local boardEntity = self._world:GetBoardEntity()
  local logicFeatureCmpt = boardEntity:LogicFeature()
  if skillConfig:GetSkillPickType() == SkillPickUpType.FeatureSkipPreview then
    local battleStatCmpt = self._world:BattleStat()
    local levelRound = battleStatCmpt:GetLevelTotalRoundCount()
    logicFeatureCmpt:AddBanPetSkillCastRound(skillID, levelRound)
  end
end

function PersonaSkillSystem:_DoLogicCalcIsFinalAttack()
  local battleService = self._world:GetService("Battle")
  local isFinalAttack = battleService:IsFinalAttack()
  return isFinalAttack
end

function PersonaSkillSystem:_DoLogicTrapDeadSkill()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:CalcActiveSkillDeadTrapDeadSkill()
  self:_DoLogicTrapDie()
end

function PersonaSkillSystem:_DoLogicResetPickUp(teamEntity)
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  logicPickUpCmpt:ResetLogicPickUp()
end

function PersonaSkillSystem:_DoLogicSwitchMainState(teamEntity)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local isTriggerDimension = boardServiceLogic:IsPlayerOnDimension(teamEntity)
  local nextState = self:_DoCheckNextState(teamEntity)
  if isTriggerDimension then
    if nextState == 2 then
      self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.RoundResult)
    elseif nextState == 1 then
      self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.WaitInput)
    end
    self._world:EventDispatcher():Dispatch(GameEventType.PersonaSkillFinish, 3)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.PersonaSkillFinish, nextState)
  end
end

function PersonaSkillSystem:_DoCheckNextState(teamEntity)
  local battleStatCmpt = self._world:BattleStat()
  local nextState = 0
  if battleStatCmpt:AssignWaveResult() then
    nextState = 1
  else
    local battleService = self._world:GetService("Battle")
    local allMonsterDead = battleService:CheckAllMonstersDead(teamEntity)
    local specificTrapDead = battleService:CheckSpecificTrapDead()
    if allMonsterDead and specificTrapDead then
      local isLastWave = battleStatCmpt:IsLastWave()
      if isLastWave then
        nextState = 1
      else
        nextState = 2
      end
    else
      nextState = 1
    end
    local waveFinish = battleService:BattleCalculation(teamEntity)
    if waveFinish then
      nextState = 2
    end
  end
  return nextState
end

function PersonaSkillSystem:_DoLogicFeatureSkillEnd(teamEntity, casterEntity)
  casterEntity:RemoveActiveSkillPickUpComponent()
  local featureSkillCmpt = teamEntity:FeatureSkill()
  featureSkillCmpt:SetFeatureSkillID(nil, nil, nil)
  local boardEntity = self._world:GetBoardEntity()
  local logicFeatureCmpt = boardEntity:LogicFeature()
  if logicFeatureCmpt then
    logicFeatureCmpt:ClearShopRecentSelectedCellList()
  end
end

function PersonaSkillSystem:_DoLogicWaitTeleportFinish(teamEntity, casterEntity, posCasterOld)
  local posCasterNew = teamEntity:GetGridPosition()
  local bHaveTeleport = posCasterNew ~= posCasterOld
  if not bHaveTeleport then
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    local teleportResultNew = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, 1)
    if teleportResultNew then
      bHaveTeleport = true
    end
  end
  local listTrapTrigger
  if bHaveTeleport then
    local sTrapLogic = self._world:GetService("TrapLogic")
    listTrapTrigger = sTrapLogic:TriggerTrapByTeleport(teamEntity, true)
  end
  return listTrapTrigger
end

function PersonaSkillSystem:_DoRenderPreFeatureSkillStart(TT)
end

function PersonaSkillSystem:_DoRenderNotifyFeatureSkillStart(TT, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderWaitPlaySkillTaskFinish(TT)
end

function PersonaSkillSystem:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderResetPieceAnim(TT, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderResetPreview(TT, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderNotifyFeatureSkillFinish(TT, teamEntity, casterEntity, featureType, skillID)
end

function PersonaSkillSystem:_DoRenderShowAfterFeatureSkill(TT, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderPlayFeatureSkill(isFinalAttack, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
end

function PersonaSkillSystem:_DoRenderResetPickUp()
end

function PersonaSkillSystem:_DoRenderFeatureSkillEnd(TT, teamEntity, casterEntity)
end
