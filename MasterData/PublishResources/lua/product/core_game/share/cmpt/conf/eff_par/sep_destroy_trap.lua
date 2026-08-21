require("skill_damage_effect_param")
_class("SkillEffectDestroyTrapParam", SkillEffectParamBase)
SkillEffectDestroyTrapParam = SkillEffectDestroyTrapParam

function SkillEffectDestroyTrapParam:Constructor(t)
  self._trapID = {}
  if t.trapID then
    for _, id in ipairs(t.trapID) do
      self._trapID[id] = true
    end
  end
  self._protectTrapID = {}
  if t.protectTrapID then
    for _, id in ipairs(t.protectTrapID) do
      self._protectTrapID[id] = true
    end
  end
  self._trapType = {}
  if t.trapType then
    for _, id in ipairs(t.trapType) do
      self._trapType[id] = true
    end
  end
  self._destroyType = t.destroyType or SkillEffectDestroyTrapType.Range
  self._disableDieSkill = t.disableDieSkill
  self._special = t.special or 0
  self._stageIndex = t.stageIndex or 1
end

function SkillEffectDestroyTrapParam:GetEffectType()
  return SkillEffectType.DestroyTrap
end

function SkillEffectDestroyTrapParam:IsDestroyTrap(trapID)
  return self._trapID[trapID]
end

function SkillEffectDestroyTrapParam:IsDestroyTrapWithType(trapType)
  return self._trapType[trapType]
end

function SkillEffectDestroyTrapParam:IsProtectTrap(trapID)
  return self._protectTrapID[trapID]
end

function SkillEffectDestroyTrapParam:GetDestroyType()
  return self._destroyType
end

function SkillEffectDestroyTrapParam:GetDisableDieSkill()
  return self._disableDieSkill
end

function SkillEffectDestroyTrapParam:GetSpecial()
  return self._special
end

function SkillEffectDestroyTrapParam:GetStageIndex()
  return self._stageIndex
end

local SkillEffectDestroyTrapType = {
  Self = 1,
  Other = 2,
  Range = 3,
  RangeExceptConfig = 4,
  Sticker = 5,
  RangeSelectTrapType = 6,
  MySummonTrap = 7,
  RangeAll = 8,
  SelfSummonDone = 9,
  HitBackRange = 10
}
_enum("SkillEffectDestroyTrapType", SkillEffectDestroyTrapType)
