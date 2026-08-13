class = var_0_10000

local var_0_0 = var_0_10000("CommanderCatPlayAnimation")
local var_0_1 = 0.3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.expSlider = arg_1_1

	return
end

function var_0_0.Action(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2.level - arg_2_1.level > 0 then
		arg_2_0:DoLevelOffsetAnimation(arg_2_1, arg_2_2, arg_2_3)
	else
		arg_2_0:DoSameLevelAnimation(arg_2_1, arg_2_2, arg_2_3)
	end

	return
end

function var_0_0.DoLevelOffsetAnimation(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_2.level - arg_3_1.level
	local var_3_1 = {}

	table = var_1_10006

	var_1_10006.insert(var_3_1, function(arg_4_0)
		local var_4_0 = arg_3_1
		local var_4_1 = var_1.getNextLevelExp(var_4_0)

		TweenValue = var_4_0
		go = var_2_10003

		var_4_0(var_2_10003(arg_3_0.expSlider), arg_3_1.exp, var_4_1, var_0_1, 0, function(arg_5_0)
			arg_3_0.expSlider.value = arg_5_0

			return
		end, arg_4_0)

		return
	end)

	for iter_3_0 = 1, var_3_0 - 1 do
		table = var_1_10010

		var_1_10010.insert(var_3_1, function(arg_6_0)
			TweenValue = var_2_10001
			go = var_2_10002

			var_2_10001(var_2_10002(arg_3_0.expSlider), 0, 1, var_0_1, 0, function(arg_7_0)
				arg_3_0.expSlider.value = arg_7_0

				return
			end, arg_6_0)

			return
		end)
	end

	table = var_6

	var_6.insert(var_3_1, function(arg_8_0)
		local var_8_0 = arg_3_2
		local var_8_1 = var_1.getNextLevelExp(var_8_0)

		TweenValue = var_8_0
		go = var_2_10003

		var_8_0(var_2_10003(arg_3_0.expSlider), 0, arg_3_2.exp, var_0_1, 0, function(arg_9_0)
			arg_3_0.expSlider.value = arg_9_0 / var_8_1

			return
		end, arg_8_0)

		return
	end)

	seriesAsync = var_6

	var_6(var_3_1, arg_3_3)

	return
end

function var_0_0.DoSameLevelAnimation(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.getNextLevelExp(var_10_0)

	TweenValue = var_10_0
	go = var_1_10006

	var_10_0(var_1_10006(arg_10_0.expSlider), arg_10_1.exp, arg_10_2.exp, var_0_1, 0, function(arg_11_0)
		arg_10_0.expSlider.value = arg_11_0 / var_10_1

		return
	end, arg_10_3)

	return
end

function var_0_0.Dispose(arg_12_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_12_0.expSlider.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_12_0.expSlider.gameObject)
	end

	return
end

return var_0_0
