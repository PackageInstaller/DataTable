_class("SkillScopeFilterParam", Object)
SkillScopeFilterParam = SkillScopeFilterParam

function SkillScopeFilterParam:Constructor(t)
  self._scopeCasterOccupiedFilter = t.scopeCasterOccupiedFilter
  self._scopeObstructingTrapFilter = t.obstructingTrapFilter
  self._scopeObstructingTrapByIDFilter = t.obstructingTrapByIDFilter
  self._scopeMonsterOccupiedFilter = t.monsterOccupiedPosFilter
  self._targetSelectionMode = t.targetSelectionMode or SkillTargetSelectionMode.Grid
  self._default = false
end

function SkillScopeFilterParam.GenerateDefaultParam()
  local p = SkillScopeFilterParam:New({})
  p:SetDefaultFlag()
  return p
end

function SkillScopeFilterParam:GetCasterOccupiedPosFilter()
  return self._scopeCasterOccupiedFilter
end

function SkillScopeFilterParam:GetObstructingTrapByIDFilter()
  return self._scopeObstructingTrapByIDFilter
end

function SkillScopeFilterParam:GetObstructingTrapFilter()
  return self._scopeObstructingTrapFilter
end

function SkillScopeFilterParam:GetMonsterOccupiedPosFilter()
  return self._scopeMonsterOccupiedFilter
end

function SkillScopeFilterParam:GetTargetSelectionMode()
  return self._targetSelectionMode
end

function SkillScopeFilterParam:IsDefault()
  return self._default
end

function SkillScopeFilterParam:SetDefaultFlag()
  self._default = true
end
