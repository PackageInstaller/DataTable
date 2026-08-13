class = var_0_10000

local var_0_0 = "CarouselPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryPlayer"))

function var_0_1.OnReset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	setActive = var_1_10004

	var_1_10004(arg_1_0.actorPanel, false)
	arg_1_3()

	return
end

function var_0_1.OnEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:StartAnimtion(arg_2_1, arg_2_3)

	return
end

function var_0_1.StartAnimtion(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.GetBgs(var_3_0)

	assert = var_1_10004

	var_1_10004(var_3_1)

	setActive = var_1_10004

	var_1_10004(arg_3_0.bgPanel, true)

	local var_3_2 = {}

	ipairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_1) do
		local var_3_3 = iter_3_1[1]
		local var_3_4 = iter_3_1[2]

		table = var_1_10012

		var_1_10012.insert(var_3_2, function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.ReplaceBg(var_4_0, var_3_3, var_3_4, arg_4_0)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_3_2, arg_3_2)

	return
end

function var_0_1.RegisetEvent(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.RegisetEvent(arg_5_0, arg_5_1, arg_5_2)

	triggerButton = var_3

	var_3(arg_5_0._go)

	return
end

function var_0_1.ReplaceBg(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.bgImage.sprite = arg_6_0:GetBg(arg_6_1)

	arg_6_0:DelayCall(arg_6_2, arg_6_3)

	return
end

return var_0_1
