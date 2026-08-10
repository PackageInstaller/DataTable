local var_0_0 = singletonClass("ActivityAccumulativeData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.drawNum = 0
	arg_1_0.taskList = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.activityID = arg_2_1.activity_id
	arg_2_0.drawNum = arg_2_1.point
	arg_2_0.taskList = arg_2_1.reward_list or {}

	arg_2_0:UpdateRedPoint()
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	if not table.indexof(arg_3_0.taskList, arg_3_1) then
		table.insert(arg_3_0.taskList, arg_3_1)
	end

	arg_3_0:UpdateRedPoint()
end

function var_0_0.GetNum(arg_4_0)
	return arg_4_0.drawNum
end

function var_0_0.UpdateRedPoint(arg_5_0)
	local var_5_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_5_0.activityID]
	local var_5_1 = false

	for iter_5_0, iter_5_1 in ipairs(var_5_0 or {}) do
		if arg_5_0.drawNum >= ActivityPointRewardCfg[iter_5_1].need and not table.indexof(arg_5_0.taskList, iter_5_1) then
			var_5_1 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ACCUMULATIVE .. "_" .. tostring(arg_5_0.activityID), var_5_1 and 1 or 0)
end

function var_0_0.GetList(arg_6_0, arg_6_1)
	local var_6_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_1]
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0 or {}) do
		local var_6_2 = {
			state = 0,
			id = iter_6_1
		}

		if arg_6_0.drawNum >= ActivityPointRewardCfg[iter_6_1].need then
			var_6_2.state = 1
		end

		if table.indexof(arg_6_0.taskList, iter_6_1) then
			var_6_2.state = 2
		end

		table.insert(var_6_1, var_6_2)
	end

	table.sort(var_6_1, function(arg_7_0, arg_7_1)
		return (ActivityPointRewardCfg[arg_7_0.id] and ActivityPointRewardCfg[arg_7_0.id].need or 0) < (ActivityPointRewardCfg[arg_7_1.id] and ActivityPointRewardCfg[arg_7_1.id].need or 0)
	end)

	return var_6_1
end

return var_0_0
