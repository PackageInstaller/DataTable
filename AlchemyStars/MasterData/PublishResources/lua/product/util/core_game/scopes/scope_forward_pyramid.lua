require("scope_base")
_class("SkillScopeCalculator_ForwardPyramid", SkillScopeCalculator_Base)
SkillScopeCalculator_ForwardPyramid = SkillScopeCalculator_ForwardPyramid
local ForwardPyramidSubtype = {
  Pyramid = 1,
  Rectangle = 2,
  DoublePyramid = 3
}

function SkillScopeCalculator_ForwardPyramid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local useCasterDir = scopeParam[2] == 1
  local v2Dir = Vector2.zero
  if casterPos == centerPos then
    v2Dir = casterDir
  else
    v2Dir = centerPos - casterPos
  end
  if useCasterDir then
    v2Dir = casterDir
  end
  if v2Dir.x > 0 then
    v2Dir.x = 1
  elseif v2Dir.x < 0 then
    v2Dir.x = -1
  end
  if 0 < v2Dir.y then
    v2Dir.y = 1
  elseif 0 > v2Dir.y then
    v2Dir.y = -1
  end
  if v2Dir == Vector2.zero then
    return SkillScopeResult:New(SkillScopeType.ForwardPyramid, centerPos, {centerPos}, {centerPos})
  end
  local lbsvc = self._gridFilter._world:GetService("BoardLogic")
  local boardMaxX = lbsvc:GetCurBoardMaxX()
  local boardMaxY = lbsvc:GetCurBoardMaxY()
  local attackRange = {}
  local type = scopeParam[1]
  if type == ForwardPyramidSubtype.Pyramid then
    local layerCount = 1
    local v2Center = centerPos:Clone()
    ::lbl_68::
    v2Center = v2Center + v2Dir
    if not (v2Center.x <= 0) and not (boardMaxX < v2Center.x) and not (0 >= v2Center.y) and not (boardMaxY < v2Center.y) then
      if self:_IsPosValid(v2Center) and not table.icontains(attackRange, v2Center) then
        table.insert(attackRange, v2Center)
      end
      self:_AddAllGridInLine(attackRange, v2Center, v2Dir, layerCount)
      layerCount = layerCount + 1
      goto lbl_68
    end
  elseif type == ForwardPyramidSubtype.Rectangle then
    local layerCount = 1
    local v2Center = centerPos:Clone()
    ::lbl_113::
    v2Center = v2Center + v2Dir
    if not (v2Center.x <= 0) and not (boardMaxX < v2Center.x) and not (0 >= v2Center.y) and not (boardMaxY < v2Center.y) then
      if self:_IsPosValid(v2Center) and not table.icontains(attackRange, v2Center) then
        table.insert(attackRange, v2Center)
      end
      self:_AddAllGridInLine(attackRange, v2Center, v2Dir, math.max(boardMaxX, boardMaxY))
      layerCount = layerCount + 1
      goto lbl_113
    end
  elseif type == ForwardPyramidSubtype.DoublePyramid then
    local frontCenters = {}
    if bodyArea then
      local bodyPosList = {}
      for index, offPos in ipairs(bodyArea) do
        local bodyPos = casterPos + offPos
        table.insert(bodyPosList, bodyPos)
      end
      for index, bodyPos in ipairs(bodyPosList) do
        local frontPos = bodyPos + v2Dir
        if not table.icontains(bodyPosList, frontPos) then
          table.insert(frontCenters, bodyPos)
        end
      end
      for index, frontCenterPos in ipairs(frontCenters) do
        local layerCount = 1
        local v2Center = frontCenterPos:Clone()
        while true do
          v2Center = v2Center + v2Dir
          if v2Center.x <= 0 or boardMaxX < v2Center.x or 0 >= v2Center.y or boardMaxY < v2Center.y then
            break
          end
          if self:_IsPosValid(v2Center) and not table.icontains(attackRange, v2Center) then
            table.insert(attackRange, v2Center)
          end
          self:_AddAllGridInLine(attackRange, v2Center, v2Dir, layerCount)
          layerCount = layerCount + 1
        end
      end
    end
  end
  local sortAttackRange = self:_AbsDistanceSort(attackRange, centerPos)
  return SkillScopeResult:New(SkillScopeType.ForwardPyramid, centerPos, sortAttackRange, sortAttackRange)
end

function SkillScopeCalculator_ForwardPyramid:_IsPosValid(v2)
  return not self._gridFilter or self._gridFilter:IsValidPiecePos(v2)
end

function SkillScopeCalculator_ForwardPyramid:_AddAllGridInLine(attackRange, v2Center, v2Dir, layerCount)
  local rotatedV2 = Vector2.New(v2Dir.y, v2Dir.x)
  for i = 1, layerCount do
    local v2 = v2Center + rotatedV2 * i
    if self:_IsPosValid(v2) and not table.icontains(attackRange, v2) then
      table.insert(attackRange, v2)
    end
  end
  rotatedV2 = rotatedV2 * -1
  for i = 1, layerCount do
    local v2 = v2Center + rotatedV2 * i
    if self:_IsPosValid(v2) and not table.icontains(attackRange, v2) then
      table.insert(attackRange, v2)
    end
  end
end

function SkillScopeCalculator_ForwardPyramid:_AbsDistanceSort(gridList, castPos)
  local posDic = {}
  for _, pos in pairs(gridList) do
    local dis = Vector2.Distance(castPos, pos)
    if not posDic[dis] then
      posDic[dis] = {}
    end
    table.insert(posDic[dis], pos)
  end
  
  local function sortDicFunc(dic)
    local newDic = {}
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  local attackRange = {}
  for dis, posList in pairs(posDic) do
    for _, pos in pairs(posList) do
      table.insert(attackRange, pos)
    end
  end
  return attackRange
end
