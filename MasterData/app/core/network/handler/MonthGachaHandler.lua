local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.activityMonthGachaData

return {
	on_S2C_MonthGacha_ActivityInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onUpdateStageData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_ACTIVITYINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_MonthGacha_TaskInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onGetTaskInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_MonthGacha_TaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onGetTaskReward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_MonthGacha_Draw = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onGetDrawReward(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_DRAW, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_MonthGacha_TaskNotify = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:updateTaskValue(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKNOTIFY, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_MonthGacha_Reset = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:onUpdateStageData(arg_6_2)
			var_0_1:resetAllReward()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_RESET, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_MonthGacha_ChoseAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:onChooseRewardItem(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_CHOSEAWARD, false, arg_7_1, arg_7_2)
		end
	end
}
