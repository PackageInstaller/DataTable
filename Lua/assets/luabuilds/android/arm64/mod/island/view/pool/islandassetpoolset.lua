local var_0_0 = class("IslandAssetPoolSet", import(".IslandObjectPoolSet"))

function var_0_0.CreatePool(arg_1_0, arg_1_1, arg_1_2)
	return IslandAssetPool.New(arg_1_0.root, arg_1_1, arg_1_2, arg_1_0.poolCapacity)
end

return var_0_0
