require("scope_base")
_class("SkillScopeCalculator_AroundBodyArea", SkillScopeCalculator_Base)
SkillScopeCalculator_AroundBodyArea = SkillScopeCalculator_AroundBodyArea

function SkillScopeCalculator_AroundBodyArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local pos = centerPos
  local area = bodyArea
  local targetArea = {}
  local wholeArea = {}
  local areaPos = {}
  local arrPos = {}
  local isBodyAreaIncluded = scopeParam[1]
  local layerCount = scopeParam[2] or 1
  for i, v in ipairs(area) do
    table.insert(areaPos, pos + v)
  end
  for i, v in ipairs(areaPos) do
    local posList = self:_GetAroundPosOfPos(v, layerCount)
    for j, jv in ipairs(posList) do
      if isBodyAreaIncluded == 1 then
        self:_InsertTargetGrid(targetArea, jv, wholeArea)
      elseif not table.icontains(areaPos, jv) then
        self:_InsertTargetGrid(targetArea, jv, wholeArea)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.AroundBodyArea, pos, targetArea, wholeArea)
  return result
end

function SkillScopeCalculator_AroundBodyArea:_GetAroundPosOfPos(pos, n)
  local arrPos = {}
  for i = -n, n do
    for j = -n, n do
      if i ~= 0 or j ~= 0 then
        table.insert(arrPos, pos + Vector2(i, j))
      end
    end
  end
  return arrPos
end
