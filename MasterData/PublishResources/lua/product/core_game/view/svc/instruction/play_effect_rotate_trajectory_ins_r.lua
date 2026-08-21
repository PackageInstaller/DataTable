_class("PlayEffectRotateTrajectoryInstruction", BaseInstruction)
PlayEffectRotateTrajectoryInstruction = PlayEffectRotateTrajectoryInstruction

function PlayEffectRotateTrajectoryInstruction:Constructor(paramList)
  self.moveSpeed = tonumber(paramList.moveSpeed)
  self.rotateSpeed = tonumber(paramList.rotateSpeed)
  self.block = tonumber(paramList.block) or 1
  self.eftID = tonumber(paramList.effectID)
  self.startEntity = paramList.start
  self.endEntity = paramList["end"]
  self.startWait = tonumber(paramList.startWait) or 0
end

function PlayEffectRotateTrajectoryInstruction:GetCacheResource()
  local t = {}
  if self.eftID and self.eftID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self.eftID].ResPath,
      1
    })
  end
  return t
end

function PlayEffectRotateTrajectoryInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self.block == 1 then
    self:_ShowDamageTask(TT, casterEntity, phaseContext)
  else
    GameGlobal.TaskManager():CoreGameStartTask(self._ShowDamageTask, self, casterEntity, phaseContext)
  end
end

function PlayEffectRotateTrajectoryInstruction:_ShowDamageTask(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  if damageResultArray == nil then
    return
  end
  local hasTargetDamageResultArray = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity then
      table.insert(hasTargetDamageResultArray, damageResult)
    end
  end
  if table.count(hasTargetDamageResultArray) == 0 then
    return
  end
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local _start = self:_GetEntityHitPos(TT, casterEntity, phaseContext, self.startEntity)
  local _end = self:_GetEntityHitPos(TT, casterEntity, phaseContext, self.endEntity)
  if not _start then
    Log.exception("PlayEffectTrajectory not find Entity hit  :", self.startEntity)
    return
  end
  if not _end then
    Log.exception("PlayEffectTrajectory not find Entity hit  :", self.endEntity)
    return
  end
  local eftEntity = effectService:CreatePositionEffect(self.eftID, _start)
  if not eftEntity:HasView() then
    YIELD(TT)
  end
  local eftTansform = eftEntity:View():GetGameObject().transform
  local offset = Vector3(0, math.random(), 0)
  local dir = _start - _end + offset
  eftEntity:SetDirection(dir)
  YIELD(TT, self.startWait)
  local moveSpeed = self.moveSpeed / 30
  local moveSpeedMin = 1
  local moveSpeedMax = 15
  local rotateSpeed = self.rotateSpeed / 30
  local lastFrameNormalized = eftTansform.forward
  local finalForwardBefore = (_end - eftTansform.position).normalized
  local finalAngle = Vector3.Angle(eftTansform.forward, finalForwardBefore)
  local _startHorizontal = Vector3(_start.x, 0, _start.z)
  local _endHorizontal = Vector3(_end.x, 0, _end.z)
  local endToStartDistance = Vector3.Distance(_startHorizontal, _endHorizontal)
  local move = true
  local frameCount = 0
  while move do
    local finalForward = (_end - eftTansform.position).normalized
    if finalForward ~= eftTansform.forward then
      local angleOffset = Vector3.Angle(eftTansform.forward, finalForward)
      local t = frameCount * rotateSpeed / finalAngle
      eftTansform.forward = Vector3.Lerp(lastFrameNormalized, finalForward, t)
    else
      moveSpeed = moveSpeed + 5
    end
    local changeSpeed = moveSpeed / 30
    eftTansform.position = eftTansform.position + Vector3(eftTansform.forward.x * changeSpeed, eftTansform.forward.y * changeSpeed, eftTansform.forward.z * changeSpeed)
    lastFrameNormalized = eftTansform.forward
    frameCount = frameCount + 1
    YIELD(TT)
    local currentDist = Vector3.Distance(eftTansform.position, _end)
    local curPosOverEndPos = self:_CheckEffectPos(_start, _end, eftTansform.position)
    if currentDist < 0.7 or 0 > eftTansform.position.y or curPosOverEndPos then
      move = false
      break
    end
  end
  world:DestroyEntity(eftEntity)
end

function PlayEffectRotateTrajectoryInstruction:_GetEntityHitPos(TT, casterEntity, phaseContext, entityName)
  local targetEntity
  if entityName == "Target" then
    local world = casterEntity:GetOwnerWorld()
    local targetEntityID = phaseContext:GetCurTargetEntityID()
    targetEntity = world:GetEntityByID(targetEntityID)
  elseif entityName == "Caster" then
    targetEntity = casterEntity
  end
  if not targetEntity then
    return
  end
  local playSkillService = targetEntity:GetOwnerWorld():GetService("PlaySkill")
  local rootTransform = playSkillService:GetEntityRenderHitTransform(targetEntity)
  local workPos = rootTransform.position
  return workPos
end

function PlayEffectRotateTrajectoryInstruction:_CheckEffectPos(_start, _end, curPos)
  if _start.x <= _end.x and _start.z <= _end.z then
    return curPos.x >= _end.x and curPos.z >= _end.z
  elseif _start.x <= _end.x and _start.z >= _end.z then
    return curPos.x >= _end.x and curPos.z <= _end.z
  elseif _start.x >= _end.x and _start.z <= _end.z then
    return curPos.x <= _end.x and curPos.z >= _end.z
  elseif _start.x >= _end.x and _start.z >= _end.z then
    return curPos.x <= _end.x and curPos.z <= _end.z
  end
  return false
end
