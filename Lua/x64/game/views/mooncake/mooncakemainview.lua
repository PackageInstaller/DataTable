local var_0_0 = class("MoonCakeMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeMainUI"
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
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.makeFillingBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectMakeFillingBtn(arg_5_0.activityID_)
		MoonCakeAction.UpdateFillingMakeRedPoint(arg_5_0.activityID_)
		JumpTools.OpenPageByJump("moonFillingMake", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.makeMoonCakeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectMakeCakeBtn(arg_5_0.activityID_)
		MoonCakeAction.UpdateCakeMakeRedPoint(arg_5_0.activityID_)
		JumpTools.OpenPageByJump("moonCakeMake", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bagBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/moonCakeBag", {
			activityID = arg_5_0.activityID_,
			mainActivityID = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.delegateBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.RefreshRecommendDelegate(arg_5_0.activityID_, function()
			JumpTools.OpenPageByJump("moonCakeDelegate", {
				activityID = arg_5_0.activityID_
			})
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeTask", {
			stage = 1,
			activityID = arg_5_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.mainActivityID_ = arg_12_0.params_.mainActivityID
	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.stopTime_ = ActivityData:GetActivityData(arg_12_0.activityID_).stopTime

	arg_12_0:AddTimer()
	arg_12_0:RefreshUI()
	arg_12_0:BindRedPoint()
end

function var_0_0.OnTop(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
	arg_14_0:StopTimer()
	arg_14_0:UnBindRedPoint()
end

function var_0_0.RefreshUI(arg_15_0)
	return
end

function var_0_0.AddTimer(arg_16_0)
	if manager.time:GetServerTime() >= arg_16_0.stopTime_ then
		arg_16_0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_16_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_16_0.stopTime_)

	arg_16_0:StopTimer()

	arg_16_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_16_0.stopTime_ then
			arg_16_0:StopTimer()

			arg_16_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_16_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_16_0.stopTime_)
	end, 1, -1)

	arg_16_0.timer_:Start()
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

function var_0_0.BindRedPoint(arg_19_0)
	local var_19_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_19_0.activityID_)

	manager.redPoint:bindUIandKey(arg_19_0.taskBtn_.transform, var_19_0)

	local var_19_1 = string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_19_0.activityID_)

	manager.redPoint:bindUIandKey(arg_19_0.makeFillingBtn_.transform, var_19_1)

	local var_19_2 = string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, arg_19_0.activityID_)

	manager.redPoint:bindUIandKey(arg_19_0.makeMoonCakeBtn_.transform, var_19_2)

	local var_19_3 = string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, arg_19_0.activityID_)

	manager.redPoint:bindUIandKey(arg_19_0.bagBtn_.transform, var_19_3)

	local var_19_4 = string.format("%s_%s", RedPointConst.MOON_DELEGATE, arg_19_0.activityID_)

	manager.redPoint:bindUIandKey(arg_19_0.delegateBtn_.transform, var_19_4)
end

function var_0_0.UnBindRedPoint(arg_20_0)
	local var_20_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_20_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_20_0.taskBtn_.transform, var_20_0)

	local var_20_1 = string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, arg_20_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_20_0.makeFillingBtn_.transform, var_20_1)

	local var_20_2 = string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, arg_20_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_20_0.makeMoonCakeBtn_.transform, var_20_2)

	local var_20_3 = string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, arg_20_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_20_0.bagBtn_.transform, var_20_3)

	local var_20_4 = string.format("%s_%s", RedPointConst.MOON_DELEGATE, arg_20_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_20_0.delegateBtn_.transform, var_20_4)
end

return var_0_0
