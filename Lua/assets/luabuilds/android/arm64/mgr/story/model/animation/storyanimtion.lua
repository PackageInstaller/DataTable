local var_0_0 = class("StoryAnimtion")

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
	arg_3_0:DelayCall(arg_3_5, function()
		local var_4_0 = LeanTween.moveLocal(arg_3_1.gameObject, arg_3_3, arg_3_4 * arg_3_0.timeScale)

		var_4_0:setFrom(arg_3_2)

		if arg_3_7 then
			var_4_0:setOnComplete(System.Action(arg_3_7))
		end

		if arg_3_6 then
			var_4_0:setEase(arg_3_6)
		end

		table.insert(arg_3_0.tweens, arg_3_1)

		return
	end)

	return
end

function var_0_0.moveLocalPath(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if #arg_5_2 <= 3 then
		arg_5_0:moveLocal(arg_5_1, arg_5_2[1], arg_5_2[#arg_5_2], arg_5_3, arg_5_4, arg_5_5, arg_5_6)

		return
	end

	local var_5_0 = System.Array.CreateInstance(typeof(UnityEngine.Vector3), #arg_5_2)

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		var_5_0[iter_5_0 - 1] = iter_5_1
	end

	arg_5_0:DelayCall(arg_5_4, function()
		local var_6_0 = LeanTween.moveLocal(arg_5_1.gameObject, var_5_0, arg_5_3 * arg_5_0.timeScale)

		if arg_5_6 then
			var_6_0:setOnComplete(System.Action(arg_5_6))
		end

		if arg_5_5 then
			var_6_0:setEase(arg_5_5)
		end

		table.insert(arg_5_0.tweens, arg_5_1)

		return
	end)

	return
end

function var_0_0.TweenMove(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	arg_7_0:DelayCall(arg_7_5, function()
		local var_8_0 = LeanTween.move(rtf(arg_7_1), arg_7_2, arg_7_3 * arg_7_0.timeScale)

		if arg_7_4 > 1 then
			var_8_0:setLoopPingPong(arg_7_4)
		end

		if arg_7_6 then
			var_8_0:setOnComplete(System.Action(arg_7_6))
		end

		table.insert(arg_7_0.tweens, arg_7_1)

		return
	end)

	return
end

function var_0_0.TweenScale(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0:DelayCall(arg_9_4, function()
		if arg_9_5 then
			LeanTween.scale(rtf(arg_9_1), arg_9_2, arg_9_3 * arg_9_0.timeScale):setOnComplete(System.Action(arg_9_5))
		end

		table.insert(arg_9_0.tweens, arg_9_1)

		return
	end)

	return
end

function var_0_0.TweenRotate(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	arg_11_0:DelayCall(arg_11_5, function()
		if arg_11_6 then
			LeanTween.rotate(rtf(arg_11_1), arg_11_2, arg_11_3 * arg_11_0.timeScale):setLoopPingPong(arg_11_4):setOnComplete(System.Action(arg_11_6))
		end

		table.insert(arg_11_0.tweens, arg_11_1)

		return
	end)

	return
end

function var_0_0.TweenValueForcanvasGroup(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	arg_13_0:DelayCall(arg_13_5, function()
		if arg_13_6 then
			LeanTween.value(go(arg_13_1), arg_13_2, arg_13_3, arg_13_4 * arg_13_0.timeScale):setOnUpdate(System.Action_float(function(arg_15_0)
				arg_13_1.alpha = arg_15_0

				return
			end)):setOnComplete(System.Action(arg_13_6))
		end

		table.insert(arg_13_0.tweens, arg_13_1.gameObject.transform)

		return
	end)

	return
end

function var_0_0.TweenValue(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	arg_16_0:DelayCall(arg_16_5, function()
		if arg_16_7 then
			LeanTween.value(go(arg_16_1), arg_16_2, arg_16_3, arg_16_4 * arg_16_0.timeScale):setOnUpdate(System.Action_float(arg_16_6)):setOnComplete(System.Action(function()
				if arg_16_7 then
					arg_16_7()
				end

				return
			end))
		end

		table.insert(arg_16_0.tweens, arg_16_1)

		return
	end)

	return
end

function var_0_0.TweenValueWithEase(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
	arg_19_0:DelayCall(arg_19_5, function()
		if arg_19_8 then
			LeanTween.value(go(arg_19_1), arg_19_2, arg_19_3, arg_19_4 * arg_19_0.timeScale):setOnUpdate(System.Action_float(arg_19_7)):setEase(arg_19_6):setOnComplete(System.Action(function()
				if arg_19_8 then
					arg_19_8()
				end

				return
			end))
		end

		table.insert(arg_19_0.tweens, arg_19_1)

		return
	end)

	return
end

function var_0_0.TweenValueLoop(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	arg_22_0:DelayCall(arg_22_5, function()
		if arg_22_7 then
			LeanTween.value(go(arg_22_1), arg_22_2, arg_22_3, arg_22_4 * arg_22_0.timeScale):setOnUpdate(System.Action_float(arg_22_6)):setLoopClamp():setOnComplete(System.Action(function()
				if arg_22_7 then
					arg_22_7()
				end

				return
			end))
		end

		table.insert(arg_22_0.tweens, arg_22_1)

		return
	end)

	return
end

function var_0_0.TweenTextAlpha(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	arg_25_0:DelayCall(arg_25_4, function()
		local var_26_0 = arg_25_3 or 1
		local var_26_1 = LeanTween.textAlpha(arg_25_1, arg_25_2, var_26_0 * arg_25_0.timeScale)

		if arg_25_5 then
			var_26_1:setOnComplete(System.Action(arg_25_5))
		end

		table.insert(arg_25_0.tweens, arg_25_1)

		return
	end)

	return
end

function var_0_0.TweenAlpha(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	arg_27_0:DelayCall(arg_27_5, function()
		if arg_27_6 then
			LeanTween.alpha(arg_27_1, arg_27_3, arg_27_4 * arg_27_0.timeScale):setFrom(arg_27_2):setOnComplete(System.Action(arg_27_6))
		end

		table.insert(arg_27_0.tweens, arg_27_1)

		return
	end)

	return
end

function var_0_0.TweenMovex(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	arg_29_0:DelayCall(arg_29_5, function()
		local var_30_0 = LeanTween.moveX(arg_29_1, arg_29_2, arg_29_4 * arg_29_0.timeScale):setFrom(arg_29_3)

		if arg_29_6 then
			var_30_0:setLoopPingPong(arg_29_6)
		end

		if arg_29_7 then
			var_30_0:setOnComplete(System.Action(arg_29_7))
		end

		table.insert(arg_29_0.tweens, arg_29_1)

		return
	end)

	return
end

function var_0_0.TweenMovey(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6, arg_31_7)
	arg_31_0:DelayCall(arg_31_5, function()
		local var_32_0 = LeanTween.moveY(arg_31_1, arg_31_2, arg_31_4 * arg_31_0.timeScale):setFrom(arg_31_3)

		if arg_31_6 then
			var_32_0:setLoopPingPong(arg_31_6)
		end

		if arg_31_7 then
			var_32_0:setOnComplete(System.Action(arg_31_7))
		end

		table.insert(arg_31_0.tweens, arg_31_1)

		return
	end)

	return
end

function var_0_0.IsTweening(arg_33_0, arg_33_1)
	return LeanTween.isTweening(arg_33_1)
end

function var_0_0.CancelTween(arg_34_0, arg_34_1)
	if arg_34_0:IsTweening(arg_34_1) then
		LeanTween.cancel(arg_34_1)
	end

	return
end

function var_0_0.DelayCall(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_1 or arg_35_1 <= 0 then
		arg_35_2()

		return
	end

	arg_35_0.timers[arg_35_2] = StoryTimer.New(function()
		arg_35_0.timers[arg_35_2]:Stop()

		arg_35_0.timers[arg_35_2] = nil

		arg_35_2()

		return
	end, arg_35_1 * arg_35_0.timeScale, 1)

	arg_35_0.timers[arg_35_2]:Start()

	return
end

function var_0_0.UnscaleDelayCall(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 <= 0 then
		arg_37_2()

		return
	end

	arg_37_0.timers[arg_37_2] = StoryTimer.New(function()
		arg_37_0.timers[arg_37_2]:Stop()

		arg_37_0.timers[arg_37_2] = nil

		arg_37_2()

		return
	end, arg_37_1, 1)

	arg_37_0.timers[arg_37_2]:Start()

	return
end

function var_0_0.CreateDelayTimer(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 == 0 then
		arg_39_2()

		return nil
	end

	local var_39_0 = StoryTimer.New(arg_39_2, arg_39_1 * arg_39_0.timeScale, 1)

	var_39_0:Start()

	return var_39_0
end

function var_0_0.PauseAllTween(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.tweens) do
		if not IsNil(iter_40_1) and arg_40_0:IsTweening(iter_40_1.gameObject) then
			LeanTween.pause(iter_40_1.gameObject)
		end
	end

	return
end

function var_0_0.ResumeAllTween(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.tweens) do
		if not IsNil(iter_41_1) then
			LeanTween.resume(iter_41_1.gameObject)
		end
	end

	return
end

function var_0_0.PauseAllTimer(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.timers) do
		iter_42_1:Pause()
	end

	return
end

function var_0_0.ResumeAllTimer(arg_43_0)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.timers) do
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
	for iter_46_0, iter_46_1 in ipairs(arg_46_0.tweens) do
		if not IsNil(iter_46_1) and arg_46_0:IsTweening(iter_46_1.gameObject) then
			LeanTween.cancel(iter_46_1.gameObject)
		end
	end

	arg_46_0.tweens = {}

	return
end

function var_0_0.ClearAllTimers(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.timers) do
		iter_47_1:Stop()
	end

	arg_47_0.timers = {}

	return
end

function var_0_0.ClearTimer(arg_48_0, arg_48_1)
	if arg_48_1 and arg_48_0.timers[arg_48_1] then
		arg_48_0.timers[arg_48_1]:Stop()

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
