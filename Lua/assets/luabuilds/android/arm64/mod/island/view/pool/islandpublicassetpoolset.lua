local var_0_0 = class("IslandPublicAssetPoolSet", import(".IslandObjectPoolSet"))

function var_0_0.CreatePool(arg_1_0, arg_1_1, arg_1_2)
	return IslandPublicAssetPool.New(arg_1_0.root, arg_1_1, arg_1_2, arg_1_0.poolCapacity)
end

function var_0_0.ReturnObject(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:RawGetPool(arg_2_1)

	if not var_2_0 then
		return
	end

	var_2_0:Enqueue(arg_2_2)

	return
end

return var_0_0
