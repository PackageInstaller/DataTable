class = var_0_10000

local var_0_0 = "CourtYardVariedInteraction"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardInteraction"))

function var_0_1.InitData(arg_1_0)
	var_0_1.super.InitData(arg_1_0)

	arg_1_0.total = 1

	return
end

function var_0_1.GetInterActionUserCnt(arg_2_0)
	local var_2_0 = arg_2_0.host
	local var_2_1 = var_1.GetOwner(var_2_0)

	isa = var_2_0

	local var_2_2 = var_2_1

	CourtYardFurniture = var_1_10004

	if var_2_0(var_2_2, var_1_10004) then
		return #var_2_1:GetUsingSlots()
	else
		return 1
	end

	return
end

function var_0_1.GetUserAction(arg_3_0)
	local var_3_0 = arg_3_0:GetInterActionUserCnt()

	return arg_3_0.userActions[var_3_0]
end

function var_0_1.GetOwnerAction(arg_4_0)
	local var_4_0 = arg_4_0:GetInterActionUserCnt()

	return arg_4_0.ownerActions[var_4_0]
end

function var_0_1.Reset(arg_5_0)
	arg_5_0.index = 0

	arg_5_0:Update(arg_5_0.loop)

	return
end

function var_0_1.OnStepEnd(arg_6_0)
	if arg_6_0:IsCompleteOwnerStep() then
		arg_6_0:DoStep()
	end

	return
end

return var_0_1
