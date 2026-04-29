require("scope_base")
_class("SkillScopeCalculator_TargetAroundFarestExtend", SkillScopeCalculator_Base)
SkillScopeCalculator_TargetAroundFarestExtend = SkillScopeCalculator_TargetAroundFarestExtend

function SkillScopeCalculator_TargetAroundFarestExtend:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local calcExtendLine = scopeParam[1] or 0
  local world = self._hub._gridFilter._world
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local playerBodyArea = teamEntity:BodyArea():GetArea()
  local attackRangeOne = ComputeScopeRange.ComputeRange_SquareRing(playerPos, #playerBodyArea, 1)
  local utilDataSvc = self._world:GetService("UtilData")
  local centerAndDirList = {}
  for _, pos in ipairs(attackRangeOne) do
    local dirs = {
      Vector2(0, -1),
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(-1, 0)
    }
    if pos.y >= playerPos.y then
      dirs = {
        Vector2(0, -1),
        Vector2(1, 0),
        Vector2(-1, 0)
      }
    elseif pos.y <= playerPos.y then
      dirs = {
        Vector2(0, 1),
        Vector2(1, 0),
        Vector2(-1, 0)
      }
    elseif pos.x >= playerPos.x then
      dirs = {
        Vector2(0, -1),
        Vector2(0, 1),
        Vector2(1, 0)
      }
    elseif pos.x <= playerPos.x then
      dirs = {
        Vector2(0, -1),
        Vector2(0, 1),
        Vector2(-1, 0)
      }
    end
    for i, dir in ipairs(dirs) do
      if table.count(bodyArea) == 6 then
        local newBodyArea = bodyArea
        if dir == Vector2(1, 0) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(0, 1),
            Vector2(0, -1),
            Vector2(-1, 0),
            Vector2(-1, 1),
            Vector2(-1, -1)
          }
        elseif dir == Vector2(-1, 0) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(0, 1),
            Vector2(0, -1),
            Vector2(1, 0),
            Vector2(1, 1),
            Vector2(1, -1)
          }
        elseif dir == Vector2(0, 1) then
          newBodyArea = {
            Vector2(0, 0),
            Vector2(-1, 0),
            Vector2(1, 0),
            Vector2(0, -1),
            Vector2(-1, -1),
            Vector2(1, -1)
          }
        end
        bodyArea = newBodyArea
      end
      local canMove = true
      local posInTargetAround = false
      for k, area in ipairs(bodyArea) do
        local workPos = area + pos
        if not utilDataSvc:IsPosBlock(workPos, BlockFlag.MonsterLand) and not table.intable(bodyArea, workPos) then
          canMove = false
          break
        end
        if table.intable(attackRangeOne, workPos) then
          posInTargetAround = true
        end
      end
      if canMove and posInTargetAround then
        table.insert(centerAndDirList, {pos = pos, dir = dir})
        break
      end
    end
  end
  local dir = casterDir
  local targetPos = centerPos
  if 0 < table.count(centerAndDirList) then
    table.sort(centerAndDirList, function(a, b)
      local disA = Vector2.Distance(casterPos, a.pos)
      local disB = Vector2.Distance(casterPos, b.pos)
      return disA > disB
    end)
    dir = centerAndDirList[1].dir
    targetPos = centerAndDirList[1].pos
  else
    Log.error("")
  end
  local result = SkillScopeResult:New(SkillScopeType.TargetAroundFarestExtend, casterPos, {targetPos}, {targetPos})
  return result
end
