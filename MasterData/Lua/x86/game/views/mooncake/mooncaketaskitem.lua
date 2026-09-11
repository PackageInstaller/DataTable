local MoonCakeTaskItem = class("MoonCakeTaskItem", ReduxView)

function MoonCakeTaskItem:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function MoonCakeTaskItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function MoonCakeTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			self.taskID_
		})
	end)
end

function MoonCakeTaskItem:SetData(arg_5_1, arg_5_2)
	self.activityID_ = arg_5_2
	self.taskID_ = arg_5_1
	self.taskProgress_ = TaskData2:GetTask(arg_5_1).progress
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_5_1)

	self:RefreshUI()
end

function MoonCakeTaskItem:Dispose()
	for iter_6_0, iter_6_1 in pairs(self.rewardItems_) do
		iter_6_1:Dispose()
	end

	self.rewardItems_ = nil

	MoonCakeTaskItem.super.Dispose(self)
end

function MoonCakeTaskItem:RefreshUI()
	self.descText_.text = AssignmentCfg[self.taskID_].desc

	local var_7_0 = AssignmentCfg[self.taskID_].reward or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if self.rewardItems_[iter_7_0] == nil then
			self.rewardItems_[iter_7_0] = RewardPoolItem.New(self.rewardParent_)
		end

		self.rewardItems_[iter_7_0]:SetData(iter_7_1, false)
	end

	for iter_7_2 = #var_7_0 + 1, #self.rewardItems_ do
		self.rewardItems_[iter_7_2]:Show(false)
	end

	self:RefreshProgress()
end

function MoonCakeTaskItem:RefreshProgress()
	local var_8_0 = AssignmentCfg[self.taskID_]
	local var_8_1 = self.taskProgress_

	if self.taskProgress_ > AssignmentCfg[self.taskID_].need then
		var_8_1 = var_8_0.need
	end

	self.progressBar_.value = var_8_1 / var_8_0.need
	self.progressText_.text = string.format("%s/%s", var_8_1, var_8_0.need)

	local var_8_2 = self.taskProgress_ >= var_8_0.need

	if self.taskComplete_ == true then
		self.statusController_:SetSelectedState("received")
	elseif var_8_2 then
		self.statusController_:SetSelectedState("completed")
	else
		self.statusController_:SetSelectedState("uncomplete")
	end

	if var_8_0.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeController_:SetSelectedState("daily")
	else
		self.typeController_:SetSelectedState("challenge")
	end
end

return MoonCakeTaskItem
