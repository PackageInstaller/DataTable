local var_0_0 = singletonClass("ActivityAccumulativeData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.drawNum = 0
	arg_1_0.taskList = {}
end

function var_0_0:InitData(arg_2_1)
	self.activityID = arg_2_1.activity_id
	self.drawNum = arg_2_1.point
	self.taskList = arg_2_1.reward_list or {}

	self:UpdateRedPoint()
end

function var_0_0:RefreshData(arg_3_1)
	if not table.indexof(self.taskList, arg_3_1) then
		table.insert(self.taskList, arg_3_1)
	end

	self:UpdateRedPoint()
end

function var_0_0:GetNum()
	return self.drawNum
end

function var_0_0:UpdateRedPoint()
	local var_5_0 = false

	for iter_5_0, iter_5_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID] or {}) do
		if self.drawNum >= ActivityPointRewardCfg[iter_5_1].need and not table.indexof(self.taskList, iter_5_1) then
			var_5_0 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ACCUMULATIVE .. "_" .. tostring(self.activityID), var_5_0 and 1 or 0)
end

function var_0_0:GetList(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_1] or {}) do
		local var_6_1 = {
			state = 0,
			id = iter_6_1
		}

		if self.drawNum >= ActivityPointRewardCfg[iter_6_1].need then
			var_6_1.state = 1
		end

		if table.indexof(self.taskList, iter_6_1) then
			var_6_1.state = 2
		end

		table.insert(var_6_0, var_6_1)
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		local var_7_0

		if ActivityPointRewardCfg[arg_7_0.id] then
			var_7_0 = ActivityPointRewardCfg[arg_7_0.id].need or 0

			local var_7_1

			if ActivityPointRewardCfg[arg_7_1.id] then
				var_7_1 = ActivityPointRewardCfg[arg_7_1.id].need or 0
			end
		end

		return var_7_0 < var_7_1
	end)

	return var_6_0
end

return var_0_0
