require("skill_effect_result_base")
_class("SkillEffectResult_AddDimensionFlag", SkillEffectResultBase)
SkillEffectResult_AddDimensionFlag = SkillEffectResult_AddDimensionFlag

function SkillEffectResult_AddDimensionFlag:GetEffectType()
  return SkillEffectType.AddDimensionFlag
end

function SkillEffectResult_AddDimensionFlag:Constructor(eTeamId)
  self._eTeamId = eTeamId
end

function SkillEffectResult_AddDimensionFlag:GetTeamEntityId()
  return self._eTeamId
end
