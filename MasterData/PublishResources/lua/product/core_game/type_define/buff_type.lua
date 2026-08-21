BuffType = {
  Control = 1,
  DOT = 2,
  Positive = 3,
  Negative = 4,
  Team = 5,
  Logic = 6,
  PopStarStage = 7
}
local ModifySkillIncreaseParamType = {
  NormalSkill = 1,
  ChainSkill = 2,
  ActiveSkill = 3,
  MonsterDamage = 4,
  TrapDamage = 5,
  CampSkill = 6,
  AutoBeadSkill = 7
}
_enum("ModifySkillIncreaseParamType", ModifySkillIncreaseParamType)
local ModifySkillParamType = {
  NormalSkill = 1,
  ChainSkill = 2,
  ActiveSkill = 3,
  MonsterDamage = 4,
  SanSkill = 5,
  CampSkill = 6,
  AutoBeadSkill = 7
}
_enum("ModifySkillParamType", ModifySkillParamType)
local MonsterSkillAbsorbType = {
  NormalSkill = 1,
  ChainSkill = 2,
  ActiveSkill = 3
}
_enum("MonsterSkillAbsorbType", MonsterSkillAbsorbType)
local ModifyBaseDefenceType = {
  "Defense",
  "DefencePercentage",
  "DefenceConstantFix"
}
_autoEnum("ModifyBaseDefenceType", ModifyBaseDefenceType)
local ModifyBaseAttackType = {
  "Attack",
  "AttackPercentage",
  "AttackConstantFix"
}
_autoEnum("ModifyBaseAttackType", ModifyBaseAttackType)
local BuffSourceType = {
  "Buff",
  "PassiveSkill",
  "SkillIntensify",
  "EquipRefine",
  "Skill",
  "Feature"
}
_autoEnum("BuffSourceType", BuffSourceType)
local ModifyBaseMaxHPType = {
  "MaxHPPercentage",
  "MaxHPConstantFix"
}
_autoEnum("ModifyBaseMaxHPType", ModifyBaseMaxHPType)
_class("BuffSource", Object)
BuffSource = BuffSource

function BuffSource:Constructor(sourceType, sourceID)
  self._sourceType = sourceType
  self._sourceID = sourceID
end

function BuffSource:IsMe(sourceType, sourceID)
  if self._sourceType and self._sourceType == sourceType and self._sourceID and self._sourceID == sourceID then
    return true
  end
  return false
end

function BuffSource:GetSourceType()
  return self._sourceType
end

function BuffSource:GetSourceID()
  return self._sourceID
end

function BuffSource.__eq(a, b)
  if a._sourceType and b._sourceType and a._sourceType == b._sourceType and a._sourceID and b._sourceID and a._sourceID == b._sourceID then
    return true
  end
  return false
end

_class("BuffIntensifyParam", Object)
BuffIntensifyParam = BuffIntensifyParam

function BuffIntensifyParam:Constructor()
  self.BuffID = nil
  self.value = nil
  self.isShow = true
  self.type = 1
  self.key = BuffIntensifyParamKey:New()
end

_class("BuffIntensifyParamKey", Object)
BuffIntensifyParamKey = BuffIntensifyParamKey

function BuffIntensifyParamKey:Constructor()
  self.LogicType = nil
  self.LogicIndex = nil
  self.param = nil
  self.paramIndex = nil
  self.TriggerType = nil
  self.TriggerIndex = nil
  self.TriggerParamIndex = nil
end
