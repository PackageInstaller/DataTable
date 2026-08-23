local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.cultivateDataMgr

return {
	on_S2C_CultivateActivity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:updateActiveData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_CultivateActivity_UpdateTask = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			local var_2_0 = var_0_1:getCultivateData(arg_2_2.activity_id)

			if var_2_0 then
				var_2_0:getTaskData():updateTaskData(arg_2_2.tasks)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATETASK, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_CultivateActivity_UpdatePasscard = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			local var_3_0 = var_0_1:getCultivateData(arg_3_2.activity_id)

			if var_3_0 then
				var_3_0:getPassCardData():updatePassCardData(arg_3_2.passcards)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATEPASSCARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_CultivateActivity_TaskAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			local var_4_0 = var_0_1:getCultivateData(arg_4_2.activity_id)

			if var_4_0 then
				var_4_0:getTaskData():onTaskAward(arg_4_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_TASKAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_CultivateActivity_PasscardGift = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			local var_5_0 = var_0_1:getCultivateData(arg_5_2.activity_id)

			if var_5_0 then
				var_5_0:getPassCardData():onPassCardReward(arg_5_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_PASSCARDGIFT, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_CultivateActivity_Notice = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:updateActive(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CULTIVATE_ACTIVITY_NOTICE, false, arg_6_1, arg_6_2)
		end
	end
}
