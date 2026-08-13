class = var_0_10000

local var_0_0 = "CourtYardTransportSlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardFurnitureBaseSlot"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1[1][1]
	arg_1_0.defaultAction = arg_1_1[1][2]
	arg_1_0.actions = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1[2]) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.actions, {
			userAction = iter_1_1[1],
			ownerAction = iter_1_1[2],
			time = iter_1_1[3]
		})
	end

	arg_1_0.animators = {}

	return
end

function var_0_1.SetAnimators(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.animators, {
			key = arg_2_0.id .. "_" .. iter_2_0,
			value = iter_2_1
		})
	end

	return
end

function var_0_1.GetSpineDefaultAction(arg_3_0)
	return arg_3_0.defaultAction
end

function var_0_1.OnAwake(arg_4_0)
	arg_4_0.animatorIndex = arg_4_0.index

	return
end

function var_0_1.OnStart(arg_5_0)
	local var_5_0 = arg_5_0.actions[arg_5_0.index]
	local var_5_1 = arg_5_0.user

	var_2.UpdateInteraction(var_5_1, {
		action = var_5_0.userAction,
		slot = arg_5_0
	})

	local var_5_2 = arg_5_0.owner

	var_2.UpdateInteraction(var_5_2, {
		action = var_5_0.ownerAction,
		slot = arg_5_0
	})

	Timer = var_2

	local var_5_3 = var_2.New(function()
		local var_6_0 = arg_5_0

		var_0.End(var_6_0)

		return
	end, var_5_0.time, 1)

	var_2.Start(var_5_3)

	return
end

function var_0_1.Occupy(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.index = 1

	var_0_1.super.Occupy(arg_7_0, arg_7_1, arg_7_2, arg_7_3)

	return
end

function var_0_1.Link(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.index = 2

	var_0_1.super.Occupy(arg_8_0, arg_8_1, arg_8_2, arg_8_3)

	return
end

function var_0_1.IsFirstTime(arg_9_0)
	return arg_9_0.index == 1
end

return var_0_1
