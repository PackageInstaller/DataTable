local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_FightingCapacity_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.fightActivityData:updateFightInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FIGHTING_CAPACITY_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_FightingCapacity_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.fightActivityData:updateAwardData(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FIGHTING_CAPACITY_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_FightingCapacity_Rank = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.fightActivityData:updateFinalRank(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FIGHTING_CAPACITY_RANK, false, arg_3_1, arg_3_2)
		end
	end
}
