require("scope_base")
_class("SkillScopeCalculator_TrainConvert", SkillScopeCalculator_Base)
SkillScopeCalculator_TrainConvert = SkillScopeCalculator_TrainConvert

function SkillScopeCalculator_TrainConvert:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  local boardServiceLogic = world:GetService("BoardLogic")
  local maxX = boardServiceLogic:GetCurBoardMaxX()
  local maxY = boardServiceLogic:GetCurBoardMaxY()
  local type = self:GetDirection(centerPos, casterPos)
  local attackGridPosList = {}
  local tmpGridPosList = {}
  local convertGridList = {}
  local attackGridScopeParam, tmpGridScopeParam
  if type == HitBackDirectionType.Down or type == HitBackDirectionType.Up then
    attackGridScopeParam = SkillNRowsMColumnsScopeParam:New(maxY * 2 + 1, 3)
    tmpGridScopeParam = SkillNRowsMColumnsScopeParam:New(maxY * 2 + 1, 1)
  else
    attackGridScopeParam = SkillNRowsMColumnsScopeParam:New(3, maxX * 2 + 1)
    tmpGridScopeParam = SkillNRowsMColumnsScopeParam:New(1, maxX * 2 + 1)
  end
  attackGridPosList = self._hub:ComputeScopeRange(SkillScopeType.NRowsMColumns, attackGridScopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos):GetAttackRange()
  tmpGridPosList = self._hub:ComputeScopeRange(SkillScopeType.NRowsMColumns, tmpGridScopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos):GetAttackRange()
  for _, pos in pairs(attackGridPosList) do
    if not table.icontains(tmpGridPosList, pos) then
      table.insert(convertGridList, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TrainConvertScope, centerPos, convertGridList, convertGridList)
  return result
end
