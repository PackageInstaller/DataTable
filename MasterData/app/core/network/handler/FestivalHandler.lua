local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.userFestivalData

return {
	on_S2C_Festival_Set_Birthday = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:updateData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FESTIVAL_SET_BIRTHDAY, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Festival_Get_Infos = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:updateUnlockIds(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FESTIVAL_GET_INFOS, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Festival_Get_Birthday_Award = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:setLastReceivedTime()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FESTIVAL_GET_BIRTHDAY_AWARD, false, arg_3_1, arg_3_2)
		end
	end
}
