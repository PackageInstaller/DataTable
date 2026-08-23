local var_0_0 = g.core.model.User.serverPassActivityData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_ServerPass_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2CServerPassInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ServerPass_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onS2CServerPassAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ServerPass_AwardAll = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:onS2CServerPassAwardAll(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_AWARDALL, false, arg_3_1, arg_3_2)
		end
	end
}
