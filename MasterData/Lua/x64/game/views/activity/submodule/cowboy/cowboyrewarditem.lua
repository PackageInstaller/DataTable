local CowboyRewardItem = class("CowboyRewardItem", ReduxView)

function CowboyRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CowboyRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CowboyRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardBtn_ = {}
	self.rewardCon_ = {}
	self.rewardBoxs_ = {}
	self.rewardNeed_ = {}
	self.rewardPanel_ = {}

	for iter_3_0 = 1, 3 do
		self.rewardBtn_[iter_3_0] = self["rewardBtn_" .. iter_3_0]
		self.rewardCon_[iter_3_0] = ControllerUtil.GetController(self.transform_, "reward_" .. iter_3_0)
		self.rewardBoxs_[iter_3_0] = {}
		self.rewardNeed_[iter_3_0] = self["need_" .. iter_3_0]
		self.rewardPanel_[iter_3_0] = self["rewardPanel_" .. iter_3_0]
	end
end

function CowboyRewardItem:AddUIListeners()
	for iter_4_0 = 1, 3 do
		self:AddBtnListener(self.rewardBtn_[iter_4_0], nil, function()
			CowboyAction:GetReward(self.activityID_, self.infos_[iter_4_0].point_id)
		end)
	end
end

function CowboyRewardItem:OnEnter()
	return
end

function CowboyRewardItem:RefreshUI(arg_7_1, arg_7_2)
	self.mainActivityID_ = arg_7_1
	self.activityID_ = arg_7_2

	self:RefreshData()
	self:RefreshReward()
	self:RefreshState()
end

function CowboyRewardItem:RefreshData()
	self.data_ = CowboyData:GetData(self.activityID_)
	self.infos_ = self.data_.reward
	self.titleText_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), (table.indexof(ActivityCfg[self.mainActivityID_].sub_activity_list, self.activityID_)))
end

function CowboyRewardItem:RefreshReward()
	self.rewardInfo_ = ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_]

	for iter_9_0, iter_9_1 in ipairs(self.rewardInfo_) do
		self.rewardNeed_[iter_9_0].text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), ActivityPointRewardCfg[iter_9_1].need)

		for iter_9_2, iter_9_3 in ipairs(ActivityPointRewardCfg[iter_9_1].reward_item_list) do
			if not self.rewardBoxs_[iter_9_0][iter_9_2] then
				self.rewardBoxs_[iter_9_0][iter_9_2] = RewardItem.New(self.rewardItem_, self.rewardPanel_[iter_9_0], true)

				self.rewardBoxs_[iter_9_0][iter_9_2]:UpdateCommonItemAni()
			end

			self.rewardBoxs_[iter_9_0][iter_9_2]:SetData(iter_9_3)
		end

		for iter_9_4 = #ActivityPointRewardCfg[iter_9_1].reward_item_list + 1, #self.rewardBoxs_[iter_9_0] do
			self.rewardBoxs_[iter_9_0][iter_9_4]:Show(false)
		end
	end
end

function CowboyRewardItem:RefreshState()
	for iter_10_0, iter_10_1 in ipairs(self.infos_) do
		if iter_10_1.point_reward_state == 2 then
			self.rewardCon_[iter_10_0]:SetSelectedState("rewarded")
		elseif self.data_.score >= ActivityPointRewardCfg[iter_10_1.point_id].need then
			self.rewardCon_[iter_10_0]:SetSelectedState("success")
		else
			self.rewardCon_[iter_10_0]:SetSelectedState("unfinished")
		end
	end
end

function CowboyRewardItem:OnExit()
	return
end

function CowboyRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(self.rewardBoxs_) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			iter_12_3:Dispose()
		end
	end

	CowboyRewardItem.super.Dispose(self)
end

return CowboyRewardItem
