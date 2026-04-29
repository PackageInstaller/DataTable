require("scope_base")
_class("SkillScopeCalculator_Crab", SkillScopeCalculator_Base)
SkillScopeCalculator_Crab = SkillScopeCalculator_Crab

function SkillScopeCalculator_Crab:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local params = scopeParam
  local attackDis = params[1]
  local moveDir = params[2] or 0
  local moveDis = params[3] or 0
  local onlyAttack = params[4] or 0
  local calcMoveBlock = params[5] or 1
  local movePosList = {}
  local range = {}
  local wholeArea = {}
  local bodyAreaPosList = {}
  for _, bodyPos in ipairs(bodyArea) do
    local posWork = centerPos + bodyPos
    table.insert(bodyAreaPosList, posWork)
  end
  local targetDir = Vector2(0, 0)
  if casterDir == Vector2(0, 1) then
    targetDir = Vector2(1 * moveDir, 0)
  elseif casterDir == Vector2(0, -1) then
    targetDir = Vector2(-1 * moveDir, 0)
  elseif casterDir == Vector2(1, 0) then
    targetDir = Vector2(0, -1 * moveDir)
  elseif casterDir == Vector2(-1, 0) then
    targetDir = Vector2(0, 1 * moveDir)
  end
  for i = 0, moveDis do
    local movePos = centerPos + Vector2(targetDir.x * i, targetDir.y * i)
    if calcMoveBlock == 1 then
      local isBlock = self:IsPosBlockByArea(movePos, BlockFlag.MonsterLand, bodyArea, casterEntity)
      if isBlock then
        break
      end
    end
    if onlyAttack ~= 1 and not table.icontains(wholeArea, movePos) and movePos ~= centerPos then
      table.insert(wholeArea, movePos)
    end
    if attackDis ~= 0 then
      for _, bodyPos in ipairs(bodyArea) do
        local curPos = movePos + bodyPos
        for k = 1, attackDis do
          local posWork = curPos + Vector2(casterDir.x * k, casterDir.y * k)
          if not table.icontains(bodyAreaPosList, posWork) and not table.icontains(wholeArea, posWork) then
            table.insert(wholeArea, posWork)
          end
        end
      end
    end
  end
  for _, pos in ipairs(wholeArea) do
    if self._gridFilter:IsValidPiecePos(pos) then
      table.insert(range, pos)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.Crab, centerPos, range, wholeArea)
  return result
end

function SkillScopeCalculator_Crab:IsPosBlockByArea(pos, blockFlag, listArea, entityExcept)
  local utilDataSvc = self._gridFilter._world:GetService("UtilData")
  local ret = false
  for i = 1, #listArea do
    local posWork = pos + listArea[i]
    if utilDataSvc:IsPosBlock(posWork, blockFlag) then
      if not entityExcept then
        return true
      end
      local entityMonster = utilDataSvc:GetMonsterAtPos(posWork)
      if not entityMonster or entityMonster ~= entityExcept then
        return true
      end
    end
  end
  return false
end
