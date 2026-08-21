require("scope_base")
_class("SkillScopeCalculator_MultiRandomRange", SkillScopeCalculator_Base)
SkillScopeCalculator_MultiRandomRange = SkillScopeCalculator_MultiRandomRange

function SkillScopeCalculator_MultiRandomRange:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local world = self._gridFilter._world
  local rangeScope = {}
  local maxRing = scopeParam.maxRing
  local maxRange = self:_CalSquareRange(scopeParam, centerPos, bodyArea, maxRing)
  local minRing = scopeParam.minRing
  local minRange = self:_CalSquareRange(scopeParam, centerPos, bodyArea, minRing)
  local skillScope = {}
  for key, value in pairs(maxRange) do
    if not table.intable(minRange) then
      table.insert(skillScope, value)
    end
  end
  local resultScope = {}
  local resultScopeCenter = {}
  local resultCount = 0
  local multiCount = scopeParam.multiCount
  local randomSvc = world:GetService("RandomLogic")
  while resultCount < multiCount do
    resultScope = {}
    resultScopeCenter = {}
    resultCount = 0
    local skillScopeCopy = {}
    table.appendArray(skillScopeCopy, skillScope)
    for i = 1, multiCount do
      local randomIndex = randomSvc:LogicRand(1, #skillScopeCopy)
      local randomPos = skillScopeCopy[randomIndex]
      local curSelectScope = self:_CalEachRange(scopeParam, randomPos)
      local selectPosInRange = false
      if curSelectScope and 0 < #curSelectScope then
        for k = 1, #curSelectScope do
          local workPos = curSelectScope[k]
          if table.intable(resultScope, workPos) or table.intable(minRange, workPos) then
            selectPosInRange = true
            break
          end
        end
      end
      if not selectPosInRange and curSelectScope and 0 < #curSelectScope then
        for k = 1, #curSelectScope do
          local workPos = curSelectScope[k]
          table.removev(skillScopeCopy, workPos)
        end
        table.appendArray(resultScope, curSelectScope)
        table.insert(resultScopeCenter, curSelectScope[1])
        resultCount = resultCount + 1
      else
        break
      end
    end
  end
  if scopeParam.returnScopeCenter == 1 then
    resultScope = resultScopeCenter
  end
  local result = SkillScopeResult:New(SkillScopeType.MultiRandomRange, centerPos, resultScope, resultScope)
  return result
end

function SkillScopeCalculator_MultiRandomRange:_CalEachRange(scopeParam, randomPos)
  local arr = {}
  if scopeParam.areaType == 1 then
    arr = self:CalSquare(scopeParam.size, randomPos)
  elseif scopeParam.areaType == 2 then
    arr = self:CalCross(scopeParam.size, randomPos)
  else
    table.insert(arr, randomPos)
  end
  local isValidGridCount = 0
  for key, value in pairs(arr) do
    local isValidGrid = self._gridFilter:IsValidPiecePos(value)
    if isValidGrid then
      isValidGridCount = isValidGridCount + 1
    end
  end
  if isValidGridCount ~= #arr then
    return nil
  end
  return arr
end

function SkillScopeCalculator_MultiRandomRange:_CalSquareRange(scopeParam, centerPos, bodyArea, squareBorder)
  local select_piece = {}
  local left = centerPos.x + BodyAreaHelper.GetBodyAreaLeft(bodyArea)
  local right = centerPos.x + BodyAreaHelper.GetBodyAreaRight(bodyArea)
  local up = centerPos.y + BodyAreaHelper.GetBodyAreaUp(bodyArea)
  local down = centerPos.y + BodyAreaHelper.GetBodyAreaDown(bodyArea)
  for i = left - squareBorder, right + squareBorder do
    for j = down - squareBorder, up + squareBorder do
      local pos = Vector2(i, j)
      local isValidGrid = self._gridFilter:IsValidPiecePos(pos)
      if isValidGrid then
        select_piece[#select_piece + 1] = pos
      end
    end
  end
  return select_piece
end

function SkillScopeCalculator_MultiRandomRange:CalSquare(size, pos)
  local arr = {}
  local tmpSize = size - 1
  for j = 0, tmpSize do
    for k = 0, tmpSize do
      table.insert(arr, pos + Vector2(j, k))
    end
  end
  return arr
end

function SkillScopeCalculator_MultiRandomRange:CalCross(size, pos)
  local arr = {}
  table.insert(arr, pos)
  for i = 1, size do
    table.insert(arr, pos + Vector2.up * i)
    table.insert(arr, pos + Vector2.right * i)
    table.insert(arr, pos + Vector2.down * i)
    table.insert(arr, pos + Vector2.left * i)
  end
  return arr
end
