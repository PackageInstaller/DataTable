local var_0_0 = class("ChallengeRogueTeamRewardPopEvent")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.CheckObtainDataHandler_ = handler(arg_1_0, arg_1_0.CheckObtainData)
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_UPDATA_REWARD_WINDOW, arg_2_0.CheckObtainDataHandler_)
end

function var_0_0.OnTop(arg_3_0)
	arg_3_0:CheckObtainData()
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_UPDATA_REWARD_WINDOW, arg_4_0.CheckObtainDataHandler_)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.CheckObtainDataHandler_ = nil
end

function var_0_0.CheckObtainData(arg_6_0)
	ChallengeRogueTeamAction.TriggerPopWindow()
end

return var_0_0
