class = var_0_10000

local var_0_0 = "CourtYardRandomControllerSlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardFurnitureBaseSlot"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1[1][1]
	arg_1_0.defaultAction = arg_1_1[1][2]

	local var_1_0

	if arg_1_1[2] then
		var_1_0 = arg_1_1[2][1]
	end

	arg_1_0.mask = var_1_0

	if arg_1_0.mask then
		arg_1_0.maskDefaultAction = arg_1_1[2][2]
	end

	arg_1_0.actions = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1[3][2]) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.actions, {
			userAction = iter_1_1[3],
			controller = iter_1_1[2],
			ownerAction = iter_1_1[1]
		})
	end

	return
end

function var_0_1.SetAnimators(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1[1]) do
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

function var_0_1.GetSpineMaskDefaultAcation(arg_4_0)
	return arg_4_0.maskDefaultAction
end

function var_0_1.OnAwake(arg_5_0)
	local var_5_0 = arg_5_0.actions

	math = var_1_10002

	local var_5_1 = var_5_0[var_1_10002.random(1, #arg_5_0.actions)]

	arg_5_0.animatorIndex = 0
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0.animators) do
		if iter_5_1.value == var_5_1.controller then
			arg_5_0.animatorIndex = iter_5_0
		end
	end

	arg_5_0.actionData = var_5_1

	return
end

function var_0_1.OnStart(arg_6_0)
	local var_6_0 = arg_6_0.actionData
	local var_6_1 = arg_6_0.user

	var_2.UpdateInteraction(var_6_1, {
		action = var_6_0.userAction,
		slot = arg_6_0
	})

	local var_6_2 = arg_6_0.owner

	var_2.UpdateInteraction(var_6_2, {
		action = var_6_0.ownerAction,
		slot = arg_6_0
	})

	return
end

function var_0_1.OnContinue(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.owner then
		arg_7_0:End()
	end

	return
end

function var_0_1.Clear(arg_8_0, arg_8_1)
	var_0_1.super.Clear(arg_8_0, arg_8_1)

	arg_8_0.actionData = nil

	return
end

return var_0_1
