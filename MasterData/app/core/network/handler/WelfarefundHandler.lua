local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.halfAnniversaryData

return {
	on_S2C_Welfarefund_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CWelfarefundGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Welfarefund_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CWelfarefundGetAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Welfarefund_GetScoreAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CWelfarefundGetScoreAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETSCOREAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Welfarefund_NotifyTask = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CWelfarefundNotifyTask(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_NOTIFYTASK, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Welfarefund_BuyScore = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CWelfarefundBuyScore(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_BUYSCORE, false, arg_5_1, arg_5_2)
		end
	end
}
