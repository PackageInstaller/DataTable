require("base_ins_r")
_class("PlayMinosAttackInstruction", BaseInstruction)
PlayMinosAttackInstruction = PlayMinosAttackInstruction

function PlayMinosAttackInstruction:Constructor(paramList)
  self._attackBeginAnimName = paramList.attackBeginAnimName
  self._attackBeginAnimNameWaitTime = tonumber(paramList.attackBeginAnimNameWaitTime or 0)
  self._attackEffectID = tonumber(paramList.attackEffectID)
  self._attackLoopAnimName = paramList.attackLoopAnimName
  self._attackLoopAnimNameWaitTime = tonumber(paramList.attackLoopAnimNameWaitTime or 0)
  self._attackWaitTime = tonumber(paramList.attackWaitTime or 0)
  self._attackEndAnimName = paramList.attackEndAnimName
  self._attackEndAnimNameWaitTime = tonumber(paramList.attackEndAnimNameWaitTime or 0)
  self._castLineEffectWaitTime = tonumber(paramList.lineEffectWaitTime)
  self._castLineEffectID = tonumber(paramList.lineEffectID)
  self._castHitEffectID = tonumber(paramList.hitEffectID)
  self._attackMaxCount = tonumber(paramList.attackMaxCount)
  self._hitAnimName = paramList.hitAnimName or "Hit"
  self._lineSpeed = tonumber(paramList.lineSpeed) or 160
  self._attackAudioID = tonumber(paramList.attackAudioID)
  self._attackAudioWaitTime = tonumber(paramList.attackAudioIDWaitTime)
  self._castLineOffsetX = tonumber(paramList.castLineOffsetX)
  self._castLineOffsetY = tonumber(paramList.castLineOffsetY)
  self._castLineOffsetZ = tonumber(paramList.castLineOffsetZ)
end

function PlayMinosAttackInstruction:GetCacheResource()
  local t = {}
  if self._castLineEffectID and self._castLineEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._castLineEffectID].ResPath,
      1
    })
  end
  if self._castHitEffectID and 0 < self._castHitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._castHitEffectID].ResPath,
      1
    })
  end
  if self._attackEffectID and 0 < self._attackEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._attackEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayMinosAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  self._world = casterEntity:GetOwnerWorld()
  local playDamageService = self._world:GetService("PlayDamage")
  self.casterEntity = casterEntity
  self._effectSvc = self._world:GetService("Effect")
  self._waitTaskID = {}
  self._skillID = skillEffectResultContainer:GetSkillID()
  if not results then
    Log.fatal("no results")
    return
  end
  local casterPos = casterEntity:GetRenderGridPosition()
  local result = results[1]
  local targetID = result:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetID)
  local targetPos = targetEntity:GetRenderGridPosition()
  local dir = targetPos - casterPos
  casterEntity:SetDirection(dir)
  casterEntity:SetAnimatorControllerTriggers({
    self._attackBeginAnimName
  })
  if self._attackBeginAnimNameWaitTime > 0 then
    YIELD(TT, self._attackBeginAnimNameWaitTime)
  end
  self._playSkillInsSvc = self._world:GetService("PlaySkillInstruction")
  local lineEffectPos = casterEntity:View():GetGameObject().transform:TransformPoint(Vector3(self._castLineOffsetX, self._castLineOffsetY, self._castLineOffsetZ))
  local index = 1
  while index <= self._attackMaxCount and index <= #results do
    local result = results[index]
    casterEntity:SetAnimatorControllerTriggers({
      self._attackLoopAnimName
    })
    self._playSkillInsSvc:PlayAttackAudio(self._attackAudioWaitTime, casterEntity, self._attackAudioID)
    self._effectSvc:CreateEffect(self._attackEffectID, casterEntity)
    local targetID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetID)
    local attackTaskID = TaskManager:GetInstance():CoreGameStartTask(self.PlayBeHit, self, targetEntity, self._castLineEffectID, self._castHitEffectID, result, self._attackLoopAnimNameWaitTime, lineEffectPos)
    table.insert(self._waitTaskID, attackTaskID)
    if 0 < self._attackWaitTime then
      YIELD(TT, self._attackWaitTime)
    end
    index = index + 1
  end
  casterEntity:SetAnimatorControllerTriggers({
    self._attackEndAnimName
  })
  if 0 < self._attackEndAnimNameWaitTime then
    YIELD(TT, self._attackEndAnimNameWaitTime)
  end
  for i = index + 1, #results do
    local damageResult = results[i]
    local damageGridPos = damageResult:GetGridPos()
    local damageInfo = damageResult:GetDamageInfo(1)
    local skillID = skillEffectResultContainer:GetSkillID()
    local targetEntityID = phaseContext:GetCurTargetEntityID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      local damageShowType = playDamageService:SingleOrGrid(skillID)
      damageInfo:SetShowType(damageShowType)
      damageInfo:SetRenderGridPos(damageGridPos)
      playDamageService:AsyncUpdateHPAndDisplayDamage(targetEntity, damageInfo)
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(self._waitTaskID) do
    YIELD(TT)
  end
end

function PlayMinosAttackInstruction:PlayBeHit(TT, targetEntity, lineEffectID, hitEffectID, damageResult, waitTime, casterPos)
  if 0 < waitTime then
    YIELD(TT, waitTime)
  end
  local targetPos = targetEntity:GetPosition()
  local holderTf = targetEntity:View().ViewWrapper.Transform
  local bindTf = GameObjectHelper.FindChild(holderTf, "Hit")
  if bindTf then
    targetPos = bindTf.position
  end
  local dis = Vector3.Distance(casterPos, targetPos)
  local dir = targetPos - casterPos
  if 1.4 < dis then
    local effectEntity = self._effectSvc:CreatePositionEffect(lineEffectID, casterPos)
    effectEntity:SetDirection(dir)
    local go = effectEntity:View():GetGameObject()
    local dotween = go.transform:DOMove(targetPos, self._lineSpeed / 1000.0, false)
    if self._flyEaseType then
      local easyType = DG.Tweening.Ease[self._flyEaseType]
      dotween:SetEase(easyType)
    end
    YIELD(TT, self._lineSpeed)
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(self.casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(false):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(self._skillID):SetHandleBeHitParam_DamageIndex(1)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlayMinosAttackInstruction:GetCacheAudio()
  if self._attackAudioID and self._attackAudioID > 0 then
    return {
      self._attackAudioID
    }
  end
end
