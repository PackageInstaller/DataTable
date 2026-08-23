local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.easterEggData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum

return {
	on_S2C_Interaction_Like = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CTalkSucc(arg_1_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_INTERACTION_LIKE, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Interaction_Info = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CInteraction(arg_2_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_INTERACTION_INFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Interaction_InfoAll = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CInteractionAll(arg_3_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_INTERACTION_INFOALL, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Interaction_OtherInfo = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CInteractionOther(arg_4_2)
			var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_INTERACTION_OTHERINFO, false, arg_4_1, arg_4_2)
		end
	end
}
