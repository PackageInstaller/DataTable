require("scope_base")
_class("SkillScopeCalculator_SelectPieceByTrapID", SkillScopeCalculator_Base)
SkillScopeCalculator_SelectPieceByTrapID = SkillScopeCalculator_SelectPieceByTrapID

function SkillScopeCalculator_SelectPieceByTrapID:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local world = self._gridFilter._world
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  local tEntityTrap = trapGroup:GetEntities()
  local tPosTrap = {}
  for _, eTrap in ipairs(tEntityTrap) do
    if table.icontains(scopeParam, eTrap:Trap():GetTrapID()) and not eTrap:HasDeadMark() then
      local v2GridLocation = eTrap:GetGridPosition()
      local cBodyArea = eTrap:BodyArea()
      local tv2RelativeBody = cBodyArea:GetArea()
      for _, v2Relative in ipairs(tv2RelativeBody) do
        table.insert(tPosTrap, v2Relative + v2GridLocation)
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SelectPieceByTrapID, centerPos, tPosTrap, tPosTrap)
  return result
end
