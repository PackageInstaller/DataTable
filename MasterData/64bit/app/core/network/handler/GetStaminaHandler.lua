local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GetStamina_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.activityGetStaminaData:onRcvGetStaminaInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_INFO, false)
		end
	end,
	on_S2C_GetStamina_Get = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.activityGetStaminaData:onRcvGetStaminaGet(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_GET, false, arg_2_2)
		end
	end
}
