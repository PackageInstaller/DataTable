_class("SkillPhaseContext", Object)
SkillPhaseContext = SkillPhaseContext

function SkillPhaseContext:Constructor(world, casterEntity)
  self._world = world
  self._casterEntity = casterEntity
  self._curDamageResultIndex = 1
  self._curDamageResultStageIndex = 1
  self._curBuffResultIndex = 1
  self._curDamageInfoIndex = 1
  self._curDamageIndex = 1
  self._curSummonInEverythingIndex = 1
  self._curTargetEntityID = nil
  self._waitTaskList = {}
  self._curGridPos = nil
  self._scopeGridList = nil
  self._scopeGridRange = nil
  self._maxRangeCount = nil
  self._curScopeGridRangeIndex = -1
  self._eHUDTargets = {}
  self._curEffectResultMap = {}
  self._curSummonOnFixPosIndex = 1
end

function SkillPhaseContext:SetCurDamageResultIndex(damageIndex)
  self._curDamageResultIndex = damageIndex
end

function SkillPhaseContext:GetCurDamageResultIndex()
  return self._curDamageResultIndex
end

function SkillPhaseContext:SetCurDamageResultStageIndex(damageStageIndex)
  self._curDamageResultStageIndex = damageStageIndex
end

function SkillPhaseContext:GetCurDamageResultStageIndex()
  return self._curDamageResultStageIndex
end

function SkillPhaseContext:SetCurBuffResultIndex(buffIndex)
  self._curBuffResultIndex = buffIndex
end

function SkillPhaseContext:GetCurBuffResultIndex()
  return self._curBuffResultIndex
end

function SkillPhaseContext:SetCurDamageInfoIndex(damageInfoIndex)
  self._curDamageInfoIndex = damageInfoIndex
end

function SkillPhaseContext:GetCurDamageInfoIndex()
  return self._curDamageInfoIndex
end

function SkillPhaseContext:SetCurSummonInEverythingIndex(index)
  self._curSummonInEverythingIndex = index
end

function SkillPhaseContext:GetCurSummonInEverythingIndex()
  return self._curSummonInEverythingIndex
end

function SkillPhaseContext:SetCurSummonOnFixPosIndex(index)
  self._curSummonOnFixPosIndex = index
end

function SkillPhaseContext:GetCurSummonOnFixPosIndex()
  return self._curSummonOnFixPosIndex
end

function SkillPhaseContext:GetCurTargetEntityID()
  return self._curTargetEntityID
end

function SkillPhaseContext:SetCurTargetEntityID(targetID)
  self._curTargetEntityID = targetID
end

function SkillPhaseContext:AddPhaseTask(taskID)
  self._waitTaskList[#self._waitTaskList + 1] = taskID
end

function SkillPhaseContext:GetPhaseTaskList()
  return self._waitTaskList
end

function SkillPhaseContext:GetCurGridPos()
  return self._curGridPos
end

function SkillPhaseContext:SetCurGridPos(gridPos)
  self._curGridPos = gridPos
end

function SkillPhaseContext:SetScopeGridList(gridPosArr)
  self._scopeGridList = gridPosArr
end

function SkillPhaseContext:SetScopeGridRange(gridRange, maxRangeCount)
  self._scopeGridRange = gridRange
  self._maxRangeCount = maxRangeCount
end

function SkillPhaseContext:GetScopeGridRange()
  return self._scopeGridRange
end

function SkillPhaseContext:GetMaxRangeCount()
  return self._maxRangeCount
end

function SkillPhaseContext:SetCurScopeGridRangeIndex(index)
  self._curScopeGridRangeIndex = index
end

function SkillPhaseContext:GetCurScopeGridRangeIndex()
  return self._curScopeGridRangeIndex
end

function SkillPhaseContext:GetHUDTargets()
  return self._eHUDTargets
end

function SkillPhaseContext:SetHUDTargets(huds)
  self._eHUDTargets = huds
end

function SkillPhaseContext:SetCurResultIndexByType(effectType, index)
  self._curEffectResultMap[effectType] = index
end

function SkillPhaseContext:GetCurResultIndexByType(effectType)
  return self._curEffectResultMap[effectType] or -1
end

function SkillPhaseContext:SetSpecialScopeResultList(specialScopeResultList)
  self._specialScopeResultList = specialScopeResultList
end

function SkillPhaseContext:GetSpecialScopeResultList()
  return self._specialScopeResultList
end

function SkillPhaseContext:SetCurDamageIndex(damageIndex)
  self._curDamageIndex = damageIndex
end

function SkillPhaseContext:GetCurDamageIndex()
  return self._curDamageIndex
end
