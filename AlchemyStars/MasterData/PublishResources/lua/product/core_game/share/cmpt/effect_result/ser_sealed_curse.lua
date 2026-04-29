require("skill_effect_result_base")
_class("SkillEffectResult_SealedCurse", SkillEffectResultBase)
SkillEffectResult_SealedCurse = SkillEffectResult_SealedCurse

function SkillEffectResult_SealedCurse:Constructor(targetID, buffID, buffInsSeq, oldLeaderPstID, newLeaderPstID)
  self._targetID = targetID
  self._buffID = buffID
  self._buffInsSeq = buffInsSeq
  self._oldLeaderPstID = oldLeaderPstID
  self._newLeaderPstID = newLeaderPstID
  self._oldTeamOrder = {}
  self._newTeamOrder = {}
end

function SkillEffectResult_SealedCurse:GetEffectType()
  return SkillEffectType.SealedCurse
end

function SkillEffectResult_SealedCurse:GetTargetID()
  return self._targetID
end

function SkillEffectResult_SealedCurse:GetBuffID()
  return self._buffID
end

function SkillEffectResult_SealedCurse:GetBuffInsSeq()
  return self._buffInsSeq
end

function SkillEffectResult_SealedCurse:GetOldLeaderPstID()
  return self._oldLeaderPstID
end

function SkillEffectResult_SealedCurse:GetNewLeaderPstID()
  return self._newLeaderPstID
end

function SkillEffectResult_SealedCurse:GetOldTeamOrder()
  return self._oldTeamOrder
end

function SkillEffectResult_SealedCurse:GetNewTeamOrder()
  return self._newTeamOrder
end

function SkillEffectResult_SealedCurse:SetOldTeamOrder(t)
  self._oldTeamOrder = t
end

function SkillEffectResult_SealedCurse:SetNewTeamOrder(t)
  self._newTeamOrder = t
end
