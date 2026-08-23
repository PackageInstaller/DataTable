local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnr"

function var_0_0:__ctor()
	self.m_iconController = self:getController("icon")
	self.m_effCellbg = self:getChild("effCellbg")
	self.m_talentIcon = self:getChild("talentIcon")
	self.m_descText = self:getChild("descText")
	self.m_pointIcon = self:getChild("pointIcon")
	self.m_pointText = self:getChild("pointText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IconCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
