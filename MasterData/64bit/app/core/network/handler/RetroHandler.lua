local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Retro_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.retroData:onS2CRetroGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRO_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Retro_BoxAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.retroData:onS2CRetroBoxAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRO_BOXAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Retro_RefreshBox = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.retroData:onS2CRetroRefreshBox(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRO_REFRESHBOX, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Retro_TaskAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.retroData:onS2CRetroTaskAward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_RETRO_TASKAWARD, false, arg_4_1, arg_4_2)
		end
	end
}
