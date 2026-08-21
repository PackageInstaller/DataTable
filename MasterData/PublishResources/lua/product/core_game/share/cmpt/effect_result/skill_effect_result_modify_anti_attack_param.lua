require("skill_effect_result_base")
_class("SkillEffectResultModifyAntiAttackParam", SkillEffectResultBase)
SkillEffectResultModifyAntiAttackParam = SkillEffectResultModifyAntiAttackParam

function SkillEffectResultModifyAntiAttackParam:Constructor(casterEntityID, modifyType, newValue)
  self._casterEntityID = casterEntityID
  self._modifyType = modifyType
  self._newValue = newValue
end

function SkillEffectResultModifyAntiAttackParam:GetEffectType()
  return SkillEffectType.ModifyAntiAttackParam
end

function SkillEffectResultModifyAntiAttackParam:GetCasterEntityID()
  return self._casterEntityID
end

function SkillEffectResultModifyAntiAttackParam:GetModifyType()
  return self._modifyType
end

function SkillEffectResultModifyAntiAttackParam:GetNewValue()
  return self._newValue
end
