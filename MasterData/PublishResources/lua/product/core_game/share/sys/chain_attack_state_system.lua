require("main_state_sys")
_class("ChainAttackStateSystem", MainStateSystem)
ChainAttackStateSystem = ChainAttackStateSystem

function ChainAttackStateSystem:_GetMainStateID()
  return GameStateID.ChainAttack
end

function ChainAttackStateSystem:_OnMainStateEnter(TT)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if (self._world:MatchType() == MatchType.MT_BlackFist or self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro) and self:_IsBattleEnd() then
    self:_DoLogicClearChainPath(teamEntity)
    self:_DoRenderClearChainPath()
    self:_DoLogicClearElementSecondaryType(teamEntity)
    self:_DoLogicGotoNextState(false, teamEntity)
    return
  end
  self:_DoLogicBeforeCalcChain()
  self:_DoRenderBeforeCalcChain(TT)
  self:_DoLogicCalcChainSkill(teamEntity)
  self:_DoLogicMonsterDeadEx()
  self:_DoRenderShowChainAttack(TT, teamEntity)
  self:_DoRenderWaitPlaySkillTaskFinish(TT)
  self:_DoLogicMonsterDead()
  self:_DoRenderMonsterDead(TT, teamEntity)
  self:_DoLogicCalc3StarProgress()
  self:_DoLogicCalcBonusObjective()
  self:_DoRenderClearLastAttack()
  local traps, monsters = self:_DoLogicSpawnInWaveMonsters(MonsterWaveInternalTime.ChainAttack)
  self:_DoRenderInWave(TT, traps, monsters)
  local isAuroraTime = self:_DoLogicCheckAuroraTime(teamEntity)
  self:_DoRenderNotifyEnterAuroraTimeInChainSys(TT, isAuroraTime)
  self:_DoRenderResetAuroraTimeState(TT)
  self:_DoLogicClearChainPath(teamEntity)
  self:_DoRenderClearChainPath()
  self:_DoLogicClearElementSecondaryType(teamEntity)
  if not isAuroraTime then
    self:_DoLogicPlayerBuffDelayed(teamEntity)
    self:_DoRenderPlayerBuffDelayed(TT, teamEntity)
  else
    self:_DoRenderWaitDeathEnd(TT)
    self:_WaitChainAttackTrapTaskEnd(TT)
    self:_DoLogicClearDeadEntity()
  end
  local hasAutoBead = self:_DoLogicCalcAutoBeadSkill(teamEntity)
  if hasAutoBead then
    self:_DoRenderShowAutoBeadSkill(TT, teamEntity)
    self:_DoLogicMonsterDead()
    self:_DoRenderMonsterDead(TT, teamEntity)
  end
  local ntChainAttackFinish = self:_DoLogicNotifyChainAttackFinish(isAuroraTime, teamEntity)
  self:_DoRenderNotifyChainAttackFinish(TT, teamEntity, ntChainAttackFinish)
  local isActiveSkillLinkLine = self:_DoLogicCheckIsActiveSkillLinkLine(teamEntity)
  self:_DoLogicActiveSkillLinkLineRestorePos(teamEntity, isActiveSkillLinkLine)
  self:_DoRenderActiveSkillLinkLineRestorePos(TT, teamEntity, isActiveSkillLinkLine)
  self:_DoLogicGotoNextState(isAuroraTime, teamEntity, isActiveSkillLinkLine)
end

function ChainAttackStateSystem:_DoLogicBeforeCalcChain()
  local ntBeforeCalcChainSkill = NTBeforeCalcChainSkill:New()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  local logicPath = logicChainPathCmpt:GetLogicChainPath()
  ntBeforeCalcChainSkill:SetChainCount(table.count(logicPath))
  self._world:GetService("Trigger"):Notify(ntBeforeCalcChainSkill)
end

function ChainAttackStateSystem:_DoLogicCalcChainSkill(teamEntity)
  local chainAttackServiceLogic = self._world:GetService("ChainAttackLogic")
  chainAttackServiceLogic:_DoLogicCalcChainSkill(teamEntity)
  local svc = self._world:GetService("L2R")
  svc:L2RChainAttackData(teamEntity)
end

function ChainAttackStateSystem:_DoLogicMonsterDeadEx()
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local drops, deadEntityIDList = sMonsterShowLogic:DoAllMonsterDeadLogic(true)
end

function ChainAttackStateSystem:_DoLogicGotoNextState(isAuroraTime, teamEntity, isLinkLineActiveSkill)
  local battle_service = self._world:GetService("Battle")
  if self:_IsBattleEnd() or battle_service:IsWavePreEnd(teamEntity) == true then
    self._world:EventDispatcher():Dispatch(GameEventType.ChainAttackFinish, 3)
  elseif isAuroraTime then
    self._world:EventDispatcher():Dispatch(GameEventType.ChainAttackFinish, 2)
  elseif isLinkLineActiveSkill then
    local battleStatCmpt = self._world:BattleStat()
    battleStatCmpt:SetActiveSkillLinkLineState(false, nil)
    self._world:EventDispatcher():Dispatch(GameEventType.ChainAttackFinish, 2)
  elseif self._world:MatchType() == MatchType.MT_BlackFist then
    self._world:EventDispatcher():Dispatch(GameEventType.ChainAttackFinish, 3)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.ChainAttackFinish, 1)
  end
end

function ChainAttackStateSystem:_DoLogicNotifyChainAttackFinish(isAuroraTime, teamEntity)
  local battle_service = self._world:GetService("Battle")
  if self:_IsBattleEnd() or battle_service:IsWavePreEnd(teamEntity) == true then
  elseif isAuroraTime then
  else
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local ntChainAttackFinish = NTChainAttackFinish:New(teamEntity)
    self._world:GetService("Trigger"):Notify(ntChainAttackFinish)
    return ntChainAttackFinish
  end
end

function ChainAttackStateSystem:_DoLogicCheckIsActiveSkillLinkLine(teamEntity)
  local battleStatCmpt = self._world:BattleStat()
  local isActiveSkillLinkLine = battleStatCmpt:IsActiveSkillLinkLine()
  return isActiveSkillLinkLine
end

function ChainAttackStateSystem:_DoLogicCheckAuroraTime(teamEntity)
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local battle_service = self._world:GetService("Battle")
  local affixService = self._world:GetService("Affix")
  local battleStatCmpt = self._world:BattleStat()
  local oldIsAuroraTime = battleStatCmpt:IsRoundAuroraTime()
  local roundAuroraTimeOk = not oldIsAuroraTime or affixService:IsNoAuroraTimeLimit()
  local isCloseAuroraTimeByLinkStep = false
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    isCloseAuroraTimeByLinkStep = true
  end
  local isAuroraTime = not isCloseAuroraTimeByLinkStep and battleStatCmpt:IsRoundSuperChain() and self._world.BW_WorldInfo.enable_aurora_time and roundAuroraTimeOk and battleStatCmpt:GuideShowStarTime(self._world.BW_WorldInfo.missionID) and not sMonsterShowLogic:IsAllMonsterHasDeadMark() and not battle_service:PlayerIsDead(teamEntity) and not affixService:IsCloseAuroraTime()
  local buffSvc = self._world:GetService("BuffLogic")
  if buffSvc:IsForceEnterAuroraTime(teamEntity) then
    isAuroraTime = roundAuroraTimeOk and not sMonsterShowLogic:IsAllMonsterHasDeadMark() and not battle_service:PlayerIsDead(teamEntity)
  end
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze and isAuroraTime then
    local seasonMazeSvc = self._world:GetService("SeasonMaze")
    seasonMazeSvc:AddMsAndGoldCoin()
  end
  if buffSvc:IsCloseEnterAuroraTime(teamEntity) then
    isAuroraTime = false
  end
  if isAuroraTime then
    battleStatCmpt:SetRoundAuroraTime(true)
    battleStatCmpt:AddAuroraTimeCount()
    if oldIsAuroraTime then
      battleStatCmpt:SetReEnterAuroraTime(true)
      local isReEnterClose = true
      self:_DoLogicCloseAuroraTime(isReEnterClose)
    end
    local chainPath = teamEntity:LogicChainPath():GetLogicChainPath()
    self._world:GetService("Trigger"):Notify(NTEnterAuroraTime:New(chainPath[1], teamEntity))
    self._world:GetService("Trigger"):Notify(NTEnterAuroraTimeInChainSys:New(chainPath[1], teamEntity))
  end
  return isAuroraTime
end

function ChainAttackStateSystem:_DoLogicCalc3StarProgress()
  local starService = self._world:GetService("Star3Calc")
  starService:Calc3StarProgress()
end

function ChainAttackStateSystem:_DoLogicCalcBonusObjective()
  local bonusService = self._world:GetService("BonusCalc")
  bonusService:CalcBonusObjective()
end

function ChainAttackStateSystem:_DoLogicClearChainPath(teamEntity)
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(teamMembers) do
    local skillPetData = e:SkillPetAttackData()
    skillPetData:ClearPetAttackData()
  end
  local logicChainPathCmpt = teamEntity:LogicChainPath()
  logicChainPathCmpt:ClearLogicChainPath()
end

function ChainAttackStateSystem:_DoLogicClearElementSecondaryType(teamEntity)
  local teamMembers = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(teamMembers) do
    local playerElementCmpt = e:Element()
    if playerElementCmpt then
      playerElementCmpt:SetUseSecondaryType(false)
    end
  end
  local fettersSvc = self._world:GetService("Fetters")
  if fettersSvc then
    for _, petEntity in ipairs(teamMembers) do
      fettersSvc:SetFettersActive(petEntity, false)
    end
  end
end

function ChainAttackStateSystem:_DoLogicPlayerBuffDelayed(teamEntity)
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:CalcPlayerBuffDelayedTurn(teamEntity)
end

function ChainAttackStateSystem:_DoLogicCalcAutoBeadSkill(teamEntity)
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local holderEntity = autoBeadServiceLogic:GetAutoBeadSkillHolder(teamEntity)
  if not holderEntity then
    return false
  end
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  autoBeadServiceLogic:_DoLogicCalcAutoBeadSkill(teamEntity)
  local svc = self._world:GetService("L2R")
  svc:L2RAutoBeadkSkillData(teamEntity)
  return true
end

function ChainAttackStateSystem:_DoLogicActiveSkillLinkLineRestorePos(teamEntity, isActiveSkillLinkLine)
  if not isActiveSkillLinkLine then
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  local casterEntity = self._world:GetEntityByID(battleStatCmpt:GetActiveSkillLinkLineCasterEntityID())
  local casterPos = teamEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local sourcePos, sourceDir = utilDataSvc:GetLogicActiveSkillLinkLineTeamPos()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  boardServiceLogic:UpdateEntityBlockFlag(teamEntity, casterPos, sourcePos)
  teamEntity:SetGridPosition(sourcePos)
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, entityPet in ipairs(pets) do
    entityPet:SetGridLocation(sourcePos, sourceDir)
  end
  self:_DoRestoreTeamLeader(teamEntity)
  self._world:GetService("Trigger"):Notify(NTActiveSkillLinkLineChainAttackFinish:New(casterEntity, casterPos))
end

function ChainAttackStateSystem:_DoRestoreTeamLeader(teamEntity)
  local teamCmpt = teamEntity:Team()
  local teamLeaderEntityID = teamCmpt:GetOriginalTeamLeaderID()
  if teamLeaderEntityID then
    local teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
    teamEntity:SetTeamLeaderPetEntity(teamLeaderEntity)
    teamCmpt:SetOriginalTeamLeaderID(nil)
  end
end

function ChainAttackStateSystem:_DoRenderBeforeCalcChain(TT)
end

function ChainAttackStateSystem:_DoRenderShowSuperChainSkill(TT)
end

function ChainAttackStateSystem:_DoRenderShowChainAttack(TT, teamEntity)
end

function ChainAttackStateSystem:_DoRenderClearLastAttack()
end

function ChainAttackStateSystem:_DoRenderInWave(TT, traps, monsters)
end

function ChainAttackStateSystem:_DoRenderNotifyEnterAuroraTimeInChainSys(TT, isAuroraTime)
end

function ChainAttackStateSystem:_DoRenderClearChainPath()
end

function ChainAttackStateSystem:_DoRenderWaitPlaySkillTaskFinish(TT)
end

function ChainAttackStateSystem:_DoRenderPlayerBuffDelayed(TT)
end

function ChainAttackStateSystem:_DoRenderResetAuroraTimeState(TT)
end

function ChainAttackStateSystem:_WaitChainAttackTrapTaskEnd(TT)
end

function ChainAttackStateSystem:_DoRenderShowAutoBeadSkill(TT, teamEntity)
end

function ChainAttackStateSystem:_DoRenderNotifyChainAttackFinish(TT, teamEntity, ntChainAttackFinish)
end

function ChainAttackStateSystem:_DoRenderActiveSkillLinkLineRestorePos(teamEntity, isActiveSkillLinkLine)
end
