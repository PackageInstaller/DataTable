local LimitedCalculationRewardItem = class("LimitedCalculationRewardItem", ReduxView)

function LimitedCalculationRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function LimitedCalculationRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LimitedCalculationRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
end

function LimitedCalculationRewardItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		ActivityAction.ReceivePointReward({
			self.id_
		})
	end)
end

function LimitedCalculationRewardItem:OnEnter()
	return
end

function LimitedCalculationRewardItem:RefreshUI(arg_7_1, arg_7_2)
	self.info_ = arg_7_1
	self.activityID_ = arg_7_2
	self.id_ = arg_7_1.id
	self.cfg_ = ActivityPointRewardCfg[self.id_]
	self.score_ = LimitedCalculationData:GetScore(self.activityID_)
	self.need_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), self.cfg_.need)

	self:RefreshReward()
	self:RefreshState()
end

function LimitedCalculationRewardItem:RefreshReward()
	for iter_8_0, iter_8_1 in ipairs(self.cfg_.reward_item_list) do
		if self.rewardItems_[iter_8_0] == nil then
			self.rewardItems_[iter_8_0] = RewardItem.New(self.rewardTemplate_, self.rewardParent_, true)

			self.rewardItems_[iter_8_0]:UpdateCommonItemAni()
		end

		self.rewardItems_[iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #self.cfg_.reward_item_list + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:Show(false)
	end
end

function LimitedCalculationRewardItem:RefreshState()
	if self.info_.complete_flag == ActivityConst.LIMITED_CALCULATION_REWARD_STATE.UNFINISHED then
		if self.cfg_.need <= self.score_ then
			self.stateCon_:SetSelectedState("success")
		else
			self.stateCon_:SetSelectedState("unfinished")
		end
	else
		self.stateCon_:SetSelectedState("rewarded")
	end
end

function LimitedCalculationRewardItem:OnExit()
	for iter_10_0 = #self.rewardItems_, 1, -1 do
		self.rewardItems_[iter_10_0]:OnExit()
	end
end

function LimitedCalculationRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_11_0 = #self.rewardItems_, 1, -1 do
		self.rewardItems_[iter_11_0]:Dispose()

		self.rewardItems_[iter_11_0] = nil
	end

	LimitedCalculationRewardItem.super.Dispose(self)
end

return LimitedCalculationRewardItem
