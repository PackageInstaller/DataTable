local StoryAnimtion = class("StoryAnimtion")

function StoryAnimtion:Ctor()
	self.tweens = {}
	self.timers = {}
	self.timeScale = 1

	return
end

function StoryAnimtion:SetTimeScale(arg_2_1)
	self.timeScale = arg_2_1

	return
end

function StoryAnimtion:moveLocal(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	self:DelayCall(arg_3_5, function()
		local var_4_0 = LeanTween.moveLocal(arg_3_1.gameObject, arg_3_3, arg_3_4 * self.timeScale)

		var_4_0:setFrom(arg_3_2)

		if arg_3_7 then
			var_4_0:setOnComplete(System.Action(arg_3_7))
		end

		if arg_3_6 then
			var_4_0:setEase(arg_3_6)
		end

		table.insert(self.tweens, arg_3_1)

		return
	end)

	return
end

function StoryAnimtion:moveLocalPath(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if #arg_5_2 <= 3 then
		self:moveLocal(arg_5_1, arg_5_2[1], arg_5_2[#arg_5_2], arg_5_3, arg_5_4, arg_5_5, arg_5_6)

		return
	end

	local var_5_0 = System.Array.CreateInstance(typeof(UnityEngine.Vector3), #arg_5_2)

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		var_5_0[iter_5_0 - 1] = iter_5_1
	end

	self:DelayCall(arg_5_4, function()
		local var_6_0 = LeanTween.moveLocal(arg_5_1.gameObject, var_5_0, arg_5_3 * self.timeScale)

		if arg_5_6 then
			var_6_0:setOnComplete(System.Action(arg_5_6))
		end

		if arg_5_5 then
			var_6_0:setEase(arg_5_5)
		end

		table.insert(self.tweens, arg_5_1)

		return
	end)

	return
end

function StoryAnimtion:TweenMove(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	self:DelayCall(arg_7_5, function()
		local var_8_0 = LeanTween.move(rtf(arg_7_1), arg_7_2, arg_7_3 * self.timeScale)

		if arg_7_4 > 1 then
			var_8_0:setLoopPingPong(arg_7_4)
		end

		if arg_7_6 then
			var_8_0:setOnComplete(System.Action(arg_7_6))
		end

		table.insert(self.tweens, arg_7_1)

		return
	end)

	return
end

function StoryAnimtion:TweenScale(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	self:DelayCall(arg_9_4, function()
		if arg_9_5 then
			LeanTween.scale(rtf(arg_9_1), arg_9_2, arg_9_3 * self.timeScale):setOnComplete(System.Action(arg_9_5))
		end

		table.insert(self.tweens, arg_9_1)

		return
	end)

	return
end

function StoryAnimtion:TweenRotate(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	self:DelayCall(arg_11_5, function()
		if arg_11_6 then
			LeanTween.rotate(rtf(arg_11_1), arg_11_2, arg_11_3 * self.timeScale):setLoopPingPong(arg_11_4):setOnComplete(System.Action(arg_11_6))
		end

		table.insert(self.tweens, arg_11_1)

		return
	end)

	return
end

function StoryAnimtion:TweenValueForcanvasGroup(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	self:DelayCall(arg_13_5, function()
		if arg_13_6 then
			LeanTween.value(go(arg_13_1), arg_13_2, arg_13_3, arg_13_4 * self.timeScale):setOnUpdate(System.Action_float(function(arg_15_0)
				arg_13_1.alpha = arg_15_0

				return
			end)):setOnComplete(System.Action(arg_13_6))
		end

		table.insert(self.tweens, arg_13_1.gameObject.transform)

		return
	end)

	return
end

function StoryAnimtion:TweenValue(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	self:DelayCall(arg_16_5, function()
		if arg_16_7 then
			LeanTween.value(go(arg_16_1), arg_16_2, arg_16_3, arg_16_4 * self.timeScale):setOnUpdate(System.Action_float(arg_16_6)):setOnComplete(System.Action(function()
				if arg_16_7 then
					arg_16_7()
				end

				return
			end))
		end

		table.insert(self.tweens, arg_16_1)

		return
	end)

	return
end

function StoryAnimtion:TweenValueWithEase(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
	self:DelayCall(arg_19_5, function()
		if arg_19_8 then
			LeanTween.value(go(arg_19_1), arg_19_2, arg_19_3, arg_19_4 * self.timeScale):setOnUpdate(System.Action_float(arg_19_7)):setEase(arg_19_6):setOnComplete(System.Action(function()
				if arg_19_8 then
					arg_19_8()
				end

				return
			end))
		end

		table.insert(self.tweens, arg_19_1)

		return
	end)

	return
end

function StoryAnimtion:TweenValueLoop(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	self:DelayCall(arg_22_5, function()
		if arg_22_7 then
			LeanTween.value(go(arg_22_1), arg_22_2, arg_22_3, arg_22_4 * self.timeScale):setOnUpdate(System.Action_float(arg_22_6)):setLoopClamp():setOnComplete(System.Action(function()
				if arg_22_7 then
					arg_22_7()
				end

				return
			end))
		end

		table.insert(self.tweens, arg_22_1)

		return
	end)

	return
end

function StoryAnimtion:TweenTextAlpha(arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	self:DelayCall(arg_25_4, function()
		if arg_25_5 then
			LeanTween.textAlpha(arg_25_1, arg_25_2, (arg_25_3 or 1) * self.timeScale):setOnComplete(System.Action(arg_25_5))
		end

		table.insert(self.tweens, arg_25_1)

		return
	end)

	return
end

function StoryAnimtion:TweenAlpha(arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	self:DelayCall(arg_27_5, function()
		if arg_27_6 then
			LeanTween.alpha(arg_27_1, arg_27_3, arg_27_4 * self.timeScale):setFrom(arg_27_2):setOnComplete(System.Action(arg_27_6))
		end

		table.insert(self.tweens, arg_27_1)

		return
	end)

	return
end

function StoryAnimtion:TweenMovex(arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	self:DelayCall(arg_29_5, function()
		local var_30_0 = LeanTween.moveX(arg_29_1, arg_29_2, arg_29_4 * self.timeScale):setFrom(arg_29_3)

		if arg_29_6 then
			var_30_0:setLoopPingPong(arg_29_6)
		end

		if arg_29_7 then
			var_30_0:setOnComplete(System.Action(arg_29_7))
		end

		table.insert(self.tweens, arg_29_1)

		return
	end)

	return
end

function StoryAnimtion:TweenMovey(arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6, arg_31_7)
	self:DelayCall(arg_31_5, function()
		local var_32_0 = LeanTween.moveY(arg_31_1, arg_31_2, arg_31_4 * self.timeScale):setFrom(arg_31_3)

		if arg_31_6 then
			var_32_0:setLoopPingPong(arg_31_6)
		end

		if arg_31_7 then
			var_32_0:setOnComplete(System.Action(arg_31_7))
		end

		table.insert(self.tweens, arg_31_1)

		return
	end)

	return
end

function StoryAnimtion:IsTweening(arg_33_1)
	return LeanTween.isTweening(arg_33_1)
end

function StoryAnimtion:CancelTween(arg_34_1)
	if self:IsTweening(arg_34_1) then
		LeanTween.cancel(arg_34_1)
	end

	return
end

function StoryAnimtion:DelayCall(arg_35_1, arg_35_2)
	if not arg_35_1 or arg_35_1 <= 0 then
		arg_35_2()

		return
	end

	self.timers[arg_35_2] = StoryTimer.New(function()
		self.timers[arg_35_2]:Stop()

		self.timers[arg_35_2] = nil

		arg_35_2()

		return
	end, arg_35_1 * self.timeScale, 1)

	self.timers[arg_35_2]:Start()

	return
end

function StoryAnimtion:UnscaleDelayCall(arg_37_1, arg_37_2)
	if arg_37_1 <= 0 then
		arg_37_2()

		return
	end

	self.timers[arg_37_2] = StoryTimer.New(function()
		self.timers[arg_37_2]:Stop()

		self.timers[arg_37_2] = nil

		arg_37_2()

		return
	end, arg_37_1, 1)

	self.timers[arg_37_2]:Start()

	return
end

function StoryAnimtion:CreateDelayTimer(arg_39_1, arg_39_2)
	if arg_39_1 == 0 then
		arg_39_2()

		return nil
	end

	local var_39_0 = StoryTimer.New(arg_39_2, arg_39_1 * self.timeScale, 1)

	var_39_0:Start()

	return var_39_0
end

function StoryAnimtion:PauseAllTween()
	for iter_40_0, iter_40_1 in ipairs(self.tweens) do
		if not IsNil(iter_40_1) and self:IsTweening(iter_40_1.gameObject) then
			LeanTween.pause(iter_40_1.gameObject)
		end
	end

	return
end

function StoryAnimtion:ResumeAllTween()
	for iter_41_0, iter_41_1 in ipairs(self.tweens) do
		if not IsNil(iter_41_1) then
			LeanTween.resume(iter_41_1.gameObject)
		end
	end

	return
end

function StoryAnimtion:PauseAllTimer()
	for iter_42_0, iter_42_1 in pairs(self.timers) do
		iter_42_1:Pause()
	end

	return
end

function StoryAnimtion:ResumeAllTimer()
	for iter_43_0, iter_43_1 in pairs(self.timers) do
		iter_43_1:Resume()
	end

	return
end

function StoryAnimtion:ResumeAllAnimation()
	self:ResumeAllTween()
	self:ResumeAllTimer()

	return
end

function StoryAnimtion:PauseAllAnimation()
	self:PauseAllTween()
	self:PauseAllTimer()

	return
end

function StoryAnimtion:ClearAllTween()
	for iter_46_0, iter_46_1 in ipairs(self.tweens) do
		if not IsNil(iter_46_1) and self:IsTweening(iter_46_1.gameObject) then
			LeanTween.cancel(iter_46_1.gameObject)
		end
	end

	self.tweens = {}

	return
end

function StoryAnimtion:ClearAllTimers()
	for iter_47_0, iter_47_1 in pairs(self.timers) do
		iter_47_1:Stop()
	end

	self.timers = {}

	return
end

function StoryAnimtion:ClearTimer(arg_48_1)
	if arg_48_1 and self.timers[arg_48_1] then
		self.timers[arg_48_1]:Stop()

		self.timers[arg_48_1] = nil
	end

	return
end

function StoryAnimtion:ClearAnimation()
	self:ClearAllTween()
	self:ClearAllTimers()

	return
end

return StoryAnimtion
