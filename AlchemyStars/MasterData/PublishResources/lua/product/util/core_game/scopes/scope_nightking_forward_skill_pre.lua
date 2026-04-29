require("scope_base")
_class("SkillScopeCalculator_NightKing_ForwardSkillPre", SkillScopeCalculator_Base)
SkillScopeCalculator_NightKing_ForwardSkillPre = SkillScopeCalculator_NightKing_ForwardSkillPre

function SkillScopeCalculator_NightKing_ForwardSkillPre:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._gridFilter._world
  local utilScopeCalcSvc = world:GetService("UtilScopeCalc")
  local pos1, pos2 = utilScopeCalcSvc:GetNightKingForwardSkillPos(casterEntity, casterPos)
  local rangList = {}
  if self._gridFilter:IsValidPiecePos(pos1) then
    table.insert(rangList, pos1)
  end
  if self._gridFilter:IsValidPiecePos(pos2) then
    table.insert(rangList, pos2)
  end
  local result = SkillScopeResult:New(SkillScopeType.N16NightKingForwardSkillPre, casterPos, rangList, rangList, nil)
  return result
end
