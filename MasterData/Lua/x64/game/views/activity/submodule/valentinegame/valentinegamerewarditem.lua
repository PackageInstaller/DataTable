local ValentineGameRewardItem = class("ValentineGameRewardItem", ReduxView)

function ValentineGameRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ValentineGameRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateCon_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function ValentineGameRewardItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ValentineGameAction:GetReward(self.activityID_)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function ValentineGameRewardItem:OnEnter()
	return
end

function ValentineGameRewardItem:RefreshUI(arg_7_1)
	self.activityID_ = arg_7_1

	self:RefreshReward()
	self:RefreshState()
end

function ValentineGameRewardItem:RefreshReward()
	self.cfg_ = ActivityValentineCfg[self.activityID_]

	for iter_8_0, iter_8_1 in ipairs(self.cfg_.reward_item_list) do
		if not self.rewardItems_[iter_8_0] then
			self.rewardItems_[iter_8_0] = RewardItem.New(self.rewardItem_, self.rewardParent_)

			self.rewardItems_[iter_8_0]:UpdateCommonItemAni()
		end

		self.rewardItems_[iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #self.cfg_.reward_item_list + 1, #self.rewardItems_ do
		self.rewardItems_[iter_8_2]:Show(false)
	end

	self.text_.text = string.format(GetTips("ACTIVITY_VALENTINE_REWARD_NEED_DESC"), self.cfg_.name)
end

function ValentineGameRewardItem:RefreshState()
	local var_9_0 = ValentineGameData:GetData(self.activityID_)

	if var_9_0 and var_9_0.isReward then
		self.stateCon_:SetSelectedState("received")
	elseif var_9_0 and var_9_0.isClear then
		self.stateCon_:SetSelectedState("complete")
	else
		self.stateCon_:SetSelectedState("uncomplete")
	end
end

function ValentineGameRewardItem:OnExit()
	for iter_10_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_10_0]:OnExit()
	end
end

function ValentineGameRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_11_0 = 1, #self.rewardItems_ do
		self.rewardItems_[iter_11_0]:Dispose()
	end

	self.super.Dispose(self)
end

return ValentineGameRewardItem
