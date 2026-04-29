require("scope_base")
_class("SkillScopeCalculator_PyramidByPickUpDirAndBuffLayer", SkillScopeCalculator_Base)
SkillScopeCalculator_PyramidByPickUpDirAndBuffLayer = SkillScopeCalculator_PyramidByPickUpDirAndBuffLayer

function SkillScopeCalculator_PyramidByPickUpDirAndBuffLayer:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local baseLength = scopeParam[1]
  local buffEffectType = scopeParam[2]
  local layerCount = scopeParam[3] or 1
  local addStep = scopeParam[4] or 1
  local dirType
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  if activeSkillPickUpComponent then
    dirType = activeSkillPickUpComponent:GetLastPickUpDirection()
  else
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    if previewPickUpComponent then
      dirType = previewPickUpComponent:GetLastPickUpDirection()
    end
  end
  if not dirType or dirType == HitBackDirectionType.None then
    if centerPos and centerPos ~= casterPos then
      dirType = self:GetDirection(centerPos, casterPos)
      centerPos = casterPos:Clone()
    else
      return SkillScopeResult:New(SkillScopeType.PyramidByPickUpDirAndBuffLayer, centerPos, {}, {})
    end
  end
  local dir = HitBackDirectionTypeHelper.ConvertDirTypeToVector(dirType)
  local maxLength = baseLength
  if buffEffectType then
    local buffSvc = self._gridFilter._world:GetService("BuffLogic")
    local curLayerCount = buffSvc:GetBuffLayer(casterEntity, buffEffectType)
    local mul = math.modf(curLayerCount / layerCount)
    maxLength = maxLength + addStep * mul
  end
  local boardSvc = self._gridFilter._world:GetService("BoardLogic")
  local boardMaxX = boardSvc:GetCurBoardMaxX()
  local boardMaxY = boardSvc:GetCurBoardMaxY()
  local attackRange = {}
  local tmpLength = 1
  local basePos = centerPos:Clone()
  while maxLength >= tmpLength do
    basePos = basePos + dir
    if basePos.x <= 0 or boardMaxX < basePos.x or 0 >= basePos.y or boardMaxY < basePos.y then
      break
    end
    self:_AddAllGridInLine(attackRange, basePos, dir, tmpLength)
    tmpLength = tmpLength + 1
  end
  return SkillScopeResult:New(SkillScopeType.PyramidByPickUpDirAndBuffLayer, centerPos, attackRange, attackRange)
end

function SkillScopeCalculator_PyramidByPickUpDirAndBuffLayer:_IsPosValid(pos)
  return not self._gridFilter or self._gridFilter:IsValidPiecePos(pos)
end

function SkillScopeCalculator_PyramidByPickUpDirAndBuffLayer:_AddAllGridInLine(attackRange, basePos, dir, step)
  if self:_IsPosValid(basePos) then
    table.insert(attackRange, basePos)
  end
  local rotatedDir = Vector2.New(dir.y, dir.x)
  for i = 1, step do
    local pos = basePos + rotatedDir * i
    if self:_IsPosValid(pos) then
      table.insert(attackRange, pos)
    end
  end
  rotatedDir = Vector2.New(-dir.y, -dir.x)
  for i = 1, step do
    local pos = basePos + rotatedDir * i
    if self:_IsPosValid(pos) then
      table.insert(attackRange, pos)
    end
  end
end
