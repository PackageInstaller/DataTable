require("base_ins_r")
_class("PlayPeacockChainHitInstruction", BaseInstruction)
PlayPeacockChainHitInstruction = PlayPeacockChainHitInstruction

function PlayPeacockChainHitInstruction:Constructor(paramList)
  self._casterEffectID = tonumber(paramList.casterEffectID)
  self._characterEffectSlots = {}
  local characterSlots = string.split(paramList.characterSlots, "|")
  for _, slot in ipairs(characterSlots) do
    local v = string.split(slot, "/")
    table.insert(self._characterEffectSlots, Vector3.New(tonumber(v[1]), tonumber(v[2]), tonumber(v[3])))
  end
  self._hitPosTrailEffectID = tonumber(paramList.hitPosTrailEffectID)
  self._trailDelay = tonumber(paramList.trailDelay)
  self._hitAnimName = paramList.hitAnimName
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._hitGridEffectID = tonumber(paramList.hitGridEffectID)
  self._hitDelay = tonumber(paramList.hitDelay)
end

function PlayPeacockChainHitInstruction:DoInstruction(TT, casterEntity, phaseContext)
  TaskManager:GetInstance():CoreGameStartTask(self.TaskFunc, self, casterEntity, phaseContext)
end

function PlayPeacockChainHitInstruction:TaskFunc(TT, casterEntity, phaseContext)
  local container = casterEntity:SkillRoutine():GetResultContainer()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local damageResultArray = container:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageResult = damageResultArray[curDamageIndex]
  local slot = self._characterEffectSlots[curDamageIndex]
  local csTransform = casterEntity:View():GetGameObject().transform
  local v3CasterEffect = csTransform:TransformPoint(slot)
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local fxCaster = fxsvc:CreatePositionEffect(self._casterEffectID, v3CasterEffect)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  if targetEntityID == nil or targetEntityID < 0 then
    return
  end
  local targetEntity = world:GetEntityByID(targetEntityID)
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
  local playSkillService = world:GetService("PlaySkill")
  local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local skillID = container:GetSkillID()
  YIELD(TT, self._trailDelay)
  local v2HitPos = damageResult:GetGridPos()
  local brsvc = world:GetService("BoardRender")
  local targetPos = brsvc:BoardRenderPos2FloatGridPos(v3CasterEffect)
  local dir = targetPos - v2HitPos
  local fxTargetPosTrail = fxsvc:CreateWorldPositionEffect(self._hitPosTrailEffectID, v2HitPos)
  local v3Dir = v3CasterEffect - brsvc:GridPos2RenderPos(v2HitPos)
  fxTargetPosTrail:SetDirection(v3Dir)
  YIELD(TT, self._hitDelay)
  local fxTargetPosGrid = fxsvc:CreateWorldPositionEffect(self._hitGridEffectID, v2HitPos)
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(0):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(v2HitPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlayPeacockChainHitInstruction:GetCacheResource()
  local t = {}
  if self._casterEffectID and self._casterEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._casterEffectID].ResPath,
      1
    })
  end
  if self._hitPosTrailEffectID and 0 < self._hitPosTrailEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitPosTrailEffectID].ResPath,
      1
    })
  end
  if self._hitGridEffectID and 0 < self._hitGridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitGridEffectID].ResPath,
      1
    })
  end
  return t
end
