require("skill_phase_param_summon_everything")
_class("SkillPhaseParam_AddBlood", SkillPhaseParam_SummonEverything)
SkillPhaseParam_AddBlood = SkillPhaseParam_AddBlood

function SkillPhaseParam_AddBlood:Constructor(t)
  self._playerStepTime = t.playerStepTime or 0
end

function SkillPhaseParam_AddBlood:GetPhaseType()
  return SkillViewPhaseType.AddBlood
end

function SkillPhaseParam_AddBlood:GetPlayerStepTime()
  return self._playerStepTime
end
