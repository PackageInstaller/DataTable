local var_0_0 = import("game.tools.ActivityTools")
local var_0_1 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_2 = import("game.views.activity.Submodule.SummerRace.SummerRaceConst")
local var_0_3 = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceLimitRewardEntryView")
local var_0_4 = class("ActivitySummerRaceGamePage", var_0_1)

local function var_0_5()
	return var_0_2.ACTIVITY_ID.MAIN
end

local function var_0_6()
	return var_0_2.ACTIVITY_ID.RESIDENT
end

local function var_0_7()
	local var_3_0 = var_0_5()

	return string.format("%s%s", var_0_0.GetRedPointKey(var_3_0), var_3_0)
end

local function var_0_8()
	return string.format("%s_%s", RedPointConst.SUMMER_RACE_LIMIT_TASK, var_0_5())
end

function var_0_4.GetUIName(arg_5_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_HomeUI"
end

function var_0_4.Init(arg_6_0)
	var_0_4.super.Init(arg_6_0)

	arg_6_0.limitRewardController_ = arg_6_0.controller_:GetController("limitReward")
	arg_6_0.limitRewardEntryView_ = var_0_3.New(arg_6_0.limitedRewardEntryGo_)

	arg_6_0.limitRewardEntryView_:SetClickHandler(function()
		SummerRaceAction.OpenRewardView(var_0_2.REWARD_PAGE.LIMITED)
	end)
	arg_6_0.limitRewardEntryView_:SetVisibleChangedHandler(function(arg_8_0)
		arg_6_0.limitRewardController_:SetSelectedState(arg_8_0 and "show" or "hide")
	end)
end

function var_0_4.OnEnter(arg_9_0)
	SummerRaceData:EnsureFrameworkRedPoints()
	SummerRaceData:RefreshFrameworkRedPoints()

	arg_9_0.rewardActivityID_ = SummerRaceData:GetRewardRootActivityId()

	arg_9_0:RefreshActivityPage()
	var_0_4.super.OnEnter(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.goBtn_.transform, var_0_7())
	manager.redPoint:bindUIandKey(arg_9_0.limitRewardEntryView_:GetBindingTransform(), var_0_8())
	arg_9_0.limitRewardEntryView_:OnEnter()
end

function var_0_4.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.goBtn_.transform, var_0_7())
	manager.redPoint:unbindUIandKey(arg_10_0.limitRewardEntryView_:GetBindingTransform(), var_0_8())
	arg_10_0.limitRewardEntryView_:OnExit()
	var_0_4.super.OnExit(arg_10_0)
end

function var_0_4.Show(arg_11_0, arg_11_1)
	var_0_4.super.Show(arg_11_0, arg_11_1)

	if arg_11_1 then
		arg_11_0:RefreshActivityPage()
	end
end

function var_0_4.AddListeners(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.goBtn_, nil, function()
		SummerRaceAction.OpenMainView({
			playBodyDisplayOnEnter = true,
			playFirstPlotOnEnter = true
		})
	end)
	arg_12_0:AddBtnListener(arg_12_0.infoBtn_, nil, function()
		ChapterResidentTools.OpenResidentActTips(var_0_6())
	end)
end

function var_0_4.AddTimer(arg_15_0)
	return
end

function var_0_4.RefreshActivityPage(arg_16_0)
	SummerRaceData:RefreshFrameworkRedPoints()

	arg_16_0.rewardActivityID_ = SummerRaceData:GetRewardRootActivityId()

	local var_16_0, var_16_1 = SummerRaceData:ResolveRewardEntryPage(var_0_2.REWARD_PAGE.LIMITED)

	arg_16_0.limitRewardEntryView_:SetData({
		activityId = arg_16_0.rewardActivityID_,
		pageType = var_0_2.REWARD_PAGE.LIMITED,
		subType = var_16_1
	})
end

function var_0_4.Dispose(arg_17_0)
	if arg_17_0.limitRewardEntryView_ ~= nil then
		arg_17_0.limitRewardEntryView_:Dispose()

		arg_17_0.limitRewardEntryView_ = nil
	end

	var_0_4.super.Dispose(arg_17_0)
end

return var_0_4
