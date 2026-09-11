local AlphaTaskItem = class("AlphaTaskItem", ReduxView)
local var_0_1 = {
	"complete",
	"incomplete",
	"lock",
	"finish"
}

function AlphaTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")

	self:InitUI()
	self:AddListeners()
end

function AlphaTaskItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
end

function AlphaTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self:GetTaskID()].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self:GetTaskID())
	end)
end

function AlphaTaskItem:OnEnter()
	return
end

function AlphaTaskItem:GetTaskID()
	return self.taskID_
end

function AlphaTaskItem:GetAlphaTaskStage()
	return TaskData2:GetAssignmentPhase()
end

function AlphaTaskItem:GetTaskComplete()
	local var_9_0 = TaskData2:GetTask(self.taskID_)

	return var_9_0 == nil or var_9_0.complete_flag >= 1
end

function AlphaTaskItem:GetTaskProgress()
	local var_10_0 = TaskData2:GetTask(self.taskID_)

	return (var_10_0 or nil) and (var_10_0.progress or 0)
end

function AlphaTaskItem:RefreshUI(arg_11_1)
	if arg_11_1 then
		self.taskID_ = arg_11_1
	end

	self:RefreshTitle()
	self:RefreshState()
	self:RefreshReward()
	self:RefreshProgress()
end

function AlphaTaskItem:RefreshTitle()
	self.titleText_.text = GetI18NText(AssignmentCfg[self:GetTaskID()].desc)
end

function AlphaTaskItem:RefreshState()
	self.state_ = self:GetItemState()

	self:ChangeState(self.state_)
end

function AlphaTaskItem:ChangeState(arg_14_1)
	self.stateCon_:SetSelectedState(arg_14_1)
end

function AlphaTaskItem:GetItemState()
	if AssignmentCfg[self:GetTaskID()].phase > self:GetAlphaTaskStage() then
		return var_0_1[3]
	end

	if self:GetTaskComplete() then
		return var_0_1[4]
	end

	if AssignmentCfg[self:GetTaskID()].need > self:GetTaskProgress() then
		return var_0_1[2]
	else
		return var_0_1[1]
	end
end

function AlphaTaskItem:RefreshReward()
	local var_16_0 = AssignmentCfg[self:GetTaskID()].reward

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if self.rewardItems_[iter_16_0] == nil then
			self.rewardItems_[iter_16_0] = RewardItem.New(self.rewardTemplate_, self.rewardParent_, true)

			self.rewardItems_[iter_16_0]:UpdateCommonItemAni()
			self.rewardItems_[iter_16_0].commonItem_:RegistCallBack(function()
				OperationRecorder.Record("test_activity", "test_item")
			end)
		end

		self.rewardItems_[iter_16_0]:SetData(iter_16_1)
	end

	for iter_16_2 = #var_16_0 + 1, #self.rewardItems_ do
		self.rewardItems_[iter_16_2]:Show(false)
	end
end

function AlphaTaskItem:RefreshProgress()
	local var_18_0 = AssignmentCfg[self:GetTaskID()].need
	local var_18_1 = self:GetTaskProgress()

	if var_18_0 < var_18_1 then
		var_18_1 = var_18_0
	end

	if self:GetTaskComplete() then
		var_18_1 = var_18_0
	end

	self.progressBar_.fillAmount = var_18_1 / var_18_0
	self.progressText_.text = string.format("%s/%s", var_18_1, var_18_0)
end

function AlphaTaskItem:Hide()
	SetActive(self.gameObject_, false)
end

function AlphaTaskItem:OnExit()
	return
end

function AlphaTaskItem:SetSiblingIndex(arg_21_1)
	self.transform_:SetSiblingIndex(arg_21_1)
end

function AlphaTaskItem:Dispose()
	self:RemoveAllListeners()

	if self.rewardItems_ then
		for iter_22_0 = #self.rewardItems_, 1, -1 do
			self.rewardItems_[iter_22_0]:Dispose()

			self.rewardItems_[iter_22_0] = nil
		end

		self.rewardItems_ = nil
	end

	AlphaTaskItem.super.Dispose(self)
end

return AlphaTaskItem
