local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6b7v2kk3pt"

function var_0_0:__ctor()
	self.m_sizeController = self:getController("size")
	self.m_frameController = self:getController("frame")
	self.m_frame_2 = self:getChild("frame")
end

var_0_0.SizeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.FrameCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
