local var_0_0 = import("game.views.activity.Submodule.SummerRace.SummerRaceConst")
local var_0_1 = class("SummerRaceLimitRewardEntryView", ReduxView)

local function var_0_2(arg_1_0)
	local var_1_0 = tonumber(arg_1_0) or 0

	if var_1_0 == 0 then
		return "", false
	end

	local var_1_1 = ActivityData:GetActivityData(var_1_0)

	if var_1_1 == nil then
		return "", false
	end

	if ActivityData:GetActivityIsOpen(var_1_0) then
		return manager.time:GetLostTimeStr2(var_1_1.stopTime), true
	end

	if manager.time:GetServerTime() < var_1_1.startTime then
		return string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_1_1.startTime)), true
	end

	return GetTips("TIME_OVER"), false
end

local function var_0_3(arg_2_0)
	if arg_2_0.rewardBtn_ == nil then
		return arg_2_0.transform_
	end

	return arg_2_0.rewardBtn_.transform
end

function var_0_1.OnCtor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_0.gameObject_.transform

	arg_3_0:Init()
end

function var_0_1.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		if arg_4_0.clickHandler_ ~= nil and arg_4_0.isVisible_ == true then
			arg_4_0.clickHandler_(arg_4_0.pageType_, arg_4_0.subType_)
		end
	end)
end

function var_0_1.SetClickHandler(arg_6_0, arg_6_1)
	arg_6_0.clickHandler_ = arg_6_1
end

function var_0_1.SetCountdownText(arg_7_0, arg_7_1)
	arg_7_0.countdownText_ = arg_7_1 or ""

	if arg_7_0.timeText_ ~= nil then
		arg_7_0.timeText_.text = arg_7_0.countdownText_
	end
end

function var_0_1.SetVisible(arg_8_0, arg_8_1)
	arg_8_0.isVisible_ = arg_8_1 == true

	if arg_8_0.visibilityChangedHandler_ ~= nil then
		arg_8_0.visibilityChangedHandler_(arg_8_0.isVisible_)
	end
end

function var_0_1.SetVisibleChangedHandler(arg_9_0, arg_9_1)
	arg_9_0.visibilityChangedHandler_ = arg_9_1
end

function var_0_1.GetBindingTransform(arg_10_0)
	return var_0_3(arg_10_0)
end

function var_0_1.SetData(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or {}

	arg_11_0.activityId_ = tonumber(var_11_0.activityId) or 0
	arg_11_0.pageType_ = var_11_0.pageType or var_0_0.REWARD_PAGE.LIMITED
	arg_11_0.subType_ = var_11_0.subType or var_0_0.REWARD_SUBTYPE.DAILY

	if arg_11_0.active_ == true then
		arg_11_0:RefreshCountdown()
	end
end

function var_0_1.OnEnter(arg_12_0)
	arg_12_0.active_ = true

	arg_12_0:RefreshCountdown()
	arg_12_0:StartTimer()
end

function var_0_1.OnExit(arg_13_0)
	arg_13_0.active_ = false

	arg_13_0:StopTimer()
end

function var_0_1.RefreshCountdown(arg_14_0)
	local var_14_0, var_14_1 = var_0_2(arg_14_0.activityId_)

	arg_14_0:SetVisible(var_14_1)
	arg_14_0:SetCountdownText(var_14_0)
	SetActive(arg_14_0.gameObject_, arg_14_0.isVisible_)
end

function var_0_1.StartTimer(arg_15_0)
	arg_15_0:StopTimer()

	if arg_15_0.activityId_ == nil or arg_15_0.activityId_ == 0 then
		return
	end

	arg_15_0.timer_ = Timer.New(function()
		arg_15_0:RefreshCountdown()
	end, 1, -1)

	arg_15_0.timer_:Start()
end

function var_0_1.StopTimer(arg_17_0)
	if arg_17_0.timer_ ~= nil then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_1.Dispose(arg_18_0)
	arg_18_0:StopTimer()
	var_0_1.super.Dispose(arg_18_0)
end

return var_0_1
