local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_OtherReturnPay_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.activityOtherReturnPayData:updateOtherServerInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OTHER_RETURN_PAY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_OtherReturnPay_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.activityOtherReturnPayData:setAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_OTHER_RETURN_PAY_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end
}
