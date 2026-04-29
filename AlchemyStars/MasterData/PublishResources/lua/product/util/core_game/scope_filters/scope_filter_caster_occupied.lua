require("scope_filter_base")
_class("SkillScopeFilter_CasterOccupied", SkillScopeFilter_Base)
SkillScopeFilter_CasterOccupied = SkillScopeFilter_CasterOccupied

function SkillScopeFilter_CasterOccupied:DoModifyRange(scopeResult, filterParam, passParam)
  local casterOccupiedPosArray = {}
  local casterPos = passParam:GetCasterPos()
  local bodyAreaArray = passParam:GetCasterBodyAreaArray()
  if bodyAreaArray then
    for _, areaPos in ipairs(bodyAreaArray) do
      table.insert(casterOccupiedPosArray, areaPos + casterPos)
    end
  else
    table.insert(casterOccupiedPosArray, casterPos)
  end
  local isInclude = filterParam:GetCasterOccupiedPosFilter() == 1
  if isInclude then
    self:AddPosToScopeResult(scopeResult, casterOccupiedPosArray)
  else
    self:RemovePosFromScopeResult(scopeResult, casterOccupiedPosArray)
  end
end
