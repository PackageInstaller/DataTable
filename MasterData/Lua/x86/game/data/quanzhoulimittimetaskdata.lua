local var_0_0 = singletonClass("QuanZhouLimitTimeTaskData")

function var_0_0:Init()
	self.stageIDGetLevelIDList_ = {}

	for iter_1_0, iter_1_1 in pairs(SkuldStageCfg.all) do
		self.stageIDGetLevelIDList_[SkuldStageCfg[iter_1_1].type[2]] = iter_1_1
	end

	self.keyList_ = {}

	self:InitRedPointGroup()
end

function var_0_0.InitRedPointGroup(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK].sub_activity_list) do
		table.insert(var_2_0, RedPointConst.QUANZHOU_LIMIT_TASK_TAG .. iter_2_1)
	end

	manager.redPoint:addGroup(RedPointConst.QUANZHOU_LIMIT_TASK_ALL, var_2_0)

	local var_2_1 = {}

	for iter_2_2, iter_2_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_QUANZHOU_TASK]) do
		table.insert(var_2_1, RedPointConst.QUANZHOU_LIMIT_TASK_ITEM .. iter_2_3)
	end

	manager.redPoint:addGroup(RedPointConst.QUANZHOU_LIMIT_TASK_ALL, var_2_1)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0:UpdateQuanZhouTaskRedPoint()
		var_0_0:UpdateQuanZhouPointRewardRedPoint()
	end)
end

function var_0_0.UpdateQuanZhouTaskRedPoint(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK].sub_activity_list) do
		local var_4_0 = 0

		for iter_4_2, iter_4_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_4_1]) do
			if not TaskData2:GetTaskComplete(iter_4_3) and TaskData2:GetTaskProgress(iter_4_3) >= AssignmentCfg[iter_4_3].need then
				var_4_0 = 1

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.QUANZHOU_LIMIT_TASK_TAG .. iter_4_1, var_4_0)
	end
end

function var_0_0.UpdateQuanZhouPointRewardRedPoint(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_QUANZHOU_TASK]) do
		manager.redPoint:setTip(RedPointConst.QUANZHOU_LIMIT_TASK_ITEM .. iter_5_1, (not TaskData2:GetTaskComplete(iter_5_1) and TaskData2:GetTaskProgress(iter_5_1) >= AssignmentCfg[iter_5_1].need or nil) and 1)
	end
end

return var_0_0
