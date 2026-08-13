class = var_0_10000

local var_0_0 = "IslandSlotUnitVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.formula_id = arg_1_1.formula_id
	arg_1_0.slotType = arg_1_1.slotType
	arg_1_0.slotId = arg_1_1.slotId
	arg_1_0.isSelfIsland = arg_1_1.isSelfIsland

	return
end

function var_0_1.SetHighLight(arg_2_0, arg_2_1)
	arg_2_0.isHighLight = arg_2_1

	return
end

function var_0_1.GetHighLight(arg_3_0, arg_3_1)
	return arg_3_0.isHighLight
end

return var_0_1
