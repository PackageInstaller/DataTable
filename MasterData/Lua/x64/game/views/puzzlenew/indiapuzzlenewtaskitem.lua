local IndiaPuzzleNewTaskItem = class("IndiaPuzzleNewTaskItem", ReduxView)

function IndiaPuzzleNewTaskItem:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function IndiaPuzzleNewTaskItem:SetData(arg_2_1, arg_2_2)
	self.activityID_ = arg_2_2
	self.taskID_ = arg_2_1
	self.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshUI()
end

function IndiaPuzzleNewTaskItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	IndiaPuzzleNewTaskItem.super.Dispose(self)
end

function IndiaPuzzleNewTaskItem:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function IndiaPuzzleNewTaskItem:InitController()
	self.controller_ = ControllerUtil.GetController(self.transform_, "state")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function IndiaPuzzleNewTaskItem:AddListeners()
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

function IndiaPuzzleNewTaskItem:RefreshUI()
	self.desc_.text = AssignmentCfg[self.taskID_].desc

	self:RefreshProgress()
	self:RefreshReward()
	self:RefreshType()
end

function IndiaPuzzleNewTaskItem:RefreshReward()
	self.rewardCfg_ = AssignmentCfg[self.taskID_].reward[1]

	if self.commonItem_ == nil then
		self.commonItem_ = CommonItemView.New(self.rewardItem_, true)
		self.itemData_ = clone(ItemTemplateData)

		function self.itemData_:clickFun()
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end

	self.itemData_.id = self.rewardCfg_[1]
	self.itemData_.number = self.rewardCfg_[2]

	self.commonItem_:SetData(self.itemData_)
	self.commonItem_:RefreshGray(self.taskComplete_ == true)
end

function IndiaPuzzleNewTaskItem:RefreshProgress()
	local var_11_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_11_0 = AssignmentCfg[self.taskID_].need
	end

	self.slider_.value = var_11_0 / AssignmentCfg[self.taskID_].need
	self.progress_.text = string.format("%s/%s", var_11_0, AssignmentCfg[self.taskID_].need)

	local var_11_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ == true then
		self.controller_:SetSelectedState("received")
	elseif var_11_1 then
		self.controller_:SetSelectedState("complete")
	else
		self.controller_:SetSelectedState("unfinish")
	end
end

function IndiaPuzzleNewTaskItem:RefreshType()
	if AssignmentCfg[self.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeController_:SetSelectedState("normal")
	else
		self.typeController_:SetSelectedState("challenge")
	end
end

return IndiaPuzzleNewTaskItem
