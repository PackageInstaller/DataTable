local CommonTaskItemModule = class("CommonTaskItemModule", ReduxView)

function CommonTaskItemModule:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.rewardItemGos_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function CommonTaskItemModule:RefreshTaskItem(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self.taskID_ = arg_2_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshProgress()
	self:RefreshUI()

	self.isShow_ = true
end

function CommonTaskItemModule:OnExit()
	self.isShow_ = false
end

function CommonTaskItemModule:Dispose()
	self:RemoveListeners()

	for iter_4_0, iter_4_1 in pairs(self.rewardItems_) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	CommonTaskItemModule.super.Dispose(self)
end

function CommonTaskItemModule:InitUI()
	self:BindCfgUI()

	self.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	self.controller_ = self.allBtnController_:GetController("all")
end

function CommonTaskItemModule:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if AssignmentCfg[self.taskID_].source then
			JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
		end
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function CommonTaskItemModule:RemoveListeners()
	self.goBtn_.onClick:RemoveAllListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
end

function CommonTaskItemModule:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg[self.taskID_].reward or {}) do
		var_10_0 = var_10_0 + 1

		if var_10_0 > 3 then
			break
		end

		local var_10_1 = rewardToItemTemplate(formatReward(iter_10_1), self.itemData[iter_10_0])

		if self.rewardItems_[iter_10_0] == nil then
			self.rewardItems_[iter_10_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_10_0)])
		end

		var_10_1.grayFlag = self.taskComplete_
		var_10_1.clickFun = handler(self, self.OnClickCommonItem)

		self.rewardItems_[iter_10_0]:SetData(var_10_1)
	end

	for iter_10_2 = #AssignmentCfg[self.taskID_].reward + 1, #self.rewardItems_ do
		if self.rewardItems_[iter_10_2] then
			self.rewardItems_[iter_10_2]:SetData(nil)
		end
	end

	if self.rewardItems_[1] and self.rewardItems_[1].transform_.parent then
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.rewardItems_[1].transform_.parent)
	end
end

function CommonTaskItemModule:RefreshProgress()
	local var_11_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_11_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_11_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_11_0, AssignmentCfg[self.taskID_].need)

	local var_11_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.controller_:SetSelectedState("complete")
	elseif var_11_1 then
		self.controller_:SetSelectedState("receive")
	else
		self.controller_:SetSelectedState("go")
	end
end

function CommonTaskItemModule:OnClickCommonItem(arg_12_1)
	ShowPopItem(POP_ITEM, {
		arg_12_1.id,
		arg_12_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return CommonTaskItemModule
