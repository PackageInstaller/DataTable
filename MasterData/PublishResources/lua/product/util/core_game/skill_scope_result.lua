_class("SkillScopeResult", Object)
SkillScopeResult = SkillScopeResult

function SkillScopeResult:Constructor(type, centerPos, attackRange, wholeRange, targetIds)
  self._scopeType = type
  self._attackGridRange = attackRange
  self._wholeGridRange = wholeRange
  self._targertIDs = targetIds
  self._centerPos = centerPos
  self._gridPosTargetIdDic = SortedDictionary:New(Algorithm.COMPARE_CUSTOM, Algorithm.LessVectorXYComparer)
  if self._targertIDs == nil then
    self._targertIDs = {}
  end
  self._effectTargetIdArray = nil
  self._specialScopeResult = nil
end

function SkillScopeResult:SetEffectTargetIdArray(targetIdArray)
  self._effectTargetIdArray = targetIdArray
end

function SkillScopeResult:GetEffectTargetIdArray()
  return self._effectTargetIdArray or {}
end

function SkillScopeResult:GetScopeType()
  return self._scopeType
end

function SkillScopeResult:GetCenterPos()
  return self._centerPos
end

function SkillScopeResult:GetAttackRange()
  return self._attackGridRange
end

function SkillScopeResult:GetWholeGridRange()
  return self._wholeGridRange
end

function SkillScopeResult:GetTargetIDs()
  if self._targertIDs and #self._targertIDs > 0 then
    local tmp = {}
    for i = 1, #self._targertIDs do
      tmp[i] = self._targertIDs[i]
    end
    return tmp
  else
    return {}
  end
end

function SkillScopeResult:AddTargetID(id)
  if self._targertIDs == nil then
    self._targertIDs = {}
  end
  if not table.icontains(self._targertIDs, id) then
    table.insert(self._targertIDs, id)
  end
end

function SkillScopeResult:AddTargetIDAndPos(id, pos)
  self:AddTargetID(id)
  if self._targetPosID == nil then
    self._targetPosID = {}
  end
  self._targetPosID[Vector2.Pos2Index(pos)] = id
  if self._gridPosTargetIdDic == nil then
    self._gridPosTargetIdDic = SortedDictionary:New(Algorithm.COMPARE_CUSTOM, Algorithm.LessVectorXYComparer)
  end
  self._gridPosTargetIdDic:Insert(pos, id)
end

_class("GridPosTargetIdRecordData", Object)
GridPosTargetIdRecordData = GridPosTargetIdRecordData

function GridPosTargetIdRecordData:Constructor(pos, ids)
  self.recordPos = pos
  self.idList = ids
end

function SkillScopeResult:AddTargetIDAndPosAllowDuplicate(id, pos)
  if not self._gridPosTargetIdRecordList then
    self._gridPosTargetIdRecordList = {}
  end
  local hasPos = false
  for index, record in ipairs(self._gridPosTargetIdRecordList) do
    if record.recordPos == pos then
      if not table.icontains(record.idList, id) then
        table.insert(record.idList, id)
      end
      hasPos = true
      break
    end
  end
  if not hasPos then
    local record = GridPosTargetIdRecordData:New(pos, {id})
    table.insert(self._gridPosTargetIdRecordList, record)
  end
end

function SkillScopeResult:GetGridPosTargetIDRecordList()
  return self._gridPosTargetIdRecordList
end

function SkillScopeResult:GetTargetIDByPos(pos)
  if self._targetPosID then
    return self._targetPosID[Vector2.Pos2Index(pos)]
  end
end

function SkillScopeResult:GetGridPosTargetIDDic()
  return self._gridPosTargetIdDic
end

function SkillScopeResult:ClearTargetIDs()
  self._targertIDs = {}
  self._gridPosTargetIdDic:Clear()
  self._gridPosTargetIdRecordList = {}
end

function SkillScopeResult:SetAttackRange(attackRange)
  self._attackGridRange = attackRange
end

function SkillScopeResult:SetWholeAttackRange(Range)
  self._wholeGridRange = Range
end

function SkillScopeResult:RemoveTargetIDByPos(pos)
  local targetID = self._gridPosTargetIdDic:Find(pos)
  table.removev(self._targertIDs, targetID)
  self._gridPosTargetIdDic:Remove(pos)
end

function Algorithm.LessVectorXYComparer(leftVec2, rightVec2)
  if leftVec2.x < rightVec2.x then
    return 1
  elseif leftVec2.x > rightVec2.x then
    return -1
  elseif leftVec2.y < rightVec2.y then
    return 1
  elseif leftVec2.y > rightVec2.y then
    return -1
  else
    return 0
  end
end

function SkillScopeResult:SetSpecialScopeResult(specialScopeResult)
  self._specialScopeResult = specialScopeResult
end

function SkillScopeResult:GetSpecialScopeResult()
  return self._specialScopeResult
end
