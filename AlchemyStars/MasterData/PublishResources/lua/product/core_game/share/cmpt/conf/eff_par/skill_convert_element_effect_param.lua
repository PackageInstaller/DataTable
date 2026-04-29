require("skill_effect_param_base")
_class("SkillConvertGridElementEffectParam", SkillEffectParamBase)
SkillConvertGridElementEffectParam = SkillConvertGridElementEffectParam

function SkillConvertGridElementEffectParam:Constructor(t)
  self._sourceGridElement = t.src
  self._targetGridElement = t.target
  self._targetCount = t.count
  self._random = t.random or false
  self._ignoreBlock = t.ignoreBlock or false
  self._legendPowerCount = t.legendPowerCount or 0
  self._convertToCasterElement = t.convertToCasterElement or false
  self._convertToTeamLeaderElement = t.convertToTeamLeaderElement or false
  self._useTeamElementCount = t.useTeamElementCount or false
  self._saveTetrisIndex = t.saveTetrisIndex or false
end

function SkillConvertGridElementEffectParam:GetEffectType()
  return SkillEffectType.ConvertGridElement
end

function SkillConvertGridElementEffectParam:GetSourceGridElement()
  return self._sourceGridElement
end

function SkillConvertGridElementEffectParam:GetTargetGridElement()
  return self._targetGridElement
end

function SkillConvertGridElementEffectParam:GetTargetGridElementCount()
  return self._targetCount
end

function SkillConvertGridElementEffectParam:NeedRandom()
  return self._random
end

function SkillConvertGridElementEffectParam:IsIgnoreBlock()
  return self._ignoreBlock
end

function SkillConvertGridElementEffectParam:GetLegendPowerCount()
  return self._legendPowerCount
end

function SkillConvertGridElementEffectParam:IsConvertToCasterElement()
  return self._convertToCasterElement
end

function SkillConvertGridElementEffectParam:IsConvertToTeamLeaderElement()
  return self._convertToTeamLeaderElement
end

function SkillConvertGridElementEffectParam:IsUseTeamElementCount()
  return self._useTeamElementCount
end

function SkillConvertGridElementEffectParam:IsSaveTetrisIndex()
  return self._saveTetrisIndex
end
