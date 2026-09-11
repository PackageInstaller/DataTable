local ActivityReforgeTaskItem = class("ActivityReforgeTaskItem", ReduxView)

function ActivityReforgeTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rewardItems_ = {}

	self:InitUI()
	self:AddListeners()
end

function ActivityReforgeTaskItem:InitUI()
	self:BindCfgUI()

	for iter_2_0 = 1, 3 do
		self.rewardItems_[iter_2_0] = CommonItemView.New(self["rewardItem" .. iter_2_0 .. "_"])
	end

	self.statusController_ = self.controllerEx_:GetController("status")
	self.rewardNumController_ = self.controllerEx_:GetController("reward")
end

function ActivityReforgeTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function ActivityReforgeTaskItem:SetData(arg_5_1)
	if not arg_5_1 then
		return
	end

	self.taskID_ = arg_5_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_5_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_5_1)

	self:RefreshUI()
end

function ActivityReforgeTaskItem:RefreshUI()
	local var_6_0 = AssignmentCfg[self.taskID_]

	self.descText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_6_1 = self.taskProgress >= var_6_0.need

	if self.taskComplete_ then
		self.statusController_:SetSelectedState("received")
	elseif var_6_1 then
		self.statusController_:SetSelectedState("complete")
	else
		self.statusController_:SetSelectedState("unfinish")
	end

	local var_6_2 = var_6_0.reward or {}

	self.rewardNumController_:SetSelectedState(#var_6_2)

	for iter_6_0 = 1, 3 do
		if var_6_2[iter_6_0] then
			local var_6_4 = rewardToItemTemplate((formatReward(var_6_2[iter_6_0])))

			var_6_4.completedFlag = self.taskComplete_
			var_6_4.clickFun = handler(self, self.OnClickCommonItem)

			self.rewardItems_[iter_6_0]:SetData(var_6_4)
		end
	end
end

function ActivityReforgeTaskItem:OnClickCommonItem(arg_7_1)
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function ActivityReforgeTaskItem:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.rewardItems_) do
		if iter_8_1 then
			iter_8_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	ActivityReforgeTaskItem.super.Dispose(self)
end

return ActivityReforgeTaskItem
