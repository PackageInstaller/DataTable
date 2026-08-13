class = var_0_10000

local var_0_0 = "IslandPublicAssetPoolSet"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandObjectPoolSet"))

function var_0_1.CreatePool(arg_1_0, arg_1_1, arg_1_2)
	IslandPublicAssetPool = var_1_10003

	return var_1_10003.New(arg_1_0.root, arg_1_1, arg_1_2, arg_1_0.poolCapacity)
end

function var_0_1.ReturnObject(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0:RawGetPool(arg_2_1) then
		return
	end

	var_3:Enqueue(arg_2_2)

	return
end

return var_0_1
