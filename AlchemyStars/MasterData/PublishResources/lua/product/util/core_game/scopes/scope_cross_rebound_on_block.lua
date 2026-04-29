require("scope_base")
_class("SkillScopeCalculator_CrossReboundOnBlock", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossReboundOnBlock = SkillScopeCalculator_CrossReboundOnBlock

function SkillScopeCalculator_CrossReboundOnBlock:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local attackRange = {}
  local wholeRange = {}
  local size = scopeParam.size
  local blockMonsterMove = scopeParam.blockMonsterMove or 0
  local ignoreCount = scopeParam.ignoreCount or 0
  local skipBlockPos = scopeParam.skipBlockPos == 1 or false
  local reboundScopeType = scopeParam.reboundScopeType
  local reboundScopeParam = scopeParam.reboundScopeParam
  local target_area_grid = {}
  for i, p in ipairs(bodyArea) do
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
  local reboundScopeCalcParam = {
    scopeType = reboundScopeType,
    scopeParam = reboundScopeParam,
    bodyArea = bodyArea,
    casterDir = casterDir,
    nTargetType = nTargetType,
    casterPos = casterPos,
    casterEntity = casterEntity
  }
  local isUpReboundRequired = true
  local isDownReboundRequired = true
  local isLeftReboundRequired = true
  local isRightReboundRequired = true
  for _, p in ipairs(target_area_grid) do
    local centerX = p.x
    local centerY = p.y
    for index = 1, size do
      local upPos = Vector2.New(centerX, centerY + index)
      local downPos = Vector2.New(centerX, centerY - index)
      local leftPos = Vector2.New(centerX - index, centerY)
      local rightPos = Vector2.New(centerX + index, centerY)
      if isUpReboundRequired and self:_CalcScopeAtPos(upPos, Vector2.up, blockGridTrapPosList, reboundScopeCalcParam, attackRange, wholeRange, skipBlockPos) then
        isUpReboundRequired = false
      end
      if isDownReboundRequired and self:_CalcScopeAtPos(downPos, Vector2.down, blockGridTrapPosList, reboundScopeCalcParam, attackRange, wholeRange, skipBlockPos) then
        isDownReboundRequired = false
      end
      if isLeftReboundRequired and self:_CalcScopeAtPos(leftPos, Vector2.left, blockGridTrapPosList, reboundScopeCalcParam, attackRange, wholeRange, skipBlockPos) then
        isLeftReboundRequired = false
      end
      if isRightReboundRequired and self:_CalcScopeAtPos(rightPos, Vector2.right, blockGridTrapPosList, reboundScopeCalcParam, attackRange, wholeRange, skipBlockPos) then
        isRightReboundRequired = false
      end
    end
  end
  return SkillScopeResult:New(SkillScopeType.CrossReboundOnBlock, centerPos, attackRange, wholeRange)
end

function SkillScopeCalculator_CrossReboundOnBlock:_CalcScopeAtPos(pos, dir, blockGridTrapPosList, reboundScopeCalcParam, attackRange, wholeRange, skipBlockPos)
  if not table.icontains(blockGridTrapPosList, pos) and self._gridFilter:IsValidPiecePos(pos) then
    table.insert(attackRange, pos)
    table.insert(wholeRange, pos)
    return false
  end
  local reboundCenterPos = pos - dir
  local scopeCalculator = SkillScopeCalculator:New(self._gridFilter)
  local reboundScopeResult = scopeCalculator:ComputeScopeRange(reboundScopeCalcParam.scopeType, reboundScopeCalcParam.scopeParam, reboundCenterPos, reboundScopeCalcParam.bodyArea, reboundScopeCalcParam.casterDir, reboundScopeCalcParam.nTargetType, reboundScopeCalcParam.casterPos, reboundScopeCalcParam.casterEntity)
  for _, grid in ipairs(reboundScopeResult:GetAttackRange()) do
    if self._gridFilter:IsValidPiecePos(grid) and (not skipBlockPos or not table.icontains(blockGridTrapPosList, grid)) then
      table.insert(attackRange, grid)
    end
    table.insert(wholeRange, grid)
  end
  return true
end
