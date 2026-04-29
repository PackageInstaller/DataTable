require("trap_type")
require("scope_filter_base")
_class("SkillScopeFilter_ObstacleTrap", SkillScopeFilter_Base)
SkillScopeFilter_ObstacleTrap = SkillScopeFilter_ObstacleTrap

function SkillScopeFilter_ObstacleTrap:DoModifyRange(scopeResult, filterParam, passParam)
  local world = passParam._world
  local utilSvc = world:GetService("UtilData")
  local configService = world:GetService("Config")
  local obstacledPosArray = {}
  local obstructTrapTypeList = filterParam:GetObstructingTrapFilter()
  local wholeGridRange = scopeResult:GetWholeGridRange()
  for _, gridPos in ipairs(wholeGridRange) do
    local trapsEntityAtPos = utilSvc:GetTrapsAtPos(gridPos)
    for _, entity in ipairs(trapsEntityAtPos) do
      local trapComponent = entity:Trap()
      if trapComponent then
        local trapID = trapComponent:GetTrapID()
        local trapConfigData = configService:GetTrapConfigData()
        local trapData = trapConfigData:GetTrapData(trapID)
        local curTrapType = trapData.TrapType
        local isObstruct = table.icontains(obstructTrapTypeList, curTrapType)
        if isObstruct then
          table.insert(obstacledPosArray, gridPos)
        end
      end
    end
  end
  local isInclude = filterParam:GetObstructingTrapFilter() == 1
  if isInclude then
    self:AddPosToScopeResult(scopeResult, obstacledPosArray)
  else
    self:RemovePosFromScopeResult(scopeResult, obstacledPosArray)
  end
end
