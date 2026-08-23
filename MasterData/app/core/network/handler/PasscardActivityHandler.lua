local var_0_0 = g.core.model.User.gmPassCardData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_PasscardActivity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:updatePassCardData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_PasscardActivity_LevelAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onGetActivityLevelAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_LEVELAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_PasscardActivity_TaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:passCardTaskAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_TASKAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_PasscardActivity_BuyLevel = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:updateBuyLevel(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_BUYLEVEL, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_PasscardActivity_Update = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_0:updateLvExp(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PASSCARD_ACTIVITY_UPDATE, false, arg_5_1, arg_5_2)
		end
	end
}
