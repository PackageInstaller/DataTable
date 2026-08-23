local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Wing_Compose = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WING_COMPOSE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Wing_Refine = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WING_REFINE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Wing_Wear = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WING_WEAR, false, arg_3_1, arg_3_2)
		end
	end
}
