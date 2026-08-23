local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Furnace_Exchange = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNACE_EXCHANGE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Furnace_GetInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.smelterData:onGetInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FURNACE_GETINFO, false, arg_2_1, arg_2_2)
		end
	end
}
