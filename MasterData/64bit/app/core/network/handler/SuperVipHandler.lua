local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_SuperVip_Get = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			-- block empty
		end
	end
}
