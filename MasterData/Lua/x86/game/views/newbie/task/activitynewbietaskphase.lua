local ActivityNewbieTaskPhase = class("ActivityNewbieTaskPhase", ReduxView)

function ActivityNewbieTaskPhase:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")

	self:BindCfgUI()
	self:AddListener()

	self.rewardItemList_ = {}
end

function ActivityNewbieTaskPhase:OnEnter()
	return
end

function ActivityNewbieTaskPhase:OnExit()
	return
end

function ActivityNewbieTaskPhase:Dispose()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)

	for iter_4_0, iter_4_1 in pairs(self.rewardItemList_) do
		iter_4_1:Dispose()
	end

	self.rewardItemList_ = nil

	ActivityNewbieTaskPhase.super.Dispose(self)
end

function ActivityNewbieTaskPhase:AddListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if TaskData2:GetAssignmentPhase() == AssignmentCfg[self.taskID_].phase and TaskTools:GetNewbiePhaseTask()[AssignmentCfg[self.taskID_].phase].progress >= AssignmentCfg[self.taskID_].need then
			-- block empty
		else
			return
		end

		TaskAction:SubmitTask(self.taskID_)
	end)

	self.onSubmitTaskResponseHandle_ = handler(self, self.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.onSubmitTaskResponseHandle_)
end

function ActivityNewbieTaskPhase:onSubmitTaskResponse()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
	self.stateCon_:SetSelectedState("received")

	local var_7_0 = TaskTools:GetNewbiePhaseTask()
	local var_7_1 = TaskData2:GetAssignmentPhase()

	if var_7_1 > #var_7_0 then
		var_7_1 = #var_7_0
	end

	local var_7_2 = 1

	for iter_7_0 = 1, var_7_1 do
		if var_7_0[iter_7_0].id then
			var_7_2 = iter_7_0
		end
	end

	self:SetData(var_7_0[var_7_2].id)
end

function ActivityNewbieTaskPhase:SetData(arg_8_1)
	self.taskID_ = arg_8_1

	self:RefreshUI()
end

function ActivityNewbieTaskPhase:RefreshUI()
	self:RefreshState()
	self:RefreshReward()
	self:RefreshProgress()
end

function ActivityNewbieTaskPhase:RefreshState()
	local var_10_0 = AssignmentCfg[self.taskID_]

	if AssignmentCfg[self.taskID_] then
		local var_10_1 = var_10_0.phase
		local var_10_2 = TaskTools:GetNewbiePhaseTask()[var_10_0.phase].progress >= var_10_0.need

		if var_10_0.phase < TaskData2:GetAssignmentPhase() then
			self.stateCon_:SetSelectedState("received")
		elseif TaskData2:GetAssignmentPhase() == var_10_1 and var_10_2 then
			self.stateCon_:SetSelectedState("receive")
		else
			self.stateCon_:SetSelectedState("lock")
		end
	end
end

function ActivityNewbieTaskPhase:RefreshReward()
	if not self.taskID_ then
		return
	end

	if not AssignmentCfg[self.taskID_] then
		return
	end

	local var_11_0 = AssignmentCfg[self.taskID_].reward

	for iter_11_0 = 1, 2 do
		self[string.format("textRewardCnt%s_", iter_11_0)].text = string.format("x%s", var_11_0[iter_11_0][2])
	end
end

function ActivityNewbieTaskPhase:RefreshProgress()
	local var_12_0 = TaskTools:GetNewbiePhaseTask()[AssignmentCfg[self.taskID_].phase].progress

	if AssignmentCfg[self.taskID_].need < var_12_0 then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	if TaskData2:GetAssignmentPhase() > AssignmentCfg[self.taskID_].phase then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	self.finishTasks_.text = var_12_0
	self.allTasks_.text = "/" .. AssignmentCfg[self.taskID_].need
end

return ActivityNewbieTaskPhase
