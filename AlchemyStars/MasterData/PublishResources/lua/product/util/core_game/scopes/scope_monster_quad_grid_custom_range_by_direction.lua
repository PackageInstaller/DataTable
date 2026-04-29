require("scope_base")
_class("SkillScopeCalculator_MonsterQuadGridCustomRangeByDirection", SkillScopeCalculator_Base)
SkillScopeCalculator_MonsterQuadGridCustomRangeByDirection = SkillScopeCalculator_MonsterQuadGridCustomRangeByDirection

function SkillScopeCalculator_MonsterQuadGridCustomRangeByDirection:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local v2GridDir = self:GetGridDirection(casterDir)
  local v2AnchorBodyPos = Vector2.zero
  if v2GridDir == Vector2.down then
    v2AnchorBodyPos = Vector2.zero
  elseif v2GridDir == Vector2.left then
    v2AnchorBodyPos = Vector2.New(0, 1)
  elseif v2GridDir == Vector2.up then
    v2AnchorBodyPos = Vector2.New(1, 1)
  else
    v2AnchorBodyPos = Vector2.New(1, 0)
  end
  if not table.Vector2Include(bodyArea, v2AnchorBodyPos) then
    return SkillScopeResult:New(SkillScopeType.MonsterQuadGridCustomRangeByDirection, centerPos, {}, {})
  end
  local v2Anchor = centerPos + v2AnchorBodyPos
  local attackRange = {}
  local wholeArea = {}
  local n = scopeParam[1]
  local m = scopeParam[2]
  local d = scopeParam[3] or 0
  if v2GridDir == Vector2.down then
    for i = 0, math.abs(n) - 1 do
      local x = i
      if 0 < n then
        x = -x
      end
      x = x - d
      for y = 1, m do
        local v2 = Vector2.New(v2Anchor.x + x, v2Anchor.y - y)
        self:_InsertTargetGrid(attackRange, v2, wholeArea)
      end
    end
  elseif v2GridDir == Vector2.left then
    for x = 1, m do
      for i = 0, math.abs(n) - 1 do
        local y = i
        if n < 0 then
          y = -y
        end
        y = y + d
        local v2 = Vector2.New(v2Anchor.x - x, v2Anchor.y + y)
        self:_InsertTargetGrid(attackRange, v2, wholeArea)
      end
    end
  elseif v2GridDir == Vector2.up then
    for i = 0, math.abs(n) - 1 do
      local x = i
      if n < 0 then
        x = -x
      end
      x = x + d
      for y = 1, m do
        local v2 = Vector2.New(v2Anchor.x + x, v2Anchor.y + y)
        self:_InsertTargetGrid(attackRange, v2, wholeArea)
      end
    end
  else
    for x = 1, m do
      for i = 0, math.abs(n) - 1 do
        local y = i
        if 0 < n then
          y = -y
        end
        y = y - d
        local v2 = Vector2.New(v2Anchor.x + x, v2Anchor.y + y)
        self:_InsertTargetGrid(attackRange, v2, wholeArea)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.MonsterQuadGridCustomRangeByDirection, centerPos, attackRange, wholeArea)
  return result
end

function SkillScopeCalculator_MonsterQuadGridCustomRangeByDirection:GetGridDirection(v2)
  local v = Vector2.New(v2.x, v2.y)
  if v.x > 1 then
    v.x = 1
  elseif v.x < -1 then
    v.x = -1
  end
  if v.y > 1 then
    v.y = 1
  elseif v.y < -1 then
    v.y = -1
  end
  return v
end
