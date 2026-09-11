local CaptureTaskMgr = class("CaptureTaskMgr", CaptureLogicMgrBase)

function CaptureTaskMgr:Ctor()
	self:Init()
end

function CaptureTaskMgr:Init()
	self.context = {
		anyDirty = true,
		taskList = {},
		taskMap = {},
		taskShot = {},
		recommendAnimMap = {}
	}

	self:InitSection()
end

function CaptureTaskMgr:InitSection()
	if CaptureGameMgr:IsFreeCapture() then
		return
	end

	self.context.taskList = {}

	for iter_3_0, iter_3_1 in ipairs(CaptureGameHelper:GetTaskBySectionId(CaptureGameMgr:GetSectionId()) or {}) do
		local var_3_0 = CaptureGameHelper:GetConditionByTask(iter_3_1)

		if not var_3_0 then
			Debug.LogError("找不到任务: " .. iter_3_1)
		end

		table.insert(self.context.taskList, {
			reached = false,
			isDirty = true,
			taskId = iter_3_1,
			taskCfg = var_3_0,
			params = var_3_0.params
		})

		self.context.taskMap[iter_3_1] = iter_3_0
	end

	self.context.anyDirty = true

	self:CollectRecommendAnim()
end

function CaptureTaskMgr:GetTaskList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.context.taskList) do
		table.insert(var_4_0, iter_4_1.taskId)
	end

	return var_4_0
end

function CaptureTaskMgr:SetTaskDirty(arg_5_1)
	if self.context.taskMap[arg_5_1] then
		self.context.taskList[self.context.taskMap[arg_5_1]] = true
		self.context.anyDirty = true
	end
end

function CaptureTaskMgr:ExecuteTask()
	if not CaptureGameMgr:AlreadyPrepare() then
		return
	end

	local var_6_0

	if not self.context.anyDirty then
		do return end

		var_6_0 = false
	end

	for iter_6_0, iter_6_1 in ipairs(self.context.taskList) do
		if iter_6_1.isDirty then
			iter_6_1.reached = true

			if not self:CheckConditionReached(iter_6_1) then
				iter_6_1.reached = false
			end
		end

		if iter_6_1.reached ~= iter_6_1.reached then
			var_6_0 = true
		end
	end

	if var_6_0 then
		manager.notify:Invoke(CAPTURE_GAME_TASK_UPDATE)
	end
end

function CaptureTaskMgr:CheckConditionReached(arg_7_1)
	return (CaptureGameHelper:GetConditionExecutorById(arg_7_1.taskCfg.type):CheckCondition(arg_7_1.params))
end

function CaptureTaskMgr:CheckTaskCompelete(arg_8_1)
	if self.context.taskMap[arg_8_1] then
		return self.context.taskList[self.context.taskMap[arg_8_1]].reached
	end

	return false
end

function CaptureTaskMgr:MakeTaskShot()
	self.context.taskShot = {}

	for iter_9_0, iter_9_1 in ipairs(self.context.taskList) do
		table.insert(self.context.taskShot, {
			taskId = iter_9_1.taskId,
			reached = self:CheckTaskCompelete(iter_9_1.taskId)
		})
	end
end

function CaptureTaskMgr:CollectRecommendAnim()
	for iter_10_0, iter_10_1 in ipairs(self.context.taskList) do
		local var_10_0 = CaptureGameHelper:GetConditionExecutorById(iter_10_1.taskCfg.type):GetConditionRecoomendAnim(iter_10_1.params)

		var_10_0 = var_10_0 or {}

		for iter_10_2, iter_10_3 in ipairs(var_10_0) do
			self.context.recommendAnimMap[iter_10_3] = true
		end
	end
end

function CaptureTaskMgr:AnimIsRecommend(arg_11_1)
	return self.context.recommendAnimMap[arg_11_1] or false
end

function CaptureTaskMgr:GetTaskShot()
	return self.context.taskShot
end

function CaptureTaskMgr:Dispose()
	return
end

return CaptureTaskMgr
