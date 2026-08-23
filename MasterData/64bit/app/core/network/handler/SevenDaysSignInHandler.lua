local var_0_0 = g.core.model.User.sevenDaysSignInData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_LoginReward_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onRcvLoginRewardInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_LOGIN_REWARD_INFO, false)
		end
	end,
	on_S2C_LoginReward_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onRcvLoginRewardAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_LOGIN_REWARD_AWARD, false, arg_2_1, arg_2_2)
		end
	end
}
