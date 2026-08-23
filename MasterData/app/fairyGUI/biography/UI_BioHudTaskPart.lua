local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794frp6ibpw"

function var_0_0:__ctor()
	self.m_switchController = self:getController("switch")
	self.m_autoController = self:getController("auto")
	self.m_openBtn = self:getChild("openBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_mainBgIcon = self:getChild("mainBgIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_autoMainBtn = self:getChild("autoMainBtn")
	self.m_taskSubBtn = self:getChild("taskSubBtn")
	self.m_subBgIcon = self:getChild("subBgIcon")
	self.m_nameSubTxt = self:getChild("nameSubTxt")
	self.m_descSubTxt = self:getChild("descSubTxt")
	self.m_autoSubBtn = self:getChild("autoSubBtn")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

return var_0_0
