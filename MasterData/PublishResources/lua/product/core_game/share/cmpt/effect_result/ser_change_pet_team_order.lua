require("skill_effect_result_base")
_class("SkillEffectResult_ChangePetTeamOrder", SkillEffectResultBase)
SkillEffectResult_ChangePetTeamOrder = SkillEffectResult_ChangePetTeamOrder

function SkillEffectResult_ChangePetTeamOrder:Constructor(targetID, oldTeamOrder, teamOrder)
  self._targetEntityID = targetID
  self._oldTeamOrder = oldTeamOrder
  self._teamOrder = teamOrder
end

function SkillEffectResult_ChangePetTeamOrder:GetEffectType()
  return SkillEffectType.ChangePetTeamOrder
end

function SkillEffectResult_ChangePetTeamOrder:GetTargetEntityID()
  return self._targetEntityID
end

function SkillEffectResult_ChangePetTeamOrder:GetOldTeamOrder()
  return self._oldTeamOrder
end

function SkillEffectResult_ChangePetTeamOrder:GetNewTeamOrder()
  return self._teamOrder
end
