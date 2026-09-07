local IslandPreviewCore = class("IslandPreviewCore", import("Mod.Island.Core.IslandCore"))

function IslandPreviewCore:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self.furnitrueId = arg_1_4
	self.lastExitPosition = arg_1_5

	IslandPreviewCore.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	return
end

function IslandPreviewCore:GetViewAndController(arg_2_1)
	local var_2_0 = AgoraPreviewController.New(self, arg_2_1, self.furnitrueId, self.lastExitPosition)

	return AgoraPreview.New(self, (var_2_0:GetAgora())), var_2_0
end

return IslandPreviewCore
