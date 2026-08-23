local var_0_0 = g.core.model.User.sevenDaysData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_NewSevendays_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2CNewSevenDaysInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SEVENDAYS_INFO, false)
		end
	end,
	on_S2C_NewSevendays_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onS2CNewSevenDaysAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SEVENDAYS_AWARD, false, arg_2_2)
		end
	end,
	on_S2C_NewSevendays_ScoreAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:onS2cNewSevenDaysScoreAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_NEW_SEVENDAYS_SCOREAWARD, false, arg_3_2)
		end
	end
}
