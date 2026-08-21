local var_0_0 = class("SummaryPageLoading", import(".SummaryPage"))
local var_0_1 = 0.05

function var_0_0.OnInit(arg_1_0)
	arg_1_0.textContainer = findTF(arg_1_0._go, "texts")
	arg_1_0.textTFs = {}

	eachChild(arg_1_0.textContainer, function(arg_2_0)
		setActive(arg_2_0, false)
		table.insert(arg_1_0.textTFs, 1, arg_2_0)

		return
	end)

	arg_1_0.timers = {}

	setActive(arg_1_0._go, false)

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	arg_3_0.inAniming = true

	setActive(arg_3_0._tf, true)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.textTFs) do
		table.insert({}, function(arg_4_0)
			arg_3_0.timers[iter_3_0] = Timer.New(function()
				if arg_3_0.timers[iter_3_0] then
					arg_3_0.timers[iter_3_0]:Stop()

					arg_3_0.timers[iter_3_0] = nil
				end

				setActive(iter_3_1, true)
				iter_3_1:GetComponent(typeof(Typewriter)):setSpeed(0.015)
				arg_4_0()

				return
			end, var_0_1 * iter_3_0, 1)

			arg_3_0.timers[iter_3_0]:Start()

			return
		end)
	end

	table.insert({}, function(arg_6_0)
		local var_6_0 = arg_3_0.textContainer:GetComponent(typeof(CanvasGroup))

		LeanTween.value(go(arg_3_0.textContainer), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_7_0)
			var_6_0.alpha = arg_7_0

			return
		end)):setOnComplete(System.Action(arg_6_0)):setDelay(0.6)

		return
	end)
	seriesAsync({}, function()
		arg_3_0.inAniming = nil

		arg_3_1()

		return
	end)

	return
end

function var_0_0.Hide(arg_9_0, arg_9_1)
	arg_9_0:Clear()
	setActive(arg_9_0._tf, false)
	arg_9_1()

	return
end

function var_0_0.inAnim(arg_10_0)
	return arg_10_0.inAniming
end

function var_0_0.Clear(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.timers) do
		iter_11_1:Stop()
	end

	arg_11_0.timers = {}

	return
end

return var_0_0
