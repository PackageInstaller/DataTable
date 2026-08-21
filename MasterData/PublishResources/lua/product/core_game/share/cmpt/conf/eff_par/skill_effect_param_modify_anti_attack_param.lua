require("skill_effect_param_base")
_class("SkillEffectParamModifyAntiAttackParam", SkillEffectParamBase)
SkillEffectParamModifyAntiAttackParam = SkillEffectParamModifyAntiAttackParam

function SkillEffectParamModifyAntiAttackParam:Constructor(t)
  self._modifyType = t.modifyType
  self._modifyParam = t.modifyParam
end

function SkillEffectParamModifyAntiAttackParam:GetEffectType()
  return SkillEffectType.ModifyAntiAttackParam
end

function SkillEffectParamModifyAntiAttackParam:GetModifyType()
  return self._modifyType
end

function SkillEffectParamModifyAntiAttackParam:GetModifyParam()
  return self._modifyParam
end

local ModifyAntiAttackParamType = {
  WaitActiveSkillCount = 1,
  AntiSkillCountCurRound = 2,
  AntiSkillEnabled = 3,
  MAX = 999
}
_enum("ModifyAntiAttackParamType", ModifyAntiAttackParamType)
