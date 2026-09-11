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
	self.receiveCon_ = {}
	self.receiveCon_[1] = ControllerUtil.GetController(self.statebtnTrs_1, "stateBtn")
	self.receiveCon_[2] = ControllerUtil.GetController(self.statebtnTrs_2, "stateBtn")
	self.receiveCon_[3] = ControllerUtil.GetController(self.statebtnTrs_3, "stateBtn")
end

function LeviathanGameRewardItem:AddUIListeners()
	for iter_4_0 = 1, 3 do
		self:AddBtnListener(self["statebtnBtn_" .. iter_4_0], nil, function()
			SummerLittleGameAction.GetSkadiReward(self.activityID_, iter_4_0)
		end)
	end
end

function LeviathanGameRewardItem:OnEnter()
	return
end

function LeviathanGameRewardItem:RefreshUI(arg_7_1)
	self.activityID_ = arg_7_1
	self.textText_.text = GetI18NText(ActivityCrossWaveCfg[self.activityID_].name)

	for iter_7_0 = 1, 3 do
		self:RefreshReward(iter_7_0)
		self:RefreshType(iter_7_0)
	end
end

function LeviathanGameRewardItem:RefreshReward(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(ActivityCrossWaveCfg[self.activityID_].reward_item_list[arg_8_1]) do
		self.rewardList_[arg_8_1] = self.rewardList_[arg_8_1] or {}

		if not self.rewardList_[arg_8_1][iter_8_0] then
			self.rewardList_[arg_8_1][iter_8_0] = RewardItem.New(self.rewardItem_, self["rewardParent_" .. arg_8_1])

			self.rewardList_[arg_8_1][iter_8_0]:UpdateCommonItemAni()
		end

		self.rewardList_[arg_8_1][iter_8_0]:SetData(iter_8_1)
	end

	for iter_8_2 = #ActivityCrossWaveCfg[self.activityID_].reward_item_list[arg_8_1] + 1, #self.rewardList_[arg_8_1] do
		self.rewardList_[arg_8_1][iter_8_2]:Show(false)
	end
end

function LeviathanGameRewardItem:RefreshType(arg_9_1)
	if arg_9_1 > #SummerLittleGameData:GetSkadiStars(self.activityID_) then
		self.receiveCon_[arg_9_1]:SetSelectedState("unfinished")
	elseif table.indexof(SummerLittleGameData:GetSkadiReward(self.activityID_), arg_9_1) then
		self.receiveCon_[arg_9_1]:SetSelectedState("rewarded")
	else
		self.receiveCon_[arg_9_1]:SetSelectedState("success")
	end
end

function LeviathanGameRewardItem:OnExit()
	return
end

function LeviathanGameRewardItem:Dispose()
	self:RemoveAllListeners()

	for iter_11_0, iter_11_1 in ipairs(self.rewardList_) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			iter_11_3:Dispose()
		end
	end

	LeviathanGameRewardItem.super.Dispose(self)
end

return LeviathanGameRewardItem
