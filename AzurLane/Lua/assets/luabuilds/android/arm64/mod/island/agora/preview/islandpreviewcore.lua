local var_0_0 = class("IslandPreviewCore", import("Mod.Island.Core.IslandCore"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.furnitrueId = arg_1_4
	arg_1_0.lastExitPosition = arg_1_5

	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_0.GetViewAndController(arg_2_0, arg_2_1)
	local var_2_0 = AgoraPreviewController.New(arg_2_0, arg_2_1, arg_2_0.furnitrueId, arg_2_0.lastExitPosition)

	return AgoraPreview.New(arg_2_0, (var_2_0:GetAgora())), var_2_0
end

return var_0_0
