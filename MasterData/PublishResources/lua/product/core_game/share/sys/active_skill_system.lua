require("main_state_sys")
_class("ActiveSkillSystem", MainStateSystem)
ActiveSkillSystem = ActiveSkillSystem

function ActiveSkillSystem:_GetMainStateID()
  return GameStateID.ActiveSkill
end

function ActiveSkillSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local casterEntity = self:_GetActiveSkillCasterEntity(teamEntity)
  self:_DoRenderCheckNoGhost(TT, teamEntity, casterEntity)
  self:_DoRenderPreActiveSkillStart(TT)
  local posCasterOld = casterEntity:GetGridPosition()
  self:_DoLogicCastActiveSkill(teamEntity, casterEntity)
  self:_DoLogicTrapDeadSkill()
  self:_DoLogicActiveSkillMonsterDead(teamEntity, casterEntity)
  self:_DoRenderNotifyActiveSkillStart(TT, teamEntity, casterEntity)
  local isFinalAttack = self:_DoLogicCalcIsFinalAttack()
  local castSkillTaskID = self:_DoRenderPlayActiveSkill(isFinalAttack, teamEntity, casterEntity)
  local guideTaskID = self:_DoRenderGuidActiveSkill(TT, teamEntity, casterEntity)
  self:_WaitTasksEnd(TT, {guideTaskID}, true)
  self:_WaitTasksEnd(TT, {castSkillTaskID})
  self:_DoRenderWaitPlaySkillTaskFinish(TT)
  self:_DoRenderResetPieceAnim(TT, teamEntity, casterEntity)
  self:_DoRenderResetPreview(TT, teamEntity, casterEntity)
  self:_DoLogicUpdateBattleStat(teamEntity, casterEntity)
  self:_DoRenderNotifyActiveFinishBeforeMonsterDead(TT, teamEntity, casterEntity)
  self:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  local skillID = self:_DoLogicGetActiveSkillID(teamEntity)
  self:_DoRenderNotifyActiveSkillFinish(TT, teamEntity, casterEntity, skillID)
  self:_DoRenderGuideActiveSkillEnd(TT, teamEntity, casterEntity)
  self:_DoRenderShowAfterActiveSkill(TT, teamEntity, casterEntity)
  self:_DoRenderPopStarHideCasterEntity(TT, casterEntity)
  local listTrapTrigger = self:_DoLogicWaitTeleportFinish(teamEntity, casterEntity, posCasterOld)
  self:_DoLogicMonsterDead()
  self:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity, casterEntity)
  self:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  self:_DoLogicTrapDie()
  self:_DoRenderTrapDie(TT)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  self:_DoLogicCalcBuffAntiAttack(teamEntity, casterEntity)
  self:_DoRenderPlayBuffAntiAttack(TT, teamEntity, casterEntity)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  local ntTeamOrderChange = self:_DoLogicPetDead(teamEntity)
  self:_DoRenderPetDead(TT, teamEntity, ntTeamOrderChange)
  local traps, monsters = self:_DoLogicSpawnInWaveMonsters(MonsterWaveInternalTime.ActiveSkill)
  self:_DoRenderInWave(TT, traps, monsters)
  local monsterEntityIDArray, refreshAntiEntityIDList = self:_DoLogicCalcAntiAttack(casterEntity)
  self:_DoRenderPlayAntiAttack(TT, monsterEntityIDArray)
  self:_ClearShareSkillResult()
  self:_DoLogicRefreshAntiAttackParam(refreshAntiEntityIDList)
  self:_DoRenderRefreshAntiAttackParam(TT, refreshAntiEntityIDList)
  self:_DoLogicResetPickUp(teamEntity)
  self:_DoRenderResetPickUp()
  self:_DoLogicActiveSkillEnd(teamEntity, casterEntity)
  self:_DoRenderActiveSkillEnd(TT, teamEntity, casterEntity)
  self:_DoLogicSyncPieceType()
  self:_DoLogicSwitchMainState(teamEntity)
  self:_DoRenderGuideActiveSkillRealEnd(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoLogicActiveSkillMonsterDead(teamEntity, casterEntity)
  local deadMonsterList = self:_DoLogicMonsterDead()
end

function ActiveSkillSystem:_DoLogicCalcAntiAttack(casterEntity)
  local monsterEntityIDArray = {}
  if not casterEntity:HasPetPstID() then
    return monsterEntityIDArray
  end
  local buffSvc = self.world:GetService("BuffLogic")
  if buffSvc:IsPetNotTriggerAntiAttack(casterEntity) then
    return monsterEntityIDArray
  end
  local aiService = self.world:GetService("AI")
  local orderArray = aiService:StatLogicOrders(AILogicPeriodType.Anti)
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.Anti)
  local refreshAntiEntityIDList = {}
  local triggerSvc = self._world:GetService("Trigger")
  for _, orderElement in ipairs(orderArray) do
    for _, aiEntity in ipairs(orderElement[2]) do
      local nt = NTMonsterPostAntiAttack:New(aiEntity)
      triggerSvc:Notify(nt)
      table.insert(monsterEntityIDArray, aiEntity:GetID())
      local aiCmpt = aiEntity:AI()
      if aiCmpt:GetAntiSkill() then
        table.insert(refreshAntiEntityIDList, aiEntity:GetID())
      end
    end
  end
  local cBattleStat = self.world:BattleStat()
  if 0 < #monsterEntityIDArray then
    cBattleStat:SetLastAntiTriggerEntityID(casterEntity:GetID())
  else
    cBattleStat:SetLastAntiTriggerEntityID(nil)
  end
  return monsterEntityIDArray, refreshAntiEntityIDList
end

function ActiveSkillSystem:_GetActiveSkillCasterEntity(teamEntity)
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local casterPetEntityID = activeSkillCmpt:GetActiveSkillCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterPetEntityID)
  return casterEntity
end

function ActiveSkillSystem:_IsPetCastActiveSkill(teamEntity)
  local shareDataSvc = self._world:GetService("UtilData")
  return shareDataSvc:IsPetCastActiveSkill(teamEntity)
end

function ActiveSkillSystem:_DoLogicCastActiveSkill(teamEntity, casterEntity)
  local ntBeforeActiveSkillAttackStart = NTBeforeActiveSkillAttackStart:New(casterEntity)
  self._world:GetService("Trigger"):Notify(ntBeforeActiveSkillAttackStart)
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local activeSkillID = activeSkillCmpt:GetActiveSkillID()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  skillEffectResultContainer:Clear()
  local playerElementCmpt = casterEntity:Element()
  if playerElementCmpt then
    playerElementCmpt:SetUseSecondaryType(false)
  end
  Log.debug("CastActiveSkill skillID=", activeSkillID, " entity=", casterEntity:GetID())
  Log.info("Skill Record cast skill, ActiveSkillSystem active skillID=", activeSkillID, " casterEntityID=", casterEntity:GetID())
  local uniqueBattleStat = self._world:BattleStat()
  uniqueBattleStat:AffixBeginSkillDamageRecord(casterEntity:GetID(), activeSkillID)
  local logicService = self._world:GetService("SkillLogic")
  if self:_IsSkillInvalidated(casterEntity, activeSkillID) then
    skillEffectResultContainer:SetIsInvalidated(true)
  else
    logicService:CalcSkillEffect(casterEntity, activeSkillID, SkillType.Active)
  end
  local affixRecordSkillDamageTargetCount = uniqueBattleStat:AffixEndSkillDamageRecordAndGetCount(casterEntity:GetID(), activeSkillID)
  Log.info("Skill Record end skill, ActiveSkillSystem active skillID=", activeSkillID, " casterEntityID=", casterEntity:GetID(), " targetCount:", affixRecordSkillDamageTargetCount)
  if casterEntity:HasPetPstID() then
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
    local totalDamage = 0
    if damageResultArray then
      for _, damageResult in ipairs(damageResultArray) do
        totalDamage = totalDamage + damageResult:GetTotalDamage()
      end
    end
    local notifyData = NTActiveSkillAttackEnd:New(casterEntity, activeSkillID)
    notifyData:InitSkillResult(activeSkillID, skillEffectResultContainer:GetScopeResult())
    notifyData:SetSkillDamageTargetCount(affixRecordSkillDamageTargetCount)
    self._world:GetService("Trigger"):Notify(notifyData)
    local ntASAEBeforeMonsterDead = NTActiveSkillAttackEndBeforeMonsterDead:New(casterEntity, activeSkillID)
    ntASAEBeforeMonsterDead:InitSkillResult(activeSkillID, skillEffectResultContainer:GetScopeResult())
    self._world:GetService("Trigger"):Notify(ntASAEBeforeMonsterDead)
    self._world:GetService("Trigger"):Notify(NTActiveSkillDamageEnd:New(casterEntity, totalDamage))
    self._world:GetService("Trigger"):Notify(NTAfterPetSkillDamage:New(casterEntity, activeSkillID))
    local costCasterHPResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.CostCasterHP)
    local costCasterHP = 0
    if costCasterHPResultArray then
      for _, costResult in ipairs(costCasterHPResultArray) do
        local damageInfo = costResult:GetDamageInfo()
        local damageValue = damageInfo:GetDamageValue()
        local damageOnHpValue = damageInfo:GetChangeHP()
        costCasterHP = costCasterHP + -1 * damageOnHpValue
      end
    end
    self._world:GetService("Trigger"):Notify(NTActiveSkillCostCasterHPEnd:New(casterEntity, costCasterHP))
    self._world:GetDataLogger():AddDataLog("OnActiveSkillEnd", casterEntity, activeSkillID, totalDamage)
  elseif casterEntity:HasTrapID() then
    local notifyData = NTTrapActiveSkillEnd:New(casterEntity, activeSkillID)
    self._world:GetService("Trigger"):Notify(notifyData)
  end
  local svc = self._world:GetService("L2R")
  svc:L2RActiveAttackData(casterEntity, activeSkillID)
  svc:L2RBoardLogicData()
end

function ActiveSkillSystem:_IsSkillInvalidated(casterEntity, activeSkillID)
  local utilData = self._world:GetService("UtilData")
  return utilData:IsSkillInvalidated(casterEntity, activeSkillID)
end

function ActiveSkillSystem:_DoLogicUpdateBattleStat(teamEntity, casterEntity)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadMark)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetOneActiveSkillKillCount(teamEntity, #monsterGroup:GetEntities())
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local resultDic = skillEffectResultContainer:GetEffectResultDict()
  for k, v in pairs(resultDic) do
    battleStatCmpt:StatisticsColorSkillCount(teamEntity, k)
  end
end

function ActiveSkillSystem:_DoLogicCalcIsFinalAttack()
  local battleService = self._world:GetService("Battle")
  local isFinalAttack = battleService:IsFinalAttack()
  return isFinalAttack
end

function ActiveSkillSystem:_DoLogicTrapDeadSkill()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:CalcActiveSkillDeadTrapDeadSkill()
  self:_DoLogicTrapDie()
end

function ActiveSkillSystem:_DoLogicResetPickUp(teamEntity)
  local logicPickUpCmpt = teamEntity:LogicPickUp()
  logicPickUpCmpt:ResetLogicPickUp()
end

function ActiveSkillSystem:_DoLogicSwitchMainState(teamEntity)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local isTriggerDimension = boardServiceLogic:IsPlayerOnDimension(teamEntity)
  local nextState = self:_DoCheckNextState(teamEntity)
  if isTriggerDimension then
    if nextState == 2 then
      self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.RoundResult)
    elseif nextState == 1 then
      self._world:BattleStat():SetTriggerDimensionFlag(TriggerDimensionFlag.WaitInput)
    end
    self._world:EventDispatcher():Dispatch(GameEventType.ActiveSkillFinish, 3)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.ActiveSkillFinish, nextState)
  end
end

function ActiveSkillSystem:_DoCheckNextState(teamEntity)
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

function ActiveSkillSystem:_DoLogicActiveSkillEnd(teamEntity, casterEntity)
  casterEntity:RemoveActiveSkillPickUpComponent()
  local activeSkillCmpt = teamEntity:ActiveSkill()
  activeSkillCmpt:SetActiveSkillID(nil, nil)
end

function ActiveSkillSystem:_DoLogicWaitTeleportFinish(teamEntity, casterEntity, posCasterOld)
  local posCasterNew = casterEntity:GetGridPosition()
  local bHaveTeleport = posCasterNew ~= posCasterOld
  if not bHaveTeleport then
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    local teleportResultNew = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, 1)
    if teleportResultNew then
      local targetEntityID = teleportResultNew:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity and (targetEntity:HasTeam() or targetEntity:HasPet()) then
        local targetTeamEntity = targetEntity
        if targetTeamEntity:HasPet() then
          targetTeamEntity = targetEntity:Pet():GetOwnerTeamEntity()
        end
        local isLocalTeam = self._world:Player():IsLocalTeamEntity(targetTeamEntity)
        if isLocalTeam then
          bHaveTeleport = true
        end
      end
    end
  end
  local listTrapTrigger
  if bHaveTeleport then
    local sTrapLogic = self._world:GetService("TrapLogic")
    listTrapTrigger = sTrapLogic:TriggerTrapByTeleport(teamEntity, true)
  end
  return listTrapTrigger
end

function ActiveSkillSystem:_DoLogicCalcBuffAntiAttack(teamEntity, casterEntity)
  local isPetActiveSkill = self:_IsPetCastActiveSkill(teamEntity)
  if isPetActiveSkill then
    local ntActiveSkillAntiAttack = NTActiveSkillAntiAttack:New(casterEntity)
    self._world:GetService("Trigger"):Notify(ntActiveSkillAntiAttack)
  end
end

function ActiveSkillSystem:_DoLogicGetActiveSkillID(teamEntity)
  local activeSkillCmpt = teamEntity:ActiveSkill()
  local activeSkillID = activeSkillCmpt:GetActiveSkillID()
  return activeSkillID
end

function ActiveSkillSystem:_DoLogicRefreshAntiAttackParam(refreshAntiEntityIDList)
  if not refreshAntiEntityIDList or table.count(refreshAntiEntityIDList) == 0 then
    return
  end
  for _, entityID in ipairs(refreshAntiEntityIDList) do
    local entity = self._world:GetEntityByID(entityID)
    local attributeCmpt = entity:Attributes()
    local roundCount = "MaxAntiSkillCountPerRound"
    local curValue = attributeCmpt:GetAttribute(roundCount)
    local newValue = curValue - 1
    if newValue < 0 then
      newValue = 0
    end
    attributeCmpt:Modify(roundCount, newValue)
    local curAntiCount = attributeCmpt:GetAttribute("WaitActiveSkillCount")
    if curAntiCount == 0 then
      local originalAntiCount = attributeCmpt:GetAttribute("OriginalWaitActiveSkillCount")
      attributeCmpt:Modify("WaitActiveSkillCount", originalAntiCount)
    end
  end
end

function ActiveSkillSystem:_ClearShareSkillResult()
  local boardEntity = self._world:GetBoardEntity()
  boardEntity:ReplaceShareSkillResult()
end

function ActiveSkillSystem:_DoRenderCheckNoGhost(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderPreActiveSkillStart(TT)
end

function ActiveSkillSystem:_DoRenderNotifyActiveSkillStart(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderGuidActiveSkill(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderWaitPlaySkillTaskFinish(TT)
end

function ActiveSkillSystem:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderResetPieceAnim(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderResetPreview(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderNotifyActiveSkillFinish(TT, teamEntity, casterEntity, skillID)
end

function ActiveSkillSystem:_DoRenderNotifyActiveFinishBeforeMonsterDead(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderGuideActiveSkillEnd(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderGuideActiveSkillRealEnd(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderShowAfterActiveSkill(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderPlayActiveSkill(isFinalAttack, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderInWave(TT, traps, monsters)
end

function ActiveSkillSystem:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderPlayAntiAttack(TT, monsterEntityIDArray)
end

function ActiveSkillSystem:_DoRenderResetPickUp()
end

function ActiveSkillSystem:_DoRenderActiveSkillEnd(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderPlayBuffAntiAttack(TT, teamEntity, casterEntity)
end

function ActiveSkillSystem:_DoRenderRefreshAntiAttackParam(TT, refreshAntiEntityIDList)
end

function ActiveSkillSystem:_DoRenderPopStarHideCasterEntity(TT, casterEntity)
end
