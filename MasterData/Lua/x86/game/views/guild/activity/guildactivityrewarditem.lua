local GuildActivityRewardItem = class("GuildActivityRewardItem", ReduxView)

function GuildActivityRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:Init()
end

function GuildActivityRewardItem:Init()
	self:InitUI()
	self:AddListeners()

	self.rewardItemList_ = {}
	self.rewardController_ = ControllerUtil.GetController(self.transform_, "state")
	self.levelController_ = ControllerUtil.GetController(self.transform_, "level")
	self.receiveHandler_ = handler(self, self.OnReceiveReward)
end

function GuildActivityRewardItem:InitUI()
	self:BindCfgUI()
end

function GuildActivityRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			ShowTips("TIME_OVER")

			return
		end

		GuildActivityAction.RequireReceive(self.rateID_, self.receiveHandler_)
	end)
end

function GuildActivityRewardItem:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.rewardItemList_) do
		iter_6_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.receiveHandler_ = nil

	GuildActivityRewardItem.super.Dispose(self)
end

function GuildActivityRewardItem:SetData(arg_7_1, arg_7_2)
	self.rateID_ = arg_7_1
	self.activityID_ = arg_7_2
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
	self.rewardList_ = ActivityClubLevelSettingCfg[arg_7_1].reward_item_list

	self:RefreshUI()
end

function GuildActivityRewardItem:setReceiveCallBack(arg_8_1)
	self.receiveCallBack_ = arg_8_1
end

function GuildActivityRewardItem:RefreshUI()
	self.descText_.text = string.format(GetTips("ACTIVITY_CLUB_REWARD"), ActivityClubLevelSettingCfg[self.rateID_].user_level)

	self.levelController_:SetSelectedState(tostring(ActivityClubLevelSettingCfg[self.rateID_].user_level))
	self:RefreshRewardItem()
	self:RefreshRewardState()
end

function GuildActivityRewardItem:RefreshRewardItem()
	for iter_10_0, iter_10_1 in ipairs(self.rewardList_) do
		if self.rewardItemList_[iter_10_0] then
			self.rewardItemList_[iter_10_0]:SetData(iter_10_1, false)
		else
			self.rewardItemList_[iter_10_0] = RewardPoolItem.New(self.rewardParent_, iter_10_1, true)
		end
	end

	for iter_10_2 = #self.rewardList_ + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_10_2]:Show(false)
	end
end

function GuildActivityRewardItem:OnReceiveReward()
	GuildActivityData:SetReceivedList(self.activityID_, self.rateID_)
	getReward(formatRewardCfgList(self.rewardList_))
	self:RefreshRewardState()

	if self.receiveCallBack_ then
		self.receiveCallBack_()
	end
end

function GuildActivityRewardItem:RefreshRewardState()
	local var_12_0 = ActivityClubLevelSettingCfg[GuildActivityData:GetCurRateID(self.activityID_)].user_level

	if table.keyof(GuildActivityData:GetReceivedList(), ActivityClubLevelSettingCfg[self.rateID_].user_level) ~= nil then
		self.rewardController_:SetSelectedState("received")
	elseif var_12_0 >= ActivityClubLevelSettingCfg[self.rateID_].user_level then
		self.rewardController_:SetSelectedState("finish")
	else
		self.rewardController_:SetSelectedState("unfinished")
	end
end

return GuildActivityRewardItem
