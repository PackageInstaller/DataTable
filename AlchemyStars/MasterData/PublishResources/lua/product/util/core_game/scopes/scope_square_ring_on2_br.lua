require("scope_base")
_class("SkillScopeCalculatorSquareRingOn2BodyArea", SkillScopeCalculator_Base)
SkillScopeCalculatorSquareRingOn2BodyArea = SkillScopeCalculatorSquareRingOn2BodyArea

function SkillScopeCalculatorSquareRingOn2BodyArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilDataCalcSvc = world:GetService("UtilData")
  local rangeList = {}
  for i, body in ipairs(bodyArea) do
    for x = -1, 1 do
      for y = -1, 1 do
        local newPos = Vector2(casterPos.x + x + body.x, casterPos.y + y + body.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) and not table.Vector2Include(rangeList, newPos) then
          table.insert(rangeList, newPos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SquareRingOn2BodyArea, casterPos, rangeList, rangeList, nil)
  return result
end
