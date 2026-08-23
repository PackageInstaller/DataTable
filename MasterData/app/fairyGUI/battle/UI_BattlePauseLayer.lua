local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2mbs1s"

function var_0_0:__ctor()
	self.m_showController = self:getController("show")
	self.m_settingBtn = self:getChild("settingBtn")
	self.m_quitBtn = self:getChild("quitBtn")
	self.m_goonBtn = self:getChild("goonBtn")
end

var_0_0.ShowCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
