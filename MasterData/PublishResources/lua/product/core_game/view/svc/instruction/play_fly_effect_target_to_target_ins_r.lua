require("base_ins_r")
_class("PlayFlyEffectTargetToTargetInstruction", BaseInstruction)
PlayFlyEffectTargetToTargetInstruction = PlayFlyEffectTargetToTargetInstruction

function PlayFlyEffectTargetToTargetInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flyTime = tonumber(paramList.flyTime)
  self._flyTrace = tonumber(paramList.flyTrace)
  self._casterType = tonumber(paramList.casterType)
  self._casterParam = tonumber(paramList.casterParam)
  self._targetType = tonumber(paramList.targetType)
  self._targetParam = tonumber(paramList.targetParam)
end

function PlayFlyEffectTargetToTargetInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayFlyEffectTargetToTargetInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalHit = skillEffectResultContainer:IsFinalAttack()
  local posCaster = casterEntity:GetGridPosition()
  local posTarget = Vector2.New(0, 0)
  local posStart = self:_PhaseWorkPos(self._casterType, self._casterParam, posCaster, posTarget)
  local posEnd = self:_PhaseWorkPos(self._targetType, self._targetParam, posCaster, posTarget)
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local entityEffect
  local posDirectory = posEnd - posStart
  entityEffect = effectService:CreateWorldPositionDirectionEffect(self._flyEffectID, posStart, posDirectory)
  YIELD(TT)
  local disx = math.abs(posEnd.x - posStart.x)
  local disy = math.abs(posEnd.y - posStart.y)
  local dis = math.sqrt(disx * disx + disy * disy)
  local nTotalTime = self._flyTime
  local nFlyTime = nTotalTime / 1000.0
  local nEndTime = GameGlobal:GetInstance():GetCurrentTime() + nTotalTime
  local trajectoryObject = entityEffect:View():GetGameObject()
  local transWork = trajectoryObject.transform
  local gridWorldpos = boardServiceRender:GridPos2RenderPos(posEnd)
  local easeWork
  if SkillPhaseParam_TrajectoryType.Line == self._flyTrace then
    easeWork = transWork:DOMove(gridWorldpos, nFlyTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  elseif SkillPhaseParam_TrajectoryType.Parabola == self._flyTrace then
    transWork.position = transWork.position + Vector3.up * 1
    local jumpPower = math.sqrt(disx + disy)
    local sequence = transWork:DOJump(gridWorldpos, jumpPower, 1, nFlyTime, false)
    easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
  elseif SkillPhaseParam_TrajectoryType.Laser == self._flyTrace then
    local sequence = transWork:DOScaleZ(dis, nFlyTime)
    easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
  end
  while nEndTime > GameGlobal:GetInstance():GetCurrentTime() do
    YIELD(TT)
  end
  self:_DelEffectEntity(TT, world, trajectoryObject, entityEffect)
end

function PlayFlyEffectTargetToTargetInstruction:_PhaseWorkPos(posType, posParam, posCaster, posTarget)
  local posReturn = Vector2.New(0, 0)
  if SkillPhaseParam_PointType.CasterPos == posType then
    posReturn = posCaster
  elseif SkillPhaseParam_PointType.CasterX == posType then
    posReturn.x = posCaster.x
    posReturn.y = posParam
  elseif SkillPhaseParam_PointType.CasterY == posType then
    posReturn.x = posParam
    posReturn.y = posCaster.y
  end
  return posReturn
end

function PlayFlyEffectTargetToTargetInstruction:_DelEffectEntity(TT, world, trajectoryObject, entityEffect)
  trajectoryObject:SetActive(false)
  world:DestroyEntity(entityEffect)
end
