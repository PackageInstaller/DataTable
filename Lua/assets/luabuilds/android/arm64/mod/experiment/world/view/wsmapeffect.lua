local var_0_0 = class("WSMapEffect", import(".WSMapTransform"))

var_0_0.Fields = {
	resPath = "string",
	resName = "string"
}

function var_0_0.Dispose(arg_1_0)
	arg_1_0:Unload()
	var_0_0.super.Dispose(arg_1_0)

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.resPath = arg_2_1
	arg_2_0.resName = arg_2_2

	return
end

function var_0_0.Load(arg_3_0, arg_3_1)
	arg_3_0:LoadModel(WorldConst.ModelPrefab, arg_3_0.resPath, arg_3_0.resName, true, function()
		setParent(arg_3_0.model, arg_3_0.transform, false)

		return existCall(arg_3_1)
	end)

	return
end

function var_0_0.Unload(arg_5_0)
	arg_5_0:UnloadModel()

	return
end

return var_0_0
