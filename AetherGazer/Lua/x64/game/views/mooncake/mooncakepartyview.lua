local var_0_0 = class("MoonCakePartyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakePartyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.partyTypeController_ = ControllerUtil.GetController(arg_4_0.transform_, "type")
	arg_4_0.rewardController_ = ControllerUtil.GetController(arg_4_0.transform_, "reward")
	arg_4_0.commonPortrait_ = CommonHeadPortrait.New(arg_4_0.headItem_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.openPartyBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonPartyOpen", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shareBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonPartyShare", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.visitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.TryQueryRecommendParty(arg_5_0.activityID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.visitNextBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.VisitNextParty(arg_5_0.activityID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.visitRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.ownerData_.isVisited then
			ShowTips("MID_AUTUMN_FESTIVAL_PARTY_VISIT_OBTAINED_REWARD")

			return
		end

		if GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(arg_5_0.activityID_) then
			ShowTips("MID_AUTUMN_FESTIVAL_PARTY_VISIT_REWARD_LIMIT")

			return
		end

		MoonCakeAction.ReceiveVisitReward(arg_5_0.activityID_, arg_5_0.ownerData_.uid)
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeTask", {
			stage = 2,
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.moonBoBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_12_0 = MoonCakeTools.GetMoonBoStageActivityID(arg_5_0.mainActivityID_)

		ActivityTools.JumpToSubmodulePage(var_12_0)
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:OnUpdate()
	arg_13_0:BindRedPoint()
	arg_13_0:AddTimer()
end

function var_0_0.OnUpdate(arg_14_0)
	arg_14_0.mainActivityID_ = arg_14_0.params_.mainActivityID
	arg_14_0.activityID_ = arg_14_0.params_.activityID
	arg_14_0.partyOwnerUID_ = arg_14_0.params_.partyOwnerUID
	arg_14_0.visitWay_ = arg_14_0.params_.visitWay

	if arg_14_0.partyOwnerUID_ == USER_ID then
		arg_14_0.isMyParty_ = true
		arg_14_0.partyData_ = MoonCakeData:GetOwnPartyData(arg_14_0.activityID_)
	else
		arg_14_0.isMyParty_ = false
		arg_14_0.partyData_ = MoonCakeData:GetVisitPartyData(arg_14_0.activityID_)
		arg_14_0.ownerData_ = MoonCakeData:GetVisitPartyOwnerData(arg_14_0.activityID_, arg_14_0.partyOwnerUID_)
	end

	arg_14_0:RefreshUI()

	arg_14_0.stopTime_ = ActivityData:GetActivityData(arg_14_0.activityID_).stopTime
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_15_0.isMyParty_ == true or arg_15_0.visitWay_ == MoonCakeConst.VISIT_WAY.SHARE then
			JumpTools.Back()
		else
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = arg_15_0.activityID_,
				mainActivityID = arg_15_0.mainActivityID_,
				partyOwnerUID = USER_ID
			})
			JumpTools.OpenPageByJump("moonPartyVisit", {
				isReturnFromOther = true,
				activityID = arg_15_0.activityID_
			})
		end
	end)
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()
	arg_17_0:UnBindRedPoint()
	arg_17_0:StopTimer()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshPartyUI()
	arg_19_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_20_0)
	if arg_20_0.isMyParty_ == true then
		if arg_20_0.partyData_.isOpened then
			arg_20_0.statusController_:SetSelectedState("selfParty")
		else
			arg_20_0.statusController_:SetSelectedState("unopen")
		end
	else
		arg_20_0.statusController_:SetSelectedState("otherParty")
	end
end

function var_0_0.RefreshPartyUI(arg_21_0)
	local var_21_0 = 0
	local var_21_1 = 0

	if arg_21_0.partyData_.isOpened then
		var_21_0 = arg_21_0.partyData_.visitNum
		var_21_1 = arg_21_0.partyData_.partyType
	end

	arg_21_0.accumulativeVisitorText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_PARTICIPANTS_NUM"), var_21_0)

	arg_21_0.partyTypeController_:SetSelectedIndex(var_21_1)

	if arg_21_0.isMyParty_ == false then
		arg_21_0.userName_.text = arg_21_0.ownerData_.nick

		arg_21_0.commonPortrait_:RenderHead(arg_21_0.ownerData_.portrait)
		arg_21_0.commonPortrait_:RenderFrame(arg_21_0.ownerData_.frame)

		local var_21_2 = false

		if MoonCakeTools.CanVisitNext(arg_21_0.activityID_) then
			var_21_2 = true
		end

		SetActive(arg_21_0.nextGo_, var_21_2)

		arg_21_0.visitorNameText_.text = PlayerData:GetPlayerInfo().nick

		arg_21_0:RefreshRewardBtn()
	end
end

function var_0_0.RefreshRewardBtn(arg_22_0)
	if GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(arg_22_0.activityID_) then
		SetActive(arg_22_0.rewardPanelGo_, false)
	else
		SetActive(arg_22_0.rewardPanelGo_, true)

		local var_22_0 = true

		if arg_22_0.ownerData_.isVisited then
			var_22_0 = false
		elseif GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(arg_22_0.activityID_) then
			var_22_0 = false
		end

		arg_22_0.rewardController_:SetSelectedIndex(var_22_0 and 1 or 0)
	end
end

function var_0_0.OnPartyOpen(arg_23_0)
	arg_23_0:RefreshUI()
end

function var_0_0.OnPartyReset(arg_24_0)
	ShowTips("MID_AUTUMN_FESTIVAL_PARTY_END")

	local var_24_0 = ActivityTools.GetActivityTheme(arg_24_0.activityID_)
	local var_24_1 = ActivityEntraceCfg.get_id_list_by_theme[var_24_0][1]
	local var_24_2 = ActivityEntraceCfg[var_24_1].jump_system
	local var_24_3 = SystemLinkCfg[var_24_2[1]].link
	local var_24_4 = var_24_2[2]

	subActivityID = ActivityVersionData:GetSelectActivityID(var_24_4)

	JumpTools.OpenPageByJump(var_24_3, {
		activityID = var_24_4,
		subActivityID = subActivityID
	})
end

function var_0_0.OnReceivedVisitReward(arg_25_0)
	arg_25_0:RefreshRewardBtn()
end

function var_0_0.AddTimer(arg_26_0)
	if manager.time:GetServerTime() >= arg_26_0.stopTime_ then
		arg_26_0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_26_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_26_0.stopTime_)

	arg_26_0:StopTimer()

	arg_26_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_26_0.stopTime_ then
			arg_26_0:StopTimer()

			arg_26_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_26_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_26_0.stopTime_)
	end, 1, -1)

	arg_26_0.timer_:Start()
end

function var_0_0.StopTimer(arg_28_0)
	if arg_28_0.timer_ then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end
end

function var_0_0.BindRedPoint(arg_29_0)
	local var_29_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_29_0.activityID_)

	manager.redPoint:bindUIandKey(arg_29_0.taskBtn_.transform, var_29_0)

	local var_29_1 = string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, arg_29_0.activityID_)

	manager.redPoint:bindUIandKey(arg_29_0.openPartyBtn_.transform, var_29_1)

	local var_29_2 = string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, arg_29_0.activityID_)

	manager.redPoint:bindUIandKey(arg_29_0.visitBtn_.transform, var_29_2)

	local var_29_3 = string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, arg_29_0.activityID_)

	manager.redPoint:bindUIandKey(arg_29_0.visitNextBtn_.transform, var_29_3)

	local var_29_4 = string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO)

	manager.redPoint:bindUIandKey(arg_29_0.moonBoBtn_.transform, var_29_4)
end

function var_0_0.UnBindRedPoint(arg_30_0)
	local var_30_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_30_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_30_0.taskBtn_.transform, var_30_0)

	local var_30_1 = string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, arg_30_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_30_0.openPartyBtn_.transform, var_30_1)

	local var_30_2 = string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, arg_30_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_30_0.visitBtn_.transform, var_30_2)

	local var_30_3 = string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, arg_30_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_30_0.visitNextBtn_.transform, var_30_3)

	local var_30_4 = string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO)

	manager.redPoint:unbindUIandKey(arg_30_0.moonBoBtn_.transform, var_30_4)
end

return var_0_0
