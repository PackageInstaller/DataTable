local var_0_0 = class("SpAnimStoryPlayer", import(".StoryPlayer"))

function var_0_0.OnReset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	setActive(arg_1_0.spAnimPanel, true)

	local var_1_0 = pg.NewStoryMgr.GetInstance().skipBtn
	local var_1_1 = pg.NewStoryMgr.GetInstance().autoBtn
	local var_1_2 = pg.NewStoryMgr.GetInstance().recordBtn

	arg_1_0.hideBtns = {}

	if isActive(var_1_0) and arg_1_1:ShouldHideSkipBtn() then
		setActive(var_1_0, false)
		table.insert(arg_1_0.hideBtns, var_1_0)
	end

	if isActive(var_1_1) then
		setActive(var_1_1, false)
		table.insert(arg_1_0.hideBtns, var_1_1)
	end

	if isActive(var_1_2) then
		setActive(var_1_2, false)
		table.insert(arg_1_0.hideBtns, var_1_2)
	end

	arg_1_3()

	return
end

function var_0_0.OnEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	seriesAsync({
		function(arg_3_0)
			arg_2_0:GetSpine(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_2_0:PlaySpAnim(arg_2_1, arg_4_0)

			return
		end
	}, arg_2_3)

	return
end

function var_0_0.GetSpine(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetSpineName()

	arg_5_0.spineChar = SpineAnimChar.New()

	arg_5_0.spineChar:SetPaint(var_5_0)
	arg_5_0.spineChar:Load(true, function(arg_6_0)
		arg_6_0:SetParent(arg_5_0.spAnimPanel)
		arg_6_0:SetLocalPosition(Vector3(0, 0, 0))
		arg_5_2()

		return
	end)

	arg_5_0.prefab = var_5_0

	return
end

function var_0_0.PlaySpAnim(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.spineChar:SetActionCallBack(nil)

	if arg_7_1:HasStopTime() then
		arg_7_0:DelayCall(arg_7_1:GetStopTime(), arg_7_2)
	else
		arg_7_0.spineChar:SetActionCallBack(function(arg_8_0)
			if arg_8_0 == "finish" then
				arg_7_0.spineChar:SetActionCallBack(nil)
				arg_7_2()
			end

			return
		end)
	end

	arg_7_0.spineChar:SetAction(arg_7_1:GetActionName(), 0)

	if arg_7_1:ShouldAdjustSpeed() then
		arg_7_0:AdjustSpeed(arg_7_1:GetSpeed())
	end

	return
end

function var_0_0.AdjustSpeed(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetAnimationState()

	var_9_0.TimeScale = var_9_0.TimeScale * arg_9_1

	return
end

function var_0_0.GetAnimationState(arg_10_0)
	return arg_10_0.spineChar:GetSkeletonGraphic().AnimationState
end

function var_0_0.ReturnSpine(arg_11_0)
	if arg_11_0.spineChar == nil or arg_11_0.prefab == nil then
		return
	end

	arg_11_0:GetAnimationState().TimeScale = 1

	arg_11_0.spineChar:Dispose()

	arg_11_0.spineChar = nil
	arg_11_0.prefab = nil

	return
end

function var_0_0.ClearSp(arg_12_0)
	arg_12_0:ReturnSpine()

	local var_12_0 = arg_12_0.hideBtns or {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		setActive(iter_12_1, true)
	end

	arg_12_0.hideBtns = {}

	return
end

function var_0_0.OnWillExit(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:ClearSp()
	arg_13_3()

	return
end

function var_0_0.OnEnd(arg_14_0)
	arg_14_0:ClearSp()

	return
end

function var_0_0.RegisetEvent(arg_15_0, arg_15_1, arg_15_2)
	var_0_0.super.RegisetEvent(arg_15_0, arg_15_1, arg_15_2)
	triggerButton(arg_15_0._go)

	return
end

return var_0_0
