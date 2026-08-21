SkillEffect_WeikeNotify_CompanionType = {
  TypeA = 1,
  TypeB = 2,
  TypeC = 3
}
_enum("SkillEffect_WeikeNotify_CompanionType", SkillEffect_WeikeNotify_CompanionType)
SkillEffect_WeikeNotify_SkillType = {
  NormalSkill = 1,
  ChainSkill1 = 2,
  ChainSkill2 = 3,
  ChainSkill3 = 4,
  ActiveSkill = 5
}
_enum("SkillEffect_WeikeNotify_SkillType", SkillEffect_WeikeNotify_SkillType)
_class("SkillEffectParam_WeikeNotify", SkillEffectParamBase)
SkillEffectParam_WeikeNotify = SkillEffectParam_WeikeNotify

function SkillEffectParam_WeikeNotify:GetEffectType()
  return SkillEffectType.WeikeNotify
end

function SkillEffectParam_WeikeNotify:Constructor(t, petId, effectIndex, skillType, grade, awaking)
  self._companionType = t.companionType
  self._skillType = t.skillType
end

function SkillEffectParam_WeikeNotify:GetCompanionType()
  return self._companionType
end

function SkillEffectParam_WeikeNotify:GetSkillType()
  return self._skillType
end
