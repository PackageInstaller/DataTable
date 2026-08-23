local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Condition_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.condition_act then
				for iter_1_0, iter_1_1 in ipairs(arg_1_2.condition_act) do
					g.core.model.User.activityTaskData:updateConditionGetInfo(iter_1_1)
				end
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONDITION_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Condition_TaskAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.activityTaskData:updateConditionTaskAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONDITION_TASKAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Condition_SyncTask = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.activityTaskData:updateConditionSyncTask(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CONDITION_SYNCTASK, false, arg_3_1, arg_3_2)
		end
	end
}
