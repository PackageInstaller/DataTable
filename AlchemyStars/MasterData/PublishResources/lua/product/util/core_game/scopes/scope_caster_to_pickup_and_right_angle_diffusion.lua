require("scope_base")
_class("SkillScopeCalculator_CasterToPickUpAndRightAngleDiffusion", SkillScopeCalculator_Base)
SkillScopeCalculator_CasterToPickUpAndRightAngleDiffusion = SkillScopeCalculator_CasterToPickUpAndRightAngleDiffusion

function SkillScopeCalculator_CasterToPickUpAndRightAngleDiffusion:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local diffusionSize = scopeParam[1] or 19
  local pickUpPosInclude = scopeParam[2] or 0
  local casterToPickUpInclude = scopeParam[3] or 0
  local onlySelectDiffusionDdge = scopeParam[4] or 0
  local attackGridPosList = {}
  local type = self:GetDirection(centerPos, casterPos)
  if 1 < diffusionSize then
    local skillNRowsMColumnsScopeParam
    if type == HitBackDirectionType.Down or type == HitBackDirectionType.Up then
      skillNRowsMColumnsScopeParam = SkillNRowsMColumnsScopeParam:New(1, diffusionSize)
    else
      skillNRowsMColumnsScopeParam = SkillNRowsMColumnsScopeParam:New(diffusionSize, 1)
    end
    attackGridPosList = self._hub:ComputeScopeRange(SkillScopeType.NRowsMColumns, skillNRowsMColumnsScopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos):GetAttackRange()
  end
  if onlySelectDiffusionDdge == 1 then
    local newPosList = {}
    local world = self._gridFilter._world
    local board = world:GetBoardEntity():Board()
    if 1 < table.count(attackGridPosList) then
      table.sort(attackGridPosList, function(a, b)
        if a.x == b.x then
          return a.y < b.y
        elseif a.y == b.y then
          return a.x < b.x
        end
      end)
    end
    for i = 1, #attackGridPosList do
      local posWork = attackGridPosList[i]
      local gridPieceType = board:GetPieceType(posWork)
      if not table.intable(newPosList, posWork) and gridPieceType ~= PieceType.None then
        table.insert(newPosList, posWork)
        break
      end
    end
    for i = #attackGridPosList, 1, -1 do
      local posWork = attackGridPosList[i]
      local gridPieceType = board:GetPieceType(posWork)
      if not table.intable(newPosList, posWork) and gridPieceType ~= PieceType.None then
        table.insert(newPosList, posWork)
        break
      end
    end
    attackGridPosList = newPosList
  else
    if pickUpPosInclude == 0 then
      table.removev(attackGridPosList, centerPos)
    end
    if casterToPickUpInclude == 1 then
      local dirX = 1
      local dirY = 1
      if centerPos.x < casterPos.x then
        dirX = -1
      end
      if centerPos.y < casterPos.y then
        dirY = -1
      end
      for i = casterPos.x, centerPos.x, dirX do
        for j = casterPos.y, centerPos.y, dirY do
          local pos = Vector2(i, j)
          table.insert(attackGridPosList, pos)
          table.insert(attackGridPosList, pos)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CasterToPickUpAndRightAngleDiffusion, centerPos, attackGridPosList, attackGridPosList)
  return result
end
