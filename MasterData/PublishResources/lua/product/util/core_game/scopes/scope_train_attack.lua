require("scope_base")
_class("SkillScopeCalculator_TrainAttack", SkillScopeCalculator_Base)
SkillScopeCalculator_TrainAttack = SkillScopeCalculator_TrainAttack

function SkillScopeCalculator_TrainAttack:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.error(self._className, "Parameter not found. Take {3, 19} here. ")
    scopeParam = {3, 19}
  end
  local row = scopeParam[1]
  local column = scopeParam[2]
  local needSort = scopeParam[3]
  local type = self:GetDirection(centerPos, casterPos)
  local attackGridPosList = {}
  local skillNRowsMColumnsScopeParam
  if type == HitBackDirectionType.Down or type == HitBackDirectionType.Up then
    skillNRowsMColumnsScopeParam = SkillNRowsMColumnsScopeParam:New(column, row)
  else
    skillNRowsMColumnsScopeParam = SkillNRowsMColumnsScopeParam:New(row, column)
  end
  attackGridPosList = self._hub:ComputeScopeRange(SkillScopeType.NRowsMColumns, skillNRowsMColumnsScopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos):GetAttackRange()
  if needSort == 1 then
    if 1 <= centerPos.x - casterPos.x then
      table.sort(attackGridPosList, function(a, b)
        if a.x == b.x then
          return a.y < b.y
        end
        return a.x < b.x
      end)
    elseif centerPos.x - casterPos.x <= -1 then
      table.sort(attackGridPosList, function(a, b)
        if a.x == b.x then
          return a.y > b.y
        end
        return a.x > b.x
      end)
    elseif 1 <= centerPos.y - casterPos.y then
      table.sort(attackGridPosList, function(a, b)
        if a.y == b.y then
          return a.x < b.x
        end
        return a.y < b.y
      end)
    elseif -1 >= centerPos.y - casterPos.y then
      table.sort(attackGridPosList, function(a, b)
        if a.y == b.y then
          return a.x > b.x
        end
        return a.y > b.y
      end)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TrainAttackScope, centerPos, attackGridPosList, attackGridPosList)
  return result
end
