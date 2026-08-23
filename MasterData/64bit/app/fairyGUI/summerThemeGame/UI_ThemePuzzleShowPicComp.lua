local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6jm5ekk3op"

function var_0_0:__ctor()
	self.m_show_picController = self:getController("show_pic")
	self.m_show_frameController = self:getController("show_frame")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_showPicLoader = self:getChild("showPicLoader")
end

var_0_0.Show_picCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Show_frameCtrl = {
	page0 = 1,
	page1 = 0
}

return var_0_0
