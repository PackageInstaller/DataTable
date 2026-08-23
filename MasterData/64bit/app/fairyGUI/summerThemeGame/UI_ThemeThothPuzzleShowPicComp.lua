local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6k6jm1kk46b"

function var_0_0:__ctor()
	self.m_show_picController = self:getController("show_pic")
	self.m_show_frameController = self:getController("show_frame")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_showPicLoader = self:getChild("showPicLoader")
end

var_0_0.Show_picCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Show_frameCtrl = {
	page1 = 0,
	page0 = 1
}

return var_0_0
