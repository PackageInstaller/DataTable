require("skill_effect_result_base")
_class("SkillEffectResult_ResetGridData", Object)
SkillEffectResult_ResetGridData = SkillEffectResult_ResetGridData

function SkillEffectResult_ResetGridData:Constructor(nX, nY, nNewElementType)
  self.m_nX = nX
  self.m_nY = nY
  self.m_nNewElementType = nNewElementType
end

_class("SkillEffectResult_ResetGridElement", SkillEffectResultBase)
SkillEffectResult_ResetGridElement = SkillEffectResult_ResetGridElement

function SkillEffectResult_ResetGridElement:Constructor(gridArray, flushTraps, gridArrayNew)
  self.m_vecResetGridData = gridArray
  self._flushTraps = flushTraps
  self._summonTrapList = nil
  self._summonTrapEntityIDList = nil
  self.m_vecResetGridDataNew = gridArrayNew
end

function SkillEffectResult_ResetGridElement:AddSummonTrapData(pos, trapId)
  if self._summonTrapList == nil then
    self._summonTrapList = {}
  end
  self._summonTrapList[pos] = trapId
end

function SkillEffectResult_ResetGridElement:GetSummonTrapList()
  return self._summonTrapList
end

function SkillEffectResult_ResetGridElement:AddSummonTrapEntityID(pos, entityID)
  if self._summonTrapEntityIDList == nil then
    self._summonTrapEntityIDList = {}
  end
  self._summonTrapEntityIDList[pos] = entityID
end

function SkillEffectResult_ResetGridElement:GetSummontTrapEntityID(pos)
  if not self._summonTrapEntityIDList then
    return nil
  end
  for p, id in pairs(self._summonTrapEntityIDList) do
    if p == pos then
      return id
    end
  end
  return nil
end

function SkillEffectResult_ResetGridElement:GetEffectType()
  return SkillEffectType.ResetGridElement
end

function SkillEffectResult_ResetGridElement:GetArrayCount()
  return table.count(self.m_vecResetGridData)
end

function SkillEffectResult_ResetGridElement:GetResetGridData()
  return self.m_vecResetGridData
end

function SkillEffectResult_ResetGridElement:GetAllFlushTraps()
  return self._flushTraps
end

function SkillEffectResult_ResetGridElement:FindGridData(gridPos)
  for nIndex, gridData in ipairs(self.m_vecResetGridData) do
    if gridData.m_nX == gridPos.x and gridData.m_nY == gridPos.y then
      return gridData.m_nNewElementType
    end
  end
  return nil
end

function SkillEffectResult_ResetGridElement:FindGridDataNew(gridPos)
  if self.m_vecResetGridDataNew[gridPos.x] then
    return self.m_vecResetGridDataNew[gridPos.x][gridPos.y]
  end
  return nil
end

function SkillEffectResult_ResetGridElement:GetFlushTrapsAt(gridPos)
  local traps = {}
  for _, trap in ipairs(self._flushTraps) do
    local pos = trap:GetGridPosition()
    if pos and pos.x == gridPos.x and pos.y == gridPos.y then
      traps[#traps + 1] = trap
    end
  end
  return traps
end

function SkillEffectResult_ResetGridElement:GetNewGridNumByType(pieceType)
  local retNum = 0
  for i = 1, #self.m_vecResetGridData do
    if self.m_vecResetGridData[i].m_nNewElementType == pieceType then
      retNum = retNum + 1
    end
  end
  return retNum
end
