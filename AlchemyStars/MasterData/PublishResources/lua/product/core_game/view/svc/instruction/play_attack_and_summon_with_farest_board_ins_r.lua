require("base_ins_r")
_class("PlayAttackAndSummonWithFarestBoardInstruction", BaseInstruction)
PlayAttackAndSummonWithFarestBoardInstruction = PlayAttackAndSummonWithFarestBoardInstruction

function PlayAttackAndSummonWithFarestBoardInstruction:Constructor(paramList)
  self._hitEffectID = tonumber(paramList.hitEffectID) or 0
  self._flyEffectID = tonumber(paramList.flyEffectID) or 0
  self._time = tonumber(paramList.time)
  self._animNameUp = "moveup"
  self._animNameDown = "movedown"
end

function PlayAttackAndSummonWithFarestBoardInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._flyEffectID and 0 < self._flyEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayAttackAndSummonWithFarestBoardInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local summonEverythingResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not damageResultArray then
    return
  end
  local listWaitTask = {}
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local sEffect = world:GetService("Effect")
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResultStart = scopeCalculator:ComputeScopeRange(SkillScopeType.FarthestBoardRowOrColumn, {1})
  local attackRangeStart = scopeResultStart:GetAttackRange()
  local scopeResultSummon = scopeCalculator:ComputeScopeRange(SkillScopeType.FarthestBoardRowOrColumn, {2})
  local scopeResultEnd = scopeCalculator:ComputeScopeRange(SkillScopeType.FarthestBoardRowOrColumn, {3})
  local attackRangeEnd = scopeResultEnd:GetAttackRange()
  local posOld = attackRangeStart[1]
  local posNew = attackRangeEnd[1]
  local distance = Vector2.Distance(posNew, posOld)
  local speed = distance / self._time * 1000
  local oneGridFlyTime = self._time / distance
  casterEntity:SetAnimatorControllerTriggers({
    self._animNameUp
  })
  YIELD(TT, 667)
  casterEntity:SetPosition(posOld)
  casterEntity:SetAnimatorControllerTriggers({
    self._animNameDown
  })
  YIELD(TT, 500)
  YIELD(TT)
  while casterEntity:HasGridMove() do
    local gridMoveComponent = casterEntity:GridMove()
    YIELD(TT)
  end
  local flyEffect = sEffect:CreateEffect(self._flyEffectID, casterEntity)
  casterEntity:AddGridMove(speed, posNew, posOld)
  local attackRangeSummon = scopeResultSummon:GetAttackRange()
  local distanceStartToSummon = Vector2.Distance(posOld, attackRangeSummon[1])
  YIELD(TT, oneGridFlyTime * distanceStartToSummon)
  if summonEverythingResult and table.count(summonEverythingResult) > 0 then
    local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
    for _, summoResult in ipairs(summonEverythingResult) do
      local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(sPlaySkillInstruction.ShowSummonAction, sPlaySkillInstruction, world, summoResult)
      table.insert(listWaitTask, nTaskID)
    end
  end
  YIELD(TT, oneGridFlyTime)
  if damageResultArray and table.count(damageResultArray) > 0 then
    for _, damageResult in ipairs(damageResultArray) do
      local targetEntityID = damageResult:GetTargetID()
      local targetEntity = world:GetEntityByID(targetEntityID)
      local damageInfo = damageResult:GetDamageInfo(1)
      local damageGridPos = damageResult:GetGridPos()
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(TurnToTargetType.None):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
      playSkillService:HandleBeHit(TT, beHitParam)
    end
  end
  while casterEntity:HasGridMove() do
    YIELD(TT)
  end
  world:DestroyEntity(flyEffect)
  casterEntity:SetAnimatorControllerTriggers({
    self._animNameUp
  })
  YIELD(TT, 667)
  casterEntity:SetPosition(gridPos)
  casterEntity:SetAnimatorControllerTriggers({
    self._animNameDown
  })
  YIELD(TT, 500)
  if table.count(listWaitTask) > 0 then
    while not TaskHelper:GetInstance():IsAllTaskFinished(listWaitTask) do
      YIELD(TT)
    end
  end
end
