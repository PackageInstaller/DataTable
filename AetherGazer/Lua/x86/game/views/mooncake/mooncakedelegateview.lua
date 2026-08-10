local var_0_0 = class("MoonCakeDelegateView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeDelegateUI"
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

	arg_4_0.ownDetailView_ = MoonOwnDelegateDetailView.New(arg_4_0.ownDelegateViewGo_)
	arg_4_0.recommendView_ = MoonRecommendDelegateView.New(arg_4_0.recommendDelegateViewGo_)
	arg_4_0.refreshController_ = ControllerUtil.GetController(arg_4_0.transform_, "refresh")
	arg_4_0.pageController_ = ControllerUtil.GetController(arg_4_0.transform_, "page")
	arg_4_0.pageConst_ = {
		recommend = 2,
		own = 1
	}
	arg_4_0.pageBtnList_ = {
		arg_4_0.ownDelegateBtn_,
		arg_4_0.recommendBtn_
	}
	arg_4_0.pageViewList_ = {
		arg_4_0.ownDetailView_,
		arg_4_0.recommendView_
	}
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.pageBtnList_) do
		arg_5_0:AddBtnListener(iter_5_1, nil, function()
			if arg_5_0.curPageIndex_ and arg_5_0.curPageIndex_ == iter_5_0 then
				return
			end

			arg_5_0:SwitchPage(iter_5_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.refreshBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if arg_5_0.curPageIndex_ == arg_5_0.pageConst_.recommend then
			if arg_5_0.leftTime_ and arg_5_0.leftTime_ > 0 then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_PROMPT")

				return
			end

			MoonCakeAction.QueryRecommendDelegate(arg_5_0.activityID_, function()
				arg_5_0:AddCdTimer()
			end)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.recordBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeDelegateRecord", {
			activityID = arg_5_0.activityID_,
			recoverType = arg_5_0.curPageIndex_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.pageViewList_) do
		iter_11_1:Dispose()
	end

	arg_11_0.pageViewList_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityID

	if arg_12_0.params_.isBack then
		arg_12_0.params_.isBack = false
		arg_12_0.curPageIndex_ = MoonCakeTools.GetTempDelegateViewPageIndex(arg_12_0.activityID_) or arg_12_0.pageConst_.own

		if arg_12_0.curPageIndex_ == arg_12_0.pageConst_.recommend then
			arg_12_0.tempScrollPos_ = MoonCakeTools.GetTempDelegateViewScrollPos(arg_12_0.activityID_)
		end
	else
		arg_12_0.curPageIndex_ = arg_12_0.pageConst_.own
	end

	arg_12_0:SwitchPage(arg_12_0.curPageIndex_)
	arg_12_0:PageRegisterEvent()
	arg_12_0:BindRedPoint()
	arg_12_0:AddCdTimer()
end

function var_0_0.OnExit(arg_13_0)
	MoonCakeTools.SetTempDelegateViewPageIndex(arg_13_0.activityID_, arg_13_0.curPageIndex_)

	if arg_13_0.curPageIndex_ == arg_13_0.pageConst_.recommend then
		MoonCakeTools.SetTempDelegateViewScrollPos(arg_13_0.activityID_, arg_13_0.pageViewList_[arg_13_0.curPageIndex_]:GetScrollPos())
	end

	arg_13_0.pageViewList_[arg_13_0.curPageIndex_]:Show(false)
	arg_13_0:StopCdTimer()
	arg_13_0:PageRemoveEvent()
	arg_13_0:UnBindRedPoint()
end

function var_0_0.SwitchPage(arg_14_0, arg_14_1)
	arg_14_0.pageViewList_[arg_14_0.curPageIndex_]:Show(false)

	arg_14_0.curPageIndex_ = arg_14_1

	arg_14_0.pageViewList_[arg_14_0.curPageIndex_]:Show(true)
	arg_14_0.pageViewList_[arg_14_0.curPageIndex_]:SetData(arg_14_0.activityID_, arg_14_0.tempScrollPos_)

	if arg_14_0.tempScrollPos_ then
		arg_14_0.tempScrollPos_ = nil
	end

	arg_14_0.pageController_:SetSelectedIndex(arg_14_0.curPageIndex_ - 1)
end

function var_0_0.PageRegisterEvent(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.pageViewList_) do
		iter_15_1:PageRegisterEvent()
	end
end

function var_0_0.PageRemoveEvent(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.pageViewList_) do
		iter_16_1:PageRemoveEvent()
	end
end

function var_0_0.OnFriendsListChange(arg_17_0)
	if arg_17_0.pageViewList_[arg_17_0.curPageIndex_].OnFriendsListChange then
		arg_17_0.pageViewList_[arg_17_0.curPageIndex_]:OnFriendsListChange()
	end
end

function var_0_0.AddCdTimer(arg_18_0)
	arg_18_0:StopCdTimer()

	local var_18_0 = MoonCakeData:GetLastRefreshDelegateTime(arg_18_0.activityID_)
	local var_18_1 = manager.time:GetServerTime()
	local var_18_2 = GameSetting.activity_mid_autumn_entrust_list_refresh_interval.value[1]

	arg_18_0.leftTime_ = var_18_0 + var_18_2 + 1 - var_18_1

	if arg_18_0.leftTime_ <= 0 then
		return
	end

	arg_18_0.cdTimeText_.text = var_18_2 >= arg_18_0.leftTime_ and arg_18_0.leftTime_ or var_18_2
	arg_18_0.cdTimer_ = Timer.New(function()
		arg_18_0.leftTime_ = arg_18_0.leftTime_ - 1
		arg_18_0.cdTimeText_.text = arg_18_0.leftTime_

		if arg_18_0.leftTime_ <= 0 then
			arg_18_0:StopCdTimer()

			return
		end
	end, 1, -1)

	arg_18_0.cdTimer_:Start()
	arg_18_0.refreshController_:SetSelectedState("off")
end

function var_0_0.StopCdTimer(arg_20_0)
	if arg_20_0.cdTimer_ then
		arg_20_0.cdTimer_:Stop()

		arg_20_0.cdTimer_ = nil
	end

	arg_20_0.refreshController_:SetSelectedState("on")

	arg_20_0.leftTime_ = 0
end

function var_0_0.BindRedPoint(arg_21_0)
	local var_21_0 = string.format("%s_%s", RedPointConst.MOON_DELEGATE, arg_21_0.activityID_)

	manager.redPoint:bindUIandKey(arg_21_0.ownDelegateBtn_.transform, var_21_0)
end

function var_0_0.UnBindRedPoint(arg_22_0)
	local var_22_0 = string.format("%s_%s", RedPointConst.MOON_DELEGATE, arg_22_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_22_0.ownDelegateBtn_.transform, var_22_0)
end

return var_0_0
