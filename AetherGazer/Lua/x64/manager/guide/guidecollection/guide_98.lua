local var_0_0 = class("Guide_98", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	if not GuideTool.SatisfyCondition(arg_1_0.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:IsFinishGuide()
end

return var_0_0
