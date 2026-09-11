local SoloChallengeRewardItem = class("SoloChallengeRewardItem", ReduxView)

function SoloChallengeRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SoloChallengeRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardItemList_ = {}
	self.rewardState_ = ControllerUtil.GetController(self.transform_, "status")
end

function SoloChallengeRewardItem:RefreshData(arg_3_1)
	self.activityID_ = arg_3_1.activityID
	self.difficultyIndex_ = arg_3_1.difficultyIndex

	self:RefreshUI()
end

function SoloChallengeRewardItem:InitUI()
	self:BindCfgUI()
end

function SoloChallengeRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.RequireReceive(self.activityID_, self.difficultyIndex_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				getReward(formatRewardCfgList(ActivitySoloChallengeCfg[self.activityID_].reward_item_list[self.difficultyIndex_][2]))
				SoloChallengeData:SetReceivedActivityList(self.activityID_, self.difficultyIndex_)
				self:RefreshState()
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
end

function SoloChallengeRewardItem:RefreshUI()
	self.descText_.text = GetI18NText(self.difficultyIndex_ == 1 and GetTips("CLEAR_NORMAL_DIFFICULTY") or self.difficultyIndex_ == 2 and GetTips("CLEAR_DIFFICULTY") or GetTips("CLEAR_EXTREME_DIFFICULTY"))

	self:RefreshState()
	self:RefreshItem()
end

function SoloChallengeRewardItem:RefreshState()
	local var_9_0 = table.keyof(SoloChallengeData:GetReceivedActivityList()[self.activityID_], self.difficultyIndex_) ~= nil

	if table.keyof(SoloChallengeData:GetCompletedActivityList()[self.activityID_], self.difficultyIndex_) == nil then
		self.rewardState_:SetSelectedState("uncompleted")
	elseif not var_9_0 then
		self.rewardState_:SetSelectedState("unreceived")
	else
		self.rewardState_:SetSelectedState("received")
	end
end

function SoloChallengeRewardItem:RefreshItem()
	for iter_10_0, iter_10_1 in ipairs(ActivitySoloChallengeCfg[self.activityID_].reward_item_list[self.difficultyIndex_][2]) do
		if self.rewardItemList_[iter_10_0] then
			self.rewardItemList_[iter_10_0]:SetData(iter_10_1, false)
		else
			self.rewardItemList_[iter_10_0] = self:GetRewardItem().New(self.goRewardPanel_, iter_10_1, true)
		end
	end

	for iter_10_2 = #ActivitySoloChallengeCfg[self.activityID_].reward_item_list[self.difficultyIndex_][2] + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_2]:Show(false)
	end
end

function SoloChallengeRewardItem:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(self.rewardCfg_[arg_11_1], POP_ITEM)
end

function SoloChallengeRewardItem:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.rewardItemList_) do
		iter_12_1:Dispose()
	end

	self.rewardItemList_ = nil

	SoloChallengeRewardItem.super.Dispose(self)
end

function SoloChallengeRewardItem:GetRewardItem()
	return RewardPoolFactoryItem
end

function SoloChallengeRewardItem:GetCommonItem(arg_14_1)
	return arg_14_1:GetCommonItem()
end

return SoloChallengeRewardItem
