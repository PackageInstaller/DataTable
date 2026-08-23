local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_DailyTask_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.dailyTaskData:updateTaskInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_DailyTask_FinishAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.dailyTaskData:onTaskAwardBack(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_FINISHAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_DailyTask_DegreeAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.dailyTaskData:onDegreeAwardBack(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_DEGREEAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_DailyTask_OneKey_FinishAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.dailyTaskData:onTaskAwardBack(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_ONEKEY_FINISHAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_DailyTask_ProfileAward = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.dailyTaskData:updateProfileAllGetAward(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_PROFILEAWARD, false, arg_5_1, arg_5_2)
		end
	end
}
