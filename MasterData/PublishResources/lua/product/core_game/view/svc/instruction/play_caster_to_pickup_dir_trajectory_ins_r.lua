require("base_ins_r")
_class("PlayCasterToPickupDirTrajectoryInstruction", BaseInstruction)
PlayCasterToPickupDirTrajectoryInstruction = PlayCasterToPickupDirTrajectoryInstruction

function PlayCasterToPickupDirTrajectoryInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  self._flyTime = tonumber(paramList.flyTime)
  if not self._effectID or not Cfg.cfg_effect[self._effectID] then
    Log.exception(self._className, "effectID无效: ", tostring(self._effectID))
  end
  if not self._flySpeed and not self._flyTime then
    Log.exception(self._className, "flySpeed与flyTime不可同时为空")
  end
  self._degressiveCount = tonumber(paramList.degressiveCount)
  self._directionType = tonumber(paramList.directionType)
  self._destroyEffectID = tonumber(paramList.destroyEffectID)
  self._effectReduceSize = tonumber(paramList.effectReduceSize)
  self._hideGO1Name = paramList.hideGO1Name
  self._hideGO2Name = paramList.hideGO2Name
  self._hideGO2WaitTime = tonumber(paramList.hideGO2WaitTime)
  if self._hideGO1Name and not self._hideGO2Name then
    Log.exception(self._className, "hideGO2Name 不能为空")
  end
  self._outBoardCount = tonumber(paramList.outBoardCount) or 5
  self._destroyKnifeWaitTime = tonumber(paramList.destroyKnifeWaitTime) or 1000
end

function PlayCasterToPickupDirTrajectoryInstruction:GetCacheResource()
  local t = {}
  if self._effectID then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._destroyEffectID and self._destroyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._destroyEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayCasterToPickupDirTrajectoryInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local casterPos = casterEntity:GetPosition()
  local castertRenderGridPos = casterEntity:GetRenderGridPosition()
  local pickUpGridPos = phaseContext:GetCurGridPos()
  if not pickUpGridPos then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    if renderPickUpComponent then
      local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
      pickUpGridPos = pickUpGridArray[1]
    end
  end
  if not pickUpGridPos then
    Log.exception(self._className, "没有点选位置")
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local world = casterEntity:GetOwnerWorld()
  local rbsvc = world:GetService("BoardRender")
  local utilData = world:GetService("UtilData")
  local maxLen = utilData:GetCurBoardMaxLen()
  local dirCenter = pickUpGridPos - castertRenderGridPos
  local dir = pickUpGridPos - castertRenderGridPos
  if self._directionType == DegressiveDamageDirection.PICKUP_POS then
  elseif self._directionType == DegressiveDamageDirection.PICKUP_LEFT_CORNER then
    if dir == Vector2.up then
      dirCenter = Vector2.New(-1, 1)
    elseif dir == Vector2.down then
      dirCenter = Vector2.New(1, -1)
    elseif dir == Vector2.left then
      dirCenter = Vector2.New(-1, -1)
    elseif dir == Vector2.right then
      dirCenter = Vector2.New(1, 1)
    end
  elseif self._directionType == DegressiveDamageDirection.PICKUP_RIGHT_CORNER then
    if dir == Vector2.up then
      dirCenter = Vector2.New(1, 1)
    elseif dir == Vector2.down then
      dirCenter = Vector2.New(-1, -1)
    elseif dir == Vector2.left then
      dirCenter = Vector2.New(-1, 1)
    elseif dir == Vector2.right then
      dirCenter = Vector2.New(1, -1)
    end
  elseif self._directionType == DegressiveDamageDirection.PICKUP_FRONT_LEFT then
    if dir == Vector2.up then
      dirCenter = Vector2.New(-1, 0)
    elseif dir == Vector2.down then
      dirCenter = Vector2.New(1, 0)
    elseif dir == Vector2.left then
      dirCenter = Vector2.New(0, -1)
    elseif dir == Vector2.right then
      dirCenter = Vector2.New(0, 1)
    end
  elseif self._directionType == DegressiveDamageDirection.PICKUP_FRONT_RIGHT then
    if dir == Vector2.up then
      dirCenter = Vector2.New(1, 0)
    elseif dir == Vector2.down then
      dirCenter = Vector2.New(-1, 0)
    elseif dir == Vector2.left then
      dirCenter = Vector2.New(0, 1)
    elseif dir == Vector2.right then
      dirCenter = Vector2.New(0, -1)
    end
  end
  castertRenderGridPos = pickUpGridPos + dirCenter
  local targetGridPos = castertRenderGridPos + Vector2(dir.x, dir.y)
  local edgeGridPos = targetGridPos
  local maxX = utilData:GetCurBoardMaxX()
  local maxY = utilData:GetCurBoardMaxY()
  if dir == Vector2.up then
    targetGridPos = Vector2(targetGridPos.x, maxY + self._outBoardCount)
    edgeGridPos = Vector2(edgeGridPos.x, maxY)
  elseif dir == Vector2.down then
    targetGridPos = Vector2(targetGridPos.x, 1 - self._outBoardCount)
    edgeGridPos = Vector2(edgeGridPos.x, 1)
  elseif dir == Vector2.left then
    targetGridPos = Vector2(1 - self._outBoardCount, targetGridPos.y)
    edgeGridPos = Vector2(1, edgeGridPos.y)
  elseif dir == Vector2.right then
    targetGridPos = Vector2(maxX + self._outBoardCount, targetGridPos.y)
    edgeGridPos = Vector2(maxX, edgeGridPos.y)
  end
  Log.fatal("TargetGridPos,", targetGridPos, " Type:", self._directionType, " dir:", dir)
  local targetPos = rbsvc:GridPos2RenderPos(targetGridPos)
  local fxsvc = world:GetService("Effect")
  local eFx = fxsvc:CreateCommonGridEffect(self._effectID, castertRenderGridPos, dir)
  local go = eFx:View():GetGameObject()
  local hideGO1 = go.transform:Find(self._hideGO1Name)
  hideGO1.gameObject:SetActive(true)
  local hideGO2 = go.transform:Find(self._hideGO2Name)
  hideGO2.gameObject:SetActive(true)
  local curEffectSize = 1
  local curDegressiveCount = self._degressiveCount
  YIELD(TT)
  if not eFx or not eFx:View() then
    return
  end
  local flyTime = self._flyTime
  local dis = Vector3.Distance(casterPos, targetPos)
  flyTime = flyTime or dis * self._flySpeed
  local tsfm = go.transform
  local dotween = tsfm:DOMove(targetPos, flyTime * 0.001, false)
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
      go:SetActive(false)
      world:DestroyEntity(eFx)
    end)
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local bHide = false
    for i = 1, dis do
      YIELD(TT, self._flySpeed)
      local posWork = castertRenderGridPos + Vector2(dir.x * i, dir.y * i)
      local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, posWork)
      if damageResult then
        curDegressiveCount = curDegressiveCount - 1
        curEffectSize = curEffectSize - self._effectReduceSize
        if curEffectSize <= 0 then
          curEffectSize = 0
        end
        local scaleData = Vector3.New(curEffectSize, curEffectSize, curEffectSize)
        tsfm:DOScale(scaleData, 0)
      end
      if curDegressiveCount == 0 or curEffectSize <= 0 or posWork == edgeGridPos then
        local destroyEffectEntity = fxsvc:CreateCommonGridEffect(self._destroyEffectID, posWork, dir)
        local hideGO1 = go.transform:Find(self._hideGO1Name)
        local hideGO2 = go.transform:Find(self._hideGO2Name)
        hideGO1.gameObject:SetActive(false)
        Log.fatal("HideGO1")
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          YIELD(TT, self._hideGO2WaitTime)
          hideGO2.gameObject:SetActive(false)
          Log.fatal("HideGO2")
        end)
      end
    end
    YIELD(TT, self._destroyKnifeWaitTime)
    world:DestroyEntity(eFx)
  end)
end
