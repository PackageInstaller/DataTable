local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrns"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_hpBar = self:getChild("hpBar")
	self.m_effIcon = self:getChild("effIcon")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
