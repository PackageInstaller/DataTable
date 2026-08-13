class = var_0_10000

local var_0_0 = "IslandBtAssetPoolSet"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandObjectPoolSet"))

function var_0_1.CreatePool(arg_1_0, arg_1_1, arg_1_2)
	IslandBtAssetPool = var_1_10003

	return var_1_10003.New(arg_1_0.root, arg_1_1, arg_1_2, arg_1_0.poolCapacity)
end

return var_0_1
