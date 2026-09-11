local HeroClueEnterTaskItem = class("HeroClueEnterTaskItem", ReduxView)

function HeroClueEnterTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function HeroClueEnterTaskItem:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitReward()
end

function HeroClueEnterTaskItem:InitController()
	self.statusController_ = ControllerUtil.GetController(self.transform_, "state")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function HeroClueEnterTaskItem:InitReward()
	self.rewardItem_ = CommonItemView.New(self.rewardItemGo_, true)
	self.itemData_ = clone(ItemTemplateData)

	function self.itemData_:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end
end

function HeroClueEnterTaskItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			self.taskID_
		})
	end)
end

function HeroClueEnterTaskItem:SetData(arg_8_1, arg_8_2)
	self.activityID_ = arg_8_2
	self.taskID_ = arg_8_1
	self.taskProgress_ = TaskData2:GetTask(arg_8_1).progress
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_8_1)

	self:RefreshUI()
end

function HeroClueEnterTaskItem:Dispose()
	self.rewardItem_:Dispose()
	HeroClueEnterTaskItem.super.Dispose(self)
end

function HeroClueEnterTaskItem:RefreshUI()
	self:RefreshReward()
	self:RefreshProgress()
	self:RefreshType()
	self:RefreshDesc()
end

function HeroClueEnterTaskItem:RefreshReward()
	local var_11_0 = AssignmentCfg[self.taskID_].reward or {}

	self.itemData_.id = var_11_0[1][1]
	self.itemData_.number = var_11_0[1][2]

	self.rewardItem_:SetData(self.itemData_)
	self.rewardItem_:RefreshGray(self.taskComplete_ == true)
end

function HeroClueEnterTaskItem:RefreshProgress()
	local var_12_0 = self.taskProgress_

	if self.taskProgress_ > AssignmentCfg[self.taskID_].need then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	if self.slider_ then
		self.slider_.value = var_12_0 / AssignmentCfg[self.taskID_].need
	end

	if self.progress_ then
		self.progress_.text = string.format("%s/%s", var_12_0, AssignmentCfg[self.taskID_].need)
	end

	local var_12_1 = self.taskProgress_ >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ == true then
		self.statusController_:SetSelectedState("received")
	elseif var_12_1 then
		self.statusController_:SetSelectedState("complete")
	else
		self.statusController_:SetSelectedState("unfinish")
	end
end

function HeroClueEnterTaskItem:RefreshType()
	if self.typeController_ then
		if AssignmentCfg[self.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
			self.typeController_:SetSelectedState("normal")
		else
			self.typeController_:SetSelectedState("challenge")
		end
	end
end

function HeroClueEnterTaskItem:RefreshDesc()
	self.desc_.text = AssignmentCfg[self.taskID_].desc
end

return HeroClueEnterTaskItem
