class = var_0_10000

local var_0_0 = "CourtYardTransportFurniture"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardFurniture"))

function var_0_1.InitSlots(arg_1_0)
	table = var_1_10001

	local var_1_0 = var_1_10001.insert
	local var_1_1 = arg_1_0.slots

	CourtYardTransportSlot = var_1_10004

	var_1_0(var_1_1, var_1_10004.New(1, arg_1_0.config.spine))

	type = var_1_0

	if var_1_0(arg_1_0.config.animator) == "table" then
		local var_1_2 = arg_1_0.slots[1]

		var_1.SetAnimators(var_1_2, arg_1_0.config.animator)
	end

	return
end

function var_0_1.IsUsing(arg_2_0)
	return #arg_2_0:GetUsingSlots() > 0
end

function var_0_1.Stop(arg_3_0)
	local var_3_0 = arg_3_0.slots[1]

	var_1.Stop(var_3_0)

	return
end

return var_0_1
