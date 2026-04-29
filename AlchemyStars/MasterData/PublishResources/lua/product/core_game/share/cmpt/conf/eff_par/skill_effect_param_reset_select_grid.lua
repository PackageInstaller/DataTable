require("skill_effect_param_base")
_class("SkillEffectParam_ResetSelectGridElement", SkillEffectParam_ResetGridElement)
SkillEffectParam_ResetSelectGridElement = SkillEffectParam_ResetSelectGridElement

function SkillEffectParam_ResetSelectGridElement:Constructor(t)
  self._selectCondition = t.selectCondition
end

function SkillEffectParam_ResetSelectGridElement:GetEffectType()
  return SkillEffectType.ResetSelectGridElement
end

function SkillEffectParam_ResetSelectGridElement:GetSelectConditionSrcElement()
  if self._selectCondition ~= nil then
    return self._selectCondition.srcElement
  end
end
