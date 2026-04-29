require("scope_base")
_class("SkillScopeCalculator_ExpectFirstCenterPos", SkillScopeCalculator_Base)
SkillScopeCalculator_ExpectFirstCenterPos = SkillScopeCalculator_ExpectFirstCenterPos

function SkillScopeCalculator_ExpectFirstCenterPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local selectIndex = scopeParam or {}
  local ret = {}
  for i, v in ipairs(centerPos) do
    if i ~= 1 then
      if 1 < #selectIndex then
        if table.icontains(selectIndex, i - 1) then
          table.insert(ret, v:Clone())
        end
      else
        table.insert(ret, v:Clone())
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.ExpectedFirstCenterPos, casterPos, ret, ret)
  return result
end
