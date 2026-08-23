local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Refund_UpdateClose = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.refundData:updateClose(arg_1_2.close)
		end
	end
}
