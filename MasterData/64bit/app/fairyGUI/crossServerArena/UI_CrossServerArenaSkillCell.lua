local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagknq94n"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_skillIconBg = self:getChild("skillIconBg")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_progBar = self:getChild("progBar")
	self.m_descTxt = self:getChild("descTxt")
	self.m_stateChangeBtn = self:getChild("stateChangeBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_subAddComp = self:getChild("subAddComp")
	self.m_levelUpBtn = self:getChild("levelUpBtn")
	self.m_touchComp = self:getChild("touchComp")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
