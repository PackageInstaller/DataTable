local PuzzleNewTaskItem = class("PuzzleNewTaskItem", ReduxView)
local JumpTools = import("game.tools.JumpTools")

function PuzzleNewTaskItem:OnCtor(arg_1_1)
	self.rewardItems_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function PuzzleNewTaskItem:SetData(arg_2_1, arg_2_2)
	self.activityID_ = arg_2_2
	self.taskID_ = arg_2_1
	self.taskProgress = TaskData2:GetTask(arg_2_1).progress
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshUI()
end

function PuzzleNewTaskItem:Dispose()
	self.commonItem_:Dispose()

	self.commonItem_ = nil

	PuzzleNewTaskItem.super.Dispose(self)
end

function PuzzleNewTaskItem:InitUI()
	self:BindCfgUI()

	self.controller_ = self.controllerEx_:GetController("status")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function PuzzleNewTaskItem:AddListeners()
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

function PuzzleNewTaskItem:RefreshUI()
	self.contentText_.text = AssignmentCfg[self.taskID_].desc

	self:RefreshReward()
	self:RefreshType()
	self:RefreshProgress()
end

function PuzzleNewTaskItem:RefreshReward()
	if self.commonItem_ == nil then
		self.commonItem_ = CommonItemView.New(self.rewardItemGo_, true)
	end

	self.rewardCfg_ = AssignmentCfg[self.taskID_].reward[1]

	local var_8_0 = clone(ItemTemplateData)

	var_8_0.id = self.rewardCfg_[1]
	var_8_0.number = self.rewardCfg_[2]

	function var_8_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	self.commonItem_:SetData(var_8_0)
end

function PuzzleNewTaskItem:RefreshProgress()
	local var_10_0 = self.taskProgress

	if self.taskProgress > AssignmentCfg[self.taskID_].need then
		var_10_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressSlider_.value = var_10_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_10_0, AssignmentCfg[self.taskID_].need)

	local var_10_1 = self.taskProgress >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ == true then
		self.controller_:SetSelectedState("received")
	elseif var_10_1 then
		self.controller_:SetSelectedState("completed")
	else
		self.controller_:SetSelectedState("uncomplete")
	end
end

function PuzzleNewTaskItem:RefreshType()
	if AssignmentCfg[self.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		self.typeController_:SetSelectedState("daily")
	else
		self.typeController_:SetSelectedState("challenge")
	end
end

return PuzzleNewTaskItem
