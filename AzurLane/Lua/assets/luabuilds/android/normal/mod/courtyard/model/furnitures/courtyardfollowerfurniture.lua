class = var_0_10000

local var_0_0 = "CourtYardFollowerFurniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardFurniture"))

function var_0_1.InitSlots(arg_1_0)
	arg_1_0.ratios = {}
	table = var_1

	local var_1_0 = var_1.insert
	local var_1_1 = arg_1_0.slots

	CourtYardFollowerSlot = var_1_10003

	var_1_0(var_1_1, var_1_10003.New(1, arg_1_0.config.spine, arg_1_0.config.spine_combine_action_replace, arg_1_0.host))

	return
end

function var_0_1.GetInterActionTime(arg_2_0)
	math = var_1_10001

	return var_1_10001.random(5, 10)
end

function var_0_1.GetRatio(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_0.ratios[arg_3_1] then
		var_3_0 = 0
	end

	return var_3_0
end

function var_0_1.IncreaseRatio(arg_4_0, arg_4_1)
	arg_4_0.ratios[arg_4_1] = 100

	return
end

function var_0_1.ReduceRatio(arg_5_0, arg_5_1)
	arg_5_0.ratios[arg_5_1] = arg_5_0:GetRatio(arg_5_1) - 20

	return
end

function var_0_1.CanFollower(arg_6_0, arg_6_1)
	if arg_6_0:IsUsing() then
		return false
	end

	if not (arg_6_0:GetRatio(arg_6_1) <= 0) then
		arg_6_0:ReduceRatio(arg_6_1)
	end

	return var_2
end

function var_0_1.IsUsing(arg_7_0)
	local var_7_0 = arg_7_0.slots[1]

	return var_1.IsUsing(var_7_0)
end

function var_0_1.StartInteraction(arg_8_0, arg_8_1)
	var_0_1.super.StartInteraction(arg_8_0, arg_8_1)

	local var_8_0 = arg_8_1:GetOwner()

	arg_8_0:IncreaseRatio(var_8_0)

	return
end

function var_0_1.GetOwner(arg_9_0)
	if arg_9_0:IsUsing() then
		local var_9_0 = arg_9_0.slots[1]

		return var_1.GetOwner(var_9_0)
	end

	return
end

function var_0_1.Stop(arg_10_0)
	local var_10_0 = arg_10_0.slots[1]

	var_1.Stop(var_10_0)

	return
end

function var_0_1.SetPosition(arg_11_0, arg_11_1)
	var_0_1.super.SetPosition(arg_11_0, arg_11_1)

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.DispatchEvent

	CourtYardEvent = var_4

	var_11_1(var_11_0, var_4.ROTATE_FURNITURE, arg_11_0.dir)

	return
end

return var_0_1
