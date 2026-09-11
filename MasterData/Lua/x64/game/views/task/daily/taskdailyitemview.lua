local TaskDailyItemView = class("TaskDailyItemView", ReduxView)
local JumpTools = import("game.tools.JumpTools")

function TaskDailyItemView:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.rewardItemGos_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function TaskDailyItemView:ReEnter(arg_2_1)
	self.taskID_ = arg_2_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshProgress()
	self:RefreshUI()

	self.isShow_ = true
end

function TaskDailyItemView:OnExit()
	self.isShow_ = false
end

function TaskDailyItemView:Dispose()
	self:RemoveListeners()

	for iter_4_0, iter_4_1 in pairs(self.rewardItems_) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	TaskDailyItemView.super.Dispose(self)
end

function TaskDailyItemView:InitUI()
	self:BindCfgUI()

	self.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	self.controller_ = self.allBtnController_:GetController("all")
end

function TaskDailyItemView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "goBtn")
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		OperationRecorder.Record(self.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function TaskDailyItemView:RemoveListeners()
	self.goBtn_.onClick:RemoveAllListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
end

function TaskDailyItemView:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg[self.taskID_].reward or {}) do
		local var_10_0 = formatReward(iter_10_1)

		if self.rewardItems_[iter_10_0] == nil then
			self.rewardItems_[iter_10_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_10_0)])
			self.rewardItems_[iter_10_0].ResetTransform = function()
				return
			end
		end

		self.itemData[iter_10_0].id = var_10_0.id
		self.itemData[iter_10_0].number = var_10_0.num
		self.itemData[iter_10_0].timeValid = iter_10_1.timeValid or 0
		self.itemData[iter_10_0].grayFlag = self.taskComplete_
		self.itemData[iter_10_0].clickFun = handler(self, self.OnClickCommonItem)

		self.rewardItems_[iter_10_0]:SetData(self.itemData[iter_10_0])
	end

	for iter_10_2 = #AssignmentCfg[self.taskID_].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_2]:SetData(nil)
	end
end

function TaskDailyItemView:RefreshProgress()
	local var_12_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_12_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_12_0, AssignmentCfg[self.taskID_].need)

	local var_12_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.controller_:SetSelectedState("complete")
	elseif var_12_1 then
		self.controller_:SetSelectedState("receive")
	else
		self.controller_:SetSelectedState("go")
	end
end

function TaskDailyItemView:RefreshComplete()
	return
end

function TaskDailyItemView:SetSibling(arg_14_1)
	return
end

function TaskDailyItemView:OnClickCommonItem(arg_15_1)
	ShowPopItem(POP_ITEM, {
		arg_15_1.id,
		arg_15_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return TaskDailyItemView
