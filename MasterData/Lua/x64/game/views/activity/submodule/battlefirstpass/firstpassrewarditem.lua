local FirstPassRewardItem = class("FirstPassRewardItem", ReduxView)

function FirstPassRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function FirstPassRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function FirstPassRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardList_ = {}
	self.receiveCon_ = ControllerUtil.GetController(self.transform_, "receiveCon")
end

function FirstPassRewardItem:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		BattleFirstPassAction:ReceiveReward(self.activiteID_, self.id_)
	end)
end

function FirstPassRewardItem:OnEnter()
	return
end

function FirstPassRewardItem:RefreshUI(arg_7_1, arg_7_2)
	self.activiteID_ = arg_7_1
	self.info_ = arg_7_2
	self.id_ = self.info_.battleID
	self.cfg_ = ActivityFirstClearCfg[self.id_]

	self:RefreshTitle()
	self:RefreshReward()
	self:RefreshType()
end

function FirstPassRewardItem:RefreshTitle()
	self.title_.text = GetI18NText(self.cfg_.reward_desc)
end

function FirstPassRewardItem:RefreshReward()
	local var_9_0 = self.cfg_.reward_item_list or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not self.rewardList_[iter_9_0] then
			self.rewardList_[iter_9_0] = RewardItem.New(self.rewardItem_, self.rewardParent_, true)

			self.rewardList_[iter_9_0]:UpdateCommonItemAni()
		end

		self.rewardList_[iter_9_0]:SetData(iter_9_1)
	end

	for iter_9_2 = #var_9_0 + 1, #self.rewardList_ do
		self.rewardList_[iter_9_2]:Show(false)
	end
end

function FirstPassRewardItem:RefreshType()
	if self.info_.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
		self.receiveCon_:SetSelectedState("unfinished")
	elseif self.info_.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
		self.receiveCon_:SetSelectedState("success")
	elseif self.info_.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED then
		self.receiveCon_:SetSelectedState("rewarded")
	end
end

function FirstPassRewardItem:OnExit()
	return
end

function FirstPassRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(self.rewardList_) do
		iter_12_1:Dispose()
	end

	FirstPassRewardItem.super.Dispose(self)
end

return FirstPassRewardItem
