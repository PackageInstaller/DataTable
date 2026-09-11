local HeroClueTaskItem = class("HeroClueTaskItem", ReduxView)

function HeroClueTaskItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function HeroClueTaskItem:InitUI()
	self:BindCfgUI()
	self:InitRewardItem()

	self.statusController_ = self.controllerEx_:GetController("state")
end

function HeroClueTaskItem:InitRewardItem()
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	for iter_3_0 = 1, self.rewardPanelTrans_.childCount do
		self.rewardItemList_[iter_3_0] = CommonItemView.New(self.rewardPanelTrans_:GetChild(iter_3_0 - 1).gameObject)
		self.itemDataList_[iter_3_0] = clone(ItemTemplateData)
		self.itemDataList_[iter_3_0].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end
end

function HeroClueTaskItem:AddListeners()
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

function HeroClueTaskItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.taskID_ = arg_7_1
	self.activityID_ = arg_7_2
	self.index_ = arg_7_3
	self.taskProgress_ = TaskData2:GetTask(arg_7_1).progress
	self.taskComplete_ = TaskData2:GetTaskComplete(arg_7_1)

	self:RefreshUI()
end

function HeroClueTaskItem:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.rewardItemList_) do
		iter_8_1:Dispose()
	end

	self.rewardItemList_ = nil

	HeroClueTaskItem.super.Dispose(self)
end

function HeroClueTaskItem:RefreshUI()
	self:RefreshReward()
	self:RefreshProgress()
	self:RefreshState()
	self:RefreshDesc()
	self:RefreshIndex()
end

function HeroClueTaskItem:RefreshReward()
	for iter_10_0, iter_10_1 in ipairs(AssignmentCfg[self.taskID_].reward or {}) do
		self.itemDataList_[iter_10_0].id = iter_10_1[1]
		self.itemDataList_[iter_10_0].number = iter_10_1[2]

		self.rewardItemList_[iter_10_0]:SetData(self.itemDataList_[iter_10_0])
	end
end

function HeroClueTaskItem:RefreshProgress()
	if self.taskProgress_ > AssignmentCfg[self.taskID_].need then
		-- block empty
	end
end

function HeroClueTaskItem:RefreshState()
	local var_12_0 = self.taskProgress_ >= AssignmentCfg[self.taskID_].need

	if self.taskComplete_ == true then
		self.statusController_:SetSelectedState("received")
	elseif var_12_0 then
		self.statusController_:SetSelectedState("complete")
	else
		self.statusController_:SetSelectedState("unfinish")
	end
end

function HeroClueTaskItem:RefreshDesc()
	self.descText_.text = AssignmentCfg[self.taskID_].desc
end

function HeroClueTaskItem:RefreshIndex()
	local var_14_0 = tostring(self.index_)

	if self.index_ < 10 then
		var_14_0 = "0" .. var_14_0
	end

	self.indexText_.text = var_14_0
end

return HeroClueTaskItem
