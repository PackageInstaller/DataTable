local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_AccountBind_Award = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.UserTitleData:bindAccountAward(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACCOUNT_BIND_AWARD, false, arg_1_1, arg_1_2)
		end
	end
}
