class = var_0_10000

local var_0_0 = "WSMapEffect"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WSMapTransform"))

var_0_1.Fields = {
	resPath = "string",
	resName = "string"
}

function var_0_1.Dispose(arg_1_0)
	arg_1_0:Unload()
	var_0_1.super.Dispose(arg_1_0)

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.resPath = arg_2_1
	arg_2_0.resName = arg_2_2

	return
end

function var_0_1.Load(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.LoadModel

	WorldConst = var_1_10005

	var_3_1(var_3_0, var_1_10005.ModelPrefab, arg_3_0.resPath, arg_3_0.resName, true, function()
		setParent = var_2_10000

		var_2_10000(arg_3_0.model, arg_3_0.transform, false)

		existCall = var_2_10000

		return var_2_10000(arg_3_1)
	end)

	return
end

function var_0_1.Unload(arg_5_0)
	arg_5_0:UnloadModel()

	return
end

return var_0_1
