local var_0_0 = {}

var_0_0.URL = "ui://xigti88c8prx3e"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_serverIdTxt = self:getChild("serverIdTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_userNameTxt = self:getChild("userNameTxt")
	self.m_serverIconComp = self:getChild("serverIconComp")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 3,
	page2 = 2
}

return var_0_0
