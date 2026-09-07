local WeekTaskProgress = class("WeekTaskProgress", import("..BaseVO"))

function WeekTaskProgress:Ctor()
	return
end

function WeekTaskProgress:Init(arg_2_1)
	self.targets = {}
	self.dropData = {}
	self.index = 0
	self.target = 0
	self.progress = 0
	self.drops = {}
	self.subTasks = {}
	self.targets = pg.gameset.weekly_target.description
	self.dropData = pg.gameset.weekly_drop_client.description
	self.progress = arg_2_1.pt or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.task) do
		local var_2_0 = WeekPtTask.New(iter_2_1)

		self.subTasks[var_2_0.id] = var_2_0
	end

	self:UpdateTarget(table.indexof(self.targets, arg_2_1.reward_lv) or 0)

	return
end

function WeekTaskProgress:IsMaximum()
	return self.index >= #self.targets
end

function WeekTaskProgress:UpdateTarget(arg_4_1)
	self.index = arg_4_1
	self.target = self.targets[arg_4_1 + 1] or self.targets[#self.targets]
	self.drops = self.dropData[arg_4_1 + 1] or self.dropData[#self.dropData]

	return
end

function WeekTaskProgress:CanUpgrade()
	return self.progress >= self.target and not self:IsMaximum()
end

function WeekTaskProgress:Upgrade()
	if self:CanUpgrade() then
		self:UpdateTarget(self.index + 1)
	end

	return
end

function WeekTaskProgress:GetDropList()
	return self.drops
end

function WeekTaskProgress:GetPhase()
	return math.min(self.index + 1, #self.targets)
end

function WeekTaskProgress:GetTotalPhase()
	return #self.targets
end

function WeekTaskProgress:GetProgress()
	return self.progress
end

function WeekTaskProgress:GetTarget()
	return self.target
end

function WeekTaskProgress:UpdateProgress(arg_12_1)
	self.progress = arg_12_1

	return
end

function WeekTaskProgress:AddProgress(arg_13_1)
	self.progress = self.progress + arg_13_1

	return
end

function WeekTaskProgress:GetAllPhaseDrops()
	return {
		type = 1,
		resIcon = "Props/weekly_pt",
		dropList = self.dropData,
		targets = self.targets,
		level = self.index,
		count = self.progress,
		resName = i18n("week_task_pt_name")
	}
end

function WeekTaskProgress:ReachMaxPt()
	return self.targets[#self.targets] <= self.progress
end

function WeekTaskProgress:GetSubTasks()
	return self.subTasks
end

function WeekTaskProgress:RemoveSubTasks(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		self:RemoveSubTask(iter_17_1)
	end

	return
end

function WeekTaskProgress:RemoveSubTask(arg_18_1)
	self.subTasks[arg_18_1] = nil

	return
end

function WeekTaskProgress:AddSubTask(arg_19_1)
	self.subTasks[arg_19_1.id] = arg_19_1

	return
end

function WeekTaskProgress:UpdateSubTask(arg_20_1)
	assert(self.subTasks[arg_20_1.id], "should exist task >> " .. arg_20_1.id)

	self.subTasks[arg_20_1.id] = arg_20_1

	return
end

function WeekTaskProgress:GetSubTask(arg_21_1)
	return self.subTasks[arg_21_1]
end

function WeekTaskProgress:AnySubTaskCanSubmit()
	if self:ReachMaxPt() then
		return false
	end

	for iter_22_0, iter_22_1 in pairs(self.subTasks) do
		if iter_22_1:isFinish() then
			return true
		end
	end

	return false
end

function WeekTaskProgress:GetCanSubmitSubTaskCnt()
	if self:ReachMaxPt() then
		return 0
	end

	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(self.subTasks) do
		if iter_23_1:isFinish() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

return WeekTaskProgress
