_class("SkillScopeFilterPassParam", Object)
SkillScopeFilterPassParam = SkillScopeFilterPassParam

function SkillScopeFilterPassParam:Constructor(t)
  self._casterPos = t.casterPos
  self._casterBodyAreaArray = t.casterBodyAreaArray
  self._world = t.world
end

function SkillScopeFilterPassParam:GetCasterPos()
  return self._casterPos
end

function SkillScopeFilterPassParam:GetCasterBodyAreaArray()
  return self._casterBodyAreaArray
end

function SkillScopeFilterPassParam:GetWorld()
  return self._world
end
