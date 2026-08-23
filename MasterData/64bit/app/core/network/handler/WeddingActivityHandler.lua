local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WeddingActivity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.weddingActivityData:onS2CWeddingActivityGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_WeddingActivity_Notify = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.weddingActivityData:onS2CWeddingActivityNotify(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_NOTIFY, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_WeddingActivity_TaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.weddingActivityData:onS2CWeddingActivityTaskAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_TASKAWARD, false, arg_3_1, arg_3_2)
		end
	end
}
