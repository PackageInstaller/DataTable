require("scope_base")
_class("SkillScopeCalculator_FakeBodyArea", SkillScopeCalculator_Base)
SkillScopeCalculator_FakeBodyArea = SkillScopeCalculator_FakeBodyArea

function SkillScopeCalculator_FakeBodyArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local centerX = centerPos.x
  local centerY = centerPos.y
  local attackRange = {}
  local wholeRange = {}
  local fakeBodyArea = {}
  for index, kvp in ipairs(scopeParam.pos) do
    if #kvp ~= 2 then
      Log.Exception("范围类型[165]FakeBodyArea: pos中第", index, "个数据不全")
    else
      local v2 = Vector2.New(kvp[1], kvp[2])
      table.insert(fakeBodyArea, v2)
    end
  end
  local followRotate = scopeParam.followRotate
  if followRotate then
    fakeBodyArea = self:_RotateFakeBodyArea(fakeBodyArea, casterDir)
  end
  for index, offPos in ipairs(fakeBodyArea) do
    local workPos = centerPos + offPos
    if self._gridFilter:IsValidPiecePos(workPos) then
      table.insert(attackRange, workPos)
      table.insert(wholeRange, workPos)
    end
  end
  return SkillScopeResult:New(SkillScopeType.FakeBodyArea, centerPos, attackRange, wholeRange)
end

function SkillScopeCalculator_FakeBodyArea:_RotateFakeBodyArea(fakeBodyArea, toDir)
  local rotatedFakeBodyArea = {}
  if toDir == Vector2.up then
    for index, pos in ipairs(fakeBodyArea) do
      local newPos = Vector2(-pos.x, -pos.y)
      table.insert(rotatedFakeBodyArea, newPos)
    end
  elseif toDir == Vector2.right then
    for index, pos in ipairs(fakeBodyArea) do
      local newPos = Vector2(-pos.y, pos.x)
      table.insert(rotatedFakeBodyArea, newPos)
    end
  elseif toDir == Vector2.left then
    for index, pos in ipairs(fakeBodyArea) do
      local newPos = Vector2(pos.y, -pos.x)
      table.insert(rotatedFakeBodyArea, newPos)
    end
  elseif toDir == Vector2.down then
    rotatedFakeBodyArea = fakeBodyArea
  end
  return rotatedFakeBodyArea
end
