class = var_0_10000

local var_0_0 = "SummaryPageLoading"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SummaryPage"))
local var_0_2 = 0.05

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001
	arg_1_0.textContainer = var_1_10001(arg_1_0._go, "texts")
	arg_1_0.textTFs = {}
	eachChild = var_1

	var_1(arg_1_0.textContainer, function(arg_2_0)
		setActive = var_2_10001

		var_2_10001(arg_2_0, false)

		table = var_2_10001

		var_2_10001.insert(arg_1_0.textTFs, 1, arg_2_0)

		return
	end)

	arg_1_0.timers = {}
	setActive = var_1

	var_1(arg_1_0._go, false)

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	arg_3_0.inAniming = true
	setActive = var_2

	var_2(arg_3_0._tf, true)

	local var_3_0 = {}

	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(arg_3_0.textTFs) do
		table = var_1_10008

		var_1_10008.insert(var_3_0, function(arg_4_0)
			local var_4_0 = arg_3_0.timers
			local var_4_1 = iter_3_0

			Timer = var_2_10003
			var_4_0[var_4_1] = var_2_10003.New(function()
				local var_5_1

				if arg_3_0.timers[iter_3_0] then
					local var_5_0 = arg_3_0.timers[iter_3_0]

					var_5_1.Stop(var_5_0)

					var_5_1 = arg_3_0.timers
					var_5_1[iter_3_0] = nil
				end

				setActive = var_5_1

				var_5_1(iter_3_1, true)

				local var_5_2 = iter_3_1
				local var_5_3 = var_0.GetComponent

				typeof = var_2
				Typewriter = var_3_10003

				local var_5_4 = var_5_3(var_5_2, var_2(var_3_10003))

				var_0.setSpeed(var_5_4, 0.015)
				arg_4_0()

				return
			end, var_0_2 * iter_3_0, 1)

			local var_4_2 = arg_3_0.timers[iter_3_0]

			var_1.Start(var_4_2)

			return
		end)
	end

	table = var_3

	var_3.insert(var_3_0, function(arg_6_0)
		local var_6_0 = arg_3_0.textContainer
		local var_6_1 = var_1.GetComponent

		typeof = var_2_10003
		CanvasGroup = var_2_10004

		local var_6_2 = var_6_1(var_6_0, var_2_10003(var_2_10004))

		LeanTween = var_6_0

		local var_6_3 = var_6_0.value

		go = var_3

		local var_6_4 = var_6_3(var_3(arg_3_0.textContainer), 1, 0, 0.5)
		local var_6_5 = var_2.setOnUpdate

		System = var_4

		local var_6_6 = var_6_5(var_6_4, var_4.Action_float(function(arg_7_0)
			var_6_2.alpha = arg_7_0

			return
		end))
		local var_6_7 = var_2.setOnComplete

		System = var_4

		local var_6_8 = var_6_7(var_6_6, var_4.Action(arg_6_0))

		var_2.setDelay(var_6_8, 0.6)

		return
	end)

	seriesAsync = var_3

	var_3(var_3_0, function()
		arg_3_0.inAniming = nil

		arg_3_1()

		return
	end)

	return
end

function var_0_1.Hide(arg_9_0, arg_9_1)
	arg_9_0:Clear()

	setActive = var_2

	var_2(arg_9_0._tf, false)
	arg_9_1()

	return
end

function var_0_1.inAnim(arg_10_0)
	return arg_10_0.inAniming
end

function var_0_1.Clear(arg_11_0)
	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.timers) do
		iter_11_1:Stop()
	end

	arg_11_0.timers = {}

	return
end

return var_0_1
