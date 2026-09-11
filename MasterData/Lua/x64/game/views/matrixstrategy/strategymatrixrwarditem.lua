local StrategyMatrixRwardItem = class("StrategyMatrixRwardItem", ReduxView)

function StrategyMatrixRwardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.rewardItems_ = {}

	self:Init()
end

function StrategyMatrixRwardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrategyMatrixRwardItem:InitUI()
	self:BindCfgUI()

	for iter_3_0 = 1, 2 do
		self.rewardItems_[iter_3_0] = CommonItemView.New(self["awardItem" .. iter_3_0 + 1 .. "Obj_"])
	end

	self.stateController_ = self.allBtnController_:GetController("all")
end

function StrategyMatrixRwardItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function StrategyMatrixRwardItem:SetData(arg_6_1)
	self.taskID_ = arg_6_1.id
	self.taskProgress = arg_6_1.progress
	self.taskComplete_ = arg_6_1.complete_flag >= 1

	self:RefreshUI()
	self:RefreshProgress()
end

function StrategyMatrixRwardItem:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_7_0 = AssignmentCfg[self.taskID_].reward or {}

	for iter_7_0 = 1, 2 do
		if var_7_0[iter_7_0] then
			local var_7_2 = rewardToItemTemplate((formatReward(var_7_0[iter_7_0])))

			var_7_2.completedFlag = self.taskComplete_
			var_7_2.clickFun = handler(self, self.OnClickCommonItem)

			self.rewardItems_[iter_7_0]:SetData(var_7_2)
		end
	end
end

function StrategyMatrixRwardItem:RefreshProgress()
	local var_8_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_8_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_8_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_8_0, AssignmentCfg[self.taskID_].need)

	local var_8_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.stateController_:SetSelectedState("complete")
	elseif var_8_1 then
		self.stateController_:SetSelectedState("receive")
	else
		self.stateController_:SetSelectedState("lock")
	end
end

function StrategyMatrixRwardItem:OnClickCommonItem(arg_9_1)
	ShowPopItem(POP_ITEM, {
		arg_9_1.id,
		arg_9_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function StrategyMatrixRwardItem:Dispose()
	for iter_10_0, iter_10_1 in pairs(self.rewardItems_) do
		if iter_10_1 then
			iter_10_1:Dispose()
		end
	end

	self.rewardItems_ = nil

	StrategyMatrixRwardItem.super.Dispose(self)
end

return StrategyMatrixRwardItem
