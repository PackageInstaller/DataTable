local var_0_0 = class("Guide_96", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	if not GuideTool.SatisfyCondition(arg_1_0.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:UIGetOperatePopType() == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM
end

return var_0_0
