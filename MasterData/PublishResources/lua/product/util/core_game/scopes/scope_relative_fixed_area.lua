require("scope_base")
_class("SkillScopeCalculator_RelativeFixedPos", SkillScopeCalculator_Base)
SkillScopeCalculator_RelativeFixedPos = SkillScopeCalculator_RelativeFixedPos

function SkillScopeCalculator_RelativeFixedPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local centerX = centerPos.x
  local centerY = centerPos.y
  local attackRange = {}
  local wholeRange = {}
  for index, kvp in ipairs(scopeParam.pos) do
    if #kvp ~= 2 then
      Log.Exception("范围类型[112]RelativeFixedPos: pos中第", index, "个数据不全")
    else
      local v2 = Vector2.New(centerX + kvp[1], centerY + kvp[2])
      table.insert(wholeRange, v2)
      if self._gridFilter:IsValidPiecePos(v2) then
        table.insert(attackRange, v2)
      end
    end
  end
  return SkillScopeResult:New(SkillScopeType.RelativeFixedPos, centerPos, attackRange, wholeRange)
end
