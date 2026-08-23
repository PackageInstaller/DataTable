local var_0_0 = g.core.model.User.gmFundData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_FundActivity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:updateFundActivityData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_FundActivity_LevelAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onGetLvReward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_LEVELAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_FundActivity_UpdateAction = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:onActionUpdate(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FUND_ACTIVITY_UPDATEACTION, false, arg_3_1, arg_3_2)
		end
	end
}
