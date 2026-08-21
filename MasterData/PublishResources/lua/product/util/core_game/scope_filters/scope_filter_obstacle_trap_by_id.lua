require("trap_type")
require("scope_filter_base")
_class("SkillScopeFilter_ObstacleTrapByID", SkillScopeFilter_Base)
SkillScopeFilter_ObstacleTrapByID = SkillScopeFilter_ObstacleTrapByID

function SkillScopeFilter_ObstacleTrapByID:DoModifyRange(scopeResult, filterParam, passParam)
  local world = passParam._world
  local utilSvc = world:GetService("UtilData")
  local obstacledPosArray = {}
  local obstructTrapIDList = filterParam:GetObstructingTrapByIDFilter()
  local wholeGridRange = scopeResult:GetWholeGridRange()
  for _, gridPos in ipairs(wholeGridRange) do
    local trapsEntityAtPos = utilSvc:GetTrapsAtPos(gridPos)
    for _, entity in ipairs(trapsEntityAtPos) do
      local trapComponent = entity:Trap()
      if trapComponent then
        local trapID = trapComponent:GetTrapID()
        local isObstruct = table.icontains(obstructTrapIDList, trapID)
        if isObstruct then
          table.insert(obstacledPosArray, gridPos)
        end
      end
    end
  end
  local isInclude = filterParam:GetObstructingTrapByIDFilter() == 1
  if isInclude then
    self:AddPosToScopeResult(scopeResult, obstacledPosArray)
  else
    self:RemovePosFromScopeResult(scopeResult, obstacledPosArray)
  end
end
