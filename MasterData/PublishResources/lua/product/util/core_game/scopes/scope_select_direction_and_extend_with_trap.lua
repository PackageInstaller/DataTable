require("scope_base")
_class("SkillScopeCalculator_SelectDirectionAndExtendWithTrap", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectDirectionAndExtendWithTrap = SkillScopeCalculator_SelectDirectionAndExtendWithTrap

function SkillScopeCalculator_SelectDirectionAndExtendWithTrap:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  self._dirX = scopeParam[1]
  self._dirY = scopeParam[2]
  self._length = scopeParam[3] or 1
  self._limitExtendCount = scopeParam[4] or 1
  local hadExtendCount = 0
  local world = self._gridFilter._world
  local utilSvc = world:GetService("UtilData")
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local attackRange = {}
  local wholeRange = {}
  for i = 1, self._length do
    local nextPos = Vector2(centerPos.x + i * self._dirX, centerPos.y + i * self._dirY)
    if self._gridFilter:IsValidPiecePos(nextPos) then
      table.insert(attackRange, nextPos)
      table.insert(wholeRange, nextPos)
    end
  end
  local trapExtend = {}
  for _, pos in ipairs(attackRange) do
    local array = utilSvc:GetTrapsAtPos(pos)
    for _, eTrap in ipairs(array) do
      local cTrap = eTrap:Trap()
      if cTrap and not eTrap:HasDeadMark() and eTrap:HasTrapExtendSkillScope() then
        local entityID = eTrap:GetID()
        table.insert(trapExtend, eTrap)
        hadExtendCount = hadExtendCount + 1
      end
    end
    if hadExtendCount >= self._limitExtendCount then
      break
    end
  end
  for _, eTrap in ipairs(trapExtend) do
    local trapExtendSkillScope = eTrap:TrapExtendSkillScope()
    local trapExtendScopeType = trapExtendSkillScope:GetScopeType()
    local trapExtendScopeParam = trapExtendSkillScope:GetScopeParam()
    local curPos = eTrap:GetGridPosition()
    local curBodyArea = casterEntity:BodyArea():GetArea()
    local curExtendAScopeResult = scopeCalculator:ComputeScopeRange(trapExtendScopeType, trapExtendScopeParam, curPos, curBodyArea)
    local curExtendAttackRange = curExtendAScopeResult:GetAttackRange()
    local curExtendWholeGridRange = curExtendAScopeResult:GetWholeGridRange()
    for _, pos in ipairs(curExtendAttackRange) do
      if not table.intable(attackRange, pos) then
        table.insert(attackRange, pos)
      end
    end
    for _, pos in ipairs(curExtendWholeGridRange) do
      if not table.intable(wholeRange, pos) then
        table.insert(wholeRange, pos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SelectDirectionAndExtendWithTrap, centerPos, attackRange, wholeRange)
  result:SetSpecialScopeResult(trapExtend)
  return result
end
