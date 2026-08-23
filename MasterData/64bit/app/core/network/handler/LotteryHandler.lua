local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Lottery_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.lotteryData:onS2CLotteryGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Lottery_Draw = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.lotteryData:onS2CLotteryDraw(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_LOTTERY_DRAW, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Lottery_Next_Pool = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.lotteryData:onS2CLotteryNextPool(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_LOTTERY_NEXT_POOL, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Lottery_TaskAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.lotteryData:onS2CLotteryTaskAward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_LOTTERY_TASKAWARD, false, arg_4_1, arg_4_2)
		end
	end
}
