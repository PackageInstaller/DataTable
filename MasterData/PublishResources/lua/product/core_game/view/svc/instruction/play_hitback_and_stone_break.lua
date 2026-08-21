_class("PlayHitBackAndStoneBreakInstruction", BaseInstruction)
PlayHitBackAndStoneBreakInstruction = PlayHitBackAndStoneBreakInstruction

function PlayHitBackAndStoneBreakInstruction:Constructor(paramList)
end

function PlayHitBackAndStoneBreakInstruction:GetCacheResource()
  local t = {}
  return t
end

function PlayHitBackAndStoneBreakInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local casterPos = casterEntity:GetRenderGridPosition()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultList = resultContainer:GetEffectResultsAsArray(SkillEffectType.HitBack)
  local hitBackResult = resultList[1]
  local targetID = hitBackResult:GetTargetID()
  local hitBackDir = hitBackResult:GetHitDir()
  local newPos = hitBackResult:GetPosTarget()
  local targetEntity = self._world:GetEntityByID(targetID)
  local resultList2 = resultContainer:GetEffectResultsAsArray(SkillEffectType.DestroyTrap, 2)
  local trapServiceRender = self._world:GetService("TrapRender")
  self._taskID = {}
  local targetRealPos = targetEntity:GetRenderGridPosition()
  while targetRealPos.x ~= newPos.x or targetRealPos.y ~= newPos.y do
    self:PlayDestroyTrap(TT, resultList2, targetEntity, hitBackDir, trapServiceRender)
    targetRealPos = targetEntity:GetRenderGridPosition()
    YIELD(TT)
  end
  self:PlayDestroyTrap(TT, resultList2, targetEntity, hitBackDir, trapServiceRender)
  while not TaskHelper:GetInstance():IsAllTaskFinished(self._taskID) do
    YIELD(TT)
  end
end

function PlayHitBackAndStoneBreakInstruction:PlayDestroyTrap(TT, resultList, casterEntity, teleportDir, trapServiceRender)
  if not resultList then
    return
  end
  for i, v in ipairs(resultList) do
    local pos = v:GetTrapPos()
    local entityID = v:GetEntityID()
    local entity = self._world:GetEntityByID(entityID)
    local trapRenderCmpt = entity:TrapRender()
    local hadPlayDead = trapRenderCmpt:GetHadPlayDead()
    if self:NeedPlayDead(casterEntity, pos, teleportDir) and not hadPlayDead then
      local id = GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.PlayTrapDieSkill, trapServiceRender, {entity})
      table.insert(self._taskID, id)
    end
  end
end

function PlayHitBackAndStoneBreakInstruction:NeedPlayDead(casterEntity, pos, teleportDir)
  local casterRealPos = casterEntity:GetRenderGridPosition()
  if teleportDir == Vector2(0, 1) then
    if pos.y <= casterRealPos.y then
      return true
    end
  elseif teleportDir == Vector2(0, -1) then
    if pos.y >= casterRealPos.y then
      return true
    end
  elseif teleportDir == Vector2(1, 0) then
    if pos.y >= casterRealPos.y then
      return true
    end
  elseif teleportDir == Vector2(-1, 0) and pos.y >= casterRealPos.y then
    return true
  end
  return false
end
