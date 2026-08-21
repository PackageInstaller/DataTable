local var_0_0 = class("CourtYardFollowerFurniture", import(".CourtYardFurniture"))

function var_0_0.InitSlots(arg_1_0)
	arg_1_0.ratios = {}

	table.insert(arg_1_0.slots, CourtYardFollowerSlot.New(1, arg_1_0.config.spine, arg_1_0.config.spine_combine_action_replace, arg_1_0.host))

	return
end

function var_0_0.GetInterActionTime(arg_2_0)
	return math.random(5, 10)
end

function var_0_0.GetRatio(arg_3_0, arg_3_1)
	return arg_3_0.ratios[arg_3_1] or 0
end

function var_0_0.IncreaseRatio(arg_4_0, arg_4_1)
	arg_4_0.ratios[arg_4_1] = 100

	return
end

function var_0_0.ReduceRatio(arg_5_0, arg_5_1)
	arg_5_0.ratios[arg_5_1] = arg_5_0:GetRatio(arg_5_1) - 20

	return
end

function var_0_0.CanFollower(arg_6_0, arg_6_1)
	if arg_6_0:IsUsing() then
		return false
	end

	local var_6_0 = arg_6_0:GetRatio(arg_6_1) <= 0

	if not var_6_0 then
		arg_6_0:ReduceRatio(arg_6_1)
	end

	return var_6_0
end

function var_0_0.IsUsing(arg_7_0)
	return arg_7_0.slots[1]:IsUsing()
end

function var_0_0.StartInteraction(arg_8_0, arg_8_1)
	var_0_0.super.StartInteraction(arg_8_0, arg_8_1)
	arg_8_0:IncreaseRatio((arg_8_1:GetOwner()))

	return
end

function var_0_0.GetOwner(arg_9_0)
	if arg_9_0:IsUsing() then
		return arg_9_0.slots[1]:GetOwner()
	end

	return
end

function var_0_0.Stop(arg_10_0)
	arg_10_0.slots[1]:Stop()

	return
end

function var_0_0.SetPosition(arg_11_0, arg_11_1)
	var_0_0.super.SetPosition(arg_11_0, arg_11_1)
	arg_11_0:DispatchEvent(CourtYardEvent.ROTATE_FURNITURE, arg_11_0.dir)

	return
end

return var_0_0
