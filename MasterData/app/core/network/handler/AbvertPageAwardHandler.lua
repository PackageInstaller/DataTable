local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_AbvertPageAward_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.abvertPageAwardData:onS2CAbvertPageAwardGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ABVERT_PAGE_AWARD_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_AbvertPageAward_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.abvertPageAwardData:onS2CAbvertPageAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ABVERT_PAGE_AWARD_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_AbvertPageAward_Notify = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.abvertPageAwardData:onS2CAbvertPageAwardNotify(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ABVERT_PAGE_AWARD_NOTIFY, false, arg_3_1, arg_3_2)
		end
	end
}
