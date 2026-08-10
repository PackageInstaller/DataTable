local var_0_0 = class("SummerRaceUnlockBannerView", ReduxView)
local var_0_1 = "UI_Activity_SummerRace_StageUnlockPopUI_cx"
local var_0_2 = 0.05
local var_0_3 = 0.2

local function var_0_4(arg_1_0)
	return arg_1_0 == SummerRaceConst.SOURCE_TYPE.CHALLENGE and "challenge" or "practice"
end

local function var_0_5(arg_2_0, arg_2_1)
	if arg_2_0 == nil or arg_2_0.runtimeAnimatorController == nil then
		return nil
	end

	local var_2_0 = arg_2_0.runtimeAnimatorController.animationClips

	if var_2_0 == nil then
		return nil
	end

	local var_2_1 = tostring(arg_2_1 or "")

	for iter_2_0 = 0, var_2_0.Length - 1 do
		local var_2_2 = var_2_0[iter_2_0]

		if var_2_2 ~= nil and tostring(var_2_2.name or "") == var_2_1 then
			return tonumber(var_2_2.length)
		end
	end

	return nil
end

local function var_0_6(arg_3_0)
	arg_3_0:StopAutoCloseTimer_()
	JumpTools.Back()
	arg_3_0:ScheduleFollowupUnlock_()
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_StageUnlockPopUI"
end

function var_0_0.UIParent(arg_5_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_6_0)
	arg_6_0:BindCfgUI()
	arg_6_0:BindViewRuntime()

	arg_6_0.followupUnlockTimer_ = nil

	arg_6_0:AddUIListener()
end

function var_0_0.BindViewRuntime(arg_7_0)
	arg_7_0.modeController_ = arg_7_0.controllerEx_:GetController("mode")
	arg_7_0.unlockBannerAnimator_ = arg_7_0.transform_:GetComponent(typeof(Animator))
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshView()
	arg_8_0:StopAutoCloseTimer_()

	local var_8_0 = var_0_5(arg_8_0.unlockBannerAnimator_, var_0_1)
	local var_8_1 = var_8_0 ~= nil and var_8_0 + var_0_3 or nil
	local var_8_2 = 0

	if arg_8_0.unlockBannerAnimator_ ~= nil then
		arg_8_0.unlockBannerAnimator_:Play(var_0_1, -1, 0)
		arg_8_0.unlockBannerAnimator_:Update(0)
	end

	arg_8_0.autoCloseTimer_ = Timer.New(function()
		var_8_2 = var_8_2 + var_0_2

		if arg_8_0.unlockBannerAnimator_ == nil then
			var_0_6(arg_8_0)

			return
		end

		local var_9_0 = arg_8_0.unlockBannerAnimator_:GetCurrentAnimatorStateInfo(0)

		if var_9_0 ~= nil and var_9_0:IsName(var_0_1) and var_9_0.normalizedTime >= 1 or var_8_1 ~= nil and var_8_2 >= var_8_1 then
			var_0_6(arg_8_0)
		end
	end, var_0_2, -1)

	arg_8_0.autoCloseTimer_:Start()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:StopAutoCloseTimer_()
	arg_10_0:StopFollowupUnlockTimer_()
end

function var_0_0.AddUIListener(arg_11_0)
	return
end

function var_0_0.RefreshView(arg_12_0)
	local var_12_0 = "modify"
	local var_12_1

	if arg_12_0.params_ ~= nil and arg_12_0.params_.sourceType ~= nil then
		var_12_0 = arg_12_0.params_.sourceType
	end

	if arg_12_0.params_ ~= nil and type(arg_12_0.params_.unlockBannerModel) == "table" then
		var_12_1 = arg_12_0.params_.unlockBannerModel
	else
		var_12_1 = SummerRaceData:GetUnlockBannerModel(var_12_0)
	end

	local var_12_2 = GetI18NText(var_12_1.title)

	arg_12_0.practiceText_.text = var_12_2
	arg_12_0.challengeText_.text = var_12_2

	arg_12_0.modeController_:SetSelectedState(var_0_4(var_12_1.sourceType))
end

function var_0_0.StopAutoCloseTimer_(arg_13_0)
	if arg_13_0.autoCloseTimer_ then
		arg_13_0.autoCloseTimer_:Stop()

		arg_13_0.autoCloseTimer_ = nil
	end
end

function var_0_0.ScheduleFollowupUnlock_(arg_14_0)
	arg_14_0:StopFollowupUnlockTimer_()

	arg_14_0.followupUnlockTimer_ = Timer.New(function()
		arg_14_0:StopFollowupUnlockTimer_()
		SummerRaceAction.TryContinuePendingUnlockFlow()
	end, 0.05, 1)

	arg_14_0.followupUnlockTimer_:Start()
end

function var_0_0.StopFollowupUnlockTimer_(arg_16_0)
	if arg_16_0.followupUnlockTimer_ then
		arg_16_0.followupUnlockTimer_:Stop()

		arg_16_0.followupUnlockTimer_ = nil
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:StopAutoCloseTimer_()
	arg_17_0:StopFollowupUnlockTimer_()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
