require("scope_base")
_class("SkillScopeCalculator_NightKing_ForwardSkill", SkillScopeCalculator_Base)
SkillScopeCalculator_NightKing_ForwardSkill = SkillScopeCalculator_NightKing_ForwardSkill

function SkillScopeCalculator_NightKing_ForwardSkill:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilScopeCalcSvc = world:GetService("UtilScopeCalc")
  local leftPos, rightPos = utilScopeCalcSvc:GetNightKingForwardSkillPos(casterEntity, casterPos)
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local dirType = utilScopeCalcSvc:GetEntityDirType(casterEntity)
  local jumpDirType
  if dirType == DirectionType.Left then
    if playerPos.y > casterPos.y then
      jumpDirType = DirectionType.Right
    else
      jumpDirType = DirectionType.Left
    end
  elseif dirType == DirectionType.Right then
    if playerPos.y < casterPos.y then
      jumpDirType = DirectionType.Right
    else
      jumpDirType = DirectionType.Left
    end
  elseif dirType == DirectionType.Up then
    if playerPos.x > casterPos.x then
      jumpDirType = DirectionType.Right
    else
      jumpDirType = DirectionType.Left
    end
  elseif dirType == DirectionType.Down then
    if playerPos.x < casterPos.x then
      jumpDirType = DirectionType.Right
    else
      jumpDirType = DirectionType.Left
    end
  end
  local rangList = self:GetPos(jumpDirType, leftPos, rightPos)
  local result = SkillScopeResult:New(SkillScopeType.N16NightKingForwardSkill, casterPos, rangList, rangList, nil)
  return result
end

function SkillScopeCalculator_NightKing_ForwardSkill:GetPos(dirType, leftPos, rightPos)
  if dirType == DirectionType.Left and self._gridFilter:IsValidPiecePos(leftPos) then
    return {leftPos}
  end
  if dirType == DirectionType.Left and not self._gridFilter:IsValidPiecePos(leftPos) then
    return {rightPos}
  end
  if dirType == DirectionType.Right and self._gridFilter:IsValidPiecePos(rightPos) then
    return {rightPos}
  end
  if dirType == DirectionType.Right and not self._gridFilter:IsValidPiecePos(rightPos) then
    return {leftPos}
  end
end
