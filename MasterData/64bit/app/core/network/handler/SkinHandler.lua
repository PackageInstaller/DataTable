local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Skin_Wear = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_WEAR, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Skin_TakeOff = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SKIN_TAKEOFF, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Skin_Expire_Ntf = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			-- block empty
		end
	end,
	on_S2C_Skin_AdvanceCheck = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			-- block empty
		end
	end
}
