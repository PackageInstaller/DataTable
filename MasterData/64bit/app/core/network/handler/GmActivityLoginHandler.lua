local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.signActivityData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_GmActivityLogin_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGmLoginGetInfo(arg_1_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_GM_ACTIVITY_LOGIN_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GmActivityLogin_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CGmLoginGetAward(arg_2_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_GM_ACTIVITY_LOGIN_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end
}
