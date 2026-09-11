local IdolTraineeRewardListItem = class("IdolTraineeRewardListItem", ReduxView)

function IdolTraineeRewardListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeRewardListItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.rewardItems_ = {}
	self.stateController_ = self.mainControllerEx_:GetController("state")
end

function IdolTraineeRewardListItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.taskID_ then
			TaskAction:SubmitTask(self.taskID_)
		end
	end)
end

function IdolTraineeRewardListItem:SetData(arg_5_1)
	self.taskID_ = arg_5_1

	local var_5_0 = AssignmentCfg[arg_5_1]

	self.desc_.text = AssignmentCfg[arg_5_1].desc

	if TaskData2:GetTaskComplete(arg_5_1) then
		self.stateController_:SetSelectedState("received")
	elseif TaskData2:GetTaskProgress(arg_5_1) >= var_5_0.need then
		self.stateController_:SetSelectedState("complete")
	else
		self.stateController_:SetSelectedState("unfinish")
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_0.reward or {}) do
		local var_5_1 = formatReward(iter_5_1)
		local var_5_2 = clone(ItemTemplateData)

		if self.rewardItems_[iter_5_0] == nil then
			self.rewardItems_[iter_5_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_5_0)])
			self.rewardItems_[iter_5_0].ResetTransform = function()
				return
			end
		end

		var_5_2.id = var_5_1.id
		var_5_2.number = var_5_1.num
		var_5_2.timeValid = iter_5_1.timeValid or 0
		var_5_2.completedFlag = self.taskComplete_
		var_5_2.clickFun = handler(self, self.OnClickCommonItem)

		self.rewardItems_[iter_5_0]:SetData(var_5_2)
	end

	for iter_5_2 = #var_5_0.reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_5_2]:SetData(nil)
	end
end

function IdolTraineeRewardListItem:OnClickCommonItem(arg_7_1)
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function IdolTraineeRewardListItem:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.rewardItems_) do
		iter_8_1:Dispose()
	end

	self.rewardItems_ = {}

	IdolTraineeRewardListItem.super.Dispose(self)
end

return IdolTraineeRewardListItem
