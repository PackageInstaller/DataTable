require("skill_scope_filter_pass_param")
_class("SkillScopeCalculator", Object)
SkillScopeCalculator = SkillScopeCalculator

function SkillScopeCalculator:Constructor(gridFilter)
  self._gridFilter = nil
  if gridFilter == nil then
    self._gridFilter = SkillScopeDefaultFilter:New()
  else
    self._gridFilter = gridFilter
  end
  self._scopeFilterDevice = SkillScopeFilterDevice:New()
  self:RegistSkillScopeCalculator()
end

function SkillScopeCalculator:CalcSkillPreviewScope(casterPos, casterDir, casterBodyArea, skillPreviewScopeParam, casterEntity)
  local scopeType = skillPreviewScopeParam:GetScopeType()
  local scopeParam = skillPreviewScopeParam:GetScopeParamData()
  local centerType = skillPreviewScopeParam:GetScopeCenterType()
  local targetType = skillPreviewScopeParam:GetScopeTargetType()
  local centerPos, bodyArea = self._gridFilter:CalcPreviewCenterPosAndBodyArea(centerType, casterPos, casterBodyArea, scopeParam, casterEntity)
  local result = self:ComputeScopeRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, targetType, casterPos, casterEntity)
  if self._gridFilter._world then
    local filterPassParam = SkillScopeFilterPassParam:New({
      casterPos = casterPos,
      casterBodyAreaArray = casterBodyArea,
      world = self._gridFilter._world
    })
    self._scopeFilterDevice:DoFilter(result, skillPreviewScopeParam:GetScopeFilterParam(), filterPassParam)
  end
  return result
end

function SkillScopeCalculator:CalcSkillEffectScope(casterPos, casterDir, casterBodyArea, skillEffectParam, casterEntity)
  local scopeType = skillEffectParam:GetSkillEffectScopeType()
  local scopeParam = skillEffectParam:GetSkillEffectScopeParam()
  local centerType = skillEffectParam:GetSkillEffectScopeCenterType()
  local targetType = skillEffectParam:GetSkillEffectTargetType()
  local centerPos, bodyArea = self._gridFilter:CalcCenterPosAndBodyArea(centerType, casterPos, casterBodyArea, scopeParam, casterEntity)
  local result = self:ComputeScopeRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, targetType, casterPos, casterEntity)
  if self._gridFilter._world then
    local filterPassParam = SkillScopeFilterPassParam:New({
      casterPos = casterPos,
      casterBodyAreaArray = casterBodyArea,
      world = self._gridFilter._world
    })
    self._scopeFilterDevice:DoFilter(result, skillEffectParam:GetScopeFilterParam(), filterPassParam)
  end
  return result
end

function SkillScopeCalculator:CalcSkillScope(skillConfigData, playerGridPos, casterDir, playerBodyArea, casterEntity)
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local centerType = skillConfigData:GetSkillScopeCenterType()
  local nTargetType = skillConfigData:GetSkillTargetType()
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  return self:CalcSkillScopeWithParams(scopeType, scopeParam, centerType, nTargetType, scopeFilterParam, playerGridPos, casterDir, playerBodyArea, casterEntity)
end

function SkillScopeCalculator:CalcSkillScopeForChainSkillPreview(skillConfigData, playerGridPos, casterEntity)
  local skillID = skillConfigData:GetID()
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local centerType = skillConfigData:GetSkillScopeCenterType()
  local nTargetType = skillConfigData:GetSkillTargetType()
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  local casterDir = casterEntity:GetGridDirection()
  local playerBodyArea = casterEntity:BodyArea():GetArea()
  if casterEntity and casterEntity:HasBuff() then
    local scopeParamAppender = casterEntity:BuffComponent():GetBuffValue("ChainSkillPreviewScopeParamAppender" .. skillID)
    if scopeParamAppender then
      if type(scopeParam) == "table" then
        local copyScopeParam = {}
        for k, v in pairs(scopeParam) do
          copyScopeParam[k] = v
        end
        for index, val in ipairs(scopeParamAppender) do
          copyScopeParam[index] = copyScopeParam[index] + val
        end
        scopeParam = copyScopeParam
      elseif type(scopeParam) == "number" then
        local appendVal = scopeParamAppender[1] or 0
        scopeParam = scopeParam + appendVal
      end
    end
  end
  return self:CalcSkillScopeWithParams(scopeType, scopeParam, centerType, nTargetType, scopeFilterParam, playerGridPos, casterDir, playerBodyArea, casterEntity)
end

function SkillScopeCalculator:CalcSkillScopeWithParams(scopeType, scopeParam, centerType, nTargetType, scopeFilterParam, playerGridPos, casterDir, playerBodyArea, casterEntity)
  local centerPos, bodyArea = self._gridFilter:CalcCenterPosAndBodyArea(centerType, playerGridPos, playerBodyArea, scopeParam)
  local result = self:ComputeScopeRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, playerGridPos, casterEntity)
  if self._gridFilter._world then
    local filterPassParam = SkillScopeFilterPassParam:New({
      casterPos = playerGridPos,
      casterBodyAreaArray = playerBodyArea,
      world = self._gridFilter._world
    })
    self._scopeFilterDevice:DoFilter(result, scopeFilterParam, filterPassParam)
  end
  return result
end

function SkillScopeCalculator:ComputeScopeRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  if self._gridFilter._world then
    scopeType = self._gridFilter._world:ReplaceSkillScopeType(scopeType)
  end
  local calculator = self._calculatorDic[scopeType]
  if scopeType == SkillScopeType.None or not calculator then
    Log.exception("No ScopeCalculator ScopeType:", scopeType)
    return SkillScopeResult:New(SkillScopeType.None, casterPos, nil, nil)
  end
  local result = calculator:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  return result
end

function SkillScopeCalculator:_InsertPosToResultArea(pos, resultArea)
  local isValid = self._gridFilter:IsValidPiecePos(pos)
  if isValid then
    local array = resultArea[pos.x]
    if array == nil then
      array = {}
      resultArea[pos.x] = array
    end
    resultArea[pos.x][pos.y] = pos
  end
end

function SkillScopeCalculator:_InsertTargetGrid(targetArea, newGridPos, wholeArea)
  local isValid = self._gridFilter:IsValidPiecePos(newGridPos)
  if isValid then
    local contain = table.icontains(targetArea, newGridPos)
    if not contain then
      targetArea[#targetArea + 1] = newGridPos
    end
  end
  if wholeArea then
    local contain = table.icontains(wholeArea, newGridPos)
    if not contain then
      wholeArea[#wholeArea + 1] = newGridPos
    end
  end
end

function SkillScopeCalculator:_InsertTargetGridIntoOneArea(newGridPos, area)
  local contain = table.icontains(area, newGridPos)
  if not contain then
    area[#area + 1] = newGridPos
  end
end

function SkillScopeCalculator:_CopyTable(tableA, tableB)
  if nil == tableB or nil == tableA then
    return
  end
  for key, value in pairs(tableB) do
    table.insert(tableA, value)
  end
end

function SkillScopeCalculator:_GetAroundPosOfPos(pos, n)
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

function SkillScopeCalculator:_CalcDirectLineExpand(casterPos, bodyAreaArray, casterDir, effectDirType, param)
  local expandWidth = param[3] or 0
  local expandArea = {}
  for i, v in ipairs(bodyAreaArray) do
    local p = Vector2(v.x, v.y)
    table.insert(expandArea, p)
  end
  local casterDirX = casterDir.x
  local casterDirY = casterDir.y
  if casterDirX ~= 0 then
    casterDirX = casterDirX / math.abs(casterDirX)
  end
  if casterDirY ~= 0 then
    casterDirY = casterDirY / math.abs(casterDirY)
  end
  local vertical1, vertical2 = Vector2(casterDirY, casterDirX), Vector2(-casterDirY, -casterDirX)
  for i, p in ipairs(bodyAreaArray) do
    for i = 1, expandWidth do
      local l = p + vertical1 * i
      local r = p + vertical2 * i
      if not BodyAreaHelper.IsPosInBodyArea(expandArea, l) then
        table.insert(expandArea, l)
      end
      if not BodyAreaHelper.IsPosInBodyArea(expandArea, r) then
        table.insert(expandArea, r)
      end
    end
  end
  local exceptBack = {}
  for i, v in ipairs(expandArea) do
    local p = Vector2(v.x, v.y)
    if not BodyAreaHelper.IsPosInBodyArea(expandArea, p + casterDir) then
      table.insert(exceptBack, p)
    end
  end
  local absArea = {}
  for i, p in ipairs(exceptBack) do
    table.insert(absArea, Vector2(casterPos.x + p.x, casterPos.y + p.y))
  end
  local cross_area = {}
  local wholeArea = {}
  local size = param[2] or 0
  local offset = param[1] or 0
  for i, p in ipairs(absArea) do
    local center_x = p.x
    local center_y = p.y
    for index = 1, size do
      local offsetIdx = index + offset
      local directpos = Vector2(center_x + casterDirX * offsetIdx, center_y + casterDirY * offsetIdx)
      table.insert(wholeArea, directpos)
      if self._gridFilter:IsValidPiecePos(directpos) then
        table.insert(cross_area, directpos)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.DirectLineExpand, casterPos, cross_area, wholeArea)
  return result
end

function SkillScopeCalculator:CalcMultiCenterCrossList(centerPos, scopeParam)
  local size = tonumber(scopeParam)
  local cross_area = {}
  local wholeArea = {}
  local center_x = centerPos.x
  local center_y = centerPos.y
  for index = 1, size do
    local upPos = Vector2(center_x, center_y + index)
    local downPos = Vector2(center_x, center_y - index)
    local leftPos = Vector2(center_x - index, center_y)
    local rightPos = Vector2(center_x + index, center_y)
    table.insert(wholeArea, upPos)
    table.insert(wholeArea, downPos)
    table.insert(wholeArea, leftPos)
    table.insert(wholeArea, rightPos)
    if self._gridFilter:IsValidPiecePos(upPos) then
      table.insert(cross_area, upPos)
    end
    if self._gridFilter:IsValidPiecePos(rightPos) then
      table.insert(cross_area, rightPos)
    end
    if self._gridFilter:IsValidPiecePos(downPos) then
      table.insert(cross_area, downPos)
    end
    if self._gridFilter:IsValidPiecePos(leftPos) then
      table.insert(cross_area, leftPos)
    end
  end
  table.insert(cross_area, centerPos)
  table.insert(wholeArea, centerPos)
  return cross_area, wholeArea
end

function SkillScopeCalculator:_CalcLeftDownColumnsAndRowsRange(leftDownPos, columns, rows)
  local retGridPosList = {}
  for y = 0, columns - 1 do
    for x = 0, rows - 1 do
      local gridPos = Vector2(leftDownPos.x + x, leftDownPos.y + y)
      if not self._gridFilter:IsValidPiecePos(gridPos) then
        return nil
      else
        table.insert(retGridPosList, gridPos)
      end
    end
  end
  return retGridPosList
end

function SkillScopeCalculator:GetDirection(gridpos, casterPos)
  local deltal = gridpos - casterPos
  if deltal.x == 0 and deltal.y <= -1 then
    return HitBackDirectionType.Down
  elseif deltal.x == 0 and deltal.y >= 1 then
    return HitBackDirectionType.Up
  elseif deltal.y == 0 and deltal.x >= 1 then
    return HitBackDirectionType.Right
  elseif deltal.y == 0 and deltal.x <= -1 then
    return HitBackDirectionType.Left
  elseif deltal.y >= 1 and deltal.x <= -1 then
    return HitBackDirectionType.LeftUp
  elseif deltal.y >= 1 and deltal.x >= 1 then
    return HitBackDirectionType.RightUp
  elseif deltal.y <= -1 and deltal.x >= 1 then
    return HitBackDirectionType.RightDown
  elseif deltal.y <= -1 and deltal.x <= -1 then
    return HitBackDirectionType.LeftDown
  else
    return HitBackDirectionType.None
  end
end

function SkillScopeCalculator:_ComputeHalfStartPos(nData)
  if 0 == nData % 2 then
    return -nData / 2 + 1
  else
    return -(nData - 1) / 2
  end
  return 0
end

function SkillScopeCalculator:_CalcCrossExceptBlock(scopeParam, centerPos, bodyArea, bReverse)
  local cross_area = {}
  local wholeArea = {}
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local size = scopeParam[1]
  local blockMonsterMove = scopeParam[2] or 0
  local ignoreCount = scopeParam[3] or 0
  local target_area_grid = {}
  for i, p in ipairs(bodyAreaArray) do
    local targetPos = casterPos + p
    table.insert(target_area_grid, targetPos)
  end
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  if blockMonsterMove and blockMonsterMove == 1 then
    blockGridTrapPosList = self._gridFilter:GetBlockMovePosList()
    local teamLeader = self._gridFilter._world:Player():GetCurrentTeamEntity()
    local teamPos = teamLeader:GetGridPosition()
    table.removev(blockGridTrapPosList, teamPos)
  end
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    local upBlocked = false
    local downBlocked = false
    local leftBlocked = false
    local rightBlocked = false
    local upFindOne = false
    local downFindOne = false
    local leftFindOne = false
    local rightFindOne = false
    local upIgnoreCount = ignoreCount
    local downIgnoreCount = ignoreCount
    local leftIgnoreCount = ignoreCount
    local rightIgnoreCount = ignoreCount
    local startIndex = 1
    local finalIndex = size
    local moveStep = 1
    if bReverse then
      startIndex = size
      finalIndex = 1
      moveStep = -1
    end
    for index = startIndex, finalIndex, moveStep do
      local upPos = Vector2(center_x, center_y + index)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      local rightPos = Vector2(center_x + index, center_y)
      upBlocked, upIgnoreCount, upFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, upBlocked, upIgnoreCount, upFindOne, blockGridTrapPosList, upPos, cross_area, wholeArea)
      downBlocked, downIgnoreCount, downFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, downBlocked, downIgnoreCount, downFindOne, blockGridTrapPosList, downPos, cross_area, wholeArea)
      leftBlocked, leftIgnoreCount, leftFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, leftBlocked, leftIgnoreCount, leftFindOne, blockGridTrapPosList, leftPos, cross_area, wholeArea)
      rightBlocked, rightIgnoreCount, rightFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, rightBlocked, rightIgnoreCount, rightFindOne, blockGridTrapPosList, rightPos, cross_area, wholeArea)
    end
  end
  return cross_area, wholeArea
end

function SkillScopeCalculator:_CalcCrossExceptBlock_checkBlock(bReverse, curBlocked, ignoreCount, curDirFindOne, blockGridTrapPosList, checkPos, cross_area, wholeArea)
  if not curBlocked then
    if not table.icontains(blockGridTrapPosList, checkPos) then
      local countBefore = #cross_area
      self:_InsertTargetGrid(cross_area, checkPos, wholeArea)
      local countEnd = #cross_area
      if countBefore < countEnd then
        curDirFindOne = true
      end
    elseif 0 < ignoreCount then
      if bReverse then
        if curDirFindOne then
          ignoreCount = ignoreCount - 1
          if ignoreCount == 0 then
            curBlocked = true
          end
        end
      else
        ignoreCount = ignoreCount - 1
        if ignoreCount == 0 then
          curBlocked = true
        end
      end
      self:_InsertTargetGrid(cross_area, checkPos, wholeArea)
    else
      if bReverse then
        if curDirFindOne then
          curBlocked = true
        end
      else
        curBlocked = true
      end
      self:_InsertTargetGridIntoOneArea(checkPos, wholeArea)
    end
  else
    self:_InsertTargetGridIntoOneArea(checkPos, wholeArea)
  end
  return curBlocked, ignoreCount, curDirFindOne
end

function SkillScopeCalculator:_CalcXShapeExceptBlock(scopeParam, centerPos, bodyArea, bReverse)
  local cross_area = {}
  local wholeArea = {}
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local size = scopeParam[1]
  local blockMonsterMove = scopeParam[2] or 0
  local ignoreCount = scopeParam[3] or 0
  local selectCenter = scopeParam[4] or 0
  local target_area_grid = {}
  for i, p in ipairs(bodyAreaArray) do
    local targetPos = casterPos + p
    table.insert(target_area_grid, targetPos)
  end
  local blockGridTrapPosList = self._gridFilter:GetBlockGridTrapPosList()
  if blockMonsterMove and blockMonsterMove == 1 then
    blockGridTrapPosList = self._gridFilter:GetBlockMovePosList()
    local teamLeader = self._gridFilter._world:Player():GetCurrentTeamEntity()
    local teamPos = teamLeader:GetGridPosition()
    table.removev(blockGridTrapPosList, teamPos)
  end
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    local leftUpBlocked = false
    local rightUpBlocked = false
    local leftDownBlocked = false
    local rightDownBlocked = false
    local leftUpFindOne = false
    local rightUpFindOne = false
    local leftDownFindOne = false
    local rightDownFindOne = false
    local leftUpIgnoreCount = ignoreCount
    local rightUpIgnoreCount = ignoreCount
    local leftDownIgnoreCount = ignoreCount
    local rightDownIgnoreCount = ignoreCount
    local startIndex = 1
    local finalIndex = size
    local moveStep = 1
    if bReverse then
      startIndex = size
      finalIndex = 1
      moveStep = -1
    end
    for index = startIndex, finalIndex, moveStep do
      local leftUpPos = Vector2(center_x - index, center_y + index)
      local rightUpPos = Vector2(center_x + index, center_y + index)
      local leftDownPos = Vector2(center_x - index, center_y - index)
      local rightDownPos = Vector2(center_x + index, center_y - index)
      leftUpBlocked, leftUpIgnoreCount, leftUpFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, leftUpBlocked, leftUpIgnoreCount, leftUpFindOne, blockGridTrapPosList, leftUpPos, cross_area, wholeArea)
      rightUpBlocked, rightUpIgnoreCount, rightUpFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, rightUpBlocked, rightUpIgnoreCount, rightUpFindOne, blockGridTrapPosList, rightUpPos, cross_area, wholeArea)
      leftDownBlocked, leftDownIgnoreCount, leftDownFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, leftDownBlocked, leftDownIgnoreCount, leftDownFindOne, blockGridTrapPosList, leftDownPos, cross_area, wholeArea)
      rightDownBlocked, rightDownIgnoreCount, rightDownFindOne = self:_CalcCrossExceptBlock_checkBlock(bReverse, rightDownBlocked, rightDownIgnoreCount, rightDownFindOne, blockGridTrapPosList, rightDownPos, cross_area, wholeArea)
    end
    if selectCenter == 1 and self._gridFilter:IsValidPiecePos(casterPos) then
      table.insert(cross_area, casterPos)
      table.insert(wholeArea, casterPos)
    end
  end
  return cross_area, wholeArea
end

function SkillScopeCalculator:_CalcNRowMColSpread_IsGridBlocked(gridPos, centerPos, blockGrids, spreadDirFlag)
  local vLeft = Vector2.left
  local vRight = Vector2.right
  local vUp = Vector2.up
  local vDown = Vector2.down
  local vCG = gridPos - centerPos
  for k, blockGrid in ipairs(blockGrids) do
    if self._gridFilter:IsValidPiecePos(blockGrid) then
      local vBG = gridPos - blockGrid
      local vBGNormalized = vBG.normalized
      local vCB = blockGrid - centerPos
      local vCBNormalized = vCB.normalized
      if vCBNormalized == vLeft then
        if vBGNormalized == vLeft then
          return true
        end
      elseif vCBNormalized == vRight then
        if vBGNormalized == vRight then
          return true
        end
      elseif vCBNormalized == vUp then
        if vBGNormalized == vUp then
          return true
        end
      elseif vCBNormalized == vDown then
        if vBGNormalized == vDown then
          return true
        end
      elseif spreadDirFlag == 1 then
        if vCB.x > 0 then
          if vBGNormalized == vRight then
            return true
          end
        elseif vCB.x < 0 and vBGNormalized == vLeft then
          return true
        end
      elseif 0 < vCB.y then
        if vBGNormalized == vUp then
          return true
        end
      elseif 0 > vCB.y and vBGNormalized == vDown then
        return true
      end
    end
  end
end

function SkillScopeCalculator:_CalcNRowMColSpread(scopeParam, centerPos, bodyArea)
  local row, col = math.floor(scopeParam[1]), math.floor(scopeParam[2])
  local spreadDirFlag = scopeParam[3]
  local targetArea = {}
  local wholeArea = {}
  local blockGrids = self._gridFilter:GetBlockGridTrapPosList()
  for i = -col, col do
    for j = -row, row do
      local gridPos = centerPos + Vector2(i, j)
      if self:_CalcNRowMColSpread_IsGridBlocked(gridPos, centerPos, blockGrids, spreadDirFlag) then
        self:_InsertTargetGridIntoOneArea(gridPos, wholeArea)
      else
        self:_InsertTargetGrid(targetArea, gridPos, wholeArea)
      end
    end
  end
  return targetArea, wholeArea
end
