local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Monopoly_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.monopolyDataMgr:onGetMonopolyInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONOPOLY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Monopoly_RollDice = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.monopolyDataMgr:onMonopolyRollDice(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONOPOLY_ROLLDICE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Monopoly_NodeAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.monopolyDataMgr:onMonopolyNodeAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONOPOLY_NODEAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Monopoly_UseFixedDice = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.monopolyDataMgr:onMonopolyUseFixedDice(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONOPOLY_USEFIXEDDICE, false, arg_4_1, arg_4_2)
		end
	end
}
