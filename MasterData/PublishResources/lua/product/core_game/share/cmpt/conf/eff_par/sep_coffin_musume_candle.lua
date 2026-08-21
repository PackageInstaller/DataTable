require("skill_damage_effect_param")
_class("SkillEffectParam_CoffinMusumeCandle", SkillEffectParamBase)
SkillEffectParam_CoffinMusumeCandle = SkillEffectParam_CoffinMusumeCandle

function SkillEffectParam_CoffinMusumeCandle:Constructor(t, petId, effectIndex, skillType, grade, awaking)
  self._trapID = t.trapID
  self._stage1Count = t.stage1Count
  self._stage1Param = t.stage1Param
  self._stage2Count = t.stage2Count
  self._stage2Param = t.stage2Param
  self._stage3Param = t.stage3Param
  if t.stage1DamageParam then
    self._stage1DamageParam = SkillDamageEffectParam:New(t.stage1DamageParam)
  end
  if t.stage2DamageParam then
    self._stage2DamageParam = SkillDamageEffectParam:New(t.stage2DamageParam)
  end
  if t.stage3DamageParam then
    self._stage3DamageParam = SkillDamageEffectParam:New(t.stage3DamageParam)
  end
end

function SkillEffectParam_CoffinMusumeCandle:GetEffectType()
  return SkillEffectType.CoffinMusumeCandle
end

function SkillEffectParam_CoffinMusumeCandle:GetTrapID()
  return self._trapID
end

function SkillEffectParam_CoffinMusumeCandle:GetStage1Count()
  return self._stage1Count
end

function SkillEffectParam_CoffinMusumeCandle:GetStage1Param()
  return self._stage1Param
end

function SkillEffectParam_CoffinMusumeCandle:GetStage2Count()
  return self._stage2Count
end

function SkillEffectParam_CoffinMusumeCandle:GetStage2Param()
  return self._stage2Param
end

function SkillEffectParam_CoffinMusumeCandle:GetStage3Param()
  return self._stage3Param
end

function SkillEffectParam_CoffinMusumeCandle:GetStage1DamageParam()
  return self._stage1DamageParam
end

function SkillEffectParam_CoffinMusumeCandle:GetStage2DamageParam()
  return self._stage2DamageParam
end

function SkillEffectParam_CoffinMusumeCandle:GetStage3DamageParam()
  return self._stage3DamageParam
end
