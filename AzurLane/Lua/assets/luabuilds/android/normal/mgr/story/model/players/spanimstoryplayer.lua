class = var_0_10000

local var_0_0 = "SpAnimStoryPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryPlayer"))

function var_0_1.OnReset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	setActive = var_1_10004

	var_1_10004(arg_1_0.spAnimPanel, true)

	pg = var_1_10004

	local var_1_0 = var_1_10004.NewStoryMgr.GetInstance().skipBtn

	pg = var_5

	local var_1_1 = var_5.NewStoryMgr.GetInstance().autoBtn

	pg = var_6

	local var_1_2 = var_6.NewStoryMgr.GetInstance().recordBtn

	arg_1_0.hideBtns = {}
	isActive = var_7

	if var_7(var_1_0) and arg_1_1:ShouldHideSkipBtn() then
		setActive = var_7

		var_7(var_1_0, false)

		table = var_7

		var_7.insert(arg_1_0.hideBtns, var_1_0)
	end

	isActive = var_7

	if var_7(var_1_1) then
		setActive = var_7

		var_7(var_1_1, false)

		table = var_7

		var_7.insert(arg_1_0.hideBtns, var_1_1)
	end

	isActive = var_7

	if var_7(var_1_2) then
		setActive = var_7

		var_7(var_1_2, false)

		table = var_7

		var_7.insert(arg_1_0.hideBtns, var_1_2)
	end

	arg_1_3()

	return
end

function var_0_1.OnEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.GetSpine(var_3_0, arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.PlaySpAnim(var_4_0, arg_2_1, arg_4_0)

			return
		end
	}, arg_2_3)

	return
end

function var_0_1.GetSpine(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.GetSpineName(var_5_0)

	SpineAnimChar = var_5_0
	arg_5_0.spineChar = var_5_0.New()

	local var_5_2 = arg_5_0.spineChar

	var_4.SetPaint(var_5_2, var_5_1)

	local var_5_3 = arg_5_0.spineChar

	var_4.Load(var_5_3, true, function(arg_6_0)
		arg_6_0:SetParent(arg_5_0.spAnimPanel)

		local var_6_0 = arg_6_0
		local var_6_1 = arg_6_0.SetLocalPosition

		Vector3 = var_3

		var_6_1(var_6_0, var_3(0, 0, 0))
		arg_5_2()

		return
	end)

	arg_5_0.prefab = var_5_1

	return
end

function var_0_1.PlaySpAnim(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.spineChar

	var_3.SetActionCallBack(var_7_0, nil)

	if arg_7_1:HasStopTime() then
		arg_7_0:DelayCall(arg_7_1:GetStopTime(), arg_7_2)
	else
		local var_7_1 = arg_7_0.spineChar

		var_3.SetActionCallBack(var_7_1, function(arg_8_0)
			if arg_8_0 == "finish" then
				local var_8_0 = arg_7_0.spineChar

				var_1.SetActionCallBack(var_8_0, nil)
				arg_7_2()
			end

			return
		end)
	end

	local var_7_2 = arg_7_1:GetActionName()
	local var_7_3 = arg_7_0.spineChar

	var_4.SetAction(var_7_3, var_7_2, 0)

	if arg_7_1:ShouldAdjustSpeed() then
		arg_7_0:AdjustSpeed(arg_7_1:GetSpeed())
	end

	return
end

function var_0_1.AdjustSpeed(arg_9_0, arg_9_1)
	var_2.TimeScale = arg_9_0:GetAnimationState().TimeScale * arg_9_1

	return
end

function var_0_1.GetAnimationState(arg_10_0)
	local var_10_0 = arg_10_0.spineChar

	return var_1.GetSkeletonGraphic(var_10_0).AnimationState
end

function var_0_1.ReturnSpine(arg_11_0)
	if arg_11_0.spineChar == nil or arg_11_0.prefab == nil then
		return
	end

	arg_11_0:GetAnimationState().TimeScale = 1

	local var_11_0 = arg_11_0.spineChar

	var_2.Dispose(var_11_0)

	arg_11_0.spineChar = nil
	arg_11_0.prefab = nil

	return
end

function var_0_1.ClearSp(arg_12_0)
	arg_12_0:ReturnSpine()

	pairs = var_1

	local var_12_0

	if not arg_12_0.hideBtns then
		var_12_0 = {}
	end

	for iter_12_0, iter_12_1 in var_1(var_12_0) do
		setActive = var_1_10006

		var_1_10006(iter_12_1, true)
	end

	arg_12_0.hideBtns = {}

	return
end

function var_0_1.OnWillExit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:ClearSp()
	arg_13_3()

	return
end

function var_0_1.OnEnd(arg_14_0)
	arg_14_0:ClearSp()

	return
end

function var_0_1.RegisetEvent(arg_15_0, arg_15_1, arg_15_2)
	var_0_1.super.RegisetEvent(arg_15_0, arg_15_1, arg_15_2)

	triggerButton = var_3

	var_3(arg_15_0._go)

	return
end

return var_0_1
