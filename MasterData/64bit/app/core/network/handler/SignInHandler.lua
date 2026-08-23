local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_SignIn_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.SignInData:loadSignInData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_SignIn_Sign = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.SignInData:onSignInSignHandler(arg_2_2.signed)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_SIGN, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_SignIn_Award = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.SignInData:onSignInAwardHandler(arg_3_2.id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_AWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_SignIn_Test = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SIGN_IN_TEST, false, arg_4_1, arg_4_2)
		end
	end
}
