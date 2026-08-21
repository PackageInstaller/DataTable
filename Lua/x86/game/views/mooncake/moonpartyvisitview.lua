local var_0_0 = class("MoonPartyVisitView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyVisitUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.scrollView_, MoonPartyVisitItem)
	arg_4_0.selectController_ = ControllerUtil.GetController(arg_4_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.refreshBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		local var_7_0 = GameSetting.activity_mid_autumn_party_list_refresh_interval.value[1]
		local var_7_1 = MoonCakeData:GetRefreshRecommendPartyTime(arg_5_0.activityID_)

		if var_7_1 and var_7_0 > manager.time:GetServerTime() - var_7_1 then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_PROMPT")

			return
		end

		MoonCakeAction.RefreshRecommendParty(arg_5_0.activityID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.allVisitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.type_ == MoonCakeConst.VISIT_TYPE.ALL then
			return
		end

		arg_5_0:RefreshList(MoonCakeConst.VISIT_TYPE.ALL)
	end)
	arg_5_0:AddBtnListener(arg_5_0.friendVisitBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.type_ == MoonCakeConst.VISIT_TYPE.FRIEND then
			return
		end

		arg_5_0:RefreshList(MoonCakeConst.VISIT_TYPE.FRIEND)
	end)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.scrollHelper_:Dispose()

	arg_10_0.scrollHelper_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID

	if arg_11_0.params_.isReturnFromOther then
		arg_11_0.params_.isReturnFromOther = false
		arg_11_0.tempScrollPos_ = MoonCakeTools.GetTempVisitViewScrollPos(arg_11_0.activityID_) or 0
	elseif arg_11_0.params_.isBack then
		arg_11_0.params_.isBack = false
		arg_11_0.type_ = MoonCakeTools.GetTempVisitViewType(arg_11_0.activityID_) or MoonCakeConst.VISIT_TYPE.ALL
		arg_11_0.tempScrollPos_ = MoonCakeTools.GetTempVisitViewScrollPos(arg_11_0.activityID_) or 0
	else
		arg_11_0.type_ = MoonCakeConst.VISIT_TYPE.ALL
	end

	arg_11_0:RefreshList(arg_11_0.type_)
	arg_11_0:RefreshProgress()
end

function var_0_0.OnExit(arg_12_0)
	MoonCakeTools.SetTempVisitViewType(arg_12_0.activityID_, arg_12_0.type_)
	MoonCakeTools.SetTempVisitViewScrollPos(arg_12_0.activityID_, arg_12_0.scrollHelper_:GetScrolledPosition())
end

function var_0_0.RefreshList(arg_13_0, arg_13_1)
	arg_13_0.type_ = arg_13_1
	arg_13_0.visitorDataList_ = {}

	if arg_13_0.type_ == MoonCakeConst.VISIT_TYPE.ALL then
		arg_13_0.visitorDataList_ = MoonCakeData:GetSortedRecommendPartyList(arg_13_0.activityID_)
	elseif arg_13_0.type_ == MoonCakeConst.VISIT_TYPE.FRIEND then
		arg_13_0.visitorDataList_ = MoonCakeData:GetSortedFriendPartyList(arg_13_0.activityID_)
	end

	arg_13_0.selectController_:SetSelectedIndex(arg_13_0.type_)

	if not arg_13_0.tempScrollPos_ then
		arg_13_0.scrollHelper_:StartScroll(#arg_13_0.visitorDataList_)
	else
		arg_13_0.scrollHelper_:StartScrollByPosition(#arg_13_0.visitorDataList_, arg_13_0.tempScrollPos_)

		arg_13_0.tempScrollPos_ = nil
	end
end

function var_0_0.RefreshProgress(arg_14_0)
	local var_14_0 = MoonCakeData:GetTodayVisitRewardTimes(arg_14_0.activityID_)
	local var_14_1 = GameSetting.activity_mid_autumn_present_limit.value[1]

	arg_14_0.progressText_.text = string.format("%d/%d", var_14_0, var_14_1)
end

function var_0_0.IndexItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.visitorDataList_[arg_15_1]

	arg_15_2:SetData(arg_15_0.type_, arg_15_1, var_15_0, arg_15_0.activityID_)
end

function var_0_0.OnVisitOtherParty(arg_16_0)
	arg_16_0:Back()
end

function var_0_0.OnPartyRecommendUpdate(arg_17_0)
	arg_17_0:RefreshList(arg_17_0.type_)
end

return var_0_0
