SkillEffect_SealedCurse_SealMode = {SwapWithNewTeamLeader = 1, CastFormerLeaderToTail = 2}
_enum("SkillEffect_SealedCurse_SealMode", SkillEffect_SealedCurse_SealMode)
require("skill_damage_effect_param")
_class("SkillEffectParam_SealedCurse", SkillDamageEffectParam)
SkillEffectParam_SealedCurse = SkillEffectParam_SealedCurse

function SkillEffectParam_SealedCurse:Constructor(t)
  self._curseBuffID = t.curseBuffID
  self._changeTeamLeaderMode = t.changeTeamLeaderMode or SkillEffect_SealedCurse_SealMode.SwapWithNewTeamLeader
end

function SkillEffectParam_SealedCurse:GetEffectType()
  return SkillEffectType.SealedCurse
end

function SkillEffectParam_SealedCurse:GetCurseBuffID()
  return self._curseBuffID
end

function SkillEffectParam_SealedCurse:GetChangeTeamLeaderMode()
  return self._changeTeamLeaderMode
end
