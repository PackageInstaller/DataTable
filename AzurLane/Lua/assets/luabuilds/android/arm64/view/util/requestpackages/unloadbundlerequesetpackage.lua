class = var_0_10000

local var_0_0 = "UnloadBundleRequesetPackage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".RequestPackage"))

function var_0_1.__call(arg_1_0)
	if arg_1_0.stopped then
		return
	end

	AssetBundleHelper = var_1

	var_1.UnstoreAssetBundle(arg_1_0.path, true)

	return arg_1_0
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.path = arg_2_1

	return
end

return var_0_1
