require("scope_base")
_class("SkillScopeCalculator_AroundBodyAndNearestPlayer", SkillScopeCalculator_Base)
SkillScopeCalculator_AroundBodyAndNearestPlayer = SkillScopeCalculator_AroundBodyAndNearestPlayer

function SkillScopeCalculator_AroundBodyAndNearestPlayer:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local width = scopeParam[1]
  local monsterRaceType = scopeParam[2]
  monsterRaceType = monsterRaceType or MonsterRaceType.Land
  local blockType
  if monsterRaceType == MonsterRaceType.Land then
    blockType = BlockFlag.MonsterLand
  elseif monsterRaceType == MonsterRaceType.Fly then
    blockType = BlockFlag.Fly
  end
  local world = self._hub._gridFilter._world
  if not world then
    Log.exception(self._className, "无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.AroundBodyAndNearestPlayer, casterPos, {}, {})
  end
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local upPos = Vector2(casterPos.x, casterPos.y + width)
  local downPos = Vector2(casterPos.x, casterPos.y - width)
  local leftPos = Vector2(casterPos.x - width, casterPos.y)
  local rightPos = Vector2(casterPos.x + width, casterPos.y)
  local disList = {}
  local attackRange
  table.insert(disList, {
    Dis = Vector2.Distance(playerPos, upPos),
    Pos = upPos
  })
  table.insert(disList, {
    Dis = Vector2.Distance(playerPos, downPos),
    Pos = downPos
  })
  table.insert(disList, {
    Dis = Vector2.Distance(playerPos, leftPos),
    Pos = leftPos
  })
  table.insert(disList, {
    Dis = Vector2.Distance(playerPos, rightPos),
    Pos = rightPos
  })
  table.sort(disList, function(a, b)
    return a.Dis < b.Dis
  end)
  local boardServiceLogic = world:GetService("BoardLogic")
  for _, v in ipairs(disList) do
    if v.Dis == 0 then
      attackRange = {
        v.Pos
      }
      break
    end
    if not boardServiceLogic:IsPosBlock(v.Pos, blockType) then
      attackRange = {
        v.Pos
      }
      break
    end
  end
  attackRange = attackRange or {casterPos}
  local result = SkillScopeResult:New(SkillScopeType.AroundBodyAndNearestPlayer, centerPos, attackRange, attackRange)
  return result
end
