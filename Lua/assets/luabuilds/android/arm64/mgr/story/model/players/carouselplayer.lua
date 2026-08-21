local var_0_0 = class("CarouselPlayer", import(".StoryPlayer"))

function var_0_0.OnReset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	setActive(arg_1_0.actorPanel, false)
	arg_1_3()

	return
end

function var_0_0.OnEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:StartAnimtion(arg_2_1, arg_2_3)

	return
end

function var_0_0.StartAnimtion(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetBgs()

	assert(var_3_0)
	setActive(arg_3_0.bgPanel, true)

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = iter_3_1[1]
		local var_3_2 = iter_3_1[2]

		table.insert({}, function(arg_4_0)
			arg_3_0:ReplaceBg(var_3_1, var_3_2, arg_4_0)

			return
		end)
	end

	seriesAsync({}, arg_3_2)

	return
end

function var_0_0.RegisetEvent(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.RegisetEvent(arg_5_0, arg_5_1, arg_5_2)
	triggerButton(arg_5_0._go)

	return
end

function var_0_0.ReplaceBg(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.bgImage.sprite = arg_6_0:GetBg(arg_6_1)

	arg_6_0:DelayCall(arg_6_2, arg_6_3)

	return
end

return var_0_0
