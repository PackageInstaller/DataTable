require("scope_base")
_class("SkillScopeCalculator_NearestOneByOne", SkillScopeCalculator_Base)
SkillScopeCalculator_NearestOneByOne = SkillScopeCalculator_NearestOneByOne

function SkillScopeCalculator_NearestOneByOne:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  if not self._gridFilter._world then
    return SkillScopeResult:New(SkillScopeType.NearestOneByOne, {}, {}, {})
  end
  local targetCount = scopeParam[1]
  local world = self._gridFilter._world
  local calc = SkillScopeCalculator:New(self._hub._gridFilter)
  local platformScopeResult = calc:ComputeScopeRange(SkillScopeType.FullScreen, 1, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local targetSelector = world:GetSkillScopeTargetSelector()
  local targetArrray = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.NearestMonsterOneByOne, platformScopeResult, nil, {targetCount})
  local monsterPosList = {}
  for i, id in ipairs(targetArrray) do
    local entity = self._gridFilter._world:GetEntityByID(id)
    local bodyAreaCmpt = entity:BodyArea()
    local pos = entity:GetGridPosition()
    local areaArray = bodyAreaCmpt:GetArea()
    for _, area in ipairs(areaArray) do
      table.insert(monsterPosList, Vector2(pos.x + area.x, pos.y + area.y))
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.NearestOneByOne, centerPos, monsterPosList, monsterPosList, targetArrray)
  return result
end
