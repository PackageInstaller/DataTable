_class("PlayPet1502151RenderJumpInstruction", BaseInstruction)
PlayPet1502151RenderJumpInstruction = PlayPet1502151RenderJumpInstruction

function PlayPet1502151RenderJumpInstruction:Constructor(paramList)
  self._casterAnim1 = paramList.casterAnim1
  self._casterAnim2 = paramList.casterAnim2
  self._casterAnim3 = paramList.casterAnim3
  self._casterAnimDelayMs1 = tonumber(paramList.casterAnimDelayMs1)
  self._casterAnimDelayMs2 = tonumber(paramList.casterAnimDelayMs2)
  self._casterAnimDelayMs3 = tonumber(paramList.casterAnimDelayMs3)
  self._casterEffectID1 = tonumber(paramList.casterEffectID1)
  self._casterEffectDelayMs1 = tonumber(paramList.casterEffectDelayMs1)
  self._showHideEffectID1 = tonumber(paramList.showHideEffectID1)
  self._showHideEffectID2 = tonumber(paramList.showHideEffectID2)
  self._showHideEffectID3 = tonumber(paramList.showHideEffectID3)
  self._showHideEffectID4 = tonumber(paramList.showHideEffectID4)
  self._effectDelayMs1 = tonumber(paramList.effectDelayMs1)
  self._effectDelayMs2 = tonumber(paramList.effectDelayMs2)
  self._effectDelayMs3 = tonumber(paramList.effectDelayMs3)
  self._effectDelayMs4 = tonumber(paramList.effectDelayMs4)
  self._casterShowHideDelay1 = tonumber(paramList.casterShowHideDelayMs1)
  self._casterShowHideDelay2 = tonumber(paramList.casterShowHideDelayMs2)
  self._casterShowHideDelay3 = tonumber(paramList.casterShowHideDelayMs3)
  self._casterShowHideDelay4 = tonumber(paramList.casterShowHideDelayMs4)
  self._casterTeleportDelayMs1 = tonumber(paramList.casterTeleportDelayMs1)
  self._casterTeleportDelayMs2 = tonumber(paramList.casterTeleportDelayMs2)
  self._centerEffectID = tonumber(paramList.centerEffectID)
  self._centerEffectDelayMs1 = tonumber(paramList.centerEffectDelayMs1)
end

function PlayPet1502151RenderJumpInstruction:_CacheEff(t, effID, count)
  local cacheCount = count or 1
  if effID and effID ~= 0 then
    table.insert(t, {
      Cfg.cfg_effect[effID].ResPath,
      cacheCount
    })
  end
end

function PlayPet1502151RenderJumpInstruction:GetCacheResource()
  local t = {}
  self:_CacheEff(t, self._showHideEffectID1, 1)
  self:_CacheEff(t, self._showHideEffectID2, 1)
  self:_CacheEff(t, self._showHideEffectID3, 1)
  self:_CacheEff(t, self._showHideEffectID4, 1)
  self:_CacheEff(t, self._centerEffectID, 1)
  self:_CacheEff(t, self._casterEffectID1, 1)
  return t
end

function PlayPet1502151RenderJumpInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntity, targetEntityID
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray and 0 < #damageResultArray then
    local damageIndex = 1
    local damageResult = damageResultArray[damageIndex]
    if damageResult then
      targetEntityID = damageResult:GetTargetID()
    end
  else
    local forceMovementResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ForceMovement)
    if forceMovementResultArray and 0 < #forceMovementResultArray then
      local forceMovementResult = forceMovementResultArray[1]
      for _, moveResult in ipairs(forceMovementResult:GetMoveResult()) do
        if moveResult.isMoved then
          targetEntityID = moveResult.targetID
        end
      end
    end
  end
  if targetEntityID then
    targetEntity = world:GetEntityByID(targetEntityID)
  end
  local effectService = world:GetService("Effect")
  local playSkillService = world:GetService("PlaySkill")
  local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local skillID = skillEffectResultContainer:GetSkillID()
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local pickPos, pickDirPos
  local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
  if scopeGridList and #scopeGridList == 2 then
    pickPos = scopeGridList[1]
    pickDirPos = scopeGridList[2]
  else
    return
  end
  local showPos, showDir = self:CalcRoleShowPosAndDir(targetEntity, pickPos, pickDirPos)
  local effectCenterPos = pickPos
  local viewPosition = casterEntity:GetRenderGridPosition()
  local viewDirection = casterEntity:GetRenderGridDirection()
  local turnDir = effectCenterPos - viewPosition
  casterEntity:SetDirection(turnDir)
  local waitTaskList = {}
  local roleAnimFlowTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._RoleAnimFlow, self, world, casterEntity)
  table.insert(waitTaskList, roleAnimFlowTaskID)
  local roleEffectFlowTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._RoleEffectFlow, self, world, casterEntity)
  table.insert(waitTaskList, roleEffectFlowTaskID)
  local effectFlowTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._EffectFlow, self, world, viewPosition, showPos)
  table.insert(waitTaskList, effectFlowTaskID)
  local roleTeleportFlowTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._RoleTeleportFlow, self, world, casterEntity, viewPosition, turnDir, showPos, showDir)
  table.insert(waitTaskList, roleTeleportFlowTaskID)
  local roleShowHideFlowTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._RoleShowHideFlow, self, world, casterEntity)
  table.insert(waitTaskList, roleShowHideFlowTaskID)
  local centerEffectFlowTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._CenterEffectFlow, self, world, effectCenterPos)
  table.insert(waitTaskList, centerEffectFlowTaskID)
  if 0 < #waitTaskList then
    while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskList) do
      YIELD(TT)
    end
  end
end

function PlayPet1502151RenderJumpInstruction:_CenterEffectFlow(TT, world, effectCenterPos)
  local effectService = world:GetService("Effect")
  YIELD(TT, self._centerEffectDelayMs1)
  effectService:CreateWorldPositionEffect(self._centerEffectID, effectCenterPos, true)
end

function PlayPet1502151RenderJumpInstruction:_EffectFlow(TT, world, startPos, showPos)
  local effectService = world:GetService("Effect")
  YIELD(TT, self._effectDelayMs1)
  effectService:CreateWorldPositionEffect(self._showHideEffectID1, startPos, true)
  YIELD(TT, self._effectDelayMs2)
  effectService:CreateWorldPositionEffect(self._showHideEffectID2, showPos, true)
  YIELD(TT, self._effectDelayMs3)
  effectService:CreateWorldPositionEffect(self._showHideEffectID3, showPos, true)
  YIELD(TT, self._effectDelayMs4)
  effectService:CreateWorldPositionEffect(self._showHideEffectID4, startPos, true)
end

function PlayPet1502151RenderJumpInstruction:_RoleAnimFlow(TT, world, casterEntity)
  if self._casterAnimDelayMs1 and self._casterAnimDelayMs1 > 0 then
    YIELD(TT, self._casterAnimDelayMs1)
  end
  casterEntity:SetAnimatorControllerTriggers({
    self._casterAnim1
  })
  YIELD(TT, self._casterAnimDelayMs2)
  casterEntity:SetAnimatorControllerTriggers({
    self._casterAnim2
  })
  YIELD(TT, self._casterAnimDelayMs3)
  casterEntity:SetAnimatorControllerTriggers({
    self._casterAnim3
  })
end

function PlayPet1502151RenderJumpInstruction:_RoleEffectFlow(TT, world, casterEntity)
  local effectService = world:GetService("Effect")
  YIELD(TT, self._casterEffectDelayMs1)
  effectService:CreateEffect(self._casterEffectID1, casterEntity)
end

function PlayPet1502151RenderJumpInstruction:_RoleTeleportFlow(TT, world, casterEntity, startPos, startDir, showPos, showDir)
  YIELD(TT, self._casterTeleportDelayMs1)
  casterEntity:SetLocation(showPos, showDir)
  YIELD(TT, self._casterTeleportDelayMs2)
  casterEntity:SetLocation(startPos, startDir)
end

function PlayPet1502151RenderJumpInstruction:_RoleShowHideFlow(TT, world, casterEntity)
  YIELD(TT, self._casterShowHideDelay1)
  casterEntity:SetViewVisible(false)
  YIELD(TT, self._casterShowHideDelay2)
  casterEntity:SetViewVisible(true)
  YIELD(TT, self._casterShowHideDelay3)
  casterEntity:SetViewVisible(false)
  YIELD(TT, self._casterShowHideDelay4)
  casterEntity:SetViewVisible(true)
end

function PlayPet1502151RenderJumpInstruction:CalcRoleShowPosAndDir(targetEntity, pickPos, dirPos)
  local showPos, showDir
  if targetEntity then
    local v2Dir, maxStep = self:_ReCalcMoveDirByTargetAndPick(targetEntity, pickPos, dirPos, 1, true)
    showPos = pickPos + v2Dir
    showDir = v2Dir * -1
  else
    showPos = pickPos + Vector2(-1, 0)
    showDir = Vector2(1, 0)
  end
  return showPos, showDir
end

function PlayPet1502151RenderJumpInstruction:_ReCalcMoveDirByTargetAndPick(targetEntity, pickPos, dirPos, defaultStep, isCalcStepByPick)
  local dir
  local step = defaultStep
  local targetPos = targetEntity:GetRenderGridPosition()
  local bodyArea = targetEntity:BodyArea():GetArea()
  if bodyArea then
    if #bodyArea == 1 then
      dir = dirPos - pickPos
      step = math.abs(dir.x) + math.abs(dir.y)
      if dir.x > 0 then
        dir.x = 1
      elseif dir.x < 0 then
        dir.x = -1
      end
      if dir.y > 0 then
        dir.y = 1
      elseif dir.y < 0 then
        dir.y = -1
      end
    else
      local upMaxY, downMinY, rightMaxX, leftMinX
      for index, off in ipairs(bodyArea) do
        local bodyPos = targetPos + off
        if not upMaxY then
          upMaxY = bodyPos.y
        elseif upMaxY < bodyPos.y then
          upMaxY = bodyPos.y
        end
        if not downMinY then
          downMinY = bodyPos.y
        elseif downMinY > bodyPos.y then
          downMinY = bodyPos.y
        end
        if not rightMaxX then
          rightMaxX = bodyPos.x
        elseif rightMaxX < bodyPos.x then
          rightMaxX = bodyPos.x
        end
        if not leftMinX then
          leftMinX = bodyPos.x
        elseif leftMinX > bodyPos.x then
          leftMinX = bodyPos.x
        end
      end
      if upMaxY < dirPos.y then
        dir = Vector2.up
        if isCalcStepByPick then
          step = dirPos.y - upMaxY
        end
      elseif downMinY > dirPos.y then
        dir = Vector2.down
        if isCalcStepByPick then
          step = downMinY - dirPos.y
        end
      elseif rightMaxX < dirPos.x then
        dir = Vector2.right
        if isCalcStepByPick then
          step = dirPos.x - rightMaxX
        end
      elseif leftMinX > dirPos.x then
        dir = Vector2.left
        if isCalcStepByPick then
          step = leftMinX - dirPos.x
        end
      end
    end
  end
  if dir.x > 0 then
    dir.x = 1
  elseif dir.x < 0 then
    dir.x = -1
  end
  if dir.y > 0 then
    dir.y = 1
  elseif dir.y < 0 then
    dir.y = -1
  end
  dir = dir * -1
  return dir, step
end
