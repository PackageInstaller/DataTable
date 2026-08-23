local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Activity_Common_Task_Get = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.activityCommonTaskData:updateGet(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_TASK_GET, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Activity_Common_Task_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.activityCommonTaskData:updateAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_TASK_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Activity_Common_Task_Update = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.activityCommonTaskData:updateSyncTask(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_TASK_UPDATE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Activity_Common_Record_Broadcast = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.activityCommonTaskData:updateBroadcast(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_RECORD_BROADCAST, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Activity_Common_Draw = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_DRAW, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Activity_Common_Record_Get = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.activityCommonTaskData:updateRecordGet(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_RECORD_GET, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Activity_Common_GetInfoServer = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.activityDataManager:onRcvActivityCommonGetInfoServer(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ACTIVITY_COMMON_GETINFOSERVER, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Activity_GetExchangeInfo = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			-- block empty
		end
	end,
	on_S2C_Activity_GetLosts = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			-- block empty
		end
	end,
	on_S2C_Activity_GetLostAward = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			-- block empty
		end
	end
}
