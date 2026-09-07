local AgoraPreview = class("AgoraPreview", import("..view.AgoraView"))

function AgoraPreview:OnSceneInited(arg_1_1)
	AgoraPreview.super.OnSceneInited(self, arg_1_1)
	self:Op("EnterEditMode")

	for iter_1_0, iter_1_1 in pairs(self.moulds) do
		self:Op("TrySelectItemById", iter_1_0)
	end

	return
end

function AgoraPreview:CreateDecorationView()
	return AgoraDecorationPreview.New(self)
end

return AgoraPreview
