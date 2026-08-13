class = var_0_10000

local var_0_0 = "CourtYardFollowerSlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardFurnitureBaseSlot"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.name = arg_1_1[1][1]
	arg_1_0.defaultAction = arg_1_1[1][2]
	Vector3 = var_2
	arg_1_0.skewValue = var_2(arg_1_1[3][1][1], arg_1_1[3][1][2])
	arg_1_0.aciton = arg_1_1[3][2]

	return
end

function var_0_1.OnInitCombine(arg_2_0, arg_2_1)
	arg_2_0.combineData = arg_2_1

	return
end

function var_0_1.GetSpineDefaultAction(arg_3_0)
	if arg_3_0:GetCombineFurnitureAnimator() then
		local var_3_0

		if not var_1[2] then
			var_3_0 = arg_3_0.defaultAction
		end

		return var_3_0
	end

	return arg_3_0.defaultAction
end

function var_0_1.Occupy(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0:IsEmpty() then
		arg_4_0.owner = arg_4_2
		arg_4_0.user = arg_4_1
		arg_4_0.observer = arg_4_3

		arg_4_0:Use()
		arg_4_0:OnAwake()
		arg_4_3:StartInteraction(arg_4_0)
		arg_4_1:StartInteraction(arg_4_0)
		arg_4_2:StartInteraction(arg_4_0, true)
		arg_4_0:OnStart()
	end

	return
end

function var_0_1.OnAwake(arg_5_0)
	arg_5_0:ClearTimer()

	return
end

function var_0_1.Clear(arg_6_0, arg_6_1)
	if arg_6_0:IsUsing() then
		arg_6_0:Empty()

		local var_6_0 = arg_6_0.observer

		var_2.WillClearInteraction(var_6_0, arg_6_0, arg_6_1)

		local var_6_1 = arg_6_0.user

		var_2.ClearInteraction(var_6_1, arg_6_0, arg_6_1)

		local var_6_2 = arg_6_0.owner

		var_2.ClearInteraction(var_6_2, arg_6_0, arg_6_1, true)

		local var_6_3 = arg_6_0.observer

		var_2.ClearInteraction(var_6_3, arg_6_0, arg_6_1)

		arg_6_0.user = nil
		arg_6_0.owner = nil
		arg_6_0.observer = nil
	end

	return
end

function var_0_1.OnStart(arg_7_0)
	local var_7_0 = arg_7_0:GetCombineFurnitureAnimator()
	local var_7_1 = arg_7_0.aciton

	var_7_1 = var_7_0 and var_7_0[3] or var_7_1

	local var_7_2 = arg_7_0.user

	var_3.UpdateInteraction(var_7_2, {
		action = var_7_1,
		slot = arg_7_0
	})

	return
end

function var_0_1.ClearTimer(arg_8_0)
	return
end

function var_0_1.OnStop(arg_9_0)
	arg_9_0:ClearTimer()

	return
end

function var_0_1.OnEnd(arg_10_0)
	arg_10_0:ClearTimer()

	return
end

function var_0_1.GetBodyMask(arg_11_0)
	return false
end

function var_0_1.GetUsingAnimator(arg_12_0)
	return false
end

function var_0_1.GetFollower(arg_13_0)
	return nil
end

return var_0_1
