local SoloChallengeMainView = class("SoloChallengeMainView", ReduxView)

function SoloChallengeMainView:UIName()
	return "UI/VersionUI/SummerUI/SummerSoloChallengeUI"
end

function SoloChallengeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloChallengeMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.switchItemList_ = {}
	self.rewardItemList_ = {}
	self.onClickHandler_ = handler(self, self.OnClick)
	self.adaptImg_ = self:FindCom("SelfAdaptImage", nil, self.roleTras_)
	self.rewardState_ = ControllerUtil.GetController(self.rewardTrans_, "rewardState")
end

function SoloChallengeMainView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.difficultyIndex_ = 1
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
	self:RefreshUI()
	self:RefreshActivityDesc()

	local var_4_0 = SoloChallengeData:GetContentPosX(self.activityID_)

	if var_4_0 ~= nil then
		self.switchPanelTrans_.localPosition.x = var_4_0
		self.switchPanelTrans_.localPosition = self.switchPanelTrans_.localPosition
	end
end

function SoloChallengeMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_CHALLENGE_DESCRIPE")
end

function SoloChallengeMainView:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeAction.RequireReceive(self.selectActivityID_, 1, function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				getReward2(mergeReward2(arg_8_0.reward_list))
				SoloChallengeData:SetReceivedActivityList(self.selectActivityID_, self.difficultyIndex_)
				self:RefreshReward()
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeData:SetSelectedDifficultyIndex(self.selectActivityID_, self.difficultyIndex_)
		SoloChallengeAction.SaveDifficulty(self.selectActivityID_, self.difficultyIndex_, handler(self, self.OnStart))
	end)
end

function SoloChallengeMainView:OnStart()
	self:Go("/soloChallengeSelect", {
		activityID = self.selectActivityID_,
		difficultyIndex = self.difficultyIndex_
	})
end

function SoloChallengeMainView:RefreshUI()
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list

	local var_11_0 = SoloChallengeData:GetSelectActivityID(self.activityID_) or self.subActivityList_[1]

	self.selectActivityID_ = var_11_0

	if var_11_0 == nil then
		return
	end

	SoloChallengeData:SetSelectActivityID(self.activityID_, var_11_0)
	self:RefreshSwitchItem()
	self:RefreshReward()
	self:RefreshRoleImage()
	self:RefreshDesc()
end

function SoloChallengeMainView:RefreshSwitchItem()
	for iter_12_0, iter_12_1 in ipairs(self.subActivityList_) do
		if self.switchItemList_[iter_12_0] == nil then
			self.switchItemList_[iter_12_0] = self:GetSwitchItemClass().New(self.switchItem_, self.switchPanel_, iter_12_1, self.activityID_)

			self.switchItemList_[iter_12_0]:RegisterClickListener(self.onClickHandler_)
		end

		self.switchItemList_[iter_12_0]:SetActivityID(iter_12_1, self.activityID_)
	end

	for iter_12_2 = #self.switchItemList_, #self.subActivityList_ + 1, -1 do
		self.switchItemList_[iter_12_2]:Dispose()

		self.switchItemList_[iter_12_2] = nil
	end

	self:RefreshSelectactivity(self.selectActivityID_)
end

function SoloChallengeMainView:GetSwitchItemClass()
	return SoloChallengeSwitchItem
end

function SoloChallengeMainView:RefreshReward()
	for iter_14_0, iter_14_1 in ipairs(ActivitySoloChallengeCfg[self.selectActivityID_].reward_item_list[self.difficultyIndex_][2]) do
		if self.rewardItemList_[iter_14_0] then
			self.rewardItemList_[iter_14_0]:SetData(iter_14_1, false)
		else
			self.rewardItemList_[iter_14_0] = RewardPoolItem.New(self.goRewardPanel_, iter_14_1)
		end
	end

	for iter_14_2 = #ActivitySoloChallengeCfg[self.selectActivityID_].reward_item_list[self.difficultyIndex_][2] + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_14_2]:Show(false)
	end

	local var_14_0 = table.keyof(SoloChallengeData:GetReceivedActivityList()[self.selectActivityID_], self.difficultyIndex_) ~= nil

	if table.keyof(SoloChallengeData:GetCompletedActivityList()[self.selectActivityID_], self.difficultyIndex_) == nil then
		self.rewardState_:SetSelectedState("uncompleted")
	elseif not var_14_0 then
		self.rewardState_:SetSelectedState("unreceived")
	else
		self.rewardState_:SetSelectedState("received")
	end
end

function SoloChallengeMainView:RefreshRoleImage()
	self.roleImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/SummerUI/" .. ActivitySoloChallengeCfg[self.selectActivityID_].background)

	self.adaptImg_:AdaptImg()
end

function SoloChallengeMainView:RefreshActivityDesc()
	self.activityDescText_.text = GetTips("ACTIVITY_SOLO_CHALLENGE_CONTENT")
end

function SoloChallengeMainView:RefreshDesc()
	self.nameText_.text = GetI18NText(ActivitySoloChallengeCfg[self.selectActivityID_].name)
	self.descText_.text = GetI18NText(ActivitySoloChallengeCfg[self.selectActivityID_].desc)
end

function SoloChallengeMainView:OnClick()
	self:RefreshUI()
end

function SoloChallengeMainView:RefreshSelectactivity(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self.switchItemList_) do
		iter_19_1:OnSelect(arg_19_1)
	end
end

function SoloChallengeMainView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self:StopTimer()

	if self.switchItemList_ then
		for iter_20_0, iter_20_1 in ipairs(self.switchItemList_) do
			iter_20_1:RefreshLock()
		end
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		if self.switchItemList_ then
			for iter_21_0, iter_21_1 in ipairs(self.switchItemList_) do
				iter_21_1:RefreshLock()
			end
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function SoloChallengeMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SoloChallengeMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	SoloChallengeData:SetContentPosX(self.activityID_, self.switchPanelTrans_.localPosition.x)
end

function SoloChallengeMainView:Dispose()
	SoloChallengeMainView.super.Dispose(self)
	self:StopTimer()

	self.onClickHandler_ = nil

	for iter_24_0, iter_24_1 in pairs(self.rewardItemList_) do
		iter_24_1:Dispose()
	end

	self.rewardItemList_ = nil

	for iter_24_2, iter_24_3 in pairs(self.switchItemList_) do
		iter_24_3:Dispose()
	end

	self.switchItemList_ = nil
end

return SoloChallengeMainView
