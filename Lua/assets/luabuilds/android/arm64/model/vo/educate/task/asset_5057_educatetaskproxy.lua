local EducateTaskProxy = class("EducateTaskProxy")

EducateTaskProxy.TASK_ADDED = "EducateTaskProxy.TASK_ADDED"
EducateTaskProxy.TASK_REMOVED = "EducateTaskProxy.TASK_REMOVED"
EducateTaskProxy.TASK_UPDATED = "EducateTaskProxy.TASK_UPDATED"

function EducateTaskProxy:Ctor(arg_1_1)
	self.binder = arg_1_1
	self.data = {}
	self.targetSetDays = {}

	for iter_1_0, iter_1_1 in ipairs(pg.gameset.child_target_set_date.description) do
		self.targetSetDays[iter_1_0] = EducateHelper.GetTimeFromCfg(iter_1_1)
	end

	return
end

function EducateTaskProxy:SetUp(arg_2_1)
	self.data = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.tasks or {}) do
		self.data[iter_2_1.id] = EducateTask.New(iter_2_1)
	end

	self:SetTarget(arg_2_1.targetId or 0)

	self.finishMindTaskIds = arg_2_1.finishMindTaskIds
	self.isGotTargetAward = arg_2_1.isGotTargetAward

	return
end

function EducateTaskProxy:UpdateTargetAwardStatus(arg_3_1)
	self.isGotTargetAward = arg_3_1

	return
end

function EducateTaskProxy:CanGetTargetAward()
	return not self.isGotTargetAward
end

function EducateTaskProxy:AddTask(arg_5_1)
	local var_5_0 = EducateTask.New(arg_5_1)

	self.data[var_5_0.id] = var_5_0

	if var_5_0:IsMind() then
		EducateTipHelper.SetNewTip(EducateTipHelper.NEW_MIND_TASK)
	end

	self.binder:sendNotification(EducateTaskProxy.TASK_ADDED)

	return
end

function EducateTaskProxy:RemoveTaskById(arg_6_1)
	self.data[arg_6_1] = nil

	self.binder:sendNotification(EducateTaskProxy.TASK_REMOVED)

	return
end

function EducateTaskProxy:UpdateTask(arg_7_1)
	if self.data[arg_7_1.id] == nil then
		return
	end

	self.data[arg_7_1.id].progress = arg_7_1.progress

	self.binder:sendNotification(EducateTaskProxy.TASK_UPDATED)

	return
end

function EducateTaskProxy:GetTasksBySystem(arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self.data) do
		if iter_8_1:GetSystemType() == arg_8_1 then
			table.insert(var_8_0, iter_8_1:clone())
		end
	end

	return var_8_0
end

function EducateTaskProxy:GetTaskById(arg_9_1)
	return self.data[arg_9_1] and self.data[arg_9_1]:clone() or nil
end

function EducateTaskProxy:SetTarget(arg_10_1)
	self.targetId = arg_10_1
	self.targetTaskIds = self.targetId == 0 and {} or pg.child_target_set[self.targetId].ids

	return
end

function EducateTaskProxy:GetTargetId()
	return self.targetId
end

function EducateTaskProxy:GetTargetSetDays()
	return self.targetSetDays
end

function EducateTaskProxy:CheckTargetSet()
	if self.targetId == 0 then
		return true
	end

	local var_13_0 = getProxy(EducateProxy):GetCurTime()

	for iter_13_0, iter_13_1 in pairs(self.targetSetDays) do
		if EducateHelper.IsSameDay(iter_13_1, var_13_0) then
			return pg.child_target_set[self.targetId].stage ~= iter_13_0
		end
	end

	return false
end

function EducateTaskProxy:GetTargetTasksForShow()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.targetTaskIds) do
		if self.data[iter_14_1] and not self.isGotTargetAward then
			table.insert(var_14_0, self:GetTaskById(iter_14_1))
		else
			local var_14_1 = EducateTask.New({
				id = iter_14_1
			})

			var_14_1:SetRecieve()
			table.insert(var_14_0, var_14_1)
		end
	end

	return var_14_0
end

function EducateTaskProxy:GetMainTasksForShow()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(pg.child_task.all) do
		if pg.child_task[iter_15_1].type_1 == EducateTask.STSTEM_TYPE_MAIN then
			if self.data[iter_15_1] then
				table.insert(var_15_0, self:GetTaskById(iter_15_1))
			else
				local var_15_1 = EducateTask.New({
					id = iter_15_1
				})

				if var_15_1:InTime() then
					var_15_1:SetRecieve()
					table.insert(var_15_0, var_15_1)
				end
			end
		end
	end

	return var_15_0
end

function EducateTaskProxy:FilterByGroup(arg_16_1, arg_16_2)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_1 = iter_16_1:getConfig("group")

		var_16_0[var_16_1] = var_16_0[var_16_1] or {}

		table.insert(var_16_0[var_16_1], iter_16_1)
	end

	local var_16_2 = {}

	for iter_16_2, iter_16_3 in pairs(var_16_0) do
		table.sort(iter_16_3, CompareFuncs({
			function(arg_17_0)
				return arg_17_0:IsReceive() and 1 or 0
			end,
			function(arg_18_0)
				return -arg_18_0:getConfig("order")
			end,
			function(arg_19_0)
				return -arg_19_0.id
			end
		}))

		if arg_16_2 then
			if underscore.any(iter_16_3, function(arg_20_0)
				return not arg_20_0:IsReceive()
			end) then
				table.insert(var_16_2, iter_16_3[1])
			end
		else
			table.insert(var_16_2, iter_16_3[1])
		end
	end

	table.sort(var_16_2, CompareFuncs({
		function(arg_21_0)
			return arg_21_0:IsReceive() and 1 or 0
		end,
		function(arg_22_0)
			return arg_22_0:IsFinish() and 0 or 1
		end,
		function(arg_23_0)
			return arg_23_0:getConfig("group")
		end,
		function(arg_24_0)
			return -arg_24_0.id
		end
	}))

	return var_16_2
end

function EducateTaskProxy:GetOtherTargetTaskProgress()
	if self.targetId == 0 then
		return 0, 0
	end

	return underscore.reduce(pg.child_target_set[self.targetId].ids, 0, function(arg_26_0, arg_26_1)
		return arg_26_0 + (self.data[arg_26_1] and 0 or pg.child_task[arg_26_1].task_target_progress)
	end), pg.child_target_set[self.targetId].target_progress
end

function EducateTaskProxy:GetMainTargetTaskProgress()
	local var_27_0 = 0
	local var_27_1 = 0

	for iter_27_0, iter_27_1 in ipairs(pg.child_task.all) do
		if pg.child_task[iter_27_1].type_1 == EducateTask.STSTEM_TYPE_MAIN then
			if self.data[iter_27_1] then
				var_27_0 = var_27_0 + 1
			elseif EducateTask.New({
				id = iter_27_1
			}):InTime() then
				var_27_1 = var_27_1 + 1
				var_27_0 = var_27_0 + 1
			end
		end
	end

	return var_27_1, var_27_0
end

function EducateTaskProxy:GetShowTargetTasks()
	local var_28_0 = self:FilterByGroup(self:GetTargetTasksForShow())

	table.sort(var_28_0, CompareFuncs({
		function(arg_29_0)
			return arg_29_0:IsReceive() and 1 or 0
		end,
		function(arg_30_0)
			return -arg_30_0:getConfig("order")
		end,
		function(arg_31_0)
			return -arg_31_0.id
		end
	}))

	return var_28_0
end

function EducateTaskProxy:GetSiteEnterAddTasks(arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(self.data) do
		if iter_32_1:NeedAddProgressFromSiteEnter() and EducateHelper.IsMatchSubType(iter_32_1:getConfig("sub_type"), arg_32_1) then
			table.insert(var_32_0, iter_32_1:clone())
		end
	end

	return var_32_0
end

function EducateTaskProxy:GetPerformAddTasks(arg_33_1)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self.data) do
		if iter_33_1:NeedAddProgressFromPerform() and EducateHelper.IsMatchSubType(iter_33_1:getConfig("sub_type"), arg_33_1) then
			table.insert(var_33_0, iter_33_1:clone())
		end
	end

	return var_33_0
end

function EducateTaskProxy:OnNewWeek()
	return
end

function EducateTaskProxy:IsShowMindTasksTip()
	for iter_35_0, iter_35_1 in pairs(self.data) do
		if iter_35_1:IsMind() and iter_35_1:IsFinish() then
			return true
		end
	end

	return false
end

function EducateTaskProxy:IsShowMainTasksTip()
	local var_36_0 = self:FilterByGroup(self:GetMainTasksForShow())[1]

	return var_36_0 and not var_36_0:IsReceive() and var_36_0:IsFinish()
end

function EducateTaskProxy:IsShowTargetTasksTip()
	for iter_37_0, iter_37_1 in pairs(self.data) do
		if iter_37_1:IsTarget() and iter_37_1:IsFinish() then
			return true
		end
	end

	return false
end

function EducateTaskProxy:IsShowOtherTasksTip()
	if self:IsShowMainTasksTip() then
		return true
	end

	if self.isGotTargetAward then
		return false
	end

	local var_38_0, var_38_1 = self:GetOtherTargetTaskProgress()

	if var_38_0 / var_38_1 >= 1 then
		return true
	end

	return self:IsShowTargetTasksTip()
end

return EducateTaskProxy
