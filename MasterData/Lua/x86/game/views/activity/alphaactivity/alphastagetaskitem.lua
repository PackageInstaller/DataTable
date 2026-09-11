local AlphaStageTaskItem = class("AlphaStageTaskItem", ReduxView)
local var_0_1 = {
	"lock",
	"receive",
	"received"
}

function AlphaStageTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")

	self:InitUI()
	self:AddUIListeners()
end

function AlphaStageTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItemS_ = {}
end

function AlphaStageTaskItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
		self:ChangeState("received")
	end)
end

function AlphaStageTaskItem:OnEnter()
	return
end

function AlphaStageTaskItem:GetTaskID()
	return self.taskID_
end

function AlphaStageTaskItem:GetTaskProgress()
	local var_7_0 = TaskData2:GetTask(self.taskID_)

	return (var_7_0 or nil) and (var_7_0.progress or 0)
end

function AlphaStageTaskItem:RefreshUI(arg_8_1)
	self.taskID_ = arg_8_1

	SetActive(self.gameObject_, true)
	self:RefreshState()
	self:RefreshReward()
	self:RefreshProgress()
end

function AlphaStageTaskItem:RefreshState()
	self.stage_ = AssignmentCfg[self.taskID_].phase

	if TaskData2:GetAssignmentPhase() > self.stage_ then
		self:ChangeState("received")
	elseif TaskData2:GetAssignmentPhase() == self.stage_ and self:IsTaskFinish() then
		self:ChangeState("receive")
	else
		self:ChangeState("lock")
	end
end

function AlphaStageTaskItem:ChangeState(arg_10_1)
	self.stateCon_:SetSelectedState(arg_10_1)
end

function AlphaStageTaskItem:IsTaskFinish()
	return TaskData2:GetTask(self.taskID_).progress >= AssignmentCfg[self.taskID_].need
end

function AlphaStageTaskItem:RefreshReward()
	local var_12_0 = AssignmentCfg[self:GetTaskID()].reward

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if self.rewardItemS_[iter_12_0] == nil then
			self.rewardItemS_[iter_12_0] = RewardItem.New(self.rewardTemplates_, self.rewardParent_, true)

			self.rewardItemS_[iter_12_0]:UpdateCommonItemAni()
		end

		self.rewardItemS_[iter_12_0]:SetData(iter_12_1)
	end

	for iter_12_2 = #var_12_0 + 1, #self.rewardItemS_ do
		self.rewardItemS_[iter_12_2]:Show(false)
	end
end

function AlphaStageTaskItem:RefreshProgress()
	local var_13_0 = AssignmentCfg[self:GetTaskID()].need
	local var_13_1 = self:GetTaskProgress()

	if var_13_0 < var_13_1 then
		var_13_1 = var_13_0
	end

	if TaskData2:GetAssignmentPhase() > self.stage_ then
		var_13_1 = var_13_0
	end

	self.finishTasks_.text = var_13_1
	self.allTasks_.text = "/" .. var_13_0
end

function AlphaStageTaskItem:OnSubcribe()
	self:RefreshProgress()
	self:RefreshState()
end

function AlphaStageTaskItem:OnExit()
	return
end

function AlphaStageTaskItem:Dispose()
	self:RemoveAllListeners()

	for iter_16_0 = 1, 3 do
		self[var_0_1[iter_16_0]] = nil
	end

	for iter_16_1 = 1, #self.rewardItemS_ do
		self.rewardItemS_[iter_16_1]:Dispose()

		self.rewardItemS_[iter_16_1] = nil
	end

	self.rewardItemS_ = nil

	AlphaStageTaskItem.super.Dispose(self)
end

return AlphaStageTaskItem
