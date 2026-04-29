require("scope_base")
_class("SkillScopeCalculator_FixedArea", SkillScopeCalculator_Base)
SkillScopeCalculator_FixedArea = SkillScopeCalculator_FixedArea

function SkillScopeCalculator_FixedArea:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local fixedAreaType = scopeParam
  local target_area_grid = {}
  if fixedAreaType == FixedAreaType.DragonSweep then
    local vPos2Target = {}
    for i = 1, 4 do
      table.insert(target_area_grid, centerPos + casterDir * i)
      for j = 5 - i, 1, -1 do
        local vVerticalL = Vector2(casterDir.y, -casterDir.x)
        local vVerticalR = Vector2(-casterDir.y, casterDir.x)
        table.insert(target_area_grid, centerPos + vVerticalL * i + casterDir * j)
        table.insert(target_area_grid, centerPos + vVerticalR * i + casterDir * j)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.FixedArea, nil, target_area_grid, target_area_grid)
  return result
end
