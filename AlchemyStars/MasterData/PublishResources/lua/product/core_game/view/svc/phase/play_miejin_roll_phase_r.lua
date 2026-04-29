require("play_skill_phase_base_r")
_class("PlayMiejinRollPhase", PlaySkillPhaseBase)
PlayMiejinRollPhase = PlayMiejinRollPhase

function PlayMiejinRollPhase:PlayFlight(TT, casterEntity, phaseParam)
  if not casterEntity:HasAttachmentController() then
    return
  end
  local cAttachment = casterEntity:AttachmentController()
  local csResRequest = cAttachment:GetResRequest()
  if not csResRequest or tostring(csResRequest) == "null" then
    return
  end
  local csgo = csResRequest.Obj
  if not self:_IsCSGameObjectValid(csgo) then
    return
  end
  YIELD(TT, phaseParam:GetPrerollDelayMS())
  if not self:_IsCSGameObjectValid(csgo) then
    return
  end
  local rollFxEntity
  if phaseParam:GetRollEffectID() then
    local fxID = phaseParam:GetRollEffectID()
    local fxsvc = self._world:GetService("Effect")
    rollFxEntity = fxsvc:CreateEffect(fxID, casterEntity)
  end
  local v3CasterRenderPos = casterEntity:GetPosition():Clone()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = resultContainer:GetScopeResult()
  local attackRange = scopeResult:GetAttackRange()
  local boardrsvc = self._world:GetService("BoardRender")
  local dir = self:_GetGridDirection(casterEntity)
  local v3ViewPosition = casterEntity:GetPosition()
  local v2ViewPos = boardrsvc:BoardRenderPos2FloatGridPos_New(v3ViewPosition)
  local finalPos = self:_GetFinalPos(v2ViewPos, dir)
  local v3FinalRenderPos = boardrsvc:GridPos2RenderPos(finalPos)
  local csTransform = csgo.transform
  local tweenerRollout = csTransform:DOMove(v3FinalRenderPos, phaseParam:GetRolloutTimeMS() * 0.001)
  local v3StartPoint = v3CasterRenderPos
  local tv2PlayedGrid = {}
  while tweenerRollout.active and self:_IsCSGameObjectValid(csgo) do
    local v3CurrentPos = csgo.transform.position
    local grids = self:_GetGridBetween(v3StartPoint, v3CurrentPos, dir, tv2PlayedGrid)
    self:_PlaySummonTrapInRange(TT, phaseParam, resultContainer, grids, casterEntity)
    self:_PlayDamageInRange(TT, phaseParam, resultContainer, grids, casterEntity)
    table.appendArray(tv2PlayedGrid, grids)
    v3StartPoint = v3CurrentPos:Clone()
    YIELD(TT)
  end
  local gridsLeft = {}
  for _, v2 in ipairs(attackRange) do
    if not table.icontains(tv2PlayedGrid, v2) then
      table.insert(gridsLeft, v2)
    end
  end
  if 0 < #gridsLeft then
    Log.error(self._className, "有格子没有被触发到？")
    self:_PlaySummonTrapInRange(TT, phaseParam, resultContainer, gridsLeft, casterEntity)
    self:_PlayDamageInRange(TT, phaseParam, resultContainer, gridsLeft, casterEntity)
  end
  YIELD(TT, phaseParam:GetStandEdgeTimeMS())
  if not self:_IsCSGameObjectValid(csgo) then
    return
  end
  local tweenerRollback = csTransform:DOMove(v3CasterRenderPos, phaseParam:GetRollbackTimeMS() * 0.001)
  while tweenerRollback.active do
    if not self:_IsCSGameObjectValid(csgo) then
      return
    end
    YIELD(TT)
  end
  if rollFxEntity then
    self._world:DestroyEntity(rollFxEntity)
  end
  YIELD(TT, phaseParam:GetPostrollDelayMS())
end

function PlayMiejinRollPhase:_GetGridDirection(entity)
  local dir = entity:GetGridDirection():Clone()
  if dir.x > 1 then
    dir.x = 1
  elseif dir.x < -1 then
    dir.x = -1
  end
  if 1 < dir.y then
    dir.y = 1
  elseif -1 > dir.y then
    dir.y = -1
  end
  return dir
end

function PlayMiejinRollPhase:_GetFinalPos(gridPosition, dir)
  local utilDataSvc = self._world:GetService("UtilData")
  local boardMaxX = utilDataSvc:GetCurBoardMaxX()
  local boardMaxY = utilDataSvc:GetCurBoardMaxY()
  local finalPos = gridPosition:Clone()
  while boardMaxX > finalPos.x and finalPos.x > 0 and boardMaxY > finalPos.y and 0 < finalPos.y do
    finalPos = finalPos + dir
  end
  if finalPos.x <= 0 then
    finalPos.x = finalPos.x + 0.5
  elseif boardMaxX < finalPos.x then
    finalPos.x = finalPos.x - 0.5
  end
  if 0 > finalPos.y then
    finalPos.y = finalPos.y + 0.5
  elseif boardMaxY < finalPos.y then
    finalPos.y = finalPos.y - 0.5
  end
  return finalPos
end

function PlayMiejinRollPhase:_IsCSGameObjectValid(go)
  return go and tostring(go) ~= "null"
end

function PlayMiejinRollPhase:_GetGridBetween(v3startpoint, v3endpoint, direction, tv2PlayedGrid)
  local t = {}
  local boardrsvc = self._world:GetService("BoardRender")
  local v2StartPoint = boardrsvc:BoardRenderPos2FloatGridPos_New(v3startpoint)
  local v2Endpoint = boardrsvc:BoardRenderPos2FloatGridPos_New(v3endpoint)
  local pattern = {
    Vector2.New(-0.5, -0.5),
    Vector2.New(-0.5, 0.5),
    Vector2.New(0.5, -0.5),
    Vector2.New(0.5, 0.5)
  }
  local funcWhileLoop
  if direction.x > 0 then
    function funcWhileLoop(v2Current, v2End)
      return v2Current.x < v2End.x
    end
  elseif 0 > direction.x then
    function funcWhileLoop(v2Current, v2End)
      return v2Current.x > v2End.x
    end
  elseif 0 < direction.y then
    function funcWhileLoop(v2Current, v2End)
      return v2Current.y < v2End.y
    end
  else
    function funcWhileLoop(v2Current, v2End)
      return v2Current.y > v2End.y
    end
  end
  local v2Pos = v2StartPoint:Clone()
  while funcWhileLoop(v2Pos, v2Endpoint) do
    for _, v2Pattern in ipairs(pattern) do
      local v2 = v2Pos + v2Pattern
      v2.x = math.floor(v2.x)
      v2.y = math.floor(v2.y)
      if not table.icontains(tv2PlayedGrid, v2) and not table.icontains(t, v2) then
        table.insert(t, v2)
      end
    end
    v2Pos = v2Pos + direction
  end
  return t
end

function PlayMiejinRollPhase:_GetSummonTrapResultsInRange(resultContainer, grids)
  local t = {}
  local array = resultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
  if not array then
    return t
  end
  for _, result in ipairs(array) do
    if table.icontains(grids, result:GetPos()) then
      table.insert(t, result)
    end
  end
  return t
end

function PlayMiejinRollPhase:_GetDamageResultsInRange(resultContainer, grids)
  local t = {}
  local array = resultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  for _, result in ipairs(array) do
    if table.icontains(grids, result:GetGridPos()) then
      table.insert(t, result)
    end
  end
  return t
end

function PlayMiejinRollPhase:_PlaySummonTrapInRange(TT, phaseParam, resultContainer, grids, casterEntity)
  local traprsvc = self._world:GetService("TrapRender")
  local tSummonTrapResults = self:_GetSummonTrapResultsInRange(resultContainer, grids)
  local tTrapEntities = {}
  for _, summonTrapResult in ipairs(tSummonTrapResults) do
    local trapIDList = summonTrapResult:GetTrapIDList()
    for _, eid in ipairs(trapIDList) do
      local entity = self._world:GetEntityByID(eid)
      if entity then
        table.insert(tTrapEntities, entity)
      end
    end
  end
  traprsvc:ShowTraps(TT, tTrapEntities, true)
end

function PlayMiejinRollPhase:_PlayDamageInRange(TT, phaseParam, resultContainer, grids, casterEntity)
  local pskillsvc = self._world:GetService("PlaySkill")
  local tDamageResults = self:_GetDamageResultsInRange(resultContainer, grids)
  for _, damageResult in ipairs(tDamageResults) do
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      local damageInfo = damageResult:GetDamageInfo(1)
      local damageGridPos = damageResult:GetGridPos()
      local isFinalAttack = resultContainer:IsFinalAttack()
      local skillID = resultContainer:GetSkillID()
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(phaseParam:GetHitAnimName()):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(true):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(1)
      pskillsvc:HandleBeHit(TT, beHitParam)
    end
  end
end
