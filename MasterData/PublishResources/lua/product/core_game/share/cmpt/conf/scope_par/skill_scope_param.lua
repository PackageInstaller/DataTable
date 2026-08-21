_class("SkillNRowsMColumnsScopeParam", Object)
SkillNRowsMColumnsScopeParam = SkillNRowsMColumnsScopeParam

function SkillNRowsMColumnsScopeParam:Constructor(rows, columns, scopeCenterParam)
  self._rows = rows
  self._columns = columns
  self._scopeCenterParam = scopeCenterParam
end

function SkillNRowsMColumnsScopeParam:GetSkillScopeRows()
  return self._rows
end

function SkillNRowsMColumnsScopeParam:GetSkillScopeColumns()
  return self._columns
end

function SkillNRowsMColumnsScopeParam:GetScopeCenterParam()
  return self._scopeCenterParam
end
