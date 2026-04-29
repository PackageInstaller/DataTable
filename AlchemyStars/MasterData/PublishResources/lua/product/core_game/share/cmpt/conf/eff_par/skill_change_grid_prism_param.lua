_class("SkillChangeGridPrismParam", SkillEffectParamBase)
SkillChangeGridPrismParam = SkillChangeGridPrismParam

function SkillChangeGridPrismParam:Constructor(t)
  self._change = t.change
  self._gridEffectType = t.gridEffectType or PieceEffectType.Prism
end

function SkillChangeGridPrismParam:GetEffectType()
  return SkillEffectType.ChangeGridPrism
end

function SkillChangeGridPrismParam:GetChangeType()
  return self._change
end

function SkillChangeGridPrismParam:GetGridEffectType()
  return self._gridEffectType
end
