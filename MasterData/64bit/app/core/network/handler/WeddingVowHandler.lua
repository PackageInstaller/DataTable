local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WeddingVow_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.weddingData:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_WeddingVow_Active = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.weddingData:onS2VowActive(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_ACTIVE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_WeddingVow_Upgrade = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.weddingData:onS2VowUpgrade(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_UPGRADE, false, arg_3_1, arg_3_2)
		end
	end
}
