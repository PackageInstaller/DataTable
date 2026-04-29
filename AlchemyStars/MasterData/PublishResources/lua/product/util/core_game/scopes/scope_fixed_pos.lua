require("scope_base")
_class("SkillScopeCalculator_FixedPos", SkillScopeCalculator_Base)
SkillScopeCalculator_FixedPos = SkillScopeCalculator_FixedPos

function SkillScopeCalculator_FixedPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local arr = {}
  if scopeParam.type == 1 then
    arr = self:CalSquare(scopeParam.size, scopeParam.pos)
  elseif scopeParam.type == 2 then
    arr = self:CalCross(scopeParam.size, scopeParam.pos)
  elseif scopeParam.type == 3 then
    arr = self:CalFixedPos(scopeParam.pos)
  else
    Log.fatal("### invalid type. expand by yourself. scopeParam.type=", scopeParam.type)
  end
  local result = SkillScopeResult:New(SkillScopeType.FixedPos, centerPos, arr, arr)
  return result
end

function SkillScopeCalculator_FixedPos:CalSquare(size, posList)
  local poses = {}
  for i, v in ipairs(posList) do
    table.insert(poses, Vector2(v[1], v[2]))
  end
  local arr = {}
  local tmpSize = size - 1
  for i, v in ipairs(poses) do
    for j = 0, tmpSize do
      for k = 0, tmpSize do
        table.insert(arr, v + Vector2(j, k))
      end
    end
  end
  return arr
end

function SkillScopeCalculator_FixedPos:CalCross(size, posList)
  local poses = {}
  for i, v in ipairs(posList) do
    table.insert(poses, Vector2(v[1], v[2]))
  end
  local arr = {}
  for i, v in ipairs(poses) do
    table.insert(arr, v)
    for i = 1, size do
      table.insert(arr, v + Vector2.up * i)
      table.insert(arr, v + Vector2.right * i)
      table.insert(arr, v + Vector2.down * i)
      table.insert(arr, v + Vector2.left * i)
    end
  end
  return arr
end

function SkillScopeCalculator_FixedPos:CalFixedPos(posList)
  local arr = {}
  for _, v in ipairs(posList) do
    table.insert(arr, Vector2(v[1], v[2]))
  end
  return arr
end
