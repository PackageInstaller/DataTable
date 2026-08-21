require("skill_effect_result_base")
_class("SkillEffectResult_SwapPetTeamOrder", SkillEffectResultBase)
SkillEffectResult_SwapPetTeamOrder = SkillEffectResult_SwapPetTeamOrder

function SkillEffectResult_SwapPetTeamOrder:Constructor(targetEntityId, oldTeamOrder, teamOrder)
  self._targetEntityId = targetEntityId
  self._oldTeamOrder = oldTeamOrder
  self._teamOrder = teamOrder
end

function SkillEffectResult_SwapPetTeamOrder:GetEffectType()
  return SkillEffectType.SwapPetTeamOrder
end

function SkillEffectResult_SwapPetTeamOrder:GetOldTeamOrder()
  return self._oldTeamOrder
end

function SkillEffectResult_SwapPetTeamOrder:GetNewTeamOrder()
  return self._teamOrder
end

function SkillEffectResult_SwapPetTeamOrder:GetTargetEntityID()
  return self._targetEntityId
end
