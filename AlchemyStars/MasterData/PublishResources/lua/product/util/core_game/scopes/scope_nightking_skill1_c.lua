require("scope_base")
_class("SkillScopeCalculator_NightKing_Skill1C", SkillScopeCalculator_Base)
SkillScopeCalculator_NightKing_Skill1C = SkillScopeCalculator_NightKing_Skill1C

function SkillScopeCalculator_NightKing_Skill1C:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilScopeCalcSvc = world:GetService("UtilScopeCalc")
  local dirType = utilScopeCalcSvc:GetEntityDirType(casterEntity)
  local utilDataCalcSvc = world:GetService("UtilData")
  local rangList = {}
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    for y = -1, 1 do
      for x = -2, BattleConst.BoardMaxLen * -1, -1 do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(rangList, newPos)
        end
      end
    end
    for y = -1, 1 do
      for x = 2, BattleConst.BoardMaxLen do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(rangList, newPos)
        end
      end
    end
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    for x = -1, 1 do
      for y = -2, BattleConst.BoardMaxLen * -1, -1 do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(rangList, newPos)
        end
      end
    end
    for x = -1, 1 do
      for y = 2, BattleConst.BoardMaxLen do
        local newPos = Vector2(x + casterPos.x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(rangList, newPos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.N16NightKingSkill1C, casterPos, rangList, rangList, nil)
  return result
end
