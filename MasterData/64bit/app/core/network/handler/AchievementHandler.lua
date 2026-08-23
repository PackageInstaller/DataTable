local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.achievementData

return {
	on_S2C_Achievement_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CAchievementInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Achievement_Finish = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CAchievementFinish(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_FINISH, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Achievement_Finish_OneKey = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CAchievementFinishOneKey(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_FINISH_ONEKEY, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Achievement_Reward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CAchievementReward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_REWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Achievement_Reward_OneKey = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CAchievementRewardOneKey(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACHIEVEMENT_REWARD_ONEKEY, false, arg_5_1, arg_5_2)
		end
	end
}
