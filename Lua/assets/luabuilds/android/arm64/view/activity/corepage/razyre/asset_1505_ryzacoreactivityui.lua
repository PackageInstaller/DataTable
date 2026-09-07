local RyzaCoreActivityUI = class("RyzaCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function RyzaCoreActivityUI:getUIName()
	return "RyzaCoreActivityUI"
end

function RyzaCoreActivityUI:init(...)
	RyzaCoreActivityUI.super.init(self, ...)

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_3_0, arg_3_1)
		self:UpdateAdapt()

		return
	end)

	self:UpdateAdapt()

	return
end

function RyzaCoreActivityUI:didEnter()
	RyzaCoreActivityUI.super.didEnter(self)

	return
end

function RyzaCoreActivityUI:UpdateAdapt()
	local var_5_0 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_5_0.currentWidth / var_5_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	return
end

function RyzaCoreActivityUI:willExit()
	RyzaCoreActivityUI.super.willExit(self)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return RyzaCoreActivityUI
