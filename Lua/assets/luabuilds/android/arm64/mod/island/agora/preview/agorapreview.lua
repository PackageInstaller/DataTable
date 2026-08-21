local var_0_0 = class("AgoraPreview", import("..view.AgoraView"))

function var_0_0.OnSceneInited(arg_1_0, arg_1_1)
	var_0_0.super.OnSceneInited(arg_1_0, arg_1_1)
	arg_1_0:Op("EnterEditMode")

	for iter_1_0, iter_1_1 in pairs(arg_1_0.moulds) do
		arg_1_0:Op("TrySelectItemById", iter_1_0)
	end

	return
end

function var_0_0.CreateDecorationView(arg_2_0)
	return AgoraDecorationPreview.New(arg_2_0)
end

return var_0_0
