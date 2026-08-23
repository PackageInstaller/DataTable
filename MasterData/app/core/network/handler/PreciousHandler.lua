local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.preciousData

return {
	on_S2C_Precious_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CPreciousGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Precious_Upgrade = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_UPGRADE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Precious_StarUp = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_STARUP, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Precious_SuitActivate = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CPreciousSuitActivate(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITACTIVATE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Precious_SuitStarUp = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CPreciousSuitStarUp(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITSTARUP, false, arg_5_1, arg_5_2)
		end
	end
}
