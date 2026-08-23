local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Phone_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.bindPhoneData:updateBindPhoneInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PHONE_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Phone_Bind = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			-- block empty
		end
	end,
	on_S2C_Phone_Award = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.bindPhoneData:updatePhoneReward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PHONE_AWARD, false, arg_3_1, arg_3_2)
		end
	end
}
