class = var_0_10000

local var_0_0 = "CourtYardRandomControllerFurniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardFurniture"))

function var_0_1.InitSlots(arg_1_0)
	table = var_1_10001

	local var_1_0 = var_1_10001.insert
	local var_1_1 = arg_1_0.slots

	CourtYardRandomControllerSlot = var_1_10003

	var_1_0(var_1_1, var_1_10003.New(1, arg_1_0.config.spine))

	type = var_1_0

	if var_1_0(arg_1_0.config.animator) == "table" then
		local var_1_2 = arg_1_0.slots[1]

		var_1.SetAnimators(var_1_2, arg_1_0.config.animator)
	end

	return
end

return var_0_1
