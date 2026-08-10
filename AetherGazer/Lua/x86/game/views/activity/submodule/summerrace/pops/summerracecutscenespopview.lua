local var_0_0 = class("SummerRaceCutScenesPopView", ReduxView)
local var_0_1 = "UI_Activity_OsirisHorus_CutScenesPopUI_xs"
local var_0_2 = "UI_Activity_OsirisHorus_CutScenesPopUI_cx"
local var_0_3 = 0.033

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_CutScenesPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.OnExitInput(arg_4_0)
	return true
end

function var_0_0.BackAndFinish(arg_5_0, arg_5_1)
	arg_5_0:Back()

	if arg_5_1 == nil then
		return
	end

	if arg_5_0.isExited_ == true then
		arg_5_1()

		return
	end

	GlobalCall.register("AfterGo", function()
		JumpTools.RefreshGaussianBg()
		arg_5_1()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.isExited_ = false
	arg_7_0.mode_ = arg_7_0.params_ and arg_7_0.params_.mode or "enter"
	arg_7_0.finishCb_ = arg_7_0.params_ and arg_7_0.params_.finishCb or nil

	if arg_7_0.mode_ == "exit" then
		arg_7_0:PlayExitAnimation()
	else
		arg_7_0:PlayEnterAnimation()
	end
end

function var_0_0.PlayEnterAnimation(arg_8_0)
	if arg_8_0.isExited_ then
		return
	end

	arg_8_0:StopAnimTimer()

	arg_8_0.enterAnimStarted_ = nil

	arg_8_0.animator_:Play(var_0_1, 0, 0)
	arg_8_0.animator_:Update(0)

	arg_8_0.animTimer_ = Timer.New(function()
		arg_8_0:CheckEnterAnimationFinished()
	end, var_0_3, -1)

	arg_8_0.animTimer_:Start()
end

function var_0_0.CheckEnterAnimationFinished(arg_10_0)
	if arg_10_0.isExited_ then
		arg_10_0:StopAnimTimer()

		return
	end

	local var_10_0 = arg_10_0.animator_:GetCurrentAnimatorStateInfo(0)

	if var_10_0 == nil or var_10_0:IsName(var_0_1) ~= true then
		return
	end

	arg_10_0.enterAnimStarted_ = true

	if var_10_0.normalizedTime < 1 then
		return
	end

	arg_10_0:StopAnimTimer()

	arg_10_0.enterAnimStarted_ = nil

	local var_10_1 = arg_10_0.finishCb_

	arg_10_0.finishCb_ = nil

	arg_10_0:BackAndFinish(var_10_1)
end

function var_0_0.PlayExitAnimation(arg_11_0)
	if arg_11_0.isExited_ then
		return
	end

	arg_11_0:StopAnimTimer()

	arg_11_0.exitAnimStarted_ = nil

	arg_11_0.animator_:Play(var_0_2, 0, 0)
	arg_11_0.animator_:Update(0)

	arg_11_0.animTimer_ = Timer.New(function()
		arg_11_0:CheckExitAnimationFinished()
	end, var_0_3, -1)

	arg_11_0.animTimer_:Start()
end

function var_0_0.CheckExitAnimationFinished(arg_13_0)
	if arg_13_0.isExited_ then
		arg_13_0:StopAnimTimer()

		return
	end

	local var_13_0 = arg_13_0.animator_:GetCurrentAnimatorStateInfo(0)

	if var_13_0 == nil or var_13_0:IsName(var_0_2) ~= true then
		return
	end

	arg_13_0.exitAnimStarted_ = true

	if var_13_0.normalizedTime < 1 then
		return
	end

	arg_13_0:StopAnimTimer()

	arg_13_0.exitAnimStarted_ = nil

	local var_13_1 = arg_13_0.finishCb_

	arg_13_0.finishCb_ = nil

	arg_13_0:BackAndFinish(var_13_1)
end

function var_0_0.StopAnimTimer(arg_14_0)
	if arg_14_0.animTimer_ ~= nil then
		arg_14_0.animTimer_:Stop()

		arg_14_0.animTimer_ = nil
	end
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.isExited_ = true
	arg_15_0.mode_ = nil
	arg_15_0.finishCb_ = nil
	arg_15_0.enterAnimStarted_ = nil
	arg_15_0.exitAnimStarted_ = nil

	arg_15_0:StopAnimTimer()
	AnimatorTools.Stop()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:StopAnimTimer()
	AnimatorTools.Stop()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
