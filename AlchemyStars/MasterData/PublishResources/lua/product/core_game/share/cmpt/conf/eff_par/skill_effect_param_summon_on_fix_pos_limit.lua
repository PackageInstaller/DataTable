require("skill_effect_param_base")
_class("SkillEffectParamSummonOnFixPosLimit", SkillEffectParamBase)
SkillEffectParamSummonOnFixPosLimit = SkillEffectParamSummonOnFixPosLimit

function SkillEffectParamSummonOnFixPosLimit:Constructor(t)
  self._trapID = t.trapID
  self._posList = {}
  for i, v in ipairs(t.pos) do
    table.insert(self._posList, Vector2(v[1], v[2]))
  end
  self._summonCount = t.summonCount
  self._limitCount = t.limitCount
  self._ignoreBlock = t.ignoreBlock or false
end

function SkillEffectParamSummonOnFixPosLimit:GetEffectType()
  return SkillEffectType.SummonOnFixPosLimit
end

function SkillEffectParamSummonOnFixPosLimit:GetTrapID()
  return self._trapID
end

function SkillEffectParamSummonOnFixPosLimit:IgnoreBlock()
  return self._ignoreBlock
end

function SkillEffectParamSummonOnFixPosLimit:GetLimitCount()
  return self._limitCount
end

function SkillEffectParamSummonOnFixPosLimit:GetSummonCount()
  return self._summonCount
end

function SkillEffectParamSummonOnFixPosLimit:GetFixPosList()
  return self._posList
end
