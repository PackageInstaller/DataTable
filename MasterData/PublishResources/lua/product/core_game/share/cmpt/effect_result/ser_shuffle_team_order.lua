require("skill_effect_result_base")
_class("SkillEffectResult_ShuffleTeamOrder", SkillEffectResultBase)
SkillEffectResult_ShuffleTeamOrder = SkillEffectResult_ShuffleTeamOrder

function SkillEffectResult_ShuffleTeamOrder:Constructor(targetID, oldTeamLeaderPstID, newTeamLeaderPstID, oldTeamOrder, newTeamOrder)
  self._targetEntityID = targetID
  self._oldTeamLeaderPstID = oldTeamLeaderPstID
  self._newTeamLeaderPstID = newTeamLeaderPstID
  self._oldTeamOrder = oldTeamOrder
  self._newTeamOrder = newTeamOrder
end

function SkillEffectResult_ShuffleTeamOrder:GetEffectType()
  return SkillEffectType.ShufflePetTeamOrder
end

function SkillEffectResult_ShuffleTeamOrder:GetTargetEntityID()
  return self._targetEntityID
end

function SkillEffectResult_ShuffleTeamOrder:GetOldTeamLeaderPstID()
  return self._oldTeamLeaderPstID
end

function SkillEffectResult_ShuffleTeamOrder:GetNewTeamLeaderPstID()
  return self._newTeamLeaderPstID
end

function SkillEffectResult_ShuffleTeamOrder:GetOldTeamOrder()
  return self._oldTeamOrder
end

function SkillEffectResult_ShuffleTeamOrder:GetNewTeamOrder()
  return self._newTeamOrder
end
