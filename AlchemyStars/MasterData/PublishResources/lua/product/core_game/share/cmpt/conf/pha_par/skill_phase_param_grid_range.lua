require("skill_phase_param_base")
local SkillPhaseParam_GridRange_SortCenterType = {
  CasterPos = 0,
  CasterX = 1,
  CasterY = 2,
  User = 3
}
_enum("SkillPhaseParam_GridRange_SortCenterType", SkillPhaseParam_GridRange_SortCenterType)
_class("SkillPhaseParam_GridRange", SkillPhaseParamBase)
SkillPhaseParam_GridRange = SkillPhaseParam_GridRange

function SkillPhaseParam_GridRange:Constructor(t)
  self._scopeCenterType = t.scopeCenterType
  self._scopeType = t.scopeType
  self._scopeParam = t.scopeParam
  self._targetType = t.targetType or SkillTargetType.Pet
  self._sortCenterType = t.sortCenterType
  self._sortCenterPos = t.sortCenterPos
  self._groupIntervalTime = t.groupIntervalTime
  self._gridEffectID = t.gridEffectID
  self._gridIntervalTime = t.gridIntervalTime
  self._hasConvert = t.hasConvert
  self._bestConvertTime = t.bestConvertTime
  self._damageIndex = t.damageIndex
  self._hitAnimationName = t.hitAnimationName
  self._hitEffectID = t.hitEffectID
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseParam_GridRange:GetCacheTable()
  local listID = {}
  self:AddEffectIDToListID(listID, self._gridEffectID)
  self:AddEffectIDToListID(listID, self._hitEffectID)
  return self:GetCacheTableFromListID(listID)
end

function SkillPhaseParam_GridRange:GetPhaseType()
  return SkillViewPhaseType.GridRangeEffect
end

function SkillPhaseParam_GridRange:GetGroupIntervalTime()
  return self._groupIntervalTime
end

function SkillPhaseParam_GridRange:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseParam_GridRange:GetGridIntervalTime()
  return self._gridIntervalTime
end

function SkillPhaseParam_GridRange:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseParam_GridRange:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseParam_GridRange:HasDamage()
  if self._damageIndex then
    return self._damageIndex > 0
  else
    return false
  end
end

function SkillPhaseParam_GridRange:GetDamageIndex()
  return self._damageIndex
end

function SkillPhaseParam_GridRange:HasConvert()
  if self._hasConvert then
    return self._hasConvert == 1
  else
    return false
  end
end

function SkillPhaseParam_GridRange:GetGridEffectTime()
  return self._gridEffectTime
end

function SkillPhaseParam_GridRange:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseParam_GridRange:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseParam_GridRange:GetScopeCenterType()
  return self._scopeCenterType
end

function SkillPhaseParam_GridRange:GetScapeType()
  return self._scopeType
end

function SkillPhaseParam_GridRange:GetScapeParam()
  return self._scopeParam
end

function SkillPhaseParam_GridRange:GetSortCenterType()
  return self._sortCenterType
end

function SkillPhaseParam_GridRange:GetSortCenterPos()
  return self._sortCenterPos
end

function SkillPhaseParam_GridRange:GetTargetType()
  return self._targetType
end
