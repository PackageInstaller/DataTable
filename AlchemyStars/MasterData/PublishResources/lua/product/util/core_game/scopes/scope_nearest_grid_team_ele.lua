require("scope_base")
_class("SkillScopeCalculator_NearestGridTeamElement", SkillScopeCalculator_Base)
SkillScopeCalculator_NearestGridTeamElement = SkillScopeCalculator_NearestGridTeamElement

function SkillScopeCalculator_NearestGridTeamElement:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local param = scopeParam
  local teamEntity = self._gridFilter._world:Player():GetCurrentTeamEntity()
  local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
  local realCenterPos = teamLeader:GetGridPosition()
  local gridCount = param.gridCount or 0
  local girdTypeList = {}
  table.insert(girdTypeList, teamLeader:Element():GetPrimaryType())
  local pieceList = self._gridFilter:FindPieceElementByTypeCountAndCenter(realCenterPos, girdTypeList, gridCount, {}, {})
  local result = SkillScopeResult:New(SkillScopeType.NearestGridTeamElement, casterPos, pieceList, pieceList)
  return result
end
