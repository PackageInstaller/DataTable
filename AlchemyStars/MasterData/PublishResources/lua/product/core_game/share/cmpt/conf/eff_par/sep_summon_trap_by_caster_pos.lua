require("skill_effect_param_base")
_class("SkillEffectParamSummonTrapByCasterPos", SkillEffectParamBase)
SkillEffectParamSummonTrapByCasterPos = SkillEffectParamSummonTrapByCasterPos

function SkillEffectParamSummonTrapByCasterPos:Constructor(t)
  self._rangeAndCount = t.rangeAndCount
  self._trapID = t.trapID
  self:ParseConfig()
end

function SkillEffectParamSummonTrapByCasterPos:ParseConfig()
  for i, param in ipairs(self._rangeAndCount) do
    local range = param.range
    param.vectorRange = {}
    for _, v in ipairs(range) do
      local pos = Vector2(v[1], v[2])
      table.insert(param.vectorRange, pos)
    end
  end
end

function SkillEffectParamSummonTrapByCasterPos:GetEffectType()
  return SkillEffectType.SummonTrapByCasterPos
end

function SkillEffectParamSummonTrapByCasterPos:GetTrapID()
  return self._trapID
end

function SkillEffectParamSummonTrapByCasterPos:GetRangeAndCount()
  return self._rangeAndCount
end

function SkillEffectParamSummonTrapByCasterPos:GetMinCount()
  return self._minCount
end

function SkillEffectParamSummonTrapByCasterPos:GetMaxCount()
  return self._minCount
end
