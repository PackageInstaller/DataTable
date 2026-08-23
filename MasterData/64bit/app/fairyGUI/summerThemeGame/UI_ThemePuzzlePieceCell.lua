local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6jm5ekk3or"

function var_0_0:__ctor()
	self.m_sizeController = self:getController("size")
	self.m_frameController = self:getController("frame")
	self.m_frame_2 = self:getChild("frame")
	self.m_effectComp = self:getChild("effectComp")
	self.m_shakeTransition = self:getTransition("shake")
end

var_0_0.SizeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.FrameCtrl = {
	page1 = 0,
	page0 = 1
}

return var_0_0
