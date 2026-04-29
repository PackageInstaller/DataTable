require("base_ins_r")
_class("PlayFlyEffectFromLastTargetToTargetInstruction", BaseInstruction)
PlayFlyEffectFromLastTargetToTargetInstruction = PlayFlyEffectFromLastTargetToTargetInstruction
FlyEffectTraceType = {
  LineTrace = 1,
  JumpTrace = 2,
  ScaleTrace = 3,
  TimeScaleTrace = 4
}

function PlayFlyEffectFromLastTargetToTargetInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  if paramList.flyTime then
    self._flyTime = tonumber(paramList.flyTime)
  end
  if paramList.finalWaitTime then
    self._finalWaitTime = tonumber(paramList.finalWaitTime)
  end
  self._flyTrace = tonumber(paramList.flyTrace)
  self._offsetX = tonumber(paramList.offsetx) or 0
  self._offsetY = tonumber(paramList.offsety) or 0
  self._offsetZ = tonumber(paramList.offsetz) or 0
  self._flyEaseType = paramList.flyEaseType
  self._pickUpPosAsTarget = tonumber(paramList.pickUpPosAsTarget) == 1
  self._targetPos = ""
  if paramList.targetPos then
    self._targetPos = paramList.targetPos
  end
  self._originalBoneName = ""
  if paramList.originalBoneName then
    self._originalBoneName = paramList.originalBoneName
  end
  self._isBlock = tonumber(paramList.isBlock) or 1
end

function PlayFlyEffectFromLastTargetToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local casterEntityReal = casterEntity
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local targetDamageIndex = curDamageIndex - 1
  if 0 < targetDamageIndex then
    local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
    local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
    local damageResult = damageResultArray[targetDamageIndex]
    local damageInfo = damageResult:GetDamageInfo(1)
    casterEntityReal = world:GetEntityByID(damageInfo:GetTargetEntityID())
  end
  local tran
  if casterEntityReal:HasSuperEntity() and casterEntityReal:SuperEntityComponent():IsUseSuperEntityView() then
    tran = casterEntityReal:GetSuperEntity():View():GetGameObject().transform
  else
    tran = casterEntityReal:View():GetGameObject().transform
  end
  local castPos = tran:TransformPoint(Vector3(self._offsetX, self._offsetY, self._offsetZ))
  if self._originalBoneName and self._originalBoneName ~= "" then
    local boneTrans = GameObjectHelper.FindChild(tran, self._originalBoneName)
    if boneTrans ~= nil then
      castPos = boneTrans.position
    end
  end
  local targetPos = Vector3.zero
  if targetEntity then
    if targetEntity:TrapRender() then
      local gridPos = targetEntity:GetGridPosition()
      local gridDir = targetEntity:GetGridDirection()
      targetEntity:SetLocation(gridPos, gridDir)
    end
    if targetEntity:Location() then
      targetPos = targetEntity:Location().Position
    else
      local cGridLocation = targetEntity:GridLocation()
      local v2 = cGridLocation:Center()
      local boardServiceRender = casterEntityReal:GetOwnerWorld():GetService("BoardRender")
      targetPos = boardServiceRender:GridPos2RenderPos(v2)
    end
    if self._targetPos and self._targetPos ~= "" then
      local tran = targetEntity:View():GetGameObject().transform
      local targetTrans = GameObjectHelper.FindChild(tran, self._targetPos)
      if targetTrans ~= nil then
        targetPos = targetTrans.position
      end
    end
  else
    targetPos = self:GetNoTargetRenderPos(world, casterEntityReal)
  end
  if self._pickUpPosAsTarget then
    local targetPosV2 = phaseContext:GetCurGridPos()
    local boardServiceRender = casterEntityReal:GetOwnerWorld():GetService("BoardRender")
    targetPos = boardServiceRender:GridPos2RenderPos(targetPosV2)
  end
  local dir = targetPos - castPos
  local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._flyEffectID, castPos)
  effectEntity:SetDirection(dir)
  local distance = Vector3.Distance(castPos, targetPos)
  local flyTime = 0
  if self._flySpeed then
    flyTime = distance * self._flySpeed
  end
  YIELD(TT)
  local go = effectEntity:View():GetGameObject()
  local dotween
  if self._flyTrace == FlyEffectTraceType.LineTrace then
    if flyTime == 0 and self._flyTime then
      flyTime = self._flyTime
    end
    dotween = go.transform:DOMove(targetPos, flyTime / 1000.0, false)
    if self._flyEaseType then
      local easyType = DG.Tweening.Ease[self._flyEaseType]
      dotween:SetEase(easyType)
    end
  elseif self._flyTrace == FlyEffectTraceType.JumpTrace then
    local jumpPower = math.sqrt(distance)
    flyTime = self._flyTime or flyTime
    dotween = go.transform:DOJump(targetPos, jumpPower, 1, flyTime * 0.001, false)
  elseif self._flyTrace == FlyEffectTraceType.ScaleTrace then
    go.transform.localScale = Vector3(1, 1, distance)
    if self._flyTime then
      flyTime = self._flyTime
    end
  elseif self._flyTrace == FlyEffectTraceType.TimeScaleTrace then
    dotween = go.transform:DOScaleZ(distance, flyTime / 1000.0)
  end
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
      if self._finalWaitTime and self._finalWaitTime > 0 then
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          YIELD(TT, self._finalWaitTime)
          if go then
            go:SetActive(false)
          end
          world:DestroyEntity(effectEntity)
        end)
      else
        go:SetActive(false)
        world:DestroyEntity(effectEntity)
      end
    end)
  end
  local totalWaitTime = flyTime
  if self._finalWaitTime and self._finalWaitTime > 0 then
    totalWaitTime = totalWaitTime + self._finalWaitTime
  end
  if self._isBlock == 1 then
    YIELD(TT, totalWaitTime)
    if not dotween then
      world:DestroyEntity(effectEntity)
    end
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, totalWaitTime)
      if not dotween then
        world:DestroyEntity(effectEntity)
      end
    end)
  end
end

function PlayFlyEffectFromLastTargetToTargetInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayFlyEffectFromLastTargetToTargetInstruction:GetNoTargetRenderPos(world, casterEntity)
  local renderPos = Vector3.zero
  local utilDataSvc = world:GetService("UtilData")
  local boardServiceRender = world:GetService("BoardRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if self._flyTrace == FlyEffectTraceType.LineTrace then
    local scope = skillEffectResultContainer:GetScopeResult()
    local wholeRange = scope:GetWholeGridRange()
    local isBlock = false
    for _, pos in pairs(wholeRange) do
      if utilDataSvc:IsPosBlock(pos, BlockFlag.Skill) then
        isBlock = true
        break
      end
    end
    local attRange = scope:GetAttackRange()
    local posCaster = casterEntity:GridLocation().Position
    local farestPos, farestMagnitude = Vector2.zero, 0
    local range = {}
    if isBlock then
      range = attRange
    else
      range = wholeRange
    end
    for _, pos in pairs(range) do
      local m = Vector2.Magnitude(pos - posCaster)
      if farestMagnitude < m then
        farestPos = pos
        farestMagnitude = m
      end
    end
    renderPos = boardServiceRender:GridPos2RenderPos(farestPos)
  elseif self._flyTrace == FlyEffectTraceType.JumpTrace then
    Log.fatal("### expand by yourself")
  elseif self._flyTrace == FlyEffectTraceType.ScaleTrace then
    Log.fatal("### expand by yourself")
  elseif self._flyTrace == FlyEffectTraceType.TimeScaleTrace then
    Log.fatal("### expand by yourself")
  end
  return renderPos
end
