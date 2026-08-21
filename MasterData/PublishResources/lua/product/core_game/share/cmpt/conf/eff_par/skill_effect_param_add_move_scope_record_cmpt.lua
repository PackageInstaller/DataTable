require("skill_effect_param_base")
_class("SkillEffectParam_AddMoveScopeRecordCmpt", SkillEffectParamBase)
SkillEffectParam_AddMoveScopeRecordCmpt = SkillEffectParam_AddMoveScopeRecordCmpt

function SkillEffectParam_AddMoveScopeRecordCmpt:Constructor(t)
  self._bSetOff = t.setOff and t.setOff == 1 or false
end

function SkillEffectParam_AddMoveScopeRecordCmpt:GetEffectType()
  return SkillEffectType.AddMoveScopeRecordCmpt
end
