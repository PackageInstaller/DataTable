require("scope_base")
_class("SkillScopeCalculator_RectExceptFixPosAndTrap", SkillScopeCalculator_Base)
SkillScopeCalculator_RectExceptFixPosAndTrap = SkillScopeCalculator_RectExceptFixPosAndTrap

function SkillScopeCalculator_RectExceptFixPosAndTrap:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  self._rowCount = scopeParam.rowCount
  self._columnCount = scopeParam.columnCount
  self._basePos = Vector2(scopeParam.basePos[1], scopeParam.basePos[2])
  self._fixPosList = {}
  for i, v in ipairs(scopeParam.fixPosList) do
    table.insert(self._fixPosList, Vector2(v[1], v[2]))
  end
  self._trapType = scopeParam.trapType
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local attackRange = {}
  local basePosList = {}
  local yMoveCount = self._rowCount - 1
  local xMoveCount = self._columnCount - 1
  for xMoveIndex = 0, xMoveCount do
    local curX = self._basePos.x + xMoveIndex
    for yMoveIndex = 0, yMoveCount do
      local curY = self._basePos.y + yMoveIndex
      local curPos = Vector2(curX, curY)
      if self._gridFilter:IsValidPiecePos(curPos) and not table.intable(self._fixPosList, curPos) then
        table.insert(basePosList, curPos)
      end
    end
  end
  local trapList = {}
  for _, pos in ipairs(basePosList) do
    local array = utilSvc:GetTrapsAtPos(pos)
    for _, eTrap in ipairs(array) do
      local cTrap = eTrap:Trap()
      if cTrap and not eTrap:HasDeadMark() and cTrap:GetTrapType() == self._trapType then
        table.insert(trapList, eTrap)
      end
    end
  end
  local needDelPosList = {}
  for _, eTrap in ipairs(trapList) do
    local curPos = eTrap:GetGridPosition()
    local bodyAreaCmpt = eTrap:BodyArea()
    local trapBodyArea = bodyAreaCmpt:GetArea()
    local scopeType = SkillScopeType.DoubleCross
    local scopeParam = 10
    local curDoubleCrossList = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, curPos, trapBodyArea)
    local curAttackRange = curDoubleCrossList:GetAttackRange()
    for _, pos in ipairs(curAttackRange) do
      if not table.intable(needDelPosList, pos) then
        table.insert(needDelPosList, pos)
      end
    end
  end
  for _, pos in ipairs(basePosList) do
    if not table.intable(needDelPosList, pos) and not self._gridFilter:IsPosHaveMonsterOrPet(pos) and not self._gridFilter:IsPosBlock(pos, BlockFlag.SummonTrap) then
      table.insert(attackRange, pos)
    end
  end
  if #attackRange == 0 then
    attackRange = basePosList
  end
  return SkillScopeResult:New(SkillScopeType.RectExceptFixPosAndTrap, centerPos, attackRange, attackRange)
end
