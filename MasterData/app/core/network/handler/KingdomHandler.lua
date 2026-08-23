local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_MainGrowth_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.kingdomData:updateInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIN_GROWTH_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_MainGrowth_Activate = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.kingdomData:updateInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIN_GROWTH_ACTIVATE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Scroll_Info = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.kingdomDataNew:updateInfo(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SCROLL_INFO, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Scroll_Activate = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.kingdomDataNew:updateInfo(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SCROLL_ACTIVATE, false, arg_4_1, arg_4_2)
		end
	end
}
