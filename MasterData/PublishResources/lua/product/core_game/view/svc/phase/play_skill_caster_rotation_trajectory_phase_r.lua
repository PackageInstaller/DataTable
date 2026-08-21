require("play_skill_phase_base_r")
_class("PlaySkillCasterRotationTrajectoryPhase", PlaySkillPhaseBase)
PlaySkillCasterRotationTrajectoryPhase = PlaySkillCasterRotationTrajectoryPhase

function PlaySkillCasterRotationTrajectoryPhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  local effectID = effectParam:GetEffectID()
  local fireEffectID = effectParam:GetFireEffectID()
  local spawnHigh = effectParam:GetSpawnHigh()
  local spawnRadius = effectParam:GetSpawnRadius()
  local rotationTime = effectParam:GetRotationTime()
  local flyOneTime = effectParam:GetFlyOneTime()
  self._destroyBulletDelay = effectParam:GetdestroyBulletDelay()
  self._disableRoot = effectParam:GetDisableRoot()
  self._turnToTarget = effectParam:GetTurnToTarget()
  self._hitAnimName = effectParam:GetHitAnimName()
  self._hitEffectID = effectParam:GetHitEffectID()
  self._casterEntity = casterEntity
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local playSkillService = world:GetService("PlaySkill")
  local casterRenderPos = casterEntity:Location():GetPosition()
  local targetDirPos = casterRenderPos + Vector3(0, 0, 20)
  local baseDir = targetDirPos - casterRenderPos
  local hasTargetDamageResultArray = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity then
      local targetRenderPos = targetEntity:Location():GetPosition()
      local curDir = targetRenderPos - casterRenderPos
      local angle = Vector3.Angle(baseDir, curDir)
      if targetRenderPos.x < casterRenderPos.x then
        angle = 360 - angle
      end
      table.insert(hasTargetDamageResultArray, {
        damageResult = damageResult,
        angle = angle,
        dir = curDir
      })
    end
  end
  if table.count(hasTargetDamageResultArray) == 0 then
    return
  end
  table.sort(hasTargetDamageResultArray, function(a, b)
    return a.angle < b.angle
  end)
  self._remainCount = table.count(hasTargetDamageResultArray)
  for _, v in ipairs(hasTargetDamageResultArray) do
    local damageResult = v.damageResult
    local angle = v.angle
    local dir = v.dir
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    local targetBoneTransform = playSkillService:GetEntityRenderSelectBoneTransform(targetEntity, "Hit")
    local targetPos = targetBoneTransform.position
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      local waitFireTime = angle / 360 * rotationTime
      YIELD(TT, waitFireTime)
      local firePos = casterRenderPos + dir.normalized * spawnRadius
      firePos = firePos + Vector3(0, spawnHigh, 0)
      local fireDir = targetPos - firePos
      local effectEntity = effectService:CreatePositionEffect(effectID, firePos)
      effectEntity:SetDirection(fireDir)
      local go = effectEntity:View():GetGameObject()
      if self._disableRoot then
        local disableTransform = go.transform:Find(self._disableRoot)
        if disableTransform then
          disableTransform.gameObject:SetActive(true)
        end
      end
      local fireEffectEntity = effectService:CreatePositionEffect(fireEffectID, firePos)
      fireEffectEntity:SetDirection(fireDir)
      local flyDis = Vector3.Distance(targetPos, firePos)
      local flyTime = flyDis * flyOneTime
      local trajectoryObject = effectEntity:View():GetGameObject()
      local transWork = trajectoryObject.transform
      transWork:DOMove(targetPos, flyTime / 1000, false):SetEase(DG.Tweening.Ease.Linear)
      YIELD(TT, flyTime)
      self:_OnPlayHit(TT, damageResult, effectEntity, firePos)
    end)
  end
  while self._remainCount > 0 do
    YIELD(TT)
  end
  YIELD(TT)
end

function PlaySkillCasterRotationTrajectoryPhase:_OnPlayHit(TT, damageResult, effectEntity, firePos)
  local skillEffectResultContainer = self._casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageInfo = damageResult:GetDamageInfo(1)
  local targetEntity = self._world:GetEntityByID(damageResult:GetTargetID())
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  if skillEffectResultContainer:IsFinalAttack() and self._remainCount == 1 then
    playFinalAttack = true
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(self._casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(0):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
  local effectService = self._world:GetService("Effect")
  local targetBoneTransform = playSkillService:GetEntityRenderSelectBoneTransform(targetEntity, "Hit")
  local hitPos = targetBoneTransform.position
  local hitEffectEntity = effectService:CreatePositionEffect(self._hitEffectID, hitPos)
  local hitDir = hitPos - firePos
  hitEffectEntity:SetDirection(hitDir)
  local go = effectEntity:View():GetGameObject()
  if self._disableRoot then
    local disableTransform = go.transform:Find(self._disableRoot)
    if disableTransform then
      disableTransform.gameObject:SetActive(false)
    end
  end
  YIELD(TT, self._destroyBulletDelay)
  self._world:DestroyEntity(effectEntity)
  self._remainCount = self._remainCount - 1
end
