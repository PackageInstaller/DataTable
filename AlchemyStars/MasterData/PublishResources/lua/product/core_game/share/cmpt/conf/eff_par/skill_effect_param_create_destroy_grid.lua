require("skill_effect_param_base")
_class("SkillEffectParam_CreateDestroyGrid", SkillEffectParamBase)
SkillEffectParam_CreateDestroyGrid = SkillEffectParam_CreateDestroyGrid

function SkillEffectParam_CreateDestroyGrid:Constructor(t)
  self._isCreate = t.isCreate or false
end

function SkillEffectParam_CreateDestroyGrid:GetEffectType()
  return SkillEffectType.CreateDestroyGrid
end

function SkillEffectParam_CreateDestroyGrid:GetIsCreate()
  return self._isCreate
end
