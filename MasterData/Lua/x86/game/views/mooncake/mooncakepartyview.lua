local MoonCakePartyView = class("MoonCakePartyView", ReduxView)

function MoonCakePartyView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakePartyUI"
end

function MoonCakePartyView:UIParent()
	return manager.ui.uiMain.transform
end

function MoonCakePartyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonCakePartyView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.partyTypeController_ = ControllerUtil.GetController(self.transform_, "type")
	self.rewardController_ = ControllerUtil.GetController(self.transform_, "reward")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function MoonCakePartyView:AddUIListener()
	self:AddBtnListener(self.openPartyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonPartyOpen", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.shareBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonPartyShare", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.visitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.TryQueryRecommendParty(self.activityID_)
	end)
	self:AddBtnListener(self.visitNextBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.VisitNextParty(self.activityID_)
	end)
	self:AddBtnListener(self.visitRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.ownerData_.isVisited then
			ShowTips("MID_AUTUMN_FESTIVAL_PARTY_VISIT_OBTAINED_REWARD")

			return
		end

		if GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(self.activityID_) then
			ShowTips("MID_AUTUMN_FESTIVAL_PARTY_VISIT_REWARD_LIMIT")

			return
		end

		MoonCakeAction.ReceiveVisitReward(self.activityID_, self.ownerData_.uid)
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeTask", {
			stage = 2,
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.moonBoBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ActivityTools.JumpToSubmodulePage((MoonCakeTools.GetMoonBoStageActivityID(self.mainActivityID_)))
	end)
end

function MoonCakePartyView:OnEnter()
	self:OnUpdate()
	self:BindRedPoint()
	self:AddTimer()
end

function MoonCakePartyView:OnUpdate()
	self.mainActivityID_ = self.params_.mainActivityID
	self.activityID_ = self.params_.activityID
	self.partyOwnerUID_ = self.params_.partyOwnerUID
	self.visitWay_ = self.params_.visitWay

	if self.partyOwnerUID_ == USER_ID then
		self.isMyParty_ = true
		self.partyData_ = MoonCakeData:GetOwnPartyData(self.activityID_)
	else
		self.isMyParty_ = false
		self.partyData_ = MoonCakeData:GetVisitPartyData(self.activityID_)
		self.ownerData_ = MoonCakeData:GetVisitPartyOwnerData(self.activityID_, self.partyOwnerUID_)
	end

	self:RefreshUI()

	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime
end

function MoonCakePartyView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.isMyParty_ == true or self.visitWay_ == MoonCakeConst.VISIT_WAY.SHARE then
			JumpTools.Back()
		else
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = self.activityID_,
				mainActivityID = self.mainActivityID_,
				partyOwnerUID = USER_ID
			})
			JumpTools.OpenPageByJump("moonPartyVisit", {
				isReturnFromOther = true,
				activityID = self.activityID_
			})
		end
	end)
end

function MoonCakePartyView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()
	self:StopTimer()
end

function MoonCakePartyView:Dispose()
	self.commonPortrait_:Dispose()
	MoonCakePartyView.super.Dispose(self)
end

function MoonCakePartyView:RefreshUI()
	self:RefreshPartyUI()
	self:RefreshStatus()
end

function MoonCakePartyView:RefreshStatus()
	if self.isMyParty_ == true then
		if self.partyData_.isOpened then
			self.statusController_:SetSelectedState("selfParty")
		else
			self.statusController_:SetSelectedState("unopen")
		end
	else
		self.statusController_:SetSelectedState("otherParty")
	end
end

function MoonCakePartyView:RefreshPartyUI()
	local var_21_0 = 0
	local var_21_1 = 0

	if self.partyData_.isOpened then
		var_21_0 = self.partyData_.visitNum
		var_21_1 = self.partyData_.partyType
	end

	self.accumulativeVisitorText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_PARTICIPANTS_NUM"), var_21_0)

	self.partyTypeController_:SetSelectedIndex(var_21_1)

	if self.isMyParty_ == false then
		self.userName_.text = self.ownerData_.nick

		self.commonPortrait_:RenderHead(self.ownerData_.portrait)
		self.commonPortrait_:RenderFrame(self.ownerData_.frame)
		SetActive(self.nextGo_, not not MoonCakeTools.CanVisitNext(self.activityID_))

		self.visitorNameText_.text = PlayerData:GetPlayerInfo().nick

		self:RefreshRewardBtn()
	end
end

function MoonCakePartyView:RefreshRewardBtn()
	if GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(self.activityID_) then
		SetActive(self.rewardPanelGo_, false)
	else
		SetActive(self.rewardPanelGo_, true)

		local var_22_0 = true

		if self.ownerData_.isVisited then
			var_22_0 = false
		elseif GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(self.activityID_) then
			var_22_0 = false
		end

		self.rewardController_:SetSelectedIndex(var_22_0 and 1 or 0)
	end
end

function MoonCakePartyView:OnPartyOpen()
	self:RefreshUI()
end

function MoonCakePartyView:OnPartyReset()
	ShowTips("MID_AUTUMN_FESTIVAL_PARTY_END")

	local var_24_0 = ActivityEntraceCfg[ActivityEntraceCfg.get_id_list_by_theme[ActivityTools.GetActivityTheme(self.activityID_)][1]].jump_system

	subActivityID = ActivityVersionData:GetSelectActivityID(var_24_0[2])

	JumpTools.OpenPageByJump(SystemLinkCfg[var_24_0[1]].link, {
		activityID = var_24_0[2],
		subActivityID = subActivityID
	})
end

function MoonCakePartyView:OnReceivedVisitReward()
	self:RefreshRewardBtn()
end

function MoonCakePartyView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		self.remainTimeText_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function MoonCakePartyView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function MoonCakePartyView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_)))
	manager.redPoint:bindUIandKey(self.openPartyBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, self.activityID_)))
	manager.redPoint:bindUIandKey(self.visitBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, self.activityID_)))
	manager.redPoint:bindUIandKey(self.visitNextBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, self.activityID_)))
	manager.redPoint:bindUIandKey(self.moonBoBtn_.transform, (string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO)))
end

function MoonCakePartyView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.openPartyBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.visitBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.visitNextBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, self.activityID_)))
	manager.redPoint:unbindUIandKey(self.moonBoBtn_.transform, (string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO)))
end

return MoonCakePartyView
