local SailIslandRewardItem = class("SailIslandRewardItem", ReduxView)

function SailIslandRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SailIslandRewardItem:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "status")
	self.rewardItemList_ = {}
end

function SailIslandRewardItem:SetData(arg_3_1, arg_3_2)
	self.activityID_ = arg_3_2
	self.taskID_ = arg_3_1.id
	self.type_ = arg_3_1.type

	self:RefreshUI()
end

function SailIslandRewardItem:Dispose()
	for iter_4_0, iter_4_1 in ipairs(self.rewardItemList_) do
		iter_4_1:Dispose()
	end

	self.rewardItemList_ = nil

	SailIslandRewardItem.super.Dispose(self)
end

function SailIslandRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.type_ == SailGameConst.TASK_TYPE.BUILDING then
			SailGameAction.ReceiveTask(self.activityID_, self.taskID_, self.type_)
		else
			SailGameAction.ReceiveTask(self.activityID_, SailGameIslandLevelCfg[self.taskID_].level, self.type_)
		end
	end)
end

function SailIslandRewardItem:RefreshUI()
	self:RefreshTitle()
	self:RefreshReward()
	self:RefreshProgress()
end

function SailIslandRewardItem:RefreshTitle()
	if self.type_ == SailGameConst.TASK_TYPE.BUILDING then
		self.contentText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BUILD_REWARD_TIP"), SailGameBuildingCfg[self.taskID_].name)
		self.rewardCfg_ = SailGameBuildingCfg[self.taskID_].reward_item_list
	else
		self.contentText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_LEVEL_REWARD_TIP"), NumberTools.IntToRomam(SailGameIslandLevelCfg[self.taskID_].level))
		self.rewardCfg_ = SailGameIslandLevelCfg[self.taskID_].reward_item_list
	end
end

function SailIslandRewardItem:RefreshReward()
	for iter_9_0, iter_9_1 in ipairs(self.rewardCfg_) do
		if self.rewardItemList_[iter_9_0] then
			self.rewardItemList_[iter_9_0]:SetData(iter_9_1, false)
		else
			self.rewardItemList_[iter_9_0] = RewardPoolItem.New(self.goRewardPanel_, iter_9_1, false)
		end
	end

	for iter_9_2 = #self.rewardCfg_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_9_2]:Show(false)
	end
end

function SailIslandRewardItem:RefreshProgress()
	local var_10_0 = false
	local var_10_1 = false

	if self.type_ == SailGameConst.TASK_TYPE.BUILDING then
		var_10_1 = SailGameData:GetRceivedBuilding(self.activityID_)[self.taskID_] == true
		var_10_0 = SailGameData:GetUnLockBuilding(self.activityID_)[self.taskID_] == true
	else
		local var_10_2 = SailGameIslandLevelCfg[self.taskID_].level

		var_10_1 = SailGameData:GetReceivedIslandLevel(self.activityID_)[SailGameIslandLevelCfg[self.taskID_].level] == true
		var_10_0 = var_10_2 <= SailGameData:GetIslandLevel(self.activityID_)
	end

	if var_10_1 == true then
		self.controller_:SetSelectedState("received")
	elseif var_10_0 == true then
		self.controller_:SetSelectedState("complete")
	else
		self.controller_:SetSelectedState("uncomplete")
	end
end

return SailIslandRewardItem
