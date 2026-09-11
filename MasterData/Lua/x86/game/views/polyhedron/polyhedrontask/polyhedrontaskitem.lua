local PolyhedronTaskItem = class("PolyhedronTaskItem", ReduxView)

function PolyhedronTaskItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_2, arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PolyhedronTaskItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardItemList_ = {}
	self.itemDataList_ = {}
	self.rewardState_ = self.allBtnController_:GetController("all")
end

function PolyhedronTaskItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronTaskItem:AddListeners()
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

function PolyhedronTaskItem:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.rewardItemList_) do
		iter_6_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.itemDataList_ = nil

	PolyhedronTaskItem.super.Dispose(self)
end

function PolyhedronTaskItem:SetData(arg_7_1, arg_7_2)
	self.taskID_ = arg_7_1
	self.maxRewardNum_ = arg_7_2
	self.activityID_ = AssignmentCfg[self.taskID_].activity_id

	self:RefreshUI()
end

function PolyhedronTaskItem:RefreshUI()
	self:RefreshDesc()
	self:RefreshItem()
	self:RefreshState()
	self:Show(true)
end

function PolyhedronTaskItem:RefreshDesc()
	self.titleText_.text = GetI18NText(AssignmentCfg[self.taskID_].desc)

	local var_9_0 = TaskData2:GetTask(self.taskID_)
	local var_9_1 = AssignmentCfg[self.taskID_].need

	if var_9_0 and var_9_0.progress and AssignmentCfg[self.taskID_].need > var_9_0.progress then
		var_9_1 = var_9_0.progress
	end

	var_9_1 = AssignmentCfg[self.taskID_].need < var_9_1 and AssignmentCfg[self.taskID_].need or var_9_1
	self.progressBar_.value = var_9_1 / AssignmentCfg[self.taskID_].need
	self.progressText_.text = string.format("%s/%s", var_9_1, AssignmentCfg[self.taskID_].need)
end

function PolyhedronTaskItem:RefreshItem()
	self.rewardCfg_ = AssignmentCfg[self.taskID_].reward

	for iter_10_0 = 1, self.maxRewardNum_ do
		self.rewardItemList_[iter_10_0] = self.rewardItemList_[iter_10_0] or CommonItemView.New(self[string.format("awardItem%sObj_", iter_10_0)])

		self.rewardItemList_[iter_10_0]:Show(true)

		if not self.itemDataList_[iter_10_0] then
			self.itemDataList_[iter_10_0] = clone(ItemTemplateData)
			self.itemDataList_[iter_10_0].clickFun = function(self)
				ShowPopItem(POP_ITEM, {
					self.id,
					self.number
				})
			end
		end

		local var_10_0 = true

		if self.rewardCfg_[iter_10_0] then
			self.itemDataList_[iter_10_0].id = self.rewardCfg_[iter_10_0][1]
			self.itemDataList_[iter_10_0].number = self.rewardCfg_[iter_10_0][2]
			var_10_0 = false
		end

		if not var_10_0 then
			self.rewardItemList_[iter_10_0]:SetData(self.itemDataList_[iter_10_0])
		else
			self.rewardItemList_[iter_10_0]:SetData(nil)
		end
	end

	for iter_10_1 = self.maxRewardNum_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_1]:Show(false)
	end
end

function PolyhedronTaskItem:RefreshState()
	local var_12_0 = AssignmentCfg[self.taskID_].need
	local var_12_1 = TaskData2:GetTask(self.taskID_)

	if var_12_0 > ((var_12_1 and var_12_1.progress or nil) and var_12_1.progress) then
		self.rewardState_:SetSelectedState("go")
	elseif not TaskData2:GetTaskComplete(self.taskID_) then
		self.rewardState_:SetSelectedState("receive")
	else
		self.rewardState_:SetSelectedState("complete")
	end
end

function PolyhedronTaskItem:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

return PolyhedronTaskItem
