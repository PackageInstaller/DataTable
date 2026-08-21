require("base_ins_r")
_class("PlayCommonBeHitByDamageIndexInstruction", BaseInstruction)
PlayCommonBeHitByDamageIndexInstruction = PlayCommonBeHitByDamageIndexInstruction

function PlayCommonBeHitByDamageIndexInstruction:Constructor(paramList)
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._trapNotPlayHitEffect = tonumber(paramList.trapNotPlayHitEffect) or 0
  self._waitBeHitFinish = tonumber(paramList.waitBeHitFinish)
end

function PlayCommonBeHitByDamageIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local curDamageIndex = phaseContext:GetCurDamageIndex()
  if curDamageIndex == nil or curDamageIndex < 0 then
    return
  end
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageResultStageCount = skillEffectResultContainer:GetEffectResultsStageCount(SkillEffectType.Damage)
  local taskIDList = {}
  for i, damageResult in ipairs(damageResultArray) do
    if damageResult:GetDamageIndex() == curDamageIndex then
      local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
      if not damageInfo then
        Log.fatal("### damageInfo is nil. curDamageIndex, curDamageInfoIndex=", curDamageIndex, curDamageInfoIndex)
        return
      end
      local damageGridPos = damageResult:GetGridPos()
      local targetID = damageResult:GetTargetID()
      local targetEntity = world:GetEntityByID(targetID)
      local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
      local playHitEffectID = self._hitEffectID
      if self._trapNotPlayHitEffect == 1 and targetEntity:TrapID() then
        playHitEffectID = 0
      end
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(playHitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(curDamageIndex)
      if self._waitBeHitFinish == 1 then
        playSkillService:HandleBeHit(TT, beHitParam)
      elseif self._waitBeHitFinish == 2 then
        local hitBackTaskID = TaskManager:GetInstance():CoreGameStartTask(self._HandleBeHitTask, self, playSkillService, beHitParam)
        phaseContext:AddPhaseTask(hitBackTaskID)
      else
        local hitBackTaskID = TaskManager:GetInstance():CoreGameStartTask(self._HandleBeHitTask, self, playSkillService, beHitParam)
        table.insert(taskIDList, hitBackTaskID)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PlayCommonBeHitByDamageIndexInstruction:_HandleBeHitTask(TT, playSkillService, beHitParam)
  playSkillService:HandleBeHit(TT, beHitParam)
end
