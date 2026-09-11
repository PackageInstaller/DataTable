local RaceTrialFirstRewardItem = class("RaceTrialFirstRewardItem", ReduxView)

function RaceTrialFirstRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RaceTrialFirstRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialFirstRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardList_ = {}
	self.receiveCon_ = ControllerUtil.GetController(self.transform_, "receiveCon")
end

function RaceTrialFirstRewardItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.id) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveFirstReward(self.mainActivityID_, self.id_)
	end)
end

function RaceTrialFirstRewardItem:OnEnter()
	return
end

function RaceTrialFirstRewardItem:RefreshUI(arg_7_1, arg_7_2)
	self.id_ = arg_7_1
	self.mainActivityID_ = arg_7_2
	self.cfg_ = ActivityRaceTrialCfg[arg_7_1]
	self.data_ = RaceTrialData:GetBattleData(self.id_)

	for iter_7_0, iter_7_1 in ipairs(self.cfg_.reward_item_list) do
		if self.rewardList_[iter_7_0] == nil then
			self.rewardList_[iter_7_0] = RewardItem.New(self.rewardItem_, self.rewardParent_, false)

			self.rewardList_[iter_7_0]:UpdateCommonItemAni()
		end

		self.rewardList_[iter_7_0]:SetData(iter_7_1)
	end

	for iter_7_2 = #self.cfg_.reward_item_list + 1, #self.rewardList_ do
		self.rewardList_[iter_7_2]:Show(false)
	end

	self.title_.text = GetI18NText(self.cfg_.reward_desc)

	if self.data_.state == 1 then
		self.receiveCon_:SetSelectedState("incomplete")
	elseif self.data_.state == 2 then
		self.receiveCon_:SetSelectedState("complete")
	elseif self.data_.state == 3 then
		self.receiveCon_:SetSelectedState("received")
	end
end

function RaceTrialFirstRewardItem:OnExit()
	return
end

function RaceTrialFirstRewardItem:Dispose()
	self:RemoveAllListeners()
	self:DisposeRewardItems()
	RaceTrialFirstRewardItem.super.Dispose(self)
end

function RaceTrialFirstRewardItem:DisposeRewardItems()
	for iter_10_0 = 1, #self.rewardList_ do
		self.rewardList_[iter_10_0]:Dispose()

		self.rewardList_[iter_10_0] = nil
	end

	self.rewardList_ = nil
end

return RaceTrialFirstRewardItem
