class = var_0_10000

local var_0_0 = "AgoraPreview"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..view.AgoraView"))

function var_0_1.OnSceneInited(arg_1_0, arg_1_1)
	var_0_1.super.OnSceneInited(arg_1_0, arg_1_1)
	arg_1_0:Op("EnterEditMode")

	pairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0.moulds) do
		arg_1_0:Op("TrySelectItemById", iter_1_0)
	end

	return
end

function var_0_1.CreateDecorationView(arg_2_0)
	AgoraDecorationPreview = var_1_10001

	return var_1_10001.New(arg_2_0)
end

return var_0_1
