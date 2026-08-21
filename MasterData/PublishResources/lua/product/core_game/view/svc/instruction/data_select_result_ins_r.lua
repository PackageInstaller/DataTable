require("base_ins_r")
_class("DataSelectResultInstruction", BaseInstruction)
DataSelectResultInstruction = DataSelectResultInstruction

function DataSelectResultInstruction:Constructor(paramList)
  self.EffectResultTypeOverride = {
    [SkillEffectType.SummonMultipleTrap] = SkillEffectType.SummonTrap
  }
  self._effectType = tonumber(paramList.effectType)
  self._index = tonumber(paramList.index)
  self._stageIndex = tonumber(paramList.damageStageIndex)
end

function DataSelectResultInstruction:GetEffectType()
  return self._effectType
end

function DataSelectResultInstruction:GetIndex()
  return self._index
end

function DataSelectResultInstruction:_LogWarning(...)
  Log.warn(self._className, ...)
end

function DataSelectResultInstruction:_GetEffectTypeForResults(effectType)
  local overrideEffectType = SkillEffectResultTypeOverride[effectType]
  if overrideEffectType then
    Log.notice(self._className, "override effectType for results: ", effectType, "=>", overrideEffectType)
    effectType = overrideEffectType
  end
  return effectType
end

function DataSelectResultInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._currentPhaseContext = phaseContext
  local effectType = self:GetEffectType()
  local resultEffectType = self:_GetEffectTypeForResults(effectType)
  local index = self:GetIndex()
  assert(effectType, "数据选择指令需要配置effectType")
  assert(index, "数据选择指令需要正确的index")
  phaseContext:SetCurResultIndexByType(effectType, index)
  phaseContext:SetCurDamageResultStageIndex(self._stageIndex)
  local routineCmpt = casterEntity:SkillRoutine():GetResultContainer()
  if not routineCmpt then
    return
  end
  local resultArray = routineCmpt:GetEffectResultsAsArray(resultEffectType, self._stageIndex)
  if not resultArray then
    phaseContext:SetCurResultIndexByType(effectType, -1)
    self:_LogWarning("No result found in SkillRoutineComponent: ", effectType, "=>", resultEffectType)
    return
  end
  local selectedResult = resultArray[index]
  if not selectedResult then
    phaseContext:SetCurResultIndexByType(effectType, -1)
    self:_LogWarning("No result at index: ", index, " for effectType: ", effectType)
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local targetEntity, targetID = self:_GetTargetEntityFromResult(selectedResult, world)
  if not targetEntity then
    phaseContext:SetCurTargetEntityID(-1)
    self:_LogWarning("Invalid target entity id at index: ", index, " for effectType: ", effectType)
    return
  end
  phaseContext:SetCurTargetEntityID(targetID)
end

function DataSelectResultInstruction:_GetTargetEntityFromResult(result, world)
  local entityID = result:GetTargetID()
  if result:GetEffectType() == SkillEffectType.SummonTrap then
    local trapResult = result
    local utilSvc = world:GetService("UtilData")
    local trapID = trapResult:GetTrapID()
    local array = utilSvc:GetTrapsAtPos(trapResult:GetPos())
    for _, eTrap in ipairs(array) do
      local cTrapID = eTrap:TrapID()
      if cTrapID and cTrapID:GetTrapID() == trapID then
        entityID = eTrap:GetID()
        break
      end
    end
  elseif result:GetEffectType() == SkillEffectType.SummonEverything then
    local summonType = result:GetSummonType()
    if summonType == SkillEffectEnum_SummonType.Monster then
      local monsterData = result:GetMonsterData()
      local eid = monsterData.m_entityWorkID
      if world:GetEntityByID(eid) then
        entityID = eid
      end
    end
  elseif result:GetEffectType() == SkillEffectType.AddBuff then
    local buffResult = result
    entityID = buffResult:GetEntityID()
  elseif result:GetEffectType() == SkillEffectType.TransferTarget then
    local buffResult = result
    entityID = buffResult:GetTargetEntityID()
  elseif result:GetEffectType() == SkillEffectType.DestroyTrap then
    local skillResult = result
    entityID = skillResult:GetEntityID()
  end
  return world:GetEntityByID(entityID), entityID
end
