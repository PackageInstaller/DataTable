require("scope_base")
_class("SkillScopeCalculator_NightKing_Skill1B", SkillScopeCalculator_Base)
SkillScopeCalculator_NightKing_Skill1B = SkillScopeCalculator_NightKing_Skill1B

function SkillScopeCalculator_NightKing_Skill1B:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilScopeCalcSvc = world:GetService("UtilScopeCalc")
  local utilDataCalcSvc = world:GetService("UtilData")
  local dirType = utilScopeCalcSvc:GetEntityDirType(casterEntity)
  local rangList = {}
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    local beginY, endY, step
    if dirType == DirectionType.Up then
      beginY = 2
      endY = BattleConst.BoardMaxLen
      step = 1
    else
      beginY = -2
      endY = BattleConst.BoardMaxLen * -1
      step = -1
    end
    for y = beginY, endY, step do
      for x = 1, BattleConst.BoardMaxLen do
        local newPos = Vector2(x, y + casterPos.y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(rangList, newPos)
        end
      end
    end
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    local beginX, endX, step
    if dirType == DirectionType.Left then
      beginX = -2
      endX = BattleConst.BoardMaxLen * -1
      step = -1
    else
      beginX = 2
      endX = BattleConst.BoardMaxLen
      step = 1
    end
    for x = beginX, endX, step do
      for y = 1, BattleConst.BoardMaxLen do
        local newPos = Vector2(casterPos.x + x, y)
        if utilDataCalcSvc:IsValidPiecePos(newPos) then
          table.insert(rangList, newPos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.N16NightKingSkill1B, casterPos, rangList, rangList, nil)
  return result
end
