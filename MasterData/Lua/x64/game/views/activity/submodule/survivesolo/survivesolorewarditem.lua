local SurviveSoloRewardItem = class("SurviveSoloRewardItem", ReduxView)

function SurviveSoloRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SurviveSoloRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SurviveSoloRewardItem:InitUI()
	self:BindCfgUI()

	self.btn_ = {}
	self.title_ = {}
	self.rewards_ = {}
	self.stateCon_ = {}
	self.rewardPanel_ = {}

	for iter_3_0 = 1, 3 do
		self.btn_[iter_3_0] = self["btn_" .. iter_3_0]
		self.title_[iter_3_0] = self["title_" .. iter_3_0]
		self.rewards_[iter_3_0] = {}
		self.stateCon_[iter_3_0] = ControllerUtil.GetController(self["item_" .. iter_3_0].transform, "state")
		self.rewardPanel_[iter_3_0] = self["rewardPanel_" .. iter_3_0]
	end
end

function SurviveSoloRewardItem:AddUIListeners()
	for iter_4_0, iter_4_1 in ipairs(self.btn_) do
		self:AddBtnListener(self.btn_[iter_4_0], nil, function()
			SurviveSoloAction:GetReward(self.activityID_, self.cfg_.reward_item_list[iter_4_0][1])
		end)
	end
end

function SurviveSoloRewardItem:OnEnter()
	return
end

function SurviveSoloRewardItem:Refresh(arg_7_1, arg_7_2)
	self.activityID_ = arg_7_1
	self.mainActivityID_ = arg_7_2
	self.cfg_ = ActivitySoloSlayerCfg[self.activityID_]

	self:RefreshUI()
end

function SurviveSoloRewardItem:RefreshUI()
	self.level_.text = GetI18NText(BattleSoloSlayerCfg[self.cfg_.stage_id].name)

	local var_8_0 = SurviveSoloData:GetData(self.activityID_)

	for iter_8_0 = 1, 3 do
		self.title_[iter_8_0].text = string.format(GetTips("ACTIVITY_SOLO_SLAYER_REWARD"), self.cfg_.reward_item_list[iter_8_0][1])

		for iter_8_1, iter_8_2 in ipairs(self.cfg_.reward_item_list[iter_8_0][2]) do
			self.rewards_[iter_8_0][iter_8_1] = self.rewards_[iter_8_0][iter_8_1] or SurviveSoloTools.GetRewardItemSkin(self.mainActivityID_).New(Object.Instantiate(self.rewardItem_, self.rewardPanel_[iter_8_0]), self.rewardPanel_[iter_8_0])

			self.rewards_[iter_8_0][iter_8_1]:SetData(iter_8_2, POP_ITEM)
		end

		for iter_8_3 = #self.cfg_.reward_item_list[iter_8_0][2] + 1, #self.rewards_[iter_8_0] do
			self.rewards_[iter_8_0][iter_8_3]:Show(false)
		end

		if var_8_0 and var_8_0.time >= self.cfg_.reward_item_list[iter_8_0][1] then
			if table.indexof(var_8_0.rewards, self.cfg_.reward_item_list[iter_8_0][1]) then
				self.stateCon_[iter_8_0]:SetSelectedState("received")
			else
				self.stateCon_[iter_8_0]:SetSelectedState("complete")
			end
		else
			self.stateCon_[iter_8_0]:SetSelectedState("incomplete")
		end
	end
end

function SurviveSoloRewardItem:OnExit()
	return
end

function SurviveSoloRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_10_0 = 1, 3 do
		for iter_10_1, iter_10_2 in ipairs(self.rewards_[iter_10_0]) do
			iter_10_2:Dispose()

			iter_10_2 = nil
		end

		self.rewards_[iter_10_0] = nil
	end

	self.rewards_ = {}

	SurviveSoloRewardItem.super.Dispose(self)
end

return SurviveSoloRewardItem
