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

function var_0_0:InitData(arg_2_1)
	self.activityID = arg_2_1.activity_id
	self.taskActivityId = self:GetTaskActivityId()
	self.pointList = arg_2_1.finish_list or {}

	for iter_2_0, iter_2_1 in ipairs(self.pointList) do
		self.pointData[iter_2_1.stage_id] = iter_2_1
	end

	self:InitRedPoint()
	self:UpdateRedPoint(self.activityID)
end

function var_0_0:RefreshTaskData(arg_3_1)
	var_0_0:UpdateRedPoint(self.activityID)
	self:CheckRewardTaskList()
end

function var_0_0:UpdatePointData(arg_4_1)
	if arg_4_1 then
		if arg_4_1 then
			if self.pointData[arg_4_1.stage_id] then
				if self.pointData[arg_4_1.stage_id] then
					if (self.pointData[arg_4_1.stage_id].star or 0) < (arg_4_1.star or 0) or (self.pointData[arg_4_1.stage_id].value or 0) < (arg_4_1.value or 0) then
						self.pointData[arg_4_1.stage_id] = arg_4_1
					end
				end
			end
		end
	end

	self:UpdateRedPoint(self.activityID)
end

function var_0_0:GetTaskActivityId()
	if self.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		return ActivityConst.ACTIVITY_3_4_BLISTER_TASK
	else
		return ActivityConst.ACTIVITY_BLISTER_TASK_4_3
	end
end

function var_0_0:GetShowPointList(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityBubbleCfg.get_id_list_by_activity_id[arg_6_1] or {}) do
		local var_6_1 = {
			id = iter_6_1,
			isPass = self.pointData[iter_6_1]
		}

		if self.pointData[iter_6_1] then
			var_6_1.star = self.pointData[iter_6_1].star or 0
		end

		table.insert(var_6_0, var_6_1)
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)

	return var_6_0
end

function var_0_0:InitRedPoint()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(BlisterGameTool.GetSubActiveID(self.activityID) or {}) do
		local var_8_1 = {}

		for iter_8_2, iter_8_3 in ipairs(ActivityBubbleCfg.get_id_list_by_activity_id[iter_8_1] or {}) do
			table.insert(var_8_1, (string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, iter_8_3)))
		end

		local var_8_2 = string.format("%s_%s", RedPointConst.BLISTER_GAME, iter_8_1)

		manager.redPoint:addGroup(var_8_2, var_8_1)
		table.insert(var_8_0, var_8_2)
	end

	local var_8_3 = {}

	for iter_8_4, iter_8_5 in ipairs(BlisterGameTool.GetSubActiveID(self.taskActivityId) or {}) do
		table.insert(var_8_3, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_8_5)))
	end

	local var_8_4 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.taskActivityId)

	manager.redPoint:addGroup(var_8_4, var_8_3)

	if self.activityID == ActivityConst.ACTIVITY_3_4_BLISTER_GAME then
		local var_8_5 = ActivityCfg.get_id_list_by_sub_activity_list[self.activityID] and ActivityCfg.get_id_list_by_sub_activity_list[self.activityID][1]

		if var_8_5 then
			manager.redPoint:addGroup(ActivityTools.GetRedPointKey(var_8_5) .. var_8_5, var_8_0)
		end
	else
		table.insert(var_8_0, var_8_4)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_COMMON, self.activityID), var_8_0)
	end
end

function var_0_0:UpdateRedPoint(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(BlisterGameTool.GetSubActiveID(arg_9_1) or {}) do
		local var_9_1 = ActivityBubbleCfg.get_id_list_by_activity_id[iter_9_1] or {}
		local var_9_2 = ActivityData:GetActivityIsOpen(iter_9_1)

		for iter_9_2, iter_9_3 in ipairs(var_9_1) do
			if self:GetStageIdIsOpen(iter_9_3) and var_9_2 and not self:GetStageInfo(iter_9_3) and not BlisterGameTool.GetSessionIsLockByID(arg_9_1, ActivityBubbleCfg[iter_9_3].session) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, iter_9_3), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.BLISTER_GAME_PLAY, iter_9_3), 0)
			end
		end
	end
end

function var_0_0:CheckRewardTaskList()
	self.taskList = {}
	self.rewardTaskList = {}

	for iter_10_0, iter_10_1 in ipairs((BlisterGameTool.GetSubActiveID(self.taskActivityId))) do
		for iter_10_2, iter_10_3 in pairs((TaskData2:GetTaskIDListByActivity(iter_10_1))) do
			self.taskList[iter_10_2] = iter_10_3
		end
	end

	self.taskList = TaskData2:SortTask(self.taskList)

	for iter_10_4, iter_10_5 in pairs(self.taskList) do
		if iter_10_5.progress >= AssignmentCfg[iter_10_5.id].need and iter_10_5.complete_flag < 1 then
			table.insert(self.rewardTaskList, iter_10_5.id)
		end
	end
end

function var_0_0:GetTaskList()
	return self.taskList
end

function var_0_0:GetRewardTaskList()
	return self.rewardTaskList
end

function var_0_0.GetStarByScore(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = 0

	if ActivityBubbleCfg[arg_13_1] then
		for iter_13_0, iter_13_1 in ipairs(ActivityBubbleCfg[arg_13_1].score_level) do
			if iter_13_1 <= arg_13_2 then
				var_13_0 = iter_13_0
			end
		end
	end

	return var_13_0
end

function var_0_0:GetStageInfo(arg_14_1)
	return self.pointData[arg_14_1]
end

function var_0_0.SavePassId(arg_15_0, arg_15_1)
	var_0_0.passId = arg_15_1
end

function var_0_0.GetPassId(arg_16_0)
	return var_0_0.passId
end

function var_0_0:GetStageIdIsOpen(arg_17_1)
	if ActivityBubbleCfg[arg_17_1].pre and ActivityBubbleCfg[ActivityBubbleCfg[arg_17_1].pre] then
		return (self:GetStageInfo(ActivityBubbleCfg[arg_17_1].pre))
	end

	return true
end

function var_0_0.SaveSetlectIndx(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.selectIndex = arg_18_1
end

function var_0_0.SavePointIndx(arg_19_0, arg_19_1)
	arg_19_0.pointIndex = arg_19_1
end

function var_0_0:GetActivityId()
	return self.activityID
end

function var_0_0.SetActivityId(arg_21_0, arg_21_1)
	arg_21_0.activityID = arg_21_1
end

function var_0_0:GetFirstPhaseLastStage()
	if ActivityBubbleCfg.get_id_list_by_activity_id[ActivityCfg[self.activityID].sub_activity_list[1]] then
		return ActivityBubbleCfg.get_id_list_by_activity_id[ActivityCfg[self.activityID].sub_activity_list[1]][#ActivityBubbleCfg.get_id_list_by_activity_id[ActivityCfg[self.activityID].sub_activity_list[1]]]
	end
end

function var_0_0:GetSecondPhaseFirstStage()
	if ActivityBubbleCfg.get_id_list_by_activity_id[ActivityCfg[self.activityID].sub_activity_list[2]] then
		return ActivityBubbleCfg.get_id_list_by_activity_id[ActivityCfg[self.activityID].sub_activity_list[2]][1]
	end
end

return var_0_0
