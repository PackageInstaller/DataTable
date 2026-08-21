require("base_ins_r")
_class("PlaySeaWaveAttackInstruction", BaseInstruction)
PlaySeaWaveAttackInstruction = PlaySeaWaveAttackInstruction

function PlaySeaWaveAttackInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._effectBind = paramList.effectBind or "hitpoint"
  self._hitAnimName = paramList.hitAnimName or "Hit"
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._hitBackEndEffectID = tonumber(paramList.hitBackEndEffectID)
  self._hitBackSpeed = tonumber(paramList.hitBackSpeed) or 10
  local boardCenter = paramList.boardCenterPos or "5|5"
  if boardCenter then
    local boardCenterList = string.split(boardCenter, "|")
    self._boardCenterPos = Vector2(tonumber(boardCenterList[1]), tonumber(boardCenterList[2]))
  else
    self._boardCenterPos = Vector2(5, 5)
  end
  self._hitBackEndTime = tonumber(paramList.hitBackEndTime)
end

function PlaySeaWaveAttackInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._hitBackEndEffectID and 0 < self._hitBackEndEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitBackEndEffectID].ResPath,
      1
    })
  end
  return t
end

function PlaySeaWaveAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  local hitBackResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.HitBack)
  if damageResultArray == nil or hitBackResultArray == nil or #damageResultArray == 0 or #hitBackResultArray == 0 then
    return
  end
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local damageResult = damageResultArray[1]
  local hitBackResult = hitBackResultArray[1]
  local waveDir = self:GetWaveDir(hitBackResult:GetHitDir())
  local sEffect = self._world:GetService("Effect")
  local waveEffectEntity = sEffect:CreateWorldPositionDirectionEffect(self._effectID, self._boardCenterPos, waveDir)
  local view = waveEffectEntity:View()
  local waveEffectGO = view:GetGameObject()
  local waveHitTransForm = GameObjectHelper.FindChild(waveEffectGO.transform, self._effectBind)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local targetPos = targetEntity:GetRenderGridPosition()
  YIELD(TT)
  while not self:IsWaveHit(waveEffectGO.transform, hitBackResult:GetHitDir(), targetPos) do
    YIELD(TT)
  end
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageResult:GetDamageInfo(1)):SetHandleBeHitParam_DamagePos(damageResult:GetGridPos()):SetHandleBeHitParam_HitTurnTarget(1):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_HitBackSpeed(self._hitBackSpeed)
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:HandleBeHit(TT, beHitParam)
  local effectEntity = self._world:GetService("Effect"):CreateBeHitEffect(self._hitBackEndEffectID, targetEntity)
  if self._hitBackEndTime then
    YIELD(TT, self._hitBackEndTime)
  end
end

function PlaySeaWaveAttackInstruction:IsWaveHit(transForm, waveDir, targetPos)
  local waveHitTransForm = GameObjectHelper.FindChild(transForm, self._effectBind)
  local boardServiceRender = self._world:GetService("BoardRender")
  local waveHitPosition = boardServiceRender:BoardRenderPos2GridPos(waveHitTransForm.position)
  if waveDir == Vector2(0, 1) and waveHitPosition.y >= targetPos.y then
    return true
  end
  if waveDir == Vector2(0, -1) and waveHitPosition.y <= targetPos.y then
    return true
  end
  if waveDir == Vector2(1, 0) and waveHitPosition.x >= targetPos.x then
    return true
  end
  if waveDir == Vector2(-1, 0) and waveHitPosition.x <= targetPos.x then
    return true
  end
  return false
end

function PlaySeaWaveAttackInstruction:GetWaveDir(hitBackDir)
  if hitBackDir == Vector2(0, 1) then
    return Vector2(-1, 0)
  elseif hitBackDir == Vector2(0, -1) then
    return Vector2(1, 0)
  elseif hitBackDir == Vector2(1, 0) then
    return Vector2(0, 1)
  elseif hitBackDir == Vector2(-1, 0) then
    return Vector2(0, -1)
  end
end
