local var_0_0 = class("Guide_95", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	if not GuideTool.SatisfyCondition(arg_1_0.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:UIGetOperatePopType() == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.RELIC
end

return var_0_0
