local var_0_0 = class("IslandDelayRecycleUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.delayRecycleTime = arg_1_1.delayRecycleTime
	arg_1_0.recycleAssetType = arg_1_1.recycleAssetType

	return
end

return var_0_0
