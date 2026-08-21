require("scope_base")
_class("SkillScopeCalculator_SquareRingExtendByGridType", SkillScopeCalculator_Base)
SkillScopeCalculator_SquareRingExtendByGridType = SkillScopeCalculator_SquareRingExtendByGridType

function SkillScopeCalculator_SquareRingExtendByGridType:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local extendType = scopeParam[1]
  local gridType = scopeParam[2]
  local _scopeType = scopeParam[3]
  local _scope_param = {}
  if table.count(scopeParam) >= 4 then
    _scope_param = table.sub(scopeParam, 4, #scopeParam)
  end
  if extendType == 4 then
    self.offSet = Offset4
  elseif extendType == 8 then
    self.offSet = Offset8
  end
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local _result = calc:ComputeScopeRange(_scopeType, _scope_param, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local attackRange = _result:GetAttackRange()
  for i, pos in ipairs(_result:GetAttackRange()) do
    self:ExtendByGridType(pos, gridType, attackRange)
  end
  local result = SkillScopeResult:New(SkillScopeType.SquareRingExtendByGridType, casterPos, attackRange, attackRange)
  return result
end

function SkillScopeCalculator_SquareRingExtendByGridType:ExtendByGridType(beginPos, gridType, range)
  local world = self._gridFilter._world
  local boardSvc = world:GetService("BoardLogic")
  for i, v in ipairs(self.offSet) do
    local newPos = Vector2(beginPos.x + v[1], beginPos.y + v[2])
    local newPosGridType = boardSvc:GetPieceType(newPos)
    if CanMatchPieceType(newPosGridType, gridType) and not table.Vector2Include(range, newPos) then
      table.insert(range, newPos)
      self:ExtendByGridType(newPos, gridType, range)
    end
  end
end
