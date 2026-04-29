require("scope_base")
_class("SkillScopeCalculator_AngleFreeLine", SkillScopeCalculator_Base)
SkillScopeCalculator_AngleFreeLine = SkillScopeCalculator_AngleFreeLine

function SkillScopeCalculator_AngleFreeLine:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local centerPosArray = centerPos
  if centerPos._className then
    centerPosArray = {centerPos}
  end
  local world = self._hub._gridFilter._world
  if not world then
    Log.exception(self._className, "AngleFreeLine无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.AngleFreeLine, casterPos, {}, {})
  end
  if scopeParam.useTrapAsBegin then
    local trapID = scopeParam.trapID
    local trapServerLogic = world:GetService("TrapLogic")
    local trapList = {}
    if type(trapID) == "number" then
      trapList[#trapList + 1] = trapID
    elseif type(trapID) == "table" then
      trapList = trapID
    end
    local bFind = false
    for _, vTrapID in ipairs(trapList) do
      local trapCenterPosList = trapServerLogic:FindTrapPosByTrapID(vTrapID)
      if table.count(trapCenterPosList) == 0 then
      else
        casterPos = trapCenterPosList[1]
        bFind = true
        break
      end
    end
    if not bFind then
      return SkillScopeResult:New(SkillScopeType.AngleFreeLine, casterPos, {}, {})
    end
  end
  if casterPos == centerPosArray[1] then
    return SkillScopeResult:New(SkillScopeType.AngleFreeLine, casterPos, {casterPos}, {})
  end
  local boardService = world:GetService("BoardLogic")
  local pieceXYMap = boardService.GridTiles
  local attackRange = {}
  local wholeRange = {}
  local posOnLine = {}
  local bNoExtend = scopeParam.noExtend == 1
  local widthThreshold = BattleConst.ScopeAngleFreeLineThreshold
  if scopeParam.widthThreshold then
    widthThreshold = scopeParam.widthThreshold * 0.8
  end
  local isDirectionReverse = scopeParam.directionReverse == 1
  local casterX = casterPos.x
  local casterY = casterPos.y
  for _, pickupPos in ipairs(centerPosArray) do
    self:_CalcLineBetween(casterPos, pickupPos, widthThreshold, bNoExtend, isDirectionReverse, attackRange, wholeRange)
  end
  local extendList = {}
  if scopeParam.useBodyArea then
    for i, v in ipairs(attackRange) do
      for _, body in ipairs(bodyArea) do
        local newPos = v + body
        if not table.Vector2Include(attackRange, newPos) then
          table.insert(extendList, newPos)
        end
      end
    end
  end
  if 0 < #extendList then
    table.Vector2Append(attackRange, extendList)
  end
  local result = SkillScopeResult:New(SkillScopeType.AngleFreeLine, centerPos, attackRange, wholeRange)
  return result
end

function SkillScopeCalculator_AngleFreeLine:_CalcLineBetween(casterPos, pickupPos, widthThreshold, bNoExtend, isDirectionReverse, attackRange, wholeRange)
  if isDirectionReverse then
    casterPos, pickupPos = pickupPos, casterPos
  end
  local posOnLine = {}
  local pickupDistance = Vector2.Distance(pickupPos, casterPos)
  local relativePickupPos = pickupPos - casterPos
  local relativePickupX = relativePickupPos.x
  local relativePickupY = relativePickupPos.y
  local a = relativePickupPos.x
  local b = relativePickupPos.y
  local pickupX = pickupPos.x
  local pickupY = pickupPos.y
  local relativeNegPickupPos = casterPos - pickupPos
  local relativeNegPickupX = relativeNegPickupPos.x
  local relativeNegPickupY = relativeNegPickupPos.y
  local casterX = casterPos.x
  local casterY = casterPos.y
  local world = self._hub._gridFilter._world
  local boardService = world:GetService("BoardLogic")
  local pieceXYMap = boardService.GridTiles
  for x, tableY in pairs(pieceXYMap) do
    local relativeX = x - casterX
    local relativeNegX = x - pickupX
    for y, _ in pairs(tableY) do
      local relativeY = y - casterY
      local relativeNegY = y - pickupY
      local v2 = Vector2(x, y)
      if b * relativeX == a * relativeY and 0 <= relativeX * relativePickupX and 0 <= relativeY * relativePickupY and (not bNoExtend or pickupDistance >= Vector2.Distance(v2, casterPos)) then
        if not table.icontains(attackRange, v2) then
          table.insert(attackRange, v2)
        end
        if not table.icontains(wholeRange, v2) then
          table.insert(wholeRange, v2)
        end
        if not table.icontains(posOnLine, v2) then
          table.insert(posOnLine, v2)
        end
      end
    end
  end
  for _, linePos in ipairs(posOnLine) do
    local disThreshold = Vector2.Distance(linePos, casterPos) + widthThreshold
    local relativeLinePos = casterPos - linePos
    local a = relativeLinePos.x
    local b = relativeLinePos.y
    local sqrtLinePos = math.sqrt(a * a + b * b)
    local sqrt = sqrtLinePos * widthThreshold
    for x, tableY in pairs(pieceXYMap) do
      local relativeX = casterX - x
      for y, _ in pairs(tableY) do
        local relativeY = casterY - y
        local v2 = Vector2(x, y)
        if sqrt > math.abs(b * relativeX - a * relativeY) and 0 <= relativeX * a and 0 <= relativeY * b and (not bNoExtend or disThreshold > Vector2.Distance(v2, casterPos)) then
          if not table.icontains(attackRange, v2) then
            table.insert(attackRange, v2)
          end
          if not table.icontains(wholeRange, v2) then
            table.insert(wholeRange, v2)
          end
        end
      end
    end
  end
end
