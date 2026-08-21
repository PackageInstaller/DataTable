require("scope_base")
_class("SkillScopeCalculator_AllTrapGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_AllTrapGrid = SkillScopeCalculator_AllTrapGrid

function SkillScopeCalculator_AllTrapGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not scopeParam then
    Log.fatal("### scopeParam is nil. centerPos=", centerPos)
    return
  end
  local world = self._gridFilter._world
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  local tEntityTrap = trapGroup:GetEntities()
  local tPosTrap = {}
  for _, eTrap in ipairs(tEntityTrap) do
    local v2GridLocation = eTrap:GetGridPosition()
    local cBodyArea = eTrap:BodyArea()
    local tv2RelativeBody = cBodyArea:GetArea()
    for _, v2Relative in ipairs(tv2RelativeBody) do
      table.insert(tPosTrap, v2Relative + v2GridLocation)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.AllTrapGrid, centerPos, tPosTrap, tPosTrap)
  return result
end
