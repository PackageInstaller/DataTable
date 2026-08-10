local var_0_0 = class("CaptureTaskMgr", CaptureLogicMgrBase)

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.context = {
		anyDirty = true,
		taskList = {},
		taskMap = {},
		taskShot = {},
		recommendAnimMap = {}
	}

	arg_2_0:InitSection()
end

function var_0_0.InitSection(arg_3_0)
	if CaptureGameMgr:IsFreeCapture() then
		return
	end

	local var_3_0 = CaptureGameHelper:GetTaskBySectionId(CaptureGameMgr:GetSectionId()) or {}

	arg_3_0.context.taskList = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = CaptureGameHelper:GetConditionByTask(iter_3_1)

		if not var_3_1 then
			Debug.LogError("找不到任务: " .. iter_3_1)
		end

		table.insert(arg_3_0.context.taskList, {
			reached = false,
			isDirty = true,
			taskId = iter_3_1,
			taskCfg = var_3_1,
			params = var_3_1.params
		})

		arg_3_0.context.taskMap[iter_3_1] = iter_3_0
	end

	arg_3_0.context.anyDirty = true

	arg_3_0:CollectRecommendAnim()
end

function var_0_0.GetTaskList(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.context.taskList) do
		table.insert(var_4_0, iter_4_1.taskId)
	end

	return var_4_0
end

function var_0_0.SetTaskDirty(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.context.taskMap[arg_5_1]

	if var_5_0 then
		arg_5_0.context.taskList[var_5_0] = true
		arg_5_0.context.anyDirty = true
	end
end

function var_0_0.ExecuteTask(arg_6_0)
	if not CaptureGameMgr:AlreadyPrepare() then
		return
	end

	if not arg_6_0.context.anyDirty then
		return
	end

	local var_6_0 = arg_6_0.context.taskList
	local var_6_1 = false

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_2 = iter_6_1.reached

		if iter_6_1.isDirty then
			iter_6_1.reached = true

			if not arg_6_0:CheckConditionReached(iter_6_1) then
				iter_6_1.reached = false
			end
		end

		if iter_6_1.reached ~= var_6_2 then
			var_6_1 = true
		end
	end

	if var_6_1 then
		manager.notify:Invoke(CAPTURE_GAME_TASK_UPDATE)
	end
end

function var_0_0.CheckConditionReached(arg_7_0, arg_7_1)
	return (CaptureGameHelper:GetConditionExecutorById(arg_7_1.taskCfg.type):CheckCondition(arg_7_1.params))
end

function var_0_0.CheckTaskCompelete(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.context.taskMap[arg_8_1]

	if var_8_0 then
		return arg_8_0.context.taskList[var_8_0].reached
	end

	return false
end

function var_0_0.MakeTaskShot(arg_9_0)
	arg_9_0.context.taskShot = {}

	local var_9_0 = arg_9_0.context.taskList

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		table.insert(arg_9_0.context.taskShot, {
			taskId = iter_9_1.taskId,
			reached = arg_9_0:CheckTaskCompelete(iter_9_1.taskId)
		})
	end
end

function var_0_0.CollectRecommendAnim(arg_10_0)
	local var_10_0 = arg_10_0.context.taskList
	local var_10_1 = arg_10_0.context.recommendAnimMap

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_2 = CaptureGameHelper:GetConditionExecutorById(iter_10_1.taskCfg.type):GetConditionRecoomendAnim(iter_10_1.params) or {}

		for iter_10_2, iter_10_3 in ipairs(var_10_2) do
			var_10_1[iter_10_3] = true
		end
	end
end

function var_0_0.AnimIsRecommend(arg_11_0, arg_11_1)
	return arg_11_0.context.recommendAnimMap[arg_11_1] or false
end

function var_0_0.GetTaskShot(arg_12_0)
	return arg_12_0.context.taskShot
end

function var_0_0.Dispose(arg_13_0)
	return
end

return var_0_0
