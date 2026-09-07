local CourtYardStoreyPreviewModule = class("CourtYardStoreyPreviewModule", import(".CourtYardStoreyModule"))

function CourtYardStoreyPreviewModule:Ctor(arg_1_1, arg_1_2)
	CourtYardStoreyPreviewModule.super.Ctor(self, arg_1_1, arg_1_2)
	self.bgmAgent:Clear()

	return
end

function CourtYardStoreyPreviewModule:EnableZoom(arg_2_1)
	self.zoomAgent.enabled = false

	return
end

return CourtYardStoreyPreviewModule
