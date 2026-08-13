class = var_0_10000

local var_0_0 = "IslandDelayRecycleUnitVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.delayRecycleTime = arg_1_1.delayRecycleTime
	arg_1_0.recycleAssetType = arg_1_1.recycleAssetType

	return
end

return var_0_1
