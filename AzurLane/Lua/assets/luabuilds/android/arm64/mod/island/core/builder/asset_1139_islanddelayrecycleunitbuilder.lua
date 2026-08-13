class = var_0_10000

local var_0_0 = "IslandDelayRecycleUnitBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseBuilder"))

var_0_1.RecycleType = {
	NormalSceneItem = 1,
	ProductEffect = 2
}

function var_0_1.GetModule(arg_1_0, arg_1_1, arg_1_2)
	IslandDelayRecycleUnit = var_1_10003

	return var_1_10003.New(arg_1_1, arg_1_2)
end

function var_0_1.Load(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:GetAssetPath()

	if arg_2_1.recycleAssetType == var_0_1.RecycleType.NormalSceneItem then
		local var_2_1 = arg_2_0:GetPoolMgr()

		var_5.GetSceneProductItem(var_2_1, var_2_0, arg_2_2)
	elseif var_4 == var_0_1.RecycleType.ProductEffect then
		local var_2_2 = arg_2_0:GetPoolMgr()

		var_5.GetSceneProductEffect(var_2_2, var_2_0, arg_2_2)
	end

	return
end

function var_0_1.Recycle(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.GetAssetPath(var_3_0)
	local var_3_2 = arg_3_1.recycleAssetType

	IslandDelayRecycleUnitBuilder = var_3_0

	if var_3_2 == var_3_0.RecycleType.NormalSceneItem then
		local var_3_3 = arg_3_0:GetPoolMgr()

		var_5.ReturnSceneProductItem(var_3_3, var_3_1, arg_3_2)
	else
		IslandDelayRecycleUnitBuilder = var_5

		if var_3_2 == var_5.RecycleType.ProductEffect then
			local var_3_4 = arg_3_0:GetPoolMgr()

			var_5.ReturnSceneProductEffect(var_3_4, var_3_1, arg_3_2)
		end
	end

	return
end

return var_0_1
