_class("PlayPet1601821ChainJumpDamageInstruction", BaseInstruction)
PlayPet1601821ChainJumpDamageInstruction = PlayPet1601821ChainJumpDamageInstruction

function PlayPet1601821ChainJumpDamageInstruction:Constructor(paramList)
  self._casterAnimateTrigger = paramList.casterAnimateTrigger
  self._jumpTimeMs = tonumber(paramList.jumpTimeMs)
  self._landingTimeMs = tonumber(paramList.landingTimeMs)
  self._centerGridEffectID = tonumber(paramList.centerGridEffectID)
  self._gridRangeWaitTimeMs = tonumber(paramList.gridRangeWaitTimeMs)
  self._damageGridEffectID = tonumber(paramList.damageGridEffectID)
  self._waitDamageTimeMs = tonumber(paramList.waitDamageTimeMs)
end

function PlayPet1601821ChainJumpDamageInstruction:GetCacheResource()
  local t = {}
  if self._centerGridEffectID and self._centerGridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._centerGridEffectID].ResPath,
      1
    })
  end
  if self._damageGridEffectID and 0 < self._damageGridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._damageGridEffectID].ResPath,
      10
    })
  end
  return t
end

function PlayPet1601821ChainJumpDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DynamicCenterDamage) or {}
  local result = resultArray[1]
  if not result then
    return
  end
  local centerScope = result:GetDamageScope()
  local viewCenterPos = centerScope:GetCenterPos()
  local effectService = world:GetService("Effect")
  effectService:CreateCommonGridEffect(self._centerGridEffectID, viewCenterPos, casterEntity:GetRenderGridDirection())
  local viewPosition = casterEntity:GetRenderGridPosition()
  casterEntity:SetAnimatorControllerTriggers({
    self._casterAnimateTrigger
  })
  YIELD(TT, self._jumpTimeMs)
  casterEntity:SetLocation(viewCenterPos)
  YIELD(TT, self._landingTimeMs)
  local playSkillService = world:GetService("PlaySkill")
  local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local skillID = skillEffectResultContainer:GetSkillID()
  local curDamageIndex = phaseContext:GetCurDamageResultIndex()
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex() or 1
  local curDamageResultStageIndex = phaseContext:GetCurDamageResultStageIndex() or 1
  local damageResults = result:GetDamageResults()
  local damageByPosIndex = {}
  for _, damageResult in ipairs(damageResults) do
    local target = damageResult:GetTargetID()
    local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
    if target and 0 < target and damageInfo then
      local eTarget = world:GetEntityByID(target)
      local damageGridPos = damageResult:GetGridPos()
      local posIndex = Vector2.Pos2Index(damageGridPos)
      if not damageByPosIndex[posIndex] then
        damageByPosIndex[posIndex] = {}
      end
      table.insert(damageByPosIndex[posIndex], damageResult)
    end
  end
  local damageScope = result:GetDamageScope()
  local scopeGridSort = DataSortScopeGridRangeInstruction:New({sortType = 1})
  local res, maxGridCount = scopeGridSort:_SortGridNearToFar(damageScope:GetAttackRange(), viewCenterPos)
  for rangeIndex = 1, maxGridCount do
    for _, range in pairs(res) do
      if range then
        local posList = range[rangeIndex]
        if posList then
          local len = table.count(posList)
          for i = 1, len do
            local pos = posList[i]
            local targetPos = pos
            effectService:CreateWorldPositionDirectionEffect(self._damageGridEffectID, targetPos, targetPos - viewCenterPos)
            local posIndex = Vector2.Pos2Index(pos)
            if damageByPosIndex[posIndex] then
              local damageResultsAtPos = damageByPosIndex[posIndex]
              for _, damageResult in ipairs(damageResultsAtPos) do
                local target = damageResult:GetTargetID()
                local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
                if target and 0 < target and damageInfo then
                  local eTarget = world:GetEntityByID(target)
                  local damageGridPos = damageResult:GetGridPos()
                  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(eTarget):SetHandleBeHitParam_HitAnimName("hit"):SetHandleBeHitParam_HitEffectID(0):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(1):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(curDamageIndex)
                  local hitBackTaskID = TaskManager:GetInstance():CoreGameStartTask(playSkillService.HandleBeHit, playSkillService, beHitParam)
                  phaseContext:AddPhaseTask(hitBackTaskID)
                end
              end
            end
          end
        end
      end
    end
    YIELD(TT, self._gridRangeWaitTimeMs)
  end
  YIELD(TT, self._waitDamageTimeMs)
  casterEntity:SetLocation(viewPosition)
end
