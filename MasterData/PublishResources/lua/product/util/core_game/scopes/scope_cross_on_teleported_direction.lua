require("scope_base")
_class("SkillScopeCalculator_CrossOnTeleportedDirection", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossOnTeleportedDirection = SkillScopeCalculator_CrossOnTeleportedDirection

function SkillScopeCalculator_CrossOnTeleportedDirection:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local bodyAreaArray = bodyArea
  local size = scopeParam[1]
  local startIndex = scopeParam[2] or 1
  local selectBodyArea = scopeParam[3] or 0
  if scopeParam.bodyArea then
    local area = scopeParam.bodyArea
    local poslist = {}
    for i, v in ipairs(area) do
      poslist[i] = Vector2(v[1], v[2])
    end
    bodyAreaArray = poslist
  end
  local target_area_grid = {}
  for i, p in ipairs(bodyAreaArray) do
    local targetPos = centerPos + p
    table.insert(target_area_grid, targetPos)
  end
  local world = self._gridFilter._world
  local includedDirections = {
    up = false,
    down = false,
    left = false,
    right = false
  }
  if world and casterEntity and casterEntity:HasTeleportRecord() then
    local utilData = world:GetService("UtilData")
    local round = utilData:GetStatCurWaveRoundNum()
    local tAllTeleportRecord = casterEntity:TeleportRecord():GetAllTeleportRecordByRound(round)
    for _, record in ipairs(tAllTeleportRecord) do
      local dir = self:_GetSimplifiedV2Direction(record.finalPos - record.beginPos)
      if dir == Vector2.up then
        includedDirections.up = true
      elseif dir == Vector2.down then
        includedDirections.down = true
      elseif dir == Vector2.left then
        includedDirections.left = true
      elseif dir == Vector2.right then
        includedDirections.right = true
      end
    end
  end
  local cross_area = {}
  local wholeArea = {}
  for i, p in ipairs(target_area_grid) do
    local center_x = p.x
    local center_y = p.y
    if selectBodyArea == 1 then
      local bodyAreaPos = Vector2(center_x, center_y)
      self:_CheckAndInsertTargetGrid(bodyAreaPos, centerPos, includedDirections, cross_area, wholeArea)
    end
    for index = startIndex, size do
      local upPos = Vector2(center_x, center_y + index)
      local rightPos = Vector2(center_x + index, center_y)
      local downPos = Vector2(center_x, center_y - index)
      local leftPos = Vector2(center_x - index, center_y)
      self:_CheckAndInsertTargetGrid(upPos, centerPos, includedDirections, cross_area, wholeArea)
      self:_CheckAndInsertTargetGrid(rightPos, centerPos, includedDirections, cross_area, wholeArea)
      self:_CheckAndInsertTargetGrid(downPos, centerPos, includedDirections, cross_area, wholeArea)
      self:_CheckAndInsertTargetGrid(leftPos, centerPos, includedDirections, cross_area, wholeArea)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CrossOnTeleportedDirection, casterPos, cross_area, wholeArea)
  return result
end

function SkillScopeCalculator_CrossOnTeleportedDirection:_GetSimplifiedV2Direction(v2)
  local v = v2:Clone()
  if v.x > 0 then
    v.x = 1
  elseif v.x < 0 then
    v.x = -1
  end
  if 0 < v.y then
    v.y = 1
  elseif 0 > v.y then
    v.y = -1
  end
  return v
end

function SkillScopeCalculator_CrossOnTeleportedDirection:_CheckAndInsertTargetGrid(v2, centerPos, includedDirections, attackRange, wholeArea)
  local dir = self:_GetSimplifiedV2Direction(v2 - centerPos)
  if dir == Vector2.up and includedDirections.up then
    self:_InsertTargetGrid(attackRange, v2, wholeArea)
  elseif dir == Vector2.down and includedDirections.down then
    self:_InsertTargetGrid(attackRange, v2, wholeArea)
  elseif dir == Vector2.left and includedDirections.left then
    self:_InsertTargetGrid(attackRange, v2, wholeArea)
  elseif dir == Vector2.right and includedDirections.right then
    self:_InsertTargetGrid(attackRange, v2, wholeArea)
  end
end
