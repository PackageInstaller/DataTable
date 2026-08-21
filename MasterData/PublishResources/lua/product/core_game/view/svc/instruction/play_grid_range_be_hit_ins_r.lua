require("base_ins_r")
_class("PlayGridRangeBeHitInstruction", BaseInstruction)
PlayGridRangeBeHitInstruction = PlayGridRangeBeHitInstruction

function PlayGridRangeBeHitInstruction:Constructor(paramList)
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._bodyArea = tonumber(paramList.bodyArea) or 1
  self._damageStageIndex = tonumber(paramList.damageStageIndex) or 1
  if paramList.hitBackSpeed then
    self._hitBackSpeed = tonumber(paramList.hitBackSpeed)
  end
  self._hitBackUseDamageIndex = tonumber(paramList.hitBackUseDamageIndex) or 0
end

function PlayGridRangeBeHitInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    return
  end
  local maxScopeRangeCount = phaseContext:GetMaxRangeCount()
  if not maxScopeRangeCount then
    return
  end
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  if maxScopeRangeCount < curScopeGridRangeIndex then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local visited = {}
  local taskIds = {}
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      if posList then
        for _, pos in pairs(posList) do
          if self._bodyArea == 1 then
            local t = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, self._damageStageIndex)
            for damageIndex, result in ipairs(t) do
              if result:GetGridPos() == pos then
                local taskid = self:_CommonBeHit(TT, casterEntity, phaseContext, result, damageIndex)
                taskIds[#taskIds + 1] = taskid
              end
            end
          elseif self._bodyArea == 4 then
            local bodyAreaFix = {}
            table.insert(bodyAreaFix, Vector2(0.5, 0.5))
            table.insert(bodyAreaFix, Vector2(0.5, -0.5))
            table.insert(bodyAreaFix, Vector2(-0.5, 0.5))
            table.insert(bodyAreaFix, Vector2(-0.5, -0.5))
            for _, bodyArea in pairs(bodyAreaFix) do
              local workPos = bodyArea + pos
              local t = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, self._damageStageIndex)
              for damageIndex, result in ipairs(t) do
                if result:GetGridPos() == workPos and not table.icontains(visited, workPos) then
                  visited[#visited + 1] = workPos
                  local taskid = self:_CommonBeHit(TT, casterEntity, phaseContext, result, damageIndex)
                  taskIds[#taskIds + 1] = taskid
                end
              end
            end
          end
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
    YIELD(TT)
  end
end

function PlayGridRangeBeHitInstruction:_CommonBeHit(TT, casterEntity, phaseContext, damageResult, damageIndex)
  local targetID = damageResult:GetTargetID()
  if not targetID then
    return 0
  end
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local targetEntity = world:GetEntityByID(targetID)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, curDamageResultStageIndex)
  local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  if skillEffectResultContainer:IsFinalAttack() and damageResultArray[#damageResultArray] == damageResult then
    playFinalAttack = true
  end
  local taskid = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(damageIndex):SetHandleBeHitParam_HitBackSpeed(self._hitBackSpeed):SetHandleBeHitParam_HitBackUseDamageIndex(self._hitBackUseDamageIndex)
    playSkillService:HandleBeHit(TT, beHitParam)
  end)
  return taskid
end

function PlayGridRangeBeHitInstruction:_GetFinalAttackIndex(damageResultArray)
  if not damageResultArray then
    return -1
  end
  for i = #damageResultArray, 1, -1 do
    local result = damageResultArray[i]
    local targetId = result:GetTargetID()
    if targetId ~= nil and 0 < targetId then
      return i
    end
  end
  return -1
end
