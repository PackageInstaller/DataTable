local RaceTrialScoreRewardItem = class("RaceTrialScoreRewardItem", ReduxView)

function RaceTrialScoreRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RaceTrialScoreRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialScoreRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardList_ = {}
	self.receiveCon_ = ControllerUtil.GetController(self.transform_, "receiveCon")
end

function RaceTrialScoreRewardItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveScoreReward(self.id_)
	end)
end

function RaceTrialScoreRewardItem:OnEnter()
	return
end

function RaceTrialScoreRewardItem:RefreshUI(arg_7_1, arg_7_2, arg_7_3)
	self.id_ = arg_7_1
	self.activityID_ = arg_7_3
	self.cfg_ = ActivityPointRewardCfg[arg_7_1]
	self.data_ = RaceTrialData:GetScoreRewardByID(self.id_)
	self.score_ = arg_7_2

	self:RefreshReward()
	self:RefreshTitle()
	self:RefreshState()
end

function RaceTrialScoreRewardItem:RefreshTitle()
	self.title_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. self.cfg_.need
end

function RaceTrialScoreRewardItem:RefreshReward()
	for iter_9_0, iter_9_1 in ipairs(self.cfg_.reward_item_list) do
		if self.rewardList_[iter_9_0] == nil then
			self.rewardList_[iter_9_0] = RewardItem.New(self.rewardItem_, self.rewardParent_, false)

			self.rewardList_[iter_9_0]:UpdateCommonItemAni()
		end

		self.rewardList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #self.cfg_.reward_item_list + 1, #self.rewardList_ do
		self.rewardList_[iter_9_2]:Show(false)
	end
end

function RaceTrialScoreRewardItem:RefreshState()
	if self.data_.receive_flag then
		self.receiveCon_:SetSelectedState("received")
	elseif self.score_ >= self.cfg_.need then
		self.receiveCon_:SetSelectedState("complete")
	else
		self.receiveCon_:SetSelectedState("incomplete")
	end
end

function RaceTrialScoreRewardItem:OnExit()
	return
end

function RaceTrialScoreRewardItem:Dispose()
	self:RemoveAllListeners()
	self:DisposeRewardItems()
	RaceTrialScoreRewardItem.super.Dispose(self)
end

function RaceTrialScoreRewardItem:DisposeRewardItems()
	for iter_13_0 = 1, #self.rewardList_ do
		self.rewardList_[iter_13_0]:Dispose()

		self.rewardList_[iter_13_0] = nil
	end

	self.rewardList_ = nil
end

return RaceTrialScoreRewardItem
