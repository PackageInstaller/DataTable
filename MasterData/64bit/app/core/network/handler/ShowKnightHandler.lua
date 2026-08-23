local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_ShowKnight_Set = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User:initNominateList(arg_1_2.show_knights, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOW_KNIGHT_SET, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ShowKnight_Flush = function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2.show_knights then
			g.core.model.User:initNominateList(arg_2_2.show_knights)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOW_KNIGHT_FLUSH, false, arg_2_1, arg_2_2)
		end
	end
}
