local var_0_0 = class("TZeroGameChangeView", BaseView)
local var_0_1 = class("TZeroGameChangeReduxView", ReduxView)
local var_0_2 = {}
local var_0_3 = "102003_GameInterludeUI"

function var_0_2.OnAnimationUpdate(arg_1_0)
	local var_1_0 = arg_1_0.animator:GetCurrentAnimatorStateInfo(0)

	if var_1_0:IsName(var_0_3) then
		if var_1_0.normalizedTime >= 1 then
			var_0_2.OnFinish(arg_1_0)
			var_0_2.StopAnimationUpdate(arg_1_0)
		elseif var_1_0.normalizedTime >= 0.2962962962962963 then
			var_0_2.OnScreenFullyBlocked(arg_1_0)
		end
	end
end

function var_0_2.StopAnimationUpdate(arg_2_0)
	if arg_2_0.time then
		arg_2_0.time:Stop()

		arg_2_0.time = nil
	end
end

function var_0_2.StartAnimationUpdate(arg_3_0)
	var_0_2.StopAnimationUpdate(arg_3_0)

	arg_3_0.time = FrameTimer.New(function()
		var_0_2.OnAnimationUpdate(arg_3_0)
	end, 1, -1)

	arg_3_0.time:Start()
end

function var_0_2.OnScreenFullyBlocked(arg_5_0)
	if arg_5_0.onScreenFullyBlockedCallback then
		local var_5_0 = arg_5_0.onScreenFullyBlockedCallback

		arg_5_0.onScreenFullyBlockedCallback = nil

		var_5_0()
	end
end

function var_0_2.OnFinish(arg_6_0)
	local var_6_0 = arg_6_0.onFinishCallback or JumpTools.Back

	arg_6_0.onFinishCallback = nil

	var_6_0()
end

function var_0_2.IsSchedulingUpdate(arg_7_0)
	return arg_7_0.time ~= nil
end

function var_0_1.UIName(arg_8_0)
	return "Widget/System/Main_T0SceneGame/102003/102003_GameInterludeUI"
end

function var_0_1.UIParent(arg_9_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_10_0)
	var_0_0.Init(arg_10_0)
end

function var_0_1.OnEnter(arg_11_0)
	arg_11_0.onScreenFullyBlockedCallback = arg_11_0.params_.onScreenFullyBlocked
	arg_11_0.onFinishCallback = arg_11_0.params_.onFinish

	var_0_0.OnEnter(arg_11_0)
end

function var_0_1.OnTop(arg_12_0)
	return
end

function var_0_1.OnExit(arg_13_0)
	var_0_0.OnExit(arg_13_0)
end

function var_0_1.Dispose(arg_14_0)
	var_0_1.super.Dispose(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.Ctor(arg_15_0, arg_15_1)
	var_0_0.super.Ctor(arg_15_0, arg_15_1)

	arg_15_0.gameObject_ = arg_15_1
	arg_15_0.transform_ = arg_15_0.gameObject_.transform

	arg_15_0:Init()
end

function var_0_0.Init(arg_16_0)
	arg_16_0:BindCfgUI()

	arg_16_0.animator = arg_16_0.gameinterludeuiAni_
	arg_16_0.colorControlller = arg_16_0.gameinterludeuiControllerexcollection_:GetController("type")
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.gameObject_:SetActive(true)
	arg_17_0.animator:Play("clipName", 0, 0)
	var_0_2.StartAnimationUpdate(arg_17_0)
end

function var_0_0.StartCutscene(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.onScreenFullyBlockedCallback = arg_18_1

	function arg_18_0.onFinishCallback()
		if arg_18_2 then
			arg_18_2()
		end

		var_0_2.StopAnimationUpdate(arg_18_0)

		if not arg_18_3 then
			arg_18_0.gameObject_:SetActive(false)
		end
	end

	arg_18_0.gameObject_:SetActive(true)
	arg_18_0.animator:Play("clipName", 0, 0)
	var_0_2.StartAnimationUpdate(arg_18_0)
end

function var_0_0.OnExit(arg_20_0)
	var_0_2.StopAnimationUpdate(arg_20_0)
	arg_20_0.gameObject_:SetActive(false)
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
	arg_21_0:RemoveAllEventListener()
end

function var_0_0.GetPlayBackwardsAnimator(arg_22_0, arg_22_1, arg_22_2)
	if gameContext:IsOpenRoute("login") then
		return {}, arg_22_1
	end

	return {
		{
			arg_22_0.animator,
			var_0_3,
			false
		}
	}, function()
		manager.windowBar:HideBar()

		if arg_22_2 then
			arg_22_2()
		end

		arg_22_0:StartCutscene(arg_22_1, function()
			var_0_2.StopAnimationUpdate(arg_22_0)
		end, true)
	end
end

function var_0_0.IsDuringCutscene(arg_25_0)
	return var_0_2.IsSchedulingUpdate(arg_25_0)
end

var_0_1.BaseView = var_0_0

return var_0_1
