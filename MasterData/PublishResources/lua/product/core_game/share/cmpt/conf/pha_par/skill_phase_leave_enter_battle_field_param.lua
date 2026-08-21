require("skill_phase_param_base")
_class("SkillPhaseLeaveEnterBattleFieldParam", SkillPhaseParamBase)
SkillPhaseLeaveEnterBattleFieldParam = SkillPhaseLeaveEnterBattleFieldParam

function SkillPhaseLeaveEnterBattleFieldParam:Constructor(t)
end

function SkillPhaseLeaveEnterBattleFieldParam:GetPhaseType()
  return SkillViewPhaseType.LeaveEnterBattleField
end

function SkillPhaseLeaveEnterBattleFieldParam:GetCacheTable()
  return {}
end
