_class("SkillEffectResultSetGridMaintainColorForSupply", SkillEffectResultBase)
SkillEffectResultSetGridMaintainColorForSupply = SkillEffectResultSetGridMaintainColorForSupply

function SkillEffectResultSetGridMaintainColorForSupply:Constructor(posList, maintainColor)
  self._posList = posList
  self._maintainColor = maintainColor
end

function SkillEffectResultSetGridMaintainColorForSupply:GetEffectType()
  return SkillEffectType.SetGridMaintainColorForSupply
end

function SkillEffectResultSetGridMaintainColorForSupply:GetPosList()
  return self._posList
end

function SkillEffectResultSetGridMaintainColorForSupply:GetMaintainColor()
  return self._maintainColor
end
