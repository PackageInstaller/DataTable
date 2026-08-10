local var_0_0 = singletonClass("BlisterGameData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.drawNum = 0
	arg_1_0.taskList = {}
	arg_1_0.pointList = {}
	arg_1_0.pointData = {}
	arg_1_0.touchList = {}
	arg_1_0.selectIndex = 0
	arg_1_0.pointIndex = 0
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.activityID = arg_2_1.activity_id
	arg_2_0.taskActivityId = arg_2_0:GetTaskActivityId()
	arg_2_0.pointList = arg_2_1.finish_list or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.pointList) do
		arg_2_0.pointData[iter_2_1.stage_id] = iter_2_1
	end

	arg_2_0:InitRedPoint()
	arg_2_0:UpdateRedPoint(arg_2_0.activityID)
end

function var_0_0.RefreshTaskData(arg_3_0, arg_3_1)
	var_0_0:UpdateRedPoint(arg_3_0.activityID)
	arg_3_0:CheckRewardTaskList()
end

function var_0_0.UpdatePointData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1.star or 0
	local var_4_1 = arg_4_1 and arg_4_1.value or 0
	local var_4_2 = arg_4_0.pointData[arg_4_1.stage_id] and arg_4_0.pointData[arg_4_1.stage_id].star or 0
	local var_4_3 = arg_4_0.pointData[arg_4_1.stage_id] and arg_4_0.pointData[arg_4_1.stage_id].value or 0

	if var_4_2 < var_4_0 or var_4_3 < var_4_1 then
		arg_4_0.pointData[arg_4_1.stage_id] = arg_4_1
	end

	arg_4_0:UpdateRedPoint(arg_4_0.activityID)
end

function var_0_0.GetTaskActivityId(arg_5_0)
	if arg_5_0.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		return ActivityConst.ACTIVITY_3_4_BLISTER_TASK
	else
		return ActivityConst.ACTIVITY_BLISTER_TASK_4_3
	end
end

function var_0_0.GetShowPointList(arg_6_0, arg_6_1)
	local var_6_0 = ActivityBubbleCfg.get_id_list_by_activity_id[arg_6_1]
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0 or {}) do
		local var_6_2 = arg_6_0.pointData[iter_6_1]
		local var_6_3 = {
			id = iter_6_1,
			isPass = var_6_2,
			star = var_6_2 and var_6_2.star or 0
		}

		table.insert(var_6_1, var_6_3)
	end

	table.sort(var_6_1, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)

	return var_6_1
end

function var_0_0.InitRedPoint(arg_8_0)
	local var_8_0 = BlisterGameTool.GetSubActiveID(arg_8_0.activityID)
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0 or {}) do
		local var_8_2 = {}
		local var_8_3 = ActivityBubbleCfg.get_id_list_by_activity_id[iter_8_1] or {}

		for iter_8_2, iter_8_3 in ipairs(var_8_3) do
			local var_8_4 = string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, iter_8_3)

			table.insert(var_8_2, var_8_4)
		end

		local var_8_5 = string.format("%s_%s", RedPointConst.BLISTER_GAME, iter_8_1)

		manager.redPoint:addGroup(var_8_5, var_8_2)
		table.insert(var_8_1, var_8_5)
	end

	local var_8_6 = {}
	local var_8_7 = BlisterGameTool.GetSubActiveID(arg_8_0.taskActivityId)

	for iter_8_4, iter_8_5 in ipairs(var_8_7 or {}) do
		local var_8_8 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_8_5)

		table.insert(var_8_6, var_8_8)
	end

	local var_8_9 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_8_0.taskActivityId)

	manager.redPoint:addGroup(var_8_9, var_8_6)

	if arg_8_0.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		local var_8_10 = ActivityCfg.get_id_list_by_sub_activity_list[arg_8_0.activityID] and ActivityCfg.get_id_list_by_sub_activity_list[arg_8_0.activityID][1]

		if var_8_10 then
			local var_8_11 = ActivityTools.GetRedPointKey(var_8_10) .. var_8_10

			manager.redPoint:addGroup(var_8_11, var_8_1)
		end
	else
		table.insert(var_8_1, var_8_9)

		local var_8_12 = string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, arg_8_0.activityID)

		manager.redPoint:addGroup(var_8_12, var_8_1)
	end
end

function var_0_0.UpdateRedPoint(arg_9_0, arg_9_1)
	local var_9_0 = BlisterGameTool.GetSubActiveID(arg_9_1)

	for iter_9_0, iter_9_1 in ipairs(var_9_0 or {}) do
		local var_9_1 = 0
		local var_9_2 = ActivityBubbleCfg.get_id_list_by_activity_id[iter_9_1] or {}
		local var_9_3 = ActivityData:GetActivityIsOpen(iter_9_1)

		for iter_9_2, iter_9_3 in ipairs(var_9_2) do
			local var_9_4 = not BlisterGameTool.GetSessionIsLockByID(arg_9_1, ActivityBubbleCfg[iter_9_3].session)

			if arg_9_0:GetStageIdIsOpen(iter_9_3) and var_9_3 and not arg_9_0:GetStageInfo(iter_9_3) and var_9_4 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, iter_9_3), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, iter_9_3), 0)
			end
		end
	end
end

function var_0_0.CheckRewardTaskList(arg_10_0)
	local var_10_0 = BlisterGameTool.GetSubActiveID(arg_10_0.taskActivityId)

	arg_10_0.taskList = {}
	arg_10_0.rewardTaskList = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = TaskData2:GetTaskIDListByActivity(iter_10_1)

		for iter_10_2, iter_10_3 in pairs(var_10_1) do
			arg_10_0.taskList[iter_10_2] = iter_10_3
		end
	end

	arg_10_0.taskList = TaskData2:SortTask(arg_10_0.taskList)

	for iter_10_4, iter_10_5 in pairs(arg_10_0.taskList) do
		if iter_10_5.progress >= AssignmentCfg[iter_10_5.id].need and iter_10_5.complete_flag < 1 then
			table.insert(arg_10_0.rewardTaskList, iter_10_5.id)
		end
	end
end

function var_0_0.GetTaskList(arg_11_0)
	return arg_11_0.taskList
end

function var_0_0.GetRewardTaskList(arg_12_0)
	return arg_12_0.rewardTaskList
end

function var_0_0.GetStarByScore(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = ActivityBubbleCfg[arg_13_1]
	local var_13_1 = 0

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0.score_level) do
			if iter_13_1 <= arg_13_2 then
				var_13_1 = iter_13_0
			end
		end
	end

	return var_13_1
end

function var_0_0.GetStageInfo(arg_14_0, arg_14_1)
	return arg_14_0.pointData[arg_14_1]
end

function var_0_0.SavePassId(arg_15_0, arg_15_1)
	var_0_0.passId = arg_15_1
end

function var_0_0.GetPassId(arg_16_0)
	return var_0_0.passId
end

function var_0_0.GetStageIdIsOpen(arg_17_0, arg_17_1)
	local var_17_0 = ActivityBubbleCfg[arg_17_1].pre

	if var_17_0 and ActivityBubbleCfg[var_17_0] then
		return (arg_17_0:GetStageInfo(var_17_0))
	end

	return true
end

function var_0_0.SaveSetlectIndx(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.selectIndex = arg_18_1
end

function var_0_0.SavePointIndx(arg_19_0, arg_19_1)
	arg_19_0.pointIndex = arg_19_1
end

function var_0_0.GetActivityId(arg_20_0)
	return arg_20_0.activityID
end

function var_0_0.SetActivityId(arg_21_0, arg_21_1)
	arg_21_0.activityID = arg_21_1
end

function var_0_0.GetFirstPhaseLastStage(arg_22_0)
	local var_22_0 = ActivityCfg[arg_22_0.activityID].sub_activity_list[1]
	local var_22_1 = ActivityBubbleCfg.get_id_list_by_activity_id[var_22_0]

	if var_22_1 then
		return var_22_1[#var_22_1]
	end
end

function var_0_0.GetSecondPhaseFirstStage(arg_23_0)
	local var_23_0 = ActivityCfg[arg_23_0.activityID].sub_activity_list[2]
	local var_23_1 = ActivityBubbleCfg.get_id_list_by_activity_id[var_23_0]

	if var_23_1 then
		return var_23_1[1]
	end
end

return var_0_0
