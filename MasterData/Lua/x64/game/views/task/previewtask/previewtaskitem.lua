local PreviewTaskItem = class("PreviewTaskItem", ReduxView)
local JumpTools = import("game.tools.JumpTools")

function PreviewTaskItem:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.rewardItemGos_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function PreviewTaskItem:SetData(arg_2_1, arg_2_2)
	self.activityID_ = arg_2_2
	self.taskID_ = arg_2_1
	self.taskProgress = PreviewTaskData:GetTaskProgress(arg_2_1)
	self.taskComplete_ = PreviewTaskData:GetTaskComplete(arg_2_1)

	self:RefreshUI()
end

function PreviewTaskItem:Dispose()
	self:RemoveListeners()

	for iter_3_0, iter_3_1 in pairs(self.rewardItems_) do
		iter_3_1:Dispose()
	end

	self.rewardItems_ = nil

	for iter_3_2, iter_3_3 in pairs(self.rewardItemGos_) do
		Object.Destroy(iter_3_3)
	end

	self.rewardItemGos_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil

	PreviewTaskItem.super.Dispose(self)
end

function PreviewTaskItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "state")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function PreviewTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PreviewTaskAction.TryToSubmitTask(self.taskID_)
	end)
end

function PreviewTaskItem:RemoveListeners()
	self.goBtn_.onClick:RemoveAllListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
end

function PreviewTaskItem:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].name)
	self.contentText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_9_0 = AssignmentCfg[self.taskID_].reward or {}

	for iter_9_0 = 1, 3 do
		if self.rewardItems_[iter_9_0] == nil then
			self.rewardItems_[iter_9_0] = CommonItemPool.New(self.rewardParent_)
		end

		if var_9_0[iter_9_0] then
			local var_9_1 = clone(ItemTemplateData)

			var_9_1.id = var_9_0[iter_9_0][1]
			var_9_1.number = var_9_0[iter_9_0][2]

			function var_9_1:clickFun()
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number,
					self.timeValid
				})
			end

			self.rewardItems_[iter_9_0]:SetData(var_9_1)
		else
			self.rewardItems_[iter_9_0]:SetData()
		end
	end

	self:RefreshTime()
	self:RefreshProgress()
end

function PreviewTaskItem:RefreshProgress()
	local var_11_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_11_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.fillAmount = var_11_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_11_0, AssignmentCfg[self.taskID_].need)

	local var_11_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ == true then
		self.controller_:SetSelectedState("received")
	elseif var_11_1 then
		self.controller_:SetSelectedState("completed")
	else
		self.controller_:SetSelectedState("incomplete")
	end
end

function PreviewTaskItem:RefreshTime()
	if AssignmentCfg[self.taskID_].type == TaskConst.TASK_TYPE.PREVIEW_DAILY then
		self.endTime_ = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)
		self.isDailyTask_ = true

		self.typeController_:SetSelectedState("daily")
	else
		self.isDailyTask_ = false

		self.typeController_:SetSelectedState("normal")
	end
end

return PreviewTaskItem
