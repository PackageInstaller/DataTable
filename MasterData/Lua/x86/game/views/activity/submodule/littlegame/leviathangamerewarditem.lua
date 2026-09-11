local LeviathanGameRewardItem = class("LeviathanGameRewardItem", ReduxView)

function LeviathanGameRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function LeviathanGameRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LeviathanGameRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardList_ = {}
	self.receiveCon_ = ControllerUtil.GetController(self.transform_, "receiveCon")
end

function LeviathanGameRewardItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		SummerLittleGameAction.GetLeviathanReward(self.activityID_)
	end)
end

function LeviathanGameRewardItem:OnEnter()
	return
end

function LeviathanGameRewardItem:RefreshUI(arg_7_1)
	self.activityID_ = arg_7_1
	self.cfg_ = ActivityBubblesCfg[self.activityID_]

	self:RefreshTitle()
	self:RefreshReward()
	self:RefreshType()
end

function LeviathanGameRewardItem:RefreshTitle()
	self.title_.text = GetI18NText(self.cfg_.desc)
end

function LeviathanGameRewardItem:RefreshReward()
	for iter_9_0, iter_9_1 in ipairs(self.cfg_.reward_item_list) do
		if not self.rewardList_[iter_9_0] then
			self.rewardList_[iter_9_0] = RewardItem.New(self.rewardItem_, self.rewardParent_, true)

			self.rewardList_[iter_9_0]:UpdateCommonItemAni()
		end

		self.rewardList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #self.cfg_.reward_item_list + 1, #self.rewardList_ do
		self.rewardList_[iter_9_2]:Show(false)
	end
end

function LeviathanGameRewardItem:RefreshType()
	local var_10_0 = SummerLittleGameData:GetLeviathanState(self.activityID_)

	if var_10_0 == 0 then
		self.receiveCon_:SetSelectedState("unfinished")
	elseif var_10_0 == 1 then
		self.receiveCon_:SetSelectedState("success")
	elseif var_10_0 == 2 then
		self.receiveCon_:SetSelectedState("rewarded")
	end
end

function LeviathanGameRewardItem:OnExit()
	return
end

function LeviathanGameRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(self.rewardList_) do
		iter_12_1:Dispose()
	end

	LeviathanGameRewardItem.super.Dispose(self)
end

return LeviathanGameRewardItem
