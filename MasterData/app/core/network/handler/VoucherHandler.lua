local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Voucher_Sale = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_VOUCHER_SALE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Voucher_Buy = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_VOUCHER_BUY, false, arg_2_1, arg_2_2)
		end
	end
}
