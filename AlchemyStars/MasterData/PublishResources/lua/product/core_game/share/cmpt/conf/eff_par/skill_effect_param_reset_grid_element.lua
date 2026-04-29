require("skill_effect_param_base")
_class("SkillEffectParam_ResetGridElement", SkillEffectParamBase)
SkillEffectParam_ResetGridElement = SkillEffectParam_ResetGridElement

function SkillEffectParam_ResetGridElement:Constructor(t)
  self._element = t.element
  self._percent = t.percent
  self._convertGray = t.convertGray
  if t.flushTrap == nil then
    self._flushTrap = true
  else
    self._flushTrap = t.flushTrap
  end
  self._ignoreBlock = t.ignoreBlock
  local protectElementArray = t.protectElementType or {}
  self._protectElementType = {}
  for _, pieceType in ipairs(protectElementArray) do
    self._protectElementType[pieceType] = true
  end
  self._excludeTrapIDList = t.excludeTrapIDList or {}
  self._excludeRangColor = t.excludeRangeColor or false
  self._targetGridTypeList = t.targetGridTypeList or {
    1,
    2,
    3,
    4
  }
  self._resetTrapId = t.resetTrapId
  self._targetElement = t.targetElement
  self._targetElementProb = t.targetElementProb
  self._ignoreLockSeed = t.ignoreLockSeed or false
end

function SkillEffectParam_ResetGridElement:GetResetTrapId()
  return self._resetTrapId
end

function SkillEffectParam_ResetGridElement:GetTargetElement()
  return self._targetElement
end

function SkillEffectParam_ResetGridElement:GetTargetElementProb()
  return self._targetElementProb
end

function SkillEffectParam_ResetGridElement:GetEffectType()
  return SkillEffectType.ResetGridElement
end

function SkillEffectParam_ResetGridElement:GetElement()
  return self._element
end

function SkillEffectParam_ResetGridElement:GetPercent()
  return self._percent
end

function SkillEffectParam_ResetGridElement:GetConvertGray()
  return self._convertGray
end

function SkillEffectParam_ResetGridElement:GetCanFlushTrap()
  return self._flushTrap
end

function SkillEffectParam_ResetGridElement:GetProtectElementType()
  return self._protectElementType
end

function SkillEffectParam_ResetGridElement:GetExcludeTrapIDList()
  return self._excludeTrapIDList
end

function SkillEffectParam_ResetGridElement:GetExcludeRangeColor()
  return self._excludeRangColor
end

function SkillEffectParam_ResetGridElement:GetTargetGridTypeList()
  return self._targetGridTypeList
end

function SkillEffectParam_ResetGridElement:GetIgnoreBlock()
  return self._ignoreBlock
end

function SkillEffectParam_ResetGridElement:GetIgnoreLockSeed()
  return self._ignoreLockSeed
end
