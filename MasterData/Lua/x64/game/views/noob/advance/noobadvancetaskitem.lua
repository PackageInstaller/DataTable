local NoobAdvanceTaskItem = class("NoobAdvanceTaskItem", ReduxView)
local var_0_1 = {
	"receive",
	"go",
	"lock",
	"complete"
}

function NoobAdvanceTaskItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.btnController_ = self.allBtnController_:GetController("all")
	self.rewardItems_ = {}
	self.itemDataList_ = {}
end

function NoobAdvanceTaskItem:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.rewardItems_) do
		iter_2_1:Dispose()
	end

	self.rewardItems_ = nil

	NoobAdvanceTaskItem.super.Dispose(self)
end

function NoobAdvanceTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		if self.curState_ ~= var_0_1[2] then
			return
		end

		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.curState_ ~= var_0_1[1] then
			return
		end

		TaskAction:SubmitTask(self.taskID_)
	end)
end

function NoobAdvanceTaskItem:SetData(arg_6_1, arg_6_2)
	self.taskID_ = arg_6_1
	self.maxRewardNum_ = arg_6_2

	self:RefreshTitle()
	self:RefreshProgress()
	self:RefreshState()
	self:RefreshReward(arg_6_1)
end

function NoobAdvanceTaskItem:RefreshTitle()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)
end

function NoobAdvanceTaskItem:RefreshProgress()
	local var_8_0 = TaskData2:GetTask(self.taskID_).progress or 0

	if AssignmentCfg[self.taskID_].need < var_8_0 then
		var_8_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressText_.text = string.format("%s/%s", var_8_0, AssignmentCfg[self.taskID_].need)
	self.progressBar_.value = var_8_0 / AssignmentCfg[self.taskID_].need
end

function NoobAdvanceTaskItem:RefreshReward(arg_9_1)
	for iter_9_0 = 1, 3 do
		if not self.itemDataList_[iter_9_0] then
			self.itemDataList_[iter_9_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_9_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_9_0 = true

		if AssignmentCfg[arg_9_1].reward[iter_9_0] then
			self.itemDataList_[iter_9_0].id = AssignmentCfg[arg_9_1].reward[iter_9_0][1]
			self.itemDataList_[iter_9_0].number = AssignmentCfg[arg_9_1].reward[iter_9_0][2]
			self.itemDataList_[iter_9_0].grayFlag = self.curState_ == var_0_1[4]
			var_9_0 = false
		end

		if self.rewardItems_[iter_9_0] == nil then
			self.rewardItems_[iter_9_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_9_0)])
		end

		self.rewardItems_[iter_9_0]:Show(true)

		if not var_9_0 then
			self.rewardItems_[iter_9_0]:SetData(self.itemDataList_[iter_9_0])
		else
			self.rewardItems_[iter_9_0]:SetData(nil)
		end
	end

	for iter_9_1 = self.maxRewardNum_ + 1, #self.rewardItems_ do
		self.rewardItems_[iter_9_1]:Show(false)
	end
end

function NoobAdvanceTaskItem:RefreshState()
	self.btnController_:SetSelectedState((self:GetItemState()))
end

function NoobAdvanceTaskItem:GetItemState()
	local var_12_0 = TaskData2:GetTask(self.taskID_)

	self.curState_ = var_12_0.complete_flag >= 1 and var_0_1[4] or (var_12_0.progress or 0) < AssignmentCfg[self.taskID_].need and var_0_1[2] or var_0_1[1]

	return self.curState_
end

return NoobAdvanceTaskItem
