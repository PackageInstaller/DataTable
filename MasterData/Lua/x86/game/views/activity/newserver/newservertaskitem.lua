local NewServerTaskItem = class("NewServerTaskItem", ReduxView)

function NewServerTaskItem:Ctor(arg_1_1)
	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.isShow_ = true

	self:InitUI()
	self:AddListeners()
end

function NewServerTaskItem:SetData(arg_2_1, arg_2_2)
	self.taskID_ = arg_2_1
	self.maxRewardNum_ = arg_2_2
	self.taskProgress_ = TaskData2:GetTaskProgress(arg_2_1)
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	self:RefreshUI()
	self:RefreshProgress()

	self.isShow_ = true
end

function NewServerTaskItem:OnExit()
	self.isShow_ = false

	SetActive(self.gameObject_, false)
end

function NewServerTaskItem:Dispose()
	self.itemDataList_ = nil

	for iter_4_0, iter_4_1 in pairs(self.rewardItemList_) do
		iter_4_1:Dispose()
	end

	self.rewardItemList_ = nil

	NewServerTaskItem.super.Dispose(self)
end

function NewServerTaskItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.allBtnController_:GetController("all")

	for iter_5_0 = 1, 3 do
		self.rewardItemList_[iter_5_0] = CommonItemView.New(self[string.format("awardItem%dObj_", iter_5_0)])
	end
end

function NewServerTaskItem:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
end

function NewServerTaskItem:RefreshUI()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	self:RefreshReward()
end

function NewServerTaskItem:RefreshReward()
	local var_10_0 = AssignmentCfg[self.taskID_].reward or {}

	for iter_10_0 = 1, 3 do
		if not self.itemDataList_[iter_10_0] then
			self.itemDataList_[iter_10_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_10_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_10_1 = true

		if var_10_0[iter_10_0] then
			self.itemDataList_[iter_10_0].id = var_10_0[iter_10_0][1]
			self.itemDataList_[iter_10_0].number = var_10_0[iter_10_0][2]
			var_10_1 = false
		end

		self.rewardItemList_[iter_10_0]:Show(true)

		if not var_10_1 then
			self.rewardItemList_[iter_10_0]:SetData(self.itemDataList_[iter_10_0])
		else
			self.rewardItemList_[iter_10_0]:SetData(nil)
		end
	end

	for iter_10_1 = self.maxRewardNum_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_1]:Show(false)
	end
end

function NewServerTaskItem:RefreshProgress()
	local var_12_0 = self.taskProgress_

	if self.taskProgress_ > AssignmentCfg[self.taskID_].need then
		var_12_0 = AssignmentCfg[self.taskID_].need
	end

	self.progressBar_.value = var_12_0 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_12_0, AssignmentCfg[self.taskID_].need)

	local var_12_1 = self.taskProgress_ >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ then
		self.stateController_:SetSelectedState("complete")
	elseif var_12_1 then
		self.stateController_:SetSelectedState("receive")
	else
		self.stateController_:SetSelectedState("go")
	end
end

return NewServerTaskItem
