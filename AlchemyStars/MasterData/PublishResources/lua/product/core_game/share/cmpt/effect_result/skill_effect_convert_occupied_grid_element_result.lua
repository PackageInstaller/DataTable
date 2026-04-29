require("skill_convert_element_effect_result")
_class("SkillEffectConvertOccupiedGridElementResult", SkillConvertGridElementEffectResult)

function SkillEffectConvertOccupiedGridElementResult:Constructor(convertPosList, targetElementType, summonTrapResults)
  self._convertPosList = convertPosList
  self._targetElementType = targetElementType
  self._trapResults = summonTrapResults or {}
end

function SkillEffectConvertOccupiedGridElementResult:GetConvertPos()
  return self._convertPosList
end

function SkillEffectConvertOccupiedGridElementResult:GetNewGridPieceType(pos)
  for _, data in ipairs(self._convertPosList) do
    if data.x == pos.x and data.y == pos.y then
      return self._targetElementType
    end
  end
  return nil
end

function SkillEffectConvertOccupiedGridElementResult:GetTargetElementType()
  return self._targetElementType
end

function SkillEffectConvertOccupiedGridElementResult:GetEffectType()
  return SkillEffectType.ConvertOccupiedGridElement
end

function SkillEffectConvertOccupiedGridElementResult:GetTrapResults()
  return self._trapResults
end
