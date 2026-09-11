local var_0_0 = singletonClass("DodgeBarrageData")

function var_0_0:InitData(arg_1_1)
	self.activityId_ = arg_1_1.activity_id
	self.finishedStage_ = arg_1_1.finish_stage
	self.lastStage_ = arg_1_1.last_stage
	self.currentScore_ = arg_1_1.current_score

	local var_1_0 = ActivityTools.GetRedPointKey(self.activityId_) .. self.activityId_

	self.redPointKey_ = var_1_0 .. "Task"

	manager.redPoint:addGroup(var_1_0, {
		self.redPointKey_
	})

	self.pointStageRecord_ = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.point_stage_list) do
		self.pointStageRecord_[iter_1_1.stage_id] = iter_1_1.score
	end

	self:CheckRewardTaskList()
end

function var_0_0:CheckRewardTaskList()
	self.taskList_ = TaskData2:GetActivityTaskSortList(self.activityId_)
	self.rewardTaskList_ = {}

	for iter_2_0, iter_2_1 in pairs(self.taskList_) do
		if iter_2_1.progress >= AssignmentCfg[iter_2_1.id].need and iter_2_1.complete_flag < 1 then
			table.insert(self.rewardTaskList_, iter_2_1.id)
		end
	end

	self:UpdateRedPointData(#self.rewardTaskList_ > 0 and 1 or 0)
end

function var_0_0:GetRewardTaskList()
	return self.rewardTaskList_
end

function var_0_0:UpdateRedPointData(arg_4_1)
	manager.redPoint:setTip(self.redPointKey_, arg_4_1)
end

function var_0_0:GetTaskList()
	return self.taskList_
end

function var_0_0:GetActivityId()
	return self.activityId_
end

function var_0_0:GetRedPointKey()
	return self.redPointKey_
end

function var_0_0:GetLastStage()
	local var_8_0 = 0

	for iter_8_0 = 1, #self.finishedStage_ do
		if var_8_0 < ActivityDodgeBarrageCfg.get_id_list_by_stage_id[self.finishedStage_[iter_8_0]][1] and self.pointStageRecord_[self.finishedStage_[iter_8_0]] > 0 then
			var_8_0 = ActivityDodgeBarrageCfg.get_id_list_by_stage_id[self.finishedStage_[iter_8_0]][1]
		end
	end

	return math.min(var_8_0 + 1, #ActivityDodgeBarrageCfg.all)
end

function var_0_0:IsStageFinished(arg_9_1)
	return table.indexof(self.finishedStage_, arg_9_1) and self.pointStageRecord_[arg_9_1] > 0
end

function var_0_0:GetStageScore(arg_10_1)
	return self.pointStageRecord_[arg_10_1]
end

function var_0_0:GetCurrentScore()
	self.currentScore_ = 0

	return self.currentScore_ or 0
end

return var_0_0
