local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ou8jrrriy"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_txt_title = self:getChild("txt_title")
	self.m_txt_des = self:getChild("txt_des")
end

var_0_0.StatusCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
