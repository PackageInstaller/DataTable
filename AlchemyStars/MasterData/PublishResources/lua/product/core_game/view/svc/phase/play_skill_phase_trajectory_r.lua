require("play_skill_phase_base_r")
_class("PlaySkillPhase_Trajectory", PlaySkillPhaseBase)
PlaySkillPhase_Trajectory = PlaySkillPhase_Trajectory

function PlaySkillPhase_Trajectory:PlayFlight(TT, casterEntity, phaseParam)
  local paramWork = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalHit = skillEffectResultContainer:IsFinalAttack()
  local posCaster = casterEntity:GetGridPosition()
  local posTarget = Vector2.New(0, 0)
  local posStart = self:_PhaseWorkPos(paramWork:GetCasterType(), paramWork:GetCasterParam(), posCaster, posTarget)
  local posEnd = self:_PhaseWorkPos(paramWork:GetTargetType(), paramWork:GetTargetParam(), posCaster, posTarget)
  local bHaveBit = self:_TrajectoryAction(TT, skillID, paramWork, casterEntity, posStart, posEnd, isFinalHit)
  local finishDelayTime = paramWork:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
end

function PlaySkillPhase_Trajectory:_PhaseWorkPos(posType, posParam, posCaster, posTarget)
  local posReturn = Vector2.New(0, 0)
  if SkillPhaseParam_PointType.CasterPos == posType then
    posReturn = posCaster
  elseif SkillPhaseParam_PointType.CasterX == posType then
    posReturn.x = posCaster.x
    posReturn.y = posParam.y
  elseif SkillPhaseParam_PointType.CasterY == posType then
    posReturn.x = posParam.x
    posReturn.y = posCaster.y
  elseif SkillPhaseParam_PointType.TargetPos == posType then
    posReturn = posTarget
  elseif SkillPhaseParam_PointType.TargetX == posType then
    posReturn.x = posTarget.x
    posReturn.y = posParam.y
  elseif SkillPhaseParam_PointType.TargetY == posType then
    posReturn.x = posParam.x
    posReturn.y = posTarget.y
  elseif SkillPhaseParam_PointType.UserParam == posType then
    posReturn = posParam
  end
  return posReturn
end

function PlaySkillPhase_Trajectory:_TrajectoryAction(TT, nSkillID, phaseParam, entityCaster, posStart, posEnd, isFinalHit)
  local nTrajectoryType = phaseParam:GetTrajectoryType()
  if nil == nTrajectoryType then
    return false
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local effectService = self._world:GetService("Effect")
  local entityEffect
  local posDirectory = posEnd - posStart
  local nEffectOffset = phaseParam:GetTrajectoryEffectOffset()
  local posCreate = posStart
  if nEffectOffset and nEffectOffset ~= 0 then
    local nDirectoryLen = math.max(math.abs(posDirectory.x), math.abs(posDirectory.y), 1)
    local effectDirector = Vector2(posDirectory.x / nDirectoryLen, posDirectory.y / nDirectoryLen)
    posCreate = posStart + nEffectOffset * effectDirector
  end
  local nTrajectoryEffectID = phaseParam:GetTrajectoryEffectID()
  entityEffect = effectService:CreateWorldPositionDirectionEffect(nTrajectoryEffectID, posCreate, posDirectory)
  YIELD(TT)
  local disx = math.abs(posEnd.x - posStart.x)
  local disy = math.abs(posEnd.y - posStart.y)
  local dis = math.sqrt(disx * disx + disy * disy)
  local nTotalTime = phaseParam:GetTotalTime()
  if nil == nTotalTime then
    local nTrajectoryTime = phaseParam:GetTrajectoryTime()
    nTotalTime = dis * nTrajectoryTime
  end
  local nFlyTime = nTotalTime / 1000.0
  local nEndTime = GameGlobal:GetInstance():GetCurrentTime() + nTotalTime
  local trajectoryObject = entityEffect:View():GetGameObject()
  local transWork = trajectoryObject.transform
  local gridWorldpos = boardServiceRender:GridPos2RenderPos(posEnd)
  local easeWork
  if SkillPhaseParam_TrajectoryType.Line == nTrajectoryType then
    easeWork = transWork:DOMove(gridWorldpos, nFlyTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  elseif SkillPhaseParam_TrajectoryType.Parabola == nTrajectoryType then
    transWork.position = transWork.position + Vector3.up * 1
    local jumpPower = math.sqrt(disx + disy)
    local sequence = transWork:DOJump(gridWorldpos, jumpPower, 1, nFlyTime, false)
    easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
  elseif SkillPhaseParam_TrajectoryType.Laser == nTrajectoryType then
    local sequence = transWork:DOScaleZ(dis, nFlyTime)
    easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
  end
  if SkillPhaseParam_TrajectoryType.Line == nTrajectoryType then
    self:_CheckFlyAttack(TT, nSkillID, phaseParam, entityCaster, entityEffect, nEndTime, posStart, posEnd, isFinalHit)
    self:_DelEffectEntity(TT, trajectoryObject, entityEffect)
  else
    if easeWork then
      easeWork:OnComplete(function()
        self:_OnTrajectoryEnd(TT, nSkillID, phaseParam, entityCaster, posStart, posEnd, isFinalHit)
        self:_DelEffectEntity(TT, trajectoryObject, entityEffect)
      end)
    end
    while nEndTime > GameGlobal:GetInstance():GetCurrentTime() do
      YIELD(TT)
    end
  end
  return true
end

function PlaySkillPhase_Trajectory:_OnTrajectoryEnd(TT, nSkillID, phaseParam, entityCaster, posStart, posEnd, isFinalHit)
  local skillEffectResultContainer = entityCaster:SkillRoutine():GetResultContainer()
  local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, posEnd)
  if damageResult then
    local damageData = damageResult:GetDamageInfo(phaseParam:GetDamageIndex())
    if damageData then
      local entityTarget = self._world:GetEntityByID(damageResult:GetTargetID())
      self:_OnFlyAttack(TT, nSkillID, phaseParam, entityCaster, entityTarget, damageData, posStart, posEnd, isFinalHit)
    end
  end
end

function PlaySkillPhase_Trajectory:_DelEffectEntity(TT, trajectoryObject, entityEffect)
  trajectoryObject:SetActive(false)
  self._world:DestroyEntity(entityEffect)
end

function PlaySkillPhase_Trajectory:_GetEntityPosByView(entityWork)
  local effectViewCmpt = entityWork:View()
  if nil == effectViewCmpt then
    return nil
  end
  local effectObject = effectViewCmpt:GetGameObject()
  if nil == effectObject then
    return nil
  end
  local effectTrans = effectObject.transform
  local boardServiceRender = self._world:GetService("BoardRender")
  local posReturn = boardServiceRender:BoardRenderPos2GridPos(effectTrans.position)
  return posReturn
end

function PlaySkillPhase_Trajectory:_CheckFlyAttack(TT, nSkillID, phaseParam, entityCaster, entityEffect, nEndTime, posStart, posEnd, isFinalHit)
  if nil == entityEffect then
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local hitAnimName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffectID()
  local hitEffectTime = phaseParam:GetHitEffectTime()
  local nWaitTime = phaseParam:GetTargetWaitTime() or 0
  local skillEffectResultContainer = entityCaster:SkillRoutine():GetResultContainer()
  self:_InitFlyPosList()
  local bFirstAttack = true
  while nEndTime > GameGlobal:GetInstance():GetCurrentTime() do
    local posFly = self:_GetEntityPosByView(entityEffect)
    if posFly then
      local listDamageData = self:_FindFlyDamageResult(skillEffectResultContainer, posFly, posStart, posEnd, 2)
      for posDamage, damageResult in pairs(listDamageData) do
        local damageData = damageResult:GetDamageInfo(phaseParam:GetDamageIndex())
        if damageData then
          local entityTarget = self._world:GetEntityByID(damageResult:GetTargetID())
          if bFirstAttack then
            bFirstAttack = false
            self:_DelayTime(TT, nWaitTime)
          end
          local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._OnFlyAttack, self, nSkillID, phaseParam, entityCaster, entityTarget, damageData, posStart, posDamage, isFinalHit)
          playSkillService:AddWaitFreeTask(nTaskID)
        end
      end
    end
    YIELD(TT)
  end
end

function PlaySkillPhase_Trajectory:_PlayTargetEffect(TT, phaseParam, posStart, posEnd)
  local nEffectID = phaseParam:GetTargetEffectID()
  local nShowTime = phaseParam:GetTargetDelayTime()
  if nil == nEffectID or nEffectID <= 0 then
    return
  end
  local effectService = self._world:GetService("Effect")
  local posDirectory = posEnd - posStart
  local entityEffect = effectService:CreateWorldPositionDirectionEffect(nEffectID, posEnd, posDirectory)
  YIELD(TT, nShowTime)
end

function PlaySkillPhase_Trajectory:_PlayHitEffect(TT, phaseParam, entityCast, entityTarget, damageData, damagePos, isFinalHit, nSkillID)
  local hitAnimationName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffectID()
  local skillService = self:SkillService()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(entityCast):SetHandleBeHitParam_TargetEntity(entityTarget):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damageData):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(phaseParam:IsClearBodyNow()):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(nSkillID)
  skillService:HandleBeHit(TT, beHitParam)
end

function PlaySkillPhase_Trajectory:_OnFlyAttack(TT, nSkillID, phaseParam, entityCaster, entityTarget, damageData, posStart, posEnd, isFinalHit)
  self:_PlayTargetEffect(TT, phaseParam, posStart, posEnd)
  if damageData then
    self:_PlayHitEffect(TT, phaseParam, entityCaster, entityTarget, damageData, posEnd, isFinalHit, nSkillID)
  end
end

function PlaySkillPhase_Trajectory:_InitFlyPosList()
  self.m_listFlyPos = {}
end

function PlaySkillPhase_Trajectory:_IsHaveFlyPosList(pos)
  if table.icontains(self.m_listFlyPos, pos) then
    return true
  end
  self.m_listFlyPos[#self.m_listFlyPos + 1] = pos
  return false
end

function PlaySkillPhase_Trajectory:_FindFlyDamageResult(skillEffectResultContainer, posFly, posStart, posEnd, nCheckRange)
  local dir = posStart - posEnd
  local dirTemp = Vector2.New(math.abs(dir.x), math.abs(dir.y))
  if dirTemp.x > 0 then
    dir.x = dir.x / dirTemp.x
  end
  if dirTemp.y > 0 then
    dir.y = dir.y / dirTemp.y
  end
  local listDamageData = {}
  for i = 0, nCheckRange do
    local posNew = posFly + dir * (nCheckRange - i)
    if posNew.x > 0 and posNew.y > 0 then
      local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, posNew)
      if damageResult and false == self:_IsHaveFlyPosList(posNew) then
        listDamageData[posNew] = damageResult
      end
    end
  end
  return listDamageData
end
