local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_MainTask_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.homeData:onS2CMainTaskGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIN_TASK_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_MainTask_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.homeData:onS2CMainTaskGetAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIN_TASK_GETAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_MainTask_Notify = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.homeData:onS2CMainTaskNotify(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MAIN_TASK_NOTIFY, false, arg_3_1, arg_3_2)
		end
	end
}
