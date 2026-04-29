require("scope_base")
_class("SkillScopeCalculator_ScopeHPLessThanFirstPickPos", SkillScopeCalculator_Base)
SkillScopeCalculator_ScopeHPLessThanFirstPickPos = SkillScopeCalculator_ScopeHPLessThanFirstPickPos

function SkillScopeCalculator_ScopeHPLessThanFirstPickPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local cfgHPPercent = scopeParam[1] or 1
  local opType = scopeParam[2] or 5
  local world = self._gridFilter._world
  local cross_area = {}
  local gridPosList = {}
  if casterEntity and casterEntity:HasAttributes() then
    local battleSvc = world:GetService("Battle")
    local curHP, maxHP = battleSvc:GetCasterHP(casterEntity)
    local hpPercent = math.modf(curHP / maxHP * 100)
    local battleSvc = world:GetService("Battle")
    local compareResult = battleSvc:Compare2Num(hpPercent, cfgHPPercent, opType)
    if compareResult then
      if #centerPos == 0 then
        centerPos = {centerPos}
      end
      cross_area = {
        centerPos[1]
      }
      gridPosList = {
        centerPos[1]
      }
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.HPLessThanFirstPickPos, centerPos, cross_area, cross_area)
  return result
end
