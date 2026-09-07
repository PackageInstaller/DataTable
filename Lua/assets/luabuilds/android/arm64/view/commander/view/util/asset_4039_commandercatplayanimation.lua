local CommanderCatPlayAnimation = class("CommanderCatPlayAnimation")
local var_0_1 = 0.3

function CommanderCatPlayAnimation:Ctor(arg_1_1)
	self.expSlider = arg_1_1

	return
end

function CommanderCatPlayAnimation:Action(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2.level - arg_2_1.level > 0 then
		self:DoLevelOffsetAnimation(arg_2_1, arg_2_2, arg_2_3)
	else
		self:DoSameLevelAnimation(arg_2_1, arg_2_2, arg_2_3)
	end

	return
end

function CommanderCatPlayAnimation:DoLevelOffsetAnimation(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	table.insert(var_3_0, function(arg_4_0)
		TweenValue(go(self.expSlider), arg_3_1.exp, arg_3_1:getNextLevelExp(), var_0_1, 0, function(arg_5_0)
			self.expSlider.value = arg_5_0

			return
		end, arg_4_0)

		return
	end)

	for iter_3_0 = 1, arg_3_2.level - arg_3_1.level - 1 do
		table.insert(var_3_0, function(arg_6_0)
			TweenValue(go(self.expSlider), 0, 1, var_0_1, 0, function(arg_7_0)
				self.expSlider.value = arg_7_0

				return
			end, arg_6_0)

			return
		end)
	end

	table.insert(var_3_0, function(arg_8_0)
		local var_8_0 = arg_3_2:getNextLevelExp()

		TweenValue(go(self.expSlider), 0, arg_3_2.exp, var_0_1, 0, function(arg_9_0)
			self.expSlider.value = arg_9_0 / var_8_0

			return
		end, arg_8_0)

		return
	end)
	seriesAsync(var_3_0, arg_3_3)

	return
end

function CommanderCatPlayAnimation:DoSameLevelAnimation(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1:getNextLevelExp()

	TweenValue(go(self.expSlider), arg_10_1.exp, arg_10_2.exp, var_0_1, 0, function(arg_11_0)
		self.expSlider.value = arg_11_0 / var_10_0

		return
	end, arg_10_3)

	return
end

function CommanderCatPlayAnimation:Dispose()
	if LeanTween.isTweening(self.expSlider.gameObject) then
		LeanTween.cancel(self.expSlider.gameObject)
	end

	return
end

return CommanderCatPlayAnimation
