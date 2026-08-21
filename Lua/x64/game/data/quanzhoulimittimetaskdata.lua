local var_0_0 = singletonClass("QuanZhouLimitTimeTaskData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageIDGetLevelIDList_ = {}

	for iter_1_0, iter_1_1 in pairs(SkuldStageCfg.all) do
		arg_1_0.stageIDGetLevelIDList_[SkuldStageCfg[iter_1_1].type[2]] = iter_1_1
	end

	arg_1_0.keyList_ = {}

	arg_1_0:InitRedPointGroup()
end

function var_0_0.InitRedPointGroup(arg_2_0)
	local var_2_0 = RedPointConst.QUANZHOU_LIMIT_TASK_ALL
	local var_2_1 = ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK]
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_1.sub_activity_list) do
		local var_2_3 = RedPointConst.QUANZHOU_LIMIT_TASK_TAG .. iter_2_1

		table.insert(var_2_2, var_2_3)
	end

	manager.redPoint:addGroup(var_2_0, var_2_2)

	local var_2_4 = {}

	for iter_2_2, iter_2_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_QUANZHOU_TASK]) do
		local var_2_5 = RedPointConst.QUANZHOU_LIMIT_TASK_ITEM .. iter_2_3

		table.insert(var_2_4, var_2_5)
	end

	manager.redPoint:addGroup(var_2_0, var_2_4)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0:UpdateQuanZhouTaskRedPoint()
		var_0_0:UpdateQuanZhouPointRewardRedPoint()
	end)
end

function var_0_0.UpdateQuanZhouTaskRedPoint(arg_4_0)
	local var_4_0 = ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK]

	for iter_4_0, iter_4_1 in pairs(var_4_0.sub_activity_list) do
		local var_4_1 = 0

		for iter_4_2, iter_4_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_4_1]) do
			local var_4_2 = TaskData2:GetTaskProgress(iter_4_3)
			local var_4_3 = AssignmentCfg[iter_4_3]

			if not TaskData2:GetTaskComplete(iter_4_3) and var_4_2 >= var_4_3.need then
				var_4_1 = 1

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.QUANZHOU_LIMIT_TASK_TAG .. iter_4_1, var_4_1)
	end
end

function var_0_0.UpdateQuanZhouPointRewardRedPoint(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_QUANZHOU_TASK]) do
		local var_5_0 = 0
		local var_5_1 = TaskData2:GetTaskProgress(iter_5_1)
		local var_5_2 = AssignmentCfg[iter_5_1]

		if not TaskData2:GetTaskComplete(iter_5_1) and var_5_1 >= var_5_2.need then
			var_5_0 = 1
		end

		manager.redPoint:setTip(RedPointConst.QUANZHOU_LIMIT_TASK_ITEM .. iter_5_1, var_5_0)
	end
end

return var_0_0
