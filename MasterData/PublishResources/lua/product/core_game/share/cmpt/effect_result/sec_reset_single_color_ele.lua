require("skill_effect_result_base")
_class("SkillEffectResultResetSingleColorGridElement", SkillEffectResultBase)
SkillEffectResultResetSingleColorGridElement = SkillEffectResultResetSingleColorGridElement

function SkillEffectResultResetSingleColorGridElement:Constructor(newGridDataList, trapIDList)
  self._newGridDataList = newGridDataList
  self._flushTrapIDList = trapIDList
end

function SkillEffectResultResetSingleColorGridElement:GetEffectType()
  return SkillEffectType.ResetSingleColorGridElement
end

function SkillEffectResultResetSingleColorGridElement:GetNewGridDataList()
  return self._newGridDataList
end

function SkillEffectResultResetSingleColorGridElement:GetFlushTrapList()
  return self._flushTrapIDList
end

function SkillEffectResultResetSingleColorGridElement:GetNewGridPieceType(pos)
  for _, data in ipairs(self._newGridDataList) do
    if data.m_nX == pos.x and data.m_nY == pos.y then
      return data.m_nNewElementType
    end
  end
end

function SkillEffectResultResetSingleColorGridElement:GetNewGridNumByType(pieceType)
  local count = 0
  for _, data in ipairs(self._newGridDataList) do
    if data.m_nNewElementType == pieceType then
      count = count + 1
    end
  end
  return count
end
