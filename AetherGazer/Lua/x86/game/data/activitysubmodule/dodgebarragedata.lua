local var_0_0 = singletonClass("DodgeBarrageData")

function var_0_0.InitData(arg_1_0, arg_1_1)
	arg_1_0.activityId_ = arg_1_1.activity_id
	arg_1_0.finishedStage_ = arg_1_1.finish_stage
	arg_1_0.lastStage_ = arg_1_1.last_stage
	arg_1_0.currentScore_ = arg_1_1.current_score

	local var_1_0 = ActivityTools.GetRedPointKey(arg_1_0.activityId_) .. arg_1_0.activityId_

	arg_1_0.redPointKey_ = var_1_0 .. "Task"

	manager.redPoint:addGroup(var_1_0, {
		arg_1_0.redPointKey_
	})

	arg_1_0.pointStageRecord_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.point_stage_list) do
		arg_1_0.pointStageRecord_[iter_1_1.stage_id] = iter_1_1.score
	end

	arg_1_0:CheckRewardTaskList()
end

function var_0_0.CheckRewardTaskList(arg_2_0)
	arg_2_0.taskList_ = TaskData2:GetActivityTaskSortList(arg_2_0.activityId_)
	arg_2_0.rewardTaskList_ = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.taskList_) do
		if iter_2_1.progress >= AssignmentCfg[iter_2_1.id].need and iter_2_1.complete_flag < 1 then
			table.insert(arg_2_0.rewardTaskList_, iter_2_1.id)
		end
	end

	arg_2_0:UpdateRedPointData(#arg_2_0.rewardTaskList_ > 0 and 1 or 0)
end

function var_0_0.GetRewardTaskList(arg_3_0)
	return arg_3_0.rewardTaskList_
end

function var_0_0.UpdateRedPointData(arg_4_0, arg_4_1)
	manager.redPoint:setTip(arg_4_0.redPointKey_, arg_4_1)
end

function var_0_0.GetTaskList(arg_5_0)
	return arg_5_0.taskList_
end

function var_0_0.GetActivityId(arg_6_0)
	return arg_6_0.activityId_
end

function var_0_0.GetRedPointKey(arg_7_0)
	return arg_7_0.redPointKey_
end

function var_0_0.GetLastStage(arg_8_0)
	local var_8_0 = 0

	for iter_8_0 = 1, #arg_8_0.finishedStage_ do
		local var_8_1 = arg_8_0.finishedStage_[iter_8_0]
		local var_8_2 = ActivityDodgeBarrageCfg.get_id_list_by_stage_id[var_8_1][1]

		if var_8_0 < var_8_2 and arg_8_0.pointStageRecord_[var_8_1] > 0 then
			var_8_0 = var_8_2
		end
	end

	return math.min(var_8_0 + 1, #ActivityDodgeBarrageCfg.all)
end

function var_0_0.IsStageFinished(arg_9_0, arg_9_1)
	return table.indexof(arg_9_0.finishedStage_, arg_9_1) and arg_9_0.pointStageRecord_[arg_9_1] > 0
end

function var_0_0.GetStageScore(arg_10_0, arg_10_1)
	return arg_10_0.pointStageRecord_[arg_10_1]
end

function var_0_0.GetCurrentScore(arg_11_0)
	local var_11_0 = arg_11_0.currentScore_ or 0

	arg_11_0.currentScore_ = 0

	return var_11_0
end

return var_0_0
