class = var_0_10000

local var_0_0 = var_0_10000("StoryAnimtion")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.tweens = {}
	arg_1_0.timers = {}
	arg_1_0.timeScale = 1

	return
end

function var_0_0.SetTimeScale(arg_2_0, arg_2_1)
	arg_2_0.timeScale = arg_2_1

	return
end

function var_0_0.moveLocal(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local function var_3_0()
		LeanTween = var_2_10000

		local var_4_0 = var_2_10000.moveLocal(arg_3_1.gameObject, arg_3_3, arg_3_4 * arg_3_0.timeScale)

		var_0.setFrom(var_4_0, arg_3_2)

		if arg_3_7 then
			local var_4_1 = var_0
			local var_4_2 = var_0.setOnComplete

			System = var_3

			var_4_2(var_4_1, var_3.Action(arg_3_7))
		end

		if arg_3_6 then
			var_0:setEase(arg_3_6)
		end

		table = var_1

		var_1.insert(arg_3_0.tweens, arg_3_1)

		return
	end

	arg_3_0:DelayCall(arg_3_5, var_3_0)

	return
end

function var_0_0.moveLocalPath(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0, var_5_1

	if #arg_5_2 <= 3 then
		var_5_0 = arg_5_2[1]
		var_5_1 = arg_5_2[#arg_5_2]

		arg_5_0:moveLocal(arg_5_1, var_5_0, var_5_1, arg_5_3, arg_5_4, arg_5_5, arg_5_6)

		return
	end

	System = var_5_0

	local var_5_2 = var_5_0.Array.CreateInstance

	typeof = var_5_1
	UnityEngine = var_1_10009

	local var_5_3 = var_5_2(var_5_1(var_1_10009.Vector3), #arg_5_2)

	ipairs = var_8

	for iter_5_0, iter_5_1 in var_8(arg_5_2) do
		var_5_3[iter_5_0 - 1] = iter_5_1
	end

	local function var_5_4()
		LeanTween = var_2_10000

		local var_6_0 = var_2_10000.moveLocal(arg_5_1.gameObject, var_5_3, arg_5_3 * arg_5_0.timeScale)

		if arg_5_6 then
			local var_6_1 = var_6_0
			local var_6_2 = var_6_0.setOnComplete

			System = var_3

			var_6_2(var_6_1, var_3.Action(arg_5_6))
		end

		if arg_5_5 then
			var_6_0:setEase(arg_5_5)
		end

		table = var_1

		var_1.insert(arg_5_0.tweens, arg_5_1)

		return
	end

	arg_5_0:DelayCall(arg_5_4, var_5_4)

	return
end

function var_0_0.TweenMove(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	local function var_7_0()
		LeanTween = var_2_10000

		local var_8_0 = var_2_10000.move

		rtf = var_2_10001

		local var_8_1 = var_8_0(var_2_10001(arg_7_1), arg_7_2, arg_7_3 * arg_7_0.timeScale)

		if arg_7_4 > 1 then
			var_8_1:setLoopPingPong(arg_7_4)
		end

		local var_8_3

		if arg_7_6 then
			local var_8_2 = var_8_1

			var_8_3 = var_8_1.setOnComplete
			System = var_3

			var_8_3(var_8_2, var_3.Action(arg_7_6))
		end

		table = var_8_3

		var_8_3.insert(arg_7_0.tweens, arg_7_1)

		return
	end

	arg_7_0:DelayCall(arg_7_5, var_7_0)

	return
end

function var_0_0.TweenScale(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	local function var_9_0()
		LeanTween = var_2_10000

		local var_10_0 = var_2_10000.scale

		rtf = var_2_10001

		local var_10_1 = var_10_0(var_2_10001(arg_9_1), arg_9_2, arg_9_3 * arg_9_0.timeScale)
		local var_10_3

		if arg_9_5 then
			local var_10_2 = var_10_1

			var_10_3 = var_10_1.setOnComplete
			System = var_3

			var_10_3(var_10_2, var_3.Action(arg_9_5))
		end

		table = var_10_3

		var_10_3.insert(arg_9_0.tweens, arg_9_1)

		return
	end

	arg_9_0:DelayCall(arg_9_4, var_9_0)

	return
end

function var_0_0.TweenRotate(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local function var_11_0()
		LeanTween = var_2_10000

		local var_12_0 = var_2_10000.rotate

		rtf = var_2_10001

		local var_12_1 = var_12_0(var_2_10001(arg_11_1), arg_11_2, arg_11_3 * arg_11_0.timeScale)
		local var_12_2 = var_0.setLoopPingPong(var_12_1, arg_11_4)
		local var_12_4

		if arg_11_6 then
			local var_12_3 = var_12_2

			var_12_4 = var_12_2.setOnComplete
			System = var_3

			var_12_4(var_12_3, var_3.Action(arg_11_6))
		end

		table = var_12_4

		var_12_4.insert(arg_11_0.tweens, arg_11_1)

		return
	end

	arg_11_0:DelayCall(arg_11_5, var_11_0)

	return
end

function var_0_0.TweenValueForcanvasGroup(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local function var_13_0()
		LeanTween = var_2_10000

		local var_14_0 = var_2_10000.value

		go = var_2_10001

		local var_14_1 = var_14_0(var_2_10001(arg_13_1), arg_13_2, arg_13_3, arg_13_4 * arg_13_0.timeScale)
		local var_14_2 = var_0.setOnUpdate

		System = var_2

		local var_14_3 = var_14_2(var_14_1, var_2.Action_float(function(arg_15_0)
			arg_13_1.alpha = arg_15_0

			return
		end))
		local var_14_5

		if arg_13_6 then
			local var_14_4 = var_14_3

			var_14_5 = var_14_3.setOnComplete
			System = var_3

			var_14_5(var_14_4, var_3.Action(arg_13_6))
		end

		table = var_14_5

		var_14_5.insert(arg_13_0.tweens, arg_13_1.gameObject.transform)

		return
	end

	arg_13_0:DelayCall(arg_13_5, var_13_0)

	return
end

function var_0_0.TweenValue(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	local function var_16_0()
		LeanTween = var_2_10000

		local var_17_0 = var_2_10000.value

		go = var_2_10001

		local var_17_1 = var_17_0(var_2_10001(arg_16_1), arg_16_2, arg_16_3, arg_16_4 * arg_16_0.timeScale)
		local var_17_2 = var_0.setOnUpdate

		System = var_2

		local var_17_3 = var_17_2(var_17_1, var_2.Action_float(arg_16_6))
		local var_17_5

		if arg_16_7 then
			local var_17_4 = var_17_3

			var_17_5 = var_17_3.setOnComplete
			System = var_3

			var_17_5(var_17_4, var_3.Action(function()
				if arg_16_7 then
					arg_16_7()
				end

				return
			end))
		end

		table = var_17_5

		var_17_5.insert(arg_16_0.tweens, arg_16_1)

		return
	end

	arg_16_0:DelayCall(arg_16_5, var_16_0)

	return
end

function var_0_0.TweenValueWithEase(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
	local function var_19_0()
		LeanTween = var_2_10000

		local var_20_0 = var_2_10000.value

		go = var_2_10001

		local var_20_1 = var_20_0(var_2_10001(arg_19_1), arg_19_2, arg_19_3, arg_19_4 * arg_19_0.timeScale)
		local var_20_2 = var_0.setOnUpdate

		System = var_2

		local var_20_3 = var_20_2(var_20_1, var_2.Action_float(arg_19_7))
		local var_20_4 = var_0.setEase(var_20_3, arg_19_6)
		local var_20_6

		if arg_19_8 then
			local var_20_5 = var_20_4

			var_20_6 = var_20_4.setOnComplete
			System = var_3

			var_20_6(var_20_5, var_3.Action(function()
				if arg_19_8 then
					arg_19_8()
				end

				return
			end))
		end

		table = var_20_6

		var_20_6.insert(arg_19_0.tweens, arg_19_1)

		return
	end

	arg_19_0:DelayCall(arg_19_5, var_19_0)

	return
end

function var_0_0.TweenValueLoop(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	local function var_22_0()
		LeanTween = var_2_10000

		local var_23_0 = var_2_10000.value

		go = var_2_10001

		local var_23_1 = var_23_0(var_2_10001(arg_22_1), arg_22_2, arg_22_3, arg_22_4 * arg_22_0.timeScale)
		local var_23_2 = var_0.setOnUpdate

		System = var_2

		local var_23_3 = var_23_2(var_23_1, var_2.Action_float(arg_22_6))
		local var_23_4 = var_0.setLoopClamp(var_23_3)
		local var_23_6

		if arg_22_7 then
			local var_23_5 = var_23_4

			var_23_6 = var_23_4.setOnComplete
			System = var_3

			var_23_6(var_23_5, var_3.Action(function()
				if arg_22_7 then
					arg_22_7()
				end

				return
			end))
		end

		table = var_23_6

		var_23_6.insert(arg_22_0.tweens, arg_22_1)

		return
	end

	arg_22_0:DelayCall(arg_22_5, var_22_0)

	return
end

function var_0_0.TweenTextAlpha(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local function var_25_0()
		LeanTween = var_2_10000

		local var_26_0 = var_2_10000.textAlpha
		local var_26_1 = arg_25_1
		local var_26_2 = arg_25_2
		local var_26_3

		if not arg_25_3 then
			var_26_3 = 1
		end

		local var_26_4 = var_26_0(var_26_1, var_26_2, var_26_3 * arg_25_0.timeScale)
		local var_26_6

		if arg_25_5 then
			local var_26_5 = var_26_4

			var_26_6 = var_26_4.setOnComplete
			System = var_3

			var_26_6(var_26_5, var_3.Action(arg_25_5))
		end

		table = var_26_6

		var_26_6.insert(arg_25_0.tweens, arg_25_1)

		return
	end

	arg_25_0:DelayCall(arg_25_4, var_25_0)

	return
end

function var_0_0.TweenAlpha(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	local function var_27_0()
		LeanTween = var_2_10000

		local var_28_0 = var_2_10000.alpha(arg_27_1, arg_27_3, arg_27_4 * arg_27_0.timeScale)
		local var_28_1 = var_0.setFrom(var_28_0, arg_27_2)
		local var_28_3

		if arg_27_6 then
			local var_28_2 = var_28_1

			var_28_3 = var_28_1.setOnComplete
			System = var_3

			var_28_3(var_28_2, var_3.Action(arg_27_6))
		end

		table = var_28_3

		var_28_3.insert(arg_27_0.tweens, arg_27_1)

		return
	end

	arg_27_0:DelayCall(arg_27_5, var_27_0)

	return
end

function var_0_0.TweenMovex(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	local function var_29_0()
		LeanTween = var_2_10000

		local var_30_0 = var_2_10000.moveX(arg_29_1, arg_29_2, arg_29_4 * arg_29_0.timeScale)
		local var_30_1 = var_0.setFrom(var_30_0, arg_29_3)

		if arg_29_6 then
			var_30_1:setLoopPingPong(arg_29_6)
		end

		local var_30_3

		if arg_29_7 then
			local var_30_2 = var_30_1

			var_30_3 = var_30_1.setOnComplete
			System = var_3

			var_30_3(var_30_2, var_3.Action(arg_29_7))
		end

		table = var_30_3

		var_30_3.insert(arg_29_0.tweens, arg_29_1)

		return
	end

	arg_29_0:DelayCall(arg_29_5, var_29_0)

	return
end

function var_0_0.TweenMovey(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6, arg_31_7)
	local function var_31_0()
		LeanTween = var_2_10000

		local var_32_0 = var_2_10000.moveY(arg_31_1, arg_31_2, arg_31_4 * arg_31_0.timeScale)
		local var_32_1 = var_0.setFrom(var_32_0, arg_31_3)

		if arg_31_6 then
			var_32_1:setLoopPingPong(arg_31_6)
		end

		local var_32_3

		if arg_31_7 then
			local var_32_2 = var_32_1

			var_32_3 = var_32_1.setOnComplete
			System = var_3

			var_32_3(var_32_2, var_3.Action(arg_31_7))
		end

		table = var_32_3

		var_32_3.insert(arg_31_0.tweens, arg_31_1)

		return
	end

	arg_31_0:DelayCall(arg_31_5, var_31_0)

	return
end

function var_0_0.IsTweening(arg_33_0, arg_33_1)
	LeanTween = var_1_10002

	return var_1_10002.isTweening(arg_33_1)
end

function var_0_0.CancelTween(arg_34_0, arg_34_1)
	if arg_34_0:IsTweening(arg_34_1) then
		LeanTween = var_2

		var_2.cancel(arg_34_1)
	end

	return
end

function var_0_0.DelayCall(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_1 or arg_35_1 <= 0 then
		arg_35_2()

		return
	end

	local var_35_0 = arg_35_0.timers

	StoryTimer = var_1_10004
	var_35_0[arg_35_2] = var_1_10004.New(function()
		local var_36_0 = arg_35_0.timers[arg_35_2]

		var_0.Stop(var_36_0)

		arg_35_0.timers[arg_35_2] = nil

		arg_35_2()

		return
	end, arg_35_1 * arg_35_0.timeScale, 1)

	local var_35_1 = arg_35_0.timers[arg_35_2]

	var_3.Start(var_35_1)

	return
end

function var_0_0.UnscaleDelayCall(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 <= 0 then
		arg_37_2()

		return
	end

	local var_37_0 = arg_37_0.timers

	StoryTimer = var_1_10004
	var_37_0[arg_37_2] = var_1_10004.New(function()
		local var_38_0 = arg_37_0.timers[arg_37_2]

		var_0.Stop(var_38_0)

		arg_37_0.timers[arg_37_2] = nil

		arg_37_2()

		return
	end, arg_37_1, 1)

	local var_37_1 = arg_37_0.timers[arg_37_2]

	var_3.Start(var_37_1)

	return
end

function var_0_0.CreateDelayTimer(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 == 0 then
		arg_39_2()

		return nil
	end

	StoryTimer = var_1_10003

	local var_39_0 = var_1_10003.New(arg_39_2, arg_39_1 * arg_39_0.timeScale, 1)

	var_3.Start(var_39_0)

	return var_3
end

function var_0_0.PauseAllTween(arg_40_0)
	ipairs = var_1_10001

	for iter_40_0, iter_40_1 in var_1_10001(arg_40_0.tweens) do
		IsNil = var_1_10006

		if not var_1_10006(iter_40_1) and arg_40_0:IsTweening(iter_40_1.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.pause(iter_40_1.gameObject)
		end
	end

	return
end

function var_0_0.ResumeAllTween(arg_41_0)
	ipairs = var_1_10001

	for iter_41_0, iter_41_1 in var_1_10001(arg_41_0.tweens) do
		IsNil = var_1_10006

		if not var_1_10006(iter_41_1) then
			LeanTween = var_1_10006

			var_1_10006.resume(iter_41_1.gameObject)
		end
	end

	return
end

function var_0_0.PauseAllTimer(arg_42_0)
	pairs = var_1_10001

	for iter_42_0, iter_42_1 in var_1_10001(arg_42_0.timers) do
		iter_42_1:Pause()
	end

	return
end

function var_0_0.ResumeAllTimer(arg_43_0)
	pairs = var_1_10001

	for iter_43_0, iter_43_1 in var_1_10001(arg_43_0.timers) do
		iter_43_1:Resume()
	end

	return
end

function var_0_0.ResumeAllAnimation(arg_44_0)
	arg_44_0:ResumeAllTween()
	arg_44_0:ResumeAllTimer()

	return
end

function var_0_0.PauseAllAnimation(arg_45_0)
	arg_45_0:PauseAllTween()
	arg_45_0:PauseAllTimer()

	return
end

function var_0_0.ClearAllTween(arg_46_0)
	ipairs = var_1_10001

	for iter_46_0, iter_46_1 in var_1_10001(arg_46_0.tweens) do
		IsNil = var_1_10006

		if not var_1_10006(iter_46_1) and arg_46_0:IsTweening(iter_46_1.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_46_1.gameObject)
		end
	end

	arg_46_0.tweens = {}

	return
end

function var_0_0.ClearAllTimers(arg_47_0)
	pairs = var_1_10001

	for iter_47_0, iter_47_1 in var_1_10001(arg_47_0.timers) do
		iter_47_1:Stop()
	end

	arg_47_0.timers = {}

	return
end

function var_0_0.ClearTimer(arg_48_0, arg_48_1)
	if arg_48_1 and arg_48_0.timers[arg_48_1] then
		local var_48_0 = arg_48_0.timers[arg_48_1]

		var_2.Stop(var_48_0)

		arg_48_0.timers[arg_48_1] = nil
	end

	return
end

function var_0_0.ClearAnimation(arg_49_0)
	arg_49_0:ClearAllTween()
	arg_49_0:ClearAllTimers()

	return
end

return var_0_0
